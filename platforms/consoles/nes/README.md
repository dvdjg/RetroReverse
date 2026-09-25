# NES (Nintendo Entertainment System / Famicom)

Plataforma de consola del marco `RetroReverse`. Objetivo: análisis y **reimplementación** de
juegos NES, apoyándonos en un **emulador NES propio** (cycle-approx/cycle-accurate) que sirva de
base de instrumentación y comparación.

> Estado: **abierta**. Documentación de hardware, plan de emulador y arnés de pruebas listos.
> Núcleo **CPU 6502 (oficiales + ilegales) validado con `nestest`** (8991/8991 líneas del log
> idénticas, `$02=$03=0`). PPU/APU/mappers pendientes.

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
