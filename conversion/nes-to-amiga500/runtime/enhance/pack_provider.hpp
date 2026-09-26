#pragma once

/// \file pack_provider.hpp
/// **Pack de gráficos por ROM**: proveedor de tiles que lee de un fichero (otro
/// grupo de tiles o tiles de mayor profundidad, 2..4 bpp) y una **paleta
/// extendida**. Solo afecta al aspecto; la emulación no cambia.
///
/// Formato del pack de tiles (binario, little-endian):
/// ```
/// 'N','2','A','T'   4 bytes
/// u8  bpp           2..4 (bits por píxel)
/// u8  reserved      0
/// u16 count         nº de tiles
/// count * 8 * bpp   bytes (cada tile: 8 filas × bpp planos)
/// ```
/// Formato del fichero de paleta: `256 × u16` (0x0RGB), 512 bytes.
///
/// Estos cargadores son de **host** (usan `<cstdio>`); el backend Amiga/SDL puede
/// alimentar `PackProvider` con datos embebidos en su lugar.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "tile_provider.hpp"

namespace n2a::enhance {

/// Almacenamiento del pack (vive tanto como el `PackProvider` que lo referencia).
struct PackStorage {
	static constexpr eng::usize kMaxBytes = 0x40000; ///< Tope de tiles (256 KB).
	eng::u8 data[kMaxBytes] = {};
	eng::usize len = 0;
	eng::u16 palette[256] = {};
	bool has_palette = false;
};

/// Proveedor de tiles sobre un pack cargado en memoria.
struct PackProvider final : ITileProvider {
	const eng::u8* tiles = nullptr; ///< Bloque de tiles (8*bpp por tile).
	eng::u32 tiles_len = 0;         ///< Bytes válidos.
	eng::u16 count = 0;             ///< Nº de tiles del pack.
	eng::u8 bpp_bits = 4;           ///< Bits por píxel del pack (2..4).
	const eng::u16* palette = nullptr; ///< Paleta extendida (256) o `nullptr`.

	[[nodiscard]] eng::u8 bpp(TileSpace) const override { return bpp_bits; }

	[[nodiscard]] bool fetch_row(TileSpace, eng::u16 tile, eng::u8, int row, eng::u16,
				     TileRow& out) const override {
		if (tiles == nullptr || count == 0u) {
			return false;
		}
		const eng::u8 b = bpp_bits;
		const eng::u16 t = static_cast<eng::u16>(tile % count);
		const eng::u32 off = static_cast<eng::u32>(t) * 8u * b + static_cast<eng::u32>(row) * b;
		if (off + b > tiles_len) {
			return false;
		}
		out = TileRow {};
		for (eng::u8 i = 0; i < b; ++i) {
			out.plane[i] = tiles[off + i];
		}
		return true;
	}

	[[nodiscard]] eng::u8 color(TileSpace space, eng::u8 pal, eng::u8 c) const override {
		if (c == 0u) {
			return 0u; // color 0 = fondo/transparente (índice 0 de la paleta extendida)
		}
		// Grupos de 16 colores: BG en 0..63, sprites en 64..127.
		const eng::u8 base = (space == TileSpace::Bg) ? 0u : 64u;
		return static_cast<eng::u8>(base + (pal & 3u) * 16u + c);
	}
};

/// Carga un pack de tiles. \param path Fichero; \param store Almacén; \param out
/// Proveedor apuntando a `store`. \return `true` si el formato es válido.
inline bool load_pack(const char* path, PackStorage& store, PackProvider& out) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(store.data, 1, sizeof store.data, f));
	std::fclose(f);
	if (n < 8u || store.data[0] != 'N' || store.data[1] != '2' || store.data[2] != 'A' ||
	    store.data[3] != 'T') {
		return false;
	}
	const eng::u8 bpp = store.data[4];
	const eng::u16 count = static_cast<eng::u16>(store.data[6] | (store.data[7] << 8));
	if (bpp < 2u || bpp > 4u || count == 0u) {
		return false;
	}
	const eng::usize need = 8u + static_cast<eng::usize>(count) * 8u * bpp;
	if (need > n) {
		return false;
	}
	store.len = need;
	out.tiles = store.data + 8u;
	out.tiles_len = static_cast<eng::u32>(store.len - 8u);
	out.count = count;
	out.bpp_bits = bpp;
	return true;
}

/// Carga una paleta extendida (256 × u16 0x0RGB). \return `true` si ocupó 512 B.
inline bool load_palette(const char* path, PackStorage& store) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	eng::u8 buf[512];
	const eng::usize n = static_cast<eng::usize>(std::fread(buf, 1, sizeof buf, f));
	std::fclose(f);
	if (n < sizeof buf) {
		return false;
	}
	for (int i = 0; i < 256; ++i) {
		store.palette[i] = static_cast<eng::u16>(buf[i * 2] | (buf[i * 2 + 1] << 8));
	}
	store.has_palette = true;
	return true;
}

} // namespace n2a::enhance
