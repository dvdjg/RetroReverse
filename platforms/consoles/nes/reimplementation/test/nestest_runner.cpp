// Arnés nestest: ejecuta el test automático de CPU y comprueba $02/$03.
// Uso: nestest_runner <nestest.nes> [--trace N]
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "bus.hpp"
#include "cartridge.hpp"
#include "cpu6502.hpp"

int main(int argc, char** argv) {
    const char* rom = (argc > 1) ? argv[1] : nullptr;
    if (!rom || rom[0] == '-') {
        std::printf("uso: nestest_runner <nestest.nes> [--trace N]\n");
        return 2;
    }
    int trace = 0;
    for (int i = 2; i < argc; ++i) {
        if (std::strcmp(argv[i], "--trace") == 0 && i + 1 < argc) trace = std::atoi(argv[++i]);
    }
    Cartridge cart;
    if (!cart.load(rom)) {
        std::printf("ERROR: no se pudo cargar %s\n", rom);
        return 2;
    }
    std::printf("ROM: %s (mapper %d, PRG %d B, CHR %d B)\n", rom, cart.mapper(), cart.prg_bytes(), cart.chr_bytes());

    Bus bus(cart);
    CPU6502 cpu(bus);
    cpu.start_test();  // PC=C000 SP=FD P=24

    const int max_steps = 300000;
    int stable = 0;
    std::uint16_t lastpc = 0xFFFF;
    int steps = 0;
    for (; steps < max_steps; ++steps) {
        if (trace && steps < trace) {
            std::printf("T %04X %02X %02X %02X %02X %02X\n", cpu.pc, cpu.a, cpu.x, cpu.y, cpu.p, cpu.sp);
        }
        cpu.step();
        if (cpu.pc == lastpc) {
            if (++stable > 100) break;
        } else {
            stable = 0;
            lastpc = cpu.pc;
        }
        if (cpu.jammed) break;
    }

    const std::uint8_t official = bus.read(0x0002);
    const std::uint8_t illegal = bus.read(0x0003);
    std::printf("instrucciones: %d  PC=%04X A=%02X X=%02X Y=%02X P=%02X SP=%02X\n",
                steps, cpu.pc, cpu.a, cpu.x, cpu.y, cpu.p, cpu.sp);
    std::printf("nestest: $02=%u (oficiales)  $03=%u (ilegales)\n", official, illegal);

    if (official == 0 && illegal == 0) {
        std::printf("\nCPU OK (oficiales + ilegales)\n");
        return 0;
    }
    std::printf("\nFALLO: oficiales=%u ilegales=%u\n", official, illegal);
    return 1;
}
