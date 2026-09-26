# runtime/platform/amiga — backend Amiga 500

Implementación de la interfaz [`Host`](../host.hpp) para el **Amiga 500** (OCS/ECS, 68000). Aquí se
mapea cada método del contrato a hardware nativo; el núcleo (`NesSystem`) no cambia.

> Estado: **especificación** (el backend SDL3 es el ejecutable hoy). La base de pantalla/Chip
> RAM/VBlank ya está descrita en [`../../../docs/RUNTIME_AMIGA.md`](../../../docs/RUNTIME_AMIGA.md).

## Mapeo del contrato `Host`

| `Host` | Amiga 500 |
|---|---|
| `init` | Reserva de Chip RAM, `BPLCON0=DPF+6 planos`, `DIWSTRT/STOP`, `DDFSTRT/STOP`, Copperlist inicial, VBlank (nivel 3) |
| `present(rgb)` | Conversión del framebuffer (índices NES) a **bitplanes** (Blitter y/o Copper para paleta por franjas); `BPLxPT` desde la Copperlist |
| `audio_write(samples)` | Volcado por bloques a **Paula** (1–4 canales) o al mixer del engine Amiga |
| `poll(in)` | Lectura de **joystick** (puerto 1/2, `JOYxDAT`) y **teclado** (`$BFEC01`) → `InputState` |
| `delay_ms`, `ticks_ms` | Espera a **VBlank** (50 PAL / 60 NTSC Hz) y contador de frames |
| `shutdown` | Parar DMA/interrupciones y liberar la Chip RAM |

## Notas

- El núcleo es **header-only freestanding** (sin STL): compila con `m68k-amiga-elf-g++`/`vbcc`.
- Prioridad: **Blitter** para tiles/bobs y **Copper** para scroll/splits/paleta, según
  [`../../../docs/PPU_AMIGA.md`](../../../docs/PPU_AMIGA.md) y
  [`../../../docs/COPPER.md`](../../../docs/COPPER.md).
- Para desarrollo/pruebas se puede arrancar con el **fallback** (PPU software + chunky→planar) y,
  después, activar los handlers **HLE**.
