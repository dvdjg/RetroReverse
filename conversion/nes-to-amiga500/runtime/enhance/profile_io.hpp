#pragma once

/// \file profile_io.hpp
/// Carga de **perfil por ROM** en el host: busca `<rom>.n2a` junto a la ROM,
/// lo parsea y, si indica un pack de tiles y/o una paleta, los carga y deja un
/// `PackProvider` listo para instalar en la PPU.
///
/// Rutas de `video.tiles` / `video.palette` se resuelven **relativas al `.n2a`**.
/// Solo host (usa `<cstdio>`); la emulación no cambia.

#include <cstdio>

#include <eng/core/types/types.hpp>
#include <eng/core/util/string_view.hpp>

#include "pack_provider.hpp"
#include "rom_profile.hpp"

namespace n2a::enhance {

/// Perfil aplicado a una ROM: perfil + almacenamiento + proveedor/paleta.
struct AppliedProfile {
	RomProfile profile;   ///< Perfil parseado.
	PackStorage pack;     ///< Almacén del pack de tiles.
	PackProvider provider; ///< Proveedor de tiles (si hay pack).
	eng::u16 palette[256] = {}; ///< Paleta extendida resuelta.
	bool active = false;       ///< ¿Se encontró y aplicó un perfil?
	bool has_provider = false; ///< ¿Hay pack de tiles?
	bool has_palette = false;  ///< ¿Hay paleta extendida?

	/// \return Puntero a la paleta extendida o `nullptr`.
	[[nodiscard]] const eng::u16* palette_ptr() const { return has_palette ? palette : nullptr; }
};

namespace detail {
/// Une `dir` + `name` (con separador `/`) en `out`.
inline void join_path(char* out, eng::usize cap, const char* base, eng::util::StringView name) {
	// directorio de `base` (hasta el último separador).
	eng::usize dir_len = 0;
	for (eng::usize i = 0; base[i] != '\0'; ++i) {
		if (base[i] == '/' || base[i] == '\\') {
			dir_len = i + 1u;
		}
	}
	eng::usize o = 0;
	for (eng::usize i = 0; i < dir_len && o + 1u < cap; ++i) {
		out[o++] = base[i];
	}
	for (eng::usize i = 0; i < name.size() && o + 1u < cap; ++i) {
		out[o++] = name[i];
	}
	out[o] = '\0';
}

/// Lee todo `path` a `out` (hasta `cap`). \return bytes leídos, o 0 si falla.
inline eng::usize read_all(const char* path, char* out, eng::usize cap) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return 0u;
	}
	eng::usize n = static_cast<eng::usize>(std::fread(out, 1, cap, f));
	std::fclose(f);
	return n;
}
} // namespace detail

/// Busca y aplica el perfil de una ROM.
/// \param rom_path Ruta de la ROM (se busca `<rom_path>.n2a`).
/// \param crc      CRC32 de la ROM (para validar/identificar, informativo).
/// \param out      Salida con perfil, pack y paleta.
/// \return `true` si se encontró y aplicó un perfil.
inline bool load_rom_profile(const char* rom_path, eng::u32 crc, AppliedProfile& out) {
	out = AppliedProfile {};
	char prof_path[600];
	// construmos "<rom_path>.n2a" con join manual.
	eng::usize o = 0;
	for (eng::usize i = 0; rom_path[i] != '\0' && o + 6u < sizeof prof_path; ++i) {
		prof_path[o++] = rom_path[i];
	}
	const char ext[] = ".n2a";
	for (eng::usize i = 0; i < 4u; ++i) {
		prof_path[o++] = ext[i];
	}
	prof_path[o] = '\0';

	char text[2048];
	const eng::usize n = detail::read_all(prof_path, text, sizeof text);
	if (n == 0u) {
		return false;
	}
	if (!parse_profile(eng::util::StringView(text, n), out.profile)) {
		return false;
	}
	out.profile.crc = crc;
	out.active = true;

	if (out.profile.gfx.tiles_path[0] != '\0') {
		char tiles[600];
		detail::join_path(tiles, sizeof tiles, prof_path,
				  eng::util::StringView(out.profile.gfx.tiles_path));
		if (load_pack(tiles, out.pack, out.provider)) {
			if (load_palette(tiles, out.pack)) {
				// (por si el pack llevara paleta al final; no en este formato)
			}
			out.has_provider = true;
			out.provider.palette = nullptr;
		}
	}
	if (out.profile.gfx.palette_path[0] != '\0') {
		char pal[600];
		detail::join_path(pal, sizeof pal, prof_path,
				  eng::util::StringView(out.profile.gfx.palette_path));
		if (load_palette(pal, out.pack)) {
			for (int i = 0; i < 256; ++i) {
				out.palette[i] = out.pack.palette[i];
			}
			out.has_palette = true;
			out.provider.palette = out.palette;
		}
	}
	return true;
}

} // namespace n2a::enhance
