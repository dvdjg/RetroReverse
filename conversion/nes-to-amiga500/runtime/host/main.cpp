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
#include "n2a_config.hpp"
#include "n2a_log.hpp"
#include "n2a_shaders.hpp"
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

// --- Configuración y shaders (declarados antes de `emu_tick_once`) ---
n2a::N2AConfig g_cfg;                  ///< Opciones persistentes (archivo editable).
char g_cfg_path[512] = "nes_sdl.cfg";  ///< Ruta del archivo de config.
int g_shader = 2;                      ///< Shader activo (ver `n2a_shaders.hpp`).
int g_shader_next_sc = 0;              ///< Scancode para el siguiente shader.
int g_shader_prev_sc = 0;              ///< Scancode para el shader anterior.
bool g_next_was_down = false;          ///< Estado previo (detección de flanco).
bool g_prev_was_down = false;

/// \return `true` en el flanco de subida (se pulsó desde el frame anterior).
inline bool edge(bool now, bool& was) {
	const bool rising = now && !was;
	was = now;
	return rising;
}

/// Cambia el shader `delta` posiciones (cíclico) y guarda la config.
void shader_cycle(int delta) {
	g_shader = (g_shader + delta + n2a::kShaderCount) % n2a::kShaderCount;
	g_cfg.shader = n2a::kShaderNames[g_shader];
	(void)g_cfg.save(g_cfg_path);
	n2a::log_emit(n2a::LogLevel::Info, "INFO", "shader -> %s", n2a::kShaderNames[g_shader]);
}

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
	// Cambio de shader en partida (teclas configurables, por flanco).
	if (g_shader_next_sc != 0 && edge(g_host.key_down(g_shader_next_sc), g_next_was_down)) {
		shader_cycle(+1);
	}
	if (g_shader_prev_sc != 0 && edge(g_host.key_down(g_shader_prev_sc), g_prev_was_down)) {
		shader_cycle(-1);
	}
	n2a::shader_apply(g_shader, g_rgb, n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH);
	g_host.present(g_rgb);
	g_nes.apu.generate_samples(eng::Span<eng::s16> {g_audio, 512});
	g_host.audio_write(g_audio, 512);
	++g_frame;
	if (g_frame == 1) {
		N2A_LOGD("primer frame presentado (PPU/APU ok)");
	} else if ((g_frame % 300) == 0) {
		N2A_LOGT("frame %d", g_frame);
	}
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

/// Lanza ShaderGlass con el perfil configurado (si hay), de forma desacoplada.
static void launch_shaderglass() {
	if (g_cfg.shaderglass_exe.empty()) {
		return;
	}
	char cmd[1600];
#if defined(_WIN32)
	std::snprintf(cmd, sizeof cmd, "start \"\" \"%s\" \"%s\"", g_cfg.shaderglass_exe.c_str(),
		      g_cfg.shaderglass_profile.c_str());
#else
	std::snprintf(cmd, sizeof cmd, "\"%s\" \"%s\" &", g_cfg.shaderglass_exe.c_str(),
		      g_cfg.shaderglass_profile.c_str());
#endif
	N2A_LOGI("lanzando ShaderGlass: %s", cmd);
	(void)std::system(cmd);
}

/// Tras inicializar SDL: resuelve las teclas de shader y lanza ShaderGlass.
static void post_init_shaders() {
	g_shader_next_sc = static_cast<int>(SDL_GetScancodeFromName(g_cfg.shader_next.c_str()));
	g_shader_prev_sc = static_cast<int>(SDL_GetScancodeFromName(g_cfg.shader_prev.c_str()));
	N2A_LOGI("shader='%s' teclas: next=%s(%d) prev=%s(%d)", n2a::kShaderNames[g_shader],
		 g_cfg.shader_next.c_str(), g_shader_next_sc, g_cfg.shader_prev.c_str(),
		 g_shader_prev_sc);
	launch_shaderglass();
}

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
	SDL_RenderDebugText(r, 4.0f, 14.0f, "Flechas=sel Enter=jugar V=verificar");
	SDL_RenderDebugText(r, 4.0f, 24.0f, "S=shaders Esc=salir");
	SDL_SetRenderDrawColor(r, 255, 150, 150, 255);
	SDL_RenderDebugText(r, 4.0f, 34.0f, "(c) codigo nativo: bajo tu responsabilidad");
	int y = 48;
	if (list.empty()) {
		SDL_SetRenderDrawColor(r, 255, 120, 120, 255);
		SDL_RenderDebugText(r, 4.0f, static_cast<float>(y), "No hay .n2x aqui (usa --emit-lib).");
	} else {
		for (std::size_t i = 0; i < list.size() && y < 208; ++i, y += 10) {
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
	// Detalle del seleccionado (plataforma + CRC de la ROM).
	if (!list.empty()) {
		const MenEntry& e = list[static_cast<std::size_t>(sel)];
		std::string det = "arch=" + (e.arch.empty() ? std::string("?") : e.arch);
		if (!e.crc.empty()) {
			det += "  crc=" + e.crc;
		}
		SDL_SetRenderDrawColor(r, 160, 200, 255, 255);
		SDL_RenderDebugText(r, 4.0f, 212.0f, det.c_str());
	}
	if (!msg.empty()) {
		SDL_SetRenderDrawColor(r, 120, 255, 120, 255);
		SDL_RenderDebugText(r, 4.0f, 224.0f, msg.c_str());
	}
	SDL_RenderPresent(r);
}

/// Dibuja el **menú de shaders** (selección con flechas).
static void draw_shader_menu(n2a::SdlHost& host, int sel) {
	SDL_Renderer* r = host.ren;
	SDL_SetRenderScale(r, 1.0f, 1.0f);
	SDL_SetRenderDrawColor(r, 0, 0, 0, 255);
	SDL_RenderClear(r);
	SDL_SetRenderDrawColor(r, 255, 255, 255, 255);
	SDL_RenderDebugText(r, 4.0f, 4.0f, "Shader de video");
	SDL_SetRenderDrawColor(r, 200, 180, 120, 255);
	SDL_RenderDebugText(r, 4.0f, 14.0f, "Flechas=elegir Enter=aplicar Esc=volver");
	for (int i = 0; i < n2a::kShaderCount; ++i) {
		const float y = 32.0f + static_cast<float>(i) * 12.0f;
		if (i == sel) {
			SDL_SetRenderDrawColor(r, 40, 60, 120, 255);
			SDL_FRect bg {0.0f, y - 1.0f, 256.0f, 12.0f};
			SDL_RenderFillRect(r, &bg);
			SDL_SetRenderDrawColor(r, 255, 255, 255, 255);
		} else {
			SDL_SetRenderDrawColor(r, 200, 200, 200, 255);
		}
		SDL_RenderDebugText(r, 4.0f, y, n2a::kShaderNames[i]);
	}
	SDL_RenderPresent(r);
}

int main(int argc, char** argv) {
	// Configuración de trazas (antes que nada, para trazar el resto).
	{
		const char* env = std::getenv("N2A_LOG");
		if (env != nullptr) {
			n2a::log_set_level(n2a::log_parse_level(env));
		}
		for (int i = 1; i < argc; ++i) {
			if (std::strcmp(argv[i], "--verbose") == 0 || std::strcmp(argv[i], "-v") == 0) {
				n2a::log_set_level(n2a::LogLevel::Debug);
			} else if (std::strcmp(argv[i], "--trace") == 0) {
				n2a::log_set_level(n2a::LogLevel::Trace);
			} else if (std::strcmp(argv[i], "--log-level") == 0 && i + 1 < argc) {
				n2a::log_set_level(n2a::log_parse_level(argv[++i]));
			} else if (std::strcmp(argv[i], "--log-file") == 0 && i + 1 < argc) {
				if (!n2a::log_set_file(argv[++i])) {
					std::fprintf(stderr, "aviso: no se pudo abrir el fichero de log\n");
				}
			}
		}
	}
	// Configuración del host (archivo editable; se crea con valores por defecto).
	for (int i = 1; i < argc; ++i) {
		if (std::strcmp(argv[i], "--config") == 0 && i + 1 < argc) {
			std::snprintf(g_cfg_path, sizeof g_cfg_path, "%s", argv[++i]);
		}
	}
	const bool had_cfg = g_cfg.load(g_cfg_path);
	if (!had_cfg) {
		(void)g_cfg.save(g_cfg_path);
	}
	g_shader = n2a::shader_index(g_cfg.shader.c_str());
	g_host.initial_scale = g_cfg.scale;

	N2A_LOGI("nes_sdl arrancando (log=%d) config='%s'%s scale=%d shader=%s", n2a::log_level(),
		 g_cfg_path, had_cfg ? "" : " (nuevo)", g_cfg.scale, g_cfg.shader.c_str());

	if (argc < 2) {
		std::printf("uso: nes_sdl <rom.nes|juego.n2x> [frames] [--verbose|--trace]\n");
		std::printf("     nes_sdl --verify  <juego.n2x> [frames]   (compara con el interprete)\n");
		std::printf("     nes_sdl --manager <dir>                  (gestor de .n2x)\n");
		std::printf("     opciones: --verbose | --trace | --log-level <n> | --log-file <f>\n");
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
		N2A_LOGI("gestor: %d .n2x en '%s'", static_cast<int>(list.size()), dir);
		if (!g_host.init("Gestor NES .n2x", n2a::NesSystem::kScreenW, n2a::NesSystem::kScreenH,
				 22050)) {
			std::printf("error: no se pudo iniciar SDL3\n");
			return 1;
		}
		post_init_shaders();
		int sel = 0;
		int mode = 0; // 0 = lista de juegos, 1 = menú de shaders
		int shader_sel = g_shader;
		std::string msg;
		for (;;) {
			if (mode == 0) {
				draw_manager(g_host, list, sel, msg);
			} else {
				draw_shader_menu(g_host, shader_sel);
			}
			int act = 0;
			if (!g_host.menu_poll(act)) {
				break; // ventana cerrada
			}
			if (mode == 1) { // menú de shaders
				if (act == 1) {
					shader_sel = (shader_sel + n2a::kShaderCount - 1) % n2a::kShaderCount;
				} else if (act == 2) {
					shader_sel = (shader_sel + 1) % n2a::kShaderCount;
				} else if (act == 3) {
					g_shader = shader_sel;
					g_cfg.shader = n2a::kShaderNames[g_shader];
					(void)g_cfg.save(g_cfg_path);
					N2A_LOGI("shader -> %s", n2a::kShaderNames[g_shader]);
					mode = 0;
					msg = "shader aplicado";
				} else if (act == 5) {
					mode = 0;
				}
				g_host.delay_ms(16);
				continue;
			}
			const int n = static_cast<int>(list.size());
			if (act == 6) {
				mode = 1; // abrir menú de shaders
				shader_sel = g_shader;
			} else if (act == 1 && n > 0) {
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
					N2A_LOGE("etapa: carga de plugin '%s'", list[sel].path.c_str());
					msg = "No se pudo cargar el .n2x";
					continue;
				}
				g_game.fill_mapper(g_cart);
				g_nes.load_mapper(g_cart);
				g_nes.reset();
				g_nes.fast_ctx = &g_game;
				g_nes.fast_run = &n2a::TranspiledGame::fast_run;
				N2A_LOGI("jugando '%s' (motor=codegen)", list[sel].path.c_str());
				std::printf("nes_sdl: '%s' motor=codegen\n", list[sel].path.c_str());
				g_frames_limit = -1;
				g_frame = 0;
				g_host.quit_window = false;
				g_host.escape_menu = false;
				while (emu_tick_once() != 0) {
					g_host.delay_ms(16);
				}
				N2A_LOGI("fin de '%s': %d frames", list[sel].path.c_str(), g_frame);
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
			N2A_LOGE("etapa: carga de plugin '%s' (invalido o ABI/arquitectura)", argv[1]);
			std::printf("error: plugin '%s' invalido o ABI/arquitectura incompatible\n",
				    argv[1]);
			return 1;
		}
		g_game.fill_mapper(g_cart);
		g_nes.load_mapper(g_cart);
		g_nes.reset();
		g_nes.fast_ctx = &g_game;
		g_nes.fast_run = &n2a::TranspiledGame::fast_run;
		N2A_LOGI("plugin='%s' mapper=%d PRG=%u CHR=%u motor=codegen", argv[1], g_game.fn_mapper(),
			 g_game.fn_prg_size(), g_game.fn_chr_size());
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
	post_init_shaders();
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
