#ifndef REIN_SCROLLTEXT_HPP
#define REIN_SCROLLTEXT_HPP

// reimpl/scrolltext — scrolltext con fuente de 3 planos de «Arte».
//
// Técnica recuperada (bloque 0x02162C, rutina 0x196E-0x1A70): una fuente bitmap
// de 3 planos; por cada carácter se busca en el mapa de chars, se localiza su
// glifo y se copian las 8 filas a los bitplanes de destino; el scroll horizontal
// avanza un offset por frame.
//
// Referencia C++: fuente de glifos 8×8 (1 byte/fila/plano) + buffer de texto +
// render + scroll.

#include <cstdint>
#include <string>
#include <vector>

namespace rein {

using u8 = std::uint8_t;

// Fuente de 3 planos: cada glifo es 8 filas × 1 byte, para 3 planos.
struct Font {
    int planes = 3;
    int glyph_w = 8;    // píxeles
    int glyph_h = 8;    // filas
    std::string chars;             // mapa: índice → carácter
    std::vector<u8> glyphs;        // glyphs[char_index][plane][row] (1 byte/fila)

    const u8* glyph(int ch, int plane) const {
        int ci = (int)chars.find((char)ch);
        if (ci < 0) return nullptr;
        return &glyphs[((std::size_t)ci * planes + plane) * glyph_h];
    }
};

// Fuente por defecto: mapa de chars de «Arte» (43 símbolos) y glifos 8×8
// generados (la fuente real del demo está en el módulo 0x02162C ~0x2800).
Font make_default_font();

// Dibuja `text` en el framebuffer planar, empezando en la columna `x0` (en píxeles).
// `scroll_px` = desplazamiento horizontal del scroll (en píxeles).
// El framebuffer es planar (planes × w_bytes × h).
struct PlanarFb {
    int w_bytes, h, planes;
    std::vector<u8> data;
    u8& at(int p, int y, int bx) { return data[((std::size_t)p * h + y) * w_bytes + bx]; }
};

void render_text(PlanarFb& fb, const Font& font, const std::string& text,
                 int x0, int scroll_px);

}  // namespace rein

#endif  // REIN_SCROLLTEXT_HPP