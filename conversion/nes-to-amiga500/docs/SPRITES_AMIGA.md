# Sprites en Amiga — conversión, multiplexado y bobs

La NES tiene **64 sprites**, **máx. 8 por scanline**, 8×8 u 8×16, con flip H/V, prioridad
(delante/detrás del fondo) y 4 paletas. El Amiga OCS tiene **8 sprites hardware** de 16 px de ancho,
multiplexables con el Copper. Estrategia: mapear los NES a los 8 HW + multiplexado; el resto, a
**bobs** (Blitter). El límite de 8/línea de la NES ayuda a que esto encaje.

## Formato de sprite Amiga

```
Para cada línea:  Word0 = bitplane 0 (16 bits),  Word1 = bitplane 1 (16 bits)
Al final:         Word 0x0000, 0x0000  (terminador)
```

2 planos → 3 colores + transparente. Los sprites NES son de 8 px: se colocan en los bits 8-15
(izquierda) del word de 16.

Registros por canal `n`:

```
SPRnPOS ($140+n*4):  VSTART | HSTART[8:1]
SPRnCTL ($142+n*4):  VSTOP  | attach | HSTART[0]
SPRnPTH/PTL ($120+n*4): puntero a datos
```

## Conversión NES → sprite Amiga (con flips)

```cpp
struct AmigaSpriteData { std::array<uint16_t, 16*2 + 2> data{}; uint8_t height = 8; };

AmigaSpriteData convert(const uint8_t* chr, uint8_t tile, uint8_t attr, bool is_8x16) {
    AmigaSpriteData out;
    const bool flip_h = (attr & 0x40) != 0, flip_v = (attr & 0x80) != 0;
    if (!is_8x16) { out.height = 8; convert_8x8(chr, tile, flip_h, flip_v, out.data.data()); }
    else {
        out.height = 16;
        uint8_t top = tile & 0xFE, bot = top + 1;
        convert_8x8(chr, top, flip_h, flip_v, out.data.data());
        convert_8x8(chr, bot, flip_h, flip_v, out.data.data() + 16);
        if (flip_v) for (int i = 0; i < 8; ++i) {
            std::swap(out.data[i*2+0], out.data[(15-i)*2+0]);
            std::swap(out.data[i*2+1], out.data[(15-i)*2+1]);
        }
    }
    int term = out.height * 2;
    out.data[term] = 0; out.data[term+1] = 0;
    return out;
}

// 8×8 NES → 8 líneas de sprite Amiga (tile en bits 8-15)
void convert_8x8(const uint8_t* chr, uint8_t tile, bool fh, bool fv, uint16_t* dst) {
    const uint8_t* src = chr + tile * 16;
    for (int y = 0; y < 8; ++y) {
        uint8_t p0 = src[fv ? 7 - y : y];
        uint8_t p1 = src[(fv ? 7 - y : y) + 8];
        if (fh) { p0 = REVERSE_BITS[p0]; p1 = REVERSE_BITS[p1]; }
        dst[y*2+0] = (uint16_t)p0 << 8;
        dst[y*2+1] = (uint16_t)p1 << 8;
    }
}
```

`REVERSE_BITS` es una tabla `constexpr` de 256 entradas (flip horizontal sin bucle de bits).

## Asignación: hardware vs bob

Se respeta el límite real de la NES (8 por línea) y el de Amiga (8 sprites HW simultáneos):

```
1. Recolectar sprites activos (Y < 0xF0) y ordenarlos por Y.
2. Contar sprites por línea (line_count[y]).
3. Para cada sprite:
     - si su línea ya tiene 8 NES → descartar (fiel al hardware);
     - si hay canal Amiga libre en esa Y → sprite HW (conversión cacheada);
     - si no, pero cabe en el multiplexado → sprite HW reutilizado por Copper;
     - si no cabe → bob (Blitter);
     - si tampoco → descartar.
```

```cpp
std::array<int, 8> next_free_line{}; next_free_line.fill(0);
for (auto& e : entries) {
    if (overflow(e)) continue;                       // límite NES
    int slot = -1;
    for (int s = 0; s < 8; ++s) if (e.y >= next_free_line[s]) { slot = s; break; }
    if (slot >= 0) { assign_hw(slot, e); next_free_line[slot] = e.y + e.height + 1; }
    else if (num_bobs_ < MAX_BOBS) assign_bob(e);
}
```

## Multiplexado por Copper

```cpp
// Estado de los 8 canales; al liberarse uno, se reprograma con el siguiente sprite.
while (next_sprite < count) {
    int ch = canal_libre_antes(next_free_line);          // el que se libera antes
    const auto* next = order[next_sprite];
    if (next->y < next_free_line[ch]) { ++next_sprite; continue; }  // (ya debería ser bob)
    wait(p, first_line + next_free_line[ch]);
    emit_sprite_setup(p, ch, *next, first_line);         // PTH/PTL + POS/CTL
    next_free_line[ch] = next->y + next->height;
    ++next_sprite;
}

void emit_sprite_setup(uint16_t*& p, int ch, const HwSpriteSlot& s, int first_line) {
    uint32_t a = (uint32_t)s.data;
    move(p, 0x120 + ch*4, (uint16_t)(a >> 16));   // SPRxPTH
    move(p, 0x122 + ch*4, (uint16_t)(a & 0xFFFF));// SPRxPTL
    int hstart = s.x + 0x40;                      // calibrar con DIWSTRT
    int vstart = first_line + s.y, vstop = vstart + s.height;
    move(p, 0x140 + ch*4, (uint16_t)((vstart << 8) | ((hstart >> 1) & 0xFF)));  // SPRxPOS
    move(p, 0x142 + ch*4, (uint16_t)((vstop << 8) | (hstart & 1)));             // SPRxCTL
}
```

El terminator del sprite es obligatorio tras cada gráfico. El offset `+0x40` se calibra una vez.

## Prioridad NES ↔ Amiga

| Prioridad NES | Amiga |
|---|---|
| sprite detrás de BG | `BPLCON2` (prioridad PF) / bob dibujado antes del PF2 |
| sprite delante de BG | sprite HW normal / bob tras PF1 |

Orden de dibujado de atrás a delante: PF1 → bobs *behind* → sprites HW *behind* → PF2 → sprites HW
normales → bobs normales.

## Enganche con OAM

```cpp
if (addr == 0x2003) oam_addr_ = value;
if (addr == 0x2004) { oam_[oam_addr_++] = value; oam_dirty_ = true; }
if (addr == 0x4014) {                                   // OAM DMA
    uint16_t src = value << 8;
    for (int i = 0; i < 256; ++i) oam_[i] = read(src + i);
    sprites.set_oam(oam_);
}
```

En VBlank: `sprites.update(scroll_x, scroll_y)` decide HW/bob; `build_copper_sprite_list` multiplexa;
`draw_bobs()` los pinta con Blitter.

## Caché

Cachear los sprites convertidos por `(tile, attr, 8x16)` evita reconvertir cada frame; los más usados
sin flip caben en una tabla pequeña en Chip RAM. El modo 8×16 se activa desde `PPUCTRL` bit 5.
