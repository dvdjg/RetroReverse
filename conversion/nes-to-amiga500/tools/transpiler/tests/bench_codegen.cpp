// bench_codegen.cpp — mide el **código generado** por el transpilador frente al
// intérprete y al ejecutor rápido sobre la misma ROM de cálculo (`--emit-bench-rom`).
//
// El fichero generado (`generated/bench.cpp`) define `game_main()`, `PRG_ROM`,
// `kPrgSize` y usa el global `g_state` de `nes_runtime.hpp`. Se incluye aquí con
// `N2A_NO_HOST_MAIN` para compartir estado con los otros dos motores.
//
// Uso: bench_codegen   (tras generar y transpilar `bench.nes` en `generated/`)

#define N2A_NO_HOST_MAIN
#include "../generated/bench.cpp"

#include <chrono>
#include <cstdio>

#include "../../runtime/include/nes_system.hpp"
#include "../../runtime/host/fastcpu.hpp"

namespace {

using Clock = std::chrono::steady_clock;

/// Estado final relevante de la ROM de cálculo.
struct Final {
	eng::u8 a;
	eng::u8 x;
	eng::u8 y;
	eng::u8 r10;
	eng::u8 r11;
	eng::u8 r12;
};

Final snapshot() {
	return Final {g_state.cpu.A, g_state.cpu.X, g_state.cpu.Y, g_state.mem.ram[0x10],
		      g_state.mem.ram[0x11], g_state.mem.ram[0x12]};
}

bool same(const Final& p, const Final& q) {
	return p.a == q.a && p.x == q.x && p.y == q.y && p.r10 == q.r10 && p.r11 == q.r11 &&
	       p.r12 == q.r12;
}

/// Deja `g_state` limpio y con la PRG enlazada para el motor de CPU.
void reset_state() {
	const n2a::CPU fresh {};
	g_state.cpu = fresh;
	for (unsigned i = 0; i < 0x800u; ++i) {
		g_state.mem.ram[i] = 0u;
	}
	g_state.mem.prg = PRG_ROM;
	g_state.mem.prg_size = static_cast<eng::u32>(kPrgSize);
	g_state.mem.io_read = nullptr;
	g_state.mem.io_write = nullptr;
	g_state.cpu.mem = &g_state.mem;
	g_state.cpu.PC = 0x8000u;
}

double ms_since(const Clock::time_point& t0) {
	return std::chrono::duration<double, std::milli>(Clock::now() - t0).count();
}

} // namespace

int main() {
	// --- Código generado ---
	reset_state();
	const Clock::time_point g0 = Clock::now();
	game_main();
	const double ms_gen = ms_since(g0);
	const Final sf_gen = snapshot();

	// --- Intérprete (hasta el BRK en $8020) ---
	reset_state();
	n2a::Interpreter interp(g_state.cpu, g_state.mem);
	unsigned long steps = 0;
	const Clock::time_point i0 = Clock::now();
	while (g_state.mem.read(g_state.cpu.PC) != 0x00u) {
		interp.step();
		++steps;
	}
	const double ms_int = ms_since(i0);
	const Final sf_int = snapshot();

	// --- Ejecutor rápido ---
	reset_state();
	n2a::FastCpu fast;
	fast.build(PRG_ROM, static_cast<eng::u32>(kPrgSize), 0x8000u, 0x8000u, 0x8000u);
	const Clock::time_point f0 = Clock::now();
	while (g_state.mem.read(g_state.cpu.PC) != 0x00u) {
		n2a::FastCpu::step(&fast, g_state.cpu, g_state.mem);
	}
	const double ms_fast = ms_since(f0);
	const Final sf_fast = snapshot();
	fast.destroy();

	const bool eq = same(sf_gen, sf_int) && same(sf_int, sf_fast);
	const double mips = static_cast<double>(steps) / 1000.0;

	std::printf("instrucciones  : %lu\n", steps);
	std::printf("final          : A=%02X X=%02X Y=%02X [$10]=%02X [$11]=%02X [$12]=%02X\n",
			sf_gen.a, sf_gen.x, sf_gen.y, sf_gen.r10, sf_gen.r11, sf_gen.r12);
	std::printf("equivalencia   : %s (codegen = interprete = rapido)\n", eq ? "OK" : "FALLO");
	std::printf("interprete     : %.2f ms  (%.1f Mips)\n", ms_int, mips / ms_int);
	std::printf("rapido         : %.2f ms  (%.1f Mips)  %.2fx vs interprete\n", ms_fast,
			mips / ms_fast, ms_int / ms_fast);
	std::printf("codegen        : %.2f ms  (%.1f Mips)  %.2fx vs interprete\n", ms_gen,
			mips / ms_gen, ms_int / ms_gen);
	return eq ? 0 : 2;
}
