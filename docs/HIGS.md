# HIGS — Hardware-Independent Game Spec

Esquema estructurado (JSON/YAML) que describe **el juego**, no la máquina. Es la **única** entrada
de la reimplementación: si un dato no está en la HIGS, la reimpl no debe saberlo. Esto garantiza
que el port es fiel a las **mecánicas y timings**, no al hardware original.

## Principios

- **Agnóstico de hardware**: nada de Z80/68000/PPU/Namco/Denise. Unidades neutras: *ticks*,
  *píxeles*, *entidades*, *tiles*, *eventos*.
- **Trazable**: cada regla referencia su **evidencia** (savestate + input + frame) y su
  **confianza** (`alta`/`media`/`baja`), como en `LECCIONES_APRENDIDAS.md`.
- **Exacto en tiempo**: temporizaciones en **ticks a 50/60 Hz** (y ciclos originales solo como
  metadato de referencia).
- **Versionable**: JSON con `schema_version`.

## Esquema (resumen)

```
spec/
  game.json               metadatos: plataforma origen, fps, resolución, esquema
  mechanics.md            reglas de juego en prosa (legible)
  timing_rules.yaml       fps, tick, latencias, interrupciones, secuencias temporizadas
  map_definitions.json    tilemaps, tilesets, colisiones por tile, spawns, portales
  state_machines/         FSM por entidad (JSON)
  hitboxes.json           cajas de colisión por estado/frame
  scoring.json            puntuación, vidas, progresión de nivel
  assets.json             índice de assets + transformaciones (paletas, animaciones)
  evidence/               referencias a savestates/inputs/frames
```

## Ejemplo: máquina de estados de un NPC (Pac-Man, fantasma)

```json
{
  "schema_version": "0.1",
  "entity": "ghost.blinky",
  "tick_hz": 60,
  "states": [
    { "id": "scatter", "exit": [ { "when": "timer>=scatter_time", "to": "chase" } ] },
    { "id": "chase",   "exit": [ { "when": "timer>=chase_time",   "to": "scatter" },
                                 { "when": "frightened",          "to": "frightened" } ] },
    { "id": "frightened", "exit": [ { "when": "timer>=fright_time", "to": "chase" } ] }
  ],
  "targeting": {
    "chase":    { "rule": "pacman_tile" },
    "scatter":  { "rule": "fixed_corner", "corner": [25, 0] }
  },
  "movement": { "speed_tiles_per_tick": { "level_1": 0.80, "level_5": 0.90, "tunnel": 0.40 } },
  "confidence": "alta",
  "evidence": [ "savestates/ghost_scatter_00.state", "inputs/scenario_move_left.bin" ]
}
```

## Timings

```yaml
# timing_rules.yaml
schema_version: "0.1"
fps: 60                 # objetivo del original (racional exacto si aplica)
tick_hz: 60             # unidad lógica de la HIGS
frame_budget_ms: 16.667
sequences:
  - id: level_intro
    events:
      - { at_tick: 0,   action: show_text, text: "READY!" }
      - { at_tick: 120, action: spawn_entities }
      - { at_tick: 180, action: enable_input }
notes: "Original: Z80 @ 3.072 MHz, VBlank 60.6 Hz (ver evidence/)."
```

## Mapas

```json
{
  "schema_version": "0.1",
  "map": "maze_1",
  "tileset": "assets/tiles_maze.png",
  "tile_size": [8, 8],
  "grid": ["####################", "#o........#........o#", "..."],
  "legend": { "#": "wall", ".": "pellet", "o": "power_pellet", " ": "empty", "-": "ghost_door" },
  "spawns": { "pacman": [13.5, 26], "ghosts": { "blinky": [13.5, 11] } },
  "portals": [ { "tile": [0, 17], "to": [27, 17] } ]
}
```

## Reglas

1. La HIGS **no** referencia direcciones de memoria ni registros del original (eso vive en
   `extraction/`, como evidencia).
2. Los **assets** se referencian por ruta en `assets/`, nunca se embeben.
3. Cada regla lleva **confianza** y **evidencia** (savestate/input/frame).
4. La reimplementación **falla** si intenta leer algo fuera de `spec/` y `assets/` (by design).
5. El esquema evoluciona con `schema_version`; los cambios incompatibles crean versión nueva.

## Validación del esquema

- `spec/` debe validar contra un **JSON Schema** (`spec/game.schema.json`) en CI.
- Un `HIGS lint` comprueba: referencias a assets existentes, evidencia presente, unidades declaradas.
- La **validación diferencial** (ver [`PIPELINE.md`](PIPELINE.md) fase 7) es la prueba final de que
  la HIGS es **suficiente** para reimplementar el juego.
