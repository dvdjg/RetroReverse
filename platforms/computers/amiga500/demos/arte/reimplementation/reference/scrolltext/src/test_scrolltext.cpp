// reimplementation/reference/scrolltext/src/test_scrolltext.cpp
#include <cstdio>
#include "scrolltext.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

int main() {
    std::printf("== test_scrolltext ==\n");

    Font f = make_default_font();
    check(f.chars.size() == 43, "mapa de 43 caracteres (real de Arte)");
    check(f.chars[0] == ' ' && f.chars[1] == 'a', "mapa empieza con espacio, a");
    check(f.glyph('a', 0) != nullptr, "glifo de 'a' existe");
    check(f.glyph('Z', 0) == nullptr, "glifo de 'Z' no existe (fuente sin mayusculas)");

    // Render de "a" en un framebuffer planar 1 plano... (usamos 3 planos, 8x8)
    PlanarFb fb{1, 8, 3, {}};
    fb.data.assign(3 * 8 * 1, 0);
    render_text(fb, f, "a", 0, 0);
    // El glifo del plano 0 es un marco: fila 0 = 0x7E
    check(fb.at(0, 0, 0) == 0x7E, "render 'a': fila 0 del plano 0");

    // Scroll: con scroll_px=8, la 'a' (pos 0) sale de pantalla y no se dibuja
    {
        PlanarFb fb2{1, 8, 3, {}};
        fb2.data.assign(3 * 8 * 1, 0);
        render_text(fb2, f, "a", 0, 8);  // desplazado 8 px a la izquierda
        check(fb2.at(0, 0, 0) == 0x00, "scroll 8px: 'a' fuera de pantalla");
    }

    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}