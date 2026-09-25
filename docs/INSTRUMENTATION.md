# INSTRUMENTACIÓN — contrato de emulación observable

Contrato que deben cumplir **todos** los emuladores instrumentados del marco, sea cual sea la
plataforma. Objetivo: ejecución **determinista** y **observable** para el bucle de IA
([`PIPELINE.md`](PIPELINE.md)). Detalle por plataforma en [`EMULATORS.md`](EMULATORS.md).

## API de control

La orquestación habla con un único interfaz (ver
[`../tools/orchestrator/include/emulator_control.hpp`](../tools/orchestrator/include/emulator_control.hpp)):

| Operación | Uso |
|---|---|
| `load_rom(path)` | Cargar ROM/imagen |
| `reset()` | Reset en frío |
| `step_frames(n)` / `step_cycles(n)` | Avance determinista |
| `save_state()` → bytes / `load_state(bytes)` | **Savestate en memoria** (O(1)) para ramificar |
| `set_input(InputState)` | Input **frame-exacto** (sin wall-clock) |
| `read_mem(addr,len)` / `write_mem(addr,bytes)` | RAM/VRAM/registros |
| `screenshot(path)` | Captura del framebuffer |
| `set_trace(TraceConfig)` | Activar trazas por rango |

## Trazas

- **Ejecución**: PC por **rangos** seleccionados (no trazar todo el juego; usar muestreo).
- **Acceso a memoria**: reads/writes por rango (VRAM, OAM/sprites, paletas, work RAM).
- **Registros de hardware**: writes a registros custom/I-O.
- **Framebuffer**: hash por frame (para la validación diferencial).

Cada traza se parametriza por `TraceConfig { kind, addr_start, addr_end, sample }`.

## Determinismo (requisito)

- **Savestates en memoria** + restauración O(1).
- **Input frame-exacto**; nada depende del reloj real.
- **Semillas fijas** para cualquier RNG del emulador.
- Toda observación se guarda como evidencia *(savestate + input + frame)*.

## Implementaciones

| Plataforma | Vía | Estado |
|---|---|---|
| **Amiga 500** | **WinUAE-DBG** + GDB (`:2345`) + **canal lateral** (`:2346`) | **HECHO** (`platforms/computers/amiga500/tools/`) |
| **Arcade/consola** | **libretro core** en un **frontend headless** propio | PENDIENTE (ver nodo Pac-Man) |

El interfaz `EmulatorControl` abstrae ambos: para Amiga, el adaptador envuelve la sesión
WinUAE/GDB/canal lateral; para libretro, envuelve el core.
