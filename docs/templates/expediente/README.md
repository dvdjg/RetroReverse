# <Título> (<grupo/autor>, <año>) — expediente de desensamblado

Plataforma: <A500 OCS / A1200 AGA / ...>. Origen: <fichero .dms/.adf/.ipf>.

Objetivo: recuperar las **técnicas** del título y **reimplementarlas en C++** (`reimpl/`).

## Estado

| Fase | Descripción | Estado |
|---|---|---|
| 0 | Extraer imagen (`.dms`->`.adf`) y verificar | |
| 1 | Identificar formato/loader | |
| 2 | Arrancar en WinUAE-DBG y volcar RAM | |
| 3 | Volcar módulos descomprimidos | |
| 4 | Localizar bucle y rutinas de efecto | |
| 5 | Extraer assets | |
| 6 | Desensamblar y documentar | |

Ver `docs/ROADMAP.md` para el detalle y los criterios de cierre.

## Inventario

- `docs/` — ROADMAP, HALLAZGOS, TECNICAS.
- `tools/` — scripts host de extracción/volcado (base: `../platforms/computers/amiga500/demos/arte/tools/`).
- `out/` — artefactos regenerables (dumps, módulos, capturas, logs).
- `recovered/` — código/media/mapas curados.
- `reimpl/` — recreación en C++.

## Cómo reproducir

Ver `../STRUCTURE.md` y los comandos en `tools/`.
