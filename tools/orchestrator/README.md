# orchestrator — capa de control de emulación

Orquestador del pipeline: carga ROM → ejecuta emulador instrumentado → genera trazas/savestates →
alimenta el análisis → produce la HIGS. Aquí vive el **contrato** con los emuladores.

## Contrato

- Interfaz C++: [`include/emulator_control.hpp`](include/emulator_control.hpp)
  (`EmulatorControl`, `InputState`, `TraceConfig`).
- Semántica y requisitos (determinismo, trazas, evidencia):
  [`../../docs/INSTRUMENTATION.md`](../../docs/INSTRUMENTATION.md).

## Implementaciones

| Adaptador | Plataforma | Vía | Estado |
|---|---|---|---|
| WinUAE-DBG | Amiga 500 | GDB + canal lateral | **existe** en `platforms/computers/amiga500/tools/` (por adaptar a la interfaz) |
| libretro | Arcade/consola | core + frontend headless | **pendiente** (nodo Pac-Man) |

## Estado

- **Contrato**: definido (este directorio).
- **Adaptadores**: pendientes. El de Amiga se envolverá sobre `winuae-session.mjs`/`side.mjs`
  (Node) o se reimplementará en C++ reutilizando el protocolo GDB.

## Nota

El orquestador es **multi-plataforma**; las particularidades (mapa de memoria, cores, hooks) viven
en cada plataforma/nodo (`platforms/.../hardware_spec`, `docs/INSTRUMENTATION.md` del juego).
