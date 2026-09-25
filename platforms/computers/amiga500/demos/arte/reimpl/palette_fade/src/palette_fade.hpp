#ifndef REIN_PALETTE_FADE_HPP
#define REIN_PALETTE_FADE_HPP

// reimpl/palette_fade — fade de paleta por nibbles (R/G/B por separado).
//
// Técnica recuperada (bloque 0x0B0C2C, rutina 0x031C-0x03E2): cada color OCS de
// 12 bits (0RGB) se acerca un paso hacia su color objetivo, componente a
// componente (nibbles), comparando nibble a nibble y sumando/restando 1, 0x10 o
// 0x100 (B, G, R). Controlado por un contador de frames.
//
// Referencia C++: fade_palette_step() acerca cada color un nivel por llamada.

#include <cstdint>
#include <vector>

namespace rein {

using u16 = std::uint16_t;

// Un paso de fade: acerca `cur[i]` hacia `dst[i]` en los nibbles B (bit 0-3),
// G (4-7) y R (8-11). Devuelve true si algún color cambió.
bool fade_palette_step(std::vector<u16>& cur, const std::vector<u16>& dst);

// Acerca todos los colores hasta que coincidan (o `max_steps`).
void fade_palette(std::vector<u16>& cur, const std::vector<u16>& dst, int max_steps = 4096);

}  // namespace rein

#endif  // REIN_PALETTE_FADE_HPP