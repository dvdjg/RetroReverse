#pragma once

/// \file plugins.hpp
/// **Plugins** de vídeo y audio del core libretro: el usuario puede cambiar cómo
/// se convierten los gráficos y el sonido de la NES sin tocar el emulador.
///
/// El núcleo genera el framebuffer de **índices de color NES** (0..63) y las
/// muestras mono del APU; un plugin los transforma al formato del core (XRGB8888
/// y S16 estéreo). Selección por **core option** en RetroArch (`nes_video_plugin`,
/// `nes_audio_plugin`).
///
/// Ejemplos de plugins futuros: vídeo *composite*/NTSC, *scanlines*, reescalado,
/// o *HD texture packs*; audio con filtros paso-bajo o mezclas alternativas.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>

#include "nes_apu.hpp"
#include "nes_palette.hpp"
#include "nes_ppu.hpp"

namespace n2a::retro {

/// Convierte el framebuffer de índices NES a **XRGB8888** (0x00RRGGBB en `u32`).
struct VideoPlugin {
	virtual ~VideoPlugin() = default;

	/// \return Identificador del plugin (nombre de la core option).
	[[nodiscard]] virtual const char* name() const = 0;

	/// Escribe `w*h` píxeles XRGB8888 en `out` a partir de la PPU.
	/// \param ppu PPU con su framebuffer de índices (`fb`).
	/// \param out Destino, `w*h` enteros.
	/// \param w,h Resolución.
	virtual void render(const Ppu& ppu, eng::u32* out, int w, int h) const = 0;
};

/// Plugin por defecto: paleta 2C02G, sin filtros.
struct RawVideoPlugin final : VideoPlugin {
	[[nodiscard]] const char* name() const override { return "raw"; }
	void render(const Ppu& ppu, eng::u32* out, int w, int h) const override {
		const int n = w * h;
		for (int i = 0; i < n; ++i) {
			eng::u8 r;
			eng::u8 g;
			eng::u8 b;
			if (ppu.ext_palette != nullptr) {
				const eng::u16 v = ppu.ext_palette[ppu.fb[i]];
				r = static_cast<eng::u8>(((v >> 8u) & 0x0Fu) * 17u);
				g = static_cast<eng::u8>(((v >> 4u) & 0x0Fu) * 17u);
				b = static_cast<eng::u8>((v & 0x0Fu) * 17u);
			} else {
				const eng::u8 c = static_cast<eng::u8>(ppu.fb[i] & 0x3Fu);
				r = kPaletteRgb[c][0];
				g = kPaletteRgb[c][1];
				b = kPaletteRgb[c][2];
			}
			out[i] = 0xFF000000u | (static_cast<eng::u32>(r) << 16u) |
				 (static_cast<eng::u32>(g) << 8u) | static_cast<eng::u32>(b);
		}
	}
};

/// Plugin de ejemplo: escala de grises (luminancia por la paleta).
struct GrayVideoPlugin final : VideoPlugin {
	[[nodiscard]] const char* name() const override { return "gray"; }
	void render(const Ppu& ppu, eng::u32* out, int w, int h) const override {
		const int n = w * h;
		for (int i = 0; i < n; ++i) {
			const eng::u8 c = static_cast<eng::u8>(ppu.fb[i] & 0x3Fu);
			const eng::u8 r = kPaletteRgb[c][0];
			const eng::u8 g = kPaletteRgb[c][1];
			const eng::u8 b = kPaletteRgb[c][2];
			const eng::u8 y = static_cast<eng::u8>((r * 30u + g * 59u + b * 11u) / 100u);
			out[i] = 0xFF000000u | (static_cast<eng::u32>(y) << 16u) |
				 (static_cast<eng::u32>(y) << 8u) | static_cast<eng::u32>(y);
		}
	}
};

/// Genera audio **estéreo S16 interleaved** a partir del APU.
struct AudioPlugin {
	virtual ~AudioPlugin() = default;

	/// \return Identificador del plugin.
	[[nodiscard]] virtual const char* name() const = 0;

	/// Avisa de la frecuencia de muestreo del core.
	virtual void configure([[maybe_unused]] int sample_rate) {}

	/// Genera `frames` muestras (L,R,L,R,...) en `out`.
	virtual void generate(Apu& apu, eng::s16* out, int frames) const = 0;
};

/// Plugin por defecto: mono del APU duplicado a estéreo.
struct LinearAudioPlugin final : AudioPlugin {
	[[nodiscard]] const char* name() const override { return "linear"; }
	void generate(Apu& apu, eng::s16* out, int frames) const override {
		eng::s16 mono[256];
		int done = 0;
		while (done < frames) {
			int n = frames - done;
			if (n > 256) {
				n = 256;
			}
			apu.generate_samples(eng::Span<eng::s16> {mono, static_cast<eng::usize>(n)});
			for (int i = 0; i < n; ++i) {
				out[(done + i) * 2 + 0] = mono[i];
				out[(done + i) * 2 + 1] = mono[i];
			}
			done += n;
		}
	}
};

/// Plugin de ejemplo: silencio (útil para depurar vídeo).
struct MuteAudioPlugin final : AudioPlugin {
	[[nodiscard]] const char* name() const override { return "mute"; }
	void generate([[maybe_unused]] Apu& apu, eng::s16* out, int frames) const override {
		for (int i = 0; i < frames * 2; ++i) {
			out[i] = 0;
		}
	}
};

/// Registro de plugins disponibles y resolución por nombre.
struct Plugins {
	/// \return Instancia del plugin de vídeo por defecto.
	[[nodiscard]] static VideoPlugin& default_video() {
		static RawVideoPlugin p;
		return p;
	}
	/// \return Instancia del plugin de audio por defecto.
	[[nodiscard]] static AudioPlugin& default_audio() {
		static LinearAudioPlugin p;
		return p;
	}
	/// Busca un plugin de vídeo por nombre (o el por defecto si no se encuentra).
	[[nodiscard]] static VideoPlugin& video(const char* name) {
		static GrayVideoPlugin gray;
		if (name != nullptr && name[0] == 'g' && name[1] == 'r') {
			return gray;
		}
		return default_video();
	}
	/// Busca un plugin de audio por nombre (o el por defecto si no se encuentra).
	[[nodiscard]] static AudioPlugin& audio(const char* name) {
		static MuteAudioPlugin mute;
		if (name != nullptr && name[0] == 'm') {
			return mute;
		}
		return default_audio();
	}
};

} // namespace n2a::retro
