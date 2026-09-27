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
	ppu.mask = 0x1Eu;      // habilita BG+sprites (sin recorte de columna izquierda)
	ppu.vram[0] = 0x00u;   // tile 0 en la celda (0,0)
	ppu.palette[0] = 0x0Fu; // color universal (color 0)
	ppu.palette[1] = 0x30u; // paleta 0, índice 1

	ppu.render_background();

	int fail = 0;
	if (ppu.fb[0] != 0x30u) { std::printf("  fb[0]=%02X (esperado 30)\n", ppu.fb[0]); ++fail; }
	if (ppu.fb[100] != 0x30u) { std::printf("  fb[100]=%02X (esperado 30)\n", ppu.fb[100]); ++fail; }
	if (ppu.fb[255] != 0x30u) { std::printf("  fb[255]=%02X (esperado 30)\n", ppu.fb[255]); ++fail; }

	// --- Scroll mid-frame (por línea) --------------------------------------
	// Tile 2: plano 0 = 0, plano 1 = 0xFF -> color 2 (paleta 2 = 0x27).
	g_chr[32] = 0x00u;
	g_chr[40] = 0xFFu;
	ppu.vram[1] = 0x02u;      // celda (1,0) = tile 2
	ppu.palette[2] = 0x27u;
	ppu.line_scroll = false;
	ppu.render_background();
	if (ppu.fb[0] != 0x30u) {
		std::printf("  bg sin scroll (fb=%02X)\n", ppu.fb[0]);
		++fail;
	}
	ppu.set_line_scroll(0, 8u, 0u);  // la línea 0 arranca 8 px a la derecha
	ppu.render_background();
	if (ppu.fb[0] != 0x27u) {
		std::printf("  scroll mid-frame no aplicado (fb=%02X, esperado 27)\n", ppu.fb[0]);
		++fail;
	}
	ppu.line_scroll = false;

	// --- Sprites -----------------------------------------------------------
	// Tile 1 (pattern base 0): fila 0 con color 1 en todos los píxeles.
	g_chr[16] = 0xFFu;
	ppu.palette[0x11] = 0x16u;  // paleta de sprite 0, índice 1

	ppu.ctrl = 0x00u;           // sprites 8×8, pattern base 0, NMI off
	ppu.mask = 0x1Eu;           // habilita BG+sprites (sin recorte de columna izquierda)
	ppu.oam[0] = 10u;           // Y
	ppu.oam[1] = 1u;            // tile
	ppu.oam[2] = 0x00u;         // atributo: paleta 0, delante
	ppu.oam[3] = 5u;            // X
	ppu.status = 0u;
	ppu.render_background();
	ppu.render_sprites();
	const int sp_y = 11;        // el sprite se dibuja desde Y+1
	if (ppu.fb[sp_y * 256 + 5] != 0x16u) {
		std::printf("  sprite delante no dibujado (fb=%02X)\n", ppu.fb[sp_y * 256 + 5]);
		++fail;
	}
	if ((ppu.status & 0x40u) == 0u) {
		std::printf("  sprite-0 hit no activado\n");
		++fail;
	}

	// Sprite detrás del fondo: el fondo (opaco) debe taparlo.
	ppu.oam[2] = 0x20u;         // bit de prioridad detrás del fondo
	ppu.status = 0u;
	ppu.render_background();
	ppu.render_sprites();
	if (ppu.fb[sp_y * 256 + 5] != 0x30u) {
		std::printf("  sprite detrás no respetó el fondo (fb=%02X)\n", ppu.fb[sp_y * 256 + 5]);
		++fail;
	}

	// Límite de 8 sprites por línea: el noveno marca overflow.
	for (int i = 0; i < 9; ++i) {
		ppu.oam[i * 4 + 0] = 10u;
		ppu.oam[i * 4 + 1] = 1u;
		ppu.oam[i * 4 + 2] = 0x00u;
		ppu.oam[i * 4 + 3] = static_cast<eng::u8>(20 + i * 2);
	}
	ppu.status = 0u;
	ppu.render_background();
	ppu.render_sprites();
	if ((ppu.status & 0x20u) == 0u) {
		std::printf("  overflow de sprites no detectado\n");
		++fail;
	}
	// (deja OAM en un estado inocuo para las pruebas de registro siguientes)
	ppu.oam[0] = 0xF0u;

	// --- Ajuste por ROM: proveedor de tiles 4 bpp --------------------------
	// Sustituye la lectura de CHR por planos de 4 bpp sin tocar la emulación.
	struct Demo4bpp final : n2a::enhance::ITileProvider {
		[[nodiscard]] eng::u8 bpp(n2a::enhance::TileSpace) const override { return 4u; }
		[[nodiscard]] bool fetch_row(n2a::enhance::TileSpace, eng::u16, eng::u8, int, eng::u16,
					     n2a::enhance::TileRow& out) const override {
			out = n2a::enhance::TileRow {};
			out.plane[0] = 0xFFu;  // bit 0 = 1
			out.plane[3] = 0xFFu;  // bit 3 = 1  → color = 0b1001 = 9
			return true;
		}
		[[nodiscard]] eng::u8 color(n2a::enhance::TileSpace, eng::u8, eng::u8 c) const override {
			return c;  // índice directo al framebuffer
		}
	};
	Demo4bpp demo;
	ppu.tile_provider = &demo;
	ppu.scroll_x = 0u;
	ppu.scroll_y = 0u;
	ppu.line_scroll = false;
	ppu.render_background();
	if (ppu.fb[0] != 9u) {
		std::printf("  proveedor 4 bpp no aplicado (fb=%02X, esperado 09)\n", ppu.fb[0]);
		++fail;
	}
	ppu.tile_provider = nullptr;  // vuelve al camino NES 2 bpp

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
		std::printf("PPU OK (fondo + sprites + registros)\n");
		return 0;
	}
	std::printf("PPU FALLO (%d)\n", fail);
	return 1;
}
