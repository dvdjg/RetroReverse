# Portar zoom de imágenes y túnel de suelo/techo a un engine (Amiga 500, 50 Hz)

Guía de implementación basada en el análisis de «Arte» (Sanity, 1993) y en las restricciones
reales del A500 OCS (68000 @ 7,09 MHz, blitter, copper, 512K chip + 512K slow).
Objetivo: reproducir ambos efectos **a 50 Hz fluidos**, con el reparto correcto entre HW, ASM y C.

---

## 0. Presupuesto de tiempo (lo primero que hay que asumir)

- **1 frame PAL = 20 ms.** A 7,09 MHz son ~+141.000 ciclos **nominales**, pero con DMA del blitter,
  copper, bitplanes y refresh, la CPU disponible baja fácilmente a **~60–90.000 ciclos**.
- Regla práctica: **el bucle visible (por píxel) casi nunca puede estar en la CPU.** Lo que se
  ejecuta por píxel debe hacerlo **el blitter** o **el copper**; la CPU sólo prepara punteros/tablas.
- Todo lo que sea periódico y costoso se **precalcula** (la demo lo hace: `SINE.soslibrary`,
  mapas de coordenadas, tablas de factores de zoom, trayectorias).

---

## 1. Reglas de oro para «súper fluidez» (aplican a los dos efectos)

1. **Tablas, no trigonometría.** `sin/cos/atan` se precalculan una vez (la demo usa una tabla de
   seno Q1.14 de 1024/65536 entradas). En runtime sólo se indexa y se suma.
2. **Multiplicación Q16 = `muls.w` + `swap`** (`(a*b)>>16`), como en el motor 3D y el zoom de la
   demo. Nunca `float`, nunca `mul` de 32×32 si se puede evitar.
3. **El blitter mueve, rellena, mezcla y desplaza.** Los bucles de píxel se sustituyen por
   `BLTCON0/1` + `BLTxMOD` + `BLTxPT` + `BLTSIZE`. La CPU queda libre mientras el blitter trabaja.
4. **El copper cambia registros por scanline** (colores, punteros de bitplane, módulos) sin CPU.
5. **Doble buffer de bitplanes** (front/back) y **swap en VBlank** (o al terminar el blitter del
   frame), nunca a mitad de frame.
6. **Sincronía a 50 Hz**: el efecto se "engancha" a la interrupción vertical (VBlank). La demo usa
   el copper/`$DFF09C` y contadores de frame.
7. **Chunky→planar por tabla** si se genera color por píxel (túnel): convertir el buffer chunky a
   los 5 planos con tablas de 256/65536 entradas por el blitter o por ASM compacto.
8. **Alineación y auto-incrementos**: punteros alineados a 8/16 B, usar `move.l`/`movem` y los
   modos `(a0)+` para no perder ciclos.
9. **Presupuesto por frame**: repartir en (a) copper durante todo el frame, (b) blitter en paralelo,
   (c) CPU sólo entre el final del blitter y el próximo VBlank.

---

## 2. Zoom de imágenes (localizado en `0x07E42C`)

### 2.1 Algoritmo (lo que hace la demo)

- Máquina de estados por frame. **Zoom** (rutina `$24C`):
  `a0 = $3EE2 + [$2D0] + [$2D2]`; `escala = (int16)(*a0) * $DC >> 16`; `centro = escala + $11D`;
  luego **4 bloques de 16 filas** con `bsr $193E`, avanzando **$380 (896) bytes** por bloque.
- **Trayectoria** (rutina `$2D4`): tablas `$3944/$38AA/$3A78` indexadas por un contador (`+2` por
  frame, hasta `$9A`), escaladas con `muls.w #$190/#$384` + `swap`, con sesgo → coordenadas del
  objeto. (`$238 = $FFFF` = fin de pista.)
- Conclusión: **no es un zoom "libre"**: es una **secuencia de factores y posiciones
  precalculada** (una animación), dibujada por bloques.

### 2.2 Cómo portarlo fluido (A500)

- **Precalcular**:
  - tabla de **factores de escala** por paso (`$3EE2`): `int16` con el factor Q16 ya multiplicado;
  - tabla de **trayectoria** (x, y) por paso;
  - para cada factor, si conviene, **la lista de filas fuente** a muestrear (evita multiplicar por
    frame).
- **Dibujo por el blitter**, no por CPU:
  - **Zoom vertical** (más o menos filas): se consigue repitiendo/omitiendo **filas fuente** en el
    blit (uno o más blits de 1 línea) o con **BLTBDOFF** por línea si se hace "line mode".
  - **Escala horizontal**: con el **shifter del blitter** (`BLTCON0` bits de shift A/B, `BLTCON1`
    DESC) y `BLTxMOD` negativos para leer de una fuente ya desplazada. Alternativa barata: precomputar
    la fila ya desplazada.
  - Un patrón típico: por cada **banda de salida** de `N` líneas, `BLTSIZE = N<<6 | ancho/2` y dejar
    que el blitter estire/repita la misma fila fuente con `BLTxMOD = 0` (repetición vertical).
- **Doble buffer** y swap de punteros BPL en VBlank.
- **Copper**: si el zoom cambia la paleta por bandas, hacerlo con el copper.

### 2.3 Qué en ASM y qué en C

- **ASM obligatorio**: el **bucle de preparación de blits** (cálculo de `BLTxPT/MOD/SIZE` por banda)
  y cualquier *inner loop* de 1 línea. Es donde más se nota.
- **C válido**: carga de imágenes/planarización (una vez), gestión de estado, trayectoria/tablas.
- **Trampa**: hacer el escalado con `for` por píxel en C → no llega ni de lejos. El zoom "de verdad"
  es **blitter + tablas**.

---

## 3. Túnel de suelo/techo (corridor, `0x03AFFC`)

### 3.1 Algoritmo

Por cada fila `y` se lanza un rayo; se interseca con el plano del **suelo** o del **techo** y se
mapea la textura:

```
z      = (yFloor - m) / (k - slope)        ; si z<0 -> usar yCeiling (techo)
k      = y / (zScreen - zFocus)
m      = y + (zFloor - zScreen)/(zScreen - zFocus) · y
izf    = (z - zFocus) / (-zFocus)          ; factor de perspectiva
trueX  = (x + veerX) · izf                 ; coordenada de textura X
trueY  = z + time/vel                      ; avance dentro del túnel Y
tile   = script[ (trueY / altura / 4) & 0xFF ]   ; script de SUELO y de TECHO
color  = textura[tile][ (trueX,&) , (trueY,&) ]  ; atenuado por (1 - z/500)
```

Claves: **suelo y techo tienen su propio script de tiles**; el avance es `z + time/vel`; `veer`
(seno suave) desplaza en X proporcional a `z`; `slope` (seno) inclina el plano; la paleta (32
colores) se carga en la **Copperlist**.

### 3.2 Cómo portarlo fluido (A500) — **precalcular el mapa**

Aquí está el truco grande: **NO hacer el raycas por frame** (el remake lo hace en JS y es
inviable en 68000). La técnica clásica de Chaos es un **mapa de coordenadas fijo**:

- **Una vez** (al entrar al efecto, o "asado" en disco): para cada píxel `(x,y)` calcular
  `offset(x,y)` = índice a la textura (`trueX,trueY`, o un `uint16` de offset). Se guarda como
  **mapa de bytes/words**. Esto es idéntico a la esfera de 16 colores (`reimplementation/reference/sphere`), que usa un
  mapa fijo de `90×96` words + textura.
- **Por frame** (50 Hz): sólo se **suma** el desplazamiento de animación (`time/vel`) al offset y se
  **indexa la textura**. El bucle de píxel es `color = textura[(offset[x,y] + d) & 0xFFFF]`.
- **Planarización**: el "color por píxel" se escribe **chunky** y se convierte a los **5 planos**:
  - con **tabla** de conversión de 8 bits→plano, o
  - con el **blitter**: rellenar los 5 planos usando `BLTCON0/1` con las máscaras de bits
    (técnica "chunky to planar": 4-6 blits por bloque de 16 píxeles con tablas de 256 entradas);
  - la demo usa un mapa de coordenadas + `move`/`eor`/`and`, que es exactamente esto.
- **Copper**: la paleta de 32 colores se carga/`fade`a en la Copperlist (cubierto por
  `reimplementation/reference/palette_fade`); si el túnel cambia el fondo por bandas, hacerlo con el copper.
- **Doble buffer** y punteros BPL por frame.

### 3.3 Qué en ASM y qué en C

- **ASM obligatorio**:
  - el **bucle de píxel/planarización** (`offset lookup + textura + escritura de planos`), que es
    el 90% del coste;
  - el **chunky→planar** (tablas + `movem`/`move.l` en bloques de 32/64 bits).
- **C válido**:
  - **generar el mapa** (una vez; puede tardar) y las tablas;
  - gestión de paleta/copper, scripts de tiles, lógica del juego.
- **Atajo del motor**: si el engine ya tiene un **sistema de "efectos por mapa + textura"**
  (como `sphere`/`tunnel`), ambos efectos son **el mismo motor** con distinto mapa y scripts.

---

## 4. Cómo y cuándo se procesa (timing)

- **Frecuencia**: todo va atado a **VBlank (50 Hz)**. Nada de "render as fast as possible".
- **Reparto por frame**:
  1. **Copper** (toda la línea): colores/punteros por scanline.
  2. **Blitter**: trabaja en paralelo a la CPU; al lanzarlo (`BLTSIZE`), la CPU sigue.
  3. **CPU**: sólo preparar el frame N+1 (punteros, `BLTxPT/MOD/SIZE`, offsets de animación).
- **Armonización**: swap de buffer **en VBlank**, esperando `BLTDONE` (`$DFF002` bit 6 y bit 14)
  antes de tocar el buffer mostrado.
- **Doble buffer** obligatorio para evitar *tearing* (BPLxPT apuntan a front; se dibuja en back).
- **Contención**: el blitter y la CPU comparten el bus de chip RAM. Cuanto más del trabajo esté en
  **chip RAM con blitter** y menos la CPU, mejor (la slow RAM es más rápida para la CPU).

---

## 5. Regla de decisión C vs ASM (resumen)

| Parte | Dónde | Por qué |
|---|---|---|
| Generar tablas/mapas (1 vez) | **C** | coste amortizado; corrección |
| Carga y planarización de imágenes | **C** (o ASM si caliente) | una vez |
| Preparación de blits por banda/frame | **ASM** | ciclos críticos |
| Bucle de píxel del túnel / planarización | **ASM** | 90% del coste |
| Zoom vertical/horizontal | **blitter** | no hacerlo en CPU |
| Paleta y cambios por línea | **copper** | gratis para la CPU |
| Lógica de estado del efecto | **C** | no es el cuello |

**Conclusión honesta:** «casi todo es aprovechar el HW» (blitter + copper + tablas) **y** el 10–20%
restante es ASM en bucles de píxel. Un port **puro en C** del bucle visible en un A500 real **no
llega a 50 Hz**: es la parte que hay que escribir en ASM (o delegar al blitter) para que sea fluido.

---

## 6. Trampas a evitar (implementaciones defectuosas)

- **Raycas/trigonometría por frame**: inviable en 68000 → precalcular el **mapa**.
- **Floats**: nunca en el bucle; usar Q16 (`muls.w`+`swap`).
- **Dibujar con la CPU lo que puede hacer el blitter** (rellenos, desplazamientos, copias).
- **Cambiar punteros de bitplane a mitad de frame** → rasgado; hacerlo en VBlank.
- **No esperar `BLTDONE`** antes de reutilizar el mismo buffer → corrupción.
- **Ignorar la contención de bus**: el blitter a chip RAM es más lento (2 ciclos/word) pero no
  consume CPU; usarlo bien es más rápido que la CPU copiando.
- **Planarizar mal**: los 5 planos deben escribirse con offsets por módulo (`BPL1MOD/BPL2MOD`)
  correctos; un error de módulo desplaza la imagen entera.

*(Ver también `extraction/disassembly/ALGORITMOS_ZOOM_Y_TUNEL.md`, `docs/TECNICAS.md` y
`platforms/computers/amiga500/tools/python/AMIGA_BITMAPS.md`.)*
