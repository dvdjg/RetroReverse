// Driver headless de libRetroReversing (sin UI web): usa el canal `rr_re_command`
// del core instrumentado para play/pause/save_state y exportar CDL/disassembly.
// Uso: re_drive --core <core.so> --rom <rom> --out <dir> [--frames N]
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <string>

#include <unistd.h>

#include "libretro_adapter.hpp"

using namespace rr;

int main(int argc, char** argv) {
    std::string core, rom, out;
    int frames = 600;
    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        auto next = [&]() { return (i + 1 < argc) ? std::string(argv[++i]) : std::string(); };
        if (a == "--core") core = next();
        else if (a == "--rom") rom = next();
        else if (a == "--out") out = next();
        else if (a == "--frames") frames = std::atoi(next().c_str());
        else { std::fprintf(stderr, "opción desconocida: %s\n", a.c_str()); return 2; }
    }
    if (core.empty() || rom.empty() || out.empty()) {
        std::fprintf(stderr, "uso: re_drive --core <core.so> --rom <rom> --out <dir> [--frames N]\n");
        return 2;
    }
    // Absolutizar antes de cambiar de directorio (el RE escribe en ./RE_projects).
    core = std::filesystem::absolute(core).string();
    rom = std::filesystem::absolute(rom).string();
    out = std::filesystem::absolute(out).string();
    std::filesystem::create_directories(out);
    if (chdir(out.c_str()) != 0) { std::fprintf(stderr, "no puedo entrar en %s\n", out.c_str()); return 2; }

    try {
        LibretroAdapter emu(core);
        std::printf("core: %s  canal RE: %s\n", emu.core_name().c_str(), emu.has_re() ? "sí" : "no");
        if (!emu.has_re()) { std::printf("este core no expone rr_re_command\n"); return 3; }
        emu.load_rom(rom);

        // Empezar a ejecutar (el runtime RE arranca en paused).
        std::printf("play -> %s\n", emu.re_command(
            R"({"category":"play","state":{"startAt":0,"speed":100,"fullLogging":true,"paused":false,"endAt":-1,"loopFrame":1}})")
            .c_str());

        // Ejecutar N frames con algo de input (derecha/A alternando).
        InputState in;
        for (int f = 0; f < frames; ++f) {
            in.right = (f / 30) % 2 == 0;
            in.fire = (f / 15) % 2 == 0;
            emu.set_input(in);
            emu.step_frames(1);
        }
        std::printf("frames ejecutados: %d  W=%u H=%u\n", frames, emu.frame_width(), emu.frame_height());

        // Crear un savestate con nombre y exportar (pause -> libRR_export_all_files).
        std::printf("save_state -> %s\n", emu.re_command(
            R"({"category":"save_state","state":{"name":"after_input"}})").c_str());
        std::printf("pause/export -> %s\n", emu.re_command(
            R"({"category":"pause","state":{"paused":true,"fullLogging":true,"speed":100,"startAt":-1}})").c_str());
        return 0;
    } catch (const std::exception& e) {
        std::fprintf(stderr, "ERROR: %s\n", e.what());
        return 4;
    }
}
