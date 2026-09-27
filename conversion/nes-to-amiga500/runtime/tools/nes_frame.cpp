// nes_frame — ejecuta una ROM con el sistema NES del runtime y vuelca un frame.
//
// Carga una ROM iNES/NES2.0 con `load_ines` (soporta todos los mappers del
// runtime: NROM/UxROM/CNROM/MMC1/MMC3/MMC5/AxROM/VRC6/FME-7), arranca el sistema
// por su vector de reset, avanza N frames y escribe el último frame como PPM (P6)
// e imprime el hash FNV-1a de los píxeles (para comparar con otro emulador, mesen).
//
// Uso: nes_frame <rom.nes> <salida.ppm> [frames]

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_system.hpp"
#include "../host/rom_loader.hpp"

namespace {

eng::u64 fnv1a(const eng::u8* data, eng::usize n) {
	eng::u64 h = 1469598103934665603ull;
	for (eng::usize i = 0; i < n; ++i) {
		h ^= data[i];
		h *= 1099511628211ull;
	}
	return h;
}

n2a::LoadedRom g_loaded; ///< ROM + mapper (todos los mappers del runtime).

} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: nes_frame <rom.nes> <salida.ppm> [frames]\n");
		return 2;
	}
	if (!n2a::load_ines(argv[1], g_loaded)) {
		// Mensaje específico si el mapper existe pero no está soportado, para no
		// confundir una ROM corrupta con un mapper sin implementar.
		std::FILE* chk = std::fopen(argv[1], "rb");
		if (chk == nullptr) {
			std::printf("ERROR: no se pudo abrir '%s'\n", argv[1]);
			return 2;
		}
		const int b = std::fgetc(chk);
		std::fclose(chk);
		std::printf("ERROR: '%s' no es una ROM iNES válida o su mapper no está soportado\n", argv[1]);
		(void)b;
		return 2;
	}
	const int frames = (argc > 3) ? std::atoi(argv[3]) : 30;

	n2a::NesSystem nes;
	nes.load_mapper(g_loaded.mapper);
	nes.reset();
	// Reloj de bus **exacto** (dot-exacto por acceso): imprescindible para que el
	// timing coincida con `frame_probe` y con el oráculo de la matriz. Sin esta
	// llamada el hook `mem.cycle_tick` no se instala y la PPU solo avanza al final
	// de la instrucción → frames distintos en juegos sensibles al timing.
	nes.set_cycle_exact(true);
	for (int i = 0; i < frames; ++i) {
		nes.run_frame();
	}

	eng::u8 rgb[n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH * 3];
	nes.frame_rgb(eng::Span<eng::u8> {rgb, sizeof rgb});

	std::FILE* out = std::fopen(argv[2], "wb");
	if (out == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", argv[2]);
		return 2;
	}
	std::fprintf(out, "P6\n%d %d\n255\n", n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH);
	std::fwrite(rgb, 1, sizeof rgb, out);
	std::fclose(out);

	std::printf("nes_frame: mapper=%u PRG=%u CHR=%u frames=%d hash=%016llx -> %s\n",
		    g_loaded.mapper_no, g_loaded.prg_size, g_loaded.chr_size, frames,
		    static_cast<unsigned long long>(fnv1a(rgb, sizeof rgb)), argv[2]);
	return 0;
}
