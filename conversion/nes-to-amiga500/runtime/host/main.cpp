// main.cpp — runner del nodo NES→Amiga usando el backend **SDL3**.
//
// Es independiente del hardware: usa la interfaz `Host` (ver `platform/host.hpp`)
// y `NesSystem`. El mismo `NesSystem` corre en Amiga con un `Host` para Copper/
// Blitter/Paula. Compila en PC y (con Emscripten) en navegador.
//
// Uso: nes_sdl <rom.nes> [frames]   (sin `frames` = bucle hasta cerrar)

#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <string>
#include <vector>

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

/// Verificación headless: ejecuta el plugin y el intérprete sobre la misma ROM y
/// compara RAM y framebuffer. \return 0 si coinciden, 2 si no, 1 si error.
static int verify_n2x(const char* path, int frames) {
	n2a::TranspiledGame vg;
	if (!vg.load(path)) {
		std::printf("error: plugin '%s' invalido o ABI incompatible\n", path);
		return 1;
	}
	n2a::Mapper cart;
	vg.fill_mapper(cart);
	n2a::NesSystem ref;
	ref.load_mapper(cart);
	ref.reset();
	n2a::NesSystem gen;
	gen.load_mapper(cart);
	gen.reset();
	gen.fast_ctx = &vg;
	gen.fast_run = &n2a::TranspiledGame::fast_run;
	for (int i = 0; i < frames; ++i) {
		ref.run_frame();
	}
	for (int i = 0; i < frames; ++i) {
		gen.run_frame();
	}
	int ram = 0;
	for (unsigned i = 0; i < 0x800u; ++i) {
		if (ref.mem.ram[i] != gen.mem.ram[i]) {
			++ram;
		}
	}
	int fb = 0;
	const int fb_total = n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH;
	for (int i = 0; i < fb_total; ++i) {
		if (ref.ppu.fb[i] != gen.ppu.fb[i]) {
			++fb;
		}
	}
		std::printf("verify '%s' (%d frames): RAM %d/2048, pixeles %d/%d -> %s\n", path, frames, ram,
		    fb, fb_total, (ram == 0 && fb == 0) ? "IDENTICO" : "DIVERGE");
	return (ram == 0 && fb == 0) ? 0 : 2;
}

// --- Gestor: lista de `.n2x` y su sidecar ---
/// Entrada del gestor (un `.n2x` y metadatos del sidecar).
struct MenEntry {
	std::string path; ///< Ruta del `.n2x`.
	std::string name; ///< Nombre del fichero.
	std::string arch; ///< Plataforma (del sidecar).
	std::string crc;  ///< CRC32 de la ROM (del sidecar).
};

/// Lee el campo `"key"` del sidecar JSON `path` (cadena o número). Vacío si no está.
static std::string json_field(const std::string& path, const char* key) {
	std::ifstream f(path);
	if (!f) {
		return std::string();
	}
	const std::string s((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
	const std::string pat = std::string("\"") + key + "\"";
	const std::size_t k = s.find(pat);
	if (k == std::string::npos) {
		return std::string();
	}
	const std::size_t c = s.find(':', k);
	if (c == std::string::npos) {
		return std::string();
	}
	std::size_t i = c + 1u;
	while (i < s.size() && (s[i] == ' ' || s[i] == '\t')) {
		++i;
	}
	if (i < s.size() && s[i] == '"') {
		++i;
		const std::size_t e = s.find('"', i);
		return s.substr(i, e - i);
	}
	std::size_t e = i;
	while (e < s.size() && s[e] != ',' && s[e] != '}' && s[e] != '\n') {
		++e;
	}
	std::string v = s.substr(i, e - i);
	while (!v.empty() && (v.back() == ' ' || v.back() == '\r')) {
		v.pop_back();
	}
	return v;
}

/// Escanea `dir` buscando `.n2x` y lee su sidecar (arch/CRC).
static void scan_n2x(const char* dir, std::vector<MenEntry>& out) {
	std::error_code ec;
	std::filesystem::directory_iterator it(dir, ec);
	const std::filesystem::directory_iterator end;
	for (; !ec && it != end; it.increment(ec)) {
		const std::filesystem::path& p = it->path();
		if (p.extension() == ".n2x") {
			MenEntry m;
			m.path = p.string();
			m.name = p.filename().string();
			m.arch = json_field(m.path + ".json", "arch");
			m.crc = json_field(m.path + ".json", "rom_crc32");
			out.push_back(std::move(m));
		}
	}
}

/// Dibuja la lista del gestor con el texto incorporado de SDL3.
static void draw_manager(n2a::SdlHost& host, const std::vector<MenEntry>& list, int sel,
			 const std::string& msg) {
	SDL_Renderer* r = host.ren;
	SDL_SetRenderScale(r, 1.0f, 1.0f);
	SDL_SetRenderDrawColor(r, 0, 0, 0, 255);
	SDL_RenderClear(r);
	SDL_SetRenderDrawColor(r, 255, 255, 255, 255);
	SDL_RenderDebugText(r, 4.0f, 4.0f, "Gestor de juegos transpilados (.n2x)");
	SDL_SetRenderDrawColor(r, 200, 180, 120, 255);
	SDL_RenderDebugText(r, 4.0f, 14.0f, "Flechas=sel  Enter=jugar  V=verificar  Esc=salir");
	SDL_SetRenderDrawColor(r, 255, 150, 150, 255);
	SDL_RenderDebugText(r, 4.0f, 24.0f, "(c) codigo nativo: carga bajo tu responsabilidad");
	int y = 40;
	if (list.empty()) {
		SDL_SetRenderDrawColor(r, 255, 120, 120, 255);
		SDL_RenderDebugText(r, 4.0f, static_cast<float>(y), "No hay .n2x aqui (usa --emit-lib).");
	} else {
		for (std::size_t i = 0; i < list.size() && y < 228; ++i, y += 10) {
			std::string line = (static_cast<int>(i) == sel) ? "> " : "  ";
			line += list[i].name;
			if (!list[i].arch.empty()) {
				line += "  [" + list[i].arch + "]";
			}
			if (static_cast<int>(i) == sel) {
				SDL_SetRenderDrawColor(r, 40, 60, 120, 255);
				SDL_FRect bg {0.0f, static_cast<float>(y) - 1.0f, 256.0f, 10.0f};
				SDL_RenderFillRect(r, &bg);
				SDL_SetRenderDrawColor(r, 255, 255, 255, 255);
			} else {
				SDL_SetRenderDrawColor(r, 200, 200, 200, 255);
			}
			SDL_RenderDebugText(r, 4.0f, static_cast<float>(y), line.c_str());
		}
	}
	if (!msg.empty()) {
		SDL_SetRenderDrawColor(r, 120, 255, 120, 255);
		SDL_RenderDebugText(r, 4.0f, 232.0f, msg.c_str());
	}
	SDL_RenderPresent(r);
}

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: nes_sdl <rom.nes|juego.n2x> [frames]\n");
		std::printf("     nes_sdl --verify  <juego.n2x> [frames]   (compara con el interprete)\n");
		std::printf("     nes_sdl --manager <dir>                  (gestor de .n2x)\n");
		return 1;
	}
	if (std::strcmp(argv[1], "--verify") == 0) {
		if (argc < 3) {
			std::printf("uso: nes_sdl --verify <juego.n2x> [frames]\n");
			return 1;
		}
		return verify_n2x(argv[2], (argc > 3) ? std::atoi(argv[3]) : 60);
	}
	if (std::strcmp(argv[1], "--manager") == 0) {
		const char* dir = (argc > 2) ? argv[2] : ".";
		std::vector<MenEntry> list;
		scan_n2x(dir, list);
		std::sort(list.begin(), list.end(),
			  [](const MenEntry& a, const MenEntry& b) { return a.name < b.name; });
		if (!g_host.init("Gestor NES .n2x", n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH,
				 22050)) {
			std::printf("error: no se pudo iniciar SDL3\n");
			return 1;
		}
		int sel = 0;
		std::string msg;
		for (;;) {
			draw_manager(g_host, list, sel, msg);
			int act = 0;
			if (!g_host.menu_poll(act)) {
				break; // ventana cerrada
			}
			const int n = static_cast<int>(list.size());
			if (act == 1 && n > 0) {
				sel = (sel + n - 1) % n;
			} else if (act == 2 && n > 0) {
				sel = (sel + 1) % n;
			} else if (act == 4 && n > 0) {
				// Verificar: compara plugin vs intérprete (headless).
				const int r = verify_n2x(list[sel].path.c_str(), 60);
				msg = (r == 0)   ? "Verificacion: IDENTICO"
				      : (r == 2) ? "Verificacion: DIVERGE"
						 : "Verificacion: error";
			} else if (act == 3 && n > 0) {
				if (!g_game.load(list[sel].path.c_str())) {
					msg = "No se pudo cargar el .n2x";
					continue;
				}
				g_game.fill_mapper(g_cart);
				g_nes.load_mapper(g_cart);
				g_nes.reset();
				g_nes.fast_ctx = &g_game;
				g_nes.fast_run = &n2a::TranspiledGame::fast_run;
				std::printf("nes_sdl: '%s' motor=codegen\n", list[sel].path.c_str());
				g_frames_limit = -1;
				g_host.quit_window = false;
				g_host.escape_menu = false;
				while (emu_tick_once() != 0) {
					g_host.delay_ms(16);
				}
				if (g_host.quit_window) {
					break;
				}
				msg = "Esc: volver al gestor";
			} else if (act == 5) {
				break; // salir
			}
			g_host.delay_ms(16);
		}
		g_host.shutdown();
		return 0;
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
