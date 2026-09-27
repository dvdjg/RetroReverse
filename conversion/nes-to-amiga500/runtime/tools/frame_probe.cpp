// frame_probe.cpp — ejecuta una ROM N frames con el intérprete e imprime, por
// frame, un hash de RAM, el PC y registros PPU ($2000/$2001), para detectar si el
// juego queda **bloqueado** (hash constante) o avanza. Uso: frame_probe <rom> [frames]

#include <cstdio>
#include <cstdlib>

#include "../fallback/nes_palette.hpp"
#include "../include/nes_system.hpp"
#include "../host/rom_loader.hpp"

namespace {
n2a::LoadedRom g_rom;
std::FILE* g_wt = nullptr; ///< Volcado de escrituras a `$2007` (addr lo/hi + valor).

/// Callback de traza de `$2007`: escribe `addr` (lo, hi) y `value`.
void trace_ppu_write(eng::u16 addr, eng::u8 value) {
	if (g_wt != nullptr) {
		const unsigned char b[3] = {static_cast<unsigned char>(addr & 0xFFu),
					    static_cast<unsigned char>(addr >> 8u), value};
		std::fwrite(b, 1, 3, g_wt);
	}
}
} // namespace

int main(int argc, char** argv) {
	if (argc < 2) {
		std::printf("uso: frame_probe <rom.nes> [frames]\n");
		return 1;
	}
	const int frames = (argc > 2) ? std::atoi(argv[2]) : 120;
	n2a::NesSystem sys;
	if (!n2a::load_ines(argv[1], g_rom)) {
		std::printf("error: no se pudo cargar\n");
		return 1;
	}
	g_wt = std::fopen("frame_probe.wt", "wb");
	sys.load_mapper(g_rom.mapper);
	sys.reset();
	sys.ppu.write_trace = &trace_ppu_write; // tras reset(): este hace `ppu = Ppu{}`
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
		std::printf("f=%3d PC=%04X nmi=%u ram=%08X fb=%08X ctrl=%02X mask=%02X st=%02X jam=%d\n", f,
			    sys.cpu.PC, sys.nmi_count, h, fb, sys.ppu.ctrl, sys.ppu.mask, sys.ppu.status,
			    static_cast<int>(sys.interp.jammed));
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
	if (FILE* fp = std::fopen("frame_probe.ram", "wb")) {
		std::fwrite(sys.mem.ram, 1, sizeof(sys.mem.ram), fp);
		std::fclose(fp);
	}
	if (g_wt != nullptr) {
		std::fclose(g_wt);
	}
	std::printf("escrito frame_probe.[ppm|chr|nt|ram|wt]\n");
	return 0;
}
