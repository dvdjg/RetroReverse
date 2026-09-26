#pragma once

/// \file rom_profile.hpp
/// **Perfil por ROM**: ajustes que solo afectan a esa ROM (aspecto gráfico, audio,
/// profundidad de tiles) sin cambiar la emulación. Se identifica por el **CRC32**
/// de la ROM y se describe en un fichero de texto, de modo que el frontend
/// (RetroArch, SDL3, Amiga) lo aplique al cargar.
///
/// Formato (una directiva por línea; `#` comenta; hexadecimal sin `0x`):
/// ```
/// crc 1a2b3c4d
/// name Mi Juego
/// video.bpp 4                 # 2 (NES), 3 o 4 bits por píxel
/// video.palette packs/mi.pal  # paleta extendida (opcional)
/// video.tiles   packs/mi.gfx  # grupo de tiles alternativo (opcional)
/// audio.plugin  linear        # plugin de audio (opcional)
/// ```

#include <eng/core/types/types.hpp>
#include <eng/core/util/string_view.hpp>

#include "tile_provider.hpp"

namespace n2a::enhance {

/// CRC-32 (IEEE) sobre los bytes de la ROM, para identificar el perfil.
[[nodiscard]] inline eng::u32 crc32(const eng::u8* data, eng::usize size) {
	eng::u32 crc = 0xFFFFFFFFu;
	for (eng::usize i = 0; i < size; ++i) {
		crc ^= data[i];
		for (int b = 0; b < 8; ++b) {
			crc = (crc >> 1u) ^ (0xEDB88320u & (0u - (crc & 1u)));
		}
	}
	return ~crc;
}

/// Ajustes gráficos del perfil.
struct GraphicsOverride {
	eng::u8 bpp_bg = 2;     ///< Bits por píxel del fondo (2 = NES; 3/4 = mejorado).
	eng::u8 bpp_sprite = 2; ///< Bits por píxel de los sprites.
	const ITileProvider* provider = nullptr; ///< Proveedor de tiles (si lo hay).
	const eng::u16* palette = nullptr;       ///< Paleta extendida 0x0RGB (opcional).
	char palette_path[64] = {};              ///< Ruta de la paleta (para el host).
	char tiles_path[64] = {};                ///< Ruta del grupo de tiles.
};

/// Ajustes de audio del perfil.
struct AudioOverride {
	char plugin[32] = {}; ///< Nombre del plugin de audio (p. ej. "linear").
};

/// Perfil de una ROM.
struct RomProfile {
	eng::u32 crc = 0;      ///< CRC32 de la ROM.
	char name[48] = {};    ///< Nombre legible.
	GraphicsOverride gfx;  ///< Ajustes gráficos.
	AudioOverride audio;   ///< Ajustes de audio.
};

/// Conjunto de perfiles conocidos.
struct ProfileStore {
	static constexpr int kMax = 32; ///< Capacidad.
	RomProfile items[kMax];         ///< Perfiles.
	int count = 0;                  ///< Número usados.

	/// Busca el perfil de una ROM por su CRC32.
	/// \param crc CRC32 de la ROM.
	/// \return Perfil o `nullptr` si no hay.
	[[nodiscard]] const RomProfile* find(eng::u32 crc) const {
		for (int i = 0; i < count; ++i) {
			if (items[i].crc == crc) {
				return &items[i];
			}
		}
		return nullptr;
	}
};

namespace detail {
/// Copia `src` (texto) en `dst` (buffer de C) recortando si no cabe.
inline void copy_str(char* dst, eng::usize cap, eng::util::StringView src) {
	eng::usize n = src.size() < (cap - 1u) ? src.size() : (cap - 1u);
	for (eng::usize i = 0; i < n; ++i) {
		dst[i] = src[i];
	}
	dst[n] = '\0';
}

/// Parsea hexadecimal sin `0x`. \return `false` si no es válido.
inline bool parse_hex(eng::util::StringView s, eng::u32& out) {
	if (s.size() >= 2u && s[0] == '0' && (s[1] == 'x' || s[1] == 'X')) {
		s.remove_prefix(2u);
	}
	if (s.empty()) {
		return false;
	}
	eng::u32 v = 0;
	for (eng::usize i = 0; i < s.size(); ++i) {
		const char c = s[i];
		eng::u32 d;
		if (c >= '0' && c <= '9') d = static_cast<eng::u32>(c - '0');
		else if (c >= 'a' && c <= 'f') d = static_cast<eng::u32>(c - 'a' + 10);
		else if (c >= 'A' && c <= 'F') d = static_cast<eng::u32>(c - 'A' + 10);
		else return false;
		v = v * 16u + d;
	}
	out = v;
	return true;
}
} // namespace detail

/// Parsea un perfil desde texto. Ignora líneas vacías/comentadas y directivas
/// desconocidas. \param text Contenido del fichero; \param out Perfil de salida.
/// \return `true` si se reconoció al menos el CRC.
inline bool parse_profile(eng::util::StringView text, RomProfile& out) {
	using eng::util::StringView;
	while (!text.empty()) {
		const eng::usize nl = text.find('\n');
		StringView line = (nl == StringView::npos) ? text : text.substr(0u, nl);
		text = (nl == StringView::npos) ? StringView {} : text.substr(nl + 1u);
		while (!line.empty() && (line[0] == ' ' || line[0] == '\t' || line[0] == '\r')) {
			line.remove_prefix(1u);
		}
		if (line.empty() || line[0] == '#') {
			continue;
		}
		const eng::usize sp = line.find(' ');
		if (sp == StringView::npos) {
			continue;
		}
		const StringView key = line.substr(0u, sp);
		StringView val = line.substr(sp + 1u);
		// recorta el valor.
		while (!val.empty() && val[0] == ' ') val.remove_prefix(1u);
		while (!val.empty() && (val[val.size() - 1u] == ' ' || val[val.size() - 1u] == '\r')) {
			val.remove_suffix(1u);
		}

		eng::u32 num = 0;
		if (key == "crc") {
			if (detail::parse_hex(val, num)) {
				out.crc = num;
			}
		} else if (key == "name") {
			detail::copy_str(out.name, sizeof out.name, val);
		} else if (key == "video.bpp") {
			if (detail::parse_hex(val, num)) {
				out.gfx.bpp_bg = static_cast<eng::u8>(num & 0x0Fu);
				out.gfx.bpp_sprite = out.gfx.bpp_bg;
			}
		} else if (key == "video.palette") {
			detail::copy_str(out.gfx.palette_path, sizeof out.gfx.palette_path, val);
		} else if (key == "video.tiles") {
			detail::copy_str(out.gfx.tiles_path, sizeof out.gfx.tiles_path, val);
		} else if (key == "audio.plugin") {
			detail::copy_str(out.audio.plugin, sizeof out.audio.plugin, val);
		}
	}
	return true;
}

} // namespace n2a::enhance
