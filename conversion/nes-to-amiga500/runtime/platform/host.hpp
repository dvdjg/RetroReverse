#pragma once

/// \file host.hpp
/// **Abstracción de plataforma**: la interfaz `Host` separa la implementación del
/// emulador/runtime (CPU, PPU, APU, mappers; sin STL ni hardware concreto) del
/// **medio de ejecución** (Amiga 500 o SDL3 en PC/navegador).
///
/// El runner (`runtime/host/main.cpp`) y `NesSystem` solo conocen `Host`; cada
/// plataforma aporta su implementación:
/// - [`sdl_host.hpp`](sdl_host.hpp): SDL3 (PC y navegador vía Emscripten).
/// - Amiga: ver [`amiga/README.md`](amiga/README.md) (Copper/Blitter/Paula/teclado).
///
/// Así el mismo núcleo corre en Amiga o en SDL3 sin cambios.

#include <eng/core/types/types.hpp>

namespace n2a {

/// Estado del mando NES (8 bits) que produce cada backend.
struct InputState {
	bool a = false;
	bool b = false;
	bool select = false;
	bool start = false;
	bool up = false;
	bool down = false;
	bool left = false;
	bool right = false;

	/// Empaqueta el estado en el orden del 6502/`$4016`
	/// (A, B, Select, Start, Up, Down, Left, Right).
	/// \return Byte con un bit por botón.
	[[nodiscard]] eng::u8 to_pad() const {
		eng::u8 v = 0u;
		if (a) v = static_cast<eng::u8>(v | 0x01u);
		if (b) v = static_cast<eng::u8>(v | 0x02u);
		if (select) v = static_cast<eng::u8>(v | 0x04u);
		if (start) v = static_cast<eng::u8>(v | 0x08u);
		if (up) v = static_cast<eng::u8>(v | 0x10u);
		if (down) v = static_cast<eng::u8>(v | 0x20u);
		if (left) v = static_cast<eng::u8>(v | 0x40u);
		if (right) v = static_cast<eng::u8>(v | 0x80u);
		return v;
	}
};

/// Interfaz de plataforma: ventana/vídeo, audio, entrada, tiempo y ciclo de vida.
///
/// \note El núcleo del emulador no depende de SDL ni de hardware Amiga; solo de
/// esta interfaz. Cada método documenta su contrato para poder implementarlo en
/// una plataforma nueva.
struct Host {
	virtual ~Host() = default;

	/// Inicializa la plataforma.
	/// \param title       Título de la ventana (puede ignorarse en Amiga).
	/// \param width,height Resolución visible (256×240).
	/// \param sample_rate Frecuencia de audio mono (p. ej. 22050).
	/// \return `true` si todo quedó listo.
	virtual bool init(const char* title, int width, int height, int sample_rate) = 0;

	/// Libera los recursos de la plataforma (idempotente).
	virtual void shutdown() = 0;

	/// Muestra un frame RGB de 8 bits (`width*height*3`, en orden R,G,B).
	/// \param rgb Puntero a los píxeles; debe medir `width*height*3`.
	virtual void present(const eng::u8* rgb) = 0;

	/// Encola audio mono con signo de 16 bits.
	/// \param frames Muestras; no bloquea (el backend decide el buffering).
	/// \param count  Número de muestras.
	virtual void audio_write(const eng::s16* frames, int count) = 0;

	/// Procesa la entrada y los eventos de sistema.
	/// \param in Salida: estado del mando NES para este frame.
	/// \return `false` si el usuario pidió salir (ventana cerrada).
	virtual bool poll(InputState& in) = 0;

	/// Espera `ms` milisegundos (para limitar a ~60 Hz).
	virtual void delay_ms(int ms) = 0;

	/// Reloj monótono en milisegundos (para cálculo de FPS/tiempo).
	/// \return Milisegundos transcurridos desde un origen arbitrario.
	virtual eng::u64 ticks_ms() = 0;
};

} // namespace n2a
