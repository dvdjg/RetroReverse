# Algoritmos localizados: zoom de imágenes y túnel de suelo/techo

Documento de análisis de dos efectos de «Arte» (Sanity, 1993). Fecha: 2026.

---

## 1. Zoom de imágenes — `0x07E42C`

**Localización**

- Bloque: `out/modules_all/blk_07E42C_l1_20268.bin` (20268 B; variante de `sos.library`:
  cabecera `4E F9 … / 4E F9 … / "sos\0"`).
- Layout interno: stub `0x10-0x9A`; **código `0x9A-0x5F8`**; **datos `0x5F8`+**. Confianza alta.
- Identificación: `effects.md` lo marca como «render de imagen a 4 planos (zoom) + créditos
  "MR.PET"». La zona de datos contiene el string **`MR.PET` 99 veces, cada `0x20` bytes**
  (`0x5F8`, `0x618`, …): tabla de registros de 32 B (charmap/créditos).

**Estructura (máquina de estados por frame)**

- Estado en `$232` (contador) y `$238` (índice de pista). El bucle por frame (`$1EC`) ejecuta:
  `bsr $1746` (WAIT de VBlank/Copper), `bsr $24C` (zoom), `bsr $2D4` (trayectoria),
  `bsr $1710` (blitter), y salta a `$422`/`$9FE`.
- Guarda el stack del efecto (`$234`) y pone `DMACON=$2000/$A000` alrededor del dibujo.

**Algoritmo de zoom** (rutina `$24C`, `$24C-$2CC`)

```
a0 = $3EE2 + [$02D0] + [$02D2]     ; tabla de factores de zoom
v  = (int16)*a0
escala = (v * $00DC) >> 16         ; muls.w #$DC,d0 ; swap  -> Q16
centro = escala + $011D            ; -> $02CE
repite 4 veces (d7=3):
    bsr $193E                       ; dibuja un bloque de 16 filas (d6=0x10, +=0x10)
    a0 += $380                     ; 896 B por bloque (avance de fila en el buffer)
```

- `$02D0` avanza **+6 por frame** hasta `$B4` (`$282-$28C`); `$02D2` se reinicia a `$B4`/0 en
  `$258`. Así se recorre la tabla de factores → el objeto **crece/decrece** en el tiempo.
- El patrón `muls.w #C,d ; swap d` es la **multiplicación Q16** (d·C/65536) usada en toda la demo.

**Algoritmo de trayectoria** (rutina `$2D4`, `$2D4-$360`)

- Lee pares de tablas indexadas por `$238` (avanza **+2**, hasta `$9A`):
  `$3944`, `$38AA`, `$3A78` → escala con `muls.w #$190`/`#$384` + `swap` y aplica un sesgo
  (`−$46`, `−$1C2`) → escribe las **coordenadas** del objeto en la estructura de destino `$416`.
- En `$238 == $9A` reinicia a `$FFFF` (fin de la pista) → control de la animación del zoom.

**Receta para el engine**: tabla de factores de escala (por frame) + tabla de trayectoria; por
frame, `muls Q16` del factor, y blit del bloque escalado a un buffer de 4 planos. Las imágenes
fuente pueden ser **no rectangulares** (ver `toolkit/python/AMIGA_BITMAPS.md`).

**Estado**: localizado y documentado; reimpl **pendiente**.

---

## 2. Túnel de suelo y techo (corridor) — `0x03AFFC`

**Localización**

- El **buffer** del efecto es `out/modules_all/blk_03AFFC_l1_102852.bin` (102852 B; **datos**:
  Copperlist + paleta `@0x146` + datos). Se carga en **chip RAM `0x26614`** (confirmado en vivo;
  paleta en `0x2675A`). El efecto **parchea la Copperlist** (copia los 32 colores). Detalle:
  `../media/palettes/tunnel-VALIDACION.md`. Confianza alta (paleta/estructura).

**Algoritmo (corridor = texture-mapped tunnel de Chaos): raycas por filas**

Para cada fila `y` de la pantalla se lanza un rayo desde el foco y se interseca con el plano del
**suelo** o del **techo**; con la profundidad `z` se calcula la perspectiva y se mapea la textura:

```
z            = (yFloor - m) / (k - slope)          ; suelo
si z < 0:    z = (yCeiling - m) / (k - slope)      ; techo (upsideDown)
k            = y / (zScreen - zFocus)
m            = y + (zFloor - zScreen)/(zScreen - zFocus) · y
inverseZ     = (z - zFocus) / (-zFocus)            ; factor de perspectiva
anchoFila    = ±halfW / inverseZ                   ; recorte horizontal
alpha        = (1 - z/500)                         ; fade con la distancia
trueX        = (x + veerX) · inverseZ              ; coord. de textura (X)
trueY        = z + time/velocidad                  ; avance dentro del túnel (Y)
tile         = scriptSueloTecho[(trueY/altura/4)&0xFF]
```

- **Suelo y techo** tienen cada uno su **script de tiles** (secuencia de tiles/huecos) que se
  recorre con la profundidad; el **avance** es `z + time/vel`.
- **`veer`** (guiño lateral, seno con envolvente suave) desplaza cada fila en X ∝ z; **`slope`**
  (seno) inclina el plano del suelo/techo.
- Paleta de 32 colores (5 planos, `BPLCON0=$5200`); los colores se cargan en la Copperlist por frame.

**Reimpl y límite**

- `reimpl/tunnel/`: fiel al **remake público** (`artsy`), con la **paleta real** de Arte, overlay
  (pared del fondo + colgantes) y compositing del canvas. Estructura **validada** visualmente
  (`../media/reference/corridor-live.png`).
- **Límite:** el **mapa/texturas exactos del original NO se han recuperado** (ni ADF/PP20, ni RAM
  en vivo, ni decodificación del bloque). Ver `tunnel-VALIDACION.md`.

**Receta para el engine**: raycas por fila (suelo/techo) con tablas de perspectiva; scripts de
tiles de suelo y techo; fade por profundidad; paleta cargada en la Copperlist
(cubierto por `reimpl/palette_fade`).
