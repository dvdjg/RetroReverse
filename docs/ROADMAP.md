# Roadmap del marco

Estados: `HECHO` → `EN CURSO` → `PENDIENTE` → `BLOQUEADO`. Cada fase tiene **criterio de cierre**
(evidencia que la da por terminada).

Regla transversal: **documentación primero** ([`RESEARCH_FIRST.md`](RESEARCH_FIRST.md)).

## P0 — Fundación y vertical slice (Pac-Man + MAME)

Objetivo: que **un** juego recorra el pipeline completo antes de generalizar.

- P0.1 Estructura del monorepo + docs + ADRs (`docs/`). **HECHO** (diseño).
- P0.2 Destripar Pac-Man: Dossier + desensamblado + driver MAME → `RESEARCH.md`. **PENDIENTE**.
- P0.3 MAME (versión ligera) instrumentado headless: input, savestates, trazas, captura. **PENDIENTE**.
- P0.4 Análisis estático (Capstone + Ghidra) + anotación por trazas. **PENDIENTE**.
- P0.5 Bucle IA: inferir FSM de fantasmas, velocidades por nivel, mapas, túnel. **PENDIENTE**.
- P0.6 HIGS de Pac-Man + assets (tiles/sprites/paletas/sonido). **PENDIENTE**.
- P0.7 Reimpl SDL3 + **validación diferencial** frame a frame. **PENDIENTE**.

**Cierre**: `pacman-sdl` reproduce el original (cero desviaciones en los escenarios cubiertos) y la
HIGS **reproduce** lo que el Dossier describe.

## P1 — Generalización del pipeline

- P1.1 Orquestador C++23/Python (carga ROM → instrumenta → traza → Ghidra → HIGS → valida).
- P1.2 Esquema HIGS + JSON Schema + `HIGS lint` — **HECHO** (`docs/higs/`); pendiente integrarlo en CI.
- P1.3 Extractores de assets por plataforma (tiles/sprites/paletas/audio).
- P1.4 Validación diferencial reusable (framebuffer + audio + estado).
- P1.5 Segundo juego (preferible no arcade: NES o Amiga) para probar la generalidad.

**Cierre**: añadir un juego nuevo no requiere tocar el núcleo, solo config + plugins de plataforma.

## P2 — Amiga 500 (retrofit de `Amiga-Reverse`)

- P2.1 Migrar `Amiga-Reverse` al layout (`platforms/computers/amiga500/...`).
  Ver [`MIGRATION_AMIGA_REVERSE.md`](MIGRATION_AMIGA_REVERSE.md).
- P2.2 `hardware_spec` Amiga (Agnus/Denise/Paula/68000) + instrumentación WinUAE-DBG/GDB.
- P2.3 Portar el expediente «Arte» a HIGS + reimpl SDL3 + validación.
- P2.4 Un **juego** Amiga (no solo demo) de un disco AmigaDOS, end-to-end.

**Cierre**: la plataforma Amiga se comporta como cualquier otra del marco.

## P3 — Cobertura de plataformas y calidad

- P3.1 Cores adicionales (Genesis, PSX, …) según necesidad.
- P3.2 Cobertura dirigida por IA (fuzzing/RL) para rutinas no alcanzadas.
- P3.3 Auto-generación de docs (mecánicas, mapas, timings) desde HIGS + evidencia.
- P3.4 CI: validación de esquema, lint de HIGS, regresión diferencial.

**Cierre**: varios juegos de varias plataformas con pipeline reproducible y validado.

## Hitos buscables

| Hito | Evidencia |
|---|---|
| M1 · Savestate determinista | dos ejecuciones con mismo *(state,input)* → mismas trazas/frames |
| M2 · CFG anotado | `control_flow_graph.json` con funciones nombradas por trazas |
| M3 · FSM inferida | HIGS `state_machines/*.json` validada contra el juego |
| M4 · Reimpl validada | diff de framebuffer ≈ 0 en escenarios cubiertos |
| M5 · Generalización | segundo juego sin tocar el núcleo |
| M6 · Amiga integrado | «Arte» migrado y validado |

## Riesgos

| Riesgo | Mitigación |
|---|---|
| No-determinismo del core | savestates en memoria + semillas fijas + input frame-exacto |
| Explosión de trazas | muestreo y rangos; no trazar todo |
| HIGS insuficiente | la validación diferencial lo detecta; iterar |
| Coste de instrumentar MAME moderno | empezar con cores year-stamped/específicos |
| Legal (ROMs/assets) | solo ROMs propias; no versionar binarios/assets originales |
| Deriva a «port mirando el asm» | prohibido: la reimpl solo consume HIGS + assets |

## Relación con `Amiga-Reverse`

`Amiga-Reverse` ya cubre para Amiga buena parte de P0–P2 (emulación instrumentada, hook de
decrunchers, Ghidra, reimpl C++ con tests, documentación con confianza/evidencia). El marco
**generaliza** ese método y lo integra como plataforma.
