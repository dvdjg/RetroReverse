# INSTRUMENTATION — Pac-Man (MAME, vertical slice P0)

Plan para instrumentar el emulador del nodo Pac-Man y cumplir el contrato
[`../../../../../../docs/INSTRUMENTATION.md`](../../../../../../docs/INSTRUMENTATION.md).

## Core

- **Opción recomendada**: **libretro `mame2003-plus`** (o `mame2010`) — MAME *year-stamped* ligero,
  con API libretro (`retro_run`, savestates, `retro_serialize`). **Fijar versión** por juego.
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

1. Clonar/compilar el core (con libRetroReversing) — ver `emulators/README.md`.
2. Implementar el adaptador `EmulatorControl` para el frontend libretro.
3. Grabar los escenarios y volcar trazas/savestates.
4. Alimentar el bucle de inferencia y **contrastar con [`RESEARCH.md`](RESEARCH.md)**.

## Pendiente

- **Compilar el core y el frontend headless** (requiere toolchain + red; no versionado).
- Verificar que el **savestate en memoria** es determinista en el core elegido.
