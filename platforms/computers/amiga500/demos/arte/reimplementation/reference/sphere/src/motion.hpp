#ifndef REIN_MOTION_HPP
#define REIN_MOTION_HPP

// reimplementation/reference/sphere — movimiento (tumble) de la esfera de «Arte».
//
// Recuperado por Jon Ludlam del código de la parte (avance de fase en $2de950,
// acumulación de velocidad en $2de9c2). No es un giro a velocidad constante: la
// demo integra una suma de senos.
//
// Una vez por vblank PAL (50 Hz):
//   - cuatro contadores de fase avanzan por pasos fijos;
//   - dos velocidades (suma de dos lookups de seno escalados, tomados del word
//     alto de un producto 16x16) integran en dos acumuladores de 16 bits;
//   - la rotación toma su byte vertical de acc_v y su byte horizontal (doblado)
//     de acc_h.

#include <cstdint>

namespace rein {

struct Motion {
    std::uint16_t pa = 0, pb = 0, pc = 0, pd = 0;
    std::uint16_t acc_h = 0, acc_v = 0;  // $34 (horizontal), $36 (vertical)

    // pasos de fase, del código original
    static constexpr std::uint16_t kStepA = 0x50, kStepB = 0x2c,
                                   kStepC = 0x12, kStepD = 0x2e;

    // Avanza un vblank PAL.
    void step();

    // Rotación (16 bits) a pasar al render: byte alto vertical, bajo horizontal×2.
    std::uint16_t rotation() const {
        return (std::uint16_t)((acc_v & 0xff00) | (((acc_h >> 8) * 2) & 0xff));
    }
};

}  // namespace rein

#endif  // REIN_MOTION_HPP