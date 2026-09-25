#ifndef RR_EMULATOR_CONTROL_HPP
#define RR_EMULATOR_CONTROL_HPP

// RetroReverse — contrato de emulación observable y determinista.
// Ver docs/INSTRUMENTATION.md. Implementaciones: WinUAE-DBG (Amiga) y libretro (arcade/consola).

#include <cstddef>
#include <cstdint>
#include <string>
#include <vector>

namespace rr {

// Acciones lógicas de input (frame-exactas; sin wall-clock).
struct InputState {
    bool up = false;
    bool down = false;
    bool left = false;
    bool right = false;
    bool fire = false;
    bool start = false;
    bool coin = false;
    // Botones extra (libretro L2/R2); usados por hotkeys del emulador de reversing.
    bool l2 = false;
    bool r2 = false;
};

enum class TraceKind {
    Execution,    // PC por rango
    MemoryRead,   // lecturas por rango
    MemoryWrite,  // escrituras por rango
    IoWrite,      // escrituras a registros de hardware
};

struct TraceConfig {
    TraceKind kind = TraceKind::Execution;
    std::uint32_t addr_start = 0;
    std::uint32_t addr_end = 0;
    int sample = 1;  // registrar 1 de cada N eventos
};

// Interfaz que debe cumplir todo emulador instrumentado.
class EmulatorControl {
public:
    virtual ~EmulatorControl() = default;

    virtual void load_rom(const std::string& path) = 0;
    virtual void reset() = 0;

    // Avance determinista.
    virtual void step_frames(int n) = 0;

    // Savestate en memoria (O(1)) para ramificar la exploración.
    virtual std::vector<std::uint8_t> save_state() = 0;
    virtual void load_state(const std::vector<std::uint8_t>& state) = 0;

    // Input de 1 frame.
    virtual void set_input(const InputState& in) = 0;

    // Memoria (RAM/VRAM/registros).
    virtual std::vector<std::uint8_t> read_mem(std::uint32_t addr, std::size_t len) = 0;
    virtual void write_mem(std::uint32_t addr, const std::vector<std::uint8_t>& bytes) = 0;

    // Captura del framebuffer.
    virtual void screenshot(const std::string& path) = 0;

    // Trazas.
    virtual void set_trace(const TraceConfig& cfg) = 0;
    virtual void clear_trace() = 0;
};

}  // namespace rr

#endif  // RR_EMULATOR_CONTROL_HPP
