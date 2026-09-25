# INSTRUMENTATION — Pac-Man (MAME, vertical slice P0)

Plan para instrumentar el emulador del nodo Pac-Man y cumplir el contrato
[`../../../../../../docs/INSTRUMENTATION.md`](../../../../../../docs/INSTRUMENTATION.md).

## Core

- **Core**: **libretro `mame2003-plus`**, compilado en `external/libretro-mame2003-plus/`
  (`mame2003_plus_libretro.so`) con `scripts/build-libretro-core.sh` y cargado por el adaptador
  libretro del orquestador (`tools/orchestrator`). Versión fijada por el propio checkout.
- Alternativa: MAME standalone + su API de debug, o un fork propio con hooks.
- **No se versiona** el core (ver `emulators/README.md`).

## Mapa a explotar

De [`../rom/layout.json`](../rom/layout.json):

| Región | Dirección | Uso en el pipeline |
|---|---|---|
| Programa | `0x0000-0x3fff` | Cobertura de ejecución (rangos), anotar funciones |
| `videoram` | `0x4000-0x43ff` | Tilemap: diffs por frame |
| `colorram` | `0x4400-0x47ff` | Colores: diffs |
| work RAM | `0x4c00-0x4fef` | Variables de juego (posición, estado) |
| `spriteram` | `0x4ff0-0x4fff` | Sprites (imagen/flip/color) |
| `spriteram2` | `0x5060-0x506f` | Coordenadas de entidades |
| IN0/IN1/DSW | `0x5000`/`0x5040`/`0x5080` | Lecturas de input/dips |

## Input

Acción lógica (4 direcciones + coin/start) mapeada al `InputState` del orquestador.

## Escenarios (para el bucle de inferencia)

1. **Idle** (attract mode): observar bucle principal y RNG de demostración.
2. **Mover** en cada dirección 1 tile; medir tiempo por tile (velocidad base).
3. **Comer un dot** y **un energizer**; medir pausas (1/3 frames) y cambio a Frightened.
4. **Salida de la casa**: medir dot counters (Pinky al instante, Inky ~30, Clyde ~60).
5. **Persecución**: entrar en Chase y observar targets (verificar 4-tiles de Pinky, vector de Inky,
   distancia de Clyde).
6. **Túnel**: comprobar la ralentización y el uso de `0x4800-0x4bff`.

## Trazas y salidas

Todo a `extraction/` (evidencia, regenerable; ignorada por git):

```
extraction/
  traces/       # cobertura (PC por rangos), accesos a VRAM/spriteram, writes de I/O
  savestates/   # estados en puntos clave (inicio de nivel, Frightened, casa)
  screenshots/  # framebuffer por frame (hash + PNG)
  memory_dumps/ # snapshots RAM/VRAM por frame
```

## Pasos

1. ~~Clonar/compilar el core~~ **HECHO**: `scripts/build-libretro-core.sh libretro-mame2003-plus`
   (o `scripts/build-cores.sh` para todos).
2. ~~Implementar el adaptador `EmulatorControl` para el frontend libretro~~ **HECHO**
   (`tools/orchestrator`, adaptador libretro + CLI `vertical_slice`).
3. ~~Colocar `pacman.zip` y ejecutar el slice~~ **HECHO** (`scripts/pacman-slice.sh`): 600 frames,
   escenario `start`, determinismo OK; salida en [`../extraction/`](../extraction/).
4. Alimentar el bucle de inferencia y **contrastar con [`RESEARCH.md`](RESEARCH.md)**.

## Pendiente

- ~~**Memoria de MAME**: `mame2003-plus` no expone `RETRO_MEMORY_SYSTEM_RAM`~~ **HECHO**: parche en
  `mame2003.c` que vuelca el espacio Z80 (64 KB) cada frame vía `cpu_readmem16`; `memory_dumps/`
  ya contiene VRAM (`0x4000`), colorram y workram.
- **Orientación**: el core emite `288x224` (horizontal); Pac-Man es vertical y RetroArch aplica
  `SET_ROTATION`. El adaptador aún no rota; las capturas actuales van sin rotar.
- **Regenerar la extracción** tras el parche de memoria: `bash scripts/pacman-slice.sh`.
