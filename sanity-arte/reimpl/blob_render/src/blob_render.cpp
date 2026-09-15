// reimpl/blob_render/src/blob_render.cpp
#include "blob_render.hpp"

namespace rein {

u16 expand4(u8 nibble) {
    // Cada bit del nibble se duplica: bit i -> bits 2i y 2i+1.
    u16 out = 0;
    for (int i = 0; i < 4; i++) {
        if (nibble & (1u << i)) out |= (u16)(3u << (2 * i));
    }
    return out;
}

ExpandLut::ExpandLut() {
    for (int i = 0; i < 16; i++) v[i] = expand4((u8)i);
}

void draw_planar_sprite(PlanarBuffer& fb, const std::vector<u8>& sprite,
                        int sprite_wb, int sprite_h, int x, int y,
                        const std::vector<u8>* mask) {
    // Dibuja un sprite planar (1 byte = 1 byte de plano) con la técnica clásica:
    // por cada byte, si hay máscara -> AND (borra), luego OR/copy del dato.
    // El original además usa una LUT para expandir/escalar; aquí copiamos byte a
    // byte (equivalente funcional para escala 1x).
    for (int p = 0; p < fb.planes; p++) {
        for (int row = 0; row < sprite_h; row++) {
            int dy = y + row;
            if (dy < 0 || dy >= fb.height) continue;
            const u8* src = &sprite[((std::size_t)p * sprite_h + row) * sprite_wb];
            const u8* msk = mask ? &(*mask)[((std::size_t)p * sprite_h + row) * sprite_wb]
                                 : nullptr;
            for (int bx = 0; bx < sprite_wb; bx++) {
                int dx = x + bx;
                if (dx < 0 || dx >= fb.width_bytes) continue;
                u8 s = src[bx];
                if (msk) {
                    // máscara=1 donde el sprite tapa: borrar fondo y poner sprite.
                    fb.at(p, dy, dx) = (u8)((fb.at(p, dy, dx) & ~msk[bx]) | (s & msk[bx]));
                } else {
                    fb.at(p, dy, dx) = s;
                }
            }
        }
    }
}

}  // namespace rein