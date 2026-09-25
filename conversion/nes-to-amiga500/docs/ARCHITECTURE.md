# Arquitectura — HLE + fallback

El emulador/conversor es **de alto nivel (HLE)** con **fallback** interpretado. En lugar de
reproducir el PPU y el 6502 ciclo a ciclo, se interceptan las **intenciones** del juego (scroll,
DMA de OAM, escrituras a VRAM, bankswitch, esperas de sprite 0) y se traducen a operaciones nativas
del Amiga (Blitter, Copper, punteros de bitplanes, sprites hardware). Lo que no se reconoce cae al
**fallback**: PPU/APU software + código transpilado (mucho más rápido que un intérprete).

Filosofía del Amiga: **no pelear contra el hardware, usarlo**.

## La cadena transpilador → runtime

```
                       HOST (PC, C++23)                          DESTINO (Amiga 500, 68000)
  ┌────────────────────────────────────────────┐        ┌────────────────────────────────────┐
  │ Fase 1: Transpilador                       │        │ Runtime                            │
  │  ROM ─► iNES ─► disasm ─► CFG ─►           │  .cpp  │  código generado (basic blocks)    │
  │         basic blocks ─► codegen C++23      │ ─────► │  + NESMemory/CPU + PPU/APU fallback│
  │                                            │        │  + motores Amiga (tiles/spr/audio) │
  │ Fase 2: Reconocedor HLE                    │        │  + Copper/Blitter/Paula/VBlank     │
  │  patrones 6502 ─► llamadas hle_*()         │        │                                    │
  └────────────────────────────────────────────┘        └────────────────────────────────────┘
```

El transpilador vive en [`../tools/transpiler/`](../tools/transpiler/README.md); el runtime, en
[`../runtime/`](../runtime/README.md). Código generado: [`../generated/`](../generated/README.md).

## Capas

```
┌─────────────────────────────────────────────────────────────┐
│ Código 6502 transpilado (basic blocks, cpu.LDA_abs(0x2005)…) │
│  o fallback: intérprete de una instrucción si el bloque no   │
│  se pudo resolver (salto indirecto / automodificación)       │
└───────────────────────────┬─────────────────────────────────┘
                            │ read()/write() (único punto de enganche)
                            ▼
┌─────────────────────────────────────────────────────────────┐
│ Capa de interceptación (NESMemory)                          │
│  registros PPU $2000-$2007 · OAM $4014 · APU $4000-$4017 ·   │
│  mapper $4020-$FFFF · entrada $4016/$4017                    │
└───────────┬───────────────────────────────┬─────────────────┘
            ▼                               ▼
┌───────────────────────┐       ┌───────────────────────────────┐
│ HLE rápido            │       │ Fallback lento                │
│ tiles/scroll/atributos│       │ PPU software (framebuffer)     │
│ sprites HW + bobs     │       │ APU software (necesario igual) │
│ bankswitch            │       │ conversión framebuffer→planar  │
└───────────┬───────────┘       └───────────────┬───────────────┘
            └───────────────┬───────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│ Hardware Amiga: Copperlist · Blitter · Sprites · DPF · Paula │
└─────────────────────────────────────────────────────────────┘
```

## Catálogo HLE (intención → acción nativa)

| Intención NES | Acción Amiga | Beneficio |
|---|---|---|
| Scroll (`$2005`) | `BPLxPT` + `BPLCON1` (+ Copper para splits) | casi gratis |
| Actualizar nametable (`$2007`) | Blitter copia tile de la cache al buffer de scroll | muy rápido |
| Attribute table | Copper cambia `COLORxx` por franjas; horizontal pre-aplicado | evita re-render |
| OAM DMA (`$4014`) | lista de sprites HW + multiplex + bobs | hardware real |
| Cambio de pattern table | actualizar punteros/cache | casi nulo |
| Bankswitch de mapper | tablas de despacho por banco / parches | rápido |
| Sprite 0 hit / split | Copper `WAIT` + cambio de scroll/capa | preciso y barato |
| Status bar fijo | segunda playfield o zona Copper | separación limpia |
| Paleta | escribir `COLORxx` (+ Copper dinámico) | instantáneo |

Detalle de patrones y `hle_*` en [`HLE.md`](HLE.md).

## Contrato del código generado

Todo acceso del juego pasa por `CPU`/`NESMemory`; el runtime decide HLE o fallback **sin que el
código generado lo sepa**:

```cpp
// Estilo del código generado (fase 1)
static void bb_C000(CPU& cpu) {
L_C000:
    cpu.LDA_imm(0x23);        // $C000: LDA #$23
    cpu.STA_abs(0x2005);      // $C002: STA $2005  → interceptado (scroll)
    cpu.INX();                // $C005: INX
    if (!cpu.Z) goto L_C000;  // $C006: BNE $C000
    cpu.RTS();
}
```

`STA_abs(0x2005)` entra por `NESMemory::write`, que el reconocedor puede haber sustituido por
`hle_set_scroll(...)` (fase 2) o dejar como escritura que el PPU software interpreta (fallback).

## Interfaces clave

```cpp
// Único punto de enganche: el bus emulado
class NESMemory {
public:
    APU          apu;
    TileEngine   tiles;
    SpriteEngine sprites;
    Input        input;
    Mapper*      mapper;

    uint8_t read(uint16_t addr);
    void    write(uint16_t addr, uint8_t value);
};

// Estado que el motor gráfico necesita cada frame
struct PPUView {
    int scroll_x, scroll_y, fine_x, fine_y;
    std::array<uint8_t, 64> attributes;   // attribute table visible
    std::array<uint16_t, 16> bg_palette;  // ya en 12 bits Amiga
    std::vector<SplitZone> splits;        // status bar, etc.
};

// Registro de handlers HLE
using HleHandler = void(*)(NESMemory&, uint16_t addr, uint8_t value);
HleHandler hle_lookup(uint16_t addr, uint8_t value);
```

## Flujo por frame

```
1. Esperar VBlank del Amiga.
2. Activar la Copperlist generada en el frame anterior (doble buffer).
3. Ejecutar código NES (transpilado) hasta el NMI/fin de frame:
     - escrituras a $2000-$2007, $4014, $4000-$4017, mapper
     - el bus marca dirty: scroll / tiles / atributos / OAM / paleta
4. tiles.update()   → Blitter solo columnas/filas sucias (F5)
5. sprites.update() → OAM → HW vs bobs; sprites.draw_bobs()
6. apu.generate_samples() → buffer del mixer (F7)
7. Construir la nueva Copperlist (fondo + atributos + splits + sprites multiplexados)
8. Leer input y escribirlo en $4016/$4017 para el siguiente frame.
```

Orden en [`RUNTIME_AMIGA.md`](RUNTIME_AMIGA.md); detalle de motores en
[`PPU_AMIGA.md`](PPU_AMIGA.md), [`COPPER.md`](COPPER.md), [`SPRITES_AMIGA.md`](SPRITES_AMIGA.md),
[`AUDIO_AMIGA.md`](AUDIO_AMIGA.md).

## Sincronización HLE ↔ fallback

El estado de la PPU (VRAM, OAM, paletas, scroll, `PPUCTRL/PPUMASK`) es **único** y compartido. Un
handler HLE actúa sobre ese estado **y** sobre el hardware, y marca lo que ya no necesita el PPU de
software; si más tarde un patrón no se reconoce, el fallback lee el mismo estado y sigue desde ahí.
Regla: **el estado emulado nunca se duplica**; el hardware Amiga es una *vista* de ese estado.

## Presupuesto de frame (A500, 50 Hz)

| Recurso | Presupuesto | Nota |
|---|---|---|
| CPU 68000 | ~20 ms (≈ 140 000 ciclos) | el más ajustado; favorecer Copper/Blitter |
| Blitter | ~ usado para tiles/bobs | limitar palabras por frame |
| Chip RAM | ~ 512 KB totales | bitmap ≈ 52 KB (DPF 272×256×6) + copperlists + sprites + audio ≈ 75 KB |
| Copper | muchas instrucciones | WAIT por franja únicamente cuando cambia algo |

Ver límites en [`RISKS.md`](RISKS.md).
