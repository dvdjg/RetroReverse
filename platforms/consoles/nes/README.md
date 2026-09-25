# NES (Nintendo Entertainment System / Famicom)

Plataforma de consola del marco `RetroReverse`. Objetivo: análisis y **reimplementación** de
juegos NES, apoyándonos en un **emulador NES propio** (cycle-approx/cycle-accurate) que sirva de
base de instrumentación y comparación.

> **APARCADO** como emulador NES clásico (decisión del usuario, 2026). Lo hecho (spec de hardware,
> CPU 6502 validada con `nestest`, cobertura de ejecución, docs) queda como **base congelada**.
>
> **Retomado como emulador no clásico**: el nodo
> [`conversion/nes-to-amiga500/`](../../../conversion/nes-to-amiga500/README.md) reutiliza esta base
> para **transpilar 6502 → C++23** y ejecutarlo en un **Amiga 500** (HLE + fallback). No continuar
> H3/H4/H5 del emulador clásico salvo lo que necesite la conversión.

## Documentación

| Documento | Contenido |
|---|---|
| [`docs/HARDWARE.md`](docs/HARDWARE.md) | 2A03 (CPU), 2C02 (PPU), APU, mapa de memoria, timing |
| [`docs/CPU_6502.md`](docs/CPU_6502.md) | ISA 6502, modos de direccionamiento, **opcodes ilegales** |
| [`docs/MAPPERS.md`](docs/MAPPERS.md) | iNES y mappers 0/1/2/3/4 |
| [`docs/REIMPLEMENTATION_ARCH.md`](docs/REIMPLEMENTATION_ARCH.md) | Comparativa de emuladores y arquitectura elegida |
| [`docs/TESTING.md`](docs/TESTING.md) | `nestest` y test ROMs; criterios de cierre |
| [`hardware_spec/README.md`](hardware_spec/README.md) | Resumen de registros y regiones |

Referencias externas (NESDev Wiki, guía de emulación, test ROMs, Mesen2/FCEUX/olcNES/Nesium):
[`../../../docs/REFERENCES.md`](../../../docs/REFERENCES.md) §NES.

## Estructura

```
nes/
├── docs/                 documentación propia de la plataforma
├── hardware_spec/        registros/regiones (resumen)
├── rom/raw/              ROMs propias (NO versionadas)
├── roms/ (raíz)          recepción (ver ../../../../roms/README.md)
├── reimplementation/     emulador NES propio (C++23) + tests
└── games/                nodos de juego (a crear)
```

## Cómo validar (emulador)

```powershell
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/platforms/consoles/nes/reimplementation && make test"
```

`make test` ejecuta el arnés `nestest` (CPU 6502, oficiales + ilegales) contra el ROM de
referencia en `external/references/repos/nes-test-roms/other/`.

## Reglas

1. Solo ROMs propias; no versionar ROMs ([`docs/LEGAL.md`](../../../docs/LEGAL.md)).
2. La reimplementación consume **solo** `spec/` + `assets/` (ADR 0003).
3. Toda inferencia lleva **confianza** y **evidencia**.
