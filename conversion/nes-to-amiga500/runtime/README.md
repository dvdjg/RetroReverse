# runtime — código de destino (host + Amiga 500)

Runtime que ejecuta el código transpilado y traduce el estado de la NES a operaciones nativas del
Amiga. Es la base de las fases F1/F3/F4 del [`ROADMAP`](../docs/ROADMAP.md).

## Núcleo compartido (host y 68000)

| Fichero | Contenido | Estado |
|---|---|---|
| [`include/nes_runtime.hpp`](include/nes_runtime.hpp) | `NESMemory` (RAM + lectura de PRG) y `CPU` 6502 (registros, flags, pila, modos y familias de opcodes) | **F1 (base)**: lo incluye el `.cpp` generado |

`nes_runtime.hpp` **no es autónomo**: el fichero generado define antes `kPrgSize` y `PRG_ROM`, y
luego lo incluye (contrato documentado en el propio header). Está escrito sobre `eng/core`, sin STL,
y compila igual en host y en `m68k`.

Pendiente de F1: sustituir la semántica aproximada por la CPU validada con `nestest`
([`../../../platforms/consoles/nes/reimplementation/`](../../../platforms/consoles/nes/reimplementation/))
y añadir conteo de ciclos. Después llegan PPU/APU/mappers (F3/F7/F9).

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
