#ifndef REIN_SINE_WOBBLE_HPP
#define REIN_SINE_WOBBLE_HPP

// reimpl/sine_wobble — efecto de distorsión/ondas por scanlines de «Arte».
//
// Técnica recuperada (bloque 0x096A28, efecto SINE): 8 osciladores de fase que
// avanzan por frame con velocidades distintas; la suma de sus senos da un
// desplazamiento horizontal por fila (ripple/wobble), aplicado por la copperlist.
//
// Referencia C++: por cada fila, calcular `offset(row)` como suma de las ondas y
// desplazar la fila (wrap). El original parchea la copperlist (no mueve píxeles).

#include <cstdint>

namespace rein {

using u16 = std::uint16_t;
using i16 = std::int16_t;
using i32 = std::int32_t;

// Tabla de seno Q15 (32767 * sin(2*pi*k/256)), 256 entradas.
extern const i16 kWobbleSin[256];

// 8 osciladores de fase (fiel a los incrementos del asm: +10,+4,+0x48,+0x52,
// +6,+9,+5,+4 por frame).
struct Wobble {
    u16 phase[8];
    static constexpr int kNumOsc = 8;
    static constexpr u16 kSpeed[8] = {10, 4, 0x48, 0x52, 6, 9, 5, 4};

    Wobble() { for (int i = 0; i < kNumOsc; i++) phase[i] = 0; }

    // Avanza todas las fases (1 frame).
    void step() {
        for (int i = 0; i < kNumOsc; i++) phase[i] = (u16)(phase[i] + kSpeed[i]);
    }

    // Desplazamiento horizontal de la fila `row` (en píxeles), suma de 8 ondas.
    // `spread` = cuánto desfasa cada oscilador por fila.
    int row_offset(int row, int spread) const {
        int acc = 0;
        for (int i = 0; i < kNumOsc; i++) {
            u16 idx = (u16)(phase[i] + row * spread * (i + 1));
            acc += kWobbleSin[idx & 0xFF];
        }
        return acc / (kNumOsc * 256);  // escala a píxeles
    }
};

// Aplica la distorsión a una imagen planar (1 byte/píxel, wrap horizontal).
void distort_rows(const std::uint8_t* src, std::uint8_t* dst, int w, int h,
                  const Wobble& wob, int spread);

}  // namespace rein

#endif  // REIN_SINE_WOBBLE_HPP