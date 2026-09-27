// raster_idioms — herramienta del **reconocedor de idiomas de raster**.
//
// Escanea linealmente la PRG de una ROM iNES buscando los patrones con los que un
// juego NES "mira al PPU" y que, en la estrategia Amiga, se sustituyen por
// primitivas HLE sobre el haz/Copper (ver docs/TIMING_AMIGA.md):
//   1. sondeo de VBlank, 2. sondeo de sprite-0, 3. bucles de retardo.
//
// Uso: raster_idioms [--json] <rom.nes> [rom2.nes ...]

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "raster_idioms.hpp"

namespace {

/// Lee la PRG de `path` y la devuelve en `buf` (malloc). \return tamaño (0 si error).
eng::usize load_prg(const char* path, eng::u8** buf) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) return 0u;
	eng::u8 hdr[16];
	if (std::fread(hdr, 1, 16, f) != 16 || hdr[0] != 'N' || hdr[1] != 'E' || hdr[2] != 'S') {
		std::fclose(f);
		return 0u;
	}
	const eng::usize trainer = (hdr[6] & 0x04u) ? 512u : 0u;
	const eng::usize prg = static_cast<eng::usize>(hdr[4]) * 0x4000u;
	std::fseek(f, static_cast<long>(16u + trainer), SEEK_SET);
	*buf = static_cast<eng::u8*>(std::malloc(prg ? prg : 1u));
	const eng::usize got = (*buf != nullptr) ? std::fread(*buf, 1, prg, f) : 0u;
	std::fclose(f);
	return got;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: raster_idioms [--json] <rom.nes> [rom2.nes ...]\n");
		return 2;
	}
	const bool json = std::strcmp(argv[1], "--json") == 0;
	const int first = json ? 2 : 1;
	if (json) {
		std::printf("{\n");
	} else {
		std::printf("%-16s %7s %8s %7s   direcciones (vblank / sprite0 / retardo)\n", "ROM",
			    "vblank", "sprite0", "retardo");
	}
	for (int a = first; a < argc; ++a) {
		eng::u8* prg = nullptr;
		const eng::usize n = load_prg(argv[a], &prg);
		const char* base = argv[a];
		for (const char* c = argv[a]; *c != '\0'; ++c) {
			if (*c == '/' || *c == '\\') base = c + 1;
		}
		if (n == 0u || prg == nullptr) {
			if (json) std::printf("  %s\"%s\": null", a > first ? ",\n" : "", base);
			else std::printf("  %s: no es iNES o no se pudo leer\n", base);
			std::free(prg);
			continue;
		}
		n2a::RasterIdioms r;
		n2a::scan_raster_idioms(prg, n, r);
		if (json) {
			std::printf("  %s\"%s\": {\"vblank\": ", a > first ? ",\n" : "", base);
			n2a::ri_json_addrs(r.vblank, r.counts[0] < 4 ? r.counts[0] : 4);
			std::printf(", \"sprite0\": ");
			n2a::ri_json_addrs(r.sprite0, r.counts[1] < 4 ? r.counts[1] : 4);
			std::printf(", \"delay\": ");
			n2a::ri_json_addrs(r.delay, r.counts[2] < 4 ? r.counts[2] : 4);
			std::printf(", \"counts\": [%d,%d,%d]}", r.counts[0], r.counts[1], r.counts[2]);
		} else {
			std::printf("%-16s %7d %8d %7d   %04X %04X %04X / %04X / %04X\n", base, r.counts[0],
				    r.counts[1], r.counts[2], r.vblank[0], r.vblank[1], r.sprite0[0], r.delay[0],
				    r.delay[1]);
		}
		std::free(prg);
	}
	if (json) std::printf("\n}\n");
	return 0;
}
