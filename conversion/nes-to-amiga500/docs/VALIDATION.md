# Validación — determinismo y comparación diferencial

Regla del marco: la conversión se valida **comparando** contra el original, no "a ojo". Ver
[`../../../docs/INSTRUMENTATION.md`](../../../docs/INSTRUMENTATION.md) y
[`../../../docs/PIPELINE.md`](../../../docs/PIPELINE.md).

## Niveles de validación

| Nivel | Qué compara | Herramienta |
|---|---|---|
| **1. CPU** | traza de PC + estado final (A/X/Y/SP/flags) | `nestest` + intérprete de referencia |
| **2. Transpilador** | ROM mínima transpilada == intérprete | harness host (F2) |
| **3. PPU/APU host** | framebuffer (hash por frame) + audio | core `mesen` (orquestador) |
| **4. HLE vs fallback** | mismo frame por ambos caminos | conmutador de handlers (F8) |
| **5. A500 real/emulado** | frame en WinUAE vs fallback host | captura + `ppm_diff` |

## Determinismo

Para que las comparaciones sean válidas:
- **input frame-exacto** (`$4016/$4017` fijados por frame);
- **estado inicial** reproducible (reset + RAM/VRAM/OAM conocidos);
- **sin aleatoriedad** dependiente de tiempo real.

## Framebuffer

Formato neutro intermedio (p. ej. `PPM`/chunky 256×240) generado por:
- el **fallback software** en host (oráculo independiente), y
- la **captura** del A500 (WinUAE) o del core `mesen`.

Comparación por **hash por frame** y por **diff de píxeles** (`tools/python/ppm_diff.py`, ya
existente en el marco).

## Audio

- RMS y comparación espectral (FFT básica) por ventanas de frame contra `mesen`.
- Criterio inicial: reconocible y sin *underruns*; no se exige igualdad muestra a muestra.

## Escenarios (vertical slice)

1. **ROM mínima** generada por nosotros (no copyright): arranque, escritura de paleta, un scroll.
2. **Homebrew propio** con NROM y scroll 8-way.
3. Juegos por mapper (F9) con ROMs propias, solo para el hito de compatibilidad.

## Criterios de cierre por fase

- **F2**: traza de PC + estado final idénticos al intérprete para la ROM mínima.
- **F3**: hash de framebuffer igual a `mesen` durante N frames del escenario 1; RMS de audio dentro
  de tolerancia.
- **F8**: ratio de escrituras PPU por HLE ≥80 % y **diff HLE vs fallback = 0** en los escenarios.
- **F4/F5/F6**: captura WinUAE comparada contra el fallback host (diff acotado y documentado).

## Evidencia y trazabilidad

Cada validación guarda: ROM usada (ruta + `sha1`), comando, build, frames comparados y resultado.
Los binarios/ROMs no se versionan; sí el script y el informe.
