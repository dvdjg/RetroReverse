# Migración a la plataforma Amiga — estado

Reorganización, **dentro del mismo repositorio** ([ADR 0004](adr/0004-migracion-amiga-reverse.md)),
del expediente «Arte» como la plataforma **Amiga 500** del marco (ver
[`REPO_LAYOUT.md`](REPO_LAYOUT.md)).

## Fase 1 — Reubicación de nivel superior — HECHO

- `sanity-arte/` → `platforms/computers/amiga500/demos/arte/`
- `toolkit/` → `tools/` (marco)
- `_template/` → `docs/templates/expediente/`
- Metodología (`STRUCTURE.md`, `LECCIONES_APRENDIDAS.md`, `PORTING.md`, `AGENTS.md`) permanece en la
  **raíz** como documentación del marco.
- Esqueleto creado: `platforms/{arcade,consoles,computers}/...`, `emulators/`, `frontend/`.
- **Enlaces markdown reescritos y verificados** (0 rotos) y `.gitignore` con rutas nuevas.

## Fase 2 — Reorganización interna del nodo — PENDIENTE

El expediente conserva aún su layout propio (`docs/ specs/ tools/ out/ recovered/ reimpl/`). Falta
llevarlo al **leaf node** del marco:

| Dentro del nodo (`demos/arte/`) | Destino (leaf node) | Notas |
|---|---|---|
| `rom/raw/*.adf`, `bootblock.bin` | `rom/raw/` + `rom/layout.json` | «ROM» = imagen de disco; mapa en `layout.json` |
| `out/{ram,modules,modules_all,display,screens,logs,ghidra}` | `extraction/` | Evidencia pesada, regenerable |
| `extraction/disassembly/` | `extraction/disassembly/` | `.asm` + `notes.md` + `SOURCE` |
| `extraction/maps/` | `extraction/` + `hardware_spec/` | Mapa del juego vs del sistema |
| `recovered/media/{gfx,palettes,audio}` | `assets/` | Assets decodificados (no originales crudos) |
| `extraction/screenshots/*.png` | `extraction/screenshots/` | Capturas (evidencia visual) |
| `assets/text/` | `assets/text/` (o fuera de git) | Texto original (©); decidir |
| `rom/reference/sanity-os-v26/` | `rom/reference/` (o fuera de git) | Material de terceros (SOS); © autores |
| `reimpl/*` | `reimplementation/reference/` | **C/C++ de referencia + ASM canónico** |
| `specs/*.json` | `extraction/specs/` | Specs de enganche (extracción) |
| `docs/*.md` (recetas) | `docs/` + `spec/` (HIGS) | Parte se traduce a HIGS |
| **Nuevo** | `spec/` | HIGS de «Arte» (efectos/timings, agnóstico de hardware) |
| **Nuevo** | `reimplementation/` | SDL3, solo consume `spec/` + `assets/` |

Además (fase 2):

- Extraer a `platforms/computers/amiga500/tools/` las herramientas **específicas de Amiga**
  (`winuae-session`, `dump-ram`, `hook-trampoline`, `probe-*`, `launch/side/stop`, `dms_unpack`,
  `copper_decode`, `planar_decode`, `capture-live`, `AMIGA_BITMAPS.md`).
- Rellenar `platforms/computers/amiga500/hardware_spec/` (Agnus/Denise/Paula/68000, mapa de
  memoria, I/O).
- Crear `spec/` (HIGS) a partir de `docs/TECNICAS.md` y la `reimplementation/` SDL3.

## Reglas

- **Un solo repositorio**, reorganización interna con `git mv` (conserva historia). **No** subtree ni
  submódulo.
- **Higiene**: excluir de git binarios de terceros y `extraction/` pesado; conservar `docs/`,
  `spec/`, `assets/` decodificados y `reimplementation/`.
- **No redistribuir** código/assets originales ([`LEGAL.md`](LEGAL.md)).

## Criterio de cierre (fase 2)

1. `demos/arte/{rom,extraction,assets,spec,reimplementation,docs}` con contenido reubicado y
   **enlaces válidos**.
2. `demos/arte/README.md` reproduce los artefactos con comandos documentados.
3. Existe `spec/` (HIGS) y una `reimplementation/` SDL3 que **solo** lee `spec/` + `assets/`.
4. El pipeline es el **mismo** que en las demás plataformas.

Ver también [`ROADMAP.md`](ROADMAP.md) fase **P2**.
