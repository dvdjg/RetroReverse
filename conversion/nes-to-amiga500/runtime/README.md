# runtime — código de destino (host + Amiga 500)

Runtime que ejecuta el código transpilado y traduce el estado de la NES a operaciones nativas del
Amiga. Es parte de **F3/F4** del [`ROADMAP`](../docs/ROADMAP.md).

## Capas

| Carpeta | Contenido | Doc |
|---|---|---|
| [`fallback/`](fallback/README.md) | PPU/APU software (camino lento, oráculo) | [`ARCHITECTURE.md`](../docs/ARCHITECTURE.md) |
| [`hle/`](hle/README.md) | handlers `hle_*` (scroll, OAM, VRAM, bankswitch) | [`HLE.md`](../docs/HLE.md) |
| [`amiga/`](amiga/README.md) | Copper, Blitter, sprites, Paula, VBlank, pantalla | [`RUNTIME_AMIGA.md`](../docs/RUNTIME_AMIGA.md) |

## Núcleo compartido (host y 68000)

- `cpu.hpp` — clase `CPU` 6502 (oficiales + ilegales), base de la F1. Reutiliza la validación
  `nestest` de [`../../../platforms/consoles/nes/reimplementation/`](../../../platforms/consoles/nes/reimplementation/).
- `nes_memory.*` — bus, espejos, `read()`/`write()` como **único punto de enganche** HLE/fallback.
- `ppu.*`, `apu.*`, `mapper.*`, `input.*`.
- `tile_engine.*`, `sprite_engine.*`, `copper_generator.*` (motores gráficos).

## Build

- **Host** (iteración rápida y validación): `g++ -std=c++23`.
- **Destino**: `m68k-amiga-elf-g++` o `vbcc`; ASM crítico con `vasm`/`vasm-elf`.
  Convenciones y punto fijo en [`../../../PORTING.md`](../../../PORTING.md).
