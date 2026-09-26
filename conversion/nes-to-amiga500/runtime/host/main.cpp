// main.cpp — runner del nodo NES→Amiga usando el backend **SDL3**.
//
// Es independiente del hardware: usa la interfaz `Host` (ver `platform/host.hpp`)
// y `NesSystem`. El mismo `NesSystem` corre en Amiga con un `Host` para Copper/
// Blitter/Paula. Compila en PC y (con Emscripten) en navegador.
//
// Uso: nes_sdl <rom.nes> [frames]   (sin `frames` = bucle hasta cerrar)

#include <cstdio>
#include <cstdlib>
#include <cstring>

#define SDL_MAIN_HANDLED
#include <SDL3/SDL.h>
#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif

#include "../enhance/profile_io.hpp"
#include "fastcpu.hpp"
#include "nes_system.hpp"
#include "rom_loader.hpp"
#include "sdl_host.hpp"

namespace {

n2a::LoadedRom g_rom;   ///< ROM y mapper.
n2a::NesSystem g_nes;   ///< Sistema NES (CPU+PPU+APU+mapper).
n2a::FastCpu g_fast;    ///< Ejecutor rápido (si `NES_ENGINE=fast`).
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

	// Motor de CPU: con NES_ENGINE=fast se usa el ejecutor pre-decodificado; si no,
	// el intérprete. El ejecutor cae al intérprete en los opcodes no cubiertos.
	const char* engine = std::getenv("NES_ENGINE");
	if (engine != nullptr && std::strcmp(engine, "fast") == 0 &&
	    g_fast.build(g_rom.mapper.prg, g_rom.mapper.prg_size, g_nes.mem.read16(0xFFFCu),
			 g_nes.mem.read16(0xFFFAu), g_nes.mem.read16(0xFFFEu))) {
		g_nes.fast_ctx = &g_fast;
		g_nes.fast_step = &n2a::FastCpu::step;
		g_nes.fast_run = &n2a::FastCpu::run_block;
	}
	std::printf("nes_sdl: mapper=%u PRG=%u CHR=%u motor=%s\n", g_rom.mapper_no, g_rom.prg_size,
		    g_rom.chr_size, g_nes.fast_run != nullptr ? "rapido(bloques)" : "interprete");

	// Ajustes por ROM (opcional): "<rom>.n2a" con pack de tiles y/o paleta.
	static n2a::enhance::AppliedProfile g_profile;
	const eng::u32 crc = n2a::enhance::crc32(g_rom.rom, g_rom.file_size);
	if (n2a::enhance::load_rom_profile(argv[1], crc, g_profile)) {
		if (g_profile.has_provider) {
			g_nes.ppu.tile_provider = &g_profile.provider;
		}
		if (g_profile.has_palette) {
			g_nes.ppu.ext_palette = g_profile.palette_ptr();
		}
		std::printf("nes_sdl: perfil '%s' bpp=%u pack=%d paleta=%d\n", g_profile.profile.name,
			    g_profile.profile.gfx.bpp_bg, static_cast<int>(g_profile.has_provider),
			    static_cast<int>(g_profile.has_palette));
	}

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
