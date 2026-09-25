# hardware_spec — Amiga 500 (OCS/ECS)

Referencia de hardware del **Amiga 500** (chipset **OCS/ECS**, Kickstart 1.3). Base para
instrumentar el emulador (WinUAE-DBG) y para leer registros custom al analizar software del demo.
Datos de la documentación clásica (HRM) y del `README` de bitmaps.

## CPU y relojes

| | Valor |
|---|---|
| CPU | **Motorola 68000** (big-endian, 16/32-bit) |
| Reloj CPU | **7.09379 MHz** (PAL) · **7.15909 MHz** (NTSC) |
| Color clock | 3.546895 MHz (PAL) · 3.579545 MHz (NTSC) |
| Línea / frame (PAL) | 15.625 kHz · **50 Hz**, 312 líneas |
| Línea / frame (NTSC) | 15.734 kHz · ~60 Hz, 262 líneas |

## Mapa de memoria (A500 OCS)

| Rango | Qué |
|---|---|
| `0x000000-0x07FFFF` | **Chip RAM** (512 KB base; el Agnus direcciona aquí DMA/Copper/Blitter) |
| `0x080000-0x0BFFFF` | Espejo/mirror de chip RAM (1 MB) o libre según configuración |
| `0xC00000-0xC7FFFF` | **Slow RAM** (512 KB "bogus", bus de CPU sin DMA) |
| `0xBFD000` | **CIA-B** (puertos paralelo/serial, timers del teclado) |
| `0xBFE001` | **CIA-A** (teclado, ratón, timers, LEDs, disk) |
| `0xDFF000-0xDFF1FF` | **Registros custom** (Agnus/Denise/Paula) |
| `0xFC0000-0xFFFFFF` | **Kickstart ROM** (256 KB, respetando el mirror) |

Direcciones de `ExceptionVectors`: `0x000000-0x0003FF` (tabla de vectores 68000).

## Chips custom

- **Agnus**: DMA, **Blitter**, **Copper**, arbitraje de bus, generación de direcciones de vídeo.
- **Denise**: generación de vídeo (planos de bits, sprites, paleta, HAM/EHB), prioridades.
- **Paula**: **audio** (4 canales 8-bit), disco, interrupciones, puertos serie.

## Registros custom (grupos clave en `$DFFxxx`)

| Grupo | Registros | Uso |
|---|---|---|
| **DMA / IRQ** | `DMACON`, `INTENA`, `INTREQ`, `ADKCON` | habilitar blitter/copper/bitplanes/sprites/audio, interrupciones |
| **Copper** | `COP1LC`, `COP2LC`, `COPJMP1/2`, `COPINS` | listas de cobre |
| **Bitplanes** | `BPLCON0/1/2`, `BPL1MOD`, `BPL2MOD`, `BPLxPTH/PTL` (x=1..6) | nº de planos, HAM, DPF, scroll, punteros |
| **Ventana** | `DIWSTRT`, `DIWSTOP`, `DDFSTRT`, `DDFSTOP` | ventana de display y de datos |
| **Color** | `COLOR00..COLOR31` | paleta 12-bit (0RGB) |
| **Blitter** | `BLTCON0/1`, `BLTxPT`, `BLTxMOD`, `BLTSIZE`, `BLTBDAT`, `BLTCDAT` | copias/rellenos/máscaras |
| **Sprites** | `SPRxPT`, `SPRxPOS`, `SPRxCTL`, `SPRxDATA`, `SPRxDATB` (x=0..7) | sprites hardware |
| **Posición** | `VPOSR`, `VHPOSR` | V/H actual (para sync) |

## Vídeo (OCS/ECS)

- **Bitplanes** (1–6 en OCS): intercalado planar (palabra a palabra); color = índice de bits por
  plano. **HAM6** (6 planos + modificación) y **EHB** (6 planos con mitad extra de brillo).
- **Resoluciones**: lores 320×256, hires 640×256 (PAL); overscan ajustable por `DDF/DIW`.
- **Copper**: programa de 3 ciclos (MOVE/WAIT/SKIP) que reconfigura registros a mitad de frame →
  permite **splits** (cambiar planos/colores/punteros por zonas).
- **Sprites**: 8 sprites hardware (o 4 de 15 colores); prioridad y colisión por hardware.

## Audio (Paula)

- **4 canales** independientes, **8-bit** PCM, con periodo (`AUDxPER`), volumen (`AUDxVOL`),
  puntero y longitud (`AUDxLCH/LCL/LEN`), y modulación (`AUDxDAT`).
- En «Arte» los módulos son **MOD** (`mod.*`) reproducidos por sofware sobre estos canales.

## Timing relevante para el pipeline

- **50 Hz PAL**: el bucle de frame espera **VBlank**; documentar los timings en **ticks 50 Hz** y,
  si aplica, en ciclos (7.09 MHz).
- **Blitter/Copper**: documentar esperas `BLTDONE` (`$DFF002` bit 14) y el uso de `VPOSR`.

## Herramientas de la plataforma

Ver [`../tools/README.md`](../tools/README.md) (WinUAE-DBG + GDB + canal lateral, DMS, planar/copper,
`AMIGA_BITMAPS.md`).

## Referencias

- *Amiga Hardware Reference Manual* (HRM) — A500/OCS.
- `../tools/python/AMIGA_BITMAPS.md` — reconstrucción de bitmaps OCS/ECS.
- Ejemplo de uso: expediente [`../demos/arte/`](../demos/arte/README.md).
