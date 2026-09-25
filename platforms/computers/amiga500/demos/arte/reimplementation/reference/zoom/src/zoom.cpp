// reimplementation/reference/zoom/src/zoom.cpp — núcleo del efecto de zoom de «Arte».
//
// Réplica literal del decompilado de Ghidra (extraction/ghidra/blk_07E42C_l1_20268.decomp.c)
// y del desensamblado canónico. Cada constante es la del original.

#include "zoom.hpp"

namespace rein {

// FUN_0000024c (0x24C).
int zoom_step(ZoomState& s, const u8* t) {
    if (!(s.frame > 0x46c)) {
        return 0;
    }
    if (s.frame == 0x5cd) {  // reinicio de la tabla de factores
        s.base = 0xb4;
        s.idx = 0;
    }
    i16 i = s.idx;
    if (s.idx < 0xb5) {
        s.idx = static_cast<i16>(s.idx + 6);
    }
    // scale = Q16(tabla[$3EE2 + base + idx] * 0xDC) + 0x11D
    s.scale = static_cast<i16>(q16_mul(rd_be16(t + s.base + i), 0xdc) + 0x11d);
    return 4;  // 4 iteraciones del dibujo de bloque (FUN_0000193e)
}

// FUN_000002d4 (0x2D4).
bool traj_step(TrajState& s, const u8* t3944, const u8* t38aa, const u8* t3a78) {
    if (s.idx == -1) {
        s.active = false;
        return false;
    }
    // $418 = Q16(tabla[$3944 + $238] * 400) - 0x46
    s.vx = q16_mul(rd_be16(t3944 + s.idx), 400);
    s.z = static_cast<i16>(s.vx - 0x46);

    i16 i = s.idx;
    s.idx = static_cast<i16>(s.idx + 2);
    if (s.idx == 0x9a) {
        s.idx = -1;
    }
    // $41C = Q16(tabla[$38AA + i] * 900) - 0x18B ; $420 = ... - 0x1F9
    i16 vy = q16_mul(rd_be16(t38aa + i), 900);
    s.a = static_cast<i16>(vy - 0x18b);
    s.b = static_cast<i16>(vy - 0x1f9);

    i16 j = s.idx2;
    s.idx2 = static_cast<i16>(s.idx2 + 6);
    if (s.idx2 == 0x1ce) {
        s.idx = -1;
    }
    // $416 = Q16(tabla[$3A78 + j] * 300) + 0x37 ; $41A = ... - 0x37
    i16 vz = q16_mul(rd_be16(t3a78 + j), 300);
    s.x = static_cast<i16>(vz + 0x37);
    s.y = static_cast<i16>(vz - 0x37);

    s.c = s.z;  // $41E = $418
    s.active = true;
    return true;
}

// Bandas de BPLCON0 calculadas por FUN_000002d4 (0x2D4-0x360).
Bands copper_bands(const TrajState& s) {
    Bands r;
    if (!s.active || !(s.z > -100)) {
        return r;
    }
    i32 d = static_cast<i32>(s.vx) + 0x1e;
    if (d == 0) {
        return r;
    }
    i32 a = (static_cast<i32>(s.x) * -100) / d + 0x80;
    i32 b = (static_cast<i32>(s.y) * -100) / d + 0x80;
    if (!(b > 0 && a < 0xff)) {
        return r;
    }
    if (a < 0) a = 0;
    if (b > 0xff) b = 0xff;
    r.n_before = static_cast<int>(a);
    r.n_5planes = static_cast<int>(b - a - 1);
    r.n_after = static_cast<int>(0xff - b);
    r.valid = true;
    return r;
}

}  // namespace rein
