// bench_m68k.cpp — compara el intérprete y el ejecutor rápido del nodo NES
// compilados para **m68k-amiga** (GCC, `-m68000`) **sin** el engine `Amiga-Cpp`:
// usa el shim `tools/m68k/shim/eng/...`. Sin libc (`-ffreestanding`), por lo que
// aquí solo se mide **tamaño de código** (que en A500 sin caché es crítico) y se
// valida que compila; la medida de ciclos real requiere WinUAE.
//
// Compilar con `-DN2A_USE_FAST` para el ejecutor rápido; sin él, el intérprete.
// Con `-DN2A_NO_MAIN` no se emite `main` (uso bare-metal).

#include "nes_runtime.hpp"
#ifdef N2A_USE_FAST
#include "fastcpu.hpp"
#else
#include "nes_interpreter.hpp"
#endif

namespace {

// ROM de cálculo: bucle 128×(256 iteraciones) y BRK (misma que el transpilador).
constexpr eng::u8 kBenchProg[] = {
	0xA2u, 0x00u, 0xA9u, 0x00u, 0x85u, 0x10u, 0xA9u, 0xFFu, 0x85u, 0x12u,
	0x18u, 0x69u, 0x07u, 0x85u, 0x10u, 0xA5u, 0x10u, 0x49u, 0x5Au, 0x85u,
	0x11u, 0x26u, 0x11u, 0xC6u, 0x12u, 0xD0u, 0xEFu, 0xE8u, 0xE0u, 0x80u,
	0xD0u, 0xE2u, 0x00u,
};

eng::u8 g_prg[16384];
n2a::NESMemory g_mem;
n2a::CPU g_cpu;

/// Prepara memoria y CPU y enlaza la PRG.
void setup() {
	for (eng::usize i = 0; i < sizeof g_prg; ++i) {
		g_prg[i] = 0u;
	}
	for (eng::usize i = 0; i < sizeof kBenchProg; ++i) {
		g_prg[i] = kBenchProg[i];
	}
	g_mem = n2a::NESMemory {};
	g_mem.prg = g_prg;
	g_mem.prg_size = 16384u;
	g_mem.io_read = nullptr;
	g_mem.io_write = nullptr;
	g_cpu = n2a::CPU {};
	g_cpu.mem = &g_mem;
	g_cpu.PC = 0x8000u;
}

} // namespace

/// Ejecuta la ROM de cálculo hasta el `BRK` en `$8020` (o `limit` pasos).
/// \param limit Tope de instrucciones (evita bucles infinitos).
/// \return Nº de instrucciones ejecutadas; deja el resultado en `g_cpu`/`g_mem`.
extern "C" unsigned n2a_bench_run(unsigned limit) {
	setup();
#ifdef N2A_USE_FAST
	n2a::FastCpu fc;
	fc.build(g_prg, 16384u, 0x8000u, 0x8000u, 0x8000u);
	unsigned n = 0u;
	while (n < limit && g_mem.read(g_cpu.PC) != 0x00u) {
		n2a::FastCpu::step(&fc, g_cpu, g_mem);
		++n;
	}
	fc.destroy();
	return n;
#else
	n2a::Interpreter it(g_cpu, g_mem);
	unsigned n = 0u;
	while (n < limit && g_mem.read(g_cpu.PC) != 0x00u) {
		it.step();
		++n;
	}
	return n;
#endif
}

#ifndef N2A_NO_MAIN
#include <cstdio>
int main() {
	const unsigned n = n2a_bench_run(1000000u);
	std::printf("steps=%u A=%02X [$10]=%02X [$11]=%02X\n", n, g_cpu.A, g_mem.ram[0x10],
		    g_mem.ram[0x11]);
	return 0;
}
#endif
