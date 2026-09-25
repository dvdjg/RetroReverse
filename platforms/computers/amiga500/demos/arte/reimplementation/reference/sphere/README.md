# reimplementation/reference/sphere — esfera con textura mapeada (efecto de Chaos)

Recreación en C++ del **efecto "16 color sphere"** de «Arte». El render reproduce **byte a byte**
el original (verificado contra los checksums de referencia).

## La técnica (efecto lente / texture mapping)

Es un **mapa de coordenadas fijo**, no geometría: nada de la forma de la esfera se calcula en
runtime y nada se mueve salvo un único número.

```
para cada píxel (x, y):
    off    = map[x, y]                        (* fijo: da forma y sombreado *)
    texel  = texture[(off + d) & 0xffff]      (* +d: la rotación (16 bits)    *)
    colour = palette[texel]                   (* 16 colores                  *)
```

- `d` (rotation, 16 bits): byte alto = scroll vertical, byte bajo = horizontal.
- La textura es **exactamente 256×256**, así que `& 0xffff` es wraparound gratis (sin bordes).
- El contorno es **data**: los píxeles fuera de la bola usan un offset centinela (`$fffc`/`$fffd`)
  que produce el fondo, sin un solo `if` de "¿dentro o fuera?".
- El mapa es **separable, no radial**: U (byte alto) depende de (fila, x), V (byte bajo) de
  (columna, y). Se genera desde dos tablas de 256 bytes (`extent` semicírculo, `profile` arcsen).

## Origen de los assets (obra de Ra/Sanity)

La textura y las tablas fueron **recuperadas de la demo en ejecución** y compartidas públicamente
por Jon Ludlam en su reimplementación (`ocaml-arte-sphere`). **Son obra de los autores de «Arte»**
(Ra de Sanity) y NO están cubiertas por la licencia MIT de este expediente: se incluyen solo para
estudio.

| Fichero | Contenido |
|---|---|
| `data/texture-256x256-4bit.bin` | textura 256×256 (niveles 0–15 por texel) — **la obra de Ra** |
| `data/palette.txt` | los 16 colores (12-bit $0RGB + RGB 8-bit) |
| `data/reference-checksums.txt` | FNV-1a de 263 rotaciones (verificación) |
| `sphere_frame_d4936.png` | frame renderizado en C++ (rotation `$4936`) |

La técnica exacta y el generador del mapa (en `$2de7ea` del módulo) fueron recuperados por Jon
Ludlam; ver su README para el detalle del chunky-to-planar y el truco de BPLCON1.

## Contenido

| Fichero | Descripción |
|---|---|
| `src/sphere.hpp` / `src/sphere.cpp` | generador del mapa + render (fiel al original) |
| `src/motion.hpp` / `src/motion.cpp` | el **tumble** (4 fases + senos + integradores) |
| `src/tables.hpp` | `extent`/`profile` (256 B c/u, del generador original) |
| `src/test_sphere.cpp` | test: verifica FNV-1a + genera la animación (64 frames) |
| `sphere_frame_d4936.png` | frame renderizado (rotation `$4936`) |
| `sphere_anim.gif` | animación del tumble (64 frames, 192×180) |
| `Makefile` | `make test` |

## Movimiento (tumble)

Recuperado por Jon Ludlam del código de la parte (fase en `$2de950`, velocidad en
`$2de9c2`). Una vez por vblank (50 Hz), cuatro contadores de fase avanzan por pasos fijos
(`$50,$2c,$12,$2e`) y dos sumas de senos escaladas integran en dos acumuladores; la rotación
toma su byte vertical de uno y el horizontal (doblado) del otro. La demo renderiza a 25 fps desde
un movimiento a 50 Hz (**2 steps por frame**).

```
rotation = (acc_v & 0xff00) | (((acc_h >> 8) * 2) & 0xff)
```

Validado: la rotación evoluciona (`$0000` → … → `$88c6` en 64 frames) y los frames se validan
visualmente como una esfera con textura mapeada.

## Validación

**Exhaustiva**: las **263 rotaciones** del manifest de referencia (`reference-checksums.txt`)
coinciden byte a byte (FNV-1a) con el render de `reimplementation/reference/sphere`.

```
rotation 0x0000 -> fnv1a d73572b1  (esperado d73572b1) OK
rotation 0x0119 -> fnv1a de4efa35  (esperado de4efa35) OK
rotation 0x0232 -> fnv1a e3a4c201  (esperado e3a4c201) OK
manifest: 263/263 rotaciones coinciden
```

Es **byte-exacto** al original. El detalle que decidía el bit-exacto: el `profile_table` se lee
como **byte con signo** (`-128..127`) y se extiende a 16 bits — leerlo sin signo corrompe todas
las rotaciones.

> Nota: los `frames/*.png` publicados junto al código original se generaron con una versión de
> **208 columnas** (el buffer completo); la salida actual (y la verificada por el manifest) es de
> **192 columnas**. Por eso se compara contra el manifest, no contra esos PNG.

## Reproducir / validar

```sh
make test
```

## Notas

- El movimiento (tumble) no es un giro a velocidad constante: cuatro acumuladores de fase avanzan
  por vblank y un sumatorio de senos integra en los bytes de rotación (recuperado por Jon Ludlam
  en `$2de950`/`$2de9c2`). Aquí solo se implementa el render (una rotación dada).
- El buffer es 208 columnas y 90 filas; el **copper dobla las filas** (192×180 en pantalla) y
  **BPLCON1** une las dos mitades de bits (odd/even) desplazando 8 columnas.
- La resolución horizontal real es 128 (la textura está duplicada por columnas adyacentes).