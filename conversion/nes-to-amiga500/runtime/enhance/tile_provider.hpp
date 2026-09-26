#pragma once

/// \file tile_provider.hpp
/// **Ajustes por ROM** del aspecto gráfico: un proveedor de tiles sustituye la
/// lectura de la CHR 2 bpp por otra fuente (otro grupo de tiles, o tiles de mayor
/// profundidad —3/4 bpp—), **sin cambiar** la emulación (CPU, mapper, timing).
///
/// La PPU pide, por fila de tile, hasta 4 planos y el color final; el proveedor
/// decide de dónde salen. El proveedor NES por defecto reproduce exactamente el
/// comportamiento 2 bpp de la CHR.
///
/// Ver el diseño de perfiles en [`README.md`](README.md).

#include <eng/core/types/types.hpp>

namespace n2a::enhance {

/// Espacio de tiles: fondo o sprites.
enum class TileSpace : eng::u8 { Bg, Sprite };

/// Fila de un tile: hasta 4 planos (1 bit por píxel en cada plano).
struct TileRow {
	eng::u8 plane[4] {}; ///< plane[0] = bit bajo; plane[bpp-1] = bit alto.
};

/// Fuente de tiles configurable por ROM.
struct ITileProvider {
	virtual ~ITileProvider() = default;

	/// \param space Bg o Sprite.
	/// \return Profundidad en bits (2 = CHR original; 3/4 = tiles mejorados).
	[[nodiscard]] virtual eng::u8 bpp(TileSpace space) const = 0;

	/// Rellena `out` con las `bpp` filas de bits del tile para `row`.
	/// \param space    Bg/Sprite.
	/// \param tile     Índice de tile NES (0..255, o 0..511 para sprites 8×16).
	/// \param palette  Atributo de paleta (0..3).
	/// \param row      Fila dentro del tile (0..7, tras aplicar flips).
	/// \param chr_off  Offset que la PPU calcularía en la CHR (para el proveedor NES).
	/// \param out      Planos resultantes.
	/// \return `false` si el tile no está disponible (el color será 0).
	[[nodiscard]] virtual bool fetch_row(TileSpace space, eng::u16 tile, eng::u8 palette, int row,
					     eng::u16 chr_off, TileRow& out) const = 0;

	/// Mapea (palette, color) al **índice final** del framebuffer. Para la NES es
	/// el número de color (0..63); un pack mejorado puede devolver índices > 63.
	[[nodiscard]] virtual eng::u8 color(TileSpace space, eng::u8 palette, eng::u8 color) const = 0;
};

/// Proveedor NES por defecto: lee la CHR 2 bpp y usa la paleta de la PPU.
struct NesTileProvider final : ITileProvider {
	const eng::u8* chr = nullptr;       ///< CHR-ROM/RAM (patrón).
	eng::u32 chr_size = 0;              ///< Tamaño de CHR (0 = sin datos → color 0).
	const eng::u8* palette = nullptr;   ///< Paleta NES de 32 entradas (PPU).
	eng::u8 universal = 0;              ///< Color universal (color 0 de fondo).

	[[nodiscard]] eng::u8 bpp(TileSpace) const override { return 2u; }

	[[nodiscard]] bool fetch_row(TileSpace, eng::u16, eng::u8, int, eng::u16 chr_off,
				     TileRow& out) const override {
		if (chr == nullptr || chr_size == 0u) {
			return false;
		}
		out.plane[0] = chr[(chr_off) % chr_size];
		out.plane[1] = chr[(chr_off + 8u) % chr_size];
		return true;
	}

	[[nodiscard]] eng::u8 color(TileSpace space, eng::u8 pal, eng::u8 c) const override {
		if (c == 0u) {
			return space == TileSpace::Bg ? universal : 0u;
		}
		eng::u8 index;
		if (space == TileSpace::Bg) {
			index = static_cast<eng::u8>((pal & 3u) * 4u + c);
		} else {
			index = static_cast<eng::u8>(0x10u + (pal & 3u) * 4u + c);
		}
		return palette != nullptr ? static_cast<eng::u8>(palette[index & 0x1Fu] & 0x3Fu) : index;
	}
};

} // namespace n2a::enhance
