// ppu_test — prueba de la PPU software (fondo + registros) del camino de fallback.
//
// Monta una escena sintética mínima (un tile completamente del color 1 de la
// paleta 0), la renderiza y comprueba píxeles; además valida VBlank/NMI y que
// `$2006`/`$2007` escriben en la VRAM.

#include <cstdio>

#include <eng/core/types/types.hpp>

#include "nes_ppu.hpp"

namespace {

/// Pattern tables sintéticas (8 KB). El tile 0 se rellena con color 1.
eng::u8 g_chr[0x2000];

} // namespace

int main() {
	// Tile 0: plano 0 = 0xFF (todos los bits a 1), plano 1 = 0 → píxel = color 1.
	for (int y = 0; y < 8; ++y) {
		g_chr[y] = 0xFFu;
	}

	n2a::Ppu ppu;
	ppu.chr = g_chr;
	ppu.chr_size = sizeof g_chr;
	ppu.ctrl = 0x00u;      // BG pattern base = 0, nametable = 0, NMI desactivado
	ppu.vram[0] = 0x00u;   // tile 0 en la celda (0,0)
	ppu.palette[0] = 0x0Fu; // color universal (color 0)
	ppu.palette[1] = 0x30u; // paleta 0, índice 1

	ppu.render_background();

	int fail = 0;
	if (ppu.fb[0] != 0x30u) { std::printf("  fb[0]=%02X (esperado 30)\n", ppu.fb[0]); ++fail; }
	if (ppu.fb[100] != 0x30u) { std::printf("  fb[100]=%02X (esperado 30)\n", ppu.fb[100]); ++fail; }
	if (ppu.fb[255] != 0x30u) { std::printf("  fb[255]=%02X (esperado 30)\n", ppu.fb[255]); ++fail; }

	// VBlank/NMI: de la scanline 240 se pasa a la 241.
	ppu.ctrl = 0x80u;
	ppu.scanline = 240u;
	ppu.tick_scanline();
	if ((ppu.status & 0x80u) == 0u || !ppu.nmi_occurred) {
		std::printf("  VBlank/NMI no se activaron\n");
		++fail;
	}

	// $2006 fija la dirección y $2007 escribe en VRAM.
	ppu.write_reg(0x2006u, 0x20u);
	ppu.write_reg(0x2006u, 0x05u);
	ppu.write_reg(0x2007u, 0xABu);
	if (ppu.vram[0x005] != 0xABu) {
		std::printf("  escritura PPUDATA falló (vram[5]=%02X)\n", ppu.vram[0x005]);
		++fail;
	}

	if (fail == 0) {
		std::printf("PPU OK (fondo + registros)\n");
		return 0;
	}
	std::printf("PPU FALLO (%d)\n", fail);
	return 1;
}
