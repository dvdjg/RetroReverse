// libretro_core.cpp — core libretro (RetroArch) del nodo NES→Amiga/SDL3.
//
// Implementa la API libretro sobre `NesSystem` (intérprete; el camino HLE/
// transpilado se añadirá después) y expone **plugins** de vídeo/audio como core
// options. Al cargar una ROM iNES/NES2.0 la transpila/analiza y la ejecuta.
//
// Compilación: ver runtime/retroarch/README.md (Makefile; incluye libretro.h de
// external/libretro-common/include).

#include <cstdio>
#include <cstring>

#include <libretro.h>

#include "../../tools/transpiler/src/transpiler.hpp"
#include "../enhance/profile_io.hpp"
#include "../host/fastcpu.hpp"
#include "nes_system.hpp"
#include "plugins.hpp"
#include "rom_loader.hpp"

// --- Callbacks del frontend ------------------------------------------------
static retro_environment_t env_cb = nullptr;
static retro_video_refresh_t video_cb = nullptr;
static retro_audio_sample_t audio_cb = nullptr;
static retro_audio_sample_batch_t audio_batch_cb = nullptr;
static retro_input_poll_t input_poll_cb = nullptr;
static retro_input_state_t input_state_cb = nullptr;

// --- Estado del core -------------------------------------------------------
static n2a::LoadedRom g_rom;       ///< ROM + mapper.
static n2a::NesSystem g_sys;       ///< Núcleo NES.
static bool g_loaded = false;      ///< ¿Hay ROM cargada?
static n2a::retro::VideoPlugin* g_video = &n2a::retro::Plugins::default_video();
static n2a::retro::AudioPlugin* g_audio = &n2a::retro::Plugins::default_audio();
static n2a::enhance::AppliedProfile g_profile; ///< Perfil por ROM (si lo hay).
static char g_system_dir[512] = {}; ///< Directorio de sistema (packs).
static bool g_use_pack = true;      ///< ¿Aplicar el perfil/pack de la ROM?
static bool g_analyze = true;       ///< ¿Analizar (transpilar) la ROM al cargar?
static n2a::FastCpu g_fast;         ///< Ejecutor rápido (motor `fast`).

static eng::u32 g_fb[256 * 240];          ///< Framebuffer XRGB8888.
static eng::s16 g_audio_buf[4096 * 2];    ///< Muestras estéreo S16.

/// Estado serializable (savestate): CPU, RAM, PPU y APU.
struct Savestate {
	n2a::CPU cpu;
	eng::u8 ram[0x800];
	n2a::Ppu ppu;
	n2a::Apu apu;
};
static Savestate g_state; ///< Búfer de savestate (BSS, evita pila).

// --- Motor codegen (opcional) ----------------------------------------------
// Un core "codegen" se compila junto al transpilado de una ROM concreta (ver
// runtime/retroarch/gen_engine_example.cpp y build-codegen-core.sh), que exporta
// estos símbolos. En el core genérico no existen: quedan a nullptr (weak) y la
// opción `codegen`/`auto` cae a `fast`.
extern "C" void n2a_codegen_init(void) __attribute__((weak));
extern "C" int n2a_codegen_step(n2a::CPU& cpu, n2a::NESMemory& mem, int budget, int* n)
	__attribute__((weak));

/// Hook `FastRun` que delega en el motor codegen enlazado (si lo hay): ejecuta el
/// `bb_*` de `cpu.PC` y devuelve sus ciclos (delta de `cpu.cycles`).
static int codegen_run(void* /*ctx*/, n2a::CPU& cpu, n2a::NESMemory& mem, int budget, int* n) {
	return n2a_codegen_step(cpu, mem, budget, n);
}

namespace {

/// Lee las core options y selecciona los plugins de vídeo/audio.
void refresh_plugins() {
	retro_variable v {"nes_video_plugin", nullptr};
	if (env_cb != nullptr && env_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &v) && v.value != nullptr) {
		g_video = &n2a::retro::Plugins::video(v.value);
	}
	retro_variable a {"nes_audio_plugin", nullptr};
	if (env_cb != nullptr && env_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &a) && a.value != nullptr) {
		g_audio = &n2a::retro::Plugins::audio(a.value);
	}
}

/// Lee una core option de texto; devuelve `def` si no está definida.
const char* get_str_opt(const char* key, const char* def) {
	retro_variable v {key, nullptr};
	if (env_cb != nullptr && env_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &v) && v.value != nullptr) {
		return v.value;
	}
	return def;
}

/// Lee una core option booleana ("enabled"/"disabled").
bool get_bool_opt(const char* key, bool def) {
	retro_variable v {key, nullptr};
	if (env_cb != nullptr && env_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &v) && v.value != nullptr) {
		return v.value[0] != 'd';
	}
	return def;
}

/// Copia el directorio de sistema del frontend a `g_system_dir`.
void fetch_system_dir() {
	g_system_dir[0] = '\0';
	const char* sys = nullptr;
	if (env_cb != nullptr && env_cb(RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY, &sys) && sys != nullptr) {
		eng::usize o = 0;
		for (eng::usize i = 0; sys[i] != '\0' && o + 2u < sizeof g_system_dir; ++i) {
			g_system_dir[o++] = sys[i];
		}
		g_system_dir[o] = '\0';
	}
}

/// Traduce el estado del mando libretro al byte de `$4016` de la NES.
eng::u8 read_nes_pad(unsigned port) {
	if (input_state_cb == nullptr) {
		return 0u;
	}
	eng::u8 pad = 0u;
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A) != 0u)
		pad = static_cast<eng::u8>(pad | 0x01u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B) != 0u)
		pad = static_cast<eng::u8>(pad | 0x02u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT) != 0u)
		pad = static_cast<eng::u8>(pad | 0x04u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START) != 0u)
		pad = static_cast<eng::u8>(pad | 0x08u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP) != 0u)
		pad = static_cast<eng::u8>(pad | 0x10u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN) != 0u)
		pad = static_cast<eng::u8>(pad | 0x20u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT) != 0u)
		pad = static_cast<eng::u8>(pad | 0x40u);
	if (input_state_cb(port, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT) != 0u)
		pad = static_cast<eng::u8>(pad | 0x80u);
	return pad;
}

/// Publica las **core options**: V2 si el frontend lo soporta, si no V1.
void set_core_options() {
	if (env_cb == nullptr) {
		return;
	}
	unsigned version = 0;
	if (!env_cb(RETRO_ENVIRONMENT_GET_CORE_OPTIONS_VERSION, &version)) {
		version = 0;
	}
	if (version >= 2u) {
		static retro_core_option_v2_category cats[] = {
			{"video", "Video", "Opciones de video del emulador"},
			{"audio", "Audio", "Opciones de audio del emulador"},
			{"rom", "ROM", "Ajustes por ROM"},
			{nullptr, nullptr, nullptr},
		};
		static retro_core_option_v2_definition defs[] = {
			{"nes_video_plugin", "Video plugin", nullptr, "Convierte los graficos de la NES.",
			 nullptr, "video", {{"raw", nullptr}, {"gray", nullptr}, {nullptr, nullptr}},
			 "raw"},
			{"nes_audio_plugin", "Audio plugin", nullptr, "Convierte el audio del APU.", nullptr,
			 "audio", {{"linear", nullptr}, {"mute", nullptr}, {nullptr, nullptr}}, "linear"},
			{"nes_use_pack", "Ajustes por ROM", nullptr,
			 "Usa el pack de tiles/paleta del perfil de la ROM.", nullptr, "rom",
			 {{"enabled", nullptr}, {"disabled", nullptr}, {nullptr, nullptr}}, "enabled"},
			{"nes_analyze", "Analizar ROM al cargar", nullptr,
			 "Ejecuta el transpilador (grafo de basic blocks) al cargar.", nullptr, "rom",
			 {{"enabled", nullptr}, {"disabled", nullptr}, {nullptr, nullptr}}, "enabled"},
			{"nes_engine", "Motor de CPU", nullptr,
			 "auto (codegen si el core lo trae, si no fast), fast, interpreter o codegen.",
			 nullptr, "rom",
			 {{"auto", nullptr}, {"fast", nullptr}, {"interpreter", nullptr},
			  {"codegen", nullptr}, {nullptr, nullptr}},
			 "auto"},
			{nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, {{nullptr, nullptr}},
			 nullptr},
		};
		retro_core_options_v2 opts {cats, defs};
		env_cb(RETRO_ENVIRONMENT_SET_CORE_OPTIONS_V2, &opts);
	} else {
		static const retro_variable vars[] = {
			{"nes_video_plugin", "Video plugin; raw|gray"},
			{"nes_audio_plugin", "Audio plugin; linear|mute"},
			{"nes_use_pack", "Ajustes por ROM; enabled|disabled"},
			{"nes_analyze", "Analizar ROM al cargar; enabled|disabled"},
			{"nes_engine", "Motor de CPU; auto|fast|interpreter|codegen"},
			{nullptr, nullptr},
		};
		env_cb(RETRO_ENVIRONMENT_SET_VARIABLES, const_cast<retro_variable*>(vars));
	}
}

} // namespace

// --- Ciclo de vida ---------------------------------------------------------
void retro_set_environment(retro_environment_t cb) { env_cb = cb; }
void retro_set_video_refresh(retro_video_refresh_t cb) { video_cb = cb; }
void retro_set_audio_sample(retro_audio_sample_t cb) { audio_cb = cb; }
void retro_set_audio_sample_batch(retro_audio_sample_batch_t cb) { audio_batch_cb = cb; }
void retro_set_input_poll(retro_input_poll_t cb) { input_poll_cb = cb; }
void retro_set_input_state(retro_input_state_t cb) { input_state_cb = cb; }

unsigned retro_api_version() { return RETRO_API_VERSION; }

void retro_get_system_info(struct retro_system_info* info) {
	std::memset(info, 0, sizeof(*info));
	info->library_name = "RetroReverse NES";
	info->library_version = "0.1";
	info->valid_extensions = "nes";
	info->need_fullpath = false;   // cargamos desde memoria
	info->block_extract = false;
}

void retro_get_system_av_info(struct retro_system_av_info* info) {
	std::memset(info, 0, sizeof(*info));
	info->geometry.base_width = 256;
	info->geometry.base_height = 240;
	info->geometry.max_width = 256;
	info->geometry.max_height = 240;
	info->geometry.aspect_ratio = 256.0f / 240.0f;
	info->timing.fps = 60.0988;
	info->timing.sample_rate = 44100.0;
}

void retro_init() {
	if (env_cb != nullptr) {
		enum retro_pixel_format fmt = RETRO_PIXEL_FORMAT_XRGB8888;
		env_cb(RETRO_ENVIRONMENT_SET_PIXEL_FORMAT, &fmt);
	}
	set_core_options();
}

void retro_deinit() {}

void retro_reset() {
	if (g_loaded) {
		g_sys.reset();
	}
}

bool retro_load_game(const struct retro_game_info* game) {
	if (game == nullptr || game->data == nullptr) {
		return false;
	}
	if (!n2a::load_ines_mem(static_cast<const eng::u8*>(game->data),
				static_cast<eng::usize>(game->size), g_rom)) {
		return false;
	}
	g_sys.load_mapper(g_rom.mapper);
	g_sys.reset();

	g_use_pack = get_bool_opt("nes_use_pack", true);
	g_analyze = get_bool_opt("nes_analyze", true);
	fetch_system_dir();

	// Motor de CPU: `auto` (codegen si el core lo trae enlazado, si no `fast`),
	// `fast` (pre-decodificado), `interpreter`, o `codegen` (requiere que el core
	// se haya compilado con el transpilado de la ROM). `fast`/`codegen` caen al
	// interprete en los opcodes/direcciones no cubiertos => mismo resultado.
	g_sys.fast_ctx = nullptr;
	g_sys.fast_step = nullptr;
	g_sys.fast_run = nullptr;
	const char* eng = get_str_opt("nes_engine", "auto");
	const bool has_codegen = (n2a_codegen_step != nullptr);
	const bool want_interp = std::strcmp(eng, "interpreter") == 0;
	const bool want_codegen = std::strcmp(eng, "codegen") == 0 ||
				  (std::strcmp(eng, "auto") == 0 && has_codegen);
	const char* mode = "interprete";
	if (want_codegen && has_codegen) {
		g_sys.fast_run = &codegen_run;
		g_sys.fast_ticks = true; // el codegen reloja la PPU por acceso
		if (n2a_codegen_init != nullptr) {
			n2a_codegen_init();
		}
		mode = "codegen";
	} else if (!want_interp &&
		   g_fast.build(g_rom.mapper.prg, g_rom.mapper.prg_size, g_sys.mem.read16(0xFFFCu),
				g_sys.mem.read16(0xFFFAu), g_sys.mem.read16(0xFFFEu))) {
		g_sys.fast_ctx = &g_fast;
		g_sys.fast_step = &n2a::FastCpu::step;
		g_sys.fast_run = &n2a::FastCpu::run_block;
		mode = want_codegen ? "rapido(codegen no enlazado)" : "rapido(bloques)";
	}
	std::printf("nes: motor de CPU = %s\n", mode);

	// Ajustes por ROM (opcional): perfil/pack de tiles + paleta extendida.
	if (g_use_pack && game->path != nullptr) {
		const eng::u32 crc = n2a::enhance::crc32(g_rom.rom, g_rom.file_size);
		if (n2a::enhance::load_rom_profile(game->path, crc, g_profile, g_system_dir)) {
			if (g_profile.has_provider) {
				g_sys.ppu.tile_provider = &g_profile.provider;
			}
			if (g_profile.has_palette) {
				g_sys.ppu.ext_palette = g_profile.palette_ptr();
			}
			std::printf("nes: perfil '%s' bpp=%u pack=%d pal=%d\n", g_profile.profile.name,
				    g_profile.profile.gfx.bpp_bg, static_cast<int>(g_profile.has_provider),
				    static_cast<int>(g_profile.has_palette));
		} else {
			std::printf("nes: sin perfil para '%s'\n", game->path);
		}
	} else {
		std::printf("nes: perfil omitido (use_pack=%d path=%s)\n", static_cast<int>(g_use_pack),
			    game->path != nullptr ? game->path : "(null)");
	}

	// Análisis en proceso (transpilador): grafo de basic blocks de la ROM.
	if (g_analyze) {
		n2a::Transpiler tp;
		if (tp.load(g_rom.rom, g_rom.file_size)) {
			tp.disassemble();
			tp.build_basic_blocks();
			std::printf("nes: analisis ROM -> instrucciones=%u bloques=%u\n",
				    static_cast<unsigned>(tp.instruction_count()),
				    static_cast<unsigned>(tp.block_count()));
		} else {
			std::printf("nes: analisis omitido (mapper %u no soportado aun)\n", g_rom.mapper_no);
		}
	}

	refresh_plugins();
	g_loaded = true;
	return true;
}

bool retro_load_game_special(unsigned, const struct retro_game_info*, size_t) { return false; }

void retro_unload_game() {
	g_loaded = false;
	g_sys.fast_step = nullptr;
	g_sys.fast_run = nullptr;
	g_sys.fast_ctx = nullptr;
	g_fast.destroy();
}

void retro_run() {
	if (!g_loaded) {
		return;
	}
	if (input_poll_cb != nullptr) {
		input_poll_cb();
	}
	g_sys.pad1 = read_nes_pad(0);
	g_sys.pad2 = read_nes_pad(1);
	g_sys.run_frame();

	g_video->render(g_sys.ppu, g_fb, 256, 240);
	if (video_cb != nullptr) {
		video_cb(g_fb, 256, 240, 256 * sizeof(eng::u32));
	}

	const int frames = static_cast<int>(44100.0 / 60.0988);  // ~734
	g_audio->generate(g_sys.apu, g_audio_buf, frames);
	if (audio_batch_cb != nullptr) {
		audio_batch_cb(g_audio_buf, static_cast<size_t>(frames));
	}
}

void retro_set_controller_port_device(unsigned, unsigned) {}
void retro_cheat_reset() {}
void retro_cheat_set(unsigned, bool, const char*) {}
unsigned retro_get_region() { return RETRO_REGION_NTSC; }

// --- Serialización (savestates) -------------------------------------------
size_t retro_serialize_size() { return sizeof(Savestate); }

bool retro_serialize(void* data, size_t size) {
	if (size < sizeof(Savestate)) {
		return false;
	}
	g_state.cpu = g_sys.cpu;
	std::memcpy(g_state.ram, g_sys.mem.ram, sizeof g_state.ram);
	g_state.ppu = g_sys.ppu;
	g_state.apu = g_sys.apu;
	g_state.cpu.mem = nullptr;
	g_state.ppu.chr = nullptr;
	std::memcpy(data, &g_state, sizeof(Savestate));
	return true;
}

bool retro_unserialize(const void* data, size_t size) {
	if (size < sizeof(Savestate)) {
		return false;
	}
	std::memcpy(&g_state, data, sizeof(Savestate));
	g_sys.cpu = g_state.cpu;
	g_sys.cpu.mem = &g_sys.mem;
	std::memcpy(g_sys.mem.ram, g_state.ram, sizeof g_state.ram);
	g_sys.ppu = g_state.ppu;
	g_sys.ppu.chr = g_rom.mapper.chr;
	g_sys.ppu.chr_size = g_rom.mapper.chr_size;
	g_sys.apu = g_state.apu;
	return true;
}

// --- Memoria expuesta al frontend -----------------------------------------
void* retro_get_memory_data(unsigned id) {
	if (id == RETRO_MEMORY_SYSTEM_RAM) {
		return g_sys.mem.ram;
	}
	return nullptr;
}

size_t retro_get_memory_size(unsigned id) {
	if (id == RETRO_MEMORY_SYSTEM_RAM) {
		return sizeof g_sys.mem.ram;
	}
	return 0;
}
