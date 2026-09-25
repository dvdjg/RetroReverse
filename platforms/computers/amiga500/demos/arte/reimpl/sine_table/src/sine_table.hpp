#pragma once
// Tabla de seno precalculada (Q1.14) para bucles de frame en 68000 sin punto flotante.
// Idea inspirada en SINE.soslibrary del demo (reimplementada, no copiada).
#include <cstdint>

namespace rein {

static constexpr unsigned kSinBits = 10;          // 1024 entradas
static constexpr unsigned kSinSize = 1u << kSinBits;
static constexpr unsigned kSinMask = kSinSize - 1u;
static constexpr int      kSinAmp  = 16384;       // == 1.0 en Q1.14

#include "sine_table_data.hpp"                    // define kSinTable (inline constexpr)

// Fase 0..65535 (16 bits, envuelve sola). Devuelve [-16384, 16384].
inline int sin_q14(unsigned phase) {
    return kSinTable[(phase >> (16 - kSinBits)) & kSinMask];
}

// Coseno = seno desplazado 1/4 de vuelta.
inline int cos_q14(unsigned phase) {
    return kSinTable[((phase >> (16 - kSinBits)) + (kSinSize >> 2)) & kSinMask];
}

} // namespace rein
