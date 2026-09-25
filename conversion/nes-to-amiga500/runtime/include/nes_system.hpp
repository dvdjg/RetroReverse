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
		ppu = Ppu {};
		ppu.chr = mapper.chr;
		ppu.chr_size = mapper.chr_size;
		ppu.scanline = 0;
		interp.jammed = false;
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
			const int cyc = interp.step();
			clock_ppu(cyc);
			if (ppu.nmi_occurred) {
				ppu.nmi_occurred = false;
				trigger_nmi();
			}
			if (ppu.scanline == 241u) {
				seen_vblank = true;
			}
			if (seen_vblank && ppu.scanline == 0u) {
				break; // el frame se ha completado (la PPU volvió a la línea 0)
			}
			if (++guard > 120000) {
				break; // salvaguarda anti-cuelgue
			}
		}
		ppu.render_frame();
	}

	/// Copia el framebuffer a RGB de 8 bits (`ancho*alto*3` bytes).
	/// \param out Búfer destino de tamaño al menos `kScreenW*kScreenH*3`.
	void frame_rgb(eng::Span<eng::u8> out) const {
		for (int i = 0; i < kScreenW * kScreenH; ++i) {
			const eng::u8 c = static_cast<eng::u8>(ppu.fb[i] & 0x3Fu);
			out[static_cast<eng::usize>(i) * 3u + 0u] = kPaletteRgb[c][0];
			out[static_cast<eng::usize>(i) * 3u + 1u] = kPaletteRgb[c][1];
			out[static_cast<eng::usize>(i) * 3u + 2u] = kPaletteRgb[c][2];
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

	/// Avanza la PPU `cpu_cycles*3` dots (341 dots por línea).
	void clock_ppu(int cpu_cycles) {
		ppu_dot += cpu_cycles * 3;
		while (ppu_dot >= 341) {
			ppu_dot -= 341;
			ppu.tick_scanline();
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
