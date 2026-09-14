# Arte (Sanity, 1993) — expediente de desensamblado

Plataforma: **Amiga 500 OCS/ECS** (Kickstart 1.3). Origen: `Sanity-Arte.dms`.
Objetivo: recuperar las **técnicas** del demo y reimplementarlas en C++ (`reimpl/`).

Estructura y reglas generales: [`../STRUCTURE.md`](../STRUCTURE.md).
Método reutilizable: [`../LECCIONES_APRENDIDAS.md`](../LECCIONES_APRENDIDAS.md).

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
sanity-arte/
  README.md
  docs/
    ROADMAP.md            fases, criterios de cierre, riesgos
    HALLAZGOS.md          datos concretos (direcciones, firmas, strings)
    TECNICAS.md           efecto a efecto + receta de reimplementación
  specs/
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
  reimpl/                 recreación en C++
```

Los scripts viven en el **toolkit compartido** [`../toolkit/`](../toolkit/README.md):

| Script | Uso |
|---|---|
| `toolkit/python/dms_unpack.py` | DMS -> ADF verificado (crc/checksum por pista) |
| `toolkit/python/bin_scan.py` | strings/entropía de ADF o volcado |
| `toolkit/node/dump-ram.mjs` | lanza WinUAE-DBG y vuelca regiones de RAM |
| `toolkit/node/hook-trampoline.mjs` | engancha el decruncher por firma y vuelca bloques |
| `toolkit/node/probe-breakpoints.mjs` | verifica que el stub aplica breakpoints |

## Cómo reproducir

```powershell
cd Amiga-Reverse\sanity-arte
python ..\toolkit\python\dms_unpack.py C:\Users\dvdjg\Downloads\Sanity-Arte.dms out\disk\sanity-arte.adf --verbose
node   ..\toolkit\node\dump-ram.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf --boot 20 --prefix sanity --screenshot
node   ..\toolkit\node\hook-trampoline.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf --spec specs\imp-dump.json --out out --boot 5
node   ..\toolkit\node\dump-display.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf --boot 21 --out out --prefix arte-title
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
