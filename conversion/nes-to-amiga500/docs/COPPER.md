# Copper — atributos, splits y multiplexado

Cada frame se construye una **Copperlist** que: coloca los bitplanes con el scroll correcto
(grueso + fino), cambia `COLORxx` según la attribute table y aplica los splits (status bar,
efectos). Se genera en **doble buffer** y se conmuta en el VBlank.

## Reglas de oro

- **Attribute vertical** → Copper (`WAIT` + `COLORxx`).
- **Attribute horizontal** → pre-aplicado en el tile (ver [`PPU_AMIGA.md`](PPU_AMIGA.md)).
- **Splits** → Copper (cambio de `BPLCON`, punteros, scroll, paleta).
- Solo se emite un `WAIT` **cuando cambia algo** (mínimo número de eventos).

## Estructura de datos

```cpp
struct SplitZone {
    int start_line, end_line;
    int scroll_x, scroll_y; uint8_t fine_x;
    bool use_different_palette;
    std::array<uint16_t, 16> palette;
};

struct PPUView {
    int scroll_x, scroll_y, fine_x, fine_y;
    std::array<uint8_t, 64> attributes;   // attribute table visible
    std::array<uint16_t, 16> bg_palette;  // 12-bit Amiga
    std::vector<SplitZone> splits;
};
```

## Generador

```cpp
size_t CopperGenerator::generate(const PPUView& ppu, uint16_t* out) {
    uint16_t* p = out;

    move(p, 0x100, 0x6600);                 // BPLCON0: DPF + 6 planos
    move(p, 0x104, 0x0024);                 // BPLCON2: prioridades PF2>PF1>sprites
    move(p, 0x108, modulo); move(p, 0x10A, modulo);   // BPL1MOD/BPL2MOD
    move(p, 0x102, (ppu.fine_x & 7) | ((ppu.fine_x & 7) << 4));   // BPLCON1

    // BPLxPTH/PTL: los calcula el TileEngine según scroll (grueso+fino)
    // for (i<6) { move(p, 0x0E0 + i*4, hi); move(p, 0x0E2 + i*4, lo); }

    // Franjas verticales de attribute (cada 16 px). La primera puede ser parcial.
    int y = 0;
    uint8_t last = 0xFF;
    while (y < 240) {
        int world_y = ppu.scroll_y + y;
        uint8_t attr = get_attr(ppu.attributes, 0, world_y >> 3);
        if (attr != last) { events.push_back({y, attr}); last = attr; }
        y += 16 - (world_y & 15);
    }
    // ... eventos de split ordenados por línea ...
    // Por cada evento: wait(p, FIRST_VISIBLE + line); apply_bg_palette(p, ppu.bg_palette, attr);

    *p++ = 0xFFFF; *p++ = 0xFFFE;           // fin
    return (size_t)(p - out);
}
```

Helpers:

```cpp
static void wait(uint16_t*& p, int v, int h = 0x01) {
    *p++ = (uint16_t)((v << 8) | (h & 0xFF)); *p++ = 0xFF00;
}
static void move(uint16_t*& p, uint16_t reg, uint16_t val) { *p++ = reg; *p++ = val; }

static uint8_t get_attr(const std::array<uint8_t,64>& a, int tx, int ty) {
    int ax = (tx >> 2) & 7, ay = (ty >> 2) & 7;
    uint8_t byte = a[ay * 8 + ax];
    int qx = (tx >> 1) & 1, qy = (ty >> 1) & 1;
    return (byte >> (qy * 4 + qx * 2)) & 3;
}
static void apply_bg_palette(uint16_t*& p, const std::array<uint16_t,16>& pal, uint8_t attr) {
    int base = attr * 4;
    move(p, 0x180, pal[0]);              // COLOR00
    move(p, 0x182, pal[base + 1]);       // COLOR01
    move(p, 0x184, pal[base + 2]);       // COLOR02
    move(p, 0x186, pal[base + 3]);       // COLOR03
}
```

## Registros usados

| Registro | Dir | Uso |
|---|---|---|
| `BPLCON0` | `$100` | DPF, nº planos (0x6600 = DPF + 6) |
| `BPLCON1` | `$102` | scroll fino horizontal (PF1/PF2) |
| `BPLCON2` | `$104` | prioridades PF1/PF2/sprites |
| `BPL1MOD/BPL2MOD` | `$108/$10A` | módulo del buffer (bytes a saltar por línea) |
| `BPLxPTH/PTL` | `$0E0+` | punteros de bitplanes |
| `COLORxx` | `$180+` | paleta (00-15 PF/sprites, 16-31 sprites) |
| `DIWSTRT/STOP`, `DDFSTRT/STOP` | `$08E/…` | ventana y fetch (ver runtime) |

## Doble buffer y uso

```cpp
uint16_t* dest = (copper_toggle == 0) ? copper_buf0 : copper_buf1;
size_t words = copper_gen.generate(view, dest);
// En el VBlank:
custom.cop1lc = (uint32_t)dest;   // (COPJMP1 si hiciera falta)
copper_toggle ^= 1;
```

El **multiplexado de sprites** también se emite en la Copperlist (ver
[`SPRITES_AMIGA.md`](SPRITES_AMIGA.md)); el generador de fondo y el de sprites escriben en el mismo
buffer de forma secuencial.

## Notas

- La primera línea visible (`FIRST_VISIBLE`, ~`0x2C`) y el offset X de sprites dependen de
  `DIWSTRT`/modo y se calibran una vez con un sprite de prueba.
- Los `WAIT` deben salir ordenados; el generador garantiza orden por línea.
- Limitar el número de `WAIT`; si un juego cambia mucho la paleta por línea, priorizar pre-aplicar
  el attribute (estrategia híbrida).
