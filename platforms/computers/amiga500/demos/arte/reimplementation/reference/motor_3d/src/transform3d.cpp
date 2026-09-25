// reimplementation/reference/motor_3d/src/transform3d.cpp
// Implementación de referencia en C++ del motor 3D de «Arte».
//
// Cada fórmula replica literalmente una secuencia del desensamblado del bloque
// 0x0B0C2C (ver reference/transform3d_q15_amiga.asm). Los Q15 intermedios se
// mantienen donde el asm los hace (muls.w de una word Q15 ya calculada).

#include "transform3d.hpp"

namespace rein {

// --- construcción de la matriz (asm 0x0C16-0x0CB8) ---
//
// Entradas: sa,sb,sc = senos de los 3 ángulos; ca,cb,cc = cosenos.
// Salidas m[0..8] (column-major de R = Rx(a)·Ry(b)·Rz(c)).
Mat3 build_rotation(const Angles& ang) {
    const i16 sa = ang.sin_a, sb = ang.sin_b, sc = ang.sin_c;
    const i16 ca = ang.cos_a, cb = ang.cos_b, cc = ang.cos_c;
    Mat3 M;

    // m[0] = Q15(cb*cc)                          ; 0xC44-0xC4C
    M.m[0] = q15_mul(cb, cc);

    // m[1] = Q15( sa*Q15(sb*cc) + ca*sc )        ; 0xC4E-0xC64
    {
        i16 t = q15_mul(sb, cc);                 // a1
        i32 acc = static_cast<i32>(sa) * t + static_cast<i32>(ca) * sc;
        M.m[1] = static_cast<i16>((acc * 2) >> 16);
    }

    // m[2] = Q15( sa*sc - ca*Q15(sb*cc) )        ; 0xC66-0xC74
    {
        i16 t = q15_mul(sb, cc);                 // a1
        i32 acc = static_cast<i32>(sa) * sc - static_cast<i32>(ca) * t;
        M.m[2] = static_cast<i16>((acc * 2) >> 16);
    }

    // m[3] = Q15(-cb*sc)                          ; 0xC76-0xC80
    M.m[3] = q15_mul(static_cast<i16>(-cb), sc);

    // m[4] = Q15( ca*cc - sa*Q15(sb*sc) )        ; 0xC82-0xC96
    {
        i16 t = q15_mul(sb, sc);                 // d2 = Q15(sb*sc)
        i32 acc = static_cast<i32>(ca) * cc - static_cast<i32>(sa) * t;
        M.m[4] = static_cast<i16>((acc * 2) >> 16);
    }

    // m[5] = Q15( ca*Q15(sb*sc) + sa*cc )        ; 0xC98-0xCA2
    {
        i16 t = q15_mul(sb, sc);                 // d7 = Q15(sb*sc)
        i32 acc = static_cast<i32>(ca) * t + static_cast<i32>(sa) * cc;
        M.m[5] = static_cast<i16>((acc * 2) >> 16);
    }

    // m[6] = sb                                   ; 0xCA4 (sin_b directo)
    M.m[6] = sb;

    // m[7] = Q15(-cb*sa)                          ; 0xCA6-0xCAE
    M.m[7] = q15_mul(static_cast<i16>(-cb), sa);

    // m[8] = Q15(cb*ca)                           ; 0xCB0-0xCB6
    M.m[8] = q15_mul(cb, ca);

    return M;
}

// --- transformación de un punto (asm 0x0CBA-0x0D58) ---
Vec3 transform(const Mat3& M, const Vec3& p) {
    const i32 x = p.x, y = p.y, z = p.z;
    Vec3 o;
    // X' = Q15( m[0]*x + m[3]*y + m[6]*z )  (suma en 32 bits, un solo shift)
    o.x = static_cast<i16>((((M.m[0] * x + M.m[3] * y + M.m[6] * z) * 2) >> 16));
    // Y' = Q15( m[1]*x + m[4]*y + m[7]*z )
    o.y = static_cast<i16>((((M.m[1] * x + M.m[4] * y + M.m[7] * z) * 2) >> 16));
    // Z' = Q15( m[2]*x + m[5]*y + m[8]*z )
    o.z = static_cast<i16>((((M.m[2] * x + M.m[5] * y + M.m[8] * z) * 2) >> 16));
    return o;
}

// --- ortonormalización (asm 0x0E1E + raíz 0x0F1C) ---
//
// El asm calcula los productos Q15 con `muls.w + sub.l + add.l d,d + swap` y normaliza
// con `divs.w` (división 32/16 con signo). Reproducimos ambas cosas literalmente.

namespace {
// Q15(a*b - c*d) = (a*b - c*d) >> 15  (fiel a `sub.l` + `add.l d,d` + `swap`).
inline i16 q15_mulsub(i16 a, i16 b, i16 c, i16 d) {
    i32 p = static_cast<i32>(a) * b - static_cast<i32>(c) * d;
    return static_cast<i16>(p >> 15);
}
// (x * 32767) / mag  con división con signo (fiel a `divs.w`; 0x0E8E-0x0EB2).
inline i16 div_q15(i16 x, u16 mag) {
    if (mag == 0) return 0;
    return static_cast<i16>((static_cast<i32>(x) * 32767) / static_cast<i32>(mag));
}
}  // namespace

std::uint16_t isqrt32(std::uint32_t n) {
    std::uint32_t res = 0, bit = 1u << 30;
    while (bit) {
        std::uint32_t t = res + bit;
        res >>= 1;
        if (n >= t) { n -= t; res += bit; }
        bit >>= 2;
    }
    return static_cast<std::uint16_t>(res);
}

Mat3 orthonormalize(const Mat3& M) {
    i16 a[9];
    for (int i = 0; i < 9; ++i) a[i] = M.m[i];

    // fila0 = fila1 × fila2  (en sitio)
    a[0] = q15_mulsub(a[4], a[8], a[5], a[7]);
    a[1] = q15_mulsub(a[5], a[6], a[3], a[8]);
    a[2] = q15_mulsub(a[3], a[7], a[4], a[6]);
    // fila1 = fila2 × fila0
    a[3] = q15_mulsub(a[7], a[2], a[8], a[1]);
    a[4] = q15_mulsub(a[0], a[8], a[6], a[2]);
    a[5] = q15_mulsub(a[6], a[1], a[7], a[0]);

    Mat3 N{};
    u16 m0 = isqrt32(static_cast<u32>(static_cast<i32>(a[0]) * a[0] +
                                      static_cast<i32>(a[1]) * a[1] +
                                      static_cast<i32>(a[2]) * a[2]));
    u16 m1 = isqrt32(static_cast<u32>(static_cast<i32>(a[3]) * a[3] +
                                      static_cast<i32>(a[4]) * a[4] +
                                      static_cast<i32>(a[5]) * a[5]));
    N.m[0] = div_q15(a[0], m0);
    N.m[1] = div_q15(a[1], m0);
    N.m[2] = div_q15(a[2], m0);
    N.m[3] = div_q15(a[3], m1);
    N.m[4] = div_q15(a[4], m1);
    N.m[5] = div_q15(a[5], m1);
    // fila2 = fila0' × fila1'
    N.m[6] = q15_mulsub(N.m[1], N.m[5], N.m[2], N.m[4]);
    N.m[7] = q15_mulsub(N.m[3], N.m[2], N.m[0], N.m[5]);
    N.m[8] = q15_mulsub(N.m[0], N.m[4], N.m[1], N.m[3]);
    return N;
}

}  // namespace rein