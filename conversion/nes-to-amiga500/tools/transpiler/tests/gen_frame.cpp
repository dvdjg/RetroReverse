// gen_frame.cpp — ejecuta el **código generado** por el transpilador dentro del
// `NesSystem` (con PPU/APU/mapper reales), avanzando la PPU con los ciclos base
// por bloque (`n2a_block_cycles`). Compara el resultado (RAM + framebuffer) y el
// rendimiento frente al intérprete sobre la **misma ROM**.
//
// Es el primer paso de "codegen para ROMs reales": el `NesSystem` despacha los
// `bb_*` generados en vez del intérprete. La temporalización es **aproximada**
// (ciclos base, sin penalización de página/rama e ignorando bucles intra-bloque),
// así que el framebuffer puede diferir; la comparación es informativa.
//
// Uso: gen_frame <rom.nes> [frames]
// Requiere que `generated/gen_frame_game.cpp` sea el transpilado de esa ROM.

#define N2A_NO_HOST_MAIN
#include "../generated/gen_frame_game.cpp"

#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../../runtime/include/nes_system.hpp"
#include "../../runtime/host/fastcpu.hpp"
#include "../../runtime/host/rom_loader.hpp"

namespace {

n2a::LoadedRom g_rom;
n2a::FastCpu g_fast; ///< Motor rápido para el fallback (RAM y saltos calculados).

/// Hook de bloque generado: ejecuta el `bb_*` de `cpu.PC` y devuelve los ciclos
/// **exactos** que consumió (delta de `cpu.cycles`, que el código generado
/// incrementa con el coste de cada instrucción). Si la dirección no es un bloque
/// (salto calculado), devuelve 0 y el `NesSystem` cae al intérprete.
int gen_run(void* /*ctx*/, n2a::CPU& cpu, n2a::NESMemory& mem, int budget, int* n) {
	const eng::u16 pc = cpu.PC;
	// Modo de diagnóstico (N2A_MODE=fallback|fixed) para aislar el despacho.
	const char* md = std::getenv("N2A_MODE");
	if (md != nullptr && std::strcmp(md, "fallback") == 0) {
		if (n != nullptr) {
			*n = 0;
		}
		return 0;
	}
	const bool force_fixed = (md != nullptr && std::strcmp(md, "fixed") == 0);
	// Ventana conmutable en mappers bancados (UxROM/MMC1): el bloque depende del
	// banco. En MMC1, un modo no soportado invalida el modelo (sentinel 0xFF).
	const eng::u8 bank = mem.prg_bank;
	if (kPrgModeSensitive && bank == static_cast<eng::u8>(0xFFu)) {
		if (n != nullptr) {
			*n = 0;
		}
		return 0; // fallback total al intérprete
	}
	BlockFn fn = nullptr;
	if (kPrgBanked && !force_fixed && pc >= 0x8000u && pc < 0xC000u) {
		fn = n2a_banked_block(pc, bank, mem.prg_bank2, mem.prg_bank3);
	} else {
		fn = n2a_fixed_block(pc);
	}
	if (fn == nullptr) {
		// Sin bloque estático: en bancadas el **intérprete** (mapper-aware) es la
		// referencia correcta; en NROM/CNROM vale el ejecutor rápido.
		if (kPrgBanked || force_fixed) {
			if (n != nullptr) {
				*n = 0;
			}
			return 0;
		}
		const int c = n2a::FastCpu::step(&g_fast, cpu, mem);
		if (n != nullptr) {
			*n = (c > 0) ? 1 : 0;
		}
		return c;
	}
	(void)budget; // la cesión por instrucción está pendiente (ver FAST_EXECUTOR.md)
	const eng::u32 before = cpu.cycles;
	fn(cpu);
	if (n != nullptr) {
		*n = 1;
	}
	const eng::u32 delta = cpu.cycles - before;
	return delta > 0u ? static_cast<int>(delta) : 1; // nunca 0 (evita el fallback)
}

double run_frames(n2a::NesSystem& sys, int frames) {
	const auto t0 = std::chrono::steady_clock::now();
	for (int i = 0; i < frames; ++i) {
		sys.run_frame();
	}
	return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: gen_frame <rom.nes> [frames]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 60;

	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar '%s'\n", argv[1]);
		return 1;
	}
	{
		n2a::NESMemory probe;
		probe.prg = g_rom.mapper.prg;
		probe.prg_size = g_rom.mapper.prg_size;
		g_fast.build(g_rom.mapper.prg, g_rom.mapper.prg_size, probe.read16(0xFFFCu),
			     probe.read16(0xFFFAu), probe.read16(0xFFFEu));
	}

	// Referencia: intérprete.
	n2a::NesSystem ref;
	ref.load_mapper(g_rom.mapper);
	ref.reset();
	const double ms_ref = run_frames(ref, frames);

	// Código generado dentro del NesSystem.
	n2a::NesSystem gen;
	gen.load_mapper(g_rom.mapper);
	gen.reset();
	init_dispatch_table();
	gen.fast_run = &gen_run;
	gen.fast_ticks = true; // el codegen reloja la PPU por acceso
	const double ms_gen = run_frames(gen, frames);

	int ram_diff = 0;
	for (unsigned i = 0; i < 0x800u; ++i) {
		if (ref.mem.ram[i] != gen.mem.ram[i]) {
			++ram_diff;
		}
	}
	int fb_diff = 0;
	for (unsigned i = 0; i < n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH; ++i) {
		if (ref.ppu.fb[i] != gen.ppu.fb[i]) {
			++fb_diff;
		}
	}
	const int fb_total = n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH;

	std::printf("frames      : %d\n", frames);
	std::printf("interprete  : %.1f fps\n", frames / (ms_ref / 1000.0));
	std::printf("codegen     : %.1f fps  (%.2fx)\n", frames / (ms_gen / 1000.0), ms_ref / ms_gen);
	std::printf("ciclos      : interprete=%u codegen=%u (dif=%d)\n", ref.interp.cycles, gen.cpu.cycles,
			static_cast<int>(static_cast<long>(ref.interp.cycles) - static_cast<long>(gen.cpu.cycles)));
	std::printf("RAM distinta: %d / %d bytes\n", ram_diff, 0x800);
	std::printf("pixeles disp: %d / %d (%.1f%%)\n", fb_diff, fb_total, 100.0 * fb_diff / fb_total);
	return 0;
}
