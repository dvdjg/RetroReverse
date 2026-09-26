// main.cpp — runner del nodo NES→Amiga usando el backend **SDL3**.
//
// Es independiente del hardware: usa la interfaz `Host` (ver `platform/host.hpp`)
// y `NesSystem`. El mismo `NesSystem` corre en Amiga con un `Host` para Copper/
// Blitter/Paula. Compila en PC y (con Emscripten) en navegador.
//
// Uso: nes_sdl <rom.nes> [frames]   (sin `frames` = bucle hasta cerrar)

#include <cstdio>
#include <cstdlib>

#define SDL_MAIN_HANDLED
#include <SDL3/SDL.h>
#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "nes_system.hpp"
#include "rom_loader.hpp"
#include "sdl_host.hpp"

namespace {

n2a::LoadedRom g_rom;   ///< ROM y mapper.
n2a::NesSystem g_nes;   ///< Sistema NES (CPU+PPU+APU+mapper).
n2a::SdlHost g_host;    ///< Backend SDL3.
eng::u8 g_rgb[n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH * 3]; ///< Frame RGB.
eng::s16 g_audio[1024]; ///< Búfer de audio por frame.
int g_frames_limit = -1; ///< Nº de frames a ejecutar (-1 = infinito).
int g_frame = 0;         ///< Frames ejecutados.

/// Ejecuta un frame completo (entrada → emulación → vídeo/audio).
/// \return `false` si hay que terminar (ventana cerrada o límite alcanzado).
int emu_tick_once() {
	n2a::InputState in;
	if (!g_host.poll(in)) {
		return 0;
	}
	g_nes.pad1 = in.to_pad();
	g_nes.run_frame();
	g_nes.frame_rgb(eng::Span<eng::u8> {g_rgb, sizeof g_rgb});
	g_host.present(g_rgb);
	g_nes.apu.generate_samples(eng::Span<eng::s16> {g_audio, 512});
	g_host.audio_write(g_audio, 512);
	++g_frame;
	if (g_frames_limit > 0 && g_frame >= g_frames_limit) {
		return 0;
	}
	return 1;
}

#ifdef __EMSCRIPTEN__
/// Callback del bucle principal en el navegador.
void emu_tick() {
	if (emu_tick_once() == 0) {
		emscripten_cancel_main_loop();
	}
}
#endif

} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: nes_sdl <rom.nes> [frames]\n");
		return 1;
	}
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar '%s' (iNES NROM/UxROM/CNROM/MMC1)\n", argv[1]);
		return 1;
	}
	g_nes.load_mapper(g_rom.mapper);
	g_nes.reset();
	std::printf("nes_sdl: mapper=%u PRG=%u CHR=%u\n", g_rom.mapper_no, g_rom.prg_size, g_rom.chr_size);

	if (!g_host.init("NES -> SDL3", n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH, 22050)) {
		std::printf("error: no se pudo iniciar SDL3\n");
		return 1;
	}
	g_frames_limit = (argc > 2) ? std::atoi(argv[2]) : -1;

#ifdef __EMSCRIPTEN__
	emscripten_set_main_loop(emu_tick, 0, 1);
#else
	while (true) {
		if (emu_tick_once() == 0) {
			break;
		}
		g_host.delay_ms(16);  // ~60 Hz
	}
	g_host.shutdown();
#endif
	return 0;
}
