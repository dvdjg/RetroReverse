# Emuladores y cores (fuentes + instrumentación)

Para el pipeline necesitamos **emuladores con código fuente** que podamos **instrumentar**
(trazas, control de input, savestates en memoria, captura). Preferimos **libretro cores** porque
comparten `libretro.h` y se integran con frontend headless.

## Matriz por plataforma

| Plataforma | Repo(s) | Instrumentación recomendada |
|---|---|---|
| **Arcade** (Pac-Man…) | [mamedev/mame](https://github.com/mamedev/mame), [libretro/mame](https://github.com/libretro/mame) | Driver oficial (`src/mame/...`), trazas en `cpu_execute`, memory maps, vídeo/sonido. Versiones **year-stamped** (`mame2003-plus`, `mame2010`) más ligeras para instrumentar. |
| **Amiga 500** | [tonioni/WinUAE](https://github.com/tonioni/WinUAE), [FrodeSolheim/fs-uae](https://github.com/FrodeSolheim/fs-uae) | Camino **más maduro** (ya usado en `Amiga-Reverse`): WinUAE-DBG + GDB (fork BartmanAbyss) + ghidra-amiga. FS-UAE es más fácil de instrumentar en Linux. |
| **NES** | [libretro/mesen](https://github.com/libretro/mesen), [libretro/nestopia](https://github.com/libretro/nestopia), [libretro/fceumm](https://github.com/libretro/fceumm) | Fácil de instrumentar (mappers, PPU, APU). Mesen tiene infraestructura de debug/trazado. |
| **Otros** | cores libretro (`Genesis-Plus-GX`, `Beetle PSX`, …) | Empezar solo con los que se necesiten. |

## Instrumentación compartida

- **[libRetroReversing](https://github.com/RetroReversing/libRetroReversing)**: logging de
  instrucciones y *memory reads*, **input recording/playback**, interfaz web de inspección.
  Se integra como submódulo del core.
- **Frontend**: [RetroArch](https://github.com/libretro/RetroArch) o un **frontend headless propio**
  mínimo (mejor para control programático).
- **[libretro-common](https://github.com/libretro/libretro-common)**: utilidades comunes.
- **libretro-super**: para construir muchos cores de golpe.

## Qué descargar (arranque)

```bash
BASE=~/retro-re
mkdir -p $BASE/{emulators,frontend,tools}

git clone --depth 1 https://github.com/mamedev/mame.git        $BASE/emulators/mame
git clone --depth 1 https://github.com/libretro/mame.git       $BASE/emulators/libretro-mame
git clone --depth 1 https://github.com/tonioni/WinUAE.git      $BASE/emulators/winuae
git clone --depth 1 https://github.com/FrodeSolheim/fs-uae.git $BASE/emulators/fs-uae
git clone --depth 1 https://github.com/libretro/RetroArch.git  $BASE/frontend/retroarch
git clone --depth 1 https://github.com/libretro/libretro-super.git $BASE/frontend/libretro-super
git clone https://github.com/RetroReversing/libRetroReversing.git $BASE/tools/libRetroReversing
git clone https://github.com/libretro/libretro-common.git      $BASE/tools/libretro-common
```

## Flujo de instrumentación

1. Compilar la versión **vanilla** del core/frontend.
2. Crear un **fork instrumentado** (`*-instrumented/`) con:
   - macros de traza (compilables fuera): instrucciones, memoria, registros hardware;
   - hooks en `retro_run` (por frame) y en las rutinas de CPU/memoria;
   - savestates en memoria + restauración O(1);
   - input recording/playback.
3. Exponer una **API de control** (C/C++ o IPC) al orquestador: `load`, `step_frame`,
   `save/load_state`, `set_input`, `read_mem`, `read_vram`, `screenshot`.

> En Amiga, el stack maduro es **WinUAE-DBG + GDB + canal lateral**, ya automatizado en
> `Amiga-Reverse/tools/` (ver [`MIGRATION_AMIGA_REVERSE.md`](MIGRATION_AMIGA_REVERSE.md)).

## Riesgos

- **Versiones year-stamped** de MAME: comportamiento distinto según versión; fijar la versión por
  juego y documentarla.
- **No-determinismo**: fuentes de aleatoriedad no emuladas rompen la reproducibilidad.
- **Coste de instrumentar** cores modernos complejos (MAME actual es enorme): preferir cores
  antiguos/específicos para el primer *vertical slice*.
