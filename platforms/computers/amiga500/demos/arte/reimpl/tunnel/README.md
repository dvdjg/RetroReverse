# reimpl/tunnel — túnel bitmap raytraced («Arte», Sanity 1993)

Recreación en C++ del efecto **túnel** de «Arte». A diferencia de los efectos de mapa fijo
(p. ej. la esfera), este es **geometría real calculada por frame**: un rayo por fila de pantalla.

## La técnica (raycast por filas)

Para cada fila `y` de la pantalla se lanza un rayo que sale del foco, se interseca con el
**plano del suelo** (`y = a·z + b`, `a` = pendiente animada, `b = yFloor`) o con el **techo**
(`yCeiling`) y se obtiene la profundidad `z`. Con `z` se calcula el factor de perspectiva de la
fila y se estira la textura a lo ancho:

```
z            = (yFloor - m) / (k - slope)          ; suelo
k            = y / (zScreen - zFocus)
m            = y + (zFloor - zScreen)/(zScreen - zFocus) · y
inverseZ     = (z - zFocus) / (-zFocus)            ; factor de perspectiva
anchoFila    = ±halfW / inverseZ                   ; recorte horizontal
alpha8bit    = (1 - z/500) · 256   (fade con la distancia)
trueX        = (x + veerX) · inverseZ              ; coord. de textura
trueY        = z + time/velocidad                  ; avance dentro del túnel
tile         = script[(trueY / altura / 4) & 0xff] ; script de suelo/techo
```

- **Avance**: sumar `time / velocidad` a `Y` mueve la textura hacia el observador (el túnel "se
  traga" al espectador). La velocidad es `1/2` (2 px de Z por ms).
- **Guiño lateral (`veer`)**: un seno con envolvente suave (`smooth`) desplaza cada fila en X
  proporcionalmente a `z`, curvando el túnel. Empieza en `time ≈ 15490 ms`.
- **Pendiente (`slope`)**: un seno (`×1.5`) inclina el plano del suelo/techo (túnel que sube/baja).
- **Script de suelo/techo** (`floorScript`/`ceilingScript`): una cadena donde cada carácter elige
  el tile de la textura (`'a'`..`'d'`) o deja un hueco (`' '`, no se dibuja). Recorre la
  profundidad, así que al avanzar aparecen y desaparecen tramos del túnel.
- **Pared y colgantes**: al acercarse al final (`distanceToWallZ < 500`) se dibuja `tunnelWall`
  (fondo) y `tunnelHanger` (colgantes del techo) como overlay.
- Fuera de `z < 500` (o en un hueco del script) el píxel queda negro.

## Assets (obra de Sanity, 1993)

| Fichero | Contenido |
|---|---|
| `data/tunnelBits.png` (`.rgba`) | textura del túnel: 80×30, 4 tiles «a»–«d» de 20 px |
| `data/tunnelWall.png` (`.rgba`) | pared del fondo: 128×64 |
| `data/tunnelHanger.png` (`.rgba`) | colgantes del techo: 160×30 |

Los `.rgba` son la conversión sin comprimir (RGBA) de los `.png`; el test lee los `.rgba`.

## Límite: el mapa del original no está recuperado

Este módulo reproduce la **geometría del remake público** (`artsy`) con la **paleta real** de Arte
aplicada. El **mapa/gráficos exactos del corridor original NO se han recuperado** por ninguna vía
probada (ADF, bloques PowerPacker, RAM en vivo, ni decodificación del bloque `0x03AFFC`). Ver el
detalle y los intentos en `../../recovered/media/palettes/tunnel-VALIDACION.md`.

Por tanto **no se debe esperar byte-exactitud** contra el original: la **estructura sí** está
validada (Ollama: «strongly resembles» la captura real `corridor-live.png`) y la **paleta** coincide
al 100%, pero las texturas son las del remake.


## Confianza

- **Mecánica raytraced, avance, veer, slope, script de tiles: ALTA.** Verificada por el perfil de
  perspectiva de los frames (las paredes convergen 320→73 px hacia el centro) y validación visual.
- **Overlay (pared del fondo + colgantes): implementado**, fiel a `bitmap-tunnel-scene.js`
  (`drawImage` con alpha). Verificado: la pared aparece cuando `distanceToWallZ < 500` y los
  colgantes cuando el script de techo lo indica.
- **Parámetros exactos de la demo original (rangos temporales, foco, planos): MEDIA.** Provienen
  del remake JS de referencia (`bitmap-tunnel-scene.js`), no del desensamblado del bloque
  `0x03AFFC` de Arte. Sin checksums byte-exactos del original.
- **⚠️ Los assets NO son los del original.** Ver `../../recovered/media/palettes/tunnel-VALIDACION.md`:
  la paleta real de Arte (`0x03AFFC+0x146`) es una **rampa de 32 colores** (5 bitplanes), y
  `tunnelBits.png` (368 colores azules/verdes) **no** está en ella. Este módulo reproduce fielmente
  **el remake de Tornblad**, no (todavía) el original.

## Contenido

| Fichero | Descripción |
|---|---|
| `src/tunnel.hpp` / `src/tunnel.cpp` | assets, offsets y render raytraced |
| `src/test_tunnel.cpp` | test de estructura + volcado de frames (`anim/*.raw`) |
| `anim/tunnel_anim.gif` | animación (32 frames del rango visible) |
| `anim/contact-sheet.png` | 6 frames para inspección visual |
| `Makefile` | `make test` |

## Variante con la paleta real de Arte (palette swap)

Para acercar el remake al **original**, `src/test_tunnel.cpp` genera además una segunda secuencia
(`anim_arte/`) con los assets **cuantizados a la paleta real de Arte** (32 colores del bloque
`0x03AFFC`, ver `data/palette-arte.json` y `tunnel-VALIDACION.md`). La geometría es la misma; solo
cambia el color.

Verificación con Ollama (qwen3-vl, `toolkit/python/ollama_vision.py`) sobre tiras de 4 frames
consecutivos:

| Secuencia | Converge a punto de fuga | Movimiento coherente | Colores dominantes |
|---|---|---|---|
| `anim/strip.png` (remake) | sí | sí | magenta/púrpura, teal/azul, verde |
| `anim_arte/strip.png` (paleta de Arte) | sí | sí | rojo, marrón, negro |

La comparativa directa (`anim/compare-remake-vs-arte.png`, mismo instante) confirma: **misma
geometría, distinta paleta** (fila superior azul/verde, inferior rojo/marrón).

## Validación

`make test` comprueba: tamaños de assets, igual longitud de ambos scripts, buffer correcto,
negro tras el fin (`t > 30720`), **32/32 frames con contenido** y frames distintos con el tiempo.
El análisis objetivo del perfil (ancho por fila) confirma la convergencia al centro.

## Reproducir / validar

```sh
make test          # compila y ejecuta (necesita un g++ con -static; en Windows: WSL)
```

## SOURCE / trazabilidad

Ver `SOURCE`. Los gráficos son **obra de Sanity** (distribuidos en el remake `artsy` de Anders
Tornblad) y se incluyen solo para estudio.
