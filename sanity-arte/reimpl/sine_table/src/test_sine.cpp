// test_sine.cpp — test host de la tabla de seno (verifica valores conocidos y tolerancia).
#include "sine_table.hpp"
#include <cassert>
#include <cmath>
#include <cstdio>

int main() {
    using namespace rein;
    // 0 -> 0 ; 90deg (16384) -> +amp ; 180deg (32768) -> 0 ; 270deg (49152) -> -amp
    assert(sin_q14(0) == 0);
    assert(sin_q14(16384) == kSinAmp);
    assert(sin_q14(32768) == 0);
    assert(sin_q14(49152) == -kSinAmp);
    assert(cos_q14(0) == kSinAmp);
    // Rango en toda la fase, y tolerancia frente a std::sin en las fases EXACTAS de tabla
    // (la fase se cuantiza a 1024 pasos; en fases intermedias el error es el de esa
    //  cuantizacion, ~amplitud*2*pi/1024, aceptable para animacion).
    constexpr double kPi = 3.14159265358979323846;
    for (unsigned p = 0; p < 65536; p += 97) {
        const int s = sin_q14(p);
        assert(s >= -kSinAmp && s <= kSinAmp);
    }
    for (unsigned i = 0; i < kSinSize; ++i) {
        const unsigned p = i * (65536u / kSinSize);
        const double ref = std::sin(2.0 * kPi * i / kSinSize) * kSinAmp;
        assert(std::fabs(double(sin_q14(p)) - ref) <= 1.0);
    }
    std::printf("sine_table: OK\n");
    return 0;
}
