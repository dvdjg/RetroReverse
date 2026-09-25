// gen_sine.cpp â€” genera la tabla de seno Q1.14 (1024 entradas).
// Uso: g++ -O2 -std=c++17 -o gen_sine gen_sine.cpp && ./gen_sine src/sine_table_data.hpp
//      (sin argumento escribe por stdout)
#include <cmath>
#include <cstdint>
#include <cstdio>

int main(int argc, char **argv) {
    constexpr unsigned kSize = 1024;
    constexpr double kAmp = 16384.0;
    constexpr double kPi = 3.14159265358979323846;

    std::FILE *f = stdout;
    if (argc > 1) {
        f = std::fopen(argv[1], "wb");
        if (!f) { std::perror("fopen"); return 1; }
    }
    std::fprintf(f, "// GENERADO por gen_sine.cpp. No editar a mano.\n");
    std::fprintf(f, "// Se incluye dentro de namespace rein desde sine_table.hpp.\n");
    std::fprintf(f, "inline constexpr std::int16_t kSinTable[%u] = {\n", kSize);
    for (unsigned i = 0; i < kSize; ++i) {
        const double v = std::sin(2.0 * kPi * i / kSize) * kAmp;
        const long r = std::lround(v);
        std::fprintf(f, "    %ld,", r);
        if ((i & 7) == 7) std::fprintf(f, "\n");
    }
    std::fprintf(f, "\n};\n");
    if (f != stdout) std::fclose(f);
    return 0;
}
