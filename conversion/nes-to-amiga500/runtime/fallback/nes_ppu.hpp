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

#include "../enhance/tile_provider.hpp"

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
	/// **CHR-RAM** escribible (8 KB) cuando el cartucho no trae CHR-ROM (`chr ==
	/// nullptr`). La carga el juego por `$2007` en `$0000-$1FFF`.
	eng::u8* chr_ram = nullptr;
	/// **Mirroring de nametables**: `true` = horizontal (según el header iNES;
	/// las dos nametables se apilan en vertical, típico de scroll vertical como
	/// Xevious). `false` = vertical (lado a lado, típico de scroll horizontal como
	/// SMB). Determina qué bit de la dirección NN selecciona la mitad de los 2 KB.
	bool mirror_h = false;
	/// Mirroring de **1 sola pantalla** (MMC1 modos 0/1): `-1` = desactivado (usar
	/// `mirror_h`); `0` = solo pantalla A (banco 0); `1` = solo pantalla B (banco 1).
	/// Toda la VRAM de nametables apunta al mismo banco de 1 KB.
	int nt_single = -1;
	/// Proveedor de tiles opcional (**ajustes por ROM**: otro grupo de tiles o
	/// mayor profundidad, 3/4 bpp). Si es `nullptr`, se usa la CHR 2 bpp normal.
	const enhance::ITileProvider* tile_provider = nullptr;
	/// Paleta extendida opcional (hasta 256 colores `0x0RGB`) para packs de >2 bpp.
	const eng::u16* ext_palette = nullptr;
	/// Hook de **diagnóstico** opcional: si no es `nullptr`, se llama con la
	/// dirección `v` y el valor de cada escritura a `$2007` (nametable o paleta)
	/// para trazar cómo el juego carga la VRAM. No afecta al comportamiento.
	void (*write_trace)(eng::u16 v_addr, eng::u8 value) = nullptr;
	/// Hook de **diagnóstico**: se llama con `(registro, valor)` en cada escritura a
	/// `$2000-$2007` (registro = `addr & 7`), para trazar la secuencia de registros
	/// (p. ej. `$2006`). No afecta al comportamiento.
	void (*reg_trace)(eng::u8 reg, eng::u8 value) = nullptr;

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
	eng::u16 dot = 0;        ///< Dot dentro de la línea (0..340; 341 dots/línea).
	/// **Warm-up del PPU**: durante los primeros frames tras el reset el PPU no
	/// levanta el flag de VBlank (como fceumm, `ppudead=2`). Necesario para que el
	/// bucle de espera de VBlank del juego coincida con la referencia.
	bool vblank_suppress = false;
	bool nmi_occurred = false; ///< Se puso el flag de VBlank (NMI si `ctrl & 0x80`).
	/// Scanline en la que ocurre el **sprite-0 hit** (calculada al renderizar); el
	/// flag de `$2002` se pone al llegar a esa línea (así el CPU lo ve ponerse y
	/// borrarse dentro del frame, como el PPU real). `0xFFFF` = no hay hit.
	eng::u16 sprite0_line = 0xFFFFu;
	/// Columna (dot ≈ píxel 0..255) del primer píxel del sprite-0 hit. El flag se
	/// activa al **alcanzar ese dot** de `sprite0_line`, no al inicio de la línea:
	/// así los juegos que usan sprite-0 como temporizador de raster ven el flanco
	/// en el mismo punto que el PPU real.
	eng::u16 sprite0_dot = 0;

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
			eng::u8 r = static_cast<eng::u8>(status & 0xE0u);
#ifdef N2A_PPU_READ_PROBE
			{
				extern void n2a_ppu_probe(unsigned scanline, unsigned dot, unsigned status);
				n2a_ppu_probe(scanline, dot, status);
			}
#endif
			// Quirk real (mesen PPU.cpp: `if(_scanline == _nmiScanline && _cycle < 3)
			// returnValue &= 0x7F`): en los 3 primeros dots de la línea 241 una lectura
			// de $2002 devuelve el bit de VBlank a 0, aunque el flag ya esté puesto.
			if (scanline == 241u && dot < 3u) r = static_cast<eng::u8>(r & 0x7Fu);
			status = static_cast<eng::u8>(status & ~0x80u);
			write_toggle = false;
			return r;
		}
		case 4u:  // OAMDATA
			return oam[oam_addr];
		case 7u: {  // PPUDATA
			eng::u8 r;
			const int ni = nametable_index(v);
			if ((v & 0x3F00u) == 0x3F00u) {
				r = static_cast<eng::u8>(palette[palette_index(v)] & 0x3Fu);
			} else if (ni >= 0) {
				r = vram[static_cast<eng::usize>(ni)];
			} else {
				// $0000-$1FFF: pattern tables (CHR-ROM o CHR-RAM).
				r = chr_byte(v);
			}
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
		if (reg_trace != nullptr) {
			reg_trace(static_cast<eng::u8>(addr & 0x07u), value);
		}
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
			if (write_trace != nullptr) {
				write_trace(v, value);
			}
			if ((v & 0x3F00u) == 0x3F00u) {
				palette[palette_index(v)] = static_cast<eng::u8>(value & 0x3Fu);
			} else {
				const int ni = nametable_index(v);
				if (ni >= 0) {
					vram[static_cast<eng::usize>(ni)] = value; // nametables ($2000-$3EFF)
				} else if (chr_ram != nullptr && v < 0x2000u) {
					// $0000-$1FFF: carga de **CHR-RAM** (los cartuchos con CHR-ROM,
					// `chr != nullptr`, la ignoran).
					chr_ram[v & 0x1FFFu] = value;
				}
			}
			v = static_cast<eng::u16>(v + ((ctrl & 0x04u) ? 32u : 1u));
			break;
		default:
			break;
		}
	}

	/// Avanza **un dot** (341 por línea). Activa el sprite-0 hit en su dot exacto
	/// (`sprite0_line`, `sprite0_dot`) y, al completar la línea, avanza de scanline.
	/// Es la unidad de avance del PPU: `NesSystem::clock_ppu` lo llama `3*ciclos`
	/// veces por instrucción/bloque.
	void tick_dot() {
		if (scanline == sprite0_line && dot == sprite0_dot) {
			status = static_cast<eng::u8>(status | 0x40u);
		}
		if (++dot >= 341u) {
			dot = 0u;
			tick_scanline();
		}
	}

	/// Avanza una scanline y, al llegar a la 241, levanta VBlank (y `nmi_occurred`
	/// si `ctrl` lo habilita). En la pre-render (261) reinicia los flags y el frame
	/// vuelve a la línea 0 tras la **262** (el PPU NTSC tiene 262 líneas: 0..261).
	void tick_scanline() {
		++scanline;
		if (scanline == 241u) {
			if (!vblank_suppress) {
				status = static_cast<eng::u8>(status | 0x80u);
				nmi_occurred = (ctrl & 0x80u) != 0u;
			}
		} else if (scanline == 261u) {
			// Pre-render: se borran VBlank, sprite-0 y overflow (el PPU real limpia
			// sprite-0/overflow aquí). Sin esto, el bit de sprite-0 quedaba pegado
			// y SMB se colgaba en su bucle de espera.
			status = static_cast<eng::u8>(status & ~0xE0u);
		} else if (scanline == 262u) {
			// Fin de frame: la línea 261 ya contó sus 341 dots. Volver a la 0.
			scanline = 0u;
		}
	}

	/// Dibuja el **fondo** completo en `fb` (sin sprites) aplicando scroll y
	/// attribute tables. Usa `chr` como pattern tables.
	void render_background() {
		const eng::u16 bg_base = (ctrl & 0x10u) ? 0x1000u : 0x0000u;
		const eng::u8 universal = static_cast<eng::u8>(palette[0] & 0x3Fu);
		const bool bg_on = (mask & 0x08u) != 0u;   ///< $2001 bit3: fondo habilitado.
		const bool left_clip = (mask & 0x02u) == 0u; ///< $2001 bit1: recorta 8 px izq.
		const int base_h = ctrl & 1;         ///< Nametable base horizontal ($2000 bit0).
		const int base_v = (ctrl >> 1) & 1;  ///< Nametable base vertical ($2000 bit1).

		for (int py = 0; py < kPpuHeight; ++py) {
			const int ly = line_scroll ? line_sy[py] : scroll_y;
			const int lx = line_scroll ? line_sx[py] : scroll_x;
			const int fy = py + ly;                 ///< 0..510 (9 bits, cruza nametable)
			const int fine_y = fy & 7;
			const int ty_abs = fy >> 3;             ///< Fila de tile absoluta (0..~62)
			// La nametable es de **30 filas** (240 px), no 32: el scroll vertical
			// envuelve ahí y cambia de nametable (a diferencia del horizontal, 32).
			const int cy = ty_abs % 30;             ///< Fila dentro de la nametable (0..29)
			for (int px = 0; px < kPpuWidth; ++px) {
				if (!bg_on || (left_clip && px < 8)) {
					const int idx = py * kPpuWidth + px;
					fb[idx] = universal;
					bg_opaque[idx] = 0u;
					continue;
				}
				const int fx = px + lx;
				const int fine_x = fx & 7;
				const int cx = (fx >> 3) & 0x3Fu;

				// Nametable efectiva = base XOR bit de cruce, y banco según mirroring.
				const int nt_h = (base_h + (cx >> 5)) & 1;   // horizontal: 32 columnas
				const int nt_v = (base_v + (ty_abs / 30)) & 1; // vertical: 30 filas
				const eng::u16 nt_base = static_cast<eng::u16>(nt_bank(nt_h, nt_v) * 0x400);
				const eng::u16 nt_off = static_cast<eng::u16>(nt_base + (cy & 31) * 32 + (cx & 31));
				const eng::u8 tile = vram[nt_off & 0x7FFu];
				const eng::u8 attr = attr_bits(nt_base, cx, cy);

				const eng::u16 pat = static_cast<eng::u16>(bg_base + tile * 16u + fine_y);
				const int bit = 7 - fine_x;
				eng::u8 color;
				eng::u8 value;
				if (tile_provider != nullptr) {
					// Ajuste por ROM: el proveedor decide el dibujo del tile.
					enhance::TileRow row;
					const bool ok = tile_provider->fetch_row(enhance::TileSpace::Bg, tile,
										 attr, fine_y, pat, row);
					const eng::u8 nb = tile_provider->bpp(enhance::TileSpace::Bg);
					color = 0u;
					if (ok) {
						for (eng::u8 b = 0; b < nb; ++b) {
							color = static_cast<eng::u8>(
								color | (((row.plane[b] >> bit) & 1u) << b));
						}
					}
					value = tile_provider->color(enhance::TileSpace::Bg, attr, color);
				} else {
					const eng::u8 p0 = chr_byte(pat);
					const eng::u8 p1 = chr_byte(static_cast<eng::u16>(pat + 8u));
					color = static_cast<eng::u8>(((p0 >> bit) & 1u) | (((p1 >> bit) & 1u) << 1u));
					value = (color == 0u)
							? universal
							: static_cast<eng::u8>(palette[(attr * 4 + color) & 0x1Fu] & 0x3Fu);
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
		sprite0_line = 0xFFFFu; ///< Se recalcula: sin sprites, no hay sprite-0 hit.
		const bool spr_on = (mask & 0x10u) != 0u;    ///< $2001 bit4: sprites habilitados.
		const bool spr_left = (mask & 0x04u) != 0u;  ///< $2001 bit2: sprites en 8 px izq.
		if (!spr_on) {
			return;
		}
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
				enhance::TileRow srow;
				bool have = false;
				eng::u8 p0 = 0;
				eng::u8 p1 = 0;
				if (tile_provider != nullptr) {
					have = tile_provider->fetch_row(enhance::TileSpace::Sprite, t,
									static_cast<eng::u8>(attr & 3u), rr, pat, srow);
				} else {
					p0 = chr_byte(pat);
					p1 = chr_byte(static_cast<eng::u16>(pat + 8u));
				}
				for (int col = 0; col < 8; ++col) {
					const int px = static_cast<int>(ox) + col;
					if (px < 0 || px >= kPpuWidth) {
						continue;
					}
					if (!spr_left && px < 8) {
						continue; // recorte de la columna izquierda
					}
					const int bit = flip_h ? col : (7 - col);
					eng::u8 color;
					if (tile_provider != nullptr) {
						const eng::u8 nb = tile_provider->bpp(enhance::TileSpace::Sprite);
						color = 0u;
						if (have) {
							for (eng::u8 b = 0; b < nb; ++b) {
								color = static_cast<eng::u8>(
									color | (((srow.plane[b] >> bit) & 1u) << b));
							}
						}
					} else {
						color = static_cast<eng::u8>(((p0 >> bit) & 1u) |
									     (((p1 >> bit) & 1u) << 1u));
					}
					if (color == 0u) {
						continue;
					}
					const int idx = y * kPpuWidth + px;
					if (i == 0 && bg_opaque[idx] != 0u && sprite0_line == 0xFFFFu) {
						// Guarda la primera línea/columna con hit; `clock_ppu`
						// pondrá el flag de `$2002` al alcanzar ese dot.
						sprite0_line = static_cast<eng::u16>(y);
						sprite0_dot = static_cast<eng::u16>(px);
					}
					const bool behind = (attr & 0x20u) != 0u;
					if (behind && bg_opaque[idx] != 0u) {
						continue;
					}
					fb[idx] = (tile_provider != nullptr)
							  ? tile_provider->color(enhance::TileSpace::Sprite,
										 static_cast<eng::u8>(attr & 3u), color)
							  : static_cast<eng::u8>(
								    palette[(0x10u + (attr & 3u) * 4u + color) & 0x1Fu] &
								    0x3Fu);
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
	/// Lee un byte de la pattern table: de CHR-ROM si `chr` está puesto, o de
	/// CHR-RAM si el cartucho la usa. \param off Offset en la CHR. \return El byte.
	eng::u8 chr_byte(eng::u16 off) const {
		if (chr != nullptr && chr_size != 0u) {
			return chr[off % chr_size];
		}
		if (chr_ram != nullptr) {
			return chr_ram[off & 0x1FFFu];
		}
		return 0u;
	}

	/// Attribute table: 2 bits de paleta por bloque 16×16 (4×4 tiles).
	/// \param nt_base Base de la nametable activa ($2000/$2400/$2800/$2C00).
	/// \param tx,ty   Tile (8×8) dentro de la nametable (0..31).
	/// \return Índice de paleta de fondo (0..3).
	/// Banco de nametable (0/1 de los 2 KB) según el **mirroring** del cartucho.
	/// \param nt_h Bit horizontal de nametable efectivo; \param nt_v Bit vertical.
	/// \return Banco CIRAM (0/1).
	[[nodiscard]] int nt_bank(int nt_h, int nt_v) const noexcept {
		if (nt_single >= 0) {
			return nt_single; // 1 pantalla (MMC1 modos 0/1): banco A/B constante.
		}
		return mirror_h ? nt_v : nt_h;
	}

	/// Dirección física (0..0x7FF) en los 2 KB de VRAM para una dirección de PPU
	/// `$2000-$3EFF`, aplicando el **mirroring** (CIRAM A10). El offset es A0-A9.
	/// \param addr Dirección de PPU.
	/// \return Índice dentro de `vram`.
	[[nodiscard]] eng::u16 vram_index(eng::u16 addr) const noexcept {
		const int nt_h = (addr >> 10) & 1;
		const int nt_v = (addr >> 11) & 1;
		return static_cast<eng::u16>(nt_bank(nt_h, nt_v) * 0x400 + (addr & 0x3FFu));
	}

	/// Índice (0..31) dentro de `palette` para una dirección de `$3F00-$3FFF`,
	/// aplicando el **espejo** de la paleta: `$3F10/$14/$18/$1C` son el mismo
	/// registro que `$3F00/$04/$08/$0C` (el color de fondo "universal"). Sin esto,
	/// las escrituras del juego a `$3F10` (paleta de sprites 0) no actualizaban el
	/// backdrop y el fondo quedaba en negro (bug del cielo de SMB).
	/// \param addr Dirección de PPU (la `v` fijada por `$2006`).
	/// \return Índice en `palette` en `[0,31]`.
	[[nodiscard]] static eng::u8 palette_index(eng::u16 addr) noexcept {
		eng::u8 idx = static_cast<eng::u8>(addr & 0x1Fu);
		if ((idx & 0x13u) == 0x10u) {
			idx = static_cast<eng::u8>(idx & ~0x10u);
		}
		return idx;
	}

	/// Si `addr` cae en el espacio de **nametables** `$2000-$3EFF` (incluido el
	/// espejo de `$3000-$3EFF` sobre `$2000-$2FFF`), devuelve su índice en `vram`.
	/// Para `$0000-$1FFF` (pattern tables) o paleta devuelve `-1`. Sin esto, las
	/// escrituras de `$2007` al espacio de pattern (p. ej. la "limpieza" genérica
	/// de VRAM de SMB, que en NROM es CHR-ROM y debe ignorarse) se **aliasaban**
	/// dentro de la VRAM de nametables y corrompían el fondo.
	/// \param addr Dirección de PPU (la `v` fijada por `$2006`).
	/// \return Índice en `vram` en `[0,0x7FF]`, o `-1` si no es nametable.
	[[nodiscard]] int nametable_index(eng::u16 addr) const noexcept {
		if (addr >= 0x2000u && addr < 0x3000u) {
			return static_cast<int>(vram_index(addr));
		}
		if (addr >= 0x3000u && addr < 0x3F00u) {
			return static_cast<int>(vram_index(static_cast<eng::u16>(addr - 0x1000u)));
		}
		return -1;
	}

	/// Atributo (paleta 0..3) del tile en la nametable `nt_base`, coordenadas
	/// **de tile globales** `cx`/`cy` (0..63; el banco ya lo fija `nt_base`).
	/// \param nt_base Base (banco) de la nametable.
	/// \param cx Coarse X (0..63). \param cy Coarse Y (0..63).
	/// \return Los 2 bits de atributo (0..3).
	eng::u8 attr_bits(eng::u16 nt_base, int cx, int cy) const {
		const int ax = (cx >> 2) & 7;
		const int ay = (cy >> 2) & 7;
		const eng::u8 byte = vram[(nt_base + 0x3C0 + ay * 8 + ax) & 0x7FFu];
		const int quad = ((cy >> 1) & 1) * 2 + ((cx >> 1) & 1);
		return static_cast<eng::u8>((byte >> (quad * 2)) & 0x03u);
	}
};

} // namespace n2a
