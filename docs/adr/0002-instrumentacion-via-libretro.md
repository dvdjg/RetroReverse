# ADR 0002 — Instrumentación vía libretro (cores + forks)

- **Estado**: aceptado
- **Fecha**: 2026

## Contexto

El pipeline necesita emuladores **headless**, con **control de input**, **savestates en memoria**,
**trazas** y **captura**, en varias plataformas. Instrumentar cada emulador por separado es costoso
y poco reutilizable.

## Decisión

Usar la **libretro API** (`libretro.h`) como interfaz de instrumentación, sobre **cores con código
fuente** (MAME, mesen/nestopia, FS-UAE/WinUAE, …). Mantener **forks instrumentados** por core
(`*-instrumented/`) y un **frontend headless** propio (o RetroArch para pruebas). Aprovechar
`libRetroReversing` para logging/input/savestates.

Para **Amiga**, mantener el stack maduro ya probado (WinUAE-DBG + GDB + canal lateral), expuesto
tras la **misma API de control** que los cores libretro.

## Consecuencias

- ✅ Un solo contrato de instrumentación (`load/step/save/load/set_input/read_mem/screenshot`).
- ✅ Reutilización de logging/input de libRetroReversing.
- ✅ Linux-friendly (FS-UAE) además de Windows (WinUAE-DBG).
- ⚠️ Algunos cores son enormes (MAME actual) → preferir versiones *year-stamped* para el slice.
- ⚠️ Distintas versiones de core cambian comportamiento → **fijar versión por juego**.

## Alternativas consideradas

- **Instrumentar cada emulador a medida**: potente pero no reutilizable; descartado.
- **Solo MAME**: no cubre bien consolas/Amiga; descartado como base única.
