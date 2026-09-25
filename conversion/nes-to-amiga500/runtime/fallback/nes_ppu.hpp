#pragma once

/// \file nes_ppu.hpp
/// PPU software (2C02) del camino de **fallback** (fase F3): registros, VRAM,
/// OAM, paleta, scroll y render del **fondo** a un framebuffer de índices de
/// color NES.
///
/// Es el oráculo independiente del nodo: permite comparar contra `mesen` y sirve
/// de referencia cuando el camino HLE (Copper/Blitter) no reconoce un patrón.
///
/// Alcance actual (F3 en curso): fondo con nametables, attribute tables, pattern
/// tables (CHR), scroll grueso/fino y VBlank/NMI. **Pendiente**: sprites, sprite-0
/// hit, scroll fino por línea (mid-frame) y la conversión a bitplanes Amiga.

#include <eng/core/types/types.hpp>

namespace n2a {

/// Ancho y alto visibles de la NES (NTSC).
inline constexpr int kPpuWidth = 256;
inline constexpr int kPpuHeight = 240;

/// PPU 2C02 mínima. Todos los registros y buffers son estado propio; el CHR
/// (pattern tables) lo aporta el cartucho mediante el puntero `chr`.
struct Ppu {
	// --- Registros ($2000-$2007) ---
	eng::u8 ctrl = 0;      ///< $2000: NMI, tamaño de sprite, base de BG/sprite, incremento, nametable.
	eng::u8 mask = 0;      ///< $2001: habilitación de BG/sprites y énfasis.
	eng::u8 status = 0;    ///< $2002: VBlank, sprite 0 hit, overflow.
	eng::u8 oam_addr = 0;  ///< $2003: dirección de OAM para $2004.

	// --- Memoria ---
	eng::u8 vram[0x800] {};       ///< 2 KB de nametables ($2000-$27FF, espejadas).
	eng::u8 oam[0x100] {};        ///< 256 B de OAM (64 sprites × 4).
	eng::u8 palette[0x20] {};     ///< 32 B de paleta ($3F00-$3F1F): índices de color NES.
	const eng::u8* chr = nullptr; ///< Pattern tables (CHR-ROM), no propietario.
	eng::u32 chr_size = 0;        ///< Tamaño de CHR en bytes.

	// --- Dirección/scroll ---
	eng::u16 v = 0;          ///< Dirección de VRAM ($2006) o dirección temporal.
	eng::u8 scroll_x = 0;    ///< Scroll grueso/fino horizontal global.
	eng::u8 scroll_y = 0;    ///< Scroll grueso/fino vertical global.
	bool write_toggle = false; ///< Latch de dos escrituras ($2005/$2006).

	/// Scroll por línea (para splits mid-frame): si `line_scroll` está activo, la
	/// línea `y` usa `line_sx[y]`/`line_sy[y]` en lugar del scroll global.
	eng::u8 line_sx[kPpuHeight] {};
	eng::u8 line_sy[kPpuHeight] {};
	bool line_scroll = false;

	/// Fija el scroll de la línea `y` (splits mid-frame). \param y Línea; \param sx
	/// scroll X; \param sy scroll Y.
	void set_line_scroll(int y, eng::u8 sx, eng::u8 sy) {
		if (y >= 0 && y < kPpuHeight) {
			line_sx[y] = sx;
			line_sy[y] = sy;
			line_scroll = true;
		}
	}

	// --- Tiempo ---
	eng::u16 scanline = 0;   ///< Línea actual (0..261 en NTSC).
	bool nmi_occurred = false; ///< Se puso el flag de VBlank (NMI si `ctrl & 0x80`).

	/// Framebuffer de índices de color NES (0..63), fila a fila (256×240).
	eng::u8 fb[kPpuWidth * kPpuHeight] {};
	/// Mapa de opacidad del fondo (1 = píxel de fondo con color != 0). Lo usa el
	/// compositor de sprites para prioridad y sprite-0 hit.
	eng::u8 bg_opaque[kPpuWidth * kPpuHeight] {};

	/// Lee un registro de la PPU `$2000-$2007`.
	/// \param addr Dirección en el rango de PPU (ya espejada a 8 bytes).
	/// \return El byte leído. `$2002` limpia VBlank y el latch; `$2007` avanza `v`.
	eng::u8 read_reg(eng::u16 addr) {
		switch (addr & 0x07u) {
		case 2u: {  // PPUSTATUS
			const eng::u8 r = static_cast<eng::u8>(status & 0xE0u);
			status = static_cast<eng::u8>(status & ~0x80u);
			write_toggle = false;
			return r;
		}
		case 4u:  // OAMDATA
			return oam[oam_addr];
		case 7u: {  // PPUDATA
			const eng::u8 r = vram[v & 0x7FFu];
			v = static_cast<eng::u16>(v + ((ctrl & 0x04u) ? 32u : 1u));
			return r;
		}
		default:
			return 0u;
		}
	}

	/// Escribe un registro de la PPU `$2000-$2007`.
	/// \param addr  Dirección en el rango de PPU.
	/// \param value Byte a escribir. `$2005` reparte X e Y; `$2006` fija `v` en dos
	///              escrituras; `$2007` escribe en nametable o paleta.
	void write_reg(eng::u16 addr, eng::u8 value) {
		switch (addr & 0x07u) {
		case 0u:  // PPUCTRL
			ctrl = value;
			break;
		case 1u:  // PPUMASK
			mask = value;
			break;
		case 3u:  // OAMADDR
			oam_addr = value;
			break;
		case 4u:  // OAMDATA
			oam[oam_addr] = value;
			++oam_addr;
			break;
		case 5u:  // PPUSCROLL
			if (!write_toggle) {
				scroll_x = value;
			} else {
				scroll_y = value;
			}
			write_toggle = !write_toggle;
			break;
		case 6u:  // PPUADDR
			if (!write_toggle) {
				v = static_cast<eng::u16>((value & 0x3Fu) << 8u);
			} else {
				v = static_cast<eng::u16>((v & 0xFF00u) | value);
			}
			write_toggle = !write_toggle;
			break;
		case 7u:  // PPUDATA
			if ((v & 0x3F00u) == 0x3F00u) {
				palette[v & 0x1Fu] = static_cast<eng::u8>(value & 0x3Fu);
			} else {
				vram[v & 0x7FFu] = value;
			}
			v = static_cast<eng::u16>(v + ((ctrl & 0x04u) ? 32u : 1u));
			break;
		default:
			break;
		}
	}

	/// Avanza una scanline y, al llegar a la 241, levanta VBlank (y `nmi_occurred`
	/// si `ctrl` lo habilita). En la pre-render (261) reinicia el flag. No modela
	/// aún el timing exacto de dots ni el sprite-0 hit.
	void tick_scanline() {
		++scanline;
		if (scanline == 241u) {
			status = static_cast<eng::u8>(status | 0x80u);
			nmi_occurred = (ctrl & 0x80u) != 0u;
		} else if (scanline == 261u) {
			scanline = 0u;
			status = static_cast<eng::u8>(status & ~0x80u);
		}
	}

	/// Dibuja el **fondo** completo en `fb` (sin sprites) aplicando scroll y
	/// attribute tables. Usa `chr` como pattern tables.
	void render_background() {
		const eng::u16 nt_base = static_cast<eng::u16>((ctrl & 0x03u) * 0x400u);
		const eng::u16 bg_base = (ctrl & 0x10u) ? 0x1000u : 0x0000u;
		const eng::u8 universal = static_cast<eng::u8>(palette[0] & 0x3Fu);

		for (int py = 0; py < kPpuHeight; ++py) {
			const int ly = line_scroll ? line_sy[py] : scroll_y;
			const int lx = line_scroll ? line_sx[py] : scroll_x;
			const int sy = (py + ly) & 0xFF;
			const int ty = sy >> 3;
			const int fine_y = sy & 7;
			for (int px = 0; px < kPpuWidth; ++px) {
				const int sx = (px + lx) & 0xFF;
				const int tx = sx >> 3;
				const int fine_x = sx & 7;

				const eng::u16 nt_off = static_cast<eng::u16>(nt_base + (ty & 31) * 32 + (tx & 31));
				const eng::u8 tile = vram[nt_off & 0x7FFu];
				const eng::u8 attr = attr_bits(nt_base, tx, ty);

				const eng::u16 pat = static_cast<eng::u16>(bg_base + tile * 16u + fine_y);
				eng::u8 p0 = chr_byte(pat);
				eng::u8 p1 = chr_byte(static_cast<eng::u16>(pat + 8u));
				const int bit = 7 - fine_x;
				eng::u8 color = static_cast<eng::u8>(((p0 >> bit) & 1u) | (((p1 >> bit) & 1u) << 1u));
				eng::u8 value;
				if (color == 0u) {
					value = universal;
				} else {
					value = static_cast<eng::u8>(palette[(attr * 4 + color) & 0x1Fu] & 0x3Fu);
				}
				fb[py * kPpuWidth + px] = value;
				bg_opaque[py * kPpuWidth + px] = (color != 0u) ? 1u : 0u;
			}
		}
	}

	/// Dibuja los **sprites** sobre el fondo ya renderizado en `fb`.
	///
	/// Respeta tamaño 8×8/8×16 (`ctrl` bit 5), bases de pattern table, flips H/V,
	/// las 4 paletas de sprite, la prioridad tras el fondo (bit 5 del atributo) y
	/// el límite de **8 sprites por línea** (bit 5 de `status` = overflow). Activa
	/// el bit 6 de `status` (sprite-0 hit) cuando el sprite 0 opaco se solapa con
	/// un píxel de fondo no transparente.
	void render_sprites() {
		const int height = (ctrl & 0x20u) ? 16 : 8;
		for (int y = 0; y < kPpuHeight; ++y) {
			int selected[8];
			int n = 0;
			bool overflow = false;
			for (int i = 0; i < 64; ++i) {
				const int top = static_cast<int>(oam[i * 4 + 0]) + 1;
				const int row = y - top;
				if (row < 0 || row >= height) {
					continue;
				}
				if (n < 8) {
					selected[n++] = i;
				} else {
					overflow = true;
				}
			}
			if (overflow) {
				status = static_cast<eng::u8>(status | 0x20u);
			}
			// De mayor a menor índice: el sprite de índice más bajo queda encima.
			for (int s = n - 1; s >= 0; --s) {
				const int i = selected[s];
				const eng::u8 tile = oam[i * 4 + 1];
				const eng::u8 attr = oam[i * 4 + 2];
				const eng::u8 ox = oam[i * 4 + 3];
				const int row = y - (static_cast<int>(oam[i * 4 + 0]) + 1);
				const bool flip_v = (attr & 0x80u) != 0u;
				const bool flip_h = (attr & 0x40u) != 0u;
				int rr = flip_v ? (height - 1 - row) : row;
				eng::u16 pbase;
				eng::u8 t;
				if (height == 16) {
					pbase = (tile & 1u) ? 0x1000u : 0x0000u;
					t = static_cast<eng::u8>((tile & 0xFEu) + ((rr >= 8) ? 1u : 0u));
					rr &= 7;
				} else {
					pbase = (ctrl & 0x08u) ? 0x1000u : 0x0000u;
					t = tile;
				}
				const eng::u16 pat = static_cast<eng::u16>(pbase + t * 16u + rr);
				const eng::u8 p0 = chr_byte(pat);
				const eng::u8 p1 = chr_byte(static_cast<eng::u16>(pat + 8u));
				for (int col = 0; col < 8; ++col) {
					const int px = static_cast<int>(ox) + col;
					if (px < 0 || px >= kPpuWidth) {
						continue;
					}
					const int bit = flip_h ? col : (7 - col);
					const eng::u8 color =
						static_cast<eng::u8>(((p0 >> bit) & 1u) | (((p1 >> bit) & 1u) << 1u));
					if (color == 0u) {
						continue;
					}
					const int idx = y * kPpuWidth + px;
					if (i == 0 && bg_opaque[idx] != 0u) {
						status = static_cast<eng::u8>(status | 0x40u);  // sprite 0 hit
					}
					const bool behind = (attr & 0x20u) != 0u;
					if (behind && bg_opaque[idx] != 0u) {
						continue;
					}
					const eng::u8 pal = static_cast<eng::u8>(0x10u + (attr & 3u) * 4u + color);
					fb[idx] = static_cast<eng::u8>(palette[pal & 0x1Fu] & 0x3Fu);
				}
			}
		}
	}

	/// Renderiza un frame completo: fondo y luego sprites.
	void render_frame() {
		render_background();
		render_sprites();
	}

private:
	/// Lee un byte de la pattern table (0 si no hay CHR).
	eng::u8 chr_byte(eng::u16 off) const {
		if (chr == nullptr || chr_size == 0u) {
			return 0u;
		}
		return chr[off % chr_size];
	}

	/// Attribute table: 2 bits de paleta por bloque 16×16 (4×4 tiles).
	/// \param nt_base Base de la nametable activa ($2000/$2400/$2800/$2C00).
	/// \param tx,ty   Tile (8×8) dentro de la nametable (0..31).
	/// \return Índice de paleta de fondo (0..3).
	eng::u8 attr_bits(eng::u16 nt_base, int tx, int ty) const {
		const int ax = (tx >> 2) & 7;
		const int ay = (ty >> 2) & 7;
		const eng::u8 byte = vram[(nt_base + 0x3C0 + ay * 8 + ax) & 0x7FFu];
		const int quad = ((ty >> 1) & 1) * 2 + ((tx >> 1) & 1);
		return static_cast<eng::u8>((byte >> (quad * 2)) & 0x03u);
	}
};

} // namespace n2a
