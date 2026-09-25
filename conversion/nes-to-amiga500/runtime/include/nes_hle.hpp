#pragma once

/// \file nes_hle.hpp
/// Capa HLE (alto nivel) mínima: clasifica las escrituras a los registros de la
/// PPU como **intención acelerable** (scroll, dirección/datos de VRAM, OAM DMA) o
/// como **fallback** (el resto). En el host los handlers actualizan el estado de la
/// PPU; en el Amiga real se convertirán en operaciones de Copper/Blitter.
///
/// Su función aquí es **medir el ratio HLE** (qué fracción de las escrituras PPU
/// se resuelven por el camino rápido), dato del hito F8.
///
/// Diseño y catálogo en [`../../docs/HLE.md`](../../docs/HLE.md).

#include <eng/core/types/types.hpp>

#include "nes_ppu.hpp"

namespace n2a {

/// Clasificador y handlers HLE sobre una PPU.
struct Hle {
	Ppu* ppu = nullptr;        ///< PPU sobre la que actúan los handlers.
	eng::u32 hle_writes = 0;   ///< Escrituras resueltas por el camino HLE.
	eng::u32 fb_writes = 0;    ///< Escrituras que van al fallback.

	/// Reinicia los contadores (se llama por frame si interesa).
	void reset_counters() {
		hle_writes = 0;
		fb_writes = 0;
	}

	/// Ratio HLE en por mil (`0..1000`): `hle / (hle + fallback)`.
	[[nodiscard]] eng::u32 ratio_permille() const {
		const eng::u32 total = hle_writes + fb_writes;
		return total != 0u ? (hle_writes * 1000u) / total : 0u;
	}

	/// Atiende una escritura a `$2000-$3FFF` (registros de PPU).
	/// \param addr Dirección (se enmascara a 8 registros).
	/// \param value Byte escrito.
	void write_ppu(eng::u16 addr, eng::u8 value) {
		if (ppu == nullptr) {
			return;
		}
		switch (addr & 0x07u) {
		case 5u:  // $2005: scroll -> HLE
			ppu->write_reg(5u, value);
			++hle_writes;
			break;
		case 6u:  // $2006: dirección de VRAM -> HLE
			ppu->write_reg(6u, value);
			++hle_writes;
			break;
		case 7u:  // $2007: datos de VRAM -> HLE
			ppu->write_reg(7u, value);
			++hle_writes;
			break;
		default:  // control/mask/OAMADDR/OAMDATA -> fallback
			ppu->write_reg(static_cast<eng::u16>(addr & 0x07u), value);
			++fb_writes;
			break;
		}
	}

	/// Marca un OAM DMA (`$4014`) como atendido por HLE. El copiado lo hace el
	/// sistema. \param page Página de origen (bits altos de la dirección).
	void oam_dma([[maybe_unused]] eng::u8 page) { ++hle_writes; }
};

} // namespace n2a
