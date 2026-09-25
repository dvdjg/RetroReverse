# Estructura del repositorio

Layout monorepo por **plataforma → arquitectura/placa → [variante] → juego**, más las áreas
compartidas del marco (`emulators/`, `frontend/`, `tools/`, `scripts/`, `docs/`).

> **Estado**: el árbol de abajo es el **destino**. La **fase 1** de la reestructuración ya está
> hecha: un solo repositorio (`dvdjg/RetroReverse`), con el marco en
> `docs/`, `tools/`, `docs/templates/expediente/` y el expediente Amiga ya en
> `platforms/computers/amiga500/demos/arte/`. La **fase 2** (reorganización interna del nodo a
> `rom/ extraction/ assets/ spec/ reimplementation/`) está pendiente: ver
> [`MIGRATION_AMIGA_REVERSE.md`](MIGRATION_AMIGA_REVERSE.md).

## Niveles de clasificación

`Categoría de plataforma → Arquitectura/Placa → [Variante] → Proyecto de juego`.

```
RetroReverse/
├── docs/                         documentación del marco (este directorio)
├── platforms/
│   ├── arcade/
│   │   ├── dedicated/            placa específica de un juego
│   │   │   └── namco_pacman/
│   │   │       └── pacman/
│   │   └── modular_systems/      placa base compartida (+ variantes)
│   │       └── sega_system16/
│   │           ├── system16a/shinobi/
│   │           └── system16b/golden_axe/
│   ├── consoles/
│   │   └── nes/
│   │       ├── hardware_spec/    bus común (6502, PPU, APU, mappers)
│   │       └── games/super_mario_bros/
│   └── computers/
│       └── amiga500/
│           ├── hardware_spec/    custom chips (Agnus/Denise/Paula), 68000
│           └── games/arte/       <- Amiga-Reverse migra aquí
├── emulators/                    fuentes y forks instrumentados
├── frontend/                     retroarch/ o frontend mínimo
├── tools/                        análisis, extracción, orquestador
└── scripts/                      build, instrumentación, pipeline
```

### Reglas de clasificación

1. **Arcade dedicado** (`arcade/dedicated/`): la PCB tiene circuitería exclusiva del juego; el
   hardware se documenta **dentro** del nodo del juego.
2. **Arcade modular** (`arcade/modular_systems/`): varios juegos comparten CPU/vídeo/sonido; la
   arquitectura se documenta una vez; las revisiones de placa son **variantes**.
3. **Consolas/ordenadores** (`consoles/`, `computers/`): la arquitectura del sistema vive en
   `hardware_spec/` (emulador base + buses); las ROMs, en `games/`. La reimplementación **solo**
   depende de `spec/` y `assets/` del juego, **nunca** del emulador ni de `hardware_spec/`.

## Nodo de juego (*game leaf node*)

```
<game_id>/
├── rom/                        # fuente (solo ROMs que poseas legalmente)
│   ├── raw/                    # dumps originales (.zip/.bin/.nes/…)
│   ├── layout.json             # mapa de memoria, EPROMs, puertos I/O
│   └── checksums.sha256
├── extraction/                 # salida de análisis (NO es la spec)
│   ├── disassembly/            # code_blocks.asm, control_flow_graph.json, symbols.map
│   ├── execution_traces/       # cobertura, eventos, diffs de estado
│   ├── memory_dumps/           # snapshots RAM/VRAM/registros por frame
│   └── savestates/             # estados deterministas en puntos clave
├── assets/                     # assets extraídos/decodificados
│   ├── graphics/               # PNG (tiles, sprites, tilemaps)
│   ├── audio/                  # WAV / MIDI / JSON de secuencias
│   └── palettes/               # tablas de color
├── spec/                       # HIGS (agnóstica de hardware) — ver docs/HIGS.md
│   ├── game.json
│   ├── timing_rules.yaml
│   ├── map_definitions.json
│   ├── state_machines/
│   ├── hitboxes.json
│   └── assets.json
└── reimplementation/           # C++23 + SDL3 (solo lee spec/ + assets/)
    ├── CMakeLists.txt
    ├── include/
    ├── src/{entities,logic,render}/
    └── tests/                  # validación diferencial vs ROM
```

## Áreas compartidas

- `emulators/`: `mame/` (upstream), `mame-instrumented/` (fork), `winuae/`, `fs-uae/`,
  `nestopia-instrumented/`, `libretro-mame/`, … Ver [`EMULATORS.md`](EMULATORS.md).
- `frontend/retroarch/` o un frontend headless propio.
- `tools/ghidra/{plugins,projects}/`, `tools/asset-extractors/`, `tools/libRetroReversing/`,
  `tools/orchestrator/`.
- `scripts/`: build, instrumentación y pipeline.

## Higiene de repositorio

- **ROMs, assets originales y binarios de emulador NO se versionan** en repos públicos; usar
  `.gitignore` por juego y, si hace falta, almacenamiento local/`git-lfs` solo en repos privados.
- Separar **evidencia** (`extraction/`, pesada, regenerable) de **curaduría** (`spec/`, `assets/`
  decodificados) de **código** (`reimplementation/`), igual que hace `Amiga-Reverse` con
  `out/` vs `recovered/` vs `reimpl/`.
- Cada juego documenta en su `README.md` cómo **reproducir** su pipeline (comandos + versiones).
