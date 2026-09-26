# runtime — código de destino (host + Amiga 500)

Runtime que ejecuta el código transpilado y traduce el estado de la NES a operaciones nativas del
Amiga. Es la base de las fases F1/F3/F4 del [`ROADMAP`](../docs/ROADMAP.md).

## Núcleo del runtime

| Fichero | Contenido | Estado |
|---|---|---|
| [`include/nes_runtime.hpp`](include/nes_runtime.hpp) | `NESMemory` (RAM, PPU/APU/E/S, PRG-ROM) y `CPU` 6502 de métodos (registros, flags, pila, modos y familias de opcodes) + macro `N2A_ASSUME` | **F1 (base)** |
| [`include/nes_interpreter.hpp`](include/nes_interpreter.hpp) | Intérprete 6502 (oficiales + ilegales) con **conteo de ciclos** | **F1**: validado con `nestest` |
| [`include/nes_mapper.hpp`](include/nes_mapper.hpp) | Cartucho: NROM/UxROM/CNROM y MMC1 parcial (bancos PRG/CHR) | **F9** (en curso) |
| [`include/nes_hle.hpp`](include/nes_hle.hpp) | Clasificador HLE de escrituras PPU + **ratio** | **F8** (en curso) |
| [`include/nes_system.hpp`](include/nes_system.hpp) | Sistema NES (CPU+PPU+APU+mapper), `run_frame` y RGB | **F3/F9** (en curso) |
| [`tools/facts_from_run.cpp`](tools/facts_from_run.cpp) | Extractor de **hechos de valores** por telemetría (`--facts`) | herramienta host |
| [`tools/nes_frame.cpp`](tools/nes_frame.cpp) | Ejecuta una ROM y vuelca un frame PPM + hash | herramienta host |
| [`test/diff_mesen.sh`](test/diff_mesen.sh) | **Validación diferencial** contra `mesen` | informativa |
| [`fallback/nes_ppu.hpp`](fallback/nes_ppu.hpp) | PPU software: registros, VRAM, OAM, paleta, scroll, VBlank/NMI y render del fondo | **F3** (en curso) |
| [`fallback/nes_apu.hpp`](fallback/nes_apu.hpp) | APU software: registros `$4000-$4017`, frame counter y síntesis pulse/triangle/noise | **F7** (en curso) |

Todo es **header-only** sobre `eng/core`, sin STL, y compila igual en host y en `m68k`. El `.cpp`
generado incluye `nes_runtime.hpp` y enlaza la PRG con `NESMemory::prg`/`prg_size`.

## Plataformas de ejecución

El núcleo es **agnóstico** y corre sobre la interfaz `Host` ([`platform/host.hpp`](platform/host.hpp)):

- **SDL3** (PC y navegador): [`platform/sdl_host.hpp`](platform/sdl_host.hpp) +
  [`host/main.cpp`](host/main.cpp). Build PC con [`host/build-pc.ps1`](host/build-pc.ps1) (MinGW) o
  CMake; **navegador** con [`web/build_web.sh`](web/build_web.sh) (Emscripten, SDL3 como *port*).
  SDL3 está en `external/SDL3/` (**3.4.16**).
- **Amiga 500**: [`platform/amiga/README.md`](platform/amiga/README.md) (Copper/Blitter/Paula).

Detalle y contrato: [`platform/README.md`](platform/README.md).

### Tests

`bash test/run.sh` (WSL/Linux o MinGW): valida la CPU con `nestest` ($02=$03=0), el **conteo de
ciclos**, la PPU (fondo + **sprites** + sprite-0 hit + **scroll mid-frame** + registros), la APU
(pulse/triangle/noise/**DMC** + mezcla no lineal), el **sistema NES + HLE** (ratio ~97 %) y la
**telemetría** de valores; y ejecuta la **validación diferencial con `mesen`** (`diff_mesen.sh`,
informativa). Pendiente: afinar timing/paleta (F3) y volcado a Paula (F7); *banking* en el
transpilador (F9).

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
