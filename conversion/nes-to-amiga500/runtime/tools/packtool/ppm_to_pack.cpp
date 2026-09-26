// ppm_to_pack — genera un pack de gráficos por ROM desde una imagen PPM (P6).
//
// La imagen se interpreta como una rejilla de tiles de 8×8 (izquierda→derecha,
// arriba→abajo). Se cuantiza a **16 colores** (4 bpp) y se escribe:
//   <base>.gfx   pack binario "N2AT" (4 bpp) que lee PackProvider
//   <base>.pal   paleta extendida (256 × u16 0x0RGB)
//   <base>.n2a   perfil de ROM que referencia ambos
//
// Uso: ppm_to_pack <entrada.ppm> <base_salida> [nombre_perfil]

#include <cstdio>
#include <cstdlib>

#include <eng/core/types/types.hpp>

namespace {

struct Color {
	eng::u8 r;
	eng::u8 g;
	eng::u8 b;
};

Color g_palette[16];
int g_palette_n = 0;

/// Busca (o añade) un color en la paleta; \return índice 0..15 o -1 si llena.
int palette_index(Color c) {
	for (int i = 0; i < g_palette_n; ++i) {
		if (g_palette[i].r == c.r && g_palette[i].g == c.g && g_palette[i].b == c.b) {
			return i;
		}
	}
	if (g_palette_n >= 16) {
		return -1;
	}
	g_palette[g_palette_n] = c;
	return g_palette_n++;
}

/// Cuantiza un color al más cercano de la paleta (distancia Manhattan). Si la
/// paleta tiene hueco (<16), añade el color y usa su índice.
int nearest(Color c) {
	int idx = palette_index(c);
	if (idx >= 0) {
		return idx;
	}
	int best = 0;
	int best_d = 1 << 30;
	for (int i = 0; i < 16; ++i) {
		const int d = abs(g_palette[i].r - c.r) + abs(g_palette[i].g - c.g) + abs(g_palette[i].b - c.b);
		if (d < best_d) {
			best_d = d;
			best = i;
		}
	}
	return best;
}

} // namespace

int main(int argc, char** argv) {
	if (argc < 3) {
		std::printf("uso: ppm_to_pack <entrada.ppm> <base_salida> [nombre]\n");
		return 2;
	}
	std::FILE* f = std::fopen(argv[1], "rb");
	if (f == nullptr) {
		std::printf("ERROR: no se pudo abrir '%s'\n", argv[1]);
		return 2;
	}
	// Cabecera P6 (ignora comentarios y espacios).
	int w = 0;
	int h = 0;
	int maxv = 0;
	if (std::fscanf(f, "P6 %d %d %d", &w, &h, &maxv) != 3 || w <= 0 || h <= 0 ||
	    (w % 8) != 0 || (h % 8) != 0) {
		std::fclose(f);
		std::printf("ERROR: se espera P6 con dimensiones múltiplo de 8\n");
		return 2;
	}
	std::fgetc(f); // consume el único separador tras el maxval
	const eng::usize n = static_cast<eng::usize>(w) * static_cast<eng::usize>(h);
	eng::u8* rgb = static_cast<eng::u8*>(std::malloc(n * 3u));
	if (rgb == nullptr || std::fread(rgb, 1, n * 3u, f) != n * 3u) {
		std::fclose(f);
		std::printf("ERROR: imagen incompleta\n");
		return 2;
	}
	std::fclose(f);

	const int tiles_x = w / 8;
	const int tiles_y = h / 8;
	const int tiles = tiles_x * tiles_y;

	// Cuantiza y acumula los tiles en 4 bpp.
	eng::u8* tileset = static_cast<eng::u8*>(std::malloc(static_cast<eng::usize>(tiles) * 8u * 4u));
	if (tileset == nullptr) {
		std::printf("ERROR: sin memoria\n");
		return 2;
	}
	for (int ty = 0; ty < tiles_y; ++ty) {
		for (int tx = 0; tx < tiles_x; ++tx) {
			const int tile = ty * tiles_x + tx;
			eng::u8* dst = tileset + static_cast<eng::usize>(tile) * 8u * 4u;
			for (int y = 0; y < 8; ++y) {
				eng::u8 plane[4] = {0, 0, 0, 0};
				for (int x = 0; x < 8; ++x) {
					const eng::usize p = (static_cast<eng::usize>(ty * 8 + y) * w + (tx * 8 + x)) * 3u;
					const Color c {rgb[p], rgb[p + 1u], rgb[p + 2u]};
					const int ci = nearest(c);
					const int bit = 7 - x;
					for (int b = 0; b < 4; ++b) {
						if ((ci >> b) & 1) {
							plane[b] = static_cast<eng::u8>(plane[b] | (1u << bit));
						}
					}
				}
				// Interleaved por fila: 4 bytes por fila.
				for (int b = 0; b < 4; ++b) {
					dst[y * 4 + b] = plane[b];
				}
			}
		}
	}

	// Escribe el pack.
	char path[600];
	std::snprintf(path, sizeof path, "%s.gfx", argv[2]);
	std::FILE* g = std::fopen(path, "wb");
	if (g == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", path);
		return 2;
	}
	eng::u8 header[8] = {'N', '2', 'A', 'T', 4u, 0u, 0u, 0u};
	header[6] = static_cast<eng::u8>(tiles & 0xFF);
	header[7] = static_cast<eng::u8>((tiles >> 8) & 0xFF);
	std::fwrite(header, 1, 8, g);
	std::fwrite(tileset, 1, static_cast<eng::usize>(tiles) * 8u * 4u, g);
	std::fclose(g);

	// Escribe la paleta (256 × u16 0x0RGB).
	std::snprintf(path, sizeof path, "%s.pal", argv[2]);
	std::FILE* p = std::fopen(path, "wb");
	if (p == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", path);
		return 2;
	}
	for (int i = 0; i < 256; ++i) {
		eng::u16 v = 0;
		if (i < g_palette_n) {
			v = static_cast<eng::u16>(((g_palette[i].r >> 4) << 8) | ((g_palette[i].g >> 4) << 4) |
						  (g_palette[i].b >> 4));
		}
		const eng::u8 le[2] = {static_cast<eng::u8>(v & 0xFF), static_cast<eng::u8>(v >> 8)};
		std::fwrite(le, 1, 2, p);
	}
	std::fclose(p);

	// Escribe el perfil .n2a.
	std::snprintf(path, sizeof path, "%s.n2a", argv[2]);
	std::FILE* t = std::fopen(path, "wb");
	if (t == nullptr) {
		std::printf("ERROR: no se pudo escribir '%s'\n", path);
		return 2;
	}
	const char* name = (argc > 3) ? argv[3] : "pack";
	std::fprintf(t, "name %s\nvideo.bpp 4\n", name);
	std::fprintf(t, "video.tiles %s.gfx\n", argv[2]);
	std::fprintf(t, "video.palette %s.pal\n", argv[2]);
	std::fclose(t);

	std::printf("pack: %d tiles (%dx%d), %d colores -> %s.gfx/.pal/.n2a\n", tiles, tiles_x, tiles_y,
		    g_palette_n, argv[2]);
	std::free(rgb);
	std::free(tileset);
	return 0;
}
