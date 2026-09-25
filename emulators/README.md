# emulators — fuentes y forks instrumentados

Aquí se clonan los **emuladores/core con código fuente** que el pipeline instrumenta (trazas,
control de input, savestates en memoria, captura). Los **binarios/forks NO se versionan** (son
pesados); este README documenta qué va y cómo instrumentarlo.

## Qué va aquí (por plataforma)

| Plataforma | Repo | Uso |
|---|---|---|
| Arcade | `mamedev/mame` (+ `libretro/mame`) | Driver oficial (p. ej. `src/mame/pacman/`), trazas de CPU/memoria/vídeo |
| Amiga 500 | `tonioni/WinUAE` / `FrodeSolheim/fs-uae` | Camino maduro (WinUAE-DBG + GDB + canal lateral) |
| NES | `libretro/mesen`, `libretro/nestopia`, `libretro/fceumm` | Mappers, PPU, APU |
| Frontend | `libretro/RetroArch` o frontend headless propio | Control programático |

Instrumentación compartida: [`libRetroReversing`](https://github.com/RetroReversing/libRetroReversing)
(logging de instrucciones/memoria, input recording/playback).

Detalle y comandos de descarga: [`../docs/EMULATORS.md`](../docs/EMULATORS.md).

## Instrumentación (resumen)

1. Compilar la versión **vanilla** del core/frontend.
2. Crear un **fork instrumentado** (`*-instrumented/`) con:
   - trazas (instrucciones / memoria / registros de hardware) seleccionables por rango;
   - hooks en `retro_run` (por frame) y en las rutinas de CPU/memoria;
   - **savestates en memoria** (restauración O(1)) + **input recording/playback**;
   - **captura** de framebuffer por frame.
3. Exponer una **API de control** al orquestador: `load`, `step_frame`, `save/load_state`,
   `set_input`, `read_mem`, `read_vram`, `screenshot`.

## Primer vertical slice

**Pac-Man + MAME (versión ligera tipo `mame2003-plus`/`mame2010`)** — ver
`../platforms/arcade/dedicated/namco_pacman/pacman/` y [`../docs/ROADMAP.md`](../docs/ROADMAP.md) P0.

> No se versionan ROMs ni emuladores. Solo ROMs propias ([`../docs/LEGAL.md`](../docs/LEGAL.md)).
