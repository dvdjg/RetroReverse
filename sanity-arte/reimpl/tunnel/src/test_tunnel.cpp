// reimpl/tunnel/src/test_tunnel.cpp
// Test del túnel: carga los assets reales, renderiza el rango temporal del efecto
// y verifica estructura (tamaños, scripts, contenido) + vuelca frames para
// inspección visual. No hay checksums de referencia del original (confianza media
// en los parámetros), así que la validación fuerte es visual (ver README).
#include <cstdint>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <iterator>
#include <string>
#include <vector>
#include "tunnel.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

static std::vector<u8> load(const std::string& p) {
    std::ifstream f(p, std::ios::binary);
    return std::vector<u8>((std::istreambuf_iterator<char>(f)), {});
}

static std::uint32_t fnv1a(const std::vector<u8>& d) {
    std::uint32_t h = 2166136261u;
    for (u8 b : d) { h ^= b; h *= 16777619u; }
    return h;
}

int main(int argc, char** argv) {
    std::printf("== test_tunnel ==\n");
    std::string dir = argc > 1 ? argv[1] : "data";

    TunnelAssets assets;
    assets.bits = load(dir + "/tunnelBits.rgba");
    assets.wall = load(dir + "/tunnelWall.rgba");
    assets.hanger = load(dir + "/tunnelHanger.rgba");
    check(assets.bits.size() == 80 * 30 * 4, "textura tunnelBits 80x30 RGBA");
    check(assets.wall.size() == 128 * 64 * 4, "tunnelWall 128x64 RGBA");
    check(assets.hanger.size() == 160 * 30 * 4, "tunnelHanger 160x30 RGBA");

    TunnelOffsets off = tunnel_offsets();
    check(off.floorOff.size() == off.ceilingOff.size(), "floorScript y ceilingScript misma longitud");
    std::printf("  script de %zu posiciones\n", off.floorOff.size());

    // Antes del efecto (t<=0 de veer) y tras el fin, el buffer debe ser negro.
    auto before = render_tunnel(assets, off, 0.0);
    check(before.size() == (std::size_t)kTunnelWidth * kTunnelHeight * 4, "tamano de buffer");
    auto after = render_tunnel(assets, off, 40000.0);
    bool allZero = true;
    for (u8 b : after) if (b) { allZero = false; break; }
    check(allZero, "tras el fin del efecto (t>30720) el buffer es negro");

    // Render del rango temporal y volcado de frames.
    std::filesystem::create_directories("anim");
    const int N = 32;
    int nonEmpty = 0, distinct = 0;
    std::uint32_t prev = 0;
    for (int f = 0; f < N; ++f) {
        const double t = 1920.0 + f * 900.0;  // efecto visible (~2s..30s)
        auto fr = render_tunnel(assets, off, t);

        std::size_t nz = 0;
        for (std::size_t i = 0; i < fr.size(); i += 4)
            if (fr[i] | fr[i + 1] | fr[i + 2]) ++nz;
        if (nz > 1000) ++nonEmpty;

        std::uint32_t h = fnv1a(fr);
        if (f > 0 && h != prev) ++distinct;
        prev = h;

        char path[64];
        std::snprintf(path, sizeof(path), "anim/frame%04d.raw", f);
        std::ofstream(path, std::ios::binary).write((const char*)fr.data(), (std::streamsize)fr.size());
    }
    std::printf("  frames con contenido: %d/%d; frames distintos: %d/%d\n", nonEmpty, N, distinct, N - 1);
    check(nonEmpty == N, "todos los frames del rango tienen contenido");
    check(distinct >= N - 2, "los frames cambian con el tiempo (avance del tunel)");

    // Frames con overlay (pared del fondo / colgantes del techo) para inspeccion visual.
    const double ovc[] = {17000.0, 22000.0, 27000.0, 30000.0, 30600.0};
    for (int i = 0; i < 5; ++i) {
        auto fr = render_tunnel(assets, off, ovc[i]);
        char path[64];
        std::snprintf(path, sizeof(path), "anim/overlay%02d.raw", i);
        std::ofstream(path, std::ios::binary).write((const char*)fr.data(), (std::streamsize)fr.size());
    }
    std::printf("  overlay: 5 frames (pared/colgantes) -> anim/overlay*.raw\n");

    // --- Variante con la PALETA REAL de Arte (palette swap de los assets) ---
    TunnelAssets arte;
    arte.bits = load(dir + "/tunnelBits-arte.rgba");
    arte.wall = load(dir + "/tunnelWall-arte.rgba");
    arte.hanger = load(dir + "/tunnelHanger-arte.rgba");
    check(arte.bits.size() == 80 * 30 * 4 && arte.wall.size() == 128 * 64 * 4 &&
              arte.hanger.size() == 160 * 30 * 4,
          "assets con paleta de Arte cargados");
    std::filesystem::create_directories("anim_arte");
    for (int f = 0; f < N; ++f) {
        auto fr = render_tunnel(arte, off, 1920.0 + f * 900.0);
        char path[64];
        std::snprintf(path, sizeof(path), "anim_arte/frame%04d.raw", f);
        std::ofstream(path, std::ios::binary).write((const char*)fr.data(), (std::streamsize)fr.size());
    }
    for (int i = 0; i < 5; ++i) {
        auto fr = render_tunnel(arte, off, ovc[i]);
        char path[64];
        std::snprintf(path, sizeof(path), "anim_arte/overlay%02d.raw", i);
        std::ofstream(path, std::ios::binary).write((const char*)fr.data(), (std::streamsize)fr.size());
    }
    std::printf("  variante paleta de Arte: 32+5 frames -> anim_arte/*.raw\n");


    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}
