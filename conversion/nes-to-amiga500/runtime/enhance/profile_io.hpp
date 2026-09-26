#pragma once

/// \file profile_io.hpp
/// Carga de **perfil por ROM** en el host. Busca el perfil en varios sitios:
///   1. `<rom>.n2a` (junto a la ROM);
///   2. `<dir_rom>/packs/<crc>.n2a`;
///   3. `<dir_rom>/packs/<nombre>.n2a`;
///   4. `<system_dir>/nes_packs/<crc>.n2a`  (RetroArch: `GET_SYSTEM_DIRECTORY`).
///
/// Rutas de `video.tiles`/`video.palette` se resuelven relativas al `.n2a`.
/// Solo host (usa `<cstdio>`); la emulación no cambia.

#include <cstdio>

#include <eng/core/types/types.hpp>
#include <eng/core/util/string_view.hpp>

#include "pack_provider.hpp"
#include "rom_profile.hpp"

namespace n2a::enhance {

/// Perfil aplicado a una ROM: perfil + almacenamiento + proveedor/paleta.
struct AppliedProfile {
	RomProfile profile;    ///< Perfil parseado.
	PackStorage pack;      ///< Almacén del pack de tiles.
	PackProvider provider; ///< Proveedor de tiles (si hay pack).
	eng::u16 palette[256] = {}; ///< Paleta extendida resuelta.
	bool active = false;       ///< ¿Se encontró y aplicó un perfil?
	bool has_provider = false; ///< ¿Hay pack de tiles?
	bool has_palette = false;  ///< ¿Hay paleta extendida?
	char source[600] = {};     ///< Ruta del `.n2a` aplicado.

	/// \return Puntero a la paleta extendida o `nullptr`.
	[[nodiscard]] const eng::u16* palette_ptr() const { return has_palette ? palette : nullptr; }
};

namespace pio {

/// Copia `s` en `out` con terminador.
inline void copy(char* out, eng::usize cap, eng::util::StringView s) {
	const eng::usize n = (s.size() < cap - 1u) ? s.size() : (cap - 1u);
	for (eng::usize i = 0; i < n; ++i) {
		out[i] = s[i];
	}
	out[n] = '\0';
}

/// Longitud de una cadena C.
inline eng::usize len(const char* s) {
	eng::usize n = 0;
	while (s[n] != '\0') {
		++n;
	}
	return n;
}

/// Concatena `a` + `b` en `out`.
inline void concat(char* out, eng::usize cap, const char* a, const char* b) {
	eng::usize o = 0;
	for (eng::usize i = 0; a[i] != '\0' && o + 1u < cap; ++i) {
		out[o++] = a[i];
	}
	for (eng::usize i = 0; b[i] != '\0' && o + 1u < cap; ++i) {
		out[o++] = b[i];
	}
	out[o] = '\0';
}

/// Directorio (con separador final) del fichero `path`.
inline void dir_of(char* out, eng::usize cap, const char* path) {
	eng::usize last = 0;
	const eng::usize n = len(path);
	eng::usize o = 0;
	for (eng::usize i = 0; i < n && o + 1u < cap; ++i) {
		out[o++] = path[i];
		if (path[i] == '/' || path[i] == '\\') {
			last = o;
		}
	}
	out[last] = '\0';
}

/// Nombre base de `path` sin extensión.
inline void stem_of(char* out, eng::usize cap, const char* path) {
	const eng::usize n = len(path);
	eng::usize start = 0;
	eng::usize end = n;
	for (eng::usize i = 0; i < n; ++i) {
		if (path[i] == '/' || path[i] == '\\') {
			start = i + 1u;
		} else if (path[i] == '.' && i >= start) {
			end = i;
		}
	}
	eng::usize o = 0;
	for (eng::usize i = start; i < end && o + 1u < cap; ++i) {
		out[o++] = path[i];
	}
	out[o] = '\0';
}

/// Formatea `crc` como 8 hex en `out`.
inline void crc_hex(char* out, eng::u32 crc) {
	const char* h = "0123456789abcdef";
	for (int i = 0; i < 8; ++i) {
		out[i] = h[(crc >> ((7 - i) * 4)) & 0xF];
	}
	out[8] = '\0';
}

/// Lee todo `path` a `out`. \return bytes leídos (0 si falla).
inline eng::usize read_all(const char* path, char* out, eng::usize cap) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return 0u;
	}
	const eng::usize n = static_cast<eng::usize>(std::fread(out, 1, cap, f));
	std::fclose(f);
	return n;
}

} // namespace pio

/// Intenta aplicar el perfil `path`. \return `true` si lo parseó y aplicó.
inline bool apply_profile_file(const char* path, eng::u32 crc, AppliedProfile& out) {
	char text[2048];
	const eng::usize n = pio::read_all(path, text, sizeof text);
	if (n == 0u) {
		return false;
	}
	if (!parse_profile(eng::util::StringView(text, n), out.profile)) {
		return false;
	}
	out.profile.crc = crc;
	out.active = true;
	pio::copy(out.source, sizeof out.source, eng::util::StringView(path));

	char dir[600];
	pio::dir_of(dir, sizeof dir, path);

	if (out.profile.gfx.tiles_path[0] != '\0') {
		char tiles[600];
		pio::concat(tiles, sizeof tiles, dir, out.profile.gfx.tiles_path);
		if (load_pack(tiles, out.pack, out.provider)) {
			out.has_provider = true;
			out.provider.palette = nullptr;
		}
	}
	if (out.profile.gfx.palette_path[0] != '\0') {
		char pal[600];
		pio::concat(pal, sizeof pal, dir, out.profile.gfx.palette_path);
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

/// Busca y aplica el perfil de una ROM (varias ubicaciones; ver cabecera).
/// \param rom_path   Ruta de la ROM.
/// \param crc        CRC32 de la ROM.
/// \param out        Salida con el perfil, pack y paleta aplicados.
/// \param system_dir Directorio de sistema del frontend (o `nullptr`).
/// \return `true` si encontró y aplicó un perfil.
inline bool load_rom_profile(const char* rom_path, eng::u32 crc, AppliedProfile& out,
			     const char* system_dir = nullptr) {
	out = AppliedProfile {};

	char dir[600];
	char stem[256];
	char crc8[12];
	char packs[600];
	pio::dir_of(dir, sizeof dir, rom_path);
	pio::stem_of(stem, sizeof stem, rom_path);
	pio::crc_hex(crc8, crc);
	pio::concat(packs, sizeof packs, dir, "packs/");

	// Lista de candidatos (hasta 5).
	char cand[5][600];
	int nc = 0;
	auto add = [&](const char* base, const char* name) {
		char tmp[600];
		pio::concat(tmp, sizeof tmp, base, name);
		pio::concat(cand[nc], sizeof cand[nc], tmp, ".n2a");
		++nc;
	};
	// 1) <rom>.n2a
	pio::concat(cand[nc], sizeof cand[nc], rom_path, ".n2a");
	++nc;
	// 2) <dir>/packs/<crc>.n2a  ; 3) <dir>/packs/<stem>.n2a
	add(packs, crc8);
	add(packs, stem);
	// 4) <system_dir>/nes_packs/<crc>.n2a
	if (system_dir != nullptr && system_dir[0] != '\0') {
		char syspacks[600];
		pio::concat(syspacks, sizeof syspacks, system_dir, "nes_packs/");
		add(syspacks, crc8);
	} else {
		// rellena con una ruta inexistente para mantener el índice.
		cand[nc][0] = '\0';
		++nc;
	}

	for (int i = 0; i < nc; ++i) {
		if (cand[i][0] != '\0' && apply_profile_file(cand[i], crc, out)) {
			return true;
		}
	}
	return false;
}

} // namespace n2a::enhance
