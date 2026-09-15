// reimpl/motor_3d/src/test_transform3d.cpp
// Test host del motor 3D: verifica la semántica Q15 y las propiedades de la matriz.
//
// Compilar: make test

#include <cstdio>
#include <cmath>
#include <cstdint>
#include <cstdlib>
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

    if (g_fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", g_fails);
    return 1;
}