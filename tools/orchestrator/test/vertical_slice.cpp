// Vertical slice P0.3: ejecuta un core libretro real vía EmulatorControl y vuelca
// trazas/savestates/capturas a extraction/. Ver docs/INSTRUMENTATION.md y
// platforms/arcade/dedicated/namco_pacman/pacman/docs/INSTRUMENTATION.md.
//
// Uso:
//   vertical_slice --core <core.(so|dll)> --rom <rom> --out <dir> [opciones]
//
// Opciones:
//   --frames N        frames totales a ejecutar (def. 600 ≈ 10 s a 60 Hz)
//   --warmup N        frames sin capturar antes de muestrear (def. 0)
//   --interval N      cada N frames guarda savestate + screenshot + dump (def. 60; 0 = solo final)
//   --dump-ram A:L[,A:L...]  rangos de RAM del sistema a volcar (def. 0:4096 si el core expone RAM)
//   --scenario S      idle | start  (def. idle)
//   --det K           frames de la comprobación de determinismo (def. 30; 0 = omitir)
//
// Salidas en <dir>:
//   traces/manifest.json, traces/frames.csv
//   savestates/frame_%06u.state, screenshots/frame_%06u.ppm
//   memory_dumps/frame_%06u_ram_<hex>_<hex>.bin

#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <optional>
#include <sstream>
#include <string>
#include <vector>

#include "libretro_adapter.hpp"
#include "libretro_api.hpp"

using namespace rr;
namespace fs = std::filesystem;

namespace {

struct Range {
    std::uint32_t addr;
    std::size_t len;
};

std::vector<Range> parse_ranges(const std::string& spec) {
    std::vector<Range> out;
    std::stringstream ss(spec);
    std::string item;
    while (std::getline(ss, item, ',')) {
        if (item.empty()) continue;
        auto colon = item.find(':');
        Range r{};
        if (colon == std::string::npos) {
            r.addr = static_cast<std::uint32_t>(std::stoul(item, nullptr, 0));
            r.len = 1;
        } else {
            r.addr = static_cast<std::uint32_t>(std::stoul(item.substr(0, colon), nullptr, 0));
            r.len = static_cast<std::size_t>(std::stoul(item.substr(colon + 1), nullptr, 0));
        }
        out.push_back(r);
    }
    return out;
}

std::string hex64(std::uint64_t v) {
    char buf[17];
    std::snprintf(buf, sizeof(buf), "%016llx", static_cast<unsigned long long>(v));
    return std::string(buf);
}

std::string frame_name(unsigned f) {
    char buf[32];
    std::snprintf(buf, sizeof(buf), "frame_%06u", f);
    return std::string(buf);
}

void write_file(const fs::path& p, const std::vector<std::uint8_t>& data) {
    std::ofstream f(p, std::ios::binary);
    if (f) f.write(reinterpret_cast<const char*>(data.data()), static_cast<std::streamsize>(data.size()));
}

InputState scenario_input(const std::string& scenario, unsigned frame) {
    InputState in;
    if (scenario == "start") {
        // Pulso de moneda en el frame 2 y de start en el 4 (suficiente para cores arcade).
        if (frame == 2) in.coin = true;
        if (frame == 4) in.start = true;
    }
    return in;
}

}  // namespace

int main(int argc, char** argv) {
    std::string core, rom, out;
    unsigned frames = 600, warmup = 0, interval = 60, det = 30;
    std::string scenario = "idle";
    std::vector<Range> ranges;
    bool have_ranges = false;
    std::string trace_writes;

    for (int i = 1; i < argc; ++i) {
        std::string a = argv[i];
        auto next = [&]() -> std::string { return (i + 1 < argc) ? argv[++i] : std::string(); };
        if (a == "--core") core = next();
        else if (a == "--rom") rom = next();
        else if (a == "--out") out = next();
        else if (a == "--frames") frames = static_cast<unsigned>(std::stoul(next()));
        else if (a == "--warmup") warmup = static_cast<unsigned>(std::stoul(next()));
        else if (a == "--interval") interval = static_cast<unsigned>(std::stoul(next()));
        else if (a == "--det") det = static_cast<unsigned>(std::stoul(next()));
        else if (a == "--scenario") scenario = next();
        else if (a == "--dump-ram") { ranges = parse_ranges(next()); have_ranges = true; }
        else if (a == "--trace-writes") trace_writes = next();
        else { std::fprintf(stderr, "opción desconocida: %s\n", a.c_str()); return 2; }
    }
    if (core.empty() || rom.empty() || out.empty()) {
        std::fprintf(stderr,
            "uso: vertical_slice --core <core> --rom <rom> --out <dir> "
            "[--frames N] [--warmup N] [--interval N] [--dump-ram A:L,...] "
            "[--trace-writes A:L] [--scenario idle|start] [--det K]\n");
        return 2;
    }

    const fs::path root(out);
    fs::create_directories(root / "traces");
    fs::create_directories(root / "savestates");
    fs::create_directories(root / "screenshots");
    fs::create_directories(root / "memory_dumps");

    try {
        LibretroAdapter emu(core);
        std::printf("core: %s\n", emu.core_name().c_str());
        emu.load_rom(rom);
        std::printf("rom: %s\n", rom.c_str());

        // RAM del sistema (si el core la expone) y rangos por defecto.
        const std::size_t ram = emu.system_ram_size();
        std::printf("system RAM: %zu bytes\n", ram);
        if (!have_ranges && ram > 0) {
            ranges.push_back(Range{0, std::min<std::size_t>(ram, 4096)});
        }

        std::printf("warmup %u + %u frames (scenario=%s)\n", warmup, frames, scenario.c_str());
        for (unsigned i = 0; i < warmup; ++i) {
            emu.set_input(scenario_input(scenario, i));
            emu.step_frames(1);
        }

        std::size_t state_size = 0;
        {
            auto st = emu.save_state();
            state_size = st.size();
            if (!st.empty()) write_file(root / "savestates" / "warmup.state", st);
        }

        // --- Comprobación de determinismo (mismo state+input => mismo framebuffer) ---
        bool det_ok = true;
        unsigned det_checked = 0;
        unsigned det_first_diff = 0;
        if (det > 0 && emu.save_state().size() > 0) {
            auto state = emu.save_state();
            std::vector<std::uint64_t> h1, h2;
            // Frame de cebado: tras load_state algunos cores emiten un frame "duplicado"
            // (data==NULL) y no hay frame nuevo; se descarta para comparar en fase equivalente.
            emu.set_input(scenario_input(scenario, 0));
            emu.step_frames(1);
            for (unsigned i = 0; i < det; ++i) {
                emu.set_input(scenario_input(scenario, i + 1));
                emu.step_frames(1);
                h1.push_back(emu.frame_hash());
            }
            emu.load_state(state);
            emu.set_input(scenario_input(scenario, 0));
            emu.step_frames(1);
            for (unsigned i = 0; i < det; ++i) {
                emu.set_input(scenario_input(scenario, i + 1));
                emu.step_frames(1);
                h2.push_back(emu.frame_hash());
            }
            det_checked = det;
            for (unsigned i = 0; i < det; ++i) {
                if (h1[i] != h2[i]) { det_ok = false; det_first_diff = i + 1; break; }
            }
            std::ofstream dcsv(root / "traces" / "determinism.csv");
            dcsv << "frame,hash_run1,hash_run2,equal\n";
            for (unsigned i = 0; i < det; ++i)
                dcsv << (i + 1) << ',' << hex64(h1[i]) << ',' << hex64(h2[i]) << ','
                     << (h1[i] == h2[i] ? 1 : 0) << '\n';
            emu.load_state(state);
        }
        std::string det_msg = det_ok ? "OK" : "FALLO";
        if (det_first_diff) det_msg += "; 1\xc2\xaa divergencia en frame " + std::to_string(det_first_diff);
        std::printf("determinismo: %s (%u frames)\n", det_msg.c_str(), det_checked);

        // --- Traza de escrituras a memoria (TraceConfig kind=MemoryWrite) ---
        std::size_t write_count = 0;
        if (!trace_writes.empty()) {
            TraceConfig cfg;
            cfg.kind = TraceKind::MemoryWrite;
            cfg.addr_start = static_cast<std::uint32_t>(std::stoul(trace_writes.substr(0, trace_writes.find(':')), nullptr, 0));
            cfg.addr_end = cfg.addr_start + static_cast<std::uint32_t>(
                                                std::stoul(trace_writes.substr(trace_writes.find(':') + 1), nullptr, 0));
            emu.set_trace(cfg);
        }

        // --- Recorrido principal con muestreo ---
        std::ofstream csv(root / "traces" / "frames.csv");
        csv << "frame,width,height,frame_hash\n";

        for (unsigned i = 0; i < frames; ++i) {
            emu.set_input(scenario_input(scenario, i));
            emu.step_frames(1);

            const bool sample = (interval > 0 && (i + 1) % interval == 0) || (i + 1 == frames);
            if (!sample) continue;

            const std::string name = frame_name(i + 1);
            csv << (i + 1) << ',' << emu.frame_width() << ',' << emu.frame_height() << ','
                << hex64(emu.frame_hash()) << '\n';

            auto st = emu.save_state();
            if (!st.empty()) write_file(root / "savestates" / (name + ".state"), st);
            emu.screenshot((root / "screenshots" / (name + ".ppm")).string());

            for (const Range& r : ranges) {
                auto mem = emu.read_memory(RETRO_MEMORY_SYSTEM_RAM, r.addr, r.len);
                if (mem.empty()) continue;
                char suffix[64];
                std::snprintf(suffix, sizeof(suffix), "_ram_%08x_%08x.bin", r.addr,
                              static_cast<unsigned>(r.addr + r.len));
                write_file(root / "memory_dumps" / (name + suffix), mem);
            }
        }

        // --- Trazas de escritura ---
        if (!trace_writes.empty()) {
            const auto& ws = emu.trace_writes();
            write_count = ws.size();
            std::ofstream wcsv(root / "traces" / "writes.csv");
            wcsv << "frame,addr,old,new\n";
            for (const auto& w : ws) {
                char buf[64];
                std::snprintf(buf, sizeof(buf), "%u,0x%08x,0x%02x,0x%02x", w.frame, w.addr, w.old_value, w.value);
                wcsv << buf << '\n';
            }
            std::printf("escrituras trazadas: %zu\n", write_count);
        }

        // --- Manifiesto ---
        std::ofstream man(root / "traces" / "manifest.json");
        man << "{\n"
            << "  \"core\": \"" << emu.core_name() << "\",\n"
            << "  \"core_file\": \"" << core << "\",\n"
            << "  \"rom\": \"" << rom << "\",\n"
            << "  \"width\": " << emu.frame_width() << ",\n"
            << "  \"height\": " << emu.frame_height() << ",\n"
            << "  \"frames\": " << frames << ",\n"
            << "  \"warmup\": " << warmup << ",\n"
            << "  \"interval\": " << interval << ",\n"
            << "  \"scenario\": \"" << scenario << "\",\n"
            << "  \"savestate_size\": " << state_size << ",\n"
            << "  \"system_ram_size\": " << ram << ",\n"
            << "  \"determinism\": {\"checked_frames\": " << det_checked
            << ", \"ok\": " << (det_ok ? "true" : "false") << "},\n"
            << "  \"trace_writes\": " << write_count << ",\n"
            << "  \"final_frame_hash\": \"" << hex64(emu.frame_hash()) << "\"\n"
            << "}\n";

        std::printf("salida: %s\n", root.string().c_str());
        if (!det_ok) return 1;
        return 0;
    } catch (const std::exception& e) {
        std::fprintf(stderr, "ERROR: %s\n", e.what());
        return 3;
    }
}
