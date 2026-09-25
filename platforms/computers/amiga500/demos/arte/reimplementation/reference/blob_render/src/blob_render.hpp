#ifndef REIN_BLOB_RENDER_HPP
#define REIN_BLOB_RENDER_HPP

// reimplementation/reference/blob_render — motor de dibujo de blobs/sprites planares de «Arte».
//
// Técnica recuperada (bloque 0x0B0C2C, rutinas 0x3318-0x3360 construir LUT,
// 0x34A0-0x34C8 render). El demo dibuja sprites/blobs a 3 bitplanes usando una
// tabla de lookup que expande bits (evita iterar píxel a píxel).
//
// Idea (referencia C++): precalcular la expansión de un nibble (4 bits) a su
// patrón de bits, y dibujar el sprite byte a byte con máscara AND (borrar) +
// OR/copy (pintar). El original además duplica bits (escalado horizontal 2x).

#include <cstdint>
#include <vector>

namespace rein {

using u8 = std::uint8_t;
using u16 = std::uint16_t;

// Expande 4 bits a 8 píxeles (cada bit repetido 2 veces) — la operación base de
// la LUT del demo. Ej.: 0b1010 -> 0b11001100.
u16 expand4(u8 nibble);

// LUT de expansión: expand4 para los 16 nibbles.
struct ExpandLut {
    u16 v[16];
    ExpandLut();
};

// Framebuffer planar: `planes` planos de `stride` bytes × `height` líneas.
struct PlanarBuffer {
    int width_bytes;   // bytes por línea (320px = 40)
    int height;
    int planes;
    std::vector<u8> data;  // planes * stride * height
    std::size_t stride() const { return (std::size_t)width_bytes; }
    u8& at(int plane, int y, int byte_x) {
        return data[((std::size_t)plane * height + y) * stride() + byte_x];
    }
};

// Dibuja un sprite planar (1 byte por línea por plano) en (x,y) con máscara.
// `sprite`: planes * h * wb bytes (planar). `mask`: máscara opcional por plano.
void draw_planar_sprite(PlanarBuffer& fb, const std::vector<u8>& sprite,
                        int sprite_wb, int sprite_h, int x, int y,
                        const std::vector<u8>* mask = nullptr);

}  // namespace rein

#endif  // REIN_BLOB_RENDER_HPP