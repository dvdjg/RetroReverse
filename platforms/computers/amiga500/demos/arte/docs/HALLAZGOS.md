# Hallazgos — «Arte» (Sanity, 1993)

Datos concretos obtenidos del expediente. Todo con evidencia reproducible.

## Imagen DMS

- Fichero: `Sanity-Arte.dms` (812978 B).
- Cabecera: firma `DMS!`, versión **2.04** (ParCon). `geninfo=0x0081` (registrado + NoZero,
  **sin cifrado**).
- Pistas 0..79, `pkfsize=811322`, `unpkfsize=901120`.
- `disktype=1` (AmigaOS 1.0 OFS), `cmode=6` (HEAVY2 como modo dominante).
- Todas las pistas usan `cmode=6`; los flags varían (`0x01`, `0x03`, `0x05`, `0x07`) para
  reutilizar/reiniciar el diccionario y activar/desactivar árboles y RLE.

## Disco / loader

- **No es AmigaDOS**: no existe root block válido (ningún bloque con `type==2`).
- Bootblock con nombre `SOS1`; strings: `trackdisk.device`, `graphics.library`.
- Bootblock estándar de arranque que limpia memoria y salta al loader por pistas.
- Entropía por pista: 0-1 ≈ 6.4-6.7 (código SOS), 2-79 ≈ 7.3-7.7 (payload comprimido).

## Sistema operativo del demo

- **SOS — Sanity Operating System V2.4 Release 11**, `(c)1992-1993 by Dierk Ohlerich (Chaos of Sanity)`.
- Strings del kernel (en RAM, Slow 0xC02B6D): `**** SOS System Error Nr $…`,
  `Memory found and utilised:`, `exeption #$`, `end of programm.`, `illegal tag`, etc.
- Cruncher propio: firmas **`CrM!`** (0x43724D21) y **`CrM2`** (0x43724D32).

## Módulos / ficheros referenciados

Nombres encontrados en la tabla de SOS (Slow RAM ~0xC037xx):
```
SINE.soslibrary    DBUG.soslibrary    sos.library (chip 0x1AF9)
*mod.livin' insanity   mod.elekfunk   mod.mobyle
drwho96.raw        hloadpic.raw.im    txt.Scrolltext
SOSchaos1  SOSchaos2  SOSchaos3       lSOSloadmodule
```
Créditos en claro (Slow ~0xC0292x): `Mr. Pet`, `Chaos`, `McDeal`, `Graphics: Moby`, `Music: Moby`,
`One Disk!`, `No AGA needed!`.

## RAM volcada (WinUAE-DBG, A500 OCS, KS1.3, 512K chip + 512K slow)

- `out/chip000000.bin` (512K), `out/slowc00000.bin` (512K), `out/chip080000.bin` (mirror/no mapeado).
- 0 fallos de lectura. `out/shot-boot.png` = pantalla de título del demo (imagen del monstruo
  con el rótulo `arte`).
- Registros al congelar: PC ≈ `0xC0256A` (**dentro del de-cruncher de SOS**), SR=0.

### Trampoline de decrunch SOS

- Dirección en RAM: `0xC02584`.
- Patrón de bytes (para localizarlo por firma en cualquier ejecución):
  `48 E7 FF FE 20 18 4B FA 00 26 B0 BC 43 72 4D 21 67 0C 4B FA 01 12 B0 BC 43 72 4D 32 66 0A 4A 58 22 18 24 18 24 48 4E 95`.
- Estructura:
  - `movem.l d0-a6,-(sp)`
  - `move.l (a0)+,d0` y comparación con `'CrM!'` / `'CrM2'`.
  - Salta al de-cruncher: `CrM!` -> `0xC025B2` (+0x2E), `CrM2` -> `0xC026AA` (+0x126).
  - `tst.w (a0)+` ; `move.l (a0)+,d1` (longitud destino) ; `move.l (a0)+,d2` (longitud comprimida) ;
    `movea.l a0,a2` ; `jsr (a5)`.
  - Contrato: al entrar, **`A1` = dirección destino** (lo fija el llamador).
- El de-cruncher descomprime **hacia atrás** (`move.b -(a2),-(a4)`) — LZ + Huffman.

## Dos crunchers distintos (hallazgo clave)

El demo pasa la mayor parte del tiempo en un cruncher **`IMP!`**, no en el `CrM!`:

- **`CrM!`/`CrM2`** — rutina en `0xC025B2` / `0xC026AA`, llamada desde el trampoline `0xC02584`.
  Formato con cabecera `'CrM!'`/`'CrM2'`.
- **`IMP!`** — rutina en `0xC02426` (`movem.l d2-d5/a2-a4,-(sp); movea.l a0,a3; movea.l a0,a4;
  cmpi.l #'IMP!',(a0)+`, opcode `0x494D5021`). Tras la firma hay **dos long big-endian**
  (probables tamaños: descomprimido y comprimido), p. ej. en Chip RAM `0x1690`: `len1=0x97C`,
  `len2=0x1E0`, y en `0x1AA0`: `len1=0x6834`, `len2=0x2C62`. Es el que se usa durante la carga
  de módulos; su layout exacto (dónde escribe) está **pendiente de determinar** con un sondeo
  antes/después.
- Firma del trampoline CrM! (para localizarlo por bytes):
  `48E7FFFE20184BFA0026B0BC43724D21…`.

## Breakpoints del stub

- Verificado con `platforms/computers/amiga500/tools/node/probe-breakpoints.mjs`: el stub **sí aplica `Z0`** y devuelve
  `T05swbreak:;` (confirmado en `0xC0255A`, dentro del bucle `IMP!`).
- `pause()` (interrupt `0x03`) puede tardar; usar reintentos.

## Contrato de `IMP!` (resuelto)

- `probe-layout.mjs` (diff de RAM antes/después de una sola llamada) determinó que `IMP!` escribe
  en **`[A0, A0 + long(A0+4))`**, donde `A0` = puntero a la cabecera `'IMP!'`. Ejemplo capturado:
  cabecera `0x07B3C4`, `len1=0x97C`.
- El hook en modo routine (`extraction/specs/imp-dump.json`) volcó **12 bloques únicos** a `extraction/modules/`
  (ver `extraction/maps/modules.md`).

## Estado de vídeo

- **La lectura en vivo de registros custom no es fiable** (ni por GDB ni por el canal lateral):
  `BPLCON0` se ha visto como `0x0200`, `0x4000` y `0x5600`; `COP1LC` como `0x66`, `0x26614`;
  `BPL1PT` como `0x43`, `0x3A600`, `0x39C2A`. Reflejan la **zona instantánea** del Copper.
- `0x26614` es también **destino de un módulo** (`mod_003/007/011`): al leerlo como "Copperlist" se
  obtiene a veces código, no una lista. No usar esa lectura como verdad.
- Primera captura (candidata): Copperlist coherente con `BPLCON0=0x5600` (5 planos), `DIW=$5981`,
  `COLOR00..`; guardada en `assets/copper/` marcada como **no verificada**.
- **No leer `$DFF1C0+` en OCS/ECS**: error y posible caída del emulador.
- Referencia fiable del aspecto: `extraction/screenshots/arte-title-screenshot.png`.
- El **canal lateral** (`platforms/computers/amiga500/tools/node/side-read.mjs`) sí es fiable para `state`/`regs`/`mem` de RAM.
- Reconstruir un frame desde los registros en vivo falla por los **splits de Copper** (cambian
  `BPLCON0`/punteros por zonas): un rango contiguo no reconstruye la imagen. La **captura de
  pantalla** es la referencia fiable; para los planos fuente habría que emular el Copper.
- Flujo corregido: el emulador se lanza **una vez** (`launch.mjs`) y se reutiliza por canal
  lateral (`side.mjs`); no relanzar por experimento. Trampa: el canal parsea números en base 10
  salvo `0x`; enviar siempre `0x`.

## Pendiente de confirmar

- Identificar módulo ↔ bloque (cruzar con la tabla de nombres de SOS).
- Tabla de dispatch de módulos (qué módulo = qué efecto).
- Capturar una Copperlist **activa** (no de blanqueo) para decodificar el título a PNG.

## Tabla de módulos y efectos

- Lista completa de nombres extraída de la tabla SOS (Slow RAM `0xC036FA`–`0xC03ABA`):
  ver [`../extraction/maps/modules.md`](../extraction/maps/modules.md). Incluye `SINE.soslibrary`,
  `DBUG.soslibrary`, `mod.*` (música), `drwho96.raw` / `hloadpic.raw.im` (gráficos), `txt.Scrolltext`,
  `main` y varios módulos internos `SOS*`.
- Los bloques volcados se clasificaron en **código SOS** y **Copperlists** (mismo doc).
- Referencias visuales capturadas (timing variable): `extraction/screenshots/`
  (título `arte-title-screenshot.png`, efecto 3D de pasillo `arte-effect-corridor.png`).
- **Captura en vivo del corridor** (2026): el bloque `0x03AFFC` (el túnel/corridor) **se carga en
  chip RAM `0x26614`** (paleta en `0x2675A` = `+0x146`); el efecto **parchea la Copperlist en
  runtime** copiando los 32 colores. Referencias: `reference/corridor-live.png` (corridor) y
  `reference/sphere-live.png` (esfera). Detalle y **límite** (mapa del original no recuperado) en
  `assets/palettes/tunnel-VALIDACION.md`.

## Análisis con Ghidra (2026)

Evaluación completa en [`GHIDRA_AMIGA_EVAL.md`](GHIDRA_AMIGA_EVAL.md) y
[`GHIDRA_DECOMP_VS_REIMPL.md`](GHIDRA_DECOMP_VS_REIMPL.md); herramienta en
[`../../tools/ghidra/`](../../../../../../tools/ghidra/README.md). Salidas en `extraction/ghidra/` (regenerables).

- **Loaders**: Ghidra 12.0.1 + extensión `ghidra-amiga` cargan **Hunk** y **`.uss`** y resuelven
  las llamadas a librería con símbolos **NDK 3.9**. `out/disk` **no contiene Hunk** (trackloader);
  probado con `SOS_RUN`/`SOS_HYB` (runtime SOS) y `demoscene-repo/effects/empty.exe`.
- **`.uss`**: verificada la base de `mod_002` **`0xC05EF2`** contra
  `extraction/disassembly/sos_library/mod_2_soslibrary.asm` → coincide instrucción a instrucción; las
  únicas diferencias son **reubicaciones** (`jmp $10` → `jmp $C05F02`). Los `.uss` capturados en
  *boot* no contienen los módulos; hay que exportarlos **con el efecto cargado**.
- **Motor 3D** (`blk_0B0C2C`, base 0): el decompilado de `0xC16` (matriz) y `0xCBA` (transform)
  coincide **término a término** con `reimplementation/reference/motor_3d`. Tablas Q15 en **`0x1056`** (senos) y
  **`0x1256`** (cosenos), 256 words cada una, indexadas por `ángulo & 0x7fe`; `0x1056` crece
  `0,201,402,603…` (compatible con un **cuarto de seno**). La **matriz ortonormal** (`0x0E1E` +
  raíz entera `0x0F1C`) se ha **portado** a `reimplementation/reference/motor_3d` (`orthonormalize`, test OK).
- **Zoom** (`blk_07E42C`, base 0): el decompilado (`FUN_0000024c`/`FUN_000002d4`) **confirma**
  `ALGORITMOS_ZOOM_Y_TUNEL.md` y añade un detalle: la trayectoria **parchea la Copperlist por
  bandas** (`BPLCON0=0x200`/`0x5200`, stride 20 B) para el recorte vertical. **Núcleo portado** a
  `reimplementation/reference/zoom` (`zoom_step`/`traj_step`/`copper_bands`, test OK); blit/copper pendientes.
- **Túnel** (`blk_03AFFC`): **0 funciones** → es datos (Copperlist + paleta `@0x146` + datos), no
  el render. En `arte tunnel stars.uss` el buffer está en `0x26614` (61.4 % match); el puntero es
  `0xC0454E` y lo fija el **init** `FUN_00c0424a` (`0xC0424A`, reserva 350000/470000 B y llama a
  `FUN_00c04752`). El init **no tiene xrefs directas** → el render se invoca por **dispatch
  indirecto** (tabla de *jobs* SOS). Ver `GHIDRA_DECOMP_VS_REIMPL.md` §3.4.
- **rz-ghidra** (`pdg`, Rizin 0.9.0, compilado en WSL) da un C **equivalente** al de Ghidra
  (`0xC16`/`0xCBA`/`0xE1E`) → cross-check válido.

