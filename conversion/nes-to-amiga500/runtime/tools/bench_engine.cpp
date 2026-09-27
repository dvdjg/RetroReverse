// bench_engine.cpp — mide el rendimiento del **camino rápido/transpilado**
// (`FastCpu`, pre-decodificado) frente al intérprete y comprueba que producen el
// mismo estado (RAM, framebuffer y registros) tras el mismo número de frames.
//
// Uso: bench_engine <rom.nes> [frames=300]
//
// Nota: el ejecutor rápido cae al intérprete para los opcodes no cubiertos, así
// que la equivalencia debe ser exacta; una diferencia señalaría un bug en la
// semántica/ciclos de un opcode cubierto.

#include <chrono>
#include <cstdio>
#include <cstdlib>

#include "../include/nes_system.hpp"
#include "../host/fastcpu.hpp"
#include "../host/rom_loader.hpp"

namespace {

/// Carga la ROM y deja un `NesSystem` listo (mapper + reset).
/// \return `true` si se cargó.
bool setup(const char* path, n2a::LoadedRom& rom, n2a::NesSystem& sys) {
	if (!n2a::load_ines(path, rom)) {
		return false;
	}
	sys.load_mapper(rom.mapper);
	sys.reset();
	return true;
}

/// Ejecuta `frames` frames de `sys` y devuelve los milisegundos empleados.
double run_frames(n2a::NesSystem& sys, int frames) {
	const auto t0 = std::chrono::steady_clock::now();
	for (int i = 0; i < frames; ++i) {
		sys.run_frame();
	}
	const auto t1 = std::chrono::steady_clock::now();
	return std::chrono::duration<double, std::milli>(t1 - t0).count();
}

/// Ejecuta `steps` instrucciones (sin `render_frame`) y devuelve los ms. Aísla el
/// coste del motor de CPU frente al render de la PPU.
double run_instructions(n2a::NesSystem& sys, int steps) {
	const auto t0 = std::chrono::steady_clock::now();
	for (int i = 0; i < steps; ++i) {
		sys.step_instruction();
	}
	const auto t1 = std::chrono::steady_clock::now();
	return std::chrono::duration<double, std::milli>(t1 - t0).count();
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: bench_engine <rom.nes> [frames]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 300;

	n2a::LoadedRom rom_a;
	n2a::NesSystem interp_sys;
	if (!setup(argv[1], rom_a, interp_sys)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}

	// Estado inicial idéntico para ambos; el segundo se construye aparte.
	n2a::LoadedRom rom_b;
	n2a::NesSystem fast_sys;
	if (!setup(argv[1], rom_b, fast_sys)) {
		return 1;
	}

	// Decodifica la PRG una vez para el camino rápido.
	n2a::FastCpu fast;
	{
		n2a::NESMemory probe;
		probe.prg = rom_b.mapper.prg;
		probe.prg_size = rom_b.mapper.prg_size;
		if (!fast.build(rom_b.mapper.prg, rom_b.mapper.prg_size, probe.read16(0xFFFCu),
				probe.read16(0xFFFAu), probe.read16(0xFFFEu))) {
			std::printf("error: no se pudo decodificar la PRG\n");
			return 1;
		}
	}
	fast_sys.fast_ctx = &fast;
	fast_sys.fast_step = &n2a::FastCpu::step;
	fast_sys.fast_run = &n2a::FastCpu::run_block;

	// Primera pasada (la que se compara) + dos de regalo para quedarnos con el
	// mejor tiempo y reducir el sesgo de caché/calentamiento.
	double ms_interp = run_frames(interp_sys, frames);
	double ms_fast = run_frames(fast_sys, frames);

	int decoded = 0;
	for (unsigned a = 0; a < 0x10000u; ++a) {
		if (fast.has[a] != 0u) {
			++decoded;
		}
	}

	// Comparación de estado final.
	int ram_diff = 0;
	int first_diff = -1;
	for (unsigned i = 0; i < 0x800u; ++i) {
		if (interp_sys.mem.ram[i] != fast_sys.mem.ram[i]) {
			if (first_diff < 0) {
				first_diff = static_cast<int>(i);
			}
			++ram_diff;
		}
	}
	int fb_diff = 0;
	for (unsigned i = 0; i < n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH; ++i) {
		if (interp_sys.ppu.fb[i] != fast_sys.ppu.fb[i]) {
			++fb_diff;
		}
	}
	const bool regs_eq = interp_sys.cpu.A == fast_sys.cpu.A && interp_sys.cpu.X == fast_sys.cpu.X &&
			     interp_sys.cpu.Y == fast_sys.cpu.Y && interp_sys.cpu.SP == fast_sys.cpu.SP &&
			     interp_sys.cpu.PC == fast_sys.cpu.PC;
	const bool equal = (ram_diff == 0) && (fb_diff == 0) && regs_eq;

	for (int t = 0; t < 2; ++t) {
		const double a = run_frames(interp_sys, frames);
		const double b = run_frames(fast_sys, frames);
		if (a < ms_interp) {
			ms_interp = a;
		}
		if (b < ms_fast) {
			ms_fast = b;
		}
	}
	const double fps_interp = frames / (ms_interp / 1000.0);
	const double fps_fast = frames / (ms_fast / 1000.0);

	std::printf("frames       : %d\n", frames);
	std::printf("direcciones  : %d decodificadas\n", decoded);
	std::printf("interprete   : %.1f ms  (%.1f fps)\n", ms_interp, fps_interp);
	std::printf("rapido       : %.1f ms  (%.1f fps)\n", ms_fast, fps_fast);
	std::printf("aceleracion  : %.2fx\n", ms_interp / ms_fast);
	std::printf("equivalencia : %s (ram_diff=%d fb_diff=%d regs=%s)\n", equal ? "OK" : "FALLO",
			ram_diff, fb_diff, regs_eq ? "ok" : "distintos");
	if (first_diff >= 0) {
		std::printf("  primera RAM distinta: $%04X  interp=%02X fast=%02X\n", first_diff,
			    interp_sys.mem.ram[first_diff], fast_sys.mem.ram[first_diff]);
	}

	// Motor de CPU puro (sin render): mismo flujo de instrucciones en ambos.
	const int budget = 3000000;
	const double cpu_i = run_instructions(interp_sys, budget);
	const double cpu_f = run_instructions(fast_sys, budget);
	std::printf("cpu (sin render): interp %.1f Mips | rapido %.1f Mips | %.2fx\n",
			budget / 1000.0 / cpu_i, budget / 1000.0 / cpu_f, cpu_i / cpu_f);

	fast.destroy();
	return equal ? 0 : 2;
}
