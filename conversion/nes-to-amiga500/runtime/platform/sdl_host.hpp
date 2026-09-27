#pragma once

/// \file sdl_host.hpp
/// Backend **SDL3** de la interfaz `Host`: ventana + textura RGB para el vídeo,
/// stream de audio mono S16, teclado/gamepad como mando NES y reloj del sistema.
///
/// Compila en PC (Windows/Linux/macOS) y en navegador con Emscripten (SDL3 es
/// multiplataforma). La implementación está en `runtime/host/sdl_host.cpp`.

#include "host.hpp"

struct SDL_Window;      ///< Ventana SDL3 (oculta en la cabecera).
struct SDL_Renderer;    ///< Renderer SDL3.
struct SDL_Texture;     ///< Textura de streaming con el frame.
struct SDL_AudioStream; ///< Stream de audio SDL3.

namespace n2a {

/// Implementación de `Host` sobre SDL3.
struct SdlHost : Host {
	SDL_Window* win = nullptr;         ///< Ventana.
	SDL_Renderer* ren = nullptr;       ///< Renderer 2D.
	SDL_Texture* tex = nullptr;        ///< Textura RGB del frame.
	SDL_AudioStream* stream = nullptr; ///< Stream de audio mono S16.
	int w = 0;                         ///< Ancho del frame (nativo, p. ej. 256).
	int h = 0;                         ///< Alto del frame (nativo, p. ej. 240).
	int initial_scale = 4;             ///< Escala de la ventana al arrancar (entera).
	bool quit_window = false;  ///< `poll` devolvió `false` por cierre de ventana.
	bool escape_menu = false;  ///< `poll` devolvió `false` por `Esc` (volver al gestor).

	/// \return Pulsación baja-nivel de `scancode` (soporta teclas simultáneas).
	[[nodiscard]] bool key_down(int scancode) const;

	bool init(const char* title, int width, int height, int sample_rate) override;
	void shutdown() override;
	void present(const eng::u8* rgb) override;
	void audio_write(const eng::s16* frames, int count) override;
	/// Pausa/reanuda el audio; al pausar **vacía** el stream (evita que siga sonando
	/// lo ya encolado al volver al menú).
	void audio_pause(bool paused);
	bool poll(InputState& in) override;
	/// Entrada del **gestor** (menú): teclas crudas de navegación.
	/// \param action 0=nada, 1=arriba, 2=abajo, 3=Enter, 4=V(verificar), 5=Salir.
	/// \return `false` si se cerró la ventana.
	bool menu_poll(int& action);
	void delay_ms(int ms) override;
	eng::u64 ticks_ms() override;
};

} // namespace n2a
