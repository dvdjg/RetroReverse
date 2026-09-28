// native_diff.cpp — compara la RAM del backend **nativo** frente al **intérprete** a N frames.
//
// El nativo se ejecuta con el mismo modelo de frame que `native_frame.cpp` (VBlank por `$2002`,
// cesión -> NMI); el intérprete usa el `NesSystem` real (PPU/APU/mapper). La comparación es
// informativa: la sincronización NMI del modelo en stub no es exacta, así que puede haber deriva.
//
// Uso: native_diff <rom.nes> [frames]
// Requiere que `../generated/native_game.cpp` sea el transpilado `--native` de esa ROM.

#define N2A_NO_HOST_MAIN
#include "../generated/native_game.cpp"

#include "nes_system.hpp"
#include "rom_loader.hpp"

#include <cstdio>
#include <cstdlib>

namespace {

bool g_vblank = false;
int g_frames = 0;
int g_want = 60;

eng::u8 read_hook(N2A_Bus& /*m*/, eng::u16 a) {
	if (a == 0x2002u) {
		const eng::u8 v = g_vblank ? 0x80u : 0x00u;
		g_vblank = false;
		return v;
	}
	return 0u;
}

void yield_hook(N2A_State& r, N2A_Bus& /*m*/) {
	g_vblank = true;
	++g_frames;
	n2a_nmi();
	if (g_frames >= g_want) {
		r.halted = true;
	}
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: native_diff <rom.nes> [frames]\n");
		return 1;
	}
	g_want = (argc > 2) ? std::atoi(argv[2]) : 60;

	// --- Referencia: intérprete + PPU/APU reales ---
	n2a::LoadedRom rom;
	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 2;
	}
	sys.load_mapper(rom.mapper);
	sys.reset();
	for (int i = 0; i < g_want; ++i) {
		sys.run_frame();
	}

	// --- Nativo (modelo de frame en stub) ---
	g_bus.io_read = read_hook;
	g_bus.io_write = nullptr;
	g_native_yield = yield_hook;
	game_main();

	unsigned diff = 0u;
	unsigned first = 0x800u;
	for (unsigned i = 0; i < 0x800u; ++i) {
		if (sys.mem.ram[i] != g_bus.ram[i]) {
			++diff;
			if (first == 0x800u) {
				first = i;
			}
		}
	}
	std::printf("native_diff: frames=%d/%d ram_diff=%u/2048", g_frames, g_want, diff);
	if (first != 0x800u) {
		std::printf(" first ram[%03X]: interp=%02X native=%02X", first, sys.mem.ram[first],
			    g_bus.ram[first]);
	}
	std::printf("\n");
	return (diff == 0u) ? 0 : 1;
}
