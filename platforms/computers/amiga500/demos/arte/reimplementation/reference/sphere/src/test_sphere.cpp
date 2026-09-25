// reimplementation/reference/sphere/src/test_sphere.cpp
// Test de la esfera: genera el mapa, renderiza y verifica el FNV-1a contra los
// checksums de referencia (data/reference-checksums.txt). Escribe un frame .raw.
#include <cstdio>
#include <cstdint>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>
#include "sphere.hpp"
#include "motion.hpp"

using namespace rein;
static int fails = 0;
static void check(bool c, const char* m) {
    if (!c) { std::printf("  FALLO: %s\n", m); ++fails; }
    else std::printf("  ok:    %s\n", m);
}

static std::uint32_t fnv1a(const std::vector<u8>& d) {
    std::uint32_t h = 2166136261u;
    for (u8 b : d) { h ^= b; h *= 16777619u; }
    return h;
}

int main(int argc, char** argv) {
    std::printf("== test_sphere ==\n");
    std::string dir = argc > 1 ? argv[1] : "data";

    // cargar textura
    std::ifstream tf(dir + "/texture-256x256-4bit.bin", std::ios::binary);
    if (!tf) { std::printf("no se pudo abrir la textura en %s\n", dir.c_str()); return 2; }
    std::vector<u8> tex((std::istreambuf_iterator<char>(tf)), {});
    check(tex.size() == 65536, "textura de 65536 bytes");

    // generar mapa
    std::vector<u8> map = generate_sphere_map();
    check(map.size() == 90 * 96 * 2, "mapa de 90*96 words");

    // Render rotation=0 y FNV-1a
    auto f0 = sphere_render(tex, map, 0x0000);
    check(f0.size() == 192 * 90, "frame de 192x90");
    std::uint32_t h0 = fnv1a(f0);
    std::printf("  rotation 0000 -> fnv1a %08x (esperado d73572b1)\n", h0);
    check(h0 == 0xd73572b1u, "rotation 0x0000 coincide con el checksum");

    // Otra rotación conocida: 0x0119 -> de4efa35
    auto f1 = sphere_render(tex, map, 0x0119);
    std::uint32_t h1 = fnv1a(f1);
    std::printf("  rotation 0119 -> fnv1a %08x (esperado de4efa35)\n", h1);
    check(h1 == 0xde4efa35u, "rotation 0x0119 coincide con el checksum");

    // Otra: 0x0232 -> e3a4c201
    auto f2 = sphere_render(tex, map, 0x0232);
    std::uint32_t h2 = fnv1a(f2);
    std::printf("  rotation 0232 -> fnv1a %08x (esperado e3a4c201)\n", h2);
    check(h2 == 0xe3a4c201u, "rotation 0x0232 coincide con el checksum");

    // Verificacion EXHAUSTIVA: todas las rotaciones del manifest (263).
    {
        std::ifstream mf(dir + "/reference-checksums.txt");
        int total = 0, ok = 0;
        std::string line;
        while (std::getline(mf, line)) {
            if (line.empty() || line[0] == '#') continue;
            unsigned rot, exp;
            if (std::sscanf(line.c_str(), "%x %x", &rot, &exp) != 2) continue;
            auto fr = sphere_render(tex, map, (u16)rot);
            if (fnv1a(fr) == exp) ok++;
            total++;
        }
        std::printf("  manifest: %d/%d rotaciones coinciden\n", ok, total);
        check(total > 0 && ok == total, "todas las rotaciones del manifest coinciden");
    }

    // Volcar un frame raw (192x90 indices) para inspeccion visual.
    std::ofstream out("sphere_frame_d4936.raw", std::ios::binary);
    auto f3 = sphere_render(tex, map, 0x4936);
    out.write((const char*)f3.data(), f3.size());
    std::printf("  frame 0x4936 -> sphere_frame_d4936.raw\n");

    // Animacion: N frames con el movimiento (2 steps por frame = 25 fps de 50 Hz).
    {
        int n = 64;
        std::filesystem::create_directories("anim");
        Motion m;
        std::uint16_t first = m.rotation(), last = first;
        for (int f = 0; f < n; f++) {
            std::uint16_t rot = m.rotation();
            last = rot;
            auto fr = sphere_render(tex, map, rot);
            char path[64];
            std::snprintf(path, sizeof(path), "anim/frame%04d.raw", f);
            std::ofstream of(path, std::ios::binary);
            of.write((const char*)fr.data(), fr.size());
            m.step();
            m.step();  // 2 steps: la demo renderiza a 25 fps desde 50 Hz
        }
        std::printf("  animacion: %d frames -> anim/ (rot %04x .. %04x)\n", n, first, last);
        check(first != last, "la rotacion cambia con el movimiento (tumble)");
    }

    if (fails == 0) { std::printf("\nTODOS LOS TESTS OK\n"); return 0; }
    std::printf("\n%d TEST(S) FALLARON\n", fails);
    return 1;
}