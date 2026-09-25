# orchestrator — capa de control de emulación

Orquestador del pipeline: carga ROM → ejecuta emulador instrumentado → genera trazas/savestates →
alimenta el análisis → produce la HIGS. Aquí vive el **contrato** con los emuladores.

## Contrato

- Interfaz C++: [`include/emulator_control.hpp`](include/emulator_control.hpp)
  (`EmulatorControl`, `InputState`, `TraceConfig`).
- Semántica y requisitos: [`../../docs/INSTRUMENTATION.md`](../../docs/INSTRUMENTATION.md).

## Implementaciones

| Adaptador | Plataforma | Vía | Estado |
|---|---|---|---|
| WinUAE-DBG | Amiga 500 | GDB + canal lateral | existe en `platforms/computers/amiga500/tools/` (por adaptar a la interfaz) |
| **libretro** | Arcade / consola / Amiga | core + frontend headless | **HECHO** (`libretro_adapter`) |

## Adaptador libretro

- [`include/libretro_api.hpp`](include/libretro_api.hpp) — subset mínimo de la API libretro.
- [`include/libretro_adapter.hpp`](include/libretro_adapter.hpp) + [`src/libretro_adapter.cpp`](src/libretro_adapter.cpp):
  - carga un core (`.dll`/`.so`), implementa los callbacks (`environment`, `video`, `audio`, `input`),
  - expone `EmulatorControl`: `load_rom`, `reset`, `step_frames` (un `retro_run` por frame),
    `save_state`/`load_state` (`retro_serialize`), `read_mem`/`write_mem` (`RETRO_MEMORY_SYSTEM_RAM`),
    `set_input`, `screenshot` (PPM del último frame).
- **Limitación**: `set_trace` no es genérico en libretro; requiere API de debug del core
  (p. ej. mesen). Se guarda la config y queda como extensión.

## Test

```sh
make test     # construye host_test + test_core.so y ejecuta el smoke test (WSL/Linux)
```

`test/test_core.cpp` es un **core mínimo** (no un emulador) que valida el adaptador: avanza RAM por
frame, refleja el input, serializa estado y emite un frame. Salida esperada: `TODOS LOS TESTS OK`.

Para cores reales, compilar los de `external/` (RetroArch + `libretro-*`) — paso pesado, pendiente.

## Cores disponibles (`external/`)

Arcade: `libretro-mame`, `libretro-mame2003-plus` · NES: `libretro-mesen`, `libretro-nestopia`,
`libretro-fceumm` · Megadrive: `libretro-genesis-plus-gx` · Amiga: `libretro-uae` (basado en WinUAE),
`libretro-puae` · Soporte: `RetroArch`, `libretro-super`, `libretro-common`, `libretro-database`,
`libRetroReversing`.
