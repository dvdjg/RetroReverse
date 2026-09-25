# RetroReverse — de juegos clásicos a PC

Marco (proyecto **único**) para **extraer, entender y reimplementar** juegos clásicos — arcade,
consolas y ordenadores (Amiga 500, NES, …) — de forma **automatizada y asistida por IA**, con el
objetivo de producir una versión **C++23 + SDL3** que **no se distinga** del original
(*pixel-perfect* y temporizaciones exactas).

> **Un solo repositorio** (decisión [ADR 0004](docs/adr/0004-migracion-amiga-reverse.md)): aquí
> convive el **marco** con su **subproyecto Amiga** (`platforms/computers/amiga500/demos/arte/`, expediente «Arte»). El repo se
> llama hoy `Amiga-Reverse` en GitHub; puede renombrarse a `RetroReverse` para coherencia.

> **Aviso legal**: repositorio **privado** de estudio personal. Se analiza **para aprender** y se
> documentan **técnicas y algoritmos** (ideas). El contenido **propio** va bajo **MIT**; el material
> de terceros (binarios/assets originales) **no** está cubierto por esa licencia y sigue siendo © de
> sus autores — solo referencia de estudio. Ver [`docs/LEGAL.md`](docs/LEGAL.md) y
> [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) §8.

---

## Qué produce (por juego)

1. **Desensamblado y mapa de memoria** (Capstone / Ghidra headless), con funciones anotadas por trazas.
2. **Especificación agnóstica de hardware (HIGS)**: mecánicas, mapas, entidades (FSM/hitboxes),
   **temporizaciones exactas** (ciclos y ticks 50/60 Hz), assets.
3. **Assets decodificados** a formatos neutros (PNG, WAV, JSON).
4. **Reimplementación C++23 + SDL3** validada **diferencialmente** contra el emulador.

## Principios (no negociables)

1. **Documentación primero** — antes de tocar una ROM, búsqueda documental exhaustiva
   ([`docs/RESEARCH_FIRST.md`](docs/RESEARCH_FIRST.md)).
2. **Determinismo** — savestates en memoria + control de input ([`docs/PIPELINE.md`](docs/PIPELINE.md)).
3. **Spec agnóstica de hardware** — la reimpl **solo** consume `spec/` (HIGS) ([`docs/HIGS.md`](docs/HIGS.md)).
4. **Validación diferencial** — framebuffer y audio frame a frame contra el emulador.
5. **Legalidad** — solo ROMs propias; no se redistribuyen binarios/assets ([`docs/LEGAL.md`](docs/LEGAL.md)).

## Arquitectura (5 componentes)

```
         ORQUESTADOR (C++23/Python)
   ┌──────────────┬────────────────────┬───────────────────┐
   ▼              ▼                    ▼                   │
EMULACIÓN      ANÁLISIS ESTÁTICO      SPEC INTERMEDIA        │
HEADLESS       (Ghidra/Capstone)      (HIGS JSON/YAML)       │
(libretro)     CFG · símbolos · I/O   mapas · FSMs · timing  │
   └──────────────┴────────────────────┴───────────────────┘
                          ▼
              VALIDACIÓN DIFERENCIAL (C++23/SDL3)
```

Detalle en [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md); layout destino en
[`docs/REPO_LAYOUT.md`](docs/REPO_LAYOUT.md); hoja de ruta en [`docs/ROADMAP.md`](docs/ROADMAP.md).

## Estado

- **Marco**: diseño documentado (este repo). Pendiente: vertical slice **Pac-Man + MAME** (P0).
- **Subproyecto Amiga**: `platforms/computers/amiga500/demos/arte/` (expediente «Arte») — pipeline ya probado para A500.
- **Migración pendiente** del expediente al layout de plataformas:
  [`docs/MIGRATION_AMIGA_REVERSE.md`](docs/MIGRATION_AMIGA_REVERSE.md).

---

# Subproyecto Amiga — «Arte» (Sanity, 1993)

Expediente de **ingeniería inversa de software Amiga 68k**. Objetivo: **recuperar las técnicas**
(sobre todo gráficas), **comprender el asm 68k**, **inferir el C++ equivalente** y **reconstruir**
en un engine propio. Las rutinas optimizadas (p. ej. Q15 con `muls.w`/`swap` del motor 3D) son la
**referencia canónica** que se porta. Ver [`platforms/computers/amiga500/demos/arte/README.md`](platforms/computers/amiga500/demos/arte/README.md).

## Índice de expedientes

| Título | Año | Plataforma | Estado | Carpeta |
|---|---|---|---|---|
| **Arte** (Sanity) | 1993 | A500 OCS/ECS | En curso | [`platforms/computers/amiga500/demos/arte/`](platforms/computers/amiga500/demos/arte/README.md) |

Cada título vive en su propia carpeta y sigue la **estructura canónica** de [`STRUCTURE.md`](STRUCTURE.md).
Para uno nuevo se copia [`docs/templates/expediente/`](docs/templates/expediente/).

## Técnicas recuperadas y portadas

Recreaciones en C++ en [`platforms/computers/amiga500/demos/arte/reimpl/`](platforms/computers/amiga500/demos/arte/reimpl/README.md); estado en
[`ROADMAP.md`](platforms/computers/amiga500/demos/arte/docs/ROADMAP.md):

| Técnica | Módulo | Reimpl |
|---|---|---|
| Seno Q1.14 | `SINE.soslibrary` | [`sine_table`](platforms/computers/amiga500/demos/arte/reimpl/sine_table/README.md) |
| Motor 3D Q15 (matriz + transform + ortonormalización) | `0x0B0C2C` | [`motor_3d`](platforms/computers/amiga500/demos/arte/reimpl/motor_3d/README.md) |
| Blobs con lookup tables | `0x0B0C2C` | [`blob_render`](platforms/computers/amiga500/demos/arte/reimpl/blob_render/README.md) |
| Distorsión SINE (8 osciladores) | `0x096A28` | [`sine_wobble`](platforms/computers/amiga500/demos/arte/reimpl/sine_wobble/README.md) |
| Scrolltext (fuente 3 planos) | `0x02162C` | [`scrolltext`](platforms/computers/amiga500/demos/arte/reimpl/scrolltext/README.md) |
| Fade de paleta por nibbles | `0x0B0C2C` | [`palette_fade`](platforms/computers/amiga500/demos/arte/reimpl/palette_fade/README.md) |
| Esfera texturizada 16 col. | (Chaos) | [`sphere`](platforms/computers/amiga500/demos/arte/reimpl/sphere/README.md) |
| Túnel / corridor (raycast por filas) | `0x03AFFC` | [`tunnel`](platforms/computers/amiga500/demos/arte/reimpl/tunnel/README.md) |
| Zoom/créditos (núcleo: Q16, trayectoria, bandas) | `0x07E42C` | [`zoom`](platforms/computers/amiga500/demos/arte/reimpl/zoom/README.md) |

Pendientes: el **blit/copper del zoom** y la **rutina de render del túnel** (init localizado, render
por dispatch indirecto). Inventario completo en [`platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md`](platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md).

## Cómo empezar (Amiga)

```powershell
# 1) Extraer el disco (verificado por pista)
python tools\python\dms_unpack.py Sanity-Arte.dms platforms\computers\amiga500\demos\arte\out\disk\sanity-arte.adf --verbose

# 2) Arrancar en WinUAE-DBG y volcar RAM + módulos
node tools\node\dump-ram.mjs --config platforms\computers\amiga500\demos\arte\out\sanity.uae --adf platforms\computers\amiga500\demos\arte\out\disk\sanity-arte.adf --boot 20 --prefix sanity --screenshot
node tools\node\hook-trampoline.mjs --config platforms\computers\amiga500\demos\arte\out\sanity.uae --adf platforms\computers\amiga500\demos\arte\out\disk\sanity-arte.adf --spec platforms\computers\amiga500\demos\arte\specs\imp-dump.json --out platforms\computers\amiga500\demos\arte\out --boot 5

# 3) Desensamblar / decompilar (objdump/capstone + Ghidra)
tools\ghidra\decompile-modules.ps1 -ModulesJson platforms\computers\amiga500\demos\arte\out\modules\modules.json -OutDir platforms\computers\amiga500\demos\arte\out\ghidra
```

Comandos completos: [`platforms/computers/amiga500/demos/arte/tools/README.md`](platforms/computers/amiga500/demos/arte/tools/README.md).

## Metodología (RE Amiga)

```
imagen (.dms/.adf/.ipf) → descomprimir/verificar → ¿AmigaDOS o trackloader?
  → WinUAE-DBG + volcado RAM → hook del decruncher → out/modules/
  → objdump/capstone (.asm canónico) + Ghidra (CFG/xrefs/decompilado)
  → media (bitplanes/paletas/copper) → reimpl C++ (+ ASM canónico)
```

**Regla de oro**: si el disco no es AmigaDOS, el código **no está en el fichero** (está en RAM tras
el decrunch); y **la demo en marcha no es fiable** para reconstruir un frame (el Copper hace splits).
Método completo en [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md); contrato de port en
[`PORTING.md`](PORTING.md).

## Toolkit reutilizable

Utilidades **parametrizables**, documentadas en [`tools/README.md`](tools/README.md):

| Área | Herramientas |
|---|---|
| **DMS / binarios** | `python/dms_unpack.py`, `python/bin_scan.py` |
| **Emulador (WinUAE-DBG + GDB)** | `node/winuae-session.mjs`, `dump-ram.mjs`, `hook-trampoline.mjs`, `probe-*.mjs`, `launch/side/stop.mjs`, `capture-live.ps1` |
| **Vídeo / assets** | `node/dump-display.mjs`, `node/decode-bitplanes.mjs`, `python/copper_decode.py`, `python/planar_decode.py`, `python/ollama_vision.py` |
| **Desensamblado / decompilado** | `ghidra/` (headless + pipeline), ver [`tools/ghidra/README.md`](tools/ghidra/README.md) |

Guía de bitmaps OCS/ECS: [`tools/python/AMIGA_BITMAPS.md`](tools/python/AMIGA_BITMAPS.md).

## Entorno / toolchain

- **WinUAE-DBG x86** (`WinUAE-DBG/bin/winuae-gdb.exe`) + servidor **GDB** (`:2345`) + **canal lateral** (`:2346`).
- **mcp-winuae-emu** (repo hermano) — `WinUAEConnection`, `GdbProtocol`.
- **`m68k-amiga-elf-objdump.exe`** (extensión Bartman) — desensamblado canónico.
- **Ghidra 12.0.1 + [`BartmanAbyss/ghidra-amiga`](https://github.com/BartmanAbyss/ghidra-amiga)** — loaders Hunk/`.uss`/ROM, símbolos NDK 3.9, **decompilador**.
- **Rizin 0.9.1** — disasm/xrefs (y `rz-ghidra` compilado en WSL como 2º decompilador).
- **Kickstart 1.3**, **Node.js** ≥ 18, **Python 3**, **JDK 21**.

---

## Documentación

### Marco

| Documento | Contenido |
|---|---|
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | Componentes, interfaces y flujo de datos |
| [`docs/PIPELINE.md`](docs/PIPELINE.md) | Flujo iterativo (instrumentar → trazar → inferir → validar) |
| [`docs/HIGS.md`](docs/HIGS.md) | Spec intermedia agnóstica de hardware (esquema + ejemplos) |
| [`docs/higs/`](docs/higs/README.md) | **JSON Schema** (`game.schema.json`), ejemplo y **lint** (`higs_lint.py`) |
| [`docs/REPO_LAYOUT.md`](docs/REPO_LAYOUT.md) | Estructura por plataforma + nodo de juego |
| [`docs/RESEARCH_FIRST.md`](docs/RESEARCH_FIRST.md) | Regla 0: documentación primero (recursos) |
| [`docs/EMULATORS.md`](docs/EMULATORS.md) | Cores por plataforma e instrumentación |
| [`docs/ROADMAP.md`](docs/ROADMAP.md) | Fases, hitos y riesgos del marco |
| [`docs/MIGRATION_AMIGA_REVERSE.md`](docs/MIGRATION_AMIGA_REVERSE.md) | Plan para portar «Arte» al layout del marco |
| [`docs/LEGAL.md`](docs/LEGAL.md) | ROMs propias, no redistribución, licencias |
| [`docs/adr/`](docs/adr/README.md) | ADRs (monorepo, libretro, HIGS, repo único) |

### Metodología y reglas (transversal)

| Documento | Contenido |
|---|---|
| [`STRUCTURE.md`](STRUCTURE.md) | Estructura canónica de un expediente, reglas y convenciones |
| [`LECCIONES_APRENDIDAS.md`](LECCIONES_APRENDIDAS.md) | Método reutilizable y trampas (§7bis: Ghidra/Rizin) |
| [`PORTING.md`](PORTING.md) | Del código recuperado al engine: C/C++ ref + ASM canónico + ABI |
| [`AGENTS.md`](AGENTS.md) | Directrices de trabajo |

### Expediente «Arte» (`platforms/computers/amiga500/demos/arte/`)

| Documento | Contenido |
|---|---|
| [`platforms/computers/amiga500/demos/arte/README.md`](platforms/computers/amiga500/demos/arte/README.md) | Estado, inventario y cómo reproducir |
| [`docs/ROADMAP.md`](platforms/computers/amiga500/demos/arte/docs/ROADMAP.md) | Fases, criterios de cierre, estado de efectos |
| [`docs/PENDIENTES.md`](platforms/computers/amiga500/demos/arte/docs/PENDIENTES.md) | Inventario vivo de trabajo abierto |
| [`docs/HALLAZGOS.md`](platforms/computers/amiga500/demos/arte/docs/HALLAZGOS.md) | Datos concretos con evidencia |
| [`docs/TECNICAS.md`](platforms/computers/amiga500/demos/arte/docs/TECNICAS.md) | Efecto a efecto + receta de reimplementación |
| [`docs/GHIDRA_AMIGA_EVAL.md`](platforms/computers/amiga500/demos/arte/docs/GHIDRA_AMIGA_EVAL.md) | Evaluación de Ghidra + extensión |
| [`docs/GHIDRA_DECOMP_VS_REIMPL.md`](platforms/computers/amiga500/demos/arte/docs/GHIDRA_DECOMP_VS_REIMPL.md) | Decompilado vs. reimpl y cross-check con rz-ghidra |
| [`docs/PORT_ENGINE_ZOOM_Y_TUNEL.md`](platforms/computers/amiga500/demos/arte/docs/PORT_ENGINE_ZOOM_Y_TUNEL.md) | Guía de port a un engine A500 50 Hz |
| [`tools/README.md`](platforms/computers/amiga500/demos/arte/tools/README.md) | Comandos exactos del expediente |
| [`recovered/maps/modules.md`](platforms/computers/amiga500/demos/arte/recovered/maps/modules.md) | Módulos, direcciones, tamaños, sha1 |

## Añadir un expediente nuevo

1. Copiar [`docs/templates/expediente/`](docs/templates/expediente/) a `<titulo>/` (o a `platforms/...` cuando se aplique el layout).
2. Rellenar `README.md` y `docs/ROADMAP.md` (fase 0 = extraer la imagen).
3. Añadir la spec en `specs/` y documentar los comandos del toolkit en `tools/README.md`.
4. Ir volcando: `out/` → revisar → promover a `recovered/` → reimplementar en `reimpl/`.
5. Añadir cada técnica a `docs/TECNICAS.md` con su receta de port. Reglas en [`STRUCTURE.md`](STRUCTURE.md).

## Licencia

- **Contenido propio** (marco, análisis, documentación, reimplementaciones y toolkit): **MIT** —
  ver [`LICENSE`](LICENSE).
- **Material de terceros** (binarios/assets originales en `platforms/computers/amiga500/demos/arte/recovered/`): **no** cubierto
  por la MIT; © de sus autores. Referencia de estudio. Ver [`docs/LEGAL.md`](docs/LEGAL.md).

Repositorio **privado** de uso personal.
