# Migración a la plataforma Amiga — estado

Reorganización, **dentro del mismo repositorio** ([ADR 0004](adr/0004-migracion-amiga-reverse.md)),
del expediente «Arte» como la plataforma **Amiga 500** del marco (ver
[`REPO_LAYOUT.md`](REPO_LAYOUT.md)).

## Fase 1 — Reubicación de nivel superior — HECHO

- `sanity-arte/` → `platforms/computers/amiga500/demos/arte/`
- `toolkit/` → `tools/` (marco)
- `_template/` → `docs/templates/expediente/`
- Metodología (`STRUCTURE.md`, `LECCIONES_APRENDIDAS.md`, `PORTING.md`, `AGENTS.md`) en la **raíz**
  como documentación del marco.
- Esqueleto creado: `platforms/{arcade,consoles,computers}/...`, `emulators/`, `frontend/`.
- Enlaces markdown reescritos y verificados (0 rotos) y `.gitignore` con rutas nuevas.

## Fase 2 — Reorganización interna del nodo — HECHO

El nodo «Arte» usa ya el **leaf node** del marco:

```
platforms/computers/amiga500/demos/arte/
  rom/                  raw/ (ADF, bootblock) · reference/ (SOS, © autores) · sanity.uae
  extraction/           disassembly/ · maps/ · screenshots/ · specs/
                        ram/ · modules/ · modules_all/ · display/ · screens/ · logs/ · ghidra/ · pp20/
  assets/               graphics/ · palettes/ · copper/ · text/ · audio/
  spec/                 HIGS (game.json + README)          <- nuevo
  reimplementation/     reference/ (C/C++ + ASM canónico) · SDL3 (esqueleto)  <- nuevo
  docs/                 ROADMAP · HALLAZGOS · TECNICAS · GHIDRA_* · PENDIENTES · RECOVERED · PORT_*
  tools/ · README.md
```

- Herramientas **específicas de Amiga** movidas a
  [`../platforms/computers/amiga500/tools/`](../platforms/computers/amiga500/tools/README.md);
  `tools/` (marco) queda genérico (`bin_scan`, `ollama_vision`, `ghidra/`).
- `hardware_spec` de Amiga creado (`../platforms/computers/amiga500/hardware_spec/`).
- HIGS de «Arte» creada (`demos/arte/spec/`) y **esqueleto SDL3** que solo lee `spec/` + `assets/`.

## Reglas

- **Un solo repositorio**; reorganización interna con `git mv` (conserva historia). **No** subtree ni
  submódulo.
- **Higiene**: excluir de git binarios de terceros y `extraction/` pesado; conservar `docs/`,
  `spec/`, `assets/` decodificados y `reimplementation/`.
- **No redistribuir** código/assets originales ([`LEGAL.md`](LEGAL.md)).

## Criterio de cierre

1. `demos/arte/{rom,extraction,assets,spec,reimplementation,docs}` con contenido reubicado y
   **enlaces válidos** — **HECHO**.
2. `demos/arte/README.md` reproduce los artefactos con comandos documentados — **HECHO**.
3. `spec/` (HIGS) + `reimplementation/` que **solo** lee `spec/` + `assets/` — **HECHO** (esqueleto;
   render real y validación **pendientes**).
4. El pipeline es el **mismo** que en las demás plataformas — **EN CURSO**.

## Pendiente (P2.3)

- **Render SDL3** real en `reimplementation/` (usando la HIGS).
- **Validación diferencial** vs emulador.
- Cargar la HIGS con una librería JSON (sustituir el lector naive).

Ver también [`ROADMAP.md`](ROADMAP.md) fase **P2**.
