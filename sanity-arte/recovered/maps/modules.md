# Módulos del demo — Sanity-Arte

Nombres extraídos de la tabla de SOS (Slow RAM ~`0xC037xx`). Direcciones/tamaños se rellenarán
cuando el volcado de módulos (`IMP!`) funcione; entonces se indexarán por `sha1`.

| Módulo | Tipo | Dirección | Tamaño | sha1 | Estado |
|---|---|---|---|---|---|
| `SINE.soslibrary` | librería (senos) | — | — | — | pendiente |
| `DBUG.soslibrary` | librería (debug) | — | — | — | pendiente |
| `mod.livin' insanity` | música | — | — | — | pendiente |
| `mod.elekfunk` | música | — | — | — | pendiente |
| `mod.mobyle` | música (Moby) | — | — | — | pendiente |
| `drwho96.raw` | gráfico | — | — | — | pendiente |
| `hloadpic.raw.im` | gráfico (imagen) | — | — | — | pendiente |
| `txt.Scrolltext` | texto scroll | — | — | — | pendiente |
| `SOSchaos1/2/3` | módulos SOS | — | — | — | pendiente |
| `lSOSloadmodule` | rutina de carga | — | — | — | pendiente |

## Bloques descomprimidos (hook `IMP!`)

Volcados con `toolkit/node/hook-trampoline.mjs` + `specs/imp-dump.json` (12 únicos, dedupe por
sha1). `dest` en Chip (`0x0`-`0x80000`) o Slow (`0xC00000`-`0xE00000`). Los buffers se reutilizan
(misma `dest` con distinto `len` = módulos distintos decodificados en el mismo hueco), por eso el
hook captura **cada** decodificación aunque el buffer se sobreescriba después.

| # | dest | len | entropía | pistas |
|---|---|---|---|---|
| 0 | `0xC5CBB2` | 114408 | 3.38 | contiene `sos.library` |
| 1 | `0x07B3C4` | 2428 | 1.96 | datos densos (tablas) |
| 2 | `0xC05EF2` | 26676 | 3.92 | `sos.library` |
| 3 | `0x026614` | 6108 | 0.35 | tablas/vacío (¿silencio?) |
| 4 | `0xC70212` | 34956 | 5.07 | `sos.library` |
| 5 | `0x07A6B4` | 5764 | 0.28 | tablas |
| 6 | `0xC05EF2` | 1152 | 5.35 | `sos.library` |
| 7 | `0x026614` | 102852 | 3.04 | grande (¿gráficos/música?) |
| 8 | `0xC706A2` | 33784 | 4.99 | `sos.library` |
| 9 | `0x07BBF4` | 324 | 3.07 | pequeño |
| 10 | `0xC05EF2` | 21100 | 4.86 | `sos.library` |
| 11 | `0x026614` | 332 | 3.03 | pequeño |

### Clasificación por cabecera

- **Código / librerías SOS** (empiezan `4E F9 00 00 00 10 4E F9 00 00 00 9A 73 6F 73 00` = dos
  `jmp` + `"sos"`): bloques **0, 2, 4, 6, 8, 10**.
- **Copperlists / datos de display** (empiezan con una lista `move.w` a `$dff08e/090/092/094/100…`):
  bloques **1, 3, 5, 7, 9, 11**. Decodificadas en `recovered/media/copper/*.copper.txt`
  (p. ej. `mod_003` = `BPLCON0=$5600` = 5 planos, `BPL1MOD=-40`; el demo parchea los punteros de
  bitplanes en runtime, por eso aparecen a 0 en la copia almacenada).
- El bloque **3 (`0x26614`)** es la Copperlist que aparecía en `COP1LC` en las capturas de display.

Ficheros en `out/modules/mod_<n>_<addr>_<len>.bin` + índice `out/modules/modules.json` (dest, len,
sha1). Identificación por módulo **pendiente** (cruzar con la tabla de nombres de SOS).

> Nota: algunos `dest` (p. ej. `0x26614`) coinciden con buffers reutilizados por varias cargas;
> conservar todos permite no perder los módulos que luego se sobreescriben.

## Nombres de la tabla de módulos SOS

Extraídos de la tabla en Slow RAM (aprox. `0xC036FA`–`0xC03ABA`); cada entrada tiene un prefijo
binario (con un tamaño aparente en 4 bytes) seguido de un nombre terminado en `\0`:

```
SINE.soslibrary   DBUG.soslibrary   mod.livin' insanity   SOSsab    SOStt   SOSfp   SOSgz
SOSdk   SOSspa   SOSst   SOSdt   SOSchaos1   SOSes   SOSloadmodule   mod.elekfunk   SOSeled
SOSls   SOScp   SOSb   SOSchaos3   SOSch   SOSchaos2   drwho96.raw   SOSman   SOSwl
SOSdig   SOSea   hloadpic.raw.im   main   mod.mobyle   txt.Scrolltext
```

- Los `SOS*` son módulos internos del sistema (cargadores, formatos/compresión, `chaos1..3`, etc.).
- Los assets del demo: `SINE.soslibrary` (senos), `mod.elekfunk` / `mod.livin' insanity` /
  `mod.mobyle` (música), `drwho96.raw` / `hloadpic.raw.im` (gráficos), `txt.Scrolltext`, `main`.
- **Pendiente**: mapear cada nombre a su dirección/tamaño (el prefijo de 10 B lleva un tamaño
  aparente en big-endian, aún por confirmar) y cruzarlo con los bloques volcados.

