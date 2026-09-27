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
	Mmc5 = 5,   ///< MMC5 (Castlevania III USA, etc.).
	Vrc6 = 24,  ///< Konami VRC6 (mapper 24; el 26 = VRC6b vía `vrc6_b`).
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
	eng::u16 mmc3_irq_scan = 0xFFFFu; ///< Scanline del primer IRQ pedido (diagnóstico).
	eng::u32 mmc3_irq_count = 0;     ///< Nº de IRQs pedidos (diagnóstico).
	eng::u16 cur_scan = 0xFFFFu;     ///< Scanline actual (lo fija el sistema antes de `cpu_write`).
	eng::u32 mmc3_chr_mid = 0;       ///< Escrituras a bancos CHR en pleno frame visible (<240).

	// --- VRC6 (mapper 24/26) ---
	eng::u8 vrc6_prg0 = 0;       ///< $8000-$8003: banco PRG de 16 KB en $8000-$BFFF.
	eng::u8 vrc6_prg1 = 0;       ///< $C000-$C003: banco PRG de 8 KB en $C000-$DFFF.
	eng::u8 vrc6_chr[8] = {0};   ///< $D000-$E003: 8 bancos CHR de 1 KB.
	eng::u8 vrc6_banking = 0;    ///< $B003: modo (CHR/nametable).
	bool vrc6_b = false;         ///< Variante VRC6b (mapper 26): intercambia bits 0/1 de la dirección.
	eng::u8 vrc6_irq_latch = 0;  ///< $F000/$F001: valor de recarga (16 bits).
	eng::u8 vrc6_irq_counter = 0;///< Contador del IRQ (cuenta 0→$FF).
	eng::s16 vrc6_irq_prescaler = 0; ///< Prescaler (modo scanline: +341 cada paso).
	bool vrc6_irq_enable = false;    ///< IRQ habilitada ($F001 bit1).
	bool vrc6_irq_after_ack = false; ///< Valor de `enable` tras el ack ($F001 bit0).
	bool vrc6_irq_cycle_mode = false;///< Modo por ciclo ($F001 bit2) vs por scanline.
	bool vrc6_irq_pending = false;   ///< IRQ pedida.

	// --- MMC5 (mapper 5) ---
	// Subconjunto: PRG (modos 0-3), CHR (modos 0-3), PRG-RAM $6000-$7FFF, ExRAM
	// $5C00-$5FFF, fill-mode. PENDIENTE: nametables por ExRAM ($5104/$5105), split
	// vertical ($5200-$5205), IRQ por detección de scanline, multiplicador, audio.
	eng::u8 mmc5_prg_mode = 3;          ///< $5100: modo PRG (0-3).
	eng::u8 mmc5_prg_banks[5] = {0};    ///< $5113-$5117: bancos PRG/PRG-RAM.
	eng::u8 mmc5_chr_mode = 0;          ///< $5101: modo CHR (0-3).
	eng::u8 mmc5_chr_banks[12] = {0};   ///< $5120-$512B: bancos CHR (bajo).
	eng::u8 mmc5_chr_upper = 0;         ///< $5130: bits altos de los bancos CHR.
	eng::u8 mmc5_nametable = 0;         ///< $5105: mapa de nametables (pendiente).
	eng::u8 mmc5_exram_mode = 0;        ///< $5104: modo de ExRAM.
	eng::u8 mmc5_fill_tile = 0;         ///< $5106: tile de relleno.
	eng::u8 mmc5_fill_color = 0;        ///< $5107: color de relleno.
	eng::u8 mmc5_exram[0x400] = {0};    ///< ExRAM ($5C00-$5FFF, 1 KB).
	eng::u8 mmc5_fill[0x400] = {0};     ///< Nametable de fill-mode (32×30 tiles + 64 attr), R-only.

	/// ¿La MMC3 pide IRQ? \return `true` si hay IRQ pendiente.
	[[nodiscard]] bool irq_line() const noexcept {
		if (kind == MapperKind::Mmc3) {
			return mmc3_irq_pending;
		}
		if (kind == MapperKind::Vrc6) {
			return vrc6_irq_pending;
		}
		return false;
	}

	/// Reloj del mapper por **ciclos de CPU** (lo llama el sistema). Hoy: IRQ de la
	/// VRC6, que cuenta por ciclos. La MMC3 usa `on_scanline`.
	/// \param cpu_cycles Ciclos de CPU desde la última llamada.
	void clock(int cpu_cycles) { vrc6_clock(cpu_cycles); }

	/// Reloj de **una scanline** (lo llama el sistema durante el render). La MMC3
	/// decrementa su contador y pide IRQ al llegar a 0.
	void on_scanline(eng::u16 scan) {
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
			if (mmc3_irq_scan == 0xFFFFu) {
				mmc3_irq_scan = scan;
			}
			++mmc3_irq_count;
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
		case MapperKind::Mmc5: {
			// 8 KB por ventana, modo de $5100 (mesen MMC5.h `UpdatePrgBanks`). Los bancos
			// de $5113-$5117 son números de página de 8 KB (`prg_banks[4]` = $5117).
			const eng::u32 n8 = prg_size / 0x2000u;
			const eng::u8 p1 = mmc5_prg_banks[1];
			const eng::u8 p2 = mmc5_prg_banks[2];
			const eng::u8 p3 = mmc5_prg_banks[3];
			const eng::u8 p4 = mmc5_prg_banks[4];
			eng::u32 bank8;
			if (mmc5_prg_mode == 0u) {
				bank8 = static_cast<eng::u32>(p4 & 0x7Cu) + ((addr >> 13u) & 3u);
			} else if (mmc5_prg_mode == 1u) {
				bank8 = (addr < 0xC000u) ? static_cast<eng::u32>(p2 & 0xFEu) + ((addr >> 13u) & 1u)
							 : static_cast<eng::u32>(p4 & 0x7Eu) + ((addr >> 13u) & 1u);
			} else if (mmc5_prg_mode == 2u) {
				if (addr < 0xC000u) {
					bank8 = static_cast<eng::u32>(p2 & 0xFEu) + ((addr >> 13u) & 1u);
				} else if (addr < 0xE000u) {
					bank8 = p3;
				} else {
					bank8 = p4 & 0x7Fu;
				}
			} else { // modo 3
				if (addr < 0xA000u) {
					bank8 = p1;
				} else if (addr < 0xC000u) {
					bank8 = p2;
				} else if (addr < 0xE000u) {
					bank8 = p3;
				} else {
					bank8 = p4 & 0x7Fu;
				}
			}
			if (n8 != 0u) {
				bank8 %= n8;
			}
			return prg_at(bank8 * 0x2000u + (off & 0x1FFFu));
		}
		case MapperKind::Vrc6: {
			// $8000-$BFFF = 16 KB conmutable ($8000-$8003); $C000 = 8 KB conmutable
			// ($C000-$C003); $E000 = último 8 KB fijo (mesen VRC6.h).
			const eng::u32 n8 = prg_size / 0x2000u;
			eng::u32 bank8;
			if (addr < 0xA000u) {
				bank8 = static_cast<eng::u32>(vrc6_prg0 & 0x0Fu) * 2u;
			} else if (addr < 0xC000u) {
				bank8 = static_cast<eng::u32>(vrc6_prg0 & 0x0Fu) * 2u + 1u;
			} else if (addr < 0xE000u) {
				bank8 = vrc6_prg1 & 0x1Fu;
			} else {
				bank8 = n8 != 0u ? n8 - 1u : 0u;
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
		case MapperKind::Vrc6:
			vrc6_write(addr, value);
			break;
		case MapperKind::Mmc5:
			mmc5_write(addr, value);
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
			} else if (kind == MapperKind::Vrc6) {
				// 8 bancos de 1 KB con el modo de $B003 (mesen VRC6.h `UpdatePpuBanking`).
				off = static_cast<eng::u32>(vrc6_chr_page(addr >> 10u)) * 0x400u +
				      (addr & 0x3FFu);
			} else if (kind == MapperKind::Mmc5) {
				off = static_cast<eng::u32>(mmc5_chr_page(addr >> 10u)) * 0x400u +
				      (addr & 0x3FFu);
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
				if (mmc3_bank_select < 6u && cur_scan < 240u) {
					++mmc3_chr_mid; // cambio de banco CHR a mitad del frame visible
				}
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

	/// Banco CHR de 1 KB (`page` 0..7) de la VRC6 según el modo de `$B003`
	/// (mesen `VRC6.h::UpdatePpuBanking`). En modo 1 (`bankingMode&3==1`) los registros
	/// 0..3 dan bancos de 2 KB (par | bit); en modo 2/3, las mitades baja/alta.
	/// \param page Índice 0..7 (1 KB).
	/// \return Número de banco CHR de 1 KB.
	[[nodiscard]] eng::u8 vrc6_chr_page(eng::u32 page) const noexcept {
		const eng::u8 mask = (vrc6_banking & 0x20u) ? 0xFEu : 0xFFu;
		const eng::u8 orm = (vrc6_banking & 0x20u) ? 1u : 0u;
		switch (vrc6_banking & 0x03u) {
		case 0u:
			return vrc6_chr[page & 7u];
		case 1u: {
			const eng::u8 base = static_cast<eng::u8>(vrc6_chr[(page >> 1) & 3u] & mask);
			return (page & 1u) != 0u ? static_cast<eng::u8>(base | orm) : base;
		}
		default: // 2 o 3
			if (page < 4u) {
				return vrc6_chr[page];
			}
			{
				const eng::u8 base = static_cast<eng::u8>(vrc6_chr[4u + ((page - 4u) >> 1)] & mask);
				return (page & 1u) != 0u ? static_cast<eng::u8>(base | orm) : base;
			}
		}
	}

	/// Fija el mirroring desde `$B003` (mesen VRC6.h). Sólo los modos de nametable por
	/// CIRAM (bit 4 = 0); el modo de nametables por CHR ROM no se modela (raro).
	void vrc6_update_mirroring() {
		vrc6_banking &= 0xFFu;
		if ((vrc6_banking & 0x10u) != 0u) {
			return; // nametables por CHR ROM: sin efecto (no modelado)
		}
		switch (vrc6_banking & 0x2Fu) {
		case 0x20u:
		case 0x27u:
			mirror_single = -1;
			mirror_h = false; // vertical
			break;
		case 0x23u:
		case 0x24u:
			mirror_single = -1;
			mirror_h = true; // horizontal
			break;
		case 0x28u:
		case 0x2Fu:
			mirror_single = 0; // 1 pantalla A
			break;
		case 0x2Bu:
		case 0x2Cu:
			mirror_single = 1; // 1 pantalla B
			break;
		default:
			mirror_single = -1;
			break;
		}
	}

	/// Escrituras de registro de la VRC6 (`$8000-$FFFF`). El audio ($9000-$B002) se
	/// ignora. En la variante **VRC6b** (mapper 26) los bits 0/1 de la dirección van
	/// intercambiados (mesen VRC6.h).
	/// \param addr Dirección de escritura. \param value Byte escrito.
	void vrc6_write(eng::u16 addr, eng::u8 value) {
		if (vrc6_b) {
			addr = static_cast<eng::u16>((addr & 0xFFFCu) | ((addr & 1u) << 1u) |
						      ((addr & 2u) >> 1u));
		}
		switch (addr & 0xF003u) {
		case 0x8000u: case 0x8001u: case 0x8002u: case 0x8003u:
			vrc6_prg0 = static_cast<eng::u8>(value & 0x0Fu);
			break;
		case 0xB003u:
			vrc6_banking = value;
			vrc6_update_mirroring();
			break;
		case 0xC000u: case 0xC001u: case 0xC002u: case 0xC003u:
			vrc6_prg1 = static_cast<eng::u8>(value & 0x1Fu);
			break;
		case 0xD000u: case 0xD001u: case 0xD002u: case 0xD003u:
			vrc6_chr[addr & 3u] = value;
			break;
		case 0xE000u: case 0xE001u: case 0xE002u: case 0xE003u:
			vrc6_chr[4u + (addr & 3u)] = value;
			break;
		case 0xF000u:
			vrc6_irq_latch = value;
			break;
		case 0xF001u:
			vrc6_irq_after_ack = (value & 0x01u) != 0u;
			vrc6_irq_enable = (value & 0x02u) != 0u;
			vrc6_irq_cycle_mode = (value & 0x04u) != 0u;
			if (vrc6_irq_enable) {
				vrc6_irq_counter = vrc6_irq_latch;
				vrc6_irq_prescaler = 341;
			}
			vrc6_irq_pending = false;
			break;
		case 0xF002u:
			vrc6_irq_enable = vrc6_irq_after_ack;
			vrc6_irq_pending = false;
			break;
		default:
			break; // $9000-$B002: audio (ignorado)
		}
	}

	/// Reloj de la VRC6 (IRQ por **ciclos de CPU**, mesen `VrcIrq::ProcessCpuClock`).
	/// El prescaler resta 3 por ciclo; en modo scanline da un paso cada ~341/3 ciclos.
	/// \param cycles Ciclos de CPU consumidos desde la última llamada.
	void vrc6_clock(int cycles) {
		if (kind != MapperKind::Vrc6 || !vrc6_irq_enable) {
			return;
		}
		for (int i = 0; i < cycles; ++i) {
			vrc6_irq_prescaler = static_cast<eng::s16>(vrc6_irq_prescaler - 3);
			if (vrc6_irq_cycle_mode || vrc6_irq_prescaler <= 0) {
				if (vrc6_irq_counter == 0xFFu) {
					vrc6_irq_counter = vrc6_irq_latch;
					vrc6_irq_pending = true;
				} else {
					++vrc6_irq_counter;
				}
				vrc6_irq_prescaler = static_cast<eng::s16>(vrc6_irq_prescaler + 341);
			}
		}
	}

	/// Banco CHR de 1 KB (`page` 0..7) de la MMC5 según el modo de `$5101` (mesen
	/// `MMC5.h::UpdateChrBanks`, rama `chrA` = bancos normales del fondo). Los bancos
	/// `$5120-$512B` son números de página en unidades del modo; `$5130` aporta los bits
	/// altos.
	/// \param page Índice 0..7 (1 KB).
	/// \return Número de banco CHR de 1 KB.
	[[nodiscard]] eng::u16 mmc5_chr_page(eng::u32 page) const noexcept {
		const eng::u32 upper = static_cast<eng::u32>(mmc5_chr_upper) << 8u;
		const auto bank = [&](eng::u32 i) -> eng::u32 {
			return static_cast<eng::u32>(mmc5_chr_banks[i & 7u]) | upper;
		};
		switch (mmc5_chr_mode & 3u) {
		case 0u:
			return static_cast<eng::u16>((bank(7u) << 3u) + page);
		case 1u:
			return static_cast<eng::u16>(((page < 4u ? bank(3u) : bank(7u)) << 2u) +
						     (page & 3u));
		case 2u:
			return static_cast<eng::u16>((bank(1u + ((page >> 1u) & 3u) * 2u) << 1u) +
						     (page & 1u));
		default:
			return static_cast<eng::u16>(bank(page));
		}
	}

	/// Escrituras de registro de la MMC5. Subconjunto: PRG/CHR, ExRAM, fill-mode.
	/// PENDIENTE (ver `MMC5` arriba): nametables por ExRAM ($5104/$5105), split vertical
	/// ($5200-$5205), IRQ, multiplicador y audio.
	/// \param addr Dirección. \param value Byte.
	void mmc5_write(eng::u16 addr, eng::u8 value) {
		if (addr >= 0x5113u && addr <= 0x5117u) {
			mmc5_prg_banks[addr - 0x5113u] = value;
			return;
		}
		if (addr >= 0x5120u && addr <= 0x512Bu) {
			mmc5_chr_banks[addr - 0x5120u] = value;
			return;
		}
		if (addr >= 0x5C00u && addr <= 0x5FFFu) {
			mmc5_exram[(addr - 0x5C00u) & 0x3FFu] = value;
			return;
		}
		switch (addr) {
		case 0x5100u: mmc5_prg_mode = static_cast<eng::u8>(value & 0x03u); break;
		case 0x5101u: mmc5_chr_mode = static_cast<eng::u8>(value & 0x03u); break;
		case 0x5104u: mmc5_exram_mode = static_cast<eng::u8>(value & 0x03u); break;
		case 0x5105u: mmc5_nametable = value; break; // pendiente: mapeo real de nametables
		case 0x5106u:
			mmc5_fill_tile = value;
			for (eng::u32 i = 0; i < 32u * 30u; ++i) {
				mmc5_fill[i] = value; // 32 tiles/fila × 30 filas
			}
			break;
		case 0x5107u: {
			mmc5_fill_color = static_cast<eng::u8>(value & 0x03u);
			const eng::u8 ab = static_cast<eng::u8>(mmc5_fill_color | (mmc5_fill_color << 2u) |
								(mmc5_fill_color << 4u) |
								(mmc5_fill_color << 6u));
			for (eng::u32 i = 0; i < 64u; ++i) {
				mmc5_fill[32u * 30u + i] = ab; // tabla de atributos (64 B)
			}
			break;
		}
		case 0x5130u: mmc5_chr_upper = static_cast<eng::u8>(value & 0x03u); break;
		default: break; // $5000-$5015 (audio), $5102/$5103 (protect), $5200+ (split)
		}
	}
};

} // namespace n2a
