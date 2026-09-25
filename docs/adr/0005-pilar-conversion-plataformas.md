# ADR 0005 — Tercer pilar: conversión a plataformas destino

- **Estado**: aceptado
- **Fecha**: 2026

## Contexto

Hasta ahora el marco hace **emulación/análisis** (libretro, Ghidra, HIGS) y **reimplementación**
(C++23 + SDL3 en PC). El objetivo del usuario es **completar el círculo**: no solo entender y
reimplementar un juego, sino **convertirlo automáticamente a otra plataforma de destino** — empezando
por un **emulador/transpilador de NES para Amiga 500**.

Ese trabajo no es un juego suyo (no encaja en `platforms/.../<game_id>/`), es **transversal**: lee una
ROM de origen, genera código y necesita un runtime propio en la máquina destino. Tampoco encaja en
`tools/` (que son utilidades genéricas) ni en `PORTING.md` (que define cómo portar técnicas
recuperadas al engine Amiga).

## Decisión

Añadir un **tercer pilar** de primer nivel, `conversion/`, con **un nodo por par origen→destino**:

```
conversion/
  README.md                 índice del pilar y principios
  <origen>-to-<destino>/    p.ej. nes-to-amiga500/
```

Cada nodo contiene su `README.md`, `docs/`, `tools/` (conversor host), `runtime/` (código destino),
`examples/` y `generated/` (salidas regenerables). El primer nodo es
[`conversion/nes-to-amiga500/`](../../conversion/nes-to-amiga500/README.md).

Principios del pilar: la ROM de origen es la especificación, **HLE con fallback**, validación
diferencial contra un emulador de referencia, código propio (se portan ideas, no se copia código) y
solo ROMs propias no versionadas.

## Consecuencias

- ✅ Separa la conversión (transversal) de los expedientes por juego y del porting de técnicas.
- ✅ Extensible a futuros pares origen→destino sin tocar el núcleo del marco.
- ✅ Reutiliza la infraestructura existente (hardware_spec NES/Amiga, cores libretro, validación).
- ⚠️ Un pilar más que mantener; el roadmap del marco gana una fase (**P4**, ver
  [`../ROADMAP.md`](../ROADMAP.md)).
- ⚠️ Riesgo de ámbito: se mitiga con fases y criterios de cierre estrictos
  ([`conversion/nes-to-amiga500/docs/ROADMAP.md`](../../conversion/nes-to-amiga500/docs/ROADMAP.md)).

## Alternativas consideradas

- **Dentro de `platforms/consoles/nes/`**: rechazado; el transpilador no es específico de un juego y
  el runtime es Amiga, no NES.
- **Dentro de `tools/`**: rechazado; `tools/` son utilidades genéricas, y la conversión tiene su
  propio runtime y roadmap.
- **Como caso particular de la reimpl (HIGS + SDL3)**: rechazado; el destino es hardware real
  (Amiga), no PC, y el enfoque es emulación/transpilación, no spec agnóstica.
