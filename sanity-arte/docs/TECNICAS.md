# Técnicas de «Arte» y receta de reimplementación

Un apartado por efecto/técnica. Se irá rellenando a medida que el desensamblado avance.
Cada entrada debe terminar con una **receta reutilizable** (algoritmo + parámetros + coste),
no con volcado de código ajeno.

## Plantilla de entrada

```
### <Nombre del efecto>
- Evidencia: <dirección de la rutina, captura, módulo>
- Qué hace: <descripción>
- Cómo (hardware): <Copper / Blitter / BPLCON1 / sprites / Paula …>
- Algoritmo/idea: <pseudocódigo propio>
- Parámetros: <tablas, velocidades, paleta, etc.>
- Receta para el engine: <cómo portarlo>
- Coste: <ciclos/DMA/CPU por frame>
```

## Empaquetado propio de SOS (`CrM!`/`CrM2` + `IMP!`)

- Evidencia: rutinas en Slow RAM `0xC02426` (`IMP!`), `0xC02584` (trampoline `CrM!`),
  `0xC025B2` (`CrM!`), `0xC026AA` (`CrM2`); desensamblado en
  `recovered/code/sos_cruncher/sos-crunchers.asm`.
- Qué hace: descomprime bloques (módulos, gráficos, música) en runtime; el disco solo lleva datos
  comprimidos.
- Cómo: cabecera con firma ASCII + dos longs big-endian; `IMP!` descomprime **hacia atrás**
  (LZ + Huffman con tabla de 28 B) escribiendo en `[A0, A0+long(A0+4))`.
- Algoritmo/idea (para reimplementar): LZ77 con árbol Huffman dinámico + paso RLE posterior en
  `CrM!`/`CrM2`. En `IMP!` la salida ocupa el propio bloque (in-place).
- Receta para el engine: empaquetar assets con un LZ+Huffman propio en el pipeline de build y
  descomprimir a un buffer destino; no requiere el formato exacto de SOS.
- Coste: descompresión en carga (fuera del hot path por frame).

## Copperlist del título

- Evidencia: `recovered/media/copper/arte-title-copper.txt` (capturada de `COP1LC=0x26614`).
- Qué hace: instala DIW/DDF, `BPLCON0=$5600` (**5 planos**), modulos `-40`, punteros BPL/SPR,
  `DMACON`, y una paleta (`COLOR00..`).
- Nota: la captura correspondía a una lista de **blanqueo** (punteros BPL a 0) durante una
  transición; hay que recapturar con la lista activa.
- Receta para el engine: el patrón es el estándar (Copper instala modo + punteros + paleta); sirve
  como referencia de un display OCS de 5 planos.

## Display OCS de 5 planos (título) — bitplanes decodificados

- Evidencia: `mod_007` (102852 B, dest Chip `0x26614`) contiene los bitplanes del título;
  copperlist `mod_003` (también en `0x26614`) configura el display.
- Parámetros de pantalla (de la copperlist): `DIWSTRT=$5981`, `DIWSTOP=$59C1` (PAL 320×200~256),
  `DDFSTRT=$38`, `DDFSTOP=$D0`, `BPLCON0=$5600` (5 planos lowres), `BPL1MOD=$FFD8` (=-40).
  `BPL1MOD=-40` ⇒ **ancho 320 px** (40 B/línea/plano × 8 = 320 bits); módulo negativo = sin
  relleno entre líneas (bitplanes contiguos).
- Paleta `arte-title-palette.json`: fondo `#330000`, texto `#99aaaa`, rampa `#556666/#334444/
  #223333`. En la captura de referencia dominan `(51,0,0)` y `(170,170,170)` → paleta confirmada.
- Layout planar OCS: 5 planos de 40 B × 200 líneas = 200 B/línea; 102852 B ≈ 514 líneas =
  ~2.5 pantallas apiladas (el buffer se reutiliza para varios estados/efectos del título).
- Imágenes decodificadas: `recovered/media/gfx/mod7_block0_320x200.png` (título lleno, 56%
  datos), `mod7_block1_320x200.png` (28%), `block2` (8%). Bloque 0 = frame principal.
- Receta para el engine: el demo pinta en planares OCS (5 planos) y deja que el Copper parchee los
  punteros BPL1PT..BPL5PT por frame (por eso en la copia almacenada los punteros están a 0).
  Al portar: mantener el bitplane como `uint32_t[5]` por línea o pasar a RGB y reutilizar una
  textura; el módulo negativo es equivalente a un stride exacto de `ancho_bytes*planos`.
- Coste: bitplanes planares = un `memcpy` de `40×planos` por línea; sin coste de Copper por frame
  si los punteros no cambian.

## Seno precalculado (`SINE.soslibrary`)

- Evidencia: módulo `SINE.soslibrary` referenciado por SOS; el demo mueve objetos/ángulos por frame.
- Idea: tabla de seno precalculada y consulta entera (sin `sin()`/punto flotante en runtime).
- Receta para el engine (PORTADO): `reimpl/sine_table/` — tabla Q1.14 de 1024 entradas, fase de 16
  bits con wrap natural, `sin_q14`/`cos_q14` O(1). Test host `make test`.

## Scrolltext con fuente de 3 planos (módulo 0x02162C)

- Evidencia: bloque `out/modules_all/blk_02162C_45924.bin` (descomprimido del ADF),
  desensamblado en `recovered/code/code_2162c/code_2162c.asm`. Confianza **alta** (rutina
  completa desensamblada, fuente y texto extraídos).
- Contenido del módulo:
  - `0x1A80`: **mapa de caracteres** `" abcdefghijklmnopqrstuvwxyz0123456789.,!?:"-` (43 chars).
  - `~0x2800-0x3400`: **glifos** (cada char: 3 planos × 8 filas × 2 bytes = 16 px de ancho).
  - `0x352A`: **texto del scroll** (alemán: "Gefällt, sondern... will sie nicht die erste ist...").
  - `0x1AAC`: rutina de **limpieza de bitplanes** (`lea $60000.l,a0; move.w #$3bff,d7;
    clr.l (a0)+; dbf d7` = limpia 0x3C00 longs = 61440 B).
- Rutina de render (0x196E-0x1A70):
  1. Si no hay texto pendiente (`$1a7e`), lee el siguiente char: `lea $352a.l,a0` +
     offset `$1a72`, busca el char en el mapa (bucle `cmp.b (a1)+,d0; dbeq`).
  2. Índice del char → base de glifos `$30e9(pc)` + índice → puntero al glifo.
  3. Bitplane destino `$60000.l` + offset `$1a76` (scroll horizontal) + `$1a7a` (contador).
  4. **Bucle de 3 planos** (`moveq #$2,d7; dbf`):
     - Copia 8 filas del glifo al bitplane: `move.b $0(a2),$0(a3); $2c→$50; $58→$a0;
       $84→$f0; $b0→$140; $dc→$190; $108→$1e0; $134→$230`.
     - `lea $160(a2),a2` (siguiente plano del glifo), `lea $5000(a3),a3` (siguiente bitplane).
  5. Avance: `$1a7a` llega a `$50` (80) → `$1a72++`, `$1a7a=0`, `$1a76 += $320` (800).
     `$1a76` llega a `$4e20` (20000) → reset scroll (`$1a76=0`, `$1a7e=1`).
- Parámetros: 3 bitplanes en Chip RAM `0x60000` (stride `0x5000` entre planos), fuente de
  16 px de ancho × 8 de alto, glifo por char = 3 × `0x160` bytes.
- Receta para el engine: mantener un **buffer de texto** con el índice de cada char; el scroll
  horizontal se hace moviendo un **offset dentro del buffer** y refrescando la columna de bytes
  que entra; el glifo es un mapa `char → 3 planos de 8 filas`. En C++: tabla de glifos
  `uint8_t glyph[43][3][8][2]`, y un bucle que copia a la textura/bitplane.
- Coste: 3 planos × 8 bytes × nº chars visibles por frame; la limpieza de bitplane es
  `0x3C00` longs (rápida en CPU o Blitter).

## Motor 3D (módulo 0x0B0C2C) — transformación de puntos con matriz Q15

- Evidencia: `out/modules_all/blk_0B0C2C_63064.bin` (descomprimido del ADF), desensamblado en
  `recovered/code/code_b0c2c/code_b0c2c.asm`. Confianza **alta** (rutinas completas).
- Contenido: motor 3D de la demo (estrellas 3D / vectorización, la rutina que el autor del
  scrolltext llama "la más optimizada"), más rutinas de fade de paleta y render.

### Transformación de punto (0x0CBA)

Entrada: punto `d0,d1,d2` (x,y,z) desde `(a0)+`; matriz 3×3 en `a1`; salida en `(a2)+`.

Layout de la matriz (9 words Q15): `[m00 m10 m20][m01 m11 m21][m02 m12 m22]` (offsets de fila
`$0,$6,$c`; columnas `$2,$8,$e` y `$4,$a,$10`).

Por cada componente (ej. X'):
```
move.w (a1),d3    ; m00
move.w $6(a1),d4  ; m01
move.w $c(a1),d5  ; m02
muls.w d0,d3      ; m00*x
muls.w d1,d4      ; m01*y
muls.w d2,d5      ; m02*z
add.l  d3,d4
add.l  d4,d5      ; suma acumulada
add.l  d5,d5      ; <<1 (Q15)
swap   d5         ; >>16
move.w d5,(a2)+   ; X'
```
Dentro de cada bloque se calculan las 3 componentes (X', Y', Z') del punto. El bloque se repite 3
veces porque la rutina procesa **3 puntos por llamada** (`MOVEM.W (A0)+,D0-D2` ×3 → 9 words de
entrada, 9 de salida). *Corrección (2026, evidencia: decompilado de Ghidra, ver
`GHIDRA_AMIGA_EVAL.md` §3): antes se describía como "un punto × 3 componentes"; es 3 puntos.*

### Construcción de matriz de rotación (0x0C46)

Entrada: `d0-d5` = senos/cosenos de los ejes. Salida: 9 elementos de la matriz en `(a0)+`,
usando el mismo patrón `muls.w + add/sub + add.l d,d + swap` (aritmética Q15 fija).

### Construcción de matriz ortonormal (0x0E1E)

Calcula una matriz de rotación 3×3 con **cross-product** de las filas para mantener
ortonormalidad (camera system): `muls.w d5,d6; muls.w d4,d7; sub.l d7,d6; ...` por fila.
Usado para la cámara (evita drift de la matriz).

### Fade de paleta por nibbles (0x31C-0x3E2)

Interpolación de color 12-bit OCS hacia un objetivo trabajando los 4 nibbles (RGB) por separado:
cada color `(a0)` se acerca al destino `(a1)+` incrementando/decrementando `+1`, `+$10`, `+$100`
(componentes B, G, R) según sea menor o mayor. Controlado por un contador de frames (`$3f0`).

### Receta para el engine

- La aritmética Q15 fija: `producto32 = mul(x16, y16); resultado = (producto32 + producto32) >> 16`
  (equivalente a `add.l d,d` + `swap`). En C++: `int r = (int32_t)(a*b) >> 15;` (Q15×Q15 → Q15).
- Matriz 3×3 `int16_t m[9]`; transformar punto: `x' = m00*x + m01*y + m02*z` (Q15).
- Mantener la cámara con cross-product para ortonormalidad (evita escalado acumulado).
- Fade: para cada color, `for k in {B,G,R}: aprox=(color==dest)?color:(color<dest?color+(1<<k):color-(1<<k))`.
- Coste: 3 muls por componente = 9 muls por punto (sin FP). Adecuado para estrellas/polígonos en
  68000.

## Túnel / corridor (bloque 0x03AFFC)

- Evidencia: `out/modules_all/blk_03AFFC_l1_102852.bin` (descomprimido del ADF `0x03AFFC`,
  track 21, l1=102852). Es el **buffer del efecto «corridor»** (= el túnel de Arte). **No contiene
  código** (rts=0). Confianza **alta** en la identificación; ver
  `recovered/media/palettes/tunnel-VALIDACION.md` para el detalle.
- Cabecera `[1d 01 ff fe]` + display: `DIWSTRT=$2981, DIWSTOP=$29C1, DDFSTRT=$38, DDFSTOP=$D0,
  BPLCON0=$5200` → **5 bitplanes / 32 colores**, 320 px. `DMACON=$802F`.
- **Carga en RAM confirmada en vivo:** el bloque se copia a **chip RAM `0x26614`** (la paleta
  aparece en `0x2675A = +0x146`). El efecto **parchea la Copperlist en runtime** (95 bytes): copia
  los 32 colores de la paleta en los registros COLORxx.
- **Paleta del túnel** (32 colores 12-bit): `recovered/media/palettes/tunnel-palette.json`
  (`FFF,FFC,FD9,…,000`, degradado de profundidad). En la captura real del efecto, la cobertura de
  esta paleta es del **100 %**. Confianza **alta**.
- Técnica: **texture-mapped tunnel** (efecto de Chaos), como el resto de efectos del grupo; el
  look de la demo lo confirma. La captura en vivo (`reference/corridor-live.png`) muestra el túnel
  con pilares y convergencia al centro.
- **Reimpl:** `reimpl/tunnel/` reproduce la geometría del **remake público** (`artsy`) —raycast por
  filas— con la **paleta real** de Arte y el compositing del canvas. Validado con Ollama: la
  estructura «strongly resembles» el original.
- **LÍMITE (mapa de textura):** el **mapa/gráficos exactos del original NO se han recuperado** por
  ninguna vía (ni ADF/PP20, ni RAM en vivo, ni decodificación del bloque —no tiene patrón radial—).
  Se documentan los intentos; la reimpl con paleta real se toma como **versión final** del efecto.
- Receta para el engine: túnel texture-mapped con tabla de ángulos/profundidad + textura, punteros
  BPL/Copper actualizados por frame y **paleta cargada en la Copperlist** (cubierto por
  `reimpl/palette_fade`).


## Plasma (bloque 0x09A940) — efecto procedural

- Evidencia: `out/modules_all/blk_09A940_51648.bin` (descomprimido del ADF). Buffer de display.
  Confianza **media**.
- **El plasma es un efecto PROCEDURAL**: el buffer no contiene una imagen estática (está vacío/
  denso sin coherencia al decodificar). Se genera en runtime calculando ondas de seno 2D
  (usa `SINE.soslibrary`) y escribiendo los bitplanes. El encabezado del buffer es una tabla de
  punteros/colores a 0 (el demo los parchea por frame).
- Estructura del buffer: `[01 00 02 00]` cabecera + pares `[00][reg][00][00]` (BPL1-6PTH/PTL,
  COLOR00..31, todos a 0 en disco) + zona de bitplanes densa.
- Layout probable: 4 planos interleaved, 320 px (avg_dx bajo = 2.3, suave). La paleta exacta se
  aplica en runtime.
- Receta para el engine: el plasma clásico = `color(x,y,t) = sin(x/a+t) + sin(y/b+t) + sin((x+y)/c+t)`,
  mapeado a la paleta. En Amiga: se calcula el índice por píxel y se escribe el bitplane planar.
  La rutina de cálculo está en el código (módulos SINE), no en los datos.

## Esfera de 16 colores / efecto lente (efecto de Chaos)

- Evidencia: créditos de «Arte» (texto de scene.org) listan como efectos de Chaos:
  **rubber-rotator, 16 color sphere y color tunnel**, y añaden "look all the same" — es decir,
  los tres usan la **misma técnica de texture mapping** (solo cambia la forma de la superficie).
  La "vector routine" (motor 3D) la escribieron Chaos y McDeal. Confianza alta en la técnica.
- Identificación de la rutina concreta: **pendiente** (los bloques de código son variantes de
  sos.library con el código de efecto embebido; no se ha localizado la rutina exacta de la
  esfera con certeza). Confianza baja-media.
- **Técnica clásica del efecto lente** (estándar en demos Amiga, hay mucho código público):
  1. **Precálculo**: para cada píxel dentro del círculo de la esfera, se calcula el
     desplazamiento `(dx,dy)` que simula la curvatura de la lente (offset desde el centro,
     escalado por la distancia al centro). Se guarda en una **tabla de offsets**.
  2. **Runtime**: por cada píxel del círculo, leer la textura en `(x+dx, y+dy)` y copiarla al
     bitplane. La tabla evita trigonometría/división en el bucle caliente (solo sumas y copias).
- Receta para el engine: precalcular la tabla de offset (una vez), luego por frame copiar la
  textura desplazada al buffer. La esfera "looks all the same" como el túnel → misma rutina de
  mapeo, distinta forma (círculo vs anillos).
- Coste: el precálculo es O(r²) una vez; el runtime es O(píxeles) con sumas + copia de bytes.

## Zoom / render de imagen a 4 planos (módulo 0x07E42C)

- Evidencia: `out/modules_all/blk_07E42C_20268.bin` (descomprimido del ADF), desensamblado en
  `recovered/code/mod_07e42c/` (por hacer). Confianza **media-alta** (rutina desensamblada).
- Contexto: el bloque 0x07E42C es una variante de sos.library con **107 `jmp`** (dispatch grande)
  y muchas rutinas de dibujo (122 `dbra`, 104 `bset.b`). Es el candidato a las rutinas de
  **zoom de imágenes / distorsión** ("zooming-pictures" del scrolltext).
- **Rutina de render a 4 planos (0x146A-0x14F0)**:
  - Puntero a imagen en `$13f4`; tablas de 4 planos en `$414a` (a1, a2=a1+$370, a3=a2+$370,
    a4=a3+$370 = 4 planos separados 0x370 bytes).
  - Bucle por fila (0x1482): `clr.l (a0)+` (margen) + `move.w #$6d, d6` (110 words) copiando
    `move.w (a1),(a0)+; move.w (a2),(a0)+` (2 planos a la vez), `lea $8(a1),a1` (columna),
    `dbra d6`. Al final `clr.l (a0)+; clr.l (a0)+`.
  - Repite con a3/a4 (planos 3 y 4) y `dbra d7` (4 filas/planos).
  - **Actualización de punteros BPL** (0x14CA-0x14F0): escribe los punteros de bitplane
    (BPLxPTH/PTL) con `swap` y `addi.l #$1c0` (avance entre filas), en la tabla de display.
- Interpretación: copia una imagen desde tablas planares (4 planos) al display, con estructura
  de fila de 110 words. El patrón `lea $8` por columna + separación `$370` entre planos es el
  layout planar interleaved por fila. La actualización de punteros BPL sugiere que cada fila de
  la imagen es un "scanline" que se coloca en el display (zoom vertical por filas).
- Receta para el engine: render planar por filas — por cada fila, copiar las words de los 4
  planos fuente al bitplane destino, y avanzar los punteros BPL por fila. El zoom se logra
  escalando el avance de filas fuente.

## Motor de blobs/sprites con lookup tables (0x0B0C2C, zona 0x34C6-0x5342)

- Evidencia: `out/modules_all/blk_0B0C2C_63064.bin`, desensamblado en
  `recovered/code/code_b0c2c/`. Confianza **alta** (rutina completa desensamblada).
- Es el **render de blobs** de la demo: dibuja sprites/blobs en **3 bitplanes** usando una
  **tabla de lookup precalculada** para expandir cada byte de sprite a su patrón de 16 bits sin
  calcular en el bucle caliente.

### Estructura del render

- **Tabla de lookup** en `$318dc`: 256 entradas × 4 bytes. La construye el código (0x3318):
  cada byte de sprite (0-255) → el patrón de 2 words (16 píxeles) expandido en el bitplane.
  En el disco está a ceros (se genera en runtime).
- **Render por byte** (0x34A0-0x34C8):
  1. `move.w (a0)+, d2` = byte del sprite; `move.b (a7)+, d2` = byte de máscara (combinados).
  2. `moveq #$fc, d3; and.w d2, d3` = índice de 6 bits para la tabla de píxeles.
  3. `move.l (a5, d3.l), d0` = patrón de píxel precalculado (16 bits).
  4. `add.w d2,d2 x2; move.l (a5, d2.l), d2` = máscara precalculada (tabla por máscara).
  5. `lea (a2, d0.w), a3` = posición en el bitplane; `a4 = a3+$20`, `a1 = a4+$20` = 3 planos.
  6. `swap d0; jmp (a6,d0.w)` = **dispatch** a la variante de copia (según ancho: 1/2/3 words).
- **Variantes del switch** (0x34DC, 0x3504, 0x3524, 0x3544...): copian 1-3 words por plano con
  `and.w` (máscara) + `move.w d5` (dato), `swap d2; not.w d2` para invertir máscara, `dbra`.
- Stride entre filas del blob: `mulu.w #$60, d5` (96 bytes); 3 planos separados 0x20 por fila.

### Receta para el engine

- Precalcular una tabla `sprite_lut[256]` que expande cada byte a su patrón de 16 píxeles
  (`patrón = expandir bits 1-a-1`). En el bucle, cada byte del blob → lookup → write a los
  bitplanes con máscara AND + dato OR.
- Es el mismo truco de "byte a palabra" que usan los juegos para blobs: evita iterar píxel a
  píxel (8x más rápido). En C++: `uint32_t lut[256]` y un bucle por fila.
- Coste: ~2 lookups + 3 writes por byte de blob.

## Efecto de distorsión/ondas con SINE (módulo 0x096A28)

- Evidencia: `out/modules_all/blk_096A28_3260.bin` (descomprimido del ADF), desensamblado en
  `recovered/code/mod_096a28/effect_sine_0x150-0x950.asm`. Confianza **alta** (rutinas completas).
- Es un efecto que **carga la librería SINE** (`move.l #$53494e45 ("SINE"), d0; jsr -$138(a6)`)
  y aplica **8 osciladores de fase** para distorsionar la imagen por bandas/scanlines.

### Inicialización (0x0164-0x0260)

- Carga SINE (`-$138`) y reserva buffers (`AllocVec -$2a`): 0x22F0 ×2, 0x818, 0x8000 (32 KB
  display), 0x20000 (128 KB), 0x4000, 0x1CCEA.
- Configura display (`SetInt -$c`) y llama a las subrutinas del efecto.

### Construcción de la tabla de distorsión (0x0400)

- Reserva 0x20000 (128 KB) y genera una **tabla de offsets** combinando dos patrones de 16
  entradas (`lea $47a(pc)`) con `or.l` + `lsl.l #$4` (×16). Limpia con patrón `$AAAAAAAA`.
- Stride de fila 0x780 (1920 B).

### Bucle por frame (0x07B6)

- **8 osciladores**: `addi.w #velocidad, $38(a5)+...` — cada uno avanza su fase con velocidad
  distinta (+10, +4, +0x48, +0x52, +6, +9, +5, +4).
- `move.w #$200, d0; add.w d0, $36(a5)` — avanza el tiempo global.
- Parchea la **copperlist** (`-$72`) con los nuevos valores de fase.
- `bsr $848` ×2 (dibuja).

### Parcheo de copperlist (0x0702)

- Escribe 9 words por fila con máscara `and.w #$FE` en la tabla de copperlist; bucle 42 filas ×
  11 registros (462 valores) → **distorsión por scanlines** (la copperlist mueve los punteros de
  bitplane/color por franja).

### Receta para el engine

- 8 acumuladores de fase (enteros), cada uno incrementado por su velocidad por frame.
- Por cada scanline, `offset = sin_table[fase] >> N`; el offset desplaza horizontalmente la fila
  (o cambia el color). Con 8 ondas superpuestas se obtiene un patrón orgánico (ripple/wobble).
- En C++: `int phase[8]`, y por fila sumar los `sin(phase[i] + row*algo)` (con tabla precalculada).

## Pendiente

- Efectos concretos (3D, corridor, blitter) y su algoritmo.
- Música (`mod.elekfunk`, `mod.livin' insanity`, `mod.mobyle`).
- Gráficos (`drwho96.raw`, `hloadpic.raw.im`).
