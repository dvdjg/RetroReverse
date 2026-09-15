// reimpl/sine_wobble/src/test_sine_wobble.cpp
#include <cstdio>
#include <cstdint>
#include "sine_wobble.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

int main() {
    std::printf("== test_sine_wobble ==\n");

    // Tabla de seno Q15
    check(kWobbleSin[0] == 0, "sin[0]=0");
    check(kWobbleSin[64] == 32767, "sin[1/4]=32767");
    check(kWobbleSin[128] == 0, "sin[1/2]=0");
    check(kWobbleSin[192] == -32767, "sin[3/4]=-32767");

    // 8 osciladores con las velocidades del asm
    Wobble w;
    bool speeds = (Wobble::kSpeed[0] == 10 && Wobble::kSpeed[2] == 0x48 &&
                   Wobble::kSpeed[3] == 0x52);
    check(speeds, "velocidades de los 8 osciladores");
    w.step();
    check(w.phase[0] == 10 && w.phase[1] == 4, "tras 1 frame, fases avanzan");

    // Distorsión: con wobble a 0 (offset 0) la imagen no cambia
    {
        const int w2 = 8, h2 = 4;
        std::uint8_t src[w2 * h2], dst[w2 * h2];
        for (int i = 0; i < w2 * h2; i++) src[i] = (std::uint8_t)i;
        Wobble wb0; wb0.phase[0] = 0;  // sin(0)=0 en todos -> offset 0
        // forzar todas las fases a 0 para offset 0
        for (int i = 0; i < 8; i++) wb0.phase[i] = 0;
        distort_rows(src, dst, w2, h2, wb0, 0);
        bool same = true;
        for (int i = 0; i < w2 * h2; i++) if (dst[i] != src[i]) same = false;
        check(same, "offset 0 -> imagen sin cambios");
    }

    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}