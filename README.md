# RetroReverse — de juegos clásicos a PC

Marco (proyecto **único**) para **extraer, entender y reimplementar** juegos clásicos — arcade,
consolas (NES, Megadrive…) y ordenadores (Amiga 500) — de forma **automatizada y asistida por IA**,
con el objetivo de producir una versión **C++23 + SDL3** que **no se distinga** del original
(*pixel-perfect* y temporizaciones exactas).

> **Aviso legal**: repositorio **privado** de estudio personal. Se analiza **para aprender** y se
> documentan **técnicas y algoritmos** (ideas). El contenido **propio** va bajo **MIT**; el material
> de terceros (binarios/assets originales) **no** está cubierto por esa licencia y sigue siendo © de
> sus autores — solo referencia de estudio. Ver [`docs/LEGAL.md`](docs/LEGAL.md) y
> [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) §8.

> **Un solo repositorio** (decisión [ADR 0004](docs/adr/0004-migracion-amiga-reverse.md)): el marco y
> sus plataformas conviven aquí. Repositorio: **`dvdjg/RetroReverse`** (privado).

> **Layout**: los **programas auxiliares** (Ghidra, Gradle, Rizin, RetroArch, cores `libretro-*`…)
> viven en [`external/`](external/) **dentro del repo** pero **ignorados por git** (no versionados).

---

## Cómo empezar (hilo nuevo)

1. **Directorio de trabajo**: la **raíz del repo** (esta carpeta). En disco:
   `C:\Users\dvdjg\Documents\programa\AI\Amiga\RetroReverse\repo`.
2. **Leer en este orden**:
   1. [`CONTEXT.md`](CONTEXT.md) — traspaso: estado, rutas, entorno y próximos pasos.
   2. Este README (visión, reglas, índices).
   3. [`AGENTS.md`](AGENTS.md) — **directrices del agente** (obligatorias).
   4. [`STRUCTURE.md`](STRUCTURE.md) — estructura canónica de un expediente.
   5. [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) y [`PORTING.md`](PORTING.md).
3. **Validar** (los `Makefile` corren con **g++ de WSL**):

```powershell
wsl -d Ubuntu -- bash -lc "bash /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/scripts/validate-higs.sh"
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/platforms/computers/amiga500/demos/arte/reimplementation/reference && make test-all"
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/tools/orchestrator && make test"
```

> ⚠️ El CWD de hilos anteriores apuntaba a `…\Amiga\Amiga-Reverse` (ya no existe). Usa siempre esta
> carpeta o `workdir`/rutas absolutas.

## Qué produce (por juego)

1. **Desensamblado y mapa de memoria** (Capstone / Ghidra headless), con funciones anotadas por trazas.
2. **Especificación agnóstica de hardware (HIGS)**: mecánicas, mapas, entidades (FSM/hitboxes),
   **temporizaciones exactas** (ciclos y ticks 50/60 Hz), assets.
3. **Assets decodificados** a formatos neutros (PNG, WAV, JSON).
4. **Reimplementación C++23 + SDL3** validada **diferencialmente** contra el emulador.

## Principios (no negociables)

1. **Documentación primero** — antes de tocar una ROM, búsqueda documental exhaustiva
   ([`docs/RESEARCH_FIRST.md`](docs/RESEARCH_FIRST.md)).
2. **Determinismo** — savestates en memoria + input frame-exacto
   ([`docs/PIPELINE.md`](docs/PIPELINE.md), [`docs/INSTRUMENTATION.md`](docs/INSTRUMENTATION.md)).
3. **Spec agnóstica de hardware** — la reimpl **solo** consume `spec/` (HIGS), ADR 0003
   ([`docs/HIGS.md`](docs/HIGS.md)).
4. **Validación diferencial** — framebuffer y audio frame a frame contra el emulador.
5. **Legalidad** — solo ROMs propias; no se redistribuyen binarios/assets ([`docs/LEGAL.md`](docs/LEGAL.md)).

## Arquitectura (5 componentes)

```
         ORQUESTADOR (tools/orchestrator)
   ┌──────────────┬────────────────────┬───────────────────┐
   ▼              ▼                    ▼                   │
EMULACIÓN      ANÁLISIS ESTÁTICO      SPEC INTERMEDIA (HIGS) │
HEADLESS       (Ghidra/Capstone)      JSON/YAML              │
(libretro)     CFG · símbolos · I/O   mapas · FSMs · timing  │
   └──────────────┴────────────────────┴───────────────────┘
                          ▼
              VALIDACIÓN DIFERENCIAL (C++23/SDL3)
```

Detalle en [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md); layout en
[`docs/REPO_LAYOUT.md`](docs/REPO_LAYOUT.md); hoja de ruta en [`docs/ROADMAP.md`](docs/ROADMAP.md).

## Estado y roadmaps

- **Marco**: documentación hecha; **HIGS** (JSON Schema + lint + CI) hecha; **orquestador** con
  interfaz `EmulatorControl`, **adaptador libretro** y **cores reales compilados**
  (`mame2003-plus`, `mesen`, `genesis-plus-gx`, `libretro-uae`) + **RetroArch**. Vertical slice
  Pac-Man listo (`scripts/pacman-slice.sh`); pendiente la ROM propia.
- **Amiga 500**: migrado e integrado; `hardware_spec` y herramientas; demo **«Arte»** con **HIGS** y
  **esqueleto SDL3** + C/C++ de referencia (tests OK). Pendiente: render y validación diferencial.
- **Arcade — Pac-Man**: `docs/RESEARCH.md` cerrado (Dossier) + plan de instrumentación + `rom/layout.json`.
- **Conversión — NES → Amiga 500**: pilar `conversion/` abierto con estructura, diseño y roadmap
  (transpilador 6502→C++23, HLE + fallback, PPU/Copper/sprites/audio en A500). Implementación
  pendiente (`docs/ROADMAP.md` §P4).
- Roadmaps: [`docs/ROADMAP.md`](docs/ROADMAP.md) ·
  [`docs/MIGRATION_AMIGA_REVERSE.md`](docs/MIGRATION_AMIGA_REVERSE.md) ·
  [`arte/docs/ROADMAP.md`](platforms/computers/amiga500/demos/arte/docs/ROADMAP.md) ·
  [`arte/docs/PENDIENTES.md`](platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md).

## Expedientes (nodos)

| Nodo | Plataforma | Estado | Ruta |
|---|---|---|---|
| **Arte** (Sanity) | Amiga 500 (demo) | en curso | [`platforms/computers/amiga500/demos/arte/`](platforms/computers/amiga500/demos/arte/README.md) |
| **Pac-Man** | Arcade (Namco) | research cerrado | [`platforms/arcade/dedicated/namco_pacman/pacman/`](platforms/arcade/dedicated/namco_pacman/pacman/README.md) |
| NES | consola | por abrir | `platforms/consoles/nes/` |
| Megadrive | consola | por abrir | (crear `platforms/consoles/megadrive/`) |

Cada título sigue la **estructura canónica** de [`STRUCTURE.md`](STRUCTURE.md); para uno nuevo se
copia [`docs/templates/expediente/`](docs/templates/expediente/).

## Conversión a plataformas destino (`conversion/`)

Tercer pilar ([ADR 0005](docs/adr/0005-pilar-conversion-plataformas.md)): **automatizar la
conversión de un juego a otra plataforma** (no a PC). Primer nodo: **NES → Amiga 500**
(transpilador 6502→C++23 en host + runtime HLE/fallback para A500).

- Visión y nodos: [`conversion/README.md`](conversion/README.md).
- Nodo NES→Amiga 500: [`conversion/nes-to-amiga500/`](conversion/nes-to-amiga500/README.md)
  (roadmap, arquitectura, transpilador, HLE, PPU/Copper/sprites/audio en Amiga, mappers, riesgos).
- Fase del marco: [`docs/ROADMAP.md`](docs/ROADMAP.md) §P4.

---

# Subproyecto Amiga — «Arte» (Sanity, 1993)

Expediente de **ingeniería inversa de software Amiga 68k**. Objetivo: **recuperar las técnicas**
(sobre todo gráficas), **comprender el asm 68k**, **inferir el C++ equivalente** y **reconstruir**
en un engine propio. Las rutinas optimizadas (p. ej. Q15 con `muls.w`/`swap` del motor 3D) son la
**referencia canónica** que se porta. Ver
[`platforms/computers/amiga500/demos/arte/README.md`](platforms/computers/amiga500/demos/arte/README.md).

## Técnicas recuperadas y portadas

Recreaciones en C++ en
[`reimplementation/reference/`](platforms/computers/amiga500/demos/arte/reimplementation/reference/README.md);
estado en [`arte/docs/ROADMAP.md`](platforms/computers/amiga500/demos/arte/docs/ROADMAP.md):

| Técnica | Módulo | Reimpl |
|---|---|---|
| Seno Q1.14 | `SINE.soslibrary` | [`sine_table`](platforms/computers/amiga500/demos/arte/reimplementation/reference/sine_table/README.md) |
| Motor 3D Q15 (matriz + transform + ortonormalización) | `0x0B0C2C` | [`motor_3d`](platforms/computers/amiga500/demos/arte/reimplementation/reference/motor_3d/README.md) |
| Blobs con lookup tables | `0x0B0C2C` | [`blob_render`](platforms/computers/amiga500/demos/arte/reimplementation/reference/blob_render/README.md) |
| Distorsión SINE (8 osciladores) | `0x096A28` | [`sine_wobble`](platforms/computers/amiga500/demos/arte/reimplementation/reference/sine_wobble/README.md) |
| Scrolltext (fuente 3 planos) | `0x02162C` | [`scrolltext`](platforms/computers/amiga500/demos/arte/reimplementation/reference/scrolltext/README.md) |
| Fade de paleta por nibbles | `0x0B0C2C` | [`palette_fade`](platforms/computers/amiga500/demos/arte/reimplementation/reference/palette_fade/README.md) |
| Esfera texturizada 16 col. | (Chaos) | [`sphere`](platforms/computers/amiga500/demos/arte/reimplementation/reference/sphere/README.md) |
| Túnel / corridor (raycast por filas) | `0x03AFFC` | [`tunnel`](platforms/computers/amiga500/demos/arte/reimplementation/reference/tunnel/README.md) |
| Zoom/créditos (núcleo: Q16, trayectoria, bandas) | `0x07E42C` | [`zoom`](platforms/computers/amiga500/demos/arte/reimplementation/reference/zoom/README.md) |

Pendientes: el **blit/copper del zoom** y la **rutina de render del túnel** (init localizado, render
por dispatch indirecto). Inventario en
[`arte/docs/PENDIENTES.md`](platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md).

## Cómo empezar (Amiga)

```powershell
# 1) Extraer el disco (verificado por pista)
python platforms\computers\amiga500\tools\python\dms_unpack.py Sanity-Arte.dms platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --verbose

# 2) Arrancar en WinUAE-DBG y volcar RAM + módulos
node platforms\computers\amiga500\tools\node\dump-ram.mjs --config platforms\computers\amiga500\demos\arte\rom\sanity.uae --adf platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --boot 20 --prefix sanity --screenshot
node platforms\computers\amiga500\tools\node\hook-trampoline.mjs --config platforms\computers\amiga500\demos\arte\rom\sanity.uae --adf platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --spec platforms\computers\amiga500\demos\arte\extraction\specs\imp-dump.json --out platforms\computers\amiga500\demos\arte\extraction --boot 5

# 3) Desensamblar / decompilar (objdump/capstone + Ghidra)
tools\ghidra\decompile-modules.ps1 -ModulesJson platforms\computers\amiga500\demos\arte\extraction\modules\modules.json -OutDir platforms\computers\amiga500\demos\arte\extraction\ghidra
```

Comandos completos:
[`arte/tools/README.md`](platforms/computers/amiga500/demos/arte/tools/README.md).

## Metodología (RE Amiga)

```
imagen (.dms/.adf/.ipf) → descomprimir/verificar → ¿AmigaDOS o trackloader?
  → WinUAE-DBG + volcado RAM → hook del decruncher → extraction/modules/
  → objdump/capstone (.asm canónico) + Ghidra (CFG/xrefs/decompilado)
  → media (bitplanes/paletas/copper) → reimpl C++ (+ ASM canónico)
```

**Regla de oro**: si el disco no es AmigaDOS, el código **no está en el fichero** (está en RAM tras
el decrunch); y **la demo en marcha no es fiable** para reconstruir un frame (el Copper hace splits).
Método completo en [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md); contrato de port en
[`PORTING.md`](PORTING.md).

---

## Documentación

### Marco (`docs/`)

| Documento | Contenido |
|---|---|
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | Componentes, interfaces y flujo de datos |
| [`docs/PIPELINE.md`](docs/PIPELINE.md) | Flujo iterativo (instrumentar → trazar → inferir → validar) |
| [`docs/HIGS.md`](docs/HIGS.md) | Spec intermedia agnóstica de hardware (concepto) |
| [`docs/higs/`](docs/higs/README.md) | **JSON Schema**, ejemplo y **lint** (`higs_lint.py`) |
| [`docs/INSTRUMENTATION.md`](docs/INSTRUMENTATION.md) | Contrato de emulación observable (API, trazas, determinismo) |
| [`docs/RESEARCH_FIRST.md`](docs/RESEARCH_FIRST.md) | Regla 0: documentación primero |
| [`docs/EMULATORS.md`](docs/EMULATORS.md) | Cores/emuladores por plataforma e instrumentación |
| [`docs/REFERENCES.md`](docs/REFERENCES.md) | Índice de desensamblados/análisis de referencia (Pac-Man, NES, MD, Amiga) |
| [`docs/ROM_SELECTION.md`](docs/ROM_SELECTION.md) | Selección de ROMs propias y trazabilidad |
| [`docs/REPO_LAYOUT.md`](docs/REPO_LAYOUT.md) | Estructura por plataforma + nodo de juego |
| [`docs/ROADMAP.md`](docs/ROADMAP.md) | Fases, hitos y riesgos del marco |
| [`docs/MIGRATION_AMIGA_REVERSE.md`](docs/MIGRATION_AMIGA_REVERSE.md) | Migración/integración Amiga (hecha) |
| [`docs/LEGAL.md`](docs/LEGAL.md) | ROMs propias, no redistribución, licencias |
| [`docs/adr/`](docs/adr/README.md) | ADRs (monorepo, libretro, HIGS, repo único) |
| [`docs/templates/expediente/`](docs/templates/expediente/) | Plantilla de expediente |

### Metodología y reglas

| Documento | Contenido |
|---|---|
| [`STRUCTURE.md`](STRUCTURE.md) | Estructura canónica de un expediente, reglas y convenciones |
| [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) | Método reutilizable y trampas (§7bis: Ghidra/Rizin) |
| [`PORTING.md`](PORTING.md) | Del código recuperado al engine: C/C++ ref + ASM canónico + ABI |
| [`AGENTS.md`](AGENTS.md) | Directrices de trabajo del agente |

### Herramientas

| Documento | Contenido |
|---|---|
| [`tools/README.md`](tools/README.md) | Toolkit genérico (`bin_scan`, `ollama_vision`, `ghidra/`) |
| [`tools/orchestrator/README.md`](tools/orchestrator/README.md) | Orquestador + **adaptador libretro** (`EmulatorControl`) |
| [`tools/ghidra/README.md`](tools/ghidra/README.md) | Ghidra + extensión Amiga: instalación, scripts, pipeline, rz-ghidra |
| [`platforms/computers/amiga500/tools/README.md`](platforms/computers/amiga500/tools/README.md) | Herramientas específicas de Amiga (WinUAE/GDB, DMS, planar/copper) |
| [`platforms/computers/amiga500/hardware_spec/README.md`](platforms/computers/amiga500/hardware_spec/README.md) | Memoria/custom chips/registros del A500 |

### Expediente «Arte»

| Documento | Contenido |
|---|---|
| [`arte/README.md`](platforms/computers/amiga500/demos/arte/README.md) | Estado, inventario y cómo reproducir |
| [`arte/docs/ROADMAP.md`](platforms/computers/amiga500/demos/arte/docs/ROADMAP.md) | Fases, criterios de cierre, estado de efectos |
| [`arte/docs/PENDIENTES.md`](platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md) | Inventario vivo de trabajo abierto |
| [`arte/docs/HALLAZGOS.md`](platforms/computers/amiga500/demos/arte/docs/HALLAZGOS.md) | Datos concretos con evidencia |
| [`arte/docs/TECNICAS.md`](platforms/computers/amiga500/demos/arte/docs/TECNICAS.md) | Efecto a efecto + receta de reimplementación |
| [`arte/spec/game.json`](platforms/computers/amiga500/demos/arte/spec/game.json) | HIGS de «Arte» |
| [`arte/reimplementation/`](platforms/computers/amiga500/demos/arte/reimplementation/README.md) | Reimpl SDL3 (solo `spec/` + `assets/`) |
| [`arte/docs/GHIDRA_AMIGA_EVAL.md`](platforms/computers/amiga500/demos/arte/docs/GHIDRA_AMIGA_EVAL.md) | Evaluación de Ghidra + extensión |
| [`arte/extraction/maps/modules.md`](platforms/computers/amiga500/demos/arte/extraction/maps/modules.md) | Módulos, direcciones, tamaños, sha1 |

### Expediente «Pac-Man»

| Documento | Contenido |
|---|---|
| [`pacman/README.md`](platforms/arcade/dedicated/namco_pacman/pacman/README.md) | Estado del nodo |
| [`pacman/docs/RESEARCH.md`](platforms/arcade/dedicated/namco_pacman/pacman/docs/RESEARCH.md) | Ground truth (Dossier) |
| [`pacman/docs/INSTRUMENTATION.md`](platforms/arcade/dedicated/namco_pacman/pacman/docs/INSTRUMENTATION.md) | Plan de instrumentación MAME |
| [`pacman/rom/layout.json`](platforms/arcade/dedicated/namco_pacman/pacman/rom/layout.json) | Mapa de memoria/I-O |

## Entorno / toolchain

- **WinUAE-DBG x86** (`WinUAE-DBG/bin/winuae-gdb.exe`) + GDB (`:2345`) + canal lateral (`:2346`)
  (repo hermano, **no** movido aquí).
- **`m68k-amiga-elf-objdump.exe`** (extensión Bartman) — desensamblado canónico.
- **Ghidra 12.0.1 + `BartmanAbyss/ghidra-amiga`** — loaders Hunk/`.uss`/ROM, símbolos NDK, decompilador
  → [`external/`](external/), ver [`tools/ghidra/README.md`](tools/ghidra/README.md).
- **Rizin 0.9.1** (y `rz-ghidra` en WSL) → [`external/`](external/).
- **Kickstart 1.3**, **Node.js** ≥ 18, **Python 3**, **JDK 21**.

## Programas auxiliares (`external/`, ignorado por git)

- **Herramientas**: Ghidra 12.0.1, extensión `ghidra-amiga`, Gradle 9.2.1, Rizin (fuentes y builds),
  `rz-ghidra`.
- **Emulación**: RetroArch, libretro-super, libretro-common, libretro-database, libRetroReversing.
- **Cores**: arcade (`mame`, `mame2003-plus`), NES (`mesen`, `nestopia`, `fceumm`), Megadrive
  (`genesis-plus-gx`), Amiga (**`libretro-uae`** base WinUAE, `puae`), **Atari 2600** (`stella`),
  **Game Boy/Color** (`gambatte`), **Master System/Game Gear** (`smsplus-gx`).
- **Referencias** (desensamblados/análisis): [`external/references/`](external/references/) —
  ver [`docs/REFERENCES.md`](docs/REFERENCES.md).
- Detalle: [`tools/orchestrator/README.md`](tools/orchestrator/README.md).

## Cómo reproducir / validar

```powershell
# HIGS (esquema + lint)
wsl -d Ubuntu -- bash -lc "bash /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/scripts/validate-higs.sh"
# Codificación (UTF-8 sin BOM ni mojibake)
wsl -d Ubuntu -- bash -lc "bash /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/scripts/validate-encoding.sh"
# Reimpl «Arte» (tests host)
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/platforms/computers/amiga500/demos/arte/reimplementation/reference && make test-all"
# Adaptador libretro (core de prueba)
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/tools/orchestrator && make test"
# Cores reales (compilar + comprobar carga)
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo && bash scripts/build-cores.sh && bash scripts/check-cores.sh"
# Referencias (clona desensamblados/PDFs a external/references/)
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo && bash scripts/fetch-references.sh"
# ROMs propias: selección desde la colección externa -> roms/ (ignorado por git)
python scripts/select-roms.py
# Vertical slice Pac-Man (requiere rom/raw/pacman.zip)
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo && bash scripts/pacman-slice.sh"
```

**CI**: [`.github/workflows/validate.yml`](.github/workflows/validate.yml) valida las HIGS en cada push/PR.

## Añadir un expediente nuevo

1. Copiar [`docs/templates/expediente/`](docs/templates/expediente/) a `platforms/.../<game_id>/`.
2. Rellenar `README.md` y `docs/ROADMAP.md` (fase 0 = extraer la imagen).
3. Añadir la spec en `extraction/specs/` y documentar los comandos en su `tools/README.md`.
4. Ir volcando: `extraction/` → revisar → promover a `assets/`/`docs/` → reimplementar en
   `reimplementation/`. Reglas en [`STRUCTURE.md`](STRUCTURE.md).

## Licencia

- **Contenido propio** (marco, análisis, documentación, reimplementaciones y toolkit): **MIT** —
  ver [`LICENSE`](LICENSE).
- **Material de terceros** (binarios/assets originales en el repo): **no** cubierto por la MIT; © de
  sus autores. Referencia de estudio. Ver [`docs/LEGAL.md`](docs/LEGAL.md).

Repositorio **privado** de uso personal.
