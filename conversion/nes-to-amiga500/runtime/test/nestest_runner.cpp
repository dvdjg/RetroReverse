// nestest_runner — valida la CPU del runtime del nodo con la ROM `nestest.nes`.
//
// Carga la ROM iNES (NROM), enlaza la PRG en la memoria del runtime, sitúa la CPU
// en el punto de entrada del test automático (`$C000`, SP=$FD, P=$24) y ejecuta
// hasta que el PC se estabiliza. El propio test deja en `$0002` y `$0003` el
// número de fallos en opcodes oficiales e ilegales; el criterio de F1 es que
// ambos sean 0.
//
// Uso: nestest_runner <nestest.nes>

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_interpreter.hpp"
#include "nes_runtime.hpp"

namespace {

/// Búfer para la ROM iNES (NROM no supera 16 KB de PRG + 16 B de cabecera).
eng::u8 g_rom[0x10000];

/// Lee el fichero `path` a `g_rom`. \return bytes leídos, o 0 si falla.
eng::usize load_rom(const char* path) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return 0u;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(g_rom, 1, sizeof g_rom, f));
	std::fclose(f);
	return n;
}

} // namespace

int main(int argc, char** argv) {
	const char* path = (argc > 1) ? argv[1] : nullptr;
	if (path == nullptr) {
		std::printf("uso: nestest_runner <nestest.nes>\n");
		return 2;
	}
	const eng::usize n = load_rom(path);
	if (n < 16u || g_rom[0] != 'N' || g_rom[1] != 'E' || g_rom[2] != 'S' || g_rom[3] != 0x1Au) {
		std::printf("ERROR: '%s' no es una ROM iNES válida\n", path);
		return 2;
	}
	const eng::usize trainer = (g_rom[6] & 0x04u) ? 512u : 0u;
	const eng::usize off = 16u + trainer;
	const eng::u32 prg_size = static_cast<eng::u32>(g_rom[4]) * 0x4000u;
	if (off + prg_size > n) {
		std::printf("ERROR: PRG truncada\n");
		return 2;
	}

	n2a::NESMemory mem;
	mem.prg = g_rom + off;
	mem.prg_size = prg_size;

	n2a::CPU cpu;
	cpu.mem = &mem;
	cpu.PC = 0xC000u;  // entrada del test automático de nestest
	cpu.SP = 0xFDu;
	cpu.I = true;      // P inicial = $24 (I y U)

	n2a::Interpreter interp {cpu, mem};
	eng::u16 last_pc = 0xFFFFu;
	int stable = 0;
	int steps = 0;
	for (; steps < 300000; ++steps) {
		interp.step();
		if (interp.jammed) {
			break;
		}
		if (cpu.PC == last_pc) {
			if (++stable > 100) {
				break;
			}
		} else {
			stable = 0;
			last_pc = cpu.PC;
		}
	}

	const unsigned official = mem.ram[0x02];
	const unsigned illegal = mem.ram[0x03];
	std::printf("nestest: pasos=%d  PC=%04X  $02=%u (oficiales)  $03=%u (ilegales)\n",
		    steps, static_cast<unsigned>(cpu.PC), official, illegal);
	if (official == 0u && illegal == 0u) {
		std::printf("CPU OK (oficiales + ilegales)\n");
		return 0;
	}
	std::printf("FALLO: oficiales=%u ilegales=%u\n", official, illegal);
	return 1;
}
