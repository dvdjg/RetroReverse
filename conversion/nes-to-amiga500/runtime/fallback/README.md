# runtime/fallback — PPU/APU software

Camino **lento pero completo**: emulación software de la PPU (render, attributes, sprites, scroll,
sprite-0 hit, VBlank/NMI, `$2000-$2007`, OAM, DMA) y del APU (5 canales + frame counter). Es el
**oráculo** del nodo y garantiza que, aunque un patrón no se reconozca, el juego funcione.

## Ficheros

| Fichero | Contenido | Estado |
|---|---|---|
| [`nes_ppu.hpp`](nes_ppu.hpp) | PPU 2C02: registros `$2000-$2007`, VRAM (2 KB), OAM (256 B), paleta (32 B), scroll, VBlank/NMI, **fondo** y **sprites** (flips, prioridad, 8/línea, sprite-0 hit) a un framebuffer de índices NES (256×240) | F3 (en curso) |
| [`test/ppu_test.cpp`](test/ppu_test.cpp) | Test sintético: fondo, sprite delante/detrás, overflow, sprite-0 hit, VBlank/NMI y `$2006`/`$2007` | OK |
| [`nes_apu.hpp`](nes_apu.hpp) | APU 2A03: registros `$4000-$4017`, frame counter y síntesis pulse/triangle/noise/**DMC** con **mezcla no lineal** (tablas NESdev) | F7 (en curso) |
| [`test/apu_test.cpp`](test/apu_test.cpp) | Test de humo: activa pulse/ruido/DMC, genera muestras y comprueba `$4015`, salida no nula y rango | OK |

## Alcance y pendientes

- **PPU**: falta sprites (64, 8/línea), sprite-0 hit, scroll fino por línea (mid-frame) y la
  conversión del framebuffer a bitplanes Amiga.
- **APU**: falta DMC, mezcla no lineal exacta y el volcado real a Paula.
- **Validación diferencial**: comparación frame a frame del framebuffer y del audio contra `mesen`
  (ver [`../../docs/VALIDATION.md`](../../docs/VALIDATION.md)).

Diseño y flujo: [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md). Tests: `bash ../test/run.sh`.
