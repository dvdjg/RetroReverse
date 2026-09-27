// sdl_host.cpp — implementación de `SdlHost` sobre SDL3.
//
// Ventana + textura RGB (SDL_PIXELFORMAT_RGB24), stream de audio mono S16 y
// teclado mapeado al mando NES. Portátil a Windows/Linux/macOS y a navegador
// (Emscripten).

#include "sdl_host.hpp"

#include <SDL3/SDL.h>

namespace n2a {

/// Inicializa SDL3 (vídeo+audio+gamepad), crea la ventana, el renderer, la
/// textura de streaming y el stream de audio. \return `true` si todo va bien.
bool SdlHost::init(const char* title, int width, int height, int sample_rate) {
	if (!SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_GAMEPAD)) {
		SDL_Log("SDL_Init: %s", SDL_GetError());
		return false;
	}
	w = width;
	h = height;
	const int s = initial_scale > 0 ? initial_scale : 1;
	win = SDL_CreateWindow(title, width * s, height * s, SDL_WINDOW_RESIZABLE);
	if (win == nullptr) {
		SDL_Log("SDL_CreateWindow: %s", SDL_GetError());
		return false;
	}
	ren = SDL_CreateRenderer(win, nullptr);
	if (ren == nullptr) {
		SDL_Log("SDL_CreateRenderer: %s", SDL_GetError());
		return false;
	}
	// Presentación lógica con **escala entera**: el frame 256x240 se reescala a la
	// ventana (reescalable) manteniendo el aspecto y píxeles nítidos; al redimensionar
	// se adapta (letterbox al mayor múltiplo entero).
	SDL_SetRenderLogicalPresentation(ren, width, height, SDL_LOGICAL_PRESENTATION_INTEGER_SCALE);
	tex = SDL_CreateTexture(ren, SDL_PIXELFORMAT_RGB24, SDL_TEXTUREACCESS_STREAMING, width, height);
	if (tex == nullptr) {
		SDL_Log("SDL_CreateTexture: %s", SDL_GetError());
		return false;
	}
	SDL_SetTextureScaleMode(tex, SDL_SCALEMODE_NEAREST);

	SDL_AudioSpec spec {};
	spec.format = SDL_AUDIO_S16;
	spec.channels = 1;
	spec.freq = sample_rate;
	stream = SDL_OpenAudioDeviceStream(SDL_AUDIO_DEVICE_DEFAULT_PLAYBACK, &spec, nullptr, nullptr);
	if (stream != nullptr) {
		SDL_ResumeAudioStreamDevice(stream);
	}
	return true;
}

/// Libera textura, renderer, ventana, audio y cierra SDL3.
void SdlHost::shutdown() {
	if (stream != nullptr) {
		SDL_DestroyAudioStream(stream);
		stream = nullptr;
	}
	if (tex != nullptr) {
		SDL_DestroyTexture(tex);
		tex = nullptr;
	}
	if (ren != nullptr) {
		SDL_DestroyRenderer(ren);
		ren = nullptr;
	}
	if (win != nullptr) {
		SDL_DestroyWindow(win);
		win = nullptr;
	}
	SDL_Quit();
}

/// Sube el frame RGB a la textura y lo dibuja escalado a la ventana.
void SdlHost::present(const eng::u8* rgb) {
	if (tex == nullptr || ren == nullptr) {
		return;
	}
	SDL_UpdateTexture(tex, nullptr, rgb, w * 3);
	SDL_RenderClear(ren);
	SDL_RenderTexture(ren, tex, nullptr, nullptr);
	SDL_RenderPresent(ren);
}

/// Pausa/reanuda el audio; al pausar vacía lo encolado (corta el sonido residual).
void SdlHost::audio_pause(bool paused) {
	if (stream == nullptr) {
		return;
	}
	if (paused) {
		SDL_ClearAudioStream(stream);
		SDL_PauseAudioStreamDevice(stream);
	} else {
		SDL_ResumeAudioStreamDevice(stream);
	}
}

/// Encola muestras mono S16 en el stream de audio (sin bloquear).
void SdlHost::audio_write(const eng::s16* frames, int count) {
	if (stream == nullptr || count <= 0) {
		return;
	}
	SDL_PutAudioStreamData(stream, frames, count * static_cast<int>(sizeof(eng::s16)));
}

/// \return `true` si `scancode` está pulsada (estado por nivel de SDL).
bool SdlHost::key_down(int scancode) const {
	const bool* k = SDL_GetKeyboardState(nullptr);
	return k[scancode];
}

/// Procesa eventos y traduce el **estado** del teclado a mando NES. Al leer el
/// estado por nivel (no eventos) se soportan varias teclas a la vez.
/// \return `false` si se cierra la ventana o se pulsa `Esc`.
bool SdlHost::poll(InputState& in) {
	SDL_Event e;
	while (SDL_PollEvent(&e)) {
		if (e.type == SDL_EVENT_QUIT) {
			quit_window = true;
			return false;
		}
	}
	const bool* k = SDL_GetKeyboardState(nullptr);
	in.a = k[SDL_SCANCODE_Z] || k[SDL_SCANCODE_SPACE];
	in.b = k[SDL_SCANCODE_X];
	in.start = k[SDL_SCANCODE_RETURN] || k[SDL_SCANCODE_KP_ENTER];
	in.select = k[SDL_SCANCODE_BACKSPACE] || k[SDL_SCANCODE_RSHIFT];
	in.up = k[SDL_SCANCODE_UP];
	in.down = k[SDL_SCANCODE_DOWN];
	in.left = k[SDL_SCANCODE_LEFT];
	in.right = k[SDL_SCANCODE_RIGHT];
	if (k[SDL_SCANCODE_ESCAPE]) {
		escape_menu = true;
		return false;
	}
	return true;
}

bool SdlHost::menu_poll(int& action) {
	action = 0;
	SDL_Event e;
	while (SDL_PollEvent(&e)) {
		if (e.type == SDL_EVENT_QUIT) {
			quit_window = true;
			return false;
		}
		if (e.type == SDL_EVENT_KEY_DOWN) {
			switch (e.key.scancode) {
			case SDL_SCANCODE_UP: action = 1; break;
			case SDL_SCANCODE_DOWN: action = 2; break;
			case SDL_SCANCODE_RETURN:
			case SDL_SCANCODE_KP_ENTER:
			case SDL_SCANCODE_SPACE: action = 3; break;
			case SDL_SCANCODE_V: action = 4; break;
			case SDL_SCANCODE_S: action = 6; break;
			case SDL_SCANCODE_ESCAPE:
			case SDL_SCANCODE_Q: action = 5; break;
			default: break;
			}
			if (action != 0) {
				return true;
			}
		}
	}
	return true;
}

/// Pausa el hilo `ms` milisegundos.
void SdlHost::delay_ms(int ms) {
	SDL_Delay(static_cast<Uint32>(ms));
}

/// \return Milisegundos desde que arrancó SDL.
eng::u64 SdlHost::ticks_ms() {
	return static_cast<eng::u64>(SDL_GetTicks());
}

} // namespace n2a
