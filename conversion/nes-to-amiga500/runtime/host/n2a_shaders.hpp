#pragma once

/// \file n2a_shaders.hpp
/// **Filtros de vídeo** (post-proceso sobre el framebuffer RGB 256x240) del host,
/// seleccionables en la configuración y en partida. Son efectos de CPU simples y
/// portables (sin GPU ni dependencias); el reescalado a la ventana lo hace el
/// `SdlHost` con escala entera, así que estos filtros actúan por *píxel NES*.
///
/// - `none`: sin filtro.
/// - `scanlines`: oscurece las líneas impares (simula el barrido CRT).
/// - `crt80s`: TV de los 80 — scanlines + **beam** (banda brillante suavizada) +
///   viñeta y un ligero tono cálido.

#include <cstring>

#include <eng/core/types/types.hpp>

namespace n2a {

/// Nombres de los shaders (índice = id). Debe coincidir con `shader_apply`.
inline const char* const kShaderNames[] = {"none", "scanlines", "crt80s"};
/// Número de shaders disponibles.
inline constexpr int kShaderCount = 3;

/// \return El id del shader llamado `name` (o `2` = `crt80s` si no se reconoce).
inline int shader_index(const char* name) {
	for (int i = 0; i < kShaderCount; ++i) {
		if (std::strcmp(name, kShaderNames[i]) == 0) {
			return i;
		}
	}
	return 2;
}

/// Aplica el shader `id` **in situ** al framebuffer RGB (`w*h*3` bytes).
/// \param id Índice de shader (`0..kShaderCount-1`).
/// \param rgb Búfer RGB de 8 bits por canal.
/// \param w Ancho en píxeles.
/// \param h Alto en píxeles.
inline void shader_apply(int id, eng::u8* rgb, int w, int h) {
	if (id <= 0) {
		return;
	}
	const bool crt = (id >= 2);
	for (int y = 0; y < h; ++y) {
		// Scanlines: líneas impares más oscuras.
		const int line_mul = (y & 1) ? 55 : 100; // %
		// "Beam": suaviza el brillo según la distancia a los tercios de la pantalla
		// (banda central algo más brillante, como el haz del tubo).
		int beam = 100;
		if (crt) {
			const int d = (y * 3) % h - h / 2; // -h/2..h/2
			beam = 100 - (d * d * 4) / (h * h); // parábola suave
		}
		for (int x = 0; x < w; ++x) {
			eng::u8* px = rgb + (static_cast<eng::usize>(y) * static_cast<eng::usize>(w) +
					     static_cast<eng::usize>(x)) * 3u;
			int m = line_mul;
			if (crt) {
				// Viñeta horizontal (bordes ligeramente más oscuros).
				const int dx = x - w / 2;
				const int vig = 100 - (dx * dx * 3) / (w * w);
				m = m * beam * vig / 10000;
				// Tono cálido (R y G algo más que B).
				px[0] = static_cast<eng::u8>(px[0] * m / 100);
				px[1] = static_cast<eng::u8>(px[1] * m / 100);
				px[2] = static_cast<eng::u8>(px[2] * m * 92 / 10000);
			} else {
				px[0] = static_cast<eng::u8>(px[0] * m / 100);
				px[1] = static_cast<eng::u8>(px[1] * m / 100);
				px[2] = static_cast<eng::u8>(px[2] * m / 100);
			}
		}
	}
}

} // namespace n2a
