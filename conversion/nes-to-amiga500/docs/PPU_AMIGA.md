# PPU en Amiga — motor de tiles, scroll y color

Objetivo: imitar el fondo de la NES (tiles 8×8 a 2 bpp, nametables, attribute tables, scroll
flexible) con **Dual Playfield + Blitter + Copper**, minimizando ciclos de CPU.

Idea central: **no redibujar tile a tile cada frame**. Se cachean los patrones ya convertidos a
planar Amiga, se mantiene un buffer de scroll un poco mayor que la pantalla y solo se *blittean* las
columnas/filas que entran (dirty strips).

## Scroll: adaptación de XYUnlimited

Se adopta el enfoque clásico de scroll de la demo-scene/Amiga (familia **XYUnlimited** de Patrik
Steger/[megaburken](https://megaburken.net/~patrik/ScrollingTricks/)) adaptado a NES:

| Concepto del original | Adaptación NES |
|---|---|
| Bloques 16×16 | **tiles 8×8** |
| Bitmap un poco mayor | 272×256 (o 288×256) |
| Solo se *blittean* columnas/filas que entran | igual |
| Scroll por HW + punteros | `BPLxPT` + `BPLCON1` + Copper |
| *Wrap* del buffer | módulo con `buffer_origin_tx/ty` |
| Attribute/colores | pre-aplicado en horizontal + Copper en vertical |

> **XYUnlimited** mantiene un mapa circular y nunca reescribe lo que ya está en pantalla; usa
> suficiente margen de guarda. **XYLimited** usa menos memoria pero depende de bandas de guarda.
> Para NES se empieza con **XYUnlimited** (simplicidad) y se evalúa XYLimited solo en juegos con
> scroll muy acotado.

## Constantes y layout

```cpp
constexpr int TILE_W = 8, TILE_H = 8;
constexpr int VISIBLE_W = 256, VISIBLE_H = 240;
constexpr int TILES_X = VISIBLE_W / TILE_W;   // 32
constexpr int TILES_Y = VISIBLE_H / TILE_H;   // 30
constexpr int EXTRA_TILES_X = 2, EXTRA_TILES_Y = 2;   // margen de scroll
constexpr int BUFFER_TILES_X = TILES_X + EXTRA_TILES_X;   // 34
constexpr int BUFFER_TILES_Y = TILES_Y + EXTRA_TILES_Y;   // 32
constexpr int BUFFER_W = BUFFER_TILES_X * TILE_W;         // 272
constexpr int BUFFER_H = BUFFER_TILES_Y * TILE_H;         // 256
constexpr int BPL_COUNT = 3;                  // por playfield (DPF 3+3)
```

Chip RAM del bitmap: `BUFFER_W/8 * BUFFER_H * BPL_COUNT` por plano del par; para DPF 3+3 ≈ 52 KB
(ver [`RUNTIME_AMIGA.md`](RUNTIME_AMIGA.md) para el presupuesto total).

## Estructura de datos

```
PatternCacheBG[2][256][altura_tile]   // CHR convertida a planar (con y sin attribute)
Nametable[2][30][32]                  // índices de tile por nametable
Attribute[2][8][8]                    // 2 bits de paleta por bloque 16×16
ScrollX, ScrollY (grueso + fino)
CurrentBPLPointers[6]
dirty_columns[BUFFER_TILES_X], dirty_rows[BUFFER_TILES_Y]
```

## Conversión NES 2bpp → planar Amiga

Un tile NES = 16 bytes: bytes 0-7 = plano 0 (bit bajo), 8-15 = plano 1 (bit alto);
`pixel = (plane1 << 1) | plane0`.

**Estrategia A (simple)**: pre-aplicar el attribute generando índices de color correctos.

```cpp
void convert_nes_tile_with_attr(const uint8_t* nes_tile, uint8_t attr, uint8_t* out) {
    uint8_t palette_base = (attr & 0x03) << 2;   // 0,4,8,12 (índices 2 bits + attr)
    for (int y = 0; y < 8; ++y) {
        uint8_t p0 = nes_tile[y], p1 = nes_tile[y + 8];
        uint8_t o0 = 0, o1 = 0, o2 = 0;
        for (int x = 0; x < 8; ++x) {
            int bit = 7 - x;
            uint8_t color = (uint8_t)(((p1 >> bit) & 1) << 1 | ((p0 >> bit) & 1));
            if (color != 0) color += palette_base;   // color 0 = transparente
            if (color & 1) o0 |= (1 << bit);
            if (color & 2) o1 |= (1 << bit);
            if (color & 4) o2 |= (1 << bit);
        }
        out[y] = o0; out[y + 8] = o1; out[y + 16] = o2;   // planar separado
    }
}
```

**Estrategia B (potente)**: tile a 2 planos (índices 0-3) + **Copper** cambiando la paleta por
franjas verticales de attribute. Se usa B por defecto y A para el attribute **horizontal** (evita
demasiados `WAIT` por línea). Ver [`COPPER.md`](COPPER.md).

## Mapa de color (Dual Playfield)

| Capa Amiga | Uso | Colores | Notas |
|---|---|---|---|
| Playfield 1 | fondo (tiles) | 0-7 | color 0 transparente, como NES |
| Playfield 2 | status bar / segunda capa | 8-15 | scroll y prioridad independientes |
| Sprites HW | sprites NES | 16-31 | 4 paletas NES (color 16 transparente) |

Alternativa: **5 bitplanes** normales (32 colores) si un juego necesita más color y renuncia a las
ventajas de DPF. Por defecto DPF.

## Núcleo del motor (XYUnlimited adaptado)

```cpp
void TileEngine::set_scroll(int x, int y) {
    fine_x_ = x & 7; fine_y_ = y & 7;
    int ncx = x >> 3, ncy = y >> 3;
    int dx = ncx - coarse_x_, dy = ncy - coarse_y_;
    if (dx || dy) {
        if (dx > 0) for (int i = 0; i < dx; ++i)
            mark_column_dirty((buffer_origin_tx_ + TILES_X + i) % BUFFER_TILES_X);
        else if (dx < 0) for (int i = 0; i < -dx; ++i)
            mark_column_dirty((buffer_origin_tx_ - 1 - i + BUFFER_TILES_X) % BUFFER_TILES_X);
        if (dy > 0) for (int i = 0; i < dy; ++i)
            mark_row_dirty((buffer_origin_ty_ + TILES_Y + i) % BUFFER_TILES_Y);
        else if (dy < 0) for (int i = 0; i < -dy; ++i)
            mark_row_dirty((buffer_origin_ty_ - 1 - i + BUFFER_TILES_Y) % BUFFER_TILES_Y);
        buffer_origin_tx_ = (buffer_origin_tx_ + dx + BUFFER_TILES_X) % BUFFER_TILES_X;
        buffer_origin_ty_ = (buffer_origin_ty_ + dy + BUFFER_TILES_Y) % BUFFER_TILES_Y;
        coarse_x_ = ncx; coarse_y_ = ncy;
    }
}

void TileEngine::update() {
    if (full_redraw_) { /* primer frame: todos los tiles */ full_redraw_ = false; return; }
    for (int tx = 0; tx < BUFFER_TILES_X; ++tx)
        if (dirty_columns_[tx]) { blit_column(tx); dirty_columns_[tx] = false; }
    for (int ty = 0; ty < BUFFER_TILES_Y; ++ty)
        if (dirty_rows_[ty]) { blit_row(ty); dirty_rows_[ty] = false; }
}
```

`blit_tile` copia 8×8×BPL con el Blitter (`BLTCON0/1`, `BLTxPT`, `BLTxMOD`, `BLTxDAT`) desde el
patrón cacheado a la posición del bitmap. El modo de copia con máscara (*cookie-cut*) solo es
necesario si hay transparencia; para el fondo opaco basta copia simple. Si el attribute va
pre-aplicado, no hay trabajo extra por frame.

## Scroll por hardware

```cpp
int bpl_offset = fine_y_ * BYTES_PER_ROW + (fine_x_ / 8);      // ajuste de punteros
// BPLxPTH/PTL = bitmap + bpl_offset (+ offset por plano)
// BPLCON1     = (fine_x_ & 7) | ((fine_x_ & 7) << 4);         // scroll fino HW
// BPL1MOD/BPL2MOD = (BUFFER_W - VISIBLE_W) / 8;               // = 2 para 272
```

El scroll grueso es casi gratis (mover punteros); el fino lo hace `BPLCON1` sin tocar el bitmap.

## Enganche con el juego

`NESMemory::write` avisa al motor (también vía HLE, ver [`HLE.md`](HLE.md)):

```cpp
if (addr == 0x2005) { ppu_scroll_write(value); tiles.set_scroll(ppu.scroll_x, ppu.scroll_y); }
if (addr == 0x2007 && vram_addr >= 0x2000 && vram_addr < 0x3F00) {
    int off = vram_addr & 0x3FF;
    if (off < 0x3C0) tiles.mark_tile_dirty(off & 31, off >> 5);
    else             tiles.mark_attribute_dirty(off - 0x3C0);
}
```

## Estado

motor de tiles (F5) **pendiente**; esta ficha es el contrato de implementación. Alternativas de
buffer/formato de tile se decidirán midiendo con el Blitter.
