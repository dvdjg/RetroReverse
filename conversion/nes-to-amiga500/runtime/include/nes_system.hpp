#pragma once

/// \file nes_system.hpp
/// Sistema NES mínimo (2A03 + 2C02 + cartucho) que une CPU, PPU, APU y mapper
/// para **ejecutar una ROM** y producir frames. Es la base de la validación
/// diferencial (comparar contra `mesen`) y de la ejecución del fallback.
///
/// Alcance (F3/F9 en curso): NROM/UxROM/CNROM, PPU con fondo + sprites y APU
/// simplificada. La sincronía CPU↔PPU es aproximada (3 dots por ciclo, VBlank en
/// la línea 241) y no modela el timing exacto ni el sprite-0 en el dot preciso.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"
#include "nes_hle.hpp"
#include "nes_interpreter.hpp"
#include "nes_mapper.hpp"
#include "nes_palette.hpp"
#include "nes_ppu.hpp"
#include "nes_runtime.hpp"

namespace n2a {

/// Consola NES mínima: memoria con hooks hacia PPU/APU/mapper, CPU intérprete y
/// control de NMI por VBlank.
struct NesSystem {
	static constexpr int kScreenW = 256;
	static constexpr int kScreenH = 240;

	Mapper mapper;   ///< Cartucho (bancos y CHR).
	NESMemory mem;   ///< Memoria/bus (RAM + hooks).
	Ppu ppu;         ///< PPU (fondo, sprites, registros).
	Apu apu;         ///< APU (pulse/triangle/noise/DMC).
	Hle hle;         ///< Capa HLE (clasificación y contabilidad).
	CPU cpu;         ///< Estado de la CPU.
	Interpreter interp; ///< Intérprete 6502 que ejecuta el código.

	/// Hook del **camino rápido/transpilado**: si devuelve ciclos > 0, la
	/// instrucción la resolvió el ejecutor pre-decodificado; si 0, se cae al
	/// intérprete. Permite cambiar de motor sin tocar `NesSystem`.
	using FastStep = int (*)(void* ctx, CPU& cpu, NESMemory& mem);
	/// Ejecutor rápido **por bloques**: ejecuta varias instrucciones hasta un
	/// salto o hasta que agotaría `budget` ciclos (frontera de scanline), sin
	/// alterar el timing. `out_instrs` recibe cuántas ejecutó.
	using FastRun = int (*)(void* ctx, CPU& cpu, NESMemory& mem, int budget, int* out_instrs);
	void* fast_ctx = nullptr;       ///< Contexto del ejecutor rápido.
	FastStep fast_step = nullptr;   ///< Ejecutor rápido de una instrucción (o `nullptr`).
	FastRun fast_run = nullptr;     ///< Ejecutor rápido por bloques (o `nullptr`).

	eng::u8 pad1 = 0;    ///< Estado del mando 1 (bit por botón).
	eng::u8 pad2 = 0;    ///< Estado del mando 2.
	bool strobe = false; ///< Strobe de `$4016`.
	eng::u8 shift1 = 0;  ///< Desplazamiento del mando 1.
	eng::u8 shift2 = 0;  ///< Desplazamiento del mando 2.
	int ppu_dot = 0;     ///< Dots acumulados en la línea actual.

	/// Instala los hooks de E/S y enlaza el intérprete con `cpu`/`mem`.
	NesSystem() : interp(cpu, mem) {
		mem.io_user = this;
		mem.io_read = &NesSystem::io_read_cb;
		mem.io_write = &NesSystem::io_write_cb;
		hle.ppu = &ppu;
	}

	/// Asigna el cartucho (mapper y CHR) al sistema.
	/// \param m Mapper ya inicializado con PRG/CHR.
	void load_mapper(const Mapper& m) {
		mapper = m;
		ppu.chr = m.chr;
		ppu.chr_size = m.chr_size;
		ppu.mirror_h = m.mirror_h;
		mem.prg = m.prg;
		mem.prg_size = m.prg_size;
	}

	/// Reinicia CPU y PPU al estado de arranque (vector de reset).
	void reset() {
		cpu = CPU {};
		cpu.mem = &mem;
		cpu.PC = mem.read16(0xFFFCu);
		cpu.SP = 0xFDu;
		cpu.I = true;
		cpu.brk_halts = false; // el runtime usa la semántica del intérprete en BRK
		ppu = Ppu {};
		ppu.chr = mapper.chr;
		ppu.chr_size = mapper.chr_size;
		ppu.mirror_h = mapper.mirror_h;
		ppu.scanline = 0;
		interp.jammed = false;
	}

	/// Ejecuta un **bloque** (varias instrucciones) si hay ejecutor rápido por
	/// bloques, o una sola instrucción de lo contrario, y avanza PPU/NMI. Es el
	/// ladrillo de `run_frame()`; se expone para pruebas en lockstep.
	/// \param out_instrs Nº de instrucciones ejecutadas (salida); puede ser `nullptr`.
	/// \return Ciclos de CPU consumidos por el bloque.
	int step_block(int* out_instrs) {
		if (fast_run != nullptr) {
			const int budget = cycles_to_scanline();
			int n = 0;
			int cyc = fast_run(fast_ctx, cpu, mem, budget, &n);
			if (cyc <= 0) {
				cyc = interp.step(); // primera instrucción no cubierta/bloque vacío
				n = 1;
			}
			clock_ppu(cyc);
			if (ppu.nmi_occurred) {
				ppu.nmi_occurred = false;
				trigger_nmi();
			}
			if (out_instrs != nullptr) {
				*out_instrs = n;
			}
			return cyc;
		}
		const int cyc = step_instruction();
		if (out_instrs != nullptr) {
			*out_instrs = 1;
		}
		return cyc;
	}

	/// Ejecuta **una** instrucción de CPU y avanza la PPU/NMI en consecuencia.
	/// Se expone para pruebas en lockstep (comparar intérprete vs ejecutor rápido
	/// instrucción a instrucción).
	/// \return Ciclos de CPU consumidos por la instrucción.
	int step_instruction() {
		int cyc;
		if (fast_step != nullptr) {
			cyc = fast_step(fast_ctx, cpu, mem);
			if (cyc <= 0) {
				cyc = interp.step(); // opcode no cubierto: cae al intérprete
			}
		} else {
			cyc = interp.step();
		}
		clock_ppu(cyc);
		if (ppu.nmi_occurred) {
			ppu.nmi_occurred = false;
			trigger_nmi();
		}
		return cyc;
	}

	/// Ejecuta un frame completo: corre la CPU a lo largo de las 262 líneas de la
	/// PPU (incluido VBlank) hasta que la PPU vuelve a la línea 0. Así el juego ve
	/// el flag de VBlank y ejecuta su rutina de actualización.
	void run_frame() {
		ppu.scanline = 0;
		ppu.status = static_cast<eng::u8>(ppu.status & ~0x80u);
		ppu.nmi_occurred = false;
		ppu_dot = 0;
		bool seen_vblank = false;
		int guard = 0;
		for (;;) {
			int n = 0;
			step_block(&n);
			guard += (n > 0) ? n : 1;
			if (ppu.scanline == 241u) {
				seen_vblank = true;
			}
			if (seen_vblank && ppu.scanline == 0u) {
				break; // el frame se ha completado (la PPU volvió a la línea 0)
			}
			if (guard > 120000) {
				break; // salvaguarda anti-cuelgue
			}
		}
		ppu.render_frame();
	}

	/// Copia el framebuffer a RGB de 8 bits (`ancho*alto*3` bytes).
	/// \param out Búfer destino de tamaño al menos `kScreenW*kScreenH*3`.
	void frame_rgb(eng::Span<eng::u8> out) const {
		for (int i = 0; i < kScreenW * kScreenH; ++i) {
			const eng::u8 c = ppu.fb[i];
			eng::u8 r;
			eng::u8 g;
			eng::u8 b;
			if (ppu.ext_palette != nullptr) {
				// Paleta extendida de un pack (0x0RGB): 4 bits por canal × 17.
				const eng::u16 v = ppu.ext_palette[c];
				r = static_cast<eng::u8>(((v >> 8u) & 0x0Fu) * 17u);
				g = static_cast<eng::u8>(((v >> 4u) & 0x0Fu) * 17u);
				b = static_cast<eng::u8>((v & 0x0Fu) * 17u);
			} else {
				const eng::u8 cc = static_cast<eng::u8>(c & 0x3Fu);
				r = kPaletteRgb[cc][0];
				g = kPaletteRgb[cc][1];
				b = kPaletteRgb[cc][2];
			}
			out[static_cast<eng::usize>(i) * 3u + 0u] = r;
			out[static_cast<eng::usize>(i) * 3u + 1u] = g;
			out[static_cast<eng::usize>(i) * 3u + 2u] = b;
		}
	}

private:
	static eng::u8 io_read_cb(void* u, eng::u16 a) {
		return static_cast<NesSystem*>(u)->io_read(a);
	}
	static void io_write_cb(void* u, eng::u16 a, eng::u8 v) {
		static_cast<NesSystem*>(u)->io_write(a, v);
	}

	/// Lee `$2000-$FFFF` (PPU espejada, APU, mandos, cartucho).
	eng::u8 io_read(eng::u16 a) {
		if (a < 0x4000u) {
			return ppu.read_reg(static_cast<eng::u16>(a & 0x07u));
		}
		if (a == 0x4015u) {
			return apu.read_status();
		}
		if (a == 0x4016u) {
			const eng::u8 b = static_cast<eng::u8>(shift1 & 1u);
			if (!strobe) shift1 = static_cast<eng::u8>(shift1 >> 1u);
			return static_cast<eng::u8>(b | 0x40u);
		}
		if (a == 0x4017u) {
			const eng::u8 b = static_cast<eng::u8>(shift2 & 1u);
			if (!strobe) shift2 = static_cast<eng::u8>(shift2 >> 1u);
			return static_cast<eng::u8>(b | 0x40u);
		}
		if (a >= 0x4020u) {
			return mapper.cpu_read(a);
		}
		return 0u;
	}

	/// Escribe `$2000-$FFFF` (PPU/HLE, OAM DMA, APU, mandos, mapper).
	void io_write(eng::u16 a, eng::u8 v) {
		if (a < 0x4000u) {
			hle.write_ppu(a, v);
			return;
		}
		if (a == 0x4014u) {  // OAM DMA
			hle.oam_dma(v);
			const eng::u16 base = static_cast<eng::u16>(static_cast<eng::u16>(v) << 8u);
			for (int i = 0; i < 256; ++i) {
				ppu.oam[i] = mem.read(static_cast<eng::u16>(base + static_cast<eng::u16>(i)));
			}
			return;
		}
		if (a == 0x4016u) {
			strobe = (v & 1u) != 0u;
			if (strobe) {
				shift1 = pad1;
				shift2 = pad2;
			}
			return;
		}
		if (a >= 0x4000u && a <= 0x4017u) {
			apu.write_reg(a, v);
			return;
		}
		if (a >= 0x4020u) {
			mapper.cpu_write(a, v);
			return;
		}
	}

	/// Máximo de ciclos de CPU que caben antes de cruzar la frontera de scanline
	/// (341 dots, 3 por ciclo). `ppu_dot` está en `[0, 340]`; devolver 0 fuerza
	/// que el siguiente bloque ejecute una sola instrucción (puede cruzar).
	/// \return Ciclos hasta el próximo límite de scanline.
	[[nodiscard]] int cycles_to_scanline() const {
		const int b = (340 - ppu_dot) / 3;
		return b < 0 ? 0 : b;
	}

	/// Avanza la PPU `cpu_cycles*3` dots (341 dots por línea). Al cambiar de
	/// línea, **captura el scroll actual** para esa línea: así las escrituras a
	/// `$2005` a mitad de frame (splits) afectan solo desde ese punto (scroll
	/// mid-frame real, no el global de fin de frame).
	void clock_ppu(int cpu_cycles) {
		ppu_dot += cpu_cycles * 3;
		while (ppu_dot >= 341) {
			ppu_dot -= 341;
			const eng::u16 before = ppu.scanline;
			ppu.tick_scanline();
			if (ppu.scanline != before) {
				ppu.set_line_scroll(static_cast<int>(ppu.scanline), ppu.scroll_x, ppu.scroll_y);
			}
		}
	}

	/// Toma una NMI: apila PC y estado y salta al vector `$FFFA`.
	void trigger_nmi() {
		eng::u8 p = 0x20u;
		if (cpu.N) p = static_cast<eng::u8>(p | 0x80u);
		if (cpu.V) p = static_cast<eng::u8>(p | 0x40u);
		if (cpu.D) p = static_cast<eng::u8>(p | 0x08u);
		if (cpu.I) p = static_cast<eng::u8>(p | 0x04u);
		if (cpu.Z) p = static_cast<eng::u8>(p | 0x02u);
		if (cpu.C) p = static_cast<eng::u8>(p | 0x01u);
		cpu.push16(cpu.PC);
		cpu.push(p);
		cpu.I = true;
		cpu.PC = mem.read16(0xFFFAu);
	}
};

} // namespace n2a
