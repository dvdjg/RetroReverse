# Arte (Sanity, 1993) — expediente de desensamblado

Plataforma: **Amiga 500 OCS/ECS** (Kickstart 1.3). Origen: `Sanity-Arte.dms`.
Objetivo: recuperar las **técnicas** del demo y reimplementarlas en C++ (`reimplementation/reference/`).

**Objetivo confirmado**: el interés principal son las **técnicas gráficas** de la demo. El flujo es
comprender el ensamblador 68k extraído -> inferir los programas C++ más aproximados -> regenerar
una versión de alto nivel -> **volver a construir la misma demo desde el código fuente** en el
engine propio. El ensamblador se usa como fuente de conocimiento y solo para las partes críticas
si es imprescindible (detalle en `docs/ROADMAP.md`).

Estructura y reglas generales: [`../STRUCTURE.md`](../../../../../STRUCTURE.md).
Método reutilizable: [`../LECCIONES_APRENDIDAS.md`](../../../../../LECCIONES_APRENDIDAS.md).

## Estado

| Fase | Descripción | Estado |
|---|---|---|
| 0 | Extraer `.dms` -> `.adf` con herramienta propia validada | HECHO |
| 1 | Formato de disco y loader | HECHO |
| 2 | Arranque en WinUAE-DBG y volcado de RAM | HECHO |
| 3 | Volcado de módulos descomprimidos (`CrM!`/`CrM2` + `IMP!`) | HECHO (12 bloques) |
| 4 | Bucle principal y rutinas de efecto | EN CURSO |
| 5 | Assets (bitmaps, samples, copperlists) | EN CURSO |
| 6 | Desensamblado y documentación de algoritmos | PENDIENTE |

Detalle en [`docs/ROADMAP.md`](docs/ROADMAP.md).

## Estructura del expediente

```
platforms/computers/amiga500/demos/arte/
  README.md
  docs/
    ROADMAP.md            fases, criterios de cierre, riesgos
    HALLAZGOS.md          datos concretos (direcciones, firmas, strings)
    TECNICAS.md           efecto a efecto + receta de reimplementación
  extraction/specs/
    sanity-arte.json      spec de enganche del decruncher (para hook-trampoline.mjs)
  tools/
    README.md             comandos exactos para reproducir este expediente
  out/                    REGENERABLE
    disk/                 sanity-arte.adf, bootblock.bin
    ram/                  chip000000.bin, chip080000.bin, slowc00000.bin
    modules/              bloques descomprimidos + modules.json
    screens/              capturas
    logs/                 trazas
    sanity.uae            config del emulador
  recovered/              CURADO
    code/                 bootblock/, sos_cruncher/, <módulo>/
    media/                gfx/ audio/ copper/ palettes/ reference/
    maps/                 memoria, módulos, dispatch
  reimplementation/reference/                 recreación en C++
```

Los scripts viven en el **toolkit compartido** [`../tools/`](../../../../../tools/README.md):

| Script | Uso |
|---|---|
| `platforms/computers/amiga500/tools/python/dms_unpack.py` | DMS -> ADF verificado (crc/checksum por pista) |
| `tools/python/bin_scan.py` | strings/entropía de ADF o volcado |
| `platforms/computers/amiga500/tools/node/dump-ram.mjs` | lanza WinUAE-DBG y vuelca regiones de RAM |
| `platforms/computers/amiga500/tools/node/hook-trampoline.mjs` | engancha el decruncher por firma y vuelca bloques |
| `platforms/computers/amiga500/tools/node/probe-breakpoints.mjs` | verifica que el stub aplica breakpoints |

## Cómo reproducir

```powershell
python platforms\computers\amiga500\tools\python\dms_unpack.py C:\Users\dvdjg\Downloads\Sanity-Arte.dms platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --verbose
node   platforms\computers\amiga500\tools\node\dump-ram.mjs --config platforms\computers\amiga500\demos\arte\rom\sanity.uae --adf platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --boot 20 --prefix sanity --screenshot
node   platforms\computers\amiga500\tools\node\hook-trampoline.mjs --config platforms\computers\amiga500\demos\arte\rom\sanity.uae --adf platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --spec platforms\computers\amiga500\demos\arte\extraction\specs\imp-dump.json --out platforms\computers\amiga500\demos\arte\extraction --boot 5
node   platforms\computers\amiga500\tools\node\dump-display.mjs --config platforms\computers\amiga500\demos\arte\rom\sanity.uae --adf platforms\computers\amiga500\demos\arte\rom\raw\sanity-arte.adf --boot 21 --out platforms\computers\amiga500\demos\arte\extraction --prefix arte-title
```

Comandos exactos y notas en [`tools/README.md`](tools/README.md).

## Entorno

WinUAE-DBG x86 (`winuae-gdb.exe`) + `mcp-winuae-emu` (GDB `:2345`) + `KICK13.rom` +
`m68k-amiga-elf-objdump.exe`.

## Hallazgo principal

El disco **no es AmigaDOS**: trackloader propio que carga **SOS (Sanity Operating System) V2.4
R11** (©1992-93 Dierk Ohlerich / Chaos of Sanity). El demo es modular y usa el cruncher propio
`CrM!`/`CrM2`; el código se descomprime en runtime, por eso el análisis parte del volcado de RAM.
Detalle en [`docs/HALLAZGOS.md`](docs/HALLAZGOS.md).
