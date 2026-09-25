// Core libretro de PRUEBA (mínimo) para validar el adaptador sin compilar MAME.
// No es un emulador: mantiene 16 bytes de "RAM del sistema" que avanzan por frame y
// reflejan el input, y emite un frame 4x2. Exporta la API libretro mínima.

#include <cstring>

#include "libretro_api.hpp"

namespace {
std::uint8_t g_ram[16];
retro_environment_t g_env = nullptr;
retro_video_refresh_t g_video = nullptr;
retro_input_poll_t g_poll = nullptr;
retro_input_state_t g_input = nullptr;
retro_pixel_format g_pixel = RETRO_PIXEL_FORMAT_RGB565;
std::uint16_t g_frame[4 * 2];
}  // namespace

extern "C" {

void retro_init(void) {}
void retro_deinit(void) {}

unsigned retro_api_version(void) { return RETRO_API_VERSION; }

void retro_get_system_info(struct retro_system_info* info) {
    std::memset(info, 0, sizeof(*info));
    info->library_name = "test_core";
    info->library_version = "1.0";
    info->valid_extensions = "bin";
    info->need_fullpath = false;
    info->block_extract = false;
}

void retro_get_system_av_info(struct retro_system_av_info* info) {
    info->geometry.base_width = 4;
    info->geometry.base_height = 2;
    info->geometry.max_width = 4;
    info->geometry.max_height = 2;
    info->geometry.aspect_ratio = 2.0f;
    info->timing.fps = 60.0;
    info->timing.sample_rate = 44100.0;
}

void retro_set_environment(retro_environment_t cb) { g_env = cb; }
void retro_set_video_refresh(retro_video_refresh_t cb) { g_video = cb; }
void retro_set_audio_sample(retro_audio_sample_t) {}
void retro_set_audio_sample_batch(retro_audio_sample_batch_t) {}
void retro_set_input_poll(retro_input_poll_t cb) { g_poll = cb; }
void retro_set_input_state(retro_input_state_t cb) { g_input = cb; }
void retro_set_controller_port_device(unsigned, unsigned) {}

void retro_reset(void) { std::memset(g_ram, 0, sizeof(g_ram)); }

void retro_run(void) {
    if (g_poll) g_poll();

    std::uint8_t in = 0;
    if (g_input) {
        auto pressed = [&](unsigned id) { return g_input(0, RETRO_DEVICE_JOYPAD, 0, id) != 0; };
        if (pressed(RETRO_DEVICE_ID_JOYPAD_UP)) in |= 0x01;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_DOWN)) in |= 0x02;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_LEFT)) in |= 0x04;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_RIGHT)) in |= 0x08;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_A)) in |= 0x10;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_START)) in |= 0x20;
        if (pressed(RETRO_DEVICE_ID_JOYPAD_SELECT)) in |= 0x40;
    }
    g_ram[0] = static_cast<std::uint8_t>(g_ram[0] + 1);
    g_ram[1] = in;

    for (int i = 0; i < 8; ++i) g_frame[i] = static_cast<std::uint16_t>(g_ram[0] << 8);
    if (g_env) g_env(RETRO_ENVIRONMENT_SET_PIXEL_FORMAT, &g_pixel);
    if (g_video) g_video(g_frame, 4, 2, 4 * sizeof(std::uint16_t));
}

bool retro_load_game(const struct retro_game_info*) {
    std::memset(g_ram, 0, sizeof(g_ram));
    return true;
}

void retro_unload_game(void) {}

void* retro_get_memory_data(unsigned id) {
    return (id == RETRO_MEMORY_SYSTEM_RAM) ? g_ram : nullptr;
}

std::size_t retro_get_memory_size(unsigned id) {
    return (id == RETRO_MEMORY_SYSTEM_RAM) ? sizeof(g_ram) : 0;
}

std::size_t retro_serialize_size(void) { return sizeof(g_ram); }
bool retro_serialize(void* data, std::size_t size) {
    if (size < sizeof(g_ram)) return false;
    std::memcpy(data, g_ram, sizeof(g_ram));
    return true;
}
bool retro_unserialize(const void* data, std::size_t size) {
    if (size < sizeof(g_ram)) return false;
    std::memcpy(g_ram, data, sizeof(g_ram));
    return true;
}

}  // extern "C"
