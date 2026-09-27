#pragma once

/// \file raster_idioms.hpp
/// **Reconocedor de idiomas de raster** (sondeo de VBlank, de sprite-0 y bucles de
/// retardo) sobre la PRG de una ROM. Lo usan la herramienta `raster_idioms` y el
/// transpilador (`--raster-json`), que lo consume el codegen/backend Amiga (ver
/// `docs/TIMING_AMIGA.md`). Escaneo lineal: sirve para **cuantificar y localizar**;
/// no modifica la emulación.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "opcodes.hpp"

namespace n2a {

/// Idiomas encontrados en una PRG: hasta 4 direcciones de ejemplo por tipo y los
/// contadores totales.
struct RasterIdioms {
	unsigned vblank[4] = {0, 0, 0, 0};  ///< Direcciones de sondeo de VBlank (LDA/BIT $2002 + BPL/BMI).
	unsigned sprite0[4] = {0, 0, 0, 0}; ///< Direcciones de sondeo de sprite-0 (LDA $2002;AND #$40;BNE).
	unsigned delay[4] = {0, 0, 0, 0};   ///< Direcciones de bucles de retardo (LDX/LDY;DEX/DEY;BNE).
	int counts[3] = {0, 0, 0};          ///< Totales [vblank, sprite0, delay].
};

/// Salta los operandos de una instrucción. \param i Offset. \param op Opcode.
/// \return Offset siguiente.
[[nodiscard]] inline eng::usize ri_skip(eng::usize i, eng::u8 op) {
	const eng::u8 sz = kOpcodeTable[op].size;
	return i + (sz != 0u ? sz : 1u);
}

/// Escanea la PRG `p` (tamaño `n`) y rellena `out` con los idiomas encontrados.
inline void scan_raster_idioms(const eng::u8* p, eng::usize n, RasterIdioms& out) {
	for (eng::usize i = 0; i + 1 < n;) {
		const eng::u8 op = p[i];
		if ((op == 0xADu || op == 0x2Cu) && i + 2 < n && p[i + 1] == 0x02u && p[i + 2] == 0x20u) {
			if (op == 0xADu && i + 5 < n && p[i + 3] == 0x29u && p[i + 4] == 0x40u &&
			    (p[i + 5] == 0xD0u || p[i + 5] == 0xF0u)) {
				if (out.counts[1] < 4) out.sprite0[out.counts[1]] = static_cast<unsigned>(0x8000u + i);
				++out.counts[1];
			} else {
				eng::usize j = ri_skip(i, op);
				for (int k = 0; k < 4 && j < n; ++k) {
					if (p[j] == 0x10u || p[j] == 0x30u) {
						if (out.counts[0] < 4) out.vblank[out.counts[0]] = static_cast<unsigned>(0x8000u + i);
						++out.counts[0];
						break;
					}
					j = ri_skip(j, p[j]);
				}
			}
		}
		if (op == 0xA2u || op == 0xA0u) {
			eng::usize j = ri_skip(i, op);
			for (int k = 0; k < 6 && j + 1 < n; ++k) {
				if ((p[j] == 0xCAu || p[j] == 0x88u) && p[j + 1] == 0xD0u) {
					if (out.counts[2] < 4) out.delay[out.counts[2]] = static_cast<unsigned>(0x8000u + i);
					++out.counts[2];
					break;
				}
				j = ri_skip(j, p[j]);
			}
		}
		i = ri_skip(i, op);
	}
}

/// Escribe una lista JSON de direcciones (hex).
inline void ri_json_addrs(unsigned v[4], int n) {
	std::printf("[");
	for (int i = 0; i < n; ++i) {
		std::printf("%s\"0x%04X\"", i != 0 ? "," : "", v[i]);
	}
	std::printf("]");
}

} // namespace n2a
