// native_frame.cpp — ejecuta el código del backend **nativo** (`--native`) dentro de un
// modelo de frame mínimo (VBlank por sondeo de `$2002` + NMI), para validar en host que
// arranca y avanza frames antes de WinUAE, y medir tiempo de host.
//
// Uso:
//   cp <salida nativa de la ROM> ../generated/native_game.cpp
//   g++ -std=gnu++23 -O2 -I<eng>/include tests/native_frame.cpp -o native_frame
//   native_frame [frames]
//
// Modelo: `$2002` devuelve VBlank (bit 7) y lo limpia al leerse (como el PPU real). Cada
// cesión del código nativo (`g_native_yield`) equivale a un VBlank: se llama a `n2a_nmi()`
// y se cuenta un frame. El resto de lecturas de E/S devuelven 0 y las escrituras se
// ignoran (no hay PPU/APU reales: el objetivo es validar control de flujo y RAM).

#define N2A_NO_HOST_MAIN
#include "../generated/native_game.cpp"

#include <chrono>
#include <cstdio>
#include <cstdlib>

namespace {

bool g_vblank = false;
int g_frames = 0;
int g_want = 60;

/// E/S: `$2002` (PPUSTATUS) devuelve VBlank y lo limpia; el resto, 0.
eng::u8 read_hook(N2A_Bus& /*m*/, eng::u16 a) {
	if (a == 0x2002u) {
		const eng::u8 v = g_vblank ? 0x80u : 0x00u;
		g_vblank = false;
		return v;
	}
	return 0u;
}

/// Cesión del código nativo = un VBlank: NMI + contar frame.
void yield_hook(N2A_State& r, N2A_Bus& /*m*/) {
	g_vblank = true;
	++g_frames;
	n2a_nmi();
	(void)r;
	if (g_frames >= g_want) {
		r.halted = true; // detiene `game_main`
	}
}

} // namespace

int main(int argc, char** argv) {
	g_want = (argc > 1) ? std::atoi(argv[1]) : 60;
	g_bus.io_read = read_hook;
	g_bus.io_write = nullptr;
	g_native_yield = yield_hook;

	std::printf("start (frames=%d)\n", g_want);
	std::fflush(stdout);
	const auto t0 = std::chrono::high_resolution_clock::now();
	game_main();
	const auto t1 = std::chrono::high_resolution_clock::now();
	const double ms = std::chrono::duration<double, std::milli>(t1 - t0).count();

	// Checksum de la RAM emulada (determinismo / no basura).
	eng::u32 sum = 0u;
	for (unsigned i = 0; i < sizeof(g_bus.ram); ++i) {
		sum = sum * 31u + g_bus.ram[i];
	}
	std::printf("native_frame: frames=%d halted=%d ram_sum=%08X %.1f ms (%.0f fps host)\n",
		    g_frames, g_st.halted ? 1 : 0, sum, ms,
		    ms > 0.0 ? (1000.0 * static_cast<double>(g_frames) / ms) : 0.0);
	return 0;
}
