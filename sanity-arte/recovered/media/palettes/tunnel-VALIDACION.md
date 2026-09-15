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

### Corrección: los bloques de código grandes son el runtime SOS + cruncher

Clasificación de los bloques de código por instrucciones características (capstone m68k):

| bloque | len | muls | divs | rot | strings clave |
|---|---|---|---|---|---|
| `0A502C` | 32500 | 77 | **185** | 37 | `IMP!`, `sos.library`, `DBUG`, `SINE` |
| `0B0C2C` | 63064 | 161 | 85 | 1 | motor 3D + fade (idioma previo) |
| `026A2C` | 114408 | 84 | 137 | 30 | `sos.library` (runtime completo) |
| `08B028` | 19484 | 28 | 49 | 2 | `sos.library`, `DBUG`, `SINE` |
| `0A3C2C` | 38628 | 16 | 21 | 3 | — |

`0A502C` (el más intensivo en divisiones) contiene el string **`IMP!`** → es el **decruncher**, no
el corridor. Todos los bloques comparten los strings del runtime (`sos.library`, `DBUG`, `SINE`),
así que **los efectos reales NO están en estos bloques**: están en los módulos `SOSchaos*` del
directorio, **inaccesibles sin resolver el cargador** (paso 2 bloqueado).

### Paso 2 (cargador) — bloqueado por falta de código

El bootblock lee el **cilindro 0** completo (`io_Offset=0`, `io_Length=11264`, vía
`trackdisk.device`) y salta al `main`. Pero el `main` desensamblado (`main_cand.asm`, 579 KB) **no
contiene** la rutina de disco (sin referencias a `trackdisk`/`11264`), y `SOSloadmodule` (1132 B) no
está decrunchado. Por tanto la semántica de `track`/`offset` **sigue sin resolver**.

**Conclusión:** ambas vías quedan bloqueadas por la misma causa raíz — **faltan los módulos de
efecto (`SOSchaos*`)**. Para desbloquear: (a) extraer el cruncher IMP! y localizar el directorio
real de datos (no ya el de metadatos), o (b) desensamblar el `main`/`SOSloadmodule` completos.

## Intento desde el volcado de RAM (paso 1 revisado)

`out/ram/live-slow.bin` (RAM en `0xC00000`, 0x80000 B) **sí** contiene el runtime y el directorio:

- Directorio en `0xC036F0` (32 B/entrada: `track` long BE + `offset` word LE + `size` long BE,
  nombre en `+0x0A`). **No guarda direcciones de carga.**
- Cabeceras de módulo en RAM = `4E F9 <abs> "sos\0"` (jmp absoluto; por eso no las detectaba la
  firma de disco `...00 10 4E F9`). Solo hay **3**, y las tres son `sos.library`
  (`0xC03B80`, `0xC05EF8`, `0xC70218`).
- **Los módulos `SOSchaos*` NO están cargados** en el momento del volcado (se cargan/descargan bajo
  demanda). El chip RAM tampoco los contiene.

**El cruncher está en RAM** (`0xC02280`): reconoce por firma de 4 bytes **`PP20` (PowerPacker)**,
`CrM!`, `CrM2`, `Crm!` e `IMP!` → es un **descompresor multi-formato**. Pista: algunos módulos
podrían usar **PowerPacker**, no solo IMP!.

**Resultado:** no se pudo extraer el corridor de este volcado. Para lograrlo hace falta capturar la
RAM **durante** el efecto (breakpoint en el `corridor`), o resolver el cargador.





