#pragma once

/// \file nes_mapper.hpp
/// Mapper de cartucho (bank switching) del runtime. Soporta los mappers más
/// comunes de juegos NROM/UxROM/CNROM y un MMC1 básico; expone lectura/escritura
/// para la CPU y para la PPU (CHR).
///
/// No usa herencia ni memoria dinámica: un solo `struct` con un discriminante
/// (`kind`) y el estado de cada mapper, para compilar igual en host y en 68000.
///
/// Alcance (F9 en curso): NROM (0), UxROM (2) y CNROM (3) completos; MMC1 (1)
/// parcial. MMC3 y otros quedan para después.

#include <eng/core/types/types.hpp>

namespace n2a {

/// Mapper de cartucho según el número iNES.
enum class MapperKind : eng::u8 {
	Nrom = 0,  ///< Sin bancos (16 KB espejados o 32 KB).
	Mmc1 = 1,  ///< Shift register (parcial).
	Uxrom = 2, ///< PRG conmutable (16 KB), CHR fija.
	Cnrom = 3, ///< PRG fija, CHR conmutable (8 KB).
};

/// Estado del cartucho: PRG/CHR y registros de bancos.
struct Mapper {
	MapperKind kind = MapperKind::Nrom; ///< Mapper detectado.
	const eng::u8* prg = nullptr;       ///< PRG-ROM (no propietario).
	eng::u32 prg_size = 0;              ///< Tamaño de PRG en bytes.
	const eng::u8* chr = nullptr;       ///< CHR-ROM (o `nullptr` si CHR RAM).
	eng::u32 chr_size = 0;              ///< Tamaño de CHR en bytes.
	eng::u8* chr_ram = nullptr;         ///< CHR RAM (si `chr == nullptr`).
	/// Mirroring de nametables del header iNES: `true` = horizontal (según el
	/// cartucho; scroll vertical), `false` = vertical (scroll horizontal).
	bool mirror_h = false;

	// --- Estado de bancos ---
	eng::u8 prg_bank = 0; ///< Banco de PRG seleccionado (UxROM/MMC1).
	eng::u8 chr_bank = 0; ///< Banco de CHR seleccionado (CNROM/MMC1).
	// --- MMC1 (shift register) ---
	eng::u8 mmc1_shift = 0; ///< Registro de desplazamiento del MMC1.
	eng::u8 mmc1_count = 0; ///< Bits recibidos.
	eng::u8 mmc1_ctrl = 0x0Cu; ///< Registro de control.
	eng::u8 mmc1_chr = 0;    ///< Registro de banco de CHR.
	eng::u8 mmc1_prg = 0;    ///< Registro de banco de PRG.
	/// Hook de **diagnóstico** opcional: `(registro 0..3, valor)` en cada commit del
	/// MMC1 (ctrl/chr/prg). No afecta al comportamiento.
	void (*write_trace)(eng::u8 reg, eng::u8 value) = nullptr;

	/// Lee el byte de la CPU en `addr` (zona de cartucho `$4020-$FFFF`).
	/// \param addr Dirección de 16 bits.
	/// \return Byte leído (0 si no está mapeado).
	[[nodiscard]] eng::u8 cpu_read(eng::u16 addr) const {
		if (addr < 0x8000u) {
			return 0u; // sin PRG-RAM en este alcance
		}
		const eng::u32 off = static_cast<eng::u32>(addr - 0x8000u);
		switch (kind) {
		case MapperKind::Nrom:
			return prg_at(off);
		case MapperKind::Uxrom:
			if (addr >= 0xC000u) {
				return prg_at((prg_size >= 0x4000u ? prg_size - 0x4000u : 0u) + (addr - 0xC000u));
			}
			return prg_at(static_cast<eng::u32>(prg_bank) * 0x4000u + off);
		case MapperKind::Cnrom:
			return prg_at(off);
		case MapperKind::Mmc1: {
			// NOTA: la referencia (MAME `nes_sxrom`) define los modos PRG (ctrl bits
			// 2-3): 0/1 = 32 KB; 2 = `$8000` fijo banco 0 / `$C000` conmutable;
			// 3 = `$8000` conmutable / `$C000` último fijo. Con esa lógica **metroid se
			// cuelga** (m1p=0x10 fuera de rango) => hay otro factor (filtro de
			// escritura de 1 ciclo del MMC1, o el banco CHR) aún sin resolver. Hasta
			// cotejarlo con la referencia, se mantiene el comportamiento que hace
			// funcionar Metroid/Mega Man 2 (modo >=2 = `$8000` conmutable, `$C000`
			// último) y MMC1 queda **parcial** (ver docs/COMPATIBILITY.md).
			const eng::u32 mode = (mmc1_ctrl >> 2u) & 3u;
			if (mode < 2u) {
				const eng::u32 base = (static_cast<eng::u32>(mmc1_prg & 0x0Eu)) * 0x4000u;
				return prg_at(base + off);
			}
			if (addr >= 0xC000u) {
				return prg_at((prg_size >= 0x4000u ? prg_size - 0x4000u : 0u) + (addr - 0xC000u));
			}
			return prg_at(static_cast<eng::u32>(mmc1_prg) * 0x4000u + off);
		}
		}
		return 0u;
	}

	/// Escribe un registro del mapper desde la CPU (bancos, MMC1).
	/// \param addr  Dirección de escritura.
	/// \param value Byte escrito.
	void cpu_write(eng::u16 addr, eng::u8 value) {
		switch (kind) {
		case MapperKind::Nrom:
			break;
		case MapperKind::Uxrom:
			if (addr >= 0x8000u) {
				prg_bank = static_cast<eng::u8>(value & 0x0Fu);
			}
			break;
		case MapperKind::Cnrom:
			if (addr >= 0x8000u) {
				chr_bank = static_cast<eng::u8>(value & 0x03u);
			}
			break;
		case MapperKind::Mmc1:
			mmc1_write(addr, value);
			break;
		}
	}

	/// Lee un byte de la PPU en `addr` (pattern/CHR).
	/// \param addr Dirección de PPU (0..$1FFF).
	/// \return Byte de CHR.
	[[nodiscard]] eng::u8 ppu_read(eng::u16 addr) const {
		if (chr != nullptr && chr_size != 0u) {
			eng::u32 off = addr;
			if (kind == MapperKind::Cnrom) {
				off += static_cast<eng::u32>(chr_bank) * 0x2000u;
			} else if (kind == MapperKind::Mmc1) {
				const eng::u8 bk = (mmc1_ctrl & 0x10u) ? 0u : mmc1_chr;
				off += static_cast<eng::u32>(bk) * 0x1000u;
			}
			return chr[off % chr_size];
		}
		if (chr_ram != nullptr) {
			return chr_ram[addr & 0x1FFFu];
		}
		return 0u;
	}

	/// Escribe CHR RAM (si existe). \param addr Dirección de PPU; \param v Byte.
	void ppu_write(eng::u16 addr, eng::u8 v) {
		if (chr_ram != nullptr) {
			chr_ram[addr & 0x1FFFu] = v;
		}
	}

private:
	/// Lee la PRG con espejo de 16 KB si procede. \param off Offset dentro de PRG.
	[[nodiscard]] eng::u8 prg_at(eng::u32 off) const {
		if (prg == nullptr || prg_size == 0u) {
			return 0u;
		}
		if (prg_size == 0x4000u) {
			off &= 0x3FFFu;
		}
		return prg[off % prg_size];
	}

	/// Escritura serial (5 bits) del MMC1 a los registros de control/CHR/PRG.
	void mmc1_write(eng::u16 addr, eng::u8 value) {
		if ((value & 0x80u) != 0u) {
			mmc1_shift = 0u;
			mmc1_count = 0u;
			mmc1_ctrl = static_cast<eng::u8>(mmc1_ctrl | 0x0Cu);
			return;
		}
		mmc1_shift = static_cast<eng::u8>(mmc1_shift | ((value & 1u) << mmc1_count));
		if (++mmc1_count == 5u) {
			eng::u8 reg = mmc1_shift;
			const eng::u32 which = (addr >> 13u) & 3u;
			switch (which) {
			case 0u:
				mmc1_ctrl = reg;
				break;
			case 1u:
				mmc1_chr = reg;
				break;
			case 2u:
				mmc1_prg = reg;
				break;
			default:
				break;
			}
			if (write_trace != nullptr) {
				write_trace(static_cast<eng::u8>(which), reg); // diagnóstico
			}
			mmc1_shift = 0u;
			mmc1_count = 0u;
		}
	}
};

} // namespace n2a
