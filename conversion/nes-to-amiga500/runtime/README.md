# runtime — código de destino (host + Amiga 500)

Runtime que ejecuta el código transpilado y traduce el estado de la NES a operaciones nativas del
Amiga. Es la base de las fases F1/F3/F4 del [`ROADMAP`](../docs/ROADMAP.md).

## Núcleo del runtime

| Fichero | Contenido | Estado |
|---|---|---|
| [`include/nes_runtime.hpp`](include/nes_runtime.hpp) | `NESMemory` (RAM, PPU/APU/E/S, PRG-ROM) y `CPU` 6502 de métodos (registros, flags, pila, modos y familias de opcodes) + macro `N2A_ASSUME` | **F1 (base)** |
| [`include/nes_interpreter.hpp`](include/nes_interpreter.hpp) | Intérprete 6502 (oficiales + ilegales) con **conteo de ciclos** | **F1**: validado con `nestest` |
| [`tools/facts_from_run.cpp`](tools/facts_from_run.cpp) | Extractor de **hechos de valores** por telemetría (`--facts`) | herramienta host |
| [`fallback/nes_ppu.hpp`](fallback/nes_ppu.hpp) | PPU software: registros, VRAM, OAM, paleta, scroll, VBlank/NMI y render del fondo | **F3** (en curso) |
| [`fallback/nes_apu.hpp`](fallback/nes_apu.hpp) | APU software: registros `$4000-$4017`, frame counter y síntesis pulse/triangle/noise | **F7** (en curso) |

Todo es **header-only** sobre `eng/core`, sin STL, y compila igual en host y en `m68k`. El `.cpp`
generado incluye `nes_runtime.hpp` y enlaza la PRG con `NESMemory::prg`/`prg_size`.

### Tests

`bash test/run.sh` (WSL/Linux o MinGW): valida la CPU con `nestest` ($02=$03=0), el **conteo de
ciclos** (`cycles_test`), la PPU (fondo + **sprites** + sprite-0 hit + registros), la APU
(pulse/triangle/noise/**DMC** + mezcla no lineal) y la **telemetría** de valores. Pendiente de F3:
scroll por línea y **validación diferencial contra `mesen`**; de F7: volcado a Paula.

## Capas de destino (a partir de F3)

| Carpeta | Contenido | Doc |
|---|---|---|
| [`fallback/`](fallback/README.md) | PPU/APU software (camino lento, oráculo) | [`ARCHITECTURE.md`](../docs/ARCHITECTURE.md) |
| [`hle/`](hle/README.md) | handlers `hle_*` (scroll, OAM, VRAM, bankswitch) | [`HLE.md`](../docs/HLE.md) |
| [`amiga/`](amiga/README.md) | Copper, Blitter, sprites, Paula, VBlank, pantalla | [`RUNTIME_AMIGA.md`](../docs/RUNTIME_AMIGA.md) |

## Build

- **Host** (iteración rápida y validación): `g++ -std=gnu++23`.
- **Destino**: `m68k-amiga-elf-g++` o `vbcc`; ASM crítico con `vasm`/`vasm-elf`.
  Convenciones y punto fijo en [`../../../PORTING.md`](../../../PORTING.md).
