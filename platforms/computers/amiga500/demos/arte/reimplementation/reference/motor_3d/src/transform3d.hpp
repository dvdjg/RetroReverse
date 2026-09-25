#ifndef REIN_MOTOR_3D_TRANSFORM3D_HPP
#define REIN_MOTOR_3D_TRANSFORM3D_HPP

// reimplementation/reference/motor_3d — motor de transformación 3D de «Arte» (Sanity, 1993).
//
// Recreación en C++ de la técnica del motor 3D recuperada por ingeniería inversa
// (bloque 0x0B0C2C, rutinas 0x0C16-0x0CB8 y 0x0CBA-0x0D58 del bloque).
//
// SEMÁNTICA Q15 (fiel al 68k):
//   El 68k calcula los productos con `muls.w` (producto 32-bit de dos int16),
//   acumula en 32 bits y hace `add.l d,d ; swap d` = (2*p)>>16 = p>>15.
//   Aquí: q15_mul(a,b) = (int32)a*b >> 15, y las sumas de productos se acumulan
//   en 32 bits ANTES del desplazamiento (un solo >>15), igual que el asm.
//
// La matriz R = Rx(a)·Ry(b)·Rz(c) se guarda en **column-major** (como el demo):
//   m[0]=R00 m[1]=R10 m[2]=R20   (columna 0)
//   m[3]=R01 m[4]=R11 m[5]=R21   (columna 1)
//   m[6]=R02 m[7]=R12 m[8]=R22   (columna 2)
// y transform() aplica R·p:
//   X' = m[0]*x + m[3]*y + m[6]*z
//   Y' = m[1]*x + m[4]*y + m[7]*z
//   Z' = m[2]*x + m[5]*y + m[8]*z

#include <cstdint>

namespace rein {

using i16 = std::int16_t;
using i32 = std::int32_t;
using u16 = std::uint16_t;
using u32 = std::uint32_t;

struct Mat3 { i16 m[9]; };
struct Vec3 { i16 x, y, z; };
struct Angles { i16 sin_a, sin_b, sin_c, cos_a, cos_b, cos_c; };

// Multiplicación Q15 de dos int16 → int16.  Equivale a:
//   muls.w a,b ; add.l b,b ; swap b
static inline i16 q15_mul(i16 a, i16 b) {
    return static_cast<i16>((static_cast<i32>(a) * static_cast<i32>(b)) >> 15);
}

// Construye la matriz de rotación a partir de los senos/cosenos (Q15) de los 3
// ángulos (a=X, b=Y, c=Z). Fiel a las 9 fórmulas del asm (0x0C44-0x0CB8).
Mat3 build_rotation(const Angles& ang);

// Transforma el punto p por la matriz M (R·p) en Q15 (fiel a 0x0CBA-0x0D58).
Vec3 transform(const Mat3& M, const Vec3& p);

// Ortonormaliza la matriz por cross-product (fiel a 0x0E1E + la raíz 0x0F1C).
// Es el "camera system": recompone una base ortonormal a partir de M para evitar el
// *drift* acumulado al multiplicar rotaciones. Los tripletes [0..2],[3..5],[6..8] se
// tratan como filas (así lo hace el asm):
//   fila0 = fila1 × fila2 ; fila1 = fila2 × fila0 ; fila2 = fila0' × fila1'
// con cada fila normalizada a Q15 mediante (x*32767)/|fila|.
Mat3 orthonormalize(const Mat3& M);

// Raíz cuadrada entera (floor) usada por orthonormalize (fiel al bucle de 0x0F1C).
std::uint16_t isqrt32(std::uint32_t n);

}  // namespace rein

#endif  // REIN_MOTOR_3D_TRANSFORM3D_HPP