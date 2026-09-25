// reimplementation/reference/blob_render/src/test_blob_render.cpp
#include <cstdio>
#include <cstdlib>
#include "blob_render.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

int main() {
    std::printf("== test_blob_render ==\n");

    // 1. expand4: cada bit -> 2 bits
    check(expand4(0b0000) == 0b00000000, "expand4(0)=0");
    check(expand4(0b0001) == 0b00000011, "expand4(1)=0011");
    check(expand4(0b1000) == 0b11000000, "expand4(8)=11000000");
    check(expand4(0b1010) == 0b11001100, "expand4(1010)=11001100");
    check(expand4(0b1111) == 0b11111111, "expand4(15)=11111111");

    // 2. LUT coincide con expand4
    ExpandLut lut;
    bool lut_ok = true;
    for (int i = 0; i < 16; i++) if (lut.v[i] != expand4((u8)i)) lut_ok = false;
    check(lut_ok, "LUT coincide con expand4");

    // 3. Dibujo planar: sprite 2 planos 1 byte x 1 linea en (0,0)
    {
        PlanarBuffer fb{2, 1, 2, {}};
        fb.data.assign(2 * 1 * 2, 0);
        // sprite: plano0=0xF0, plano1=0x0F
        std::vector<u8> spr = {0xF0, 0x0F};
        draw_planar_sprite(fb, spr, 1, 1, 0, 0);
        check(fb.at(0, 0, 0) == 0xF0, "plano0 escrito");
        check(fb.at(1, 0, 0) == 0x0F, "plano1 escrito");
    }

    // 4. Dibujo con máscara: solo sobreescribe donde mask=1
    {
        PlanarBuffer fb{1, 1, 1, {}};
        fb.data.assign(1, 0xFF);          // fondo 0xFF
        std::vector<u8> spr = {0x00};
        std::vector<u8> msk = {0x0F};     // solo nibble bajo
        draw_planar_sprite(fb, spr, 1, 1, 0, 0, &msk);
        // dest = (0xFF & ~0x0F) | (0x00 & 0x0F) = 0xF0
        check(fb.at(0, 0, 0) == 0xF0, "mascara: borra solo donde mask=1");
    }

    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}