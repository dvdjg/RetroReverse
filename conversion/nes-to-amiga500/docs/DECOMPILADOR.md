# Decompilador NES → port nativo Amiga (objetivo: Donkey Kong)

Cambio de objetivo: **no emular**, sino **portar**. El transpilador actual emula el 6502 (estado en
memoria, por instrucción); para un port nativo y *pixel perfect* hay que **elevar el 6502 a C de
alto nivel** y **reimplementar el hardware en el Amiga**. Este documento fija la arquitectura, el
contrato del HAL y el plan por etapas. Primer objetivo: **Donkey Kong** (PRG 16 KB, NROM, sin bancos,
sin código en RAM, sin `JMP (ind)` relevante: el caso más limpio).

## Por qué Donkey Kong primero

- NROM fijo, sin *mapper*, sin ventanas conmutables ni código copiado a RAM.
- Código y datos pequeños (~6 000 instrucciones): el CFG se completa al 100 % (ya medido).
- Pocas rutinas y estructura clara (init, bucle de juego, NMI, control de sprites).
- Ya existe `--native` que lo compila (regiones + locales), así que sirve de referencia/validación.

## Arquitectura del port (etapas)

1. **Captura (ya hecho).** Desensamblado recursivo + CFG + VSA + cobertura por telemetría
   (`--pc-trace`) + tablas estáticas. Sobre esto se construye todo.
2. **IR de efectos (en curso).** Convertir cada bloque a una lista de operaciones con **def/uso**
   sobre *lugares* (registros A/X/Y, flags, memoria, inmediato). Base del reconocedor estructural.
3. **Modelo de memoria y tipos.** Clasificar RAM (`$0000-$07FF`) en: variables escalares, arrays
   (`base,X`), punteros de 16 bits, *buffers* (OAM shadow), y separar el **hardware** (`$2000-$4017`).
   Recuperar tipos (`u8`/`u16`/arrays) por análisis de uso.
4. **Estructuración de control.** Reconocer bucles (aristas de retroceso), `if`/`else`, `while`,
   y **rutinas** (`JSR`/`RTS` → funciones con firma), a partir de las regiones/labels actuales.
5. **Emisión C de alto nivel.** Cada rutina → función C; variables con nombre; arrays con índice;
   sin estado de CPU explícito (A/X/Y como temporales, flags plegados a comparaciones/expresiones).
6. **HAL (hardware) → Amiga.** Los accesos de hardware se mapean a un **HAL** (no a un PPU emulado).
   El render se **reimplementa** con Blitter/Copper/bitplanes (ver `HAL` abajo).
7. **Timing por frame.** El NMI/VBlank del NES → **VBlank del Amiga** (Copper/IRQ). Sin ciclos.
8. **Validación *pixel perfect*.** El harness diferencial vs **mesen** (ya en el repo, 67/71 a 0.0 %)
   compara RAM y framebuffer: es la garantía automática de fidelidad durante todo el port.

## HAL (contrato del hardware en el Amiga)

El código decompilado **no** conoce la NES: llama a un HAL mínimo. Firmas propuestas (aún sin
implementar; el decompilado de la fase 5 las usa):

```c
/* $2000-$2007: PPU */
void hal_ppu_write(u16 reg, u8 v);   /* PPUCTRL, PPUMASK, OAMADDR, OAMDATA, SCROLL, PPUADDR, PPUDATA */
u8   hal_ppu_read(u16 reg);          /* PPUSTATUS ($2002): VBlank/sprite-0/overflow (sombra) */
/* $4014: OAM DMA (256 B de la page a OAM) */
void hal_oam_dma(const u8* page);
/* $4016/$4017: mando */
u8   hal_pad_read(int port);
/* $4000-$4017: APU */
void hal_apu_write(u16 reg, u8 v);
/* Evento de frame: avanza el "PPU" hasta el VBlank y devuelve el control */
void hal_wait_vblank(void);
/* Render de fin de frame a los bitplanes Amiga */
void hal_render(void);
```

Diseño del **renderer** (reimplementación, no emulación): mantener el estado observable del PPU que
el juego escribe (nametables, paleta `$3F00`, OAM, scroll, registro de máscara); en cada frame (o por
**Copper** en splits), dibujar tiles/atributos con el **Blitter** a bitplanes y sprites como *bobs*;
paleta → `COLORxx`. *Pixel perfect* si se modelan tiles + atributos + sprites + scroll como el PPU.

## Estructura del C emitido (fase 5, ejemplo)

```c
#include "nes_hal.h"
static const u8 PRG_ROM[16384] = { /* ... */ };
static u8 ram[0x800];           /* RAM interna (espejo de 2 KB) */
static u8 oam[0x100];           /* sombra de OAM */
static u8 frame = 0;            /* contadores del juego (nombrados tras análisis) */

static void sub_jugar(void);    /* una por rutina (JSR/región) */

static void sub_init(void) {
    /* ...init...; se escriben registros PPU vía hal_ppu_write */
    hal_ppu_write(0x2000, 0x90);
    hal_ppu_write(0x2001, 0x1e);
    /* bucle principal */
    for (;;) {
        hal_wait_vblank();       /* antes: LDA $2002; BPL */
        /* ...lógica de frame... */
        hal_render();
    }
}

int main(void) { hal_init(); sub_init(); return 0; }
```

## Plan por etapas (incremental y validado)

1. **Modelo de memoria + HAL + esqueleto C** — **HECHO (fase 1)**: `--decompile` emite C plano con
   `ram[]`/`PRG_ROM`/estado (`A/X/Y/SP/flags`) como variables, HAL (`hal_ppu_*`, `hal_oam_dma`,
   `hal_pad_read`) y **una función por región** con etiquetas/`goto`. **Verificado equivalente al
   intérprete en host** en las ROMs `mini`, `branch` (bucle + `JSR`/`RTS` + `ADC`) y `misc`
   (`ASL`/`ROR`/`LSR`, `INC`/`DEC`, `JMP (ind)`). El código sale ya semi-estructurado (bucles con
   `if (!Zf) goto`). Siguiente: estructuración a `while`/`for`, tipos y arrays, y HAL/renderer Amiga.
2. **Estructuración**: bucles/`if`/`while`, firmas de rutina, nombres de variables (por uso).
3. **Tipos y arrays**: `base,X` → arrays; punteros de 16 bits → `u16*`/índices; propagación de tipos.
4. **Renderer Amiga**: PPU→bitplanes con Blitter/Copper; validar framebuffer vs mesen.
5. **APU→Paula**, input, y ajuste de rendimiento (presupuesto: DK cabe holgado en A500).

## Criterio de éxito

- **DK corre en el port a 60 fps en A500** con framebuffer **idéntico a mesen** (0.0 % de divergencia)
  durante N frames con entrada simulada. Si eso se logra, se generaliza a otros NROM.

## Riesgos y límites

- Estructurar/ tipar es **investigación**: cobertura parcial; algunas rutinas quedarán "emulación
  local" (aceptable) mientras el conjunto sea nativo.
- *Pixel perfect* exige modelar el PPU con fidelidad (sprites por scanline, *clipping*, *sprite 0*).
- Juegos con *mapper*/código en RAM quedan fuera de la primera fase (DK no los usa).
