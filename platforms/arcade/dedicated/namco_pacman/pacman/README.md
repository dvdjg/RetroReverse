# Pac-Man — nodo de juego (vertical slice P0)

Primer **nodo de juego** del marco [`RetroReverse`](../../../../../README.md), sobre hardware
**Namco Pac-Man** (arcade dedicado). Objetivo: recorrer el pipeline completo (research → emulación
instrumentada → análisis → HIGS → reimpl SDL3 → validación diferencial) con un juego muy
documentado que sirva de **test de calidad** del sistema.

## Estado

| Fase | Estado |
|---|---|
| P0.2 Documentación primero (`docs/RESEARCH.md`) | **en curso** (borrador) |
| P0.3 MAME instrumentado headless | pendiente |
| P0.4 Análisis estático (Capstone + Ghidra) | pendiente |
| P0.5 Bucle IA (FSMs, mazos, timings) | pendiente |
| P0.6 HIGS + assets | pendiente |
| P0.7 Reimpl SDL3 + validación diferencial | pendiente |

## Estructura del nodo

```
pacman/
├── rom/
│   ├── raw/            # ROMs propias (NO versionadas)
│   └── layout.json     # mapa de memoria / I/O (extraído del driver MAME)
├── extraction/         # (a generar) trazas, disassembly, savestates, dumps
├── assets/             # (a generar) tiles, sprites, paletas, audio
├── spec/               # (a generar) HIGS del juego
├── reimplementation/   # (a generar) C++23 + SDL3 (solo lee spec/ + assets/)
└── docs/
    └── RESEARCH.md     # ground truth de la comunidad (Regla 0)
```

## Documentación

- [`docs/RESEARCH.md`](docs/RESEARCH.md) — fuentes, ground truth y lagunas (empezar por aquí).
- [`rom/layout.json`](rom/layout.json) — mapa de memoria e I/O, `source`: driver MAME.
- Marco: [`docs/ROADMAP.md`](../../../../../docs/ROADMAP.md) (fase P0),
  [`docs/PIPELINE.md`](../../../../../docs/PIPELINE.md),
  [`docs/HIGS.md`](../../../../../docs/HIGS.md).

## Reglas

1. **Solo ROMs propias**; no versionar ROMs/assets originales ([`docs/LEGAL.md`](../../../../../docs/LEGAL.md)).
2. La reimplementación consume **solo** `spec/` + `assets/` (ADR 0003).
3. Toda inferencia lleva **confianza** y **evidencia** (savestate + input + frame).
