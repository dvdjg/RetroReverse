# Validación del túnel contra el bloque real `0x03AFFC`

Fecha: 2026. Método: análisis binario del bloque decrunchado
`out/modules_all/blk_03AFFC_l1_102852.bin` (102852 B) y de la captura de referencia
`../reference/arte-effect-corridor.png`.

## Qué es el bloque `0x03AFFC`

Es el **buffer del efecto "corridor"** (el túnel de Arte), no un módulo de código:

- **NO contiene código 68k** (`rts`=0, `link`=0). Los módulos de código empiezan con
  `4E F9 00 00 00 10 4E F9 00 00 00 xx "sos"` (dos `jmp` + firma SOS).
- Empieza con una **copperlist** (`DIWSTRT=$2981`, `DIWSTOP=$29C1`, `DDFSTRT=$38`,
  `DDFSTOP=$D0`, `BPLCON0=$5200`), seguida de la paleta y datos mixtos.
- `BPLCON0=$5200` → bits 14-12 = `101` = **5 bitplanes = 32 colores**.
- `DMACON=$802F` (SET|BPLEN|COPEN|…).
- Coherente con `modules.md` mod_007: «bloque mixto — 392 copper moves + 23 WAIT-fin +
  datos. Candidato al efecto principal (título/corridor)».

## Paleta

La paleta del túnel está en el **offset `0x146`** del bloque, como **32 words big-endian
12-bit** (`$0FFF, $0FFC, $0FD9, …`). Coincide **exactamente** con
`recovered/media/palettes/tunnel-palette.json` (rampa blanco→naranja→rojo→marrón→gris +
negro). **Confianza ALTA.**

## Comparación con los assets del remake (`artsy`)

`reimpl/tunnel/data/tunnelBits.png` (textura del remake de Anders Tornblad):

- **368 colores únicos**, dominados por azules/verdes/magentas (p. ej. `(0,95,125)`,
  `(44,77,9)`, `(187,50,148)`).
- **Ninguno de esos colores está en la paleta del original** (la paleta de Arte es una rampa
  roja/marrón/gris, sin azul ni verde).
- La secuencia de la paleta tampoco aparece asociada a ninguna textura del bloque.

La captura `arte-effect-corridor.png` sí usa la paleta del original (58,2 % de sus píxeles
cuantizados a 12-bit están en la paleta; dominan `$000` y `$300` = rojo oscuro `#330000`).

## Conclusión (con grados de confianza)

- **Paleta del túnel = `tunnel-palette.json`, 32 colores, 5 bitplanes: ALTA** (byte-exacta en
  el bloque real).
- **El túnel de Arte es el efecto "corridor" de Chaos**, hecho con **texture mapping**
  (como el resto de efectos de Chaos), no un raytrace. **MEDIA** (por la técnica de Chaos y
  la forma de la captura; el mapa fijo + textura exactos aún no localizados).
- **`tunnelBits.png` / `tunnelWall.png` / `tunnelHanger.png` NO son assets originales de
  Arte: ALTA**. Son gráficos del remake; útiles para reconstruir *una* versión del efecto,
  pero **no** para reproducir el original.
- Por tanto, `reimpl/tunnel/` **reproduce fielmente el remake de Tornblad**, no (todavía) el
  original. Corrige la confianza «media» previa: la mecánica del remake es correcta, pero su
  **paleta/texturas son de otra recreación**.

## Pendiente para subir la confianza a ALTA (original)

- Localizar el **mapa de coordenadas** y la **textura** del corridor (probablemente en el
  bloque `0x03AFFC` o en un módulo de efecto): el bloque contiene datos con una estructura
  regular de **40 bytes** (35 datos + relleno) aún sin identificar.
- O recuperar la técnica de un remake *fiel* al original (paleta roja), como se hizo con la
  esfera (`ocaml-arte-sphere`).

## Verificación de las secuencias con Ollama

Con la **palette swap** a la paleta de Arte (`reimpl/tunnel/anim_arte/`), la verificación con
`qwen3-vl` sobre tiras de 4 frames **consecutivos** da resultados coherentes y consistentes:

- Converge a un punto de fuga central (es un túnel): **sí**.
- Movimiento coherente entre frames: **sí**.
- Colores dominantes: **rojo, marrón, negro** (los de la paleta de Arte).
- La comparativa mismo-instante (`anim/compare-remake-vs-arte.png`) confirma geometría idéntica y
  paleta distinta (arriba azul/verde del remake; abajo rojo/marrón de Arte).

Nota metodológica: el modelo de 8B **necesita frames consecutivos** para juzgar el movimiento; con
frames muy separados (32 frames en 30 s) describe la imagen como «collage fragmentado». Los
frames del remake también convergen (túnel válido); solo cambian los colores.

## Intentos de localización del mapa/textura (pasos 1 y 2)

### Paso 1 — la estructura de 40 bytes del bloque `0x03AFFC` NO es una imagen

Los datos (desde `0x790`) tienen un **periodo de 40 bytes** (≈35 no-cero + 5 cero) y words
int16 saturados: top valores `0` (29525), `-1` (4253), `-32768` (708), `32767` (634), `-256`,
`127`, `255`, `-128`. Rampa característica: `80 00 00 00 00 00 7f ff` (= -32768, 0, 0, 32767).

Se decodificó como imagen en varios formatos y offsets (`0x790`/`0x800`): chunky 320×128 y
160×200, planar 1 y 5 planos 320 px (stride 40). **Todas salen ruido** — verificado a ojo y con
Ollama («noise/garbage», ningún panel coherente). Hipótesis «imagen» **descartada**.

Interpretación probable (confianza baja): buffer de coordenadas/valores de 16 bits (¿tabla de
interpolación, ¿warp?, ¿scanline?) aún **sin identificar**.

### Paso 2 — los módulos `SOSchaos*` no se pueden extraer por el directorio

- La fórmula `track*11264 + offset` **sí** localiza el bloque `0x03AFFC` (track 21), pero al
  leer los módulos SOS en esa posición los datos **no son cabeceras** (`jmp`+`"sos"` ni `IMP!`):
  son datos variables (audio/tablas). La semántica de `track`/`offset` del directorio sigue
  **sin resolver** (coincide con lo que ya anotaba `modules.md`).
- Los tamaños de `SOSchaos1/2/3` (15004/2776/16940) y `SOSes` (18284) **no coinciden con ningún
  `l1`** de los 41 bloques IMP! → no se pueden cruzar por tamaño.

Conclusión: el mapa/textura del corridor original sigue **sin localizar**. Vías alternativas
(abajo) más prometedoras que insistir en `0x03AFFC`.

### Búsqueda del motor de Chaos (falso positivo a documentar)

Se buscaron las tablas de la esfera de Chaos (`extent`/`profile` de 256 B, `sphere/src/tables.hpp`)
en los 41 bloques. Aparecieron coincidencias de **subsecuencias de 32 B** en `blk_08B028` (19484 B)
y `blk_096A28` (3260 B). **PERO la tabla de 256 B completa NO está en ninguno** (`find` = -1):
eran **coincidencias parciales** en datos suaves → **falso positivo**, no una pista válida.

Dato sí confirmado: `blk_08B028` y `blk_096A28` son **variantes de `sos.library`** (misma cabecera
`4E F9 00 00 00 10 4E F9 00 00 00 9A "sos"` y mismas instrucciones iniciales), con efectos
embebidos. El corridor debe estar en una de esas variantes, **pendiente de desensamblar**.



