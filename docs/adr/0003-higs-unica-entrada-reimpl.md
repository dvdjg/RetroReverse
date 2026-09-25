# ADR 0003 — La HIGS es la única entrada de la reimplementación

- **Estado**: aceptado
- **Fecha**: 2026

## Contexto

El objetivo es una reimplementación que **no se distinga** del original, pero **sin** depender del
hardware original (Z80/68000/PPU/Namco/Denise). Si la reimpl mira el asm o los registros, deja de
ser portable y deja de validar que hemos entendido el juego.

## Decisión

La reimplementación **solo** consume `spec/` (HIGS) y `assets/`. El código **no** puede referenciar
direcciones de memoria, registros de hardware ni el desensamblado. Las temporizaciones se expresan
en **ticks 50/60 Hz** (los ciclos originales son metadato). La validación es **diferencial** contra
el emulador.

## Consecuencias

- ✅ Port portable y limpio; el target (SDL3, PC) no conoce el hardware.
- ✅ Fuerza una spec **suficiente**; si falta algo, la validación diferencial lo detecta.
- ✅ Reproducir bugs visibles se decide en la spec, no copiando el asm.
- ⚠️ Más trabajo de inferencia/spec que un «port mirando el asm».
- ⚠️ Requiere disciplina (revisión): prohibido leer `extraction/disassembly/` al implementar.

## Alternativas consideradas

- **Port directo desde el desensamblado**: rápido pero no generaliza ni demuestra comprensión;
  descartado para el marco (puede usarse como referencia interna, no como fuente).
