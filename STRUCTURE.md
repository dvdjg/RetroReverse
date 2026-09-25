# Estructura canónica de un expediente de reverse engineering

Esta estructura se aplica a **cualquier** volcado/desensamblado (demo, juego, módulo). El
objetivo final es siempre el mismo: recuperar **técnicas y media** y **reimplementarlas en C++**
en programas nuevos, dejando trazabilidad de dónde salió cada cosa.

```
<repo>/                                  marco RetroReverse + plataformas
  README.md                              README del marco
  STRUCTURE.md · LECCIONES_APRENDIDAS.md · PORTING.md · AGENTS.md   metodología
  docs/                                  documentación del marco (arquitectura, HIGS, adr/, templates/)
  tools/                                 utilidades reutilizables (antes `toolkit/`)
    node/  python/  ghidra/              biblioteca + CLIs + pipeline Ghidra
  scripts/                               validación (HIGS) y utilidades de repo
  conversion/                            conversión a plataformas destino (ADR 0005)
    <origen>-to-<destino>/               nodo (docs/, tools/, runtime/, examples/, generated/)
  platforms/                             plataformas → placa → [variante] → juego
    computers/amiga500/
      hardware_spec/                     custom chips (Agnus/Denise/Paula), 68000
      tools/                             herramientas específicas de Amiga
      demos/arte/                        expediente «Arte» (ver anatomía abajo)
      games/                             juegos Amiga futuros
    arcade/dedicated/namco_pacman/pacman/  nodo Pac-Man (vertical slice P0)
  emulators/ · frontend/                 fuentes y forks instrumentados (ver docs/EMULATORS.md)
```

## Anatomía de un nodo/expediente (`<game_id>/`)

```
<titulo>/
  README.md                 estado + inventario + cómo reproducir
  docs/                     documentación PROPIA del título
    ROADMAP.md              fases, estado, criterios de cierre, riesgos
    HALLAZGOS.md            datos concretos con evidencia (direcciones, firmas, formatos)
    TECNICAS.md             un apartado por efecto/técnica + receta de reimplementación
  tools/                    scripts HOST para reproducir extracción y volcado
  specs/                    specs de enganche (JSON) específicas del título
  out/                      TODO lo generado y REGENERABLE (no se cura, no es fuente de verdad)
    disk/                   imágenes extraídas (.adf/.bin del bootblock)
    ram/                    volcados de memoria (chip/slow/fast)
    modules/                bloques descomprimidos + modules.json
    screens/                capturas del emulador
    logs/                   trazas de los scripts
    ghidra/                 proyecto Ghidra + salidas (decompilado, xrefs, volcados) — regenerable
    <config>.uae            config de emulador usada
  recovered/                CURADO: lo que merece conservarse para reimplementar
    code/                    código recuperado, una carpeta por módulo/rutina
      <unidad>/
        <unidad>.asm         desensamblado (objdump con --adjust-vma)
        <unidad>.symbols     etiquetas y nombres inferidos
        notes.md             análisis, contrato de la rutina, entradas/salidas
        SOURCE               ruta + sha1 del binario de origen en extraction/modules/
    media/                   media recuperada y decodificada
      gfx/                   imágenes (PNG/ILBM) + paleta usada
      audio/                 samples (WAV) / módulos (MOD)
      copper/                copperlists decodificadas (.txt/.s)
      palettes/              paletas (.json/.pal)
      reference/             capturas de referencia por efecto
    maps/                    mapas y símbolos globales
      memory_map.md          regiones y qué contiene cada una
      modules.md             tabla de módulos, direcciones, tamaños, sha1
      dispatch.md            tabla de efectos -> rutina/estado
      symbols.json           símbolos para reensamblar/etiquetar
  reimpl/                   RECREACIÓN en C++ (objetivo final)
    <tecnica>/
      README.md              de qué código recuperado sale + cómo se porta
      src/*.cpp|*.hpp        implementación (host y/o Amiga)
      Makefile / notas de build
```

## Reglas

1. **`out/` es desechable**: se puede borrar y regenerar con `tools/`. Nunca es fuente de
   verdad. Guarda todo lo pesado y binario.
2. **`recovered/` es curado**: solo lo que un humano revisó y decidió conservar. Aquí sí se
   documentan direcciones, símbolos y notas. Puede citar binarios de `out/` con su `sha1` en vez
   de duplicarlos.
3. **`reimpl/` es el destino**: cada técnica recuperada se reescribe como algoritmo propio en
   C++. No se copia código ajeno; se porta la **idea** (ver `LECCIONES_APRENDIDAS.md` §8).
   El **contrato de técnica** (funcionamiento + C/C++ de referencia + **ASM canónico** + contrato
   de llamada/ABI + checklist) y su uso en el engine están en [`PORTING.md`](PORTING.md).
4. **Media**: se conserva en `recovered/media/` para referencia y comparación. No se redistribuye
   fuera del entorno de estudio (derechos del autor original).
5. **Una unidad = una carpeta** en `extraction/disassembly/`; el nombre de la carpeta es el nombre del
   módulo/rutina (`SINE_soslibrary`, `bootblock`, `cruncher_sos`, …).
6. **Trazabilidad**: todo artefacto curado indica su origen (`SOURCE` o el `sha1` en
   `modules.json`) y el comando de `tools/` que lo regenera.
7. **Herramientas en `tools/` (marco) y en `platforms/.../tools/` (plataforma)**: nada de scripts
   atados a un título. Las utilidades se parametrizan por CLI/spec y se documentan en
   `tools/README.md`; el expediente solo aporta su `specs/*.json` y su lista de comandos en el
   `tools/README.md` del nodo.
8. **Ghidra (análisis, no curación)**: Ghidra consume los volcados de `out/` (módulos
   descomprimidos de `extraction/modules/`, `.uss`/Hunk) y su salida va **siempre a `extraction/ghidra/`**:
   pseudo‑C, xrefs, volcados auxiliares y el proyecto. **No se cura** su salida (los nombres
   `FUN_xxxx` y la detección de funciones cambian entre versiones de Ghidra). Lo que merezca
   conservarse se resume a mano en `extraction/disassembly/<unidad>/notes.md` y `docs/TECNICAS.md`.
   Contrato: `extraction/modules/*.bin` → Ghidra → `reimpl/`. Ver `tools/ghidra/README.md` y
   `platforms/computers/amiga500/demos/arte/docs/GHIDRA_AMIGA_EVAL.md`.

## Convenciones de nombres

- Carpetas de unidad: sin espacios, `[A-Za-z0-9_]+`; los `.` de los módulos -> `_`.
- Ficheros de volcado: `<region><direccion>.bin` (p. ej. `chip000000.bin`, `slowc00000.bin`).
- Módulos: `mod_<n>_<addr>_<len>.bin` + entrada en `modules.json` (con `sha1`).
- Capturas: `<efecto>-<frame>.png`.
- Desensamblados: `<unidad>.asm`.

## Abrir un expediente nuevo

1. Copiar `docs/templates/expediente/` a `platforms/<categoría>/<plataforma>/.../<game_id>/`.
2. Rellenar `README.md` y `docs/ROADMAP.md` (fase 0 = extraer la imagen).
3. Añadir la spec en `specs/` y documentar los comandos en el `tools/README.md` del nodo
   (reutilizar `tools/` del marco, no crear scripts nuevos salvo necesidad real).
4. Ir volcando: `out/` -> revisar -> promover a `recovered/` -> reimplementar en `reimpl/`.
5. Añadir cada técnica a `docs/TECNICAS.md` con su receta de port.
