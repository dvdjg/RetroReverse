// bench_hle — banco de **presupuesto por frame** y **cobertura HLE**.
//
// Ejecuta una ROM N frames con el intérprete y mide, por frame:
//   - ciclos de CPU 6502 gastados (el presupuesto NTSC es 29780; PAL, 33247),
//   - ratio HLE (escrituras a registros de PPU resueltas por el camino HLE),
//   - FPS del host.
//
// Sirve para razonar el encaje en el Amiga: el transpilado ejecuta los **mismos
// ciclos de 6502** y las escrituras de PPU cubiertas por HLE son las que no
// costarán lógica en el 68000 (las resolverá el Copper/Blitter). Ver
// docs/TIMING_AMIGA.md y docs/HLE.md.
//
// Uso: bench_hle <rom.nes> [frames]

#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../include/nes_system.hpp"
#include "../host/rom_loader.hpp"

namespace {
n2a::LoadedRom g_rom;
}

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: bench_hle <rom.nes> [frames]\n");
		return 2;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 120;
	bool cycle_exact = true;
	for (int i = 1; i < argc; ++i) {
		if (std::strcmp(argv[i], "--fast-timing") == 0) {
			cycle_exact = false;
		}
	}
	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}
	sys.load_mapper(g_rom.mapper);
	sys.reset();
	sys.set_cycle_exact(cycle_exact);

	const auto t0 = std::chrono::steady_clock::now();
	long long total_cycles = 0;
	unsigned long long hle = 0, fb = 0;
	for (int f = 0; f < frames; ++f) {
		const eng::u32 c0 = sys.interp.cycles;
		sys.run_frame();
		total_cycles += static_cast<long long>(sys.interp.cycles - c0);
	}
	const auto t1 = std::chrono::steady_clock::now();
	hle = sys.hle.hle_writes;
	fb = sys.hle.fb_writes;

	const double ms = std::chrono::duration<double, std::milli>(t1 - t0).count();
	const double cyc_frame = static_cast<double>(total_cycles) / frames;
	const double ratio = (hle + fb) != 0u ? 100.0 * static_cast<double>(hle) /
						 static_cast<double>(hle + fb)
					      : 0.0;
	std::printf("ROM=%s frames=%d\n", argv[1], frames);
	std::printf("ciclos CPU 6502/frame : %.0f   (NTSC 29780 -> %.0f%%, PAL 33247 -> %.0f%%)\n",
		    cyc_frame, 100.0 * cyc_frame / 29780.0, 100.0 * cyc_frame / 33247.0);
	std::printf("HLE PPU               : %.1f%% (%llu HLE / %llu fallback)\n", ratio, hle, fb);
	std::printf("host                  : %.1f ms total, %.0f fps (%.2f ms/frame)\n", ms,
		    frames * 1000.0 / ms, ms / frames);
	return 0;
}
