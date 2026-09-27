# Plan de test del port Amiga (validar contra el oráculo)

Objetivo: cuando llegue el backend Amiga (Copper/Blitter/Paula + codegen), validarlo **contra el
oráculo del host** sin rehacer infraestructura. Todo lo que se compara ya lo produce el oráculo hoy.

## Qué produce el oráculo (ya disponible)

| Artefacto | Herramienta | Uso | Estado |
|---|---|---|---|
| **Hash de framebuffer** por frame | `tools/nes_frame.cpp` (`hash=...`) | huella determinista del render | HECHO |
| **PPM** del frame | `nes_frame <rom> <out.ppm> <frames>` | comparación estructural | HECHO |
| **Volcado de RAM** por frame | `tools/frame_probe.cpp` (`frame_probe.ram`) | divergencia de estado del juego | HECHO |
| **Traza de escrituras `$2007`** | `frame_probe` (`frame_probe.wt`) | cómo se carga la VRAM | HECHO |
| **Timeline de eventos** (sprites/paleta/scroll) | `frame_probe` + `ppu.sprite0_line/dot`, `line_sx/sy` | constantes *baked* y Copper list | PARCIAL |
| **RAM de `mesen`** | `vertical_slice --dump-ram` | referencia externa | HECHO |
| **Diff estructural vs mesen** | `test/diff_mesen.sh` | calibración del renderer | HECHO |
| **Ratio HLE** | `tools/bench_hle.cpp` | puerta de calidad del mapeo hardware | HECHO |

## Niveles de aceptación (de más débil a más fuerte)

1. **Determinismo**: mismo estado+input → mismo frame (§ reproducibilidad del orquestador). Debe
   pasar en el Amiga (misma ROM, mismos frames).
2. **Hash de framebuffer**: `hash(Amiga, frame N)` == `hash(oráculo, frame N)` para N de una lista
   por juego. Nivel 1 de fidelidad (imagen idéntica bit a bit).
3. **Diff estructural** (luminancia, tolerante a la paleta Amiga): si el hash exacto no cuadra por la
   paleta OCS, exigir `estructura(lum) ≤ 2%` (como `mesen` con BF/SMB). Comparación reutilizando la
   métrica de `diff_mesen.sh`.
4. **RAM del juego**: `frame_probe.ram` (oráculo) vs el volcado de RAM del Amiga por frame. Aceptar
   la misma divergencia que codegen↔intérprete (**2–13 bytes** con framebuffer idéntico; ver
   `RISKS.md`), nunca peor.
5. **Timeline de eventos**: la línea/dot del sprite-0 y los splits que el oráculo *bakea* deben
   coincidir con los `WAIT` del Copper efectivos (medibles con un contador de raster en el Amiga).
6. **Ratio HLE**: el mapeo hardware debe cubrir ≥ 80% de las escrituras de PPU (puerta ya en
   `test/run.sh`).

## Reutilización (lo que NO hay que rehacer)

- La **métrica de diff** y el **volcado de RAM** son herramientas genéricas: solo hay que sustituir
  la "captura" (hoy `nes_frame`/`mesen`) por la del Amiga (p. ej. volcar sus bitplanes a PPM).
- Las **constantes baked** (líneas de sprite-0, splits) salen del oráculo dot-exacto; el Amiga las
  **consume**, no las recalcula.
- El **reconocedor** (`raster_idioms`) y las **primitivas HLE** (`nes_hle_raster.hpp`) fijan el
  contrato; el backend Amiga solo tiene que implementarlas.

## Matriz por juego

Mantener una tabla publicada (como la de `mesen`) con, por juego: mapper, `frames` de referencia,
`hash`/`estructura`, bytes de RAM que difieren y ratio HLE. Sirve de **criterio de compatibilidad**
y detecta regresiones al tocar el oráculo o el codegen.

## Cómo encaja con el trabajo actual (PC)

- El oráculo ya es **dot-exacto** en PPU (sprite-0 por columna, VBlank, reloj de bus por acceso).
- El **sub-ciclo del 6502** (interprete dirigido por ciclo) está parcialmente hecho; lo que quede no
  bloquea el port (el Amiga resuelve el timing por hardware).
- La ABI del plugin (`n2a_plugin.h`) y los modos `nes_engine` quedan **congelados** para que el
  backend Amiga se enchufe sin romper lo existente.
