# Migración: `Amiga-Reverse` → subproyecto Amiga del marco

Plan para **reorganizar, dentro del mismo repositorio** (ADR 0004), el expediente «Arte» como la
plataforma **Amiga 500** del marco. No se pierde nada: el contenido se reubica con `git mv` según
[`REPO_LAYOUT.md`](REPO_LAYOUT.md) y la **metodología** se promueve a documentación del marco.

## 1. Qué es hoy `Amiga-Reverse`

```
Amiga-Reverse/
  README.md · STRUCTURE.md · LECCIONES_APRENDIDAS.md · PORTING.md · AGENTS.md
  toolkit/           node/ python/ ghidra/          (utilidades)
  _template/         esqueleto de expediente
  sanity-arte/       el expediente (demo «Arte»)
    README.md · docs/ · specs/ · tools/ · out/ · recovered/ · reimpl/
```

Convención interna: `out/` (regenerable) · `recovered/` (curado) · `reimpl/` (destino C++).
Ya implementa buena parte del pipeline (DMS→ADF, WinUAE-DBG+GDB+canal lateral, hook de
decrunchers, Ghidra, reimpl C++ con tests, docs con confianza + evidencia).

## 2. Clasificación en el marco

Amiga 500 es **`computers`** (no arcade/consola). «Arte» es una **demo**, no un juego; se propone
un directorio `demos/` junto a `games/`:

```
platforms/computers/amiga500/
├── hardware_spec/          # Agnus/Denise/Paula/68000, mapa de memoria, I/O
├── tools/                  # tooling ESPECÍFICO de Amiga (WinUAE-DBG, GDB, DMS, planar/copper)
├── demos/arte/             # <- sanity-arte migra aquí
└── games/                  # juegos AmigaDOS futuros
```

(Para un juego AmigaDOS, `demos/` sería `games/<id>/`.)

## 3. Mapa de reubicación

| `Amiga-Reverse` | Destino | Notas |
|---|---|---|
| `STRUCTURE.md`, `LECCIONES_APRENDIDAS.md`, `PORTING.md`, `AGENTS.md` | `docs/methodology/` del **marco** | Método transversal, no del juego |
| `_template/` | `docs/templates/expediente/` | Plantilla del marco |
| `toolkit/node/winuae-session.mjs`, `dump-ram`, `hook-trampoline`, `probe-*`, `launch/side/stop` | `platforms/computers/amiga500/tools/` | Específico de Amiga |
| `toolkit/python/dms_unpack.py`, `copper_decode.py`, `planar_decode.py`, `AMIGA_BITMAPS.md` | `platforms/computers/amiga500/tools/` | Específico de Amiga |
| `toolkit/python/bin_scan.py`, `ollama_vision.py`, `toolkit/ghidra/*` | `tools/` del **marco** | Reutilizable multi-plataforma |
| `toolkit/capture-live.ps1` | `platforms/computers/amiga500/tools/` | Específico de WinUAE |
| `sanity-arte/out/disk/*.adf`, `bootblock.bin` | `demos/arte/rom/raw/` + `rom/layout.json` | «ROM» = la imagen de disco; documentar el mapa |
| `sanity-arte/out/{ram,modules,modules_all,display,screens,logs,ghidra}` | `demos/arte/extraction/` | Evidencia pesada, regenerable |
| `sanity-arte/recovered/code/` | `demos/arte/extraction/disassembly/` | `.asm` + notes + SOURCE |
| `sanity-arte/recovered/maps/` | `demos/arte/extraction/` + `hardware_spec/` | Mapa de memoria del juego vs del sistema |
| `sanity-arte/recovered/media/gfx|palettes|audio` | `demos/arte/assets/` | Assets decodificados (no originales crudos) |
| `sanity-arte/recovered/media/reference/*.png` | `demos/arte/extraction/screenshots/` | Capturas (evidencia visual) |
| `sanity-arte/recovered/reference/sanity-os-v26/*` | **fuera de git** (o `rom/reference/` local) | Material de terceros (SOS); © autores |
| `sanity-arte/recovered/scrolltext/*` | `demos/arte/assets/text/` (o fuera de git) | Texto original (©); decidir |
| `sanity-arte/docs/{ROADMAP,HALLAZGOS,TECNICAS,GHIDRA_*,PENDIENTES}.md` | `demos/arte/docs/` | Docs del juego |
| `sanity-arte/docs/*.md` con recetas de port | `demos/arte/docs/` + `spec/` (HIGS) | Se traducen a HIGS |
| `sanity-arte/reimpl/*` | `demos/arte/reimplementation/reference/` | **C/C++ de referencia + ASM canónico** |
| `sanity-arte/specs/*.json` | `demos/arte/extraction/specs/` | Specs de enganche (extracción) |
| **Nuevo**: HIGS de «Arte» | `demos/arte/spec/` | Mecánicas/efectos/timings agnósticos |
| **Nuevo**: reimpl SDL3 | `demos/arte/reimplementation/` | Solo consume `spec/` + `assets/` |
| `sanity-arte/tools/README.md` (comandos) | `demos/arte/README.md` | Cómo reproducir |

## 4. Pasos de migración (mecánicos)

1. **Crear el esqueleto** del marco y la plataforma (`platforms/computers/amiga500/{hardware_spec,
   tools,demos,}`) y `tools/` genérico.
2. **Metodología primero**: mover `STRUCTURE.md`, `LECCIONES_APRENDIDAS.md`, `PORTING.md` a
   `docs/methodology/` y adaptar los enlaces internos.
3. **Toolkit**: separar genérico (`tools/`) de Amiga (`…/amiga500/tools/`). Ver tabla §3.
4. **Nodo «Arte»**: mover `sanity-arte/` → `demos/arte/` reorganizando por `rom/ extraction/
   assets/ spec/ reimplementation/ docs/`.
5. **Higiene**: excluir de git los binarios de terceros y los `extraction/` pesados (`.gitignore`
   por juego); conservar `docs/`, `spec/`, `assets/` decodificados y `reimplementation/`.
6. **Reescribir rutas/enlaces** (markdown) y actualizar `README.md` del juego con los comandos.
7. **HIGS**: crear `spec/` para «Arte» a partir de `TECNICAS.md` (efectos, timings por frame,
   tablas) — ver [`HIGS.md`](HIGS.md).
8. **Reimpl SDL3**: nueva carpeta que consume `spec/` + `assets/`; los `reimpl/*` actuales quedan
   como **referencia de port** (C++ + ASM canónico).
9. **Validación**: regenerar los artefactos del nodo con los comandos documentados y comprobar que
   los enlaces/CI pasan.

### Repositorio único (decisión: ADR 0004)

No hay que fusionar repos: **ya es un solo repositorio**. La migración es **reorganización interna**
con `git mv` (conserva la historia) + reescritura de enlaces. **No** se usa subtree ni submódulo.

## 5. Qué NO cambia

- El **método** (asm → comprensión → doc → reimpl; `out/` regenerable, `recovered/` curado,
  `reimpl/` destino; confianza + evidencia) — se **promueve**, no se reescribe.
- El **ASM canónico** y las rutinas optimizadas como referencia de port.
- La **regla legal**: no redistribuir código/assets originales.

## 6. Riesgos y mitigación

| Riesgo | Mitigación |
|---|---|
| Enlaces rotos tras mover | script de reescritura + verificación de enlaces (como el del README) |
| Perder historial | usar subtree/submódulo, no copia |
| Confundir `extraction/` (evidencia) con `spec/` (HIGS) | `.gitignore` + reglas; HIGS **nunca** cita direcciones de memoria |
| Mezclar reimpl de referencia (C++) con reimpl SDL | carpetas distintas: `reimplementation/reference/` vs `reimplementation/` (SDL) |
| Material de terceros en repo público | repo **privado** (actual) y excluir binarios/assets originales |
| «Big bang» que rompe todo | migración por fases (metodología → toolkit → nodo) con validación por fase |

## 7. Criterio de cierre

La migración está hecha cuando:

1. `platforms/computers/amiga500/{hardware_spec,tools}/` y `demos/arte/` existen con el contenido
   reubicado y **enlaces válidos**.
2. `demos/arte/README.md` reproduce los artefactos con comandos documentados.
3. Existe `demos/arte/spec/` (HIGS) y una `reimplementation/` SDL3 que **solo** lee `spec/`+`assets/`.
4. El pipeline es el **mismo** que en las demás plataformas (segundo juego sin tocar el núcleo).

Ver también [`ROADMAP.md`](ROADMAP.md) fase **P2**.
