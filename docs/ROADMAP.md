# Roadmap del marco

Estados: `HECHO` → `EN CURSO` → `PENDIENTE` → `BLOQUEADO`. Cada fase tiene **criterio de cierre**
(evidencia que la da por terminada).

Regla transversal: **documentación primero** ([`RESEARCH_FIRST.md`](RESEARCH_FIRST.md)).

## P0 — Fundación y vertical slice (Pac-Man + MAME)

Objetivo: que **un** juego recorra el pipeline completo antes de generalizar.

- P0.1 Estructura del monorepo + docs + ADRs (`docs/`). **HECHO**.
- P0.2 Destripar Pac-Man: Dossier + driver MAME → `RESEARCH.md`. **HECHO**
  (`platforms/arcade/dedicated/namco_pacman/pacman/docs/RESEARCH.md`).
- P0.3 Emulación instrumentada: contrato (`docs/INSTRUMENTATION.md`), plan MAME del nodo y
  orquestador (`tools/orchestrator/`). **HECHO (base)**: cores reales compilados y validados
  (`mame2003-plus`, `mesen`, `genesis-plus-gx`, `libretro-uae`, `stella`, `gambatte`, `smsplus-gx`)
  y vertical slice de Pac-Man ejecutado (determinismo OK → `extraction/`). Pendiente fino:
  memoria de MAME (no expone `SYSTEM_RAM`) y rotación de pantalla.
- P0.4 Análisis estático (Capstone + Ghidra) + anotación por trazas. **PENDIENTE**.
- P0.5 Bucle IA: inferir FSM de fantasmas, velocidades por nivel, mapas, túnel. **PENDIENTE**.
- P0.6 HIGS de Pac-Man + assets (tiles/sprites/paletas/sonido). **PENDIENTE**.
- P0.7 Reimpl SDL3 + **validación diferencial** frame a frame. **PENDIENTE**.

**Cierre**: `pacman-sdl` reproduce el original (cero desviaciones en los escenarios cubiertos) y la
HIGS **reproduce** lo que el Dossier describe.

## P1 — Generalización del pipeline

- P1.1 Orquestador (carga ROM → instrumenta → traza → Ghidra → HIGS → valida). **EN CURSO**:
  interfaz `EmulatorControl` + [`INSTRUMENTATION.md`](INSTRUMENTATION.md); adaptadores pendientes.
- P1.2 Esquema HIGS + JSON Schema + `HIGS lint` + CI — **HECHO** (`docs/higs/`, `.github/workflows/`).
- P1.3 Extractores de assets por plataforma (tiles/sprites/paletas/audio).
- P1.4 Validación diferencial reusable (framebuffer + audio + estado).
- P1.5 Segundo juego (preferible no arcade: NES o Amiga) para probar la generalidad.

**Cierre**: añadir un juego nuevo no requiere tocar el núcleo, solo config + plugins de plataforma.

## P2 — Amiga 500 (retrofit de `Amiga-Reverse`)

- P2.1 Migrar al layout (`platforms/computers/amiga500/...`). **HECHO** (fases 1+2;
  ver [`MIGRATION_AMIGA_REVERSE.md`](MIGRATION_AMIGA_REVERSE.md)).
- P2.2 `hardware_spec` Amiga (Agnus/Denise/Paula/68000) **HECHO**; adaptador WinUAE→`EmulatorControl`
  **PENDIENTE**.
- P2.3 «Arte» a HIGS + reimpl SDL3 + validación. **EN CURSO**: HIGS
  (`demos/arte/spec/`) + esqueleto SDL3 (`reimplementation/`); render y validación **PENDIENTES**.
- P2.4 Un **juego** Amiga (no solo demo) de un disco AmigaDOS, end-to-end. **PENDIENTE**.

**Cierre**: la plataforma Amiga se comporta como cualquier otra del marco.

## P3 — Cobertura de plataformas y calidad

- P3.1 Cores adicionales (Genesis, PSX, …) según necesidad.
- P3.2 Cobertura dirigida por IA (fuzzing/RL) para rutinas no alcanzadas.
- P3.3 Auto-generación de docs (mecánicas, mapas, timings) desde HIGS + evidencia.
- P3.4 CI: validación de esquema, lint de HIGS, regresión diferencial.

**Cierre**: varios juegos de varias plataformas con pipeline reproducible y validado.

## P4 — Conversión a plataformas destino (NES → Amiga 500)

Tercer pilar ([ADR 0005](adr/0005-pilar-conversion-plataformas.md)): automatizar la **conversión de
un juego a otra plataforma**, empezando por **NES → Amiga 500** con un enfoque **HLE + fallback**.

- P4.1 Fundaciones del pilar `conversion/` y del nodo `nes-to-amiga500` (docs + roadmap + ADR).
  **HECHO**.
- P4.2 CPU 6502 runtime fiel (host) validada con `nestest`. **PENDIENTE**.
- P4.3 Transpilador estático 6502 → C++23 (NROM). **PENDIENTE**.
- P4.4 Fallback PPU+APU software en host + validación diferencial vs `mesen`. **PENDIENTE**.
- P4.5 Runtime Amiga mínimo (arranca en WinUAE A500 con el fallback). **PENDIENTE**.
- P4.6 Motores Amiga: tiles+scroll, sprites, audio. **PENDIENTE**.
- P4.7 Capa HLE (reconocimiento de intenciones) y mappers 0/2/3/1/4. **PENDIENTE**.
- P4.8 Matriz de compatibilidad con ROMs propias. **PENDIENTE**.

**Cierre**: un juego NROM y un UxROM arrancan y son jugables en A500 stock (frameskip permitido),
con validación diferencial y compatibilidad documentada. Roadmap detallado:
[`conversion/nes-to-amiga500/docs/ROADMAP.md`](../conversion/nes-to-amiga500/docs/ROADMAP.md).

## Hitos buscables

| Hito | Evidencia |
|---|---|
| M1 · Savestate determinista | dos ejecuciones con mismo *(state,input)* → mismas trazas/frames |
| M2 · CFG anotado | `control_flow_graph.json` con funciones nombradas por trazas |
| M3 · FSM inferida | HIGS `state_machines/*.json` validada contra el juego |
| M4 · Reimpl validada | diff de framebuffer ≈ 0 en escenarios cubiertos |
| M5 · Generalización | segundo juego sin tocar el núcleo |
| M6 · Amiga integrado | «Arte» migrado (HECHO) y validado (pendiente) |

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

`Amiga-Reverse` está **integrado** en este repo como plataforma Amiga
(`platforms/computers/amiga500/`): aporta el método (emulación WinUAE/GDB, hook de decrunchers,
Ghidra, reimpl C++ con ASM canónico, documentación con confianza/evidencia) y el demo «Arte» como
primer expediente. El marco **generaliza** ese método al resto de plataformas.
