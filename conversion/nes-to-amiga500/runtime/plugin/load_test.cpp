// load_test.cpp — prueba headless del gestor: carga un plugin `.n2x`, monta el
// `NesSystem` desde su ROM (cartucho autocontenido) y compara el **motor codegen**
// (plugin) contra el intérprete, además de medir FPS.
//
// Uso: load_test <juego.n2x> [frames=60]

#include <chrono>
#include <cstdio>
#include <cstdlib>

#include "n2a_loader.hpp"

namespace {

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
		std::printf("uso: load_test <juego.n2x> [frames]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 60;

	n2a::TranspiledGame game;
	if (!game.load(argv[1])) {
		std::printf("error: no se pudo cargar '%s' (ABI/arquitectura incompatible?)\n", argv[1]);
		return 1;
	}
	std::printf("n2x        : mapper=%d PRG=%u CHR=%u  ABI v%d/%d\n", game.fn_mapper(),
		    game.fn_prg_size(), game.fn_chr_size(), game.fn_version(), game.fn_arch());

	n2a::Mapper cart;
	game.fill_mapper(cart);

	n2a::NesSystem ref;
	ref.load_mapper(cart);
	ref.reset();
	const double ms_ref = run_frames(ref, frames);

	n2a::NesSystem gen;
	gen.load_mapper(cart);
	gen.reset();
	gen.fast_ctx = &game;
	gen.fast_run = &n2a::TranspiledGame::fast_run;
	gen.fast_ticks = true; // el plugin reloja la PPU por acceso
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

	std::printf("interprete : %.1f fps\n", frames / (ms_ref / 1000.0));
	std::printf("codegen    : %.1f fps  (%.2fx)\n", frames / (ms_gen / 1000.0), ms_ref / ms_gen);
	std::printf("RAM distinta: %d / 2048\n", ram_diff);
	std::printf("pixeles    : %d / %d (%.1f%%)\n", fb_diff, fb_total, 100.0 * fb_diff / fb_total);
	return 0;
}
