# Lecciones aprendidas — desensamblado de demos/juegos Amiga

Documento **reutilizable**: método, trampas y recetas que sirven para cualquier expediente
de reverse engineering de software Amiga 68k. Se irá ampliando con cada desensamblado.

## 1. Flujo general recomendado

```
imagen (.dms/.adf/.ipf)
   -> (si .dms) descomprimir a .adf y VERIFICAR
   -> identificar formato (¿AmigaDOS o trackloader propio?)
   -> arrancar en WinUAE-DBG y volcar RAM en caliente
   -> identificar el decruncher del loader y engancharlo
   -> volcar módulos/bloques descomprimidos
   -> localizar bucle/efectos, desensamblar, extraer assets
```

Regla de oro: **si el disco no es AmigaDOS, el código no está "en el fichero"**: está en RAM
tras el decrunch. El `.adf` solo sirve para el loader y los datos aún comprimidos.

## 2. Extraer DMS con herramienta propia

- La referencia fiable es **xDMS**, y los fuentes viven en `WinUAE-DBG/archivers/dms`
  (`pfile.cpp` + `u_*.cpp` + `getbits.h`). Portarlos es más seguro que fiarse de utilidades
  externas.
- El bitstream es MSB-first con `bitbuf` de 32 bits y `bitcount` de 8 bits (`getbits.h`):
  `GETBITS(n) = bitbuf >> (bitcount-n)`; `DROPBITS(n)` mantiene `bitbuf < 2^bitcount`.
  **En Python hay que enmascarar a 32 bits** (no hay overflow natural como en C).
- `DROPBITS` es el sitio donde más se falla: recarga bytes mientras `bitcount < 16`.
- **Trampa de estado**: en HEAVY (y en general en el modo de cada pista) el diccionario persiste
  entre pistas salvo que el flag `bit0` pida reset (`if (!(flags & 1)) Init_Decrunchers()`).
  Si no se persiste el `text_loc` del modo, la pista siguiente diverge.
- El decodificador HEAVY (LZH) es el más delicado: portar `maketbl.cpp` (construcción de tablas)
  y respetar el orden `read_tree_c`, `read_tree_p` (solo si `flags & 2`) y el RLE final
  (solo si `flags & 4`).
- **Verificación gratis**: el formato guarda CRC de cabecera, CRC del bloque comprimido y
  checksum del bloque descomprimido. Si el checksum no cuadra, la implementación está mal.
  Aprovecharlo: fallar rápido por pista en vez de generar basura.
- Cabecera de 56 B (`HEADLEN`), pista de 20 B (`THLEN`) con firma `TR`; pista 80 = `FILEID.DIZ`,
  pista `0xFFFF` = banner, pista 0 con 1024 B = fake bootblock.

## 3. Identificar el formato del disco

- Comprobar la firma del bootblock: `DOS\0` (OFS), `DOS\1` (FFS), o desconocida.
- **Ojo**: un bootblock puede *decir* `DOS\0` y no haber filesystem real. Buscar el root block
  (bloque 880 en DD: 80·11·2) y comprobar `type==2`; si no existe, es trackloader propio.
- Los strings del bootblock delatan las dependencias: `trackdisk.device` + `graphics.library`
  => carga por pistas propia.

## 4. WinUAE-DBG + GDB (el caballo de batalla)

- Usar el **build x86** (`winuae-gdb.exe`); el x64 tiene un bug de boot con GDB.
- Lanzar en modo portable con la config del proyecto y `-s debugging_features=gdbserver` **en la
  línea de comandos**, no solo en el `.uae`.
- Para no depender de las tools MCP, importar el módulo Node del repo hermano:
  `mcp-winuae-emu/dist/winuae-connection.js` (`WinUAEConnection` + `GdbProtocol`).
  Es exactamente lo que hacen `toolkit/node/dump-ram.mjs` y
  `toolkit/node/hook-trampoline.mjs`.
- Flujo: `connect()` (hace Ctrl+C y handshake) -> `continue()` -> esperar -> `pause()` ->
  `readRegisters()` / `readMemory()`.
- `memcfg` (monitor) da el mapa real de bancos: no asumir 0x000000/0xC00000, confirmarlo.
- `readMemory` en **bloques** (1-4 KB); leer 512 KB de golpe puede resetear el stub.
- `screenshot <ruta>` (monitor) funciona y es la evidencia visual más útil.
- En WinUAE-DBG v2.x hay canal lateral (`:2346`) para observar sin tocar el socket GDB.

### 4bis. Sesión persistente y canal lateral (evitar relanzar)

- **Lanzar WinUAE UNA vez** y reutilizarlo (`toolkit/node/launch.mjs` deja el emulador detached).
  Relanzarlo por cada experimento es lento y un error de método: las herramientas deben conectar
  al que ya corre, no arrancar otro.
- **Canal lateral (2346)**: independiente de GDB; lee/escribe en runtime **sin pausar la CPU**.
  Comandos: `hello`, `state`, `regs`, `mem <addr> <len>` (≤4096 B), `poke <addr> <hex>`,
  `lock acquire <owner> <observe|assist|takeover>` / `lock release`, `screenshot <path>`,
  `pause`/`resume`, `runstatus`, `audit writes`. Cliente: `toolkit/node/side.mjs`.
- **Trampa de formato numérico**: el servidor parsea los números en **base 10** salvo que lleven
  `0x` o letras hex. Enviar SIEMPRE `0x` (p. ej. `mem 0xdff080 0x140`); si no, `1000` se
  interpreta como 1000 decimal en vez de `0x1000` (nos pasó: leía 128000 B de 524288).
- Locks: `poke`/`pause`/`resume` requieren **takeover**; `input`/`profile` requieren **assist**;
  `mem`/`screenshot`/`state`/`regs` **no** requieren lock.
- **Extraer un frame completo desde los registros en vivo NO es fiable**: el Copper cambia
  `BPLCON0`/punteros de plano por zonas (splits), así que un rango contiguo no reconstruye la
  imagen (sale ruido; verificado incluso congelando la CPU atómicamente). Opciones **sin tocar
  WinUAE**:
  - `screenshot` para la referencia visual (fiel).
  - `monitor watch <reg> w src=copper reportonly` + `monitor trace on` (las escrituras del Copper
    se registran en `%TEMP%\winuae-gdb.log`) -> reconstruir registros por línea.
  - `monitor profile` / canal lateral: el profiler registra `DMARECORD_BITPLANE` por scanline
    (con dirección), pero el parser MCP solo expone el resumen (`byType`), no las direcciones.
  - Sólo si todo lo anterior es insuficiente, **extensión aditiva** en `barto_gdbserver.cpp`
    (p. ej. un `qRcmd`/canal lateral `coppertrace`) — implementar **opt-in y sin alterar** el
    comportamiento existente.
- `mem` limita a 4096 B por llamada: trocear (leer 512 KB = 128 llamadas, rápido).

### 4ter. Aislamiento y convivencia con otras instancias

- **Nunca matar procesos a lo bruto**: `Get-Process winuae-gdb | Stop-Process -Force` mata instancias
  de **otros** proyectos/usuarios. Registrar el **PID propio** al lanzar (`launch.mjs` ->
  `.session.json`) y cerrar **solo** ese PID (`stop.mjs`), verificando que sigue siendo `winuae-gdb`.
- **Puertos propios**: GDB **2445**, canal lateral **2446** (`AMIGA_REVERSE_GDB_PORT`/
  `AMIGA_REVERSE_SIDE_PORT`). Ojo: el equipo puede tener `WINUAE_GDB_PORT=2345` global; ignorarlo.
- **No capturar el ratón**: `-s win32.start_not_captured=yes`,
  `-s win32.active_capture_automatically=no`, `-s win32.absolute_mouse=yes`
  (+ `win32.nonotificationicon=yes`, `absolute_mouse=none` en el `.uae`).
- **Extensión aditiva en WinUAE-DBG**: `WINUAE_SIDE_CHANNEL_PORT` ya existía; se añadió
  `WINUAE_GDB_PORT` (default 2345 intacto). Antes de recompilar, **backup del `.exe`**; el deploy
  a extensiones en uso puede fallar (bien: no se pisa su binario).
- **Cerrar en cuanto no se necesite**: una instancia persistente solo mientras dura la tarea.
- **La ventana debe quedar en primer plano para que WinUAE complete el arranque**: si se lanza
  minimizada/oculta, el boot no termina de arrancar (no abre el stub GDB/canal lateral). Lanzar
  **sin** `-WindowStyle Minimized` y dejar la ventana visible.
- **Las instancias solo responden si están en primer plano**: no minimizarlas mientras se trabaja
  con GDB/canal lateral.
- **`.session.json` puede quedar con una sesión fantasma** (PID muerto pero registrado): si los
  puertos quedan "ocupados" por una sesión que ya no existe, las nuevas instancias no abren el
  stub. Al detectar puertos ocupados sin proceso vivo, **limpiar `.session.json`** y relanzar.
- **El detach de GDB (`D` o `k`) cierra el stub**: tras `detach` el proceso sigue vivo pero deja de
  escuchar en 2445. Para sesiones largas, hacer todo el flujo (pausar -> watchpoint -> continuar
  -> esperar hit -> leer registros) en **un único script GDB** sin detach al final.

## 5. Trampas de entorno (Windows/PowerShell)

- **No cortar el pipe con `Select-Object -First N`** a un proceso que aún trabaja: mató el
  volcado a medias. Redirigir a fichero (`1> log 2> err`) y leer después.
- El módulo MCP imprime trazas (`[WinUAE] readMemory chunk ...`) en stderr: redirigir para no
  inundar la salida.
- Evitar here-strings de PowerShell con comillas anidadas para Python (se comen las comillas):
  **escribir el script a fichero** y ejecutarlo.
- `Select-String`/`grep` y `objdump` con `--adjust-vma` para direccionar el volcado.

## 6. Encontrar y enganchar decrunchers

- Los loaders suelen dejar **firmas** en el código y los datos: p. ej. SOS usa `CrM!` y `CrM2`
  (`'CrM!'`=0x43724D21). Buscar estas firmas en el volcado localiza las rutinas.
- **No asumir que la firma más obvia es la que se usa**: en «Arte» había `CrM!` y además `IMP!`
  (0x494D5021), y el bucle caliente era `IMP!`. La pista decisiva es **dónde vive el PC** al
  pausar varias veces (`probe-breakpoints.mjs`); el cruncher realmente usado es el que aparece.
- Una misma familia de formatos puede tener **varias rutinas**: identificar la entrada exacta
  (prologue + `cmpi.l #'FIRMA'`) y engancharla aparte.
- Patrón del trampoline de SOS (útil como plantilla de detección):
  `48e7fffe 2018 4bfa0026 b0bc43724d21 ... 4bfa0112 b0bc43724d32`.
- Estrategia de enganche: breakpoint en la **entrada** del trampoline (captura `destino`, `len`,
  `header`) y en el **retorno** (`+0x2`) para volcar `[destino, destino+len)` ya descomprimido.
- Buscar el trampoline **por firma** en RAM tras el boot, no por dirección fija (por si el loader
  se relocaliza entre ejecuciones).
- Cuidado con breakpoints software en RAM que se **sobrescribe** al cargar el loader: ponerlos
  después de que el loader esté residente.
- **Descubrir el contrato de una rutina sin documentación**: `probe-layout.mjs` congela en la
  entrada y en el retorno de una sola llamada y compara la RAM (diff). El rango que cambia es lo
  que la rutina escribe; de ahí salen destino y longitud (p. ej. en «Arte», `IMP!` escribe
  `[A0, A0+long(A0+4))`).
- **Los buffers se reutilizan**: un mismo destino con longitudes distintas = módulos distintos que
  comparten hueco. Enganchar la rutina captura cada decodificación aunque luego se sobreescriba;
  deduplicar por `sha1`.
- **Formato de módulo SOS en el disco (bloques `IMP!`)**: en el ADF los módulos se guardan
  comprimidos y empiezan con un header previo a la firma:
  `[long tipo 0x40000000/0] [long tamaño? 0x03/0x3F2] [long 0x04E9 const] [long tamañoX] "IMP!" [long1] [long2] ...`
  `0x04E9` (1257) es una constante que precede a cada bloque `IMP!`. El decruncher (0xC02426)
  hace `cmpi.l #'IMP!',(a0)+; adda.l (a0)+,a4; adda.l (a0)+,a3` (los 2 longs tras la firma son
  offset de destino y origen relativos al bloque). Los tamaños post-`IMP!` son
  `long1`≈destino/descomprimido, `long2`≈origen/comprimido.
- **El directorio SOS en RAM es una copia del directorio del disco (track 1, offset 0x2C00)**:
  mismo formato pero expandido (track pasa de word→long, nombre pasa de +0x08 a +0x0A).
  Confirmar la semántica de `track`/`offset`/`size` leyendo la rutina que lo recorre o con el
  watchpoint en la tabla, no asumiendo.
- **Los módulos SOS se referencian por tag de 32 bits, no por string**: sos.library carga p. ej.
  `DBUG.soslibrary` con `move.l #$44425547 ("DBUG"), d0; jsr -$138(a6)`. El tag son los 4
  primeros caracteres del nombre en mayúsculas. Al portar, usar un mapa `tag → módulo`.
- **Asociación bloque IMP! del ADF ↔ módulo volcado por `l1`**: cada bloque `IMP!` del disco lleva
  `l1` (tamaño descomprimido) y `l2` (tamaño comprimido) tras la firma. El hook de runtime capturó
  `len` = `l1`; la coincidencia es exacta (12/12 en «Arte»). Permite mapear cada bloque del disco a
  su módulo descomprimido **sin decrunchar** (`recovered/maps/imp_blocks.json`).
- **El `track`/`offset` del directorio SOS NO es la posición física del bloque IMP!** en el disco
  (tracks del directorio 0–13 vs tracks reales de los bloques 14–69). El campo `track`/`offset`
  del directorio es un índice lógico del loader; para localizar el dato físico hay que usar la
  tabla de bloques IMP!.
- **Detalles del decruncher `IMP!` (port a Python)**: (1) el bit-reader usa `d3` como buffer de
  8 bits, y **arranca con el word del trailer** (no con 0); (2) `a3` es UN solo puntero compartido
  entre la copia directa y el bit reader (sincronizar la posición entre ambos); (3) el decrunch es
  **in-place** sobre el bloque (el match puede leer del origen comprimido más allá del destino);
  (4) `add.b d3,d3` opera en byte bajo. Pendiente: orden del header del trailer en el destino.
- **El formato `IMP!` es File Imploder (formato conocido de la escena Amiga)**: firma
  `0x494D5021`, clones `ATN!/EDAM/M.H.`. No reinventar: usar la librería **`ancient`**
  (temisu/ancient, C++17, licencia BSD) que lo descomprime verificado. Compilar:
  `g++ -std=c++17 -O2 -Iancient -Iancient/api -Iancient/api/ancient main.cpp src/*.cpp src/common/*.cpp`.
  Copiar `libstdc++-6.dll`/`libgcc_s_seh-1.dll`/`libwinpthread-1.dll` junto al exe.
- **Sanity usa IMP! SIN checksum estándar**: `ancient` falla por checksum (`addition=7`); en
  `IMPDecompressor.cpp` poner `addition=0` para los bloques SOS. Tras esto, decrunching de los 41
  bloques del ADF **exacto** (sha1 coincide con los 12 volcados por el hook).
- **El `size` del directorio SOS NO es el tamaño descomprimido del bloque IMP!**: ninguno de los
  41 bloques decrunchados coincide con los `size` del directorio. El directorio es la tabla de
  nombres/lógica del loader; los datos reales están en los bloques IMP! (mapeados por `l1`).
- **SOS está documentado por el propio autor**: Dierk Ohlerich publicó SOS 2.6 en Aminet
  (`dev/asm/SanityOperationSystem.lha`, 1994) con docs, includes y ejemplos. Confirma: (1) el
  `IMP!` del disco es **Imploder** ("ripped out of beermon"); (2) las librerías
  `DBUG/SINE/TEXT/AGAC.soslibrary`; (3) `main` es el loader; (4) el "effect handler" interpreta
  un `script` (los `.scr` del paquete). Referencia guardada en
  `sanity-arte/recovered/reference/sanity-os-v26/`.
- **Formato de copperlist SOS**: MOVE = `[opcode 0][reg][valor]` (4 bytes, igual que el estándar
  `0x01xx` pero con opcode `0`). Los punteros BPL/SPR y colores van a 0 en el bloque (el demo los
  parchea por frame). Un bloque de efecto puede contener **varias copperlists encadenadas**
  (marcador `[01 ff fe]` + cabecera de 1 byte `[0xXX]`).
- **Efectos procedurales vs assets**: el **plasma** es procedural (se calcula en runtime con
  SINE, el buffer en disco está vacío); el **túnel** tiene paleta (asset) + textura (layout
  incierto). No intentar decodificar un buffer procedural como imagen estática: buscar la rutina
  de cálculo en el código.
- **Capstone necesita `skipdata=True` en bloques con datos intercalados** (headers de librería,
  firmas ASCII): sin él, el disassembler se detiene tras la primera zona de datos (p. ej. solo
  decodificaba 2 insns de un bloque de 26676 B en lugar de 8160).

## 6bis. Extraer el estado de vídeo

- **La lectura en vivo de registros custom no es fiable** en este setup, ni por GDB **ni por el
  canal lateral** (`mem $dff0xx`): `BPLCON0`/`BPL1PT`/`COP1LC` devuelven valores distintos entre
  capturas (p. ej. `0x0200`, `0x4000`, `0x5600`), porque reflejan la **zona instantánea** que el
  Copper está programando en ese instante (y el demo hace splits). No reconstruir un bitmap de
  frame completo a partir de ellos.
- `COP1LC` puede apuntar a un **buffer reutilizado** (p. ej. el mismo destino de un módulo), de
  modo que "parsear la lista" da código, no Copper. Verificar que el contenido es una lista
  coherente (destinos `$dffxxx` pares, `WAIT`/`SKIP` válidos) antes de fiarse.
- `dump-display.mjs` sirve para volcar registros + lista + paleta, pero su salida puede ser una
  captura de transición; tratar la Copperlist como **candidata a validar**.
- **Referencia fiable**: la **captura de pantalla** (`screenshot`) refleja lo realmente mostrado.
  Usarla como fuente para reimplementar, aunque no dé los bitplanes fuente.
- No leer `$DFF1C0+` en OCS/ECS: provoca error y puede tumbar el emulador (limitar a `$DFF1BE`).
- El canal lateral (`toolkit/node/side-read.mjs`, puerto 2346) sí es útil de forma fiable para
  `state`/`regs` (PC, ciclos, registros de CPU) y para `mem` de RAM genérica.

## 7. Desensamblado

- `m68k-amiga-elf-objdump.exe` (extensión Bartman) con
  `-D -b binary -m m68k --adjust-vma=<base> --start-address/--stop-address`.
- Para CFG/xrefs y nombrar rutinas en volcados sin símbolos: Rizin/radare2 (ligero) o Ghidra
  (mejor para sesiones largas). Decidir según el tamaño del binario.

## 8. Aspectos legales

- Desensamblar **para aprender** y reimplementar técnicas es aceptable en el ámbito del
  reverse engineering educacional; **no** redistribuir código ni assets del original.
- Documentar **técnicas y algoritmos** (ideas), no volcar el código ajeno.

## 9. Plantilla de expediente

Reutilizar esta estructura en el próximo título:
`README.md` (estado + inventario + cómo reproducir) + `docs/{ROADMAP,HALLAZGOS,LECCIONES_APRENDIDAS,TECNICAS}.md`
+ `tools/` (extracción, volcado, enganche) + `out/` (artefactos regenerables).
