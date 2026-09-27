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
	Mmc3 = 4,  ///< PRG/CHR por bancos + IRQ por scanline.
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
	eng::u8 mmc1_shift = 0;      ///< Registro de desplazamiento del MMC1.
	eng::u8 mmc1_count = 0;      ///< Bits recibidos.
	eng::u8 mmc1_ctrl = 0x0Cu;   ///< Registro de control ($8000); al power-on bits 2,3 = 1.
	eng::u8 mmc1_chr0 = 0;       ///< Registro CHR 0 ($A000).
	eng::u8 mmc1_chr1 = 0;       ///< Registro CHR 1 ($C000).
	eng::u8 mmc1_prg = 0;        ///< Registro de banco de PRG ($E000).
	bool mmc1_last_chr1 = false; ///< El último registro CHR escrito fue $C000 (para CHR de 4 KB).
	int mirror_single = -1;      ///< 1 pantalla: -1 = no; 0 = banco A; 1 = banco B (MMC1 modos 0/1).
	bool mmc1_wram_enabled = true; ///< WRAM de $6000-$7FFF habilitada ($E000 bit 4 = 0).
	eng::u32 mmc1_last_write = 0; ///< Ciclo de la última escritura (filtro de 2 ciclos de MMC1).
	eng::u32 cpu_cycle = 0;       ///< Ciclo de CPU actual (lo fija el sistema antes de `cpu_write`).
	/// Hook de **diagnóstico** opcional: `(registro 0..3, valor)` en cada commit del
	/// MMC1 (ctrl/chr/prg). No afecta al comportamiento.
	void (*write_trace)(eng::u8 reg, eng::u8 value) = nullptr;

	// --- MMC3 ---
	eng::u8 mmc3_bank_select = 0;   ///< Registro seleccionado ($8000).
	eng::u8 mmc3_regs[8] = {0};     ///< R0..R7 ($8001).
	eng::u8 mmc3_prg_mode = 0;      ///< Modo PRG (bit 6 de $8000).
	eng::u8 mmc3_chr_mode = 0;      ///< Modo CHR (bit 7 de $8000).
	eng::u8 mmc3_irq_latch = 0;     ///< Recarga del contador IRQ ($C000).
	eng::u8 mmc3_irq_counter = 0;   ///< Contador de scanlines del IRQ.
	bool mmc3_irq_reload = false;   ///< Recargar el contador en el próximo scanline.
	bool mmc3_irq_enable = false;   ///< IRQ habilitada ($E001/$E000).
	bool mmc3_irq_pending = false;  ///< IRQ pedida (se limpia al escribir $E000).

	/// ¿La MMC3 pide IRQ? \return `true` si hay IRQ pendiente.
	[[nodiscard]] bool irq_line() const noexcept {
		return kind == MapperKind::Mmc3 && mmc3_irq_pending;
	}

	/// Reloj de **una scanline** (lo llama el sistema durante el render). La MMC3
	/// decrementa su contador y pide IRQ al llegar a 0.
	void on_scanline() {
		if (kind != MapperKind::Mmc3) {
			return;
		}
		if (mmc3_irq_counter == 0u || mmc3_irq_reload) {
			mmc3_irq_counter = mmc3_irq_latch;
			mmc3_irq_reload = false;
		} else {
			--mmc3_irq_counter;
		}
		if (mmc3_irq_counter == 0u && mmc3_irq_enable) {
			mmc3_irq_pending = true;
		}
	}

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
			// Modos PRG (mesen MMC1.h: `_prgMode`=16K si ctrl bit 3; `_slotSelect`=
			// $8000 si ctrl bit 2; si no, $C000):
			//  - 32K (bit3=0): ventana única de 32K = banco (`prg & 0x0E`).
			//  - 16K (bit3=1): banco conmutable (prg & 0x0F) en $8000 o $C000 según
			//    slot; el otro es fijo (0 en $8000.., o el último en $C000..).
			const bool mode16 = (mmc1_ctrl & 0x08u) != 0u;
			const bool slot8000 = (mmc1_ctrl & 0x04u) != 0u;
			const eng::u32 last = (prg_size >= 0x4000u) ? prg_size - 0x4000u : 0u;
			if (!mode16) {
				const eng::u32 base = static_cast<eng::u32>(mmc1_prg & 0x0Eu) * 0x4000u;
				return prg_at(base + off);
			}
			if (slot8000) {
				if (addr >= 0xC000u) {
					return prg_at(last + (addr - 0xC000u));
				}
				return prg_at(static_cast<eng::u32>(mmc1_prg & 0x0Fu) * 0x4000u + off);
			}
			if (addr >= 0xC000u) {
				return prg_at(static_cast<eng::u32>(mmc1_prg & 0x0Fu) * 0x4000u + (addr - 0xC000u));
			}
			return prg_at(off); // $8000-$BFFF = banco 0 fijo
		}
		case MapperKind::Mmc3: {
			// 4 ventanas de 8 KB. R6/R7 conmutan; las dos últimas fijas.
			const eng::u32 n8 = prg_size / 0x2000u; // nº de bancos de 8 KB
			const eng::u32 fixed_last = n8 != 0u ? n8 - 1u : 0u;
			const eng::u32 fixed_2nd = n8 >= 2u ? n8 - 2u : 0u;
			eng::u32 bank8;
			if (addr < 0xA000u) {
				bank8 = (mmc3_prg_mode == 0u) ? mmc3_regs[6] : fixed_2nd;
			} else if (addr < 0xC000u) {
				bank8 = mmc3_regs[7];
			} else if (addr < 0xE000u) {
				bank8 = (mmc3_prg_mode == 0u) ? fixed_2nd : mmc3_regs[6];
			} else {
				bank8 = fixed_last;
			}
			if (n8 != 0u) {
				bank8 %= n8;
			}
			return prg_at(bank8 * 0x2000u + (off & 0x1FFFu));
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
		case MapperKind::Mmc3:
			mmc3_write(addr, value);
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
				// mesen MMC1.h: 8K (ctrl bit4=0) usa chr0&0x1E (par) en dos mitades; 4K
				// usa chr0 en $0000-$0FFF y chr1 en $1000-$1FFF.
				if ((mmc1_ctrl & 0x10u) == 0u) {
					// 8 KB: `off` (=addr) ya recorre 0..$1FFF; añade el banco 8K par.
					off += ((mmc1_chr0 & 0x1Fu) & ~1u) * 0x1000u;
				} else if (addr >= 0x1000u) {
					off += static_cast<eng::u32>(mmc1_chr1 & 0x1Fu) * 0x1000u;
				} else {
					off += static_cast<eng::u32>(mmc1_chr0 & 0x1Fu) * 0x1000u;
				}
			} else if (kind == MapperKind::Mmc3) {
				off = mmc3_chr_addr(addr);
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

	/// Actualiza el mirroring del MMC1 desde `mmc1_ctrl` bits 0-1 (mesen MMC1.h
	/// `UpdateState`): 0 = 1 pantalla A, 1 = 1 pantalla B, 2 = vertical, 3 = horizontal.
	void mmc1_update_mirroring() {
		switch (mmc1_ctrl & 0x03u) {
		case 0u:
			mirror_single = 0;
			break;
		case 1u:
			mirror_single = 1;
			break;
		case 2u:
			mirror_single = -1;
			mirror_h = false;
			break;
		default:
			mirror_single = -1;
			mirror_h = true;
			break;
		}
	}

	/// Escritura serial (5 bits) del MMC1 a los registros de control/CHR/PRG, fiel a
	/// `mesen MMC1.h::WriteRegister`:
	/// - Si bit 7 (`r`) = 1: resetea el buffer y pone bits 2,3 de $8000 (16K, $8000).
	/// - Si no: desplaza 1 bit; al 5º, escribe el registro según `(addr>>13)&3`
	///   (0=$8000, 1=$A000, 2=$C000, 3=$E000).
	/// - Registros 0/1 (`$8000`/`$A000`) ignoran el bit 0.
	/// - Se ignora la escritura si ocurre < 2 ciclos tras la anterior (dummy write),
	///   salvo que traiga el bit de reset.
	/// \param addr Dirección de escritura ($8000-$FFFF).
	/// \param value Byte escrito.
	void mmc1_write(eng::u16 addr, eng::u8 value) {
		const bool reset = (value & 0x80u) != 0u;
		if (!reset && (cpu_cycle - mmc1_last_write) < 2u) {
			mmc1_last_write = cpu_cycle;
			return; // escritura "dummy" pegada a otra: se ignora
		}
		mmc1_last_write = cpu_cycle;
		if (reset) {
			mmc1_shift = 0u;
			mmc1_count = 0u;
			mmc1_ctrl = static_cast<eng::u8>(mmc1_ctrl | 0x0Cu);
			mmc1_update_mirroring();
			return;
		}
		mmc1_shift = static_cast<eng::u8>(mmc1_shift | ((value & 1u) << mmc1_count));
		if (++mmc1_count < 5u) {
			return;
		}
		eng::u8 reg = mmc1_shift;
		const eng::u32 which = (addr >> 13u) & 3u;
		switch (which) {
		case 0u:
			mmc1_ctrl = reg;
			mmc1_update_mirroring();
			break;
		case 1u:
			mmc1_chr0 = static_cast<eng::u8>(reg & ~0x01u);
			mmc1_last_chr1 = false;
			break;
		case 2u:
			mmc1_chr1 = static_cast<eng::u8>(reg & ~0x01u);
			mmc1_last_chr1 = true;
			break;
		default:
			mmc1_prg = reg;
			// $E000 bit 4 = 1 deshabilita la WRAM de $6000-$7FFF.
			mmc1_wram_enabled = (reg & 0x10u) == 0u;
			break;
		}
		if (write_trace != nullptr) {
			write_trace(static_cast<eng::u8>(which), reg); // diagnóstico
		}
		mmc1_shift = 0u;
		mmc1_count = 0u;
	}

	/// Dirección CHR (1 KB) para una dirección de PPU según el modo CHR de la MMC3.
	/// \param addr Dirección de PPU (0..$1FFF).
	/// \return Offset dentro de la CHR.
	[[nodiscard]] eng::u32 mmc3_chr_addr(eng::u16 addr) const {
		if (mmc3_chr_mode == 0u) {
			// 2 KB en $0000 (R0) y $0800 (R1); 1 KB en $1000..$1C00 (R2..R5).
			if (addr < 0x0800u) {
				return static_cast<eng::u32>(mmc3_regs[0] & 0xFEu) * 0x400u + addr;
			}
			if (addr < 0x1000u) {
				return static_cast<eng::u32>(mmc3_regs[1] & 0xFEu) * 0x400u + (addr - 0x0800u);
			}
			const eng::u32 r = static_cast<eng::u32>((addr - 0x1000u) >> 10u);
			return static_cast<eng::u32>(mmc3_regs[2u + r]) * 0x400u + (addr & 0x3FFu);
		}
		// 1 KB en $0000..$0C00 (R2..R5); 2 KB en $1000 (R0) y $1800 (R1).
		if (addr < 0x1000u) {
			const eng::u32 r = static_cast<eng::u32>(addr >> 10u);
			return static_cast<eng::u32>(mmc3_regs[2u + r]) * 0x400u + (addr & 0x3FFu);
		}
		if (addr < 0x1800u) {
			return static_cast<eng::u32>(mmc3_regs[0] & 0xFEu) * 0x400u + (addr - 0x1000u);
		}
		return static_cast<eng::u32>(mmc3_regs[1] & 0xFEu) * 0x400u + (addr - 0x1800u);
	}

	/// Escrituras de registro de la MMC3 (`$8000-$FFFF`).
	void mmc3_write(eng::u16 addr, eng::u8 value) {
		if (addr < 0xA000u) {                       // $8000-$9FFF
			if ((addr & 1u) == 0u) {
				mmc3_bank_select = static_cast<eng::u8>(value & 0x07u);
				mmc3_prg_mode = (value & 0x40u) ? 1u : 0u;
				mmc3_chr_mode = (value & 0x80u) ? 1u : 0u;
			} else {
				mmc3_regs[mmc3_bank_select] = value;
			}
		} else if (addr < 0xC000u) {                // $A000-$BFFF: mirroring
			if ((addr & 1u) == 0u) {
				mirror_h = (value & 1u) != 0u; // 0 = vertical, 1 = horizontal
			}
			// $A001: protección de PRG-RAM (sin efecto aquí).
		} else if (addr < 0xE000u) {                // $C000-$DFFF: IRQ
			if ((addr & 1u) == 0u) {
				mmc3_irq_latch = value;
			} else {
				mmc3_irq_reload = true;
			}
		} else {                                    // $E000-$FFFF: habilitar/limpiar
			if ((addr & 1u) == 0u) {
				mmc3_irq_enable = false;
				mmc3_irq_pending = false;
			} else {
				mmc3_irq_enable = true;
			}
		}
	}
};

} // namespace n2a
