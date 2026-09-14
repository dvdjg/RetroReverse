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
La matriz se aplica 3 veces (3 líneas repetidas idénticas para X, Y, Z).

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

## Túnel con textura mapeada (bloque 0x03AFFC)

- Evidencia: `out/modules_all/blk_03AFFC_102852.bin` (descomprimido del ADF 0x03AFFC,
  track 21, l1=102852). Buffer del efecto. Confianza **media** (estructura parcial).
- Descripción (confirmada por comentarios de pouet): **texture-mapped tunnel de un solo pixel
  a 50 Hz** — un túnel de profundidad donde cada columna/pixel del anillo se calcula con
  trigonometría (tabla SINE) y se mapea una textura. Es el efecto de apertura de «Arte».
- El bloque empieza con cabecera `[1d 01 ff fe]` (4 B) + configuración de display:
  `DIWSTRT=$2981, DIWSTOP=$29C1, DDFSTRT=$38, DDFSTOP=$D0, BPLCON0=$5200` (5 planos, 320 px).
- El bloque contiene **4 copperlists encadenadas** (marcadores `[01 ff fe]` en 0x1, 0x119, 0x5969,
  0x178F7) — una por zona/banda de la pantalla (el túnel usa listas por anillo).
- **Formato de copperlist SOS**: MOVE = `[opcode 0][reg][valor]` (igual que el estándar pero con
  opcode `0` en vez de `01`). Los punteros BPL/SPR y colores van a 0 (el demo los parchea por
  frame). Confianza alta (decodificada: 69 moves en la primera lista).
- **Paleta del túnel extraída** (32 colores 12-bit): `recovered/media/palettes/tunnel-palette.json`.
  Degradado de profundidad blanco→rojo→grises→negro (`FFF,FFC,FD9,...,911,800,700,600,...,000`).
  Confianza alta.
- La textura mapeada está en la zona de datos (0x119-0x5969 y 0x5969-0x178F7) pero su layout
  exacto (resolución/planos/stride) no se ha confirmado; quedan candidatos sin validar
  (WIP). El túnel es **procedural + textura**: los anillos se calculan con SINE y se mapea la
  textura.
- Receta para el engine: el túnel 3D se puede hacer con una tabla de ángulos por columna y una
  textura; por frame se actualizan los punteros BPL/Copper. El pre-cálculo en tablas evita
  trigonometría en el bucle caliente.

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

## Pendiente

- Efectos concretos (3D, corridor, blitter) y su algoritmo.
- Música (`mod.elekfunk`, `mod.livin' insanity`, `mod.mobyle`).
- Gráficos (`drwho96.raw`, `hloadpic.raw.im`).
