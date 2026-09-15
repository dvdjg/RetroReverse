// reimpl/motor_3d/src/transform3d.cpp
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

}  // namespace rein