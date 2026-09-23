// reimpl/motor_3d/src/test_transform3d.cpp
// Test host del motor 3D: verifica la semántica Q15 y las propiedades de la matriz.
//
// Compilar: make test

#include <cstdio>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <algorithm>
#include "transform3d.hpp"

using namespace rein;

static int g_fails = 0;
static void check(bool cond, const char* msg) {
    if (!cond) { std::printf("  FALLO: %s\n", msg); ++g_fails; }
    else       { std::printf("  ok:    %s\n", msg); }
}

// Ángulos Q15 desde radianes (para el test host).
static Angles angles_from_rad(double ax, double ay, double az) {
    Angles a;
    a.sin_a = (i16)std::lround(std::sin(ax) * 32767.0);
    a.cos_a = (i16)std::lround(std::cos(ax) * 32767.0);
    a.sin_b = (i16)std::lround(std::sin(ay) * 32767.0);
    a.cos_b = (i16)std::lround(std::cos(ay) * 32767.0);
    a.sin_c = (i16)std::lround(std::sin(az) * 32767.0);
    a.cos_c = (i16)std::lround(std::cos(az) * 32767.0);
    return a;
}

int main() {
    std::printf("== test_transform3d ==\n");

    // 1. q15_mul: 0.5 * 0.5 = 0.25 en Q15
    //    16384 (0.5) * 16384 (0.5) = 268435456 ; >>15 = 8192 (0.25)
    check(q15_mul(16384, 16384) == 8192, "q15_mul(0.5,0.5)=0.25");
    check(q15_mul(32767, 32767) == 32766, "q15_mul(~1,~1)~1");
    check(q15_mul(0, 12345) == 0, "q15_mul(0,*) = 0");

    // 2. Identidad (a=b=c=0): sin=0, cos=1 → matriz identidad (con error Q15 ~1)
    {
        Angles a{0, 0, 0, 32767, 32767, 32767};
        Mat3 M = build_rotation(a);
        auto near = [](i16 v, i16 ref) { return std::abs(v - ref) <= 2; };
        bool id = near(M.m[0], 32767) && near(M.m[4], 32767) && near(M.m[8], 32767) &&
                  near(M.m[1], 0) && near(M.m[2], 0) && near(M.m[3], 0) &&
                  near(M.m[5], 0) && near(M.m[6], 0) && near(M.m[7], 0);
        check(id, "angulos 0 -> matriz identidad (tol Q15)");
    }

    // 3. transform con identidad devuelve el punto
    {
        Mat3 I{32767, 0, 0, 0, 32767, 0, 0, 0, 32767};
        Vec3 p{1000, -2000, 3000};
        Vec3 o = transform(I, p);
        // Q15(32767*1000>>15) = Q15(1000*0.99997) ≈ 999 (error de redondeo Q15)
        check(std::abs(o.x - 1000) <= 2 && std::abs(o.y + 2000) <= 2 &&
              std::abs(o.z - 3000) <= 2, "identidad transforma ~sin cambio");
    }

    // 4. La matriz de rotación preserva la longitud (|R·p| ≈ |p|)
    {
        Angles a = angles_from_rad(0.6, -1.1, 2.3);
        Mat3 M = build_rotation(a);
        double det =
            (double)M.m[0] * (M.m[4] * M.m[8] - M.m[5] * M.m[7]) -
            (double)M.m[3] * (M.m[1] * M.m[8] - M.m[2] * M.m[7]) +
            (double)M.m[6] * (M.m[1] * M.m[5] - M.m[2] * M.m[4]);
        det /= (32767.0 * 32767.0 * 32767.0);  // desnormaliza Q15^3
        check(std::abs(det - 1.0) < 0.01, "det(R) ~ 1 (rotacion valida)");

        Vec3 p{8000, 4000, -6000};
        Vec3 o = transform(M, p);
        double lin = std::sqrt((double)p.x * p.x + (double)p.y * p.y + (double)p.z * p.z);
        double lout = std::sqrt((double)o.x * o.x + (double)o.y * o.y + (double)o.z * o.z);
        check(std::abs(lout - lin) / lin < 0.02, "rotacion preserva la longitud (<2%)");
    }

    // 5. Rotación pura en Y (a=c=0): m[0]=cos_b, m[6]=sin_b (column-major)
    {
        double b = 0.7;
        i16 sb = (i16)std::lround(std::sin(b) * 32767.0);
        i16 cb = (i16)std::lround(std::cos(b) * 32767.0);
        Angles a{0, sb, 0, 32767, cb, 32767};  // sin_a,sin_b,sin_c,cos_a,cos_b,cos_c
        Mat3 M = build_rotation(a);
        check(std::abs(M.m[6] - sb) <= 2, "rotacion Y: m[6]=sin_b");
        check(std::abs(M.m[0] - cb) <= 2, "rotacion Y: m[0]=cos_b");
    }

    // 6. isqrt32 (raíz entera usada por orthonormalize)
    check(isqrt32(0) == 0, "isqrt32(0)=0");
    check(isqrt32(1) == 1, "isqrt32(1)=1");
    check(isqrt32(15) == 3, "isqrt32(15)=3");
    check(isqrt32(16) == 4, "isqrt32(16)=4");
    check(isqrt32(1000000) == 1000, "isqrt32(1e6)=1000");

    // 7. orthonormalize: desde una rotación con error recupera una base ortonormal
    {
        Angles a = angles_from_rad(0.6, -1.1, 2.3);
        Mat3 M = build_rotation(a);
        M.m[0] = (i16)(M.m[0] + 900);   // simula drift acumulado
        M.m[4] = (i16)(M.m[4] - 1200);
        M.m[8] = (i16)(M.m[8] + 700);
        Mat3 N = orthonormalize(M);
        auto unit = [](i16 x, i16 y, i16 z) {
            double n = std::sqrt((double)x * x + (double)y * y + (double)z * z) / 32767.0;
            return std::abs(n - 1.0) < 0.02;
        };
        auto dot = [](i16 x0, i16 y0, i16 z0, i16 x1, i16 y1, i16 z1) {
            return std::abs((double)x0 * x1 + (double)y0 * y1 + (double)z0 * z1) /
                   (32767.0 * 32767.0);
        };
        check(unit(N.m[0], N.m[1], N.m[2]), "orthonormalize: fila0 unitaria");
        check(unit(N.m[3], N.m[4], N.m[5]), "orthonormalize: fila1 unitaria");
        check(unit(N.m[6], N.m[7], N.m[8]), "orthonormalize: fila2 unitaria");
        check(dot(N.m[0], N.m[1], N.m[2], N.m[3], N.m[4], N.m[5]) < 0.02,
              "orthonormalize: fila0·fila1 ~ 0");
        check(dot(N.m[0], N.m[1], N.m[2], N.m[6], N.m[7], N.m[8]) < 0.02,
              "orthonormalize: fila0·fila2 ~ 0");
        double det =
            (double)N.m[0] * (N.m[4] * N.m[8] - N.m[5] * N.m[7]) -
            (double)N.m[3] * (N.m[1] * N.m[8] - N.m[2] * N.m[7]) +
            (double)N.m[6] * (N.m[1] * N.m[5] - N.m[2] * N.m[4]);
        det /= (32767.0 * 32767.0 * 32767.0);
        check(std::abs(det - 1.0) < 0.03, "orthonormalize: det ~ 1");
    }

    // 8. orthonormalize es ~ idempotente sobre una rotación ya válida
    {
        Angles a = angles_from_rad(0.3, 0.8, -1.4);
        Mat3 M = build_rotation(a);
        Mat3 N = orthonormalize(M);
        int maxd = 0;
        for (int i = 0; i < 9; ++i)
            maxd = std::max(maxd, std::abs((int)N.m[i] - (int)M.m[i]));
        check(maxd <= 400, "orthonormalize ~ idempotente (delta pequeno)");
    }

    if (g_fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", g_fails);
    return 1;
}