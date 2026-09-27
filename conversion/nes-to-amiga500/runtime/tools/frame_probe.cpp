// frame_probe.cpp — ejecuta una ROM N frames con el intérprete e imprime, por
// frame, un hash de RAM, el PC y registros PPU ($2000/$2001), para detectar si el
// juego queda **bloqueado** (hash constante) o avanza. Uso: frame_probe <rom> [frames]

#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "../fallback/nes_palette.hpp"
#include "../include/nes_system.hpp"
#include "../host/rom_loader.hpp"

namespace {
n2a::LoadedRom g_rom;
std::FILE* g_wt = nullptr;  ///< Volcado de escrituras a `$2007` (addr lo/hi + valor).
std::FILE* g_reg = nullptr;   ///< Volcado de escrituras a registros PPU (reg + valor).
std::FILE* g_mmc1 = nullptr;  ///< Volcado de commits MMC1 (reg + valor).
std::FILE* g_cpu = nullptr;   ///< Traza de CPU (pc lo/hi, op, A, X, Y, P, SP, scan lo/hi).
unsigned long long g_cpu_n = 0; ///< Instrucciones trazadas.
n2a::NesSystem* g_sys = nullptr; ///< Para leer la scanline en la traza.

/// Callback de traza de CPU: escribe 10 bytes por instrucción.
void trace_cpu(void* /*user*/, eng::u16 pc, eng::u8 op, const n2a::CPU& c) {
	if (g_cpu == nullptr || g_cpu_n > 4000000ULL) {
		return;
	}
	eng::u8 p = 0x20u;
	if (c.N) p |= 0x80u;
	if (c.V) p |= 0x40u;
	if (c.D) p |= 0x08u;
	if (c.I) p |= 0x04u;
	if (c.Z) p |= 0x02u;
	if (c.C) p |= 0x01u;
	const eng::u32 cyc = (g_sys != nullptr) ? g_sys->interp.cycles : 0u;
	const unsigned char b[12] = {static_cast<unsigned char>(pc & 0xFFu),
				     static_cast<unsigned char>(pc >> 8u),
				     op,
				     c.A,
				     c.X,
				     c.Y,
				     p,
				     c.SP,
				     static_cast<unsigned char>(cyc & 0xFFu),
				     static_cast<unsigned char>((cyc >> 8u) & 0xFFu),
				     static_cast<unsigned char>((cyc >> 16u) & 0xFFu),
				     static_cast<unsigned char>((cyc >> 24u) & 0xFFu)};
	std::fwrite(b, 1, 12, g_cpu);
	++g_cpu_n;
}

/// Callback de commits MMC1: escribe `(reg, value)`.
void trace_mmc1(eng::u8 reg, eng::u8 value) {
	if (g_mmc1 != nullptr) {
		const unsigned char b[2] = {reg, value};
		std::fwrite(b, 1, 2, g_mmc1);
	}
}

/// Callback de traza de registros PPU: escribe `(reg, value)`.
void trace_ppu_reg(eng::u8 reg, eng::u8 value) {
	if (g_reg != nullptr) {
		const unsigned char b[2] = {reg, value};
		std::fwrite(b, 1, 2, g_reg);
	}
}

/// Callback de traza de `$2007`: escribe `addr` (lo, hi) y `value`.
void trace_ppu_write(eng::u16 addr, eng::u8 value) {
	if (g_wt != nullptr) {
		const unsigned char b[3] = {static_cast<unsigned char>(addr & 0xFFu),
					    static_cast<unsigned char>(addr >> 8u), value};
		std::fwrite(b, 1, 3, g_wt);
	}
}
} // namespace

// Probe de lecturas de $2002: lo usa `nes_ppu.hpp` cuando se compila con
// -DN2A_PPU_READ_PROBE. Imprime (scanline, dot, status) de las N primeras
// lecturas para comparar la posición exacta del flag de VBlank con la referencia.
namespace n2a {
void n2a_ppu_probe(unsigned scanline, unsigned dot, unsigned status) {
	static unsigned long n = 0;
	const unsigned long gdot = static_cast<unsigned long>(scanline) * 341UL + dot;
	// Solo lecturas cerca de la zona de VBlank (scanline 239-243), suficientes para
	// ver dónde aparece el flag respecto al bucle de espera del juego.
	if (n < 200000UL && scanline >= 239u && scanline <= 243u) {
		std::printf("[2002] n=%lu gdot=%lu sl=%u dot=%u st=%02X vbl=%u\n", n, gdot, scanline,
			    dot, status, (status >> 7) & 1u);
	}
	++n;
}
} // namespace n2a

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: frame_probe <rom.nes> [frames] [--fast-timing]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 120;
	bool cycle_exact = true;
	bool trace = false;
	for (int i = 1; i < argc; ++i) {
		if (std::strcmp(argv[i], "--fast-timing") == 0) {
			cycle_exact = false; // desactiva el reloj de bus por acceso
		}
		if (std::strcmp(argv[i], "--trace") == 0) {
			trace = true; // vuelca la traza de CPU a frame_probe.cpu
		}
	}
	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar\n");
		return 1;
	}
	g_wt = std::fopen("frame_probe.wt", "wb");
	g_reg = std::fopen("frame_probe.reg", "wb");
	g_mmc1 = std::fopen("frame_probe.mmc1", "wb");
	sys.load_mapper(g_rom.mapper);
	sys.reset();
	sys.set_cycle_exact(cycle_exact);
	sys.ppu.write_trace = &trace_ppu_write; // tras reset(): este hace `ppu = Ppu{}`
	sys.ppu.reg_trace = &trace_ppu_reg;
	sys.mapper.write_trace = &trace_mmc1;
	if (trace) {
		g_cpu = std::fopen("frame_probe.cpu", "wb");
		g_sys = &sys;
		sys.interp.trace = &trace_cpu;
	}
	std::printf("mapper=%u prg=%u chr=%u mirror_h=%d\n", g_rom.mapper_no, g_rom.prg_size,
		    g_rom.chr_size, static_cast<int>(g_rom.mapper.mirror_h));
	for (int f = 0; f < frames; ++f) {
		sys.run_frame();
		eng::u32 h = 2166136261u;
		for (unsigned i = 0; i < 0x800u; ++i) {
			h = (h ^ sys.mem.ram[i]) * 16777619u;
		}
		eng::u32 fb = 2166136261u;
		for (unsigned i = 0; i < n2a::NesSystem::kScreenW * n2a::NesSystem::kScreenH; ++i) {
			fb = (fb ^ sys.ppu.fb[i]) * 16777619u;
		}
		std::printf("f=%3d PC=%04X cyc=%u nmi=%u irq=%u@%d ram=%08X fb=%08X ctrl=%02X mask=%02X st=%02X jam=%d op=%02X@%04X m1c=%02X m1p=%02X\n",
			    f, sys.cpu.PC, sys.interp.cycles, sys.nmi_count, sys.mapper.mmc3_irq_count,
			    (sys.mapper.mmc3_irq_scan == 0xFFFFu) ? -1
								  : static_cast<int>(sys.mapper.mmc3_irq_scan),
			    h, fb, sys.ppu.ctrl, sys.ppu.mask, sys.ppu.status,
			    static_cast<int>(sys.interp.jammed), sys.interp.jam_op, sys.interp.jam_pc,
			    sys.mapper.mmc1_ctrl, sys.mapper.mmc1_prg);
	}
	// Resumen del último frame: colores distintos y volcado del framebuffer a PPM
	// (índices de paleta -> RGB NES) para inspección visual.
	const int w = n2a::NesSystem::kScreenW;
	const int h = n2a::NesSystem::kScreenH;
	bool seen[64] = {};
	int distinct = 0;
	for (int i = 0; i < w * h; ++i) {
		const int c = sys.ppu.fb[i] & 0x3F;
		if (!seen[c]) {
			seen[c] = true;
			++distinct;
		}
	}
	std::printf("ultimo frame: %d colores distintos\n", distinct);
	if (FILE* fp = std::fopen("frame_probe.ppm", "wb")) {
		std::fprintf(fp, "P6\n%d %d\n255\n", w, h);
		for (int i = 0; i < w * h; ++i) {
			const eng::u8* px = n2a::kPaletteRgb[sys.ppu.fb[i] & 0x3F];
			std::fwrite(px, 1, 3, fp);
		}
		std::fclose(fp);
		std::printf("escrito frame_probe.ppm\n");
	}
	// Volcados de depuración: CHR y las dos nametables (bancos de VRA M).
	if (FILE* fp = std::fopen("frame_probe.chr", "wb")) {
		std::fwrite(sys.ppu.chr, 1, sys.ppu.chr_size, fp);
		std::fclose(fp);
	}
	if (FILE* fp = std::fopen("frame_probe.nt", "wb")) {
		std::fwrite(sys.ppu.vram, 1, sizeof(sys.ppu.vram), fp);
		std::fclose(fp);
	}
	if (FILE* fp = std::fopen("frame_probe.pal", "wb")) {
		std::fwrite(sys.ppu.palette, 1, sizeof(sys.ppu.palette), fp);
		std::fclose(fp);
	}
	if (FILE* fp = std::fopen("frame_probe.ram", "wb")) {
		std::fwrite(sys.mem.ram, 1, sizeof(sys.mem.ram), fp);
		std::fclose(fp);
	}
	if (g_wt != nullptr) {
		std::fclose(g_wt);
	}
	if (g_reg != nullptr) {
		std::fclose(g_reg);
	}
	if (g_mmc1 != nullptr) {
		std::fclose(g_mmc1);
	}
	if (g_cpu != nullptr) {
		std::fclose(g_cpu);
	}
	std::printf("escrito frame_probe.[ppm|chr|nt|ram|wt]\n");
	return 0;
}
