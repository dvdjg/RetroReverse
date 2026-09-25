// Test del adaptador libretro contra el core de prueba.
// Uso: host_test <core.(so|dll)> [rom]

#include <cstdint>
#include <cstdio>
#include <string>
#include <vector>

#include "libretro_adapter.hpp"

using namespace rr;

int main(int argc, char** argv) {
    if (argc < 2) {
        std::printf("uso: host_test <core.(so|dll)> [rom]\n");
        return 2;
    }
    const std::string core = argv[1];
    const std::string rom = (argc > 2) ? argv[2] : "";

    int fails = 0;
    auto check = [&](bool cond, const char* msg) {
        std::printf("  %s %s\n", cond ? "ok:" : "FALLO:", msg);
        if (!cond) ++fails;
    };

    try {
        LibretroAdapter emu(core);
        std::printf("core: %s\n", emu.core_name().c_str());

        emu.load_rom(rom);
        emu.step_frames(5);
        auto a = emu.read_mem(0, 2);
        check(a.size() == 2 && a[0] == 5, "ram[0]==5 tras 5 frames");

        InputState in;
        in.up = true;
        in.fire = true;
        emu.set_input(in);
        emu.step_frames(1);
        auto b = emu.read_mem(1, 1);
        check(b.size() == 1 && (b[0] & 0x01) && (b[0] & 0x10), "ram[1] refleja input (up+fire)");

        auto st = emu.save_state();
        check(!st.empty(), "save_state no vacio");
        auto before = emu.read_mem(0, 1);
        emu.step_frames(3);
        emu.load_state(st);
        auto after = emu.read_mem(0, 1);
        check(!before.empty() && before == after, "load_state restaura ram[0]");

        emu.screenshot("host_test.ppm");
        check(emu.frame_width() == 4 && emu.frame_height() == 2, "frame 4x2");
    } catch (const std::exception& e) {
        std::printf("ERROR: %s\n", e.what());
        return 3;
    }

    if (fails == 0) {
        std::printf("\nTODOS LOS TESTS OK\n");
        return 0;
    }
    std::printf("\n%d FALLO(S)\n", fails);
    return 1;
}
