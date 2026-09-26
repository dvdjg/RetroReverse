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
#include "../plugin/n2a_loader.hpp"
#include "fastcpu.hpp"
#include "nes_system.hpp"
#include "rom_loader.hpp"
#include "sdl_host.hpp"

// Host **codegen** (opcional): con `-DN2A_CODEGEN` se enlaza el transpilado de una
// ROM (`build/codegen_rom.cpp`, generado por build-pc.ps1 -CodegenRom) y se ejecuta
// con el motor `codegen` en vez del intérprete/rápido.
#ifdef N2A_CODEGEN
#define N2A_NO_HOST_MAIN
#include "codegen_rom.cpp"
#endif

namespace {

n2a::LoadedRom g_rom;   ///< ROM y mapper.
n2a::NesSystem g_nes;   ///< Sistema NES (CPU+PPU+APU+mapper).
n2a::FastCpu g_fast;    ///< Ejecutor rápido (si `NES_ENGINE=fast`).
n2a::SdlHost g_host;    ///< Backend SDL3.
eng::u8 g_rgb[n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH * 3]; ///< Frame RGB.
eng::s16 g_audio[1024]; ///< Búfer de audio por frame.
int g_frames_limit = -1; ///< Nº de frames a ejecutar (-1 = infinito).
int g_frame = 0;         ///< Frames ejecutados.

#ifdef N2A_CODEGEN
n2a::FastCpu g_gen_fast; ///< Fallback (RAM/saltos calculados) del motor codegen.

/// Hook `FastRun` del motor codegen: ejecuta el bloque generado de `cpu.PC` y
/// devuelve sus ciclos. Si no hay bloque (RAM/salto calculado), usa el ejecutor
/// rápido (que decodifica RAM bajo demanda); si tampoco, devuelve 0 y `NesSystem`
/// resuelve esa instrucción con el intérprete.
int gen_run(void* /*ctx*/, n2a::CPU& cpu, n2a::NESMemory& mem, int /*budget*/, int* n) {
	const eng::u16 pc = cpu.PC;
	if (dispatch_table[pc] == nullptr) {
		const int c = n2a::FastCpu::step(&g_gen_fast, cpu, mem);
		if (n != nullptr) {
			*n = (c > 0) ? 1 : 0;
		}
		return c;
	}
	const eng::u32 before = cpu.cycles;
	dispatch_table[pc](cpu);
	if (n != nullptr) {
		*n = 1;
	}
	const eng::u32 d = cpu.cycles - before;
	return d > 0u ? static_cast<int>(d) : 1;
}
#endif

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

/// ¿`s` termina con `suf`? (para detectar `.n2x`).
static bool ends_with(const char* s, const char* suf) {
	const eng::usize ns = std::strlen(s);
	const eng::usize nf = std::strlen(suf);
	return ns >= nf && std::strcmp(s + (ns - nf), suf) == 0;
}

/// Plugin transpilado cargado (si `argv[1]` es un `.n2x`).
static n2a::TranspiledGame g_game;
static n2a::Mapper g_cart;

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: nes_sdl <rom.nes|juego.n2x> [frames]\n");
		return 1;
	}
	const bool is_plugin = ends_with(argv[1], ".n2x");
	if (is_plugin) {
		// Plugin transpilado (`.n2x`): el cartucho y el código vienen del plugin;
		// el intérprete/PPU/APU/mapper los pone este host (fallback en RAM/saltos).
		if (!g_game.load(argv[1])) {
			std::printf("error: plugin '%s' invalido o ABI/arquitectura incompatible\n",
				    argv[1]);
			return 1;
		}
		g_game.fill_mapper(g_cart);
		g_nes.load_mapper(g_cart);
		g_nes.reset();
		g_nes.fast_ctx = &g_game;
		g_nes.fast_run = &n2a::TranspiledGame::fast_run;
		std::printf("nes_sdl: plugin='%s' mapper=%d PRG=%u CHR=%u motor=codegen\n", argv[1],
			    g_game.fn_mapper(), g_game.fn_prg_size(), g_game.fn_chr_size());
	} else {
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
#ifdef N2A_CODEGEN
	// Motor codegen: usa el transpilado enlazado (fallback a FastCpu/intérprete).
	{
		n2a::NESMemory probe;
		probe.prg = g_rom.mapper.prg;
		probe.prg_size = g_rom.mapper.prg_size;
		g_gen_fast.build(g_rom.mapper.prg, g_rom.mapper.prg_size, probe.read16(0xFFFCu),
				 probe.read16(0xFFFAu), probe.read16(0xFFFEu));
		init_dispatch_table();
		g_nes.fast_ctx = &g_gen_fast;
		g_nes.fast_run = &gen_run;
	}
#endif
#ifdef N2A_CODEGEN
	const char* g_motor = "codegen";
#else
	const char* g_motor = g_nes.fast_run != nullptr ? "rapido(bloques)" : "interprete";
#endif
	std::printf("nes_sdl: mapper=%u PRG=%u CHR=%u motor=%s\n", g_rom.mapper_no, g_rom.prg_size,
		    g_rom.chr_size, g_motor);

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
