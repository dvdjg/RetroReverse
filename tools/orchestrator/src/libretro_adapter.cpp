// Adaptador libretro de EmulatorControl. Ver ../README.md y docs/INSTRUMENTATION.md.

#include "libretro_adapter.hpp"

#include <cstdio>
#include <cstring>
#include <fstream>
#include <iterator>
#include <stdexcept>
#include <vector>

#include "libretro_api.hpp"

#ifdef _WIN32
#include <windows.h>
using LibHandle = HMODULE;
static LibHandle open_lib(const std::string& p) { return LoadLibraryA(p.c_str()); }
static void* sym(LibHandle h, const char* n) { return reinterpret_cast<void*>(GetProcAddress(h, n)); }
static void close_lib(LibHandle h) { FreeLibrary(h); }
#else
#include <dlfcn.h>
using LibHandle = void*;
static LibHandle open_lib(const std::string& p) { return dlopen(p.c_str(), RTLD_NOW | RTLD_LOCAL); }
static void* sym(LibHandle h, const char* n) { return dlsym(h, n); }
static void close_lib(LibHandle h) { dlclose(h); }
#endif

namespace rr {

namespace {

// Puntero al adaptador activo para los callbacks C del core.
LibretroAdapter* g_active = nullptr;  // (usamos Impl vía el friend impl; ver abajo)

void log_stub(int, const char*, ...) {}

}  // namespace

struct LibretroAdapter::Impl {
    // Punteros a funciones del core.
    LibHandle handle = nullptr;
    void (*retro_init)() = nullptr;
    void (*retro_deinit)() = nullptr;
    unsigned (*retro_api_version)() = nullptr;
    void (*retro_get_system_info)(retro_system_info*) = nullptr;
    void (*retro_get_system_av_info)(retro_system_av_info*) = nullptr;
    void (*retro_set_environment)(retro_environment_t) = nullptr;
    void (*retro_set_video_refresh)(retro_video_refresh_t) = nullptr;
    void (*retro_set_audio_sample)(retro_audio_sample_t) = nullptr;
    void (*retro_set_audio_sample_batch)(retro_audio_sample_batch_t) = nullptr;
    void (*retro_set_input_poll)(retro_input_poll_t) = nullptr;
    void (*retro_set_input_state)(retro_input_state_t) = nullptr;
    void (*retro_reset)() = nullptr;
    void (*retro_run)() = nullptr;
    bool (*retro_load_game)(const retro_game_info*) = nullptr;
    void (*retro_unload_game)() = nullptr;
    void (*retro_set_controller_port_device)(unsigned, unsigned) = nullptr;
    // Canal opcional de libRetroReversing (símbolo `rr_re_command`, ver scripts/setup-re-core.sh).
    const char* (*rr_re_command)(const char*) = nullptr;
    void* (*retro_get_memory_data)(unsigned) = nullptr;
    std::size_t (*retro_get_memory_size)(unsigned) = nullptr;
    std::size_t (*retro_serialize_size)() = nullptr;
    bool (*retro_serialize)(void*, std::size_t) = nullptr;
    bool (*retro_unserialize)(const void*, std::size_t) = nullptr;

    // Estado del frontend.
    std::string core_path;
    std::string core_name = "(desconocido)";
    std::vector<std::uint8_t> rom_data;
    InputState input;
    TraceConfig trace;
    bool loaded = false;

    retro_pixel_format pixel_format = RETRO_PIXEL_FORMAT_0RGB1555;
    std::vector<std::uint8_t> frame;  // último frame (RGBA8888)
    unsigned fw = 0, fh = 0;

    // directorios devueltos al core
    std::string sys_dir = ".";
    std::string save_dir = ".";

    // Regiones publicadas por el core + estado de trazas.
    std::vector<retro_memory_descriptor> memory_map;
    std::vector<TraceWrite> writes;
    std::vector<std::uint8_t> trace_prev;
    bool tracing = false;
    unsigned frame_no = 0;

    // Lee una dirección a través del mapa de memoria del core (o SYSTEM_RAM como reserva).
    std::uint8_t map_read(std::uint32_t addr) {
        for (const auto& d : memory_map) {
            if (d.ptr && d.len && addr >= d.start && addr < d.start + d.len)
                return static_cast<std::uint8_t*>(d.ptr)[addr - d.start];
        }
        if (retro_get_memory_data && retro_get_memory_size) {
            void* base = retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
            std::size_t size = retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
            if (base && addr < size) return static_cast<std::uint8_t*>(base)[addr];
        }
        return 0;
    }

    void snapshot_trace() {
        writes.clear();
        trace_prev.clear();
        if (!tracing || trace.kind != TraceKind::MemoryWrite || trace.addr_end <= trace.addr_start)
            return;
        const std::uint32_t start = trace.addr_start, end = trace.addr_end;
        trace_prev.resize(end - start);
        for (std::uint32_t a = start; a < end; ++a) trace_prev[a - start] = map_read(a);
    }

    void capture_trace_frame() {
        if (!tracing || trace.kind != TraceKind::MemoryWrite || trace_prev.empty()) return;
        const std::uint32_t start = trace.addr_start;
        for (std::size_t o = 0; o < trace_prev.size(); ++o) {
            const std::uint8_t v = map_read(start + static_cast<std::uint32_t>(o));
            if (v != trace_prev[o]) {
                writes.push_back({frame_no, start + static_cast<std::uint32_t>(o), trace_prev[o], v});
                trace_prev[o] = v;
            }
        }
    }

    void resolve() {
        handle = open_lib(core_path);
        if (!handle) throw std::runtime_error("no se pudo cargar el core: " + core_path);
        auto R = [&](const char* n) -> void* {
            void* p = sym(handle, n);
            if (!p) throw std::runtime_error(std::string("símbolo ausente en el core: ") + n);
            return p;
        };
        retro_init = reinterpret_cast<void (*)()>(R("retro_init"));
        retro_deinit = reinterpret_cast<void (*)()>(R("retro_deinit"));
        retro_api_version = reinterpret_cast<unsigned (*)()>(R("retro_api_version"));
        retro_get_system_info = reinterpret_cast<void (*)(retro_system_info*)>(R("retro_get_system_info"));
        retro_get_system_av_info = reinterpret_cast<void (*)(retro_system_av_info*)>(R("retro_get_system_av_info"));
        retro_set_environment = reinterpret_cast<void (*)(retro_environment_t)>(R("retro_set_environment"));
        retro_set_video_refresh = reinterpret_cast<void (*)(retro_video_refresh_t)>(R("retro_set_video_refresh"));
        retro_set_audio_sample = reinterpret_cast<void (*)(retro_audio_sample_t)>(R("retro_set_audio_sample"));
        retro_set_audio_sample_batch = reinterpret_cast<void (*)(retro_audio_sample_batch_t)>(R("retro_set_audio_sample_batch"));
        retro_set_input_poll = reinterpret_cast<void (*)(retro_input_poll_t)>(R("retro_set_input_poll"));
        retro_set_input_state = reinterpret_cast<void (*)(retro_input_state_t)>(R("retro_set_input_state"));
        retro_reset = reinterpret_cast<void (*)()>(R("retro_reset"));
        retro_run = reinterpret_cast<void (*)()>(R("retro_run"));
        retro_load_game = reinterpret_cast<bool (*)(const retro_game_info*)>(R("retro_load_game"));
        retro_unload_game = reinterpret_cast<void (*)()>(R("retro_unload_game"));
        // Opcional: no todos los cores lo exportan.
        retro_set_controller_port_device =
            reinterpret_cast<void (*)(unsigned, unsigned)>(sym(handle, "retro_set_controller_port_device"));
        // Opcional: canal de control de libRetroReversing.
        rr_re_command = reinterpret_cast<const char* (*)(const char*)>(sym(handle, "rr_re_command"));
        retro_get_memory_data = reinterpret_cast<void* (*)(unsigned)>(R("retro_get_memory_data"));
        retro_get_memory_size = reinterpret_cast<std::size_t (*)(unsigned)>(R("retro_get_memory_size"));
        retro_serialize_size = reinterpret_cast<std::size_t (*)()>(R("retro_serialize_size"));
        retro_serialize = reinterpret_cast<bool (*)(void*, std::size_t)>(R("retro_serialize"));
        retro_unserialize = reinterpret_cast<bool (*)(const void*, std::size_t)>(R("retro_unserialize"));
    }

    // --- callbacks ---
    static bool env(unsigned cmd, void* data) {
        Impl* self = reinterpret_cast<Impl*>(g_active ? g_active->impl_.get() : nullptr);
        const unsigned base = cmd & 0xFFFF;  // descarta el flag EXPERIMENTAL
        switch (base) {
            case RETRO_ENVIRONMENT_GET_CAN_DUPE:
                if (data) *reinterpret_cast<bool*>(data) = true;
                return true;
            case RETRO_ENVIRONMENT_SET_PIXEL_FORMAT:
                if (self && data) self->pixel_format = *reinterpret_cast<retro_pixel_format*>(data);
                return true;
            case RETRO_ENVIRONMENT_GET_SYSTEM_DIRECTORY:
            case RETRO_ENVIRONMENT_GET_CORE_ASSETS_DIRECTORY:
                if (data) *reinterpret_cast<const char**>(data) = self->sys_dir.c_str();
                return true;
            case RETRO_ENVIRONMENT_GET_SAVE_DIRECTORY:
                if (data) *reinterpret_cast<const char**>(data) = self->save_dir.c_str();
                return true;
            case RETRO_ENVIRONMENT_GET_LOG_INTERFACE:
                if (data) reinterpret_cast<retro_log_callback*>(data)->log = log_stub;
                return true;
            case RETRO_ENVIRONMENT_GET_OVERSCAN:
                if (data) *reinterpret_cast<bool*>(data) = false;
                return true;
            case RETRO_ENVIRONMENT_GET_VARIABLE:
                // Sin variables definidas: el contrato exige devolver false y no tocar value.
                if (data) reinterpret_cast<retro_variable*>(data)->value = nullptr;
                return false;
            case RETRO_ENVIRONMENT_GET_VARIABLE_UPDATE:
                if (data) *reinterpret_cast<bool*>(data) = false;
                return true;
            case RETRO_ENVIRONMENT_GET_CORE_OPTIONS_VERSION:
                // 0 = interfaz legacy; el frontend no expone opciones (core usa defaults).
                if (data) *reinterpret_cast<unsigned*>(data) = 0;
                return true;
            case RETRO_ENVIRONMENT_GET_LANGUAGE:
                if (data) *reinterpret_cast<unsigned*>(data) = 0;  // English
                return true;
            case RETRO_ENVIRONMENT_GET_INPUT_DEVICE_CAPABILITIES:
                if (data) *reinterpret_cast<std::uint64_t*>(data) = (1ULL << RETRO_DEVICE_JOYPAD);
                return true;
            case RETRO_ENVIRONMENT_GET_MESSAGE_INTERFACE_VERSION:
                if (data) *reinterpret_cast<unsigned*>(data) = 0;
                return true;
            case RETRO_ENVIRONMENT_GET_RUMBLE_INTERFACE:
            case RETRO_ENVIRONMENT_GET_PREFERRED_HW_RENDER:
            case RETRO_ENVIRONMENT_GET_DISK_CONTROL_INTERFACE_VERSION:
                return false;  // no soportado (el core usa stdio por defecto)
            case (RETRO_ENVIRONMENT_GET_VFS_INTERFACE & 0xFFFF):
                return false;  // sin VFS: el core usa stdio; el frontend no lee zip
            case (RETRO_ENVIRONMENT_SET_MEMORY_MAPS & 0xFFFF): {
                // El core solo garantiza validez durante la llamada: copiamos los descriptores.
                if (self && data) {
                    const retro_memory_map* m = static_cast<const retro_memory_map*>(data);
                    if (m && m->descriptors && m->num_descriptors)
                        self->memory_map.assign(m->descriptors, m->descriptors + m->num_descriptors);
                    else
                        self->memory_map.clear();
                }
                return true;
            }
            // Información que el core publica y el frontend puede aceptar e ignorar.
            case RETRO_ENVIRONMENT_SET_VARIABLES:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS_INTL:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS_V2:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS_V2_INTL:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS_DISPLAY:
            case RETRO_ENVIRONMENT_SET_CORE_OPTIONS_UPDATE_DISPLAY_CALLBACK:
            case RETRO_ENVIRONMENT_SET_INPUT_DESCRIPTORS:
            case RETRO_ENVIRONMENT_SET_PERFORMANCE_LEVEL:
            case RETRO_ENVIRONMENT_SET_SUPPORT_ACHIEVEMENTS:
            case RETRO_ENVIRONMENT_SET_SUPPORT_NO_GAME:
            case RETRO_ENVIRONMENT_SET_CONTROLLER_INFO:
            case RETRO_ENVIRONMENT_SET_SUBSYSTEM_INFO:
            case RETRO_ENVIRONMENT_SET_SYSTEM_AV_INFO:
            case RETRO_ENVIRONMENT_SET_GEOMETRY:
            case RETRO_ENVIRONMENT_SET_MESSAGE_EXT:
            case RETRO_ENVIRONMENT_SET_ROTATION:
                return true;
            default:
                return false;
        }
    }

    static void video(const void* data, unsigned width, unsigned height, std::size_t pitch) {
        Impl* self = reinterpret_cast<Impl*>(g_active ? g_active->impl_.get() : nullptr);
        if (!self || !data) return;
        self->fw = width;
        self->fh = height;
        self->frame.assign(static_cast<std::size_t>(width) * height * 4, 0);
        for (unsigned y = 0; y < height; ++y) {
            const std::uint8_t* row = static_cast<const std::uint8_t*>(data) + y * pitch;
            for (unsigned x = 0; x < width; ++x) {
                std::uint8_t r = 0, g = 0, b = 0;
                switch (self->pixel_format) {
                    case RETRO_PIXEL_FORMAT_XRGB8888: {
                        std::uint32_t p;
                        std::memcpy(&p, row + x * 4, 4);
                        r = (p >> 16) & 0xff; g = (p >> 8) & 0xff; b = p & 0xff;
                        break;
                    }
                    case RETRO_PIXEL_FORMAT_RGB565: {
                        std::uint16_t p;
                        std::memcpy(&p, row + x * 2, 2);
                        r = ((p >> 11) & 0x1f) << 3; g = ((p >> 5) & 0x3f) << 2; b = (p & 0x1f) << 3;
                        break;
                    }
                    default: {  // 0RGB1555
                        std::uint16_t p;
                        std::memcpy(&p, row + x * 2, 2);
                        r = ((p >> 10) & 0x1f) << 3; g = ((p >> 5) & 0x1f) << 3; b = (p & 0x1f) << 3;
                        break;
                    }
                }
                std::size_t o = (static_cast<std::size_t>(y) * width + x) * 4;
                self->frame[o + 0] = r; self->frame[o + 1] = g; self->frame[o + 2] = b; self->frame[o + 3] = 0xff;
            }
        }
    }

    static void audio(std::int16_t, std::int16_t) {}
    static std::size_t audio_batch(const std::int16_t*, std::size_t frames) { return frames; }
    static void input_poll() {}
    static std::int16_t input_state(unsigned port, unsigned device, unsigned /*index*/, unsigned id) {
        Impl* self = reinterpret_cast<Impl*>(g_active ? g_active->impl_.get() : nullptr);
        if (!self || port != 0 || device != RETRO_DEVICE_JOYPAD) return 0;
        const InputState& in = self->input;
        switch (id) {
            case RETRO_DEVICE_ID_JOYPAD_UP: return in.up;
            case RETRO_DEVICE_ID_JOYPAD_DOWN: return in.down;
            case RETRO_DEVICE_ID_JOYPAD_LEFT: return in.left;
            case RETRO_DEVICE_ID_JOYPAD_RIGHT: return in.right;
            case RETRO_DEVICE_ID_JOYPAD_A: return in.fire;
            case RETRO_DEVICE_ID_JOYPAD_B: return in.fire;
            case RETRO_DEVICE_ID_JOYPAD_START: return in.start;
            case RETRO_DEVICE_ID_JOYPAD_SELECT: return in.coin;
            case RETRO_DEVICE_ID_JOYPAD_L2: return in.l2;
            case RETRO_DEVICE_ID_JOYPAD_R2: return in.r2;
            default: return 0;
        }
    }
};

LibretroAdapter::LibretroAdapter(const std::string& core_path) : impl_(std::make_unique<Impl>()) {
    impl_->core_path = core_path;
    impl_->resolve();
    if (impl_->retro_api_version() != RETRO_API_VERSION)
        throw std::runtime_error("versión de API del core no soportada");

    g_active = this;
    // Orden canónico del frontend: environment -> init -> resto de callbacks.
    // Algunos cores (p. ej. mesen) asumen que retro_init ya se ha ejecutado cuando
    // reciben retro_set_video_refresh/audio/input.
    impl_->retro_set_environment(&Impl::env);
    impl_->retro_init();
    impl_->retro_set_video_refresh(&Impl::video);
    impl_->retro_set_audio_sample(&Impl::audio);
    impl_->retro_set_audio_sample_batch(&Impl::audio_batch);
    impl_->retro_set_input_poll(&Impl::input_poll);
    impl_->retro_set_input_state(&Impl::input_state);

    retro_system_info si{};
    impl_->retro_get_system_info(&si);
    if (si.library_name) impl_->core_name = si.library_name;
}

LibretroAdapter::~LibretroAdapter() {
    if (impl_) {
        if (impl_->loaded && impl_->retro_unload_game) impl_->retro_unload_game();
        if (impl_->retro_deinit) impl_->retro_deinit();
        if (impl_->handle) close_lib(impl_->handle);
    }
    g_active = nullptr;
}

void LibretroAdapter::load_rom(const std::string& path) {
    std::ifstream f(path, std::ios::binary);
    if (f) {
        impl_->rom_data.assign(std::istreambuf_iterator<char>(f), std::istreambuf_iterator<char>());
    }
    retro_game_info gi{};
    gi.path = path.c_str();
    gi.data = impl_->rom_data.empty() ? nullptr : impl_->rom_data.data();
    gi.size = impl_->rom_data.size();
    gi.meta = nullptr;
    if (!impl_->retro_load_game(&gi)) throw std::runtime_error("retro_load_game falló: " + path);
    impl_->loaded = true;
    if (impl_->retro_set_controller_port_device)
        impl_->retro_set_controller_port_device(0, RETRO_DEVICE_JOYPAD);
}

void LibretroAdapter::reset() { if (impl_->retro_reset) impl_->retro_reset(); }

void LibretroAdapter::step_frames(int n) {
    for (int i = 0; i < n; ++i) {
        impl_->retro_run();
        ++impl_->frame_no;
        impl_->capture_trace_frame();
    }
}

std::vector<std::uint8_t> LibretroAdapter::save_state() {
    std::size_t size = impl_->retro_serialize_size();
    std::vector<std::uint8_t> buf(size);
    if (size && !impl_->retro_serialize(buf.data(), size)) return {};
    return buf;
}

void LibretroAdapter::load_state(const std::vector<std::uint8_t>& state) {
    if (!state.empty()) impl_->retro_unserialize(state.data(), state.size());
}

void LibretroAdapter::set_input(const InputState& in) { impl_->input = in; }

std::vector<std::uint8_t> LibretroAdapter::read_mem(std::uint32_t addr, std::size_t len) {
    std::vector<std::uint8_t> out;
    void* base = impl_->retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
    std::size_t size = impl_->retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
    if (!base || addr + len > size) return out;
    out.assign(static_cast<std::uint8_t*>(base) + addr, static_cast<std::uint8_t*>(base) + addr + len);
    return out;
}

void LibretroAdapter::write_mem(std::uint32_t addr, const std::vector<std::uint8_t>& bytes) {
    void* base = impl_->retro_get_memory_data(RETRO_MEMORY_SYSTEM_RAM);
    std::size_t size = impl_->retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
    if (!base || addr + bytes.size() > size) return;
    std::memcpy(static_cast<std::uint8_t*>(base) + addr, bytes.data(), bytes.size());
}

void LibretroAdapter::screenshot(const std::string& path) {
    std::ofstream f(path, std::ios::binary);
    if (!f) return;
    f << "P6\n" << impl_->fw << " " << impl_->fh << "\n255\n";
    for (std::size_t i = 0; i + 3 < impl_->frame.size(); i += 4)
        f.write(reinterpret_cast<const char*>(&impl_->frame[i]), 3);  // RGB
}

void LibretroAdapter::set_trace(const TraceConfig& cfg) {
    // libretro no expone trazas de PC de forma genérica. Sí podemos trazar ESCRITURAS a
    // memoria muestreando por frame las regiones publicadas (SET_MEMORY_MAPS / SYSTEM_RAM);
    // las trazas de PC requieren API de debug del core (p. ej. mesen en su build standalone).
    impl_->trace = cfg;
    impl_->tracing = true;
    impl_->frame_no = 0;
    impl_->snapshot_trace();
}

void LibretroAdapter::clear_trace() {
    impl_->trace = TraceConfig{};
    impl_->tracing = false;
    impl_->writes.clear();
    impl_->trace_prev.clear();
}

std::size_t LibretroAdapter::memory_map_count() const { return impl_->memory_map.size(); }

std::vector<std::uint8_t> LibretroAdapter::read_map(std::uint32_t addr, std::size_t len) {
    std::vector<std::uint8_t> out;
    for (const auto& d : impl_->memory_map) {
        if (d.ptr && d.len && addr >= d.start && addr + len <= d.start + d.len) {
            const std::uint8_t* p = static_cast<const std::uint8_t*>(d.ptr) + (addr - d.start);
            out.assign(p, p + len);
            return out;
        }
    }
    return read_mem(addr, len);  // reserva: SYSTEM_RAM
}

const std::vector<LibretroAdapter::TraceWrite>& LibretroAdapter::trace_writes() const {
    return impl_->writes;
}

bool LibretroAdapter::has_re() const { return impl_->rr_re_command != nullptr; }

std::string LibretroAdapter::re_command(const std::string& json) {
    if (!impl_->rr_re_command) return {};
    const char* r = impl_->rr_re_command(json.c_str());
    return r ? std::string(r) : std::string();
}

const std::string& LibretroAdapter::core_name() const { return impl_->core_name; }
unsigned LibretroAdapter::frame_width() const { return impl_->fw; }
unsigned LibretroAdapter::frame_height() const { return impl_->fh; }

std::uint64_t LibretroAdapter::frame_hash() const {
    // FNV-1a 64 bits sobre el framebuffer RGBA8888.
    std::uint64_t h = 1469598103934665603ULL;
    for (std::uint8_t b : impl_->frame) {
        h ^= b;
        h *= 1099511628211ULL;
    }
    return impl_->frame.empty() ? 0 : h;
}

std::vector<std::uint8_t> LibretroAdapter::frame_rgba() const { return impl_->frame; }

std::size_t LibretroAdapter::system_ram_size() const {
    if (!impl_->retro_get_memory_size) return 0;
    return impl_->retro_get_memory_size(RETRO_MEMORY_SYSTEM_RAM);
}

std::vector<std::uint8_t> LibretroAdapter::read_memory(unsigned id, std::uint32_t addr, std::size_t len) {
    std::vector<std::uint8_t> out;
    if (!impl_->retro_get_memory_data || !impl_->retro_get_memory_size) return out;
    void* base = impl_->retro_get_memory_data(id);
    std::size_t size = impl_->retro_get_memory_size(id);
    if (!base || addr + len > size) return out;
    out.assign(static_cast<std::uint8_t*>(base) + addr, static_cast<std::uint8_t*>(base) + addr + len);
    return out;
}

}  // namespace rr
