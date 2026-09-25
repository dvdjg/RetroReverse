# Módulos del demo — Sanity-Arte

Directorios de módulos descifrados en `extraction/maps/sos_directory.json` (ver tabla debajo).
Cada bloque volcado en `extraction/modules/` sigue pendiente de asociación nombre↔sha1.

## Bloques descomprimidos (hook `IMP!`)

Volcados con `tools/node/hook-trampoline.mjs` + `extraction/specs/imp-dump.json` (12 únicos, dedupe por
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
  `jmp` + `"sos"`): bloques **0, 2, 4, 6, 8, 10**. Son **la misma `sos.library`** recargada en
  distintos destinos (los 6 primeros bytes son idénticos); difieren en tamaño = distintas
  versiones/extensiones (mod_4 = 34956 B es la más completa). Confianza **alta** (mismo header,
  mismos vectores Exec).
- **Bloques de datos de display** (1, 3, 5, 7, 9, 11): NO son copperlists puras. Empiezan con un
  **byte de cabecera** (`0x1A`/`0x08`/`0x10`/`0x1D` = nº de líneas o contador) seguido de una
  instrucción Copper `01 ff fe` (WAIT fin) y 2-4 MOVE iniciales a `$dff08e/090/092/094/100`, pero
  el resto del bloque son **datos** (solo 0-2% de copper moves). Confianza **media**: el inicio es
  claramente una Copperlist corta de configuración, pero el cuerpo son datos de efecto
  (bitplanes/tablas/música) no listas de Copper. **La clasificación previa como copperlist era
  incorrecta** y se corrige aquí.
  - `mod_001` (0x07B3C4, 2428 B): cabecera `0x1A`; inicio `DIWSTRT=$2981 DIWSTOP=$29C1
    DDFSTRT=$38 DDFSTOP=$D0 BPLCON0=$5200` (5 planos, mod 0).
  - `mod_003` (0x26614, 6108 B): cabecera `0x08`; `BPLCON0=$5600` (5 planos), `BPL1MOD=$FFD8
    (=-40)`, `BPL2MOD=$FFD8`. Es la lista que aparecía en `COP1LC`.
  - `mod_005` (0x07A6B4, 5764 B): cabecera `0x10`; `DDFSTRT=$50 DDFSTOP=$B8` (≈360 px), 5 planos.
  - `mod_007` (0x26614, 102852 B): cabecera `0x1D`; bloque **mixto** — 392 copper moves dispersos
    + 23 WAIT-fín (listas encadenadas) + datos. Candidato al buffer del efecto principal
    (título/corridor). Confianza media.
  - `mod_009`/`mod_011` (324/332 B): pequeños, cabecera `0x10`; fragmentos.
- El bloque **3 (`0x26614`)** es la Copperlist que aparecía en `COP1LC` en las capturas de display.

Ficheros en `extraction/modules/mod_<n>_<addr>_<len>.bin` + índice `extraction/modules/modules.json` (dest, len,
sha1). Identificación por módulo **pendiente** (cruzar con la tabla de nombres de SOS).

> Nota: algunos `dest` (p. ej. `0x26614`) coinciden con buffers reutilizados por varias cargas;
> conservar todos permite no perder los módulos que luego se sobreescriben.

## Directorio SOS (nombre → dirección/tamaño)

La tabla de módulos se confirmó **en el disco** (ADF) y **en RAM** (copia en runtime). Formato por
entrada (32 bytes):

| | ADF (disco) | RAM (copia) |
|---|---|---|
| base | track 1 `0x2C00` (32 entradas: `loader` + 31 módulos) | `0xC036D2` (raw `loader`) y `0xC036F0`+ (módulos) |
| prefijo | 8 B | 10 B |
| campos | `track` word BE + `offset` word LE + `size` long BE | `track` long BE + `offset` word LE + `size` long BE |
| nombre | en `+0x08` | en `+0x0A` |

Referencias al puntero `0xC036D2` en código residente: `0xC0300A` y `0xC03634`.

**Semántica** (verificada por consistencia RAM↔ADF y plausibilidad):
- `track` / `offset`: posición del módulo crunched en el disco (track + desplazamiento LE en
  bytes dentro del track). Los `SOS*` van en tracks correlativos ~0–13 (el boot/loader y el
  directorio ocupan tracks 0–1); hay gaps (tracks 6 y 12) → igualmente válidos.
- `size`: **tamaño descomprimido** en bytes. Evidencia: `drwho96.raw` = `9216` = 96×96 exacto
  (imagen raw `drwho96`), `txt.Scrolltext` = 2502, los `mod.*` de música son los mayores
  (138394/99114/89876).

Mapa completo: `extraction/maps/sos_directory.json`.

| # | Módulo | RAM | track | offset | size (descomp.) |
|---|---|---|---|---|---|
| 0 | `SINE.soslibrary` | `0xC036F0` | 0 | 72 | 1260 |
| 1 | `DBUG.soslibrary` | `0xC03710` | 0 | 78 | 1236 |
| 2 | `mod.livin' insanity` | `0xC03730` | 0 | 84 | 99114 |
| 3 | `SOSsab` | `0xC03750` | 1 | 216 | 15816 |
| 4 | `SOStt` | `0xC03770` | 2 | 22 | 21212 |
| 5 | `SOSfp` | `0xC03790` | 2 | 106 | 47176 |
| 6 | `SOSgz` | `0xC037B0` | 3 | 36 | 12404 |
| 7 | `SOSdk` | `0xC037D0` | 3 | 86 | 21640 |
| 8 | `SOSspa` | `0xC037F0` | 3 | 172 | 35344 |
| 9 | `SOSst` | `0xC03810` | 4 | 56 | 19680 |
| 10 | `SOSdt` | `0xC03830` | 4 | 134 | 13432 |
| 11 | `SOSchaos1` | `0xC03850` | 4 | 188 | 15004 |
| 12 | `SOSes` | `0xC03870` | 4 | 248 | 18284 |
| 13 | `SOSloadmodule` | `0xC03890` | 5 | 64 | 1132 |
| 14 | `mod.elekfunk` | `0xC038B0` | 5 | 70 | 138394 |
| 15 | `SOSeled` | `0xC038D0` | 7 | 100 | 9680 |
| 16 | `SOSls` | `0xC038F0` | 7 | 138 | 22744 |
| 17 | `SOScp` | `0xC03910` | 7 | 228 | 11960 |
| 18 | `SOSb` | `0xC03930` | 8 | 20 | 39904 |
| 19 | `SOSchaos3` | `0xC03950` | 8 | 176 | 16940 |
| 20 | `SOSch` | `0xC03970` | 8 | 244 | 30160 |
| 21 | `SOSchaos2` | `0xC03990` | 9 | 106 | 2776 |
| 22 | `drwho96.raw` | `0xC039B0` | 9 | 118 | 9216 |
| 23 | `SOSman` | `0xC039D0` | 9 | 154 | 41460 |
| 24 | `SOSwl` | `0xC039F0` | 10 | 60 | 4768 |
| 25 | `SOSdig` | `0xC03A10` | 10 | 80 | 33988 |
| 26 | `SOSea` | `0xC03A30` | 10 | 214 | 5524 |
| 27 | `loadpic.raw.im` | `0xC03A50` | 10 | 236 | 7784 |
| 28 | `main` | `0xC03A70` | 11 | 12 | 53956 |
| 29 | `mod.mobyle` | `0xC03A90` | 11 | 224 | 89876 |
| 30 | `txt.Scrolltext` | `0xC03AB0` | 13 | 64 | 2502 |

**Cruce provisional con bloques volcados (por tamaño descomprimido)**: `SOSdig` ≈ `mod_8`
(33988 vs 33784) y `SOStt` ≈ `mod_10` (21212 vs 21100). Queda **pendiente** confirmar leyendo la
rutina `SOSloadmodule` (cómo usa la tabla, incluyendo la semántica física de `track`/`offset`) y
asociar el resto de bloques.

## Clasificación final de los 41 bloques IMP! del ADF

Los 41 bloques descomprimidos (`extraction/modules_all/`) se clasifican así (mapa completo en
`extraction/modules_all/index.json`):

| Clase | Bloques | Qué son |
|---|---|---|
| **sos.library (código)** | 0x02162C, 0x026A2C, 0x03242C, 0x03562C, 0x04382C, 0x04862C, 0x04BC28, 0x078A2C, 0x07E42C, 0x08B028, 0x096A28, 0x099A2C, 0x0A3C2C, 0x0A502C, 0x0B0C2C, + pequeños | runtime SOS (OS) + motores de efecto embebidos |
| **copper+datos** | 0x01DDE8, 0x03AFFC, 0x0ADB04, 0x076844, 0x0ACE9C + pequeños | copperlist compacta + datos de efecto (texturas/tablas) |
| **datos** | 0x00455C, 0x04EFE8, 0x08E91C, 0x0973D0 | tablas |
| **display-data** | 0x09A940 | buffer de display (plasma) |
| **IFF** | (ninguno confirmado) | — |

Nota: todos los bloques de código son **variantes de sos.library** (mismo header jmp+"sos"),
cada una con un subconjunto distinto de rutinas. El motor 3D está en 0x0B0C2C, el scrolltext en
0x02162C, el fade en 0x0B0C2C.

## Asociación bloque IMP! del ADF ↔ módulo volcado (12/12 confirmado)

Cada bloque IMP! del disco tiene un header con `l1` (tamaño descomprimido) y `l2` (tamaño
comprimido) tras la firma `IMP!`. El hook de runtime capturó `len` de cada descompresión; la
coincidencia `l1 == len(hook)` es **exacta en 12/12** módulos:

| mod_ | len (hook) | bloque ADF (l1) | track | l2 (comprimido) |
|---|---|---|---|---|
| 0 | 114408 | `0x026A2C` | 14 | 46218 |
| 1 | 2428 | `0x03201C` | 18 | 480 |
| 2 | 26676 | `0x03242C` | 18 | 11362 |
| 3 | 6108 | `0x0352F0` | 19 | 312 |
| 4 | 34956 | `0x03562C` | 19 | 20676 |
| 5 | 5764 | `0x03A93C` | 21 | 258 |
| 6 | 1152 | `0x03AC2C` | 21 | 676 |
| 7 | 102852 | `0x03AFFC` | 21 | 34250 |
| 8 | 33784 | `0x04382C` | 24 | 18670 |
| 9 | 324 | `0x0483D4` | 26 | 194 |
| 10 | 21100 | `0x04862C` | 26 | 11754 |
| 11 | 332 | `0x04B968` | 27 | 198 |

- **41 bloques IMP!** en total en el ADF (mapa completo en `extraction/maps/imp_blocks.json`).
- **`l1` = tamaño descomprimido** (confirma la interpretación del `size` del directorio SOS);
  `l2` = tamaño del stream comprimido.
- Los tracks de los bloques (14, 18, 19, 21, 24, 26, 27, …) **no coinciden con los `track` del
  directorio** (0–13): el `track`/`offset` del directorio NO es la posición física del bloque IMP!.
  La posición real es la de los bloques IMP! (tabla de `imp_blocks.json`). La semántica de
  `track`/`offset` del directorio sigue **pendiente** (podría ser un índice lógico del loader).

