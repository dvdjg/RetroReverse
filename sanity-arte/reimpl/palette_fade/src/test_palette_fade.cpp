// reimpl/palette_fade/src/test_palette_fade.cpp
#include <cstdio>
#include <vector>
#include "palette_fade.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

int main() {
    std::printf("== test_palette_fade ==\n");

    // Fade de negro (0x000) a blanco (0xFFF): cada paso sube 1 en cada nibble
    {
        std::vector<u16> cur = {0x000};
        std::vector<u16> dst = {0xFFF};
        fade_palette_step(cur, dst);
        check(cur[0] == 0x111, "paso 1: 0x000 -> 0x111");
        fade_palette(cur, dst);
        check(cur[0] == 0xFFF, "fade completo a 0xFFF");
    }

    // Fade a la baja: de 0xFFF a 0x000
    {
        std::vector<u16> cur = {0xFFF};
        std::vector<u16> dst = {0x000};
        fade_palette_step(cur, dst);
        check(cur[0] == 0xEEE, "paso 1 a la baja: 0xFFF -> 0xEEE");
    }

    // Componentes independientes: R=0xF00, G=0x000, B=0x00F
    {
        std::vector<u16> cur = {0x000};
        std::vector<u16> dst = {0xF0F};
        fade_palette_step(cur, dst);
        check(cur[0] == 0x101, "R y B suben, G no: 0x101");
    }

    // Multi-color y convergencia
    {
        std::vector<u16> cur = {0x000, 0xFFF, 0x800};
        std::vector<u16> dst = {0xFF0, 0x00F, 0x800};
        fade_palette(cur, dst);
        check(cur[0] == 0xFF0 && cur[1] == 0x00F && cur[2] == 0x800,
              "multi-color converge al destino");
    }

    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}