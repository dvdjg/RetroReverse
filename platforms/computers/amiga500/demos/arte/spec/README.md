# spec — HIGS de «Arte»

Especificación **agnóstica de hardware** del demo, construida desde
[`../docs/TECNICAS.md`](../docs/TECNICAS.md) y [`../docs/HALLAZGOS.md`](../docs/HALLAZGOS.md).
Es la entrada prevista de la reimplementación (ver
[`../../../../../docs/HIGS.md`](../../../../../docs/HIGS.md) y ADR 0003).

- Fichero: `game.json` (valida contra [`game.schema.json`](../../../../../docs/higs/game.schema.json)).
- Lint: `python docs/higs/higs_lint.py platforms/computers/amiga500/demos/arte/spec/game.json`.

## Contenido

| Bloque | Qué recoge |
|---|---|
| `mechanics.rules` | Reglas de los efectos: matemática Q15, zonas de vídeo, fade de paleta, doble buffer (con **confianza** y evidencia) |
| `entities` | Efectos con estados: `stars3d` (transform_q15), `zoom` (growing/shrinking) |
| `timing_sequences` | Bucle de frame: espera VBlank → paso de efecto → blit/swap |
| `assets` | Copperlists, gráficos, paletas y scrolltext decodificados (`assets/`) |
| `evidence` | Referencias a `docs/` y `extraction/maps/` |

## Pendiente

- Sustituir descripciones genéricas por **tablas exactas** (factores de zoom, tiempos por efecto)
  con evidencia (savestate + frame).
- Separar `state_machines/*.json` si crece.
- La **validación diferencial** (fase 7 de [`PIPELINE.md`](../../../../../docs/PIPELINE.md)) es la
  prueba de que la spec es suficiente.
