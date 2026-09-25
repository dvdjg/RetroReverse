#ifndef RR_LIBRETRO_ADAPTER_HPP
#define RR_LIBRETRO_ADAPTER_HPP

// Adaptador libretro del contrato EmulatorControl (ver docs/INSTRUMENTATION.md).
// Carga un core libretro (.dll/.so), ejecuta frames y expone RAM/estado/input/screenshot.

#include <memory>
#include <string>

#include "emulator_control.hpp"

namespace rr {

class LibretroAdapter : public EmulatorControl {
public:
    // `core_path` = ruta al core libretro (p. ej. libretro-mame2003-plus/mame2003_plus_libretro.dll).
    explicit LibretroAdapter(const std::string& core_path);
    ~LibretroAdapter() override;

    LibretroAdapter(const LibretroAdapter&) = delete;
    LibretroAdapter& operator=(const LibretroAdapter&) = delete;

    void load_rom(const std::string& path) override;
    void reset() override;
    void step_frames(int n) override;

    std::vector<std::uint8_t> save_state() override;
    void load_state(const std::vector<std::uint8_t>& state) override;

    void set_input(const InputState& in) override;

    // `addr` es relativo al inicio de la RAM del sistema del core (RETRO_MEMORY_SYSTEM_RAM).
    std::vector<std::uint8_t> read_mem(std::uint32_t addr, std::size_t len) override;
    void write_mem(std::uint32_t addr, const std::vector<std::uint8_t>& bytes) override;

    void screenshot(const std::string& path) override;

    void set_trace(const TraceConfig& cfg) override;
    void clear_trace() override;

    // Info del core, útil para logs.
    const std::string& core_name() const;
    unsigned frame_width() const;
    unsigned frame_height() const;

private:
    struct Impl;
    std::unique_ptr<Impl> impl_;
};

}  // namespace rr

#endif  // RR_LIBRETRO_ADAPTER_HPP
