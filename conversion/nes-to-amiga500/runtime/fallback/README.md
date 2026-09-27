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

- **PPU**: implementados fondo (nametables con **mirroring** y envoltura de 30 filas), sprites
  (flips, prioridad, 8/línea + overflow), **sprite-0 hit dot-exacto** (`sprite0_line`/`sprite0_dot`:
  el flag de `$2002` se activa al alcanzar la **columna** del primer píxel del hit y se limpia en
  la pre-render), scroll, VBlank/NMI y `$2000-$2007`, incluido el reparto correcto del espacio de
  direcciones de VRAM: `$0000-$1FFF` = pattern tables (CHR-ROM: escrituras ignoradas; lecturas de
  CHR), `$2000-$3EFF` = nametables (con espejo de `$3000-$3EFF`) y `$3F00-$3FFF` = paleta con
  **espejo** `$3F10→$3F00`, etc. El avance del PPU es por dot (`tick_dot`), pero el sprite-0 se
  resuelve **O(1)** por tramo (sin iterar) para no penalizar el ejecutor rápido.
  Pendiente: sincronismo **dot-exacto del 6502** (sub-instrucción; causa la deriva de estado, ver
  `docs/RISKS.md`), evaluación de sprites por línea exacta y conversión del framebuffer a bitplanes.
- **APU**: implementados pulse ×2 (con **envelope** y **sweep**, incl. el `+1` del pulse1 y el
  muteo fuera de rango), triangle, **noise con envolvente** y **DMC** (lee sus muestras de la PRG),
  con mezcla no lineal. Referencia auditiva: `tools/apu_dump.cpp` genera un WAV (sweep + envelopes).
  Pendiente: volcado real a Paula.
- **Validación diferencial**: comparación frame a frame del framebuffer y del audio contra `mesen`
  (ver [`../../docs/VALIDATION.md`](../../docs/VALIDATION.md)).

Diseño y flujo: [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md). Tests: `bash ../test/run.sh`.
