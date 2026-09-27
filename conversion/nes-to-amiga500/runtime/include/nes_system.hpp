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

/// Versión del **oráculo** (semántica observable de la emulación: framebuffer, RAM,
/// timing). Queda **congelada** antes de empezar el backend Amiga; cualquier cambio
/// que altere lo observable debe incrementarla (ver `docs/VERSIONS.md`).
inline constexpr int kOracleVersion = 3;

/// Consola NES mínima: memoria con hooks hacia PPU/APU/mapper, CPU intérprete y
/// control de NMI por VBlank.
struct NesSystem {
	static constexpr int kScreenW = 256;
	static constexpr int kScreenH = 240;
	/// Dot de la línea en que A12 sube (fetch de sprites) → flanco del contador IRQ MMC3.
	static constexpr eng::u16 kA12Dot = 257u;

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
	eng::u32 nmi_count = 0; ///< NMIs tomadas (diagnóstico: ¿llega el VBlank al juego?).
	bool cycle_exact_ = true; ///< Reloj de bus por acceso activo (ver `set_cycle_exact`).
	int frames_done_ = 0;     ///< Frames completados: el 1º no fuerza la frontera (PPU desde línea 0).

	/// Instala los hooks de E/S y enlaza el intérprete con `cpu`/`mem`.
	NesSystem() : interp(cpu, mem) {
		mem.io_user = this;
		mem.io_read = &NesSystem::io_read_cb;
		mem.io_write = &NesSystem::io_write_cb;
		mem.cycle_user = this;
		mem.cycle_tick = &NesSystem::cycle_tick_cb; // PPU dot-exacta por acceso de bus
		apu.set_reader(&NesSystem::apu_read_cb, this); // DMC: leer samples de la PRG
		hle.ppu = &ppu;
	}

	/// Asigna el cartucho (mapper y CHR) al sistema.
	/// \param m Mapper ya inicializado con PRG/CHR.
	/// Callback de lectura de CHR para el render: aplica la conmutación de bancos del
	/// mapper (`Mapper::ppu_read`). \param ctx El `Mapper`; \param addr Offset PPU.
	/// \return Byte de CHR conmutado.
	static eng::u8 chr_read_cb(void* ctx, eng::u16 addr) {
		return static_cast<Mapper*>(ctx)->ppu_read(addr);
	}

	void load_mapper(const Mapper& m) {
		mapper = m;
		ppu.chr = m.chr;
		ppu.chr_size = m.chr_size;
		ppu.chr_ram = m.chr_ram;
		ppu.chr_read = &NesSystem::chr_read_cb;
		ppu.chr_ctx = &mapper;
		ppu.mirror_h = m.mirror_h;
		ppu.nt_single = m.mirror_single;
		mem.prg = m.prg;
		mem.prg_size = m.prg_size;
	}

	/// Activa/desactiva el **reloj de bus por acceso** (modelo dot-exacto del
	/// intérprete). Activado por defecto. Desactivarlo acelera el host (la PPU se
	/// reloja al final de la instrucción, modelo anterior) a costa de perder el
	/// orden intra-instrucción. No afecta al Amiga: el codegen no reloja por acceso.
	/// \param on `true` para relojear en cada acceso de bus.
	void set_cycle_exact(bool on) {
		cycle_exact_ = on;
		mem.cycle_tick = on ? &NesSystem::cycle_tick_cb : nullptr;
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
		ppu.chr_ram = mapper.chr_ram;
		ppu.chr_read = &NesSystem::chr_read_cb; // tras `ppu = Ppu{}` (que lo limpia)
		ppu.chr_ctx = &mapper;
		ppu.mirror_h = mapper.mirror_h;
		ppu.nt_single = mapper.mirror_single;
		ppu.scanline = 0;
		ppu.vblank_suppress = false; // mesen activa el flag en (241,1) desde el frame 0
		frames_done_ = 0;
		interp.jammed = false;
		// La CPU tarda 8 ciclos en empezar a ejecutar tras el reset (mesen CPU.cpp:150:
		// "the CPU takes 8 cycles before it starts executing the ROM's code"); durante
		// ellos el PPU avanza con el master clock. Sin esto, nuestro contador de ciclos va
		// 8 por detrás de mesen y el flag de VBlank cruza instrucciones distintas.
		interp.cycles = 8;
		clock_ppu(8);
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
				// Bloque vacío/no cubierto: una instrucción por el intérprete. Si el
				// reloj de bus está activo, ya reloja por acceso; si no, relojamos aquí.
				cyc = interp.step();
				n = 1;
				if (!cycle_exact_) {
					clock_ppu(cyc);
				}
			} else {
				clock_ppu(cyc); // la PRG transpilada no reloja por acceso
			}
			if (ppu.nmi_occurred) {
				ppu.nmi_occurred = false;
				trigger_nmi();
			} else if (!cpu.I && (apu.frame_irq || apu.dmc_irq || mapper.irq_line())) {
				trigger_irq();
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
	/// Ciclos de PPU a avanzar **antes** del acceso a datos de la instrucción en
	/// `cpu.PC` (dot-exacto para lecturas de registros de PPU). El acceso a datos
	/// del 6502 ocurre en el **último** ciclo de la instrucción, así que se
	/// pre-relojea `base-1` ciclos: una `LDA $2002` (4 ciclos) ve el estado en el
	/// ciclo 4 (el real), no al principio. Es una aproximación de 1 ciclo para
	/// lecturas indexadas con cruce de página. Solo afecta al orden intra-instrucción
	/// (el total no cambia), por lo que es inocuo para el timing global.
	/// \return Ciclos a pre-relojar (>= 0).
	[[nodiscard]] int ppu_pre_cycles() const {
		const eng::u8 op = mem.read(cpu.PC);
		const int b = Interpreter::opcode_cycles(op);
		return b > 0 ? b - 1 : 0;
	}

	/// Ejecuta **una** instrucción de CPU y avanza la PPU/NMI en consecuencia.
	/// Se expone para pruebas en lockstep (comparar intérprete vs ejecutor rápido
	/// instrucción a instrucción).
	/// \return Ciclos de CPU consumidos por la instrucción.
	int step_instruction() {
		int cyc;
		if (fast_step != nullptr) {
			// El ejecutor rápido no reloja por acceso: se pre-reloja al ciclo del
			// acceso a datos y se completa tras la instrucción.
			const int pre = ppu_pre_cycles();
			if (pre > 0) {
				clock_ppu(pre);
			}
			cyc = fast_step(fast_ctx, cpu, mem);
			if (cyc <= 0) {
				cyc = interp.step(); // el intérprete ya reloja por acceso (pre de más)
			} else {
				const int post = cyc - pre;
				if (post > 0) {
					clock_ppu(post);
				}
			}
		} else {
			// El intérprete reloja la PPU en cada acceso de bus y completa los ciclos
			// internos; si el reloj de bus está desactivado, se reloja aquí al final.
			cyc = interp.step();
			if (!cycle_exact_) {
				clock_ppu(cyc);
			}
		}
		if (ppu.nmi_occurred) {
			ppu.nmi_occurred = false; // el NMI se toma en frontera de instrucción
			trigger_nmi();
		} else if (!cpu.I && (apu.frame_irq || apu.dmc_irq || mapper.irq_line())) {
			trigger_irq(); // IRQ (frame counter del APU / DMC / MMC3), si no enmascarada
		}
		return cyc;
	}

	/// Ejecuta un frame completo: corre la CPU a lo largo de las 262 líneas de la
	/// PPU (incluido VBlank) hasta que la PPU vuelve a la línea 0. Así el juego ve
	/// el flag de VBlank y ejecuta su rutina de actualización.
	void run_frame() {
		// Sin supresión de VBlank: mesen levanta el flag en (241,1) desde el frame 0
		// (el antiguo `ppudead=2` de fceumm era un hack para Knight Rider y desalineaba
		// los bucles de espera del reset).
		ppu.vblank_suppress = false;
		ppu.mirror_h = mapper.mirror_h; // la MMC3/MMC1 cambian el mirroring en runtime
		ppu.nt_single = mapper.mirror_single;
		// Frontera de frame en la pre-VBlank (scanline 240). El PRIMER frame **no** se fuerza:
		// la PPU arranca en la línea 0 y llega a la 241 por sí sola (forzar la 240 aquí
		// saltaría las líneas 0-239 y adelantaría el primer VBlank ~27000 ciclos, haciendo
		// que el bucle `LDA $2002/BPL` del reset salga de inmediato). Desde el 2º frame la
		// PPU ya está en la 240 y se fija una frontera nítida.
		if (frames_done_ > 0) {
			ppu.scanline = 240u;
		}
		++frames_done_;
		ppu.status = static_cast<eng::u8>(ppu.status & ~0x80u);
		ppu.nmi_occurred = false;
		ppu.dot = 0u;
		bool seen_vblank = false;
		int guard = 0;
		for (;;) {
			int n = 0;
			step_block(&n);
			guard += (n > 0) ? n : 1;
			if (ppu.scanline == 241u) {
				seen_vblank = true;
			}
			if (seen_vblank && ppu.scanline == 240u) {
				break; // frame completo: la PPU volvió a la pre-VBlank
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
	/// Lector de memoria del **DMC**: lee el byte de `a` (PRG) para el canal DMC.
	/// Sin esto el DMC leía silencio y faltaban los samples.
	static eng::u8 apu_read_cb(void* u, eng::u16 a) {
		return static_cast<NesSystem*>(u)->mem.read(a);
	}

	static eng::u8 io_read_cb(void* u, eng::u16 a) {
		return static_cast<NesSystem*>(u)->io_read(a);
	}
	static void io_write_cb(void* u, eng::u16 a, eng::u8 v) {
		static_cast<NesSystem*>(u)->io_write(a, v);
	}

	/// Hook de reloj de bus: avanza la PPU `n` ciclos (3 dots cada uno).
	static void cycle_tick_cb(void* u, int n) { static_cast<NesSystem*>(u)->clock_ppu(n); }

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
		if (a >= 0x6000u && a < 0x8000u &&
		    (mapper.kind == MapperKind::Mmc3 || mapper.kind == MapperKind::Mmc1)) {
			// PRG-RAM/WRAM en $6000-$7FFF (MMC3 y MMC1). La MMC1 puede deshabilitarla
			// ($E000 bit 4); ver `mapper.wram_enabled`.
			if (mapper.kind == MapperKind::Mmc1 && !mapper.mmc1_wram_enabled) {
				return 0u;
			}
			return mem.prg_ram[a - 0x6000u];
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
		if (a >= 0x6000u && a < 0x8000u &&
		    (mapper.kind == MapperKind::Mmc3 || mapper.kind == MapperKind::Mmc1)) {
			if (mapper.kind != MapperKind::Mmc1 || mapper.mmc1_wram_enabled) {
				mem.prg_ram[a - 0x6000u] = v;
			}
			return;
		}
		if (a >= 0x4020u) {
			mapper.cpu_cycle = interp.cycles;
			mapper.cpu_write(a, v);
			return;
		}
	}

	/// Máximo de ciclos de CPU que caben antes de cruzar la frontera de scanline
	/// (341 dots, 3 por ciclo). `ppu.dot` está en `[0, 340]`; devolver 0 fuerza
	/// que el siguiente bloque ejecute una sola instrucción (puede cruzar).
	/// \return Ciclos hasta el próximo límite de scanline.
	[[nodiscard]] int cycles_to_scanline() const {
		const int b = (340 - static_cast<int>(ppu.dot)) / 3;
		return b < 0 ? 0 : b;
	}

	/// Avanza la PPU `cpu_cycles*3` dots (341 dots por línea). Al cambiar de
	/// línea, **captura el scroll actual** para esa línea: así las escrituras a
	/// `$2005` a mitad de frame (splits) afectan solo desde ese punto (scroll
	/// mid-frame real, no el global de fin de frame).
	void clock_ppu(int cpu_cycles) {
		const int dots = cpu_cycles * 3;
		const eng::u16 start = ppu.dot;
		const eng::u16 end = static_cast<eng::u16>(start + static_cast<eng::u16>(dots));
		// Sprite-0 **dot-exacto** sin iterar dot a dot: si el dot del hit cae dentro
		// de este tramo de la línea actual, se activa el flag. Los bloques del
		// ejecutor rápido terminan (o cruzan) en frontera de scanline, así que cada
		// llamada abarca como mucho una línea; el cruce se resuelve tras el `while`.
		if (ppu.scanline == ppu.sprite0_line && ppu.sprite0_dot >= start && ppu.sprite0_dot < end) {
			ppu.status = static_cast<eng::u8>(ppu.status | 0x40u);
		}
		// MMC3: A12 sube en el fetch de sprites (dot ~257) de cada línea renderizada; el
		// contador IRQ avanza ahí, no en la frontera de scanline (~257 dots / 86 ciclos
		// antes). Es el flanco dominante con el render activo.
		if (mapper.kind == MapperKind::Mmc3 && ppu.scanline < 240u && (ppu.mask & 0x18u) != 0u &&
		    kA12Dot >= start && kA12Dot < end) {
			mapper.on_scanline(ppu.scanline);
		}
		ppu.dot = end;
		while (ppu.dot >= 341u) {
			ppu.dot = static_cast<eng::u16>(ppu.dot - 341u);
			const eng::u16 before = ppu.scanline;
			ppu.tick_scanline();
			if (ppu.scanline != before) {
				ppu.set_line_scroll(static_cast<int>(ppu.scanline), ppu.scroll_x, ppu.scroll_y);
				// Cruce de la frontera de línea a mitad de tramo: el A12 de la nueva línea
				// (dot 257) queda por delante, se dispara en la siguiente llamada.
				if (ppu.scanline == ppu.sprite0_line && ppu.sprite0_dot < ppu.dot) {
					ppu.status = static_cast<eng::u8>(ppu.status | 0x40u);
				}
			}
		}
	}

	/// Toma una NMI: apila PC y estado y salta al vector `$FFFA`.
	void trigger_nmi() {
		++nmi_count;
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

	/// Toma una **IRQ**: apila PC y estado y salta al vector `$FFFE`. La usa el
	/// frame counter del APU (y el DMC). El flag `I` la enmascara.
	void trigger_irq() {
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
		cpu.PC = mem.read16(0xFFFEu);
	}
};

} // namespace n2a
