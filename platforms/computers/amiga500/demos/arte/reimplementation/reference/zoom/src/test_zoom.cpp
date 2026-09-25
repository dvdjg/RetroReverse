// reimplementation/reference/zoom/src/test_zoom.cpp
// Test host del núcleo del zoom: Q16, paso de zoom, trayectoria y bandas de copper.
//
// Compilar: make test

#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include "zoom.hpp"

using namespace rein;

static int g_fails = 0;
static void check(bool cond, const char* msg) {
    if (!cond) { std::printf("  FALLO: %s\n", msg); ++g_fails; }
    else       { std::printf("  ok:    %s\n", msg); }
}

// Rellena una tabla de shorts big-endian; `val` da el valor de cada word.
template <typename F>
static void fill_be(u8* t, int nbytes, F val) {
    for (int w = 0; w * 2 + 1 < nbytes; ++w) {
        i16 v = val(w);
        t[w * 2] = (u8)((u16)v >> 8);
        t[w * 2 + 1] = (u8)((u16)v & 0xff);
    }
}

int main() {
    std::printf("== test_zoom ==\n");

    // 1. Q16: (v*c)>>16
    check(q16_mul(32767, 32767) == 16383, "q16_mul(~1,~1)=~0.5");
    check(q16_mul(32767, 220) == 109, "q16_mul(~1,0xDC)=109");
    check(q16_mul(0, 12345) == 0, "q16_mul(0,*)=0");

    u8 tab[0x400];
    fill_be(tab, sizeof(tab), [](int) { return (i16)0x4000; });  // 0x4000 en todas

    // 2. zoom_step: aún no ha empezado
    {
        ZoomState s; s.frame = 0x46c;
        check(zoom_step(s, tab) == 0 && s.idx == 0, "frame<=0x46c: sin efecto");
    }
    // 3. zoom_step: avanza idx +6 y calcula scale
    {
        ZoomState s; s.frame = 0x46d; s.idx = 0; s.base = 0;
        int blocks = zoom_step(s, tab);
        // q16_mul(0x4000,0xDC)=55 ; +0x11D=285 -> 340
        check(blocks == 4, "frame>0x46c: 4 bloques");
        check(s.idx == 6, "zoom: idx += 6");
        check(s.scale == 340, "zoom: scale = Q16(v*0xDC)+0x11D");
    }
    // 4. zoom_step: reinicio en frame 0x5cd
    {
        ZoomState s; s.frame = 0x5cd; s.idx = 0x60; s.base = 0;
        zoom_step(s, tab);
        check(s.base == 0xb4 && s.idx == 6, "frame 0x5cd: base=0xB4, idx reinicia");
        check(s.scale == 340, "zoom: scale con base=0xB4");
    }

    // Tablas de trayectoria (0x4000 en todas las entradas relevantes)
    u8 t3944[0x400], t38aa[0x400], t3a78[0x400];
    fill_be(t3944, sizeof(t3944), [](int) { return (i16)0x4000; });
    fill_be(t38aa, sizeof(t38aa), [](int) { return (i16)0x4000; });
    fill_be(t3a78, sizeof(t3a78), [](int) { return (i16)0x4000; });

    // 5. traj_step: coordenadas
    {
        TrajState s;
        bool ok = traj_step(s, t3944, t38aa, t3a78);
        // vx=Q16(0x4000*400)=100 -> z=30 ; vy=Q16(0x4000*900)=225 -> a=-170,b=-280
        // vz=Q16(0x4000*300)=75 -> x=130,y=20 ; c=z=30
        check(ok && s.active, "traj: activo");
        check(s.vx == 100 && s.z == 30, "traj: vx=100, z=30");
        check(s.a == -170 && s.b == -280, "traj: a=-170, b=-280");
        check(s.x == 130 && s.y == 20, "traj: x=130, y=20");
        check(s.c == 30, "traj: c=z=30");
        check(s.idx == 2 && s.idx2 == 6, "traj: idx+=2, idx2+=6");
    }
    // 6. traj_step: desactivada / wrap
    {
        TrajState s; s.idx = -1;
        check(traj_step(s, t3944, t38aa, t3a78) == false, "traj: idx=-1 -> inactivo");
    }
    {
        TrajState s; s.idx = 0x98; s.idx2 = 0;
        traj_step(s, t3944, t38aa, t3a78);
        check(s.idx == -1, "traj: idx 0x98+2=0x9A -> -1");
    }
    {
        TrajState s; s.idx = 0; s.idx2 = 0x1c8;
        traj_step(s, t3944, t38aa, t3a78);
        check(s.idx == -1, "traj: idx2 0x1C8+6=0x1CE -> idx=-1");
    }

    // 7. copper_bands: recorte vertical del zoom
    {
        TrajState s;
        traj_step(s, t3944, t38aa, t3a78);
        Bands b = copper_bands(s);
        // d=vx+0x1E=130 ; a=(130*-100)/130+0x80=28 ; b=(20*-100)/130+0x80=113
        check(b.valid, "bands: validas");
        check(b.n_before == 28, "bands: 28 lineas 0x200");
        check(b.n_5planes == 84, "bands: 84 lineas 0x5200 (5 planos)");
        check(b.n_after == 142, "bands: 142 lineas 0x200");
        check(b.n_before + b.n_5planes + b.n_after == 0xfe, "bands: suma = 0xFE");
    }

    if (g_fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", g_fails);
    return 1;
}
