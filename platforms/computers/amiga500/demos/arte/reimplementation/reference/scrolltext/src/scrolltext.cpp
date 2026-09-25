// reimplementation/reference/scrolltext/src/scrolltext.cpp
#include "scrolltext.hpp"

namespace rein {

// Fuente por defecto: mapa de 43 chars de «Arte» (el real del demo, extraído del
// módulo 0x02162C) con glifos 8×8 generados (la fuente real está en el módulo).
Font make_default_font() {
    Font f;
    f.planes = 3;
    f.glyph_w = 8;
    f.glyph_h = 8;
    f.chars = " abcdefghijklmnopqrstuvwxyz0123456789.,!?:-";
    int n = (int)f.chars.size();
    f.glyphs.assign((std::size_t)n * f.planes * f.glyph_h, 0);
    const u8 rows[8] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    for (int ci = 0; ci < n; ci++) {
        char c = f.chars[ci];
        if (c == ' ') continue;  // espacio = vacío
        // glifo sintético legible: marco de 3×3 con el código del char (referencia)
        for (int row = 0; row < 8; row++) {
            u8 v = 0;
            if (row == 0 || row == 7) v = 0x7E;
            else if (row >= 2 && row <= 5) v = 0x42;
            f.glyphs[((std::size_t)ci * f.planes + 0) * f.glyph_h + row] = v;
            f.glyphs[((std::size_t)ci * f.planes + 1) * f.glyph_h + row] =
                (u8)((c + row) & 0xFF);
            f.glyphs[((std::size_t)ci * f.planes + 2) * f.glyph_h + row] = (u8)(v ^ 0x3C);
        }
    }
    (void)rows;
    return f;
}

void render_text(PlanarFb& fb, const Font& font, const std::string& text,
                 int x0, int scroll_px) {
    int pen = x0 - scroll_px;
    for (char c : text) {
        const u8* g[3];
        for (int p = 0; p < font.planes; p++) g[p] = font.glyph((unsigned char)c, p);
        if (!g[0]) { pen += font.glyph_w; continue; }
        for (int row = 0; row < font.glyph_h; row++) {
            int y = row;
            if (y < 0 || y >= fb.h) continue;
            for (int p = 0; p < font.planes; p++) {
                u8 bits = g[p][row];
                for (int bit = 0; bit < font.glyph_w; bit++) {
                    if (!(bits & (0x80 >> bit))) continue;
                    int px = pen + bit;
                    int bx = px >> 3;
                    if (px < 0 || bx >= fb.w_bytes) continue;
                    fb.at(p, y, bx) |= (u8)(0x80 >> (px & 7));
                }
            }
        }
        pen += font.glyph_w;
    }
}

}  // namespace rein