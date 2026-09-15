# Mapa de efectos y códigos — Sanity «Arte»

Identificación de los 41 bloques IMP! del ADF (descomprimidos en `out/modules_all/`), con lo que
se ha podido determinar. Confianzas: alta (desensamblado/código leído), media (inferido),
baja (pendiente).

## Clasificación por uso de la API de SOS (LVOs)

Con el mapa de LVOs (`reference/sanity-os-v26/LVO_MAP.md`) se ve qué funciones SOS usa cada
bloque, lo que ayuda a clasificarlo:

| Bloque | Funciones SOS destacadas | Pista |
|---|---|---|
| `0x078A2C` (main) | AllocMem, **Randomize×4**, **AltKick×2** | loader con gestión de memoria alterna (cambia entre efectos) |
| `0x05402C` | **Load** | carga un archivo (música) |
| `0x0B0C2C` | **Load + LoadDecrunch**, SetCopperAdr×7, SetCopperCol×3, Fade | motor con carga de assets + display complejo |
| `0x04BC28` | **Fade×5**, SetCopperAdr×4, SetCopperCol×3 | efecto con **fade de paleta intenso** |
| `0x08B028` | **Fade×4**, SetCopperAdr×6, SetCopperCol×2 | efecto con fade + copperlist compleja |
| `0x096A28` | SetCopperAdr×5, SetCopperCol, Fade, LoadDecrunch | efecto de distorsión SINE |
| `0x02162C` | AllocMem×5, SetCopperAdr | scrolltext |
| `0x07E42C` | AllocMem, AllocBlock | zoom/render imagen + créditos |
| `0x0A3C2C` | (sin SetCopperAdr) | efecto sin copperlist propia (¿blitter/dibujo directo?) |
| resto | perfil estándar (GetPISS, AllocMem, SetInt, SetCopperAdr) | efectos gráficos estándar |

Nota: todos los bloques llaman a `GetPISS`/`AllocMem`/`StartIt`/`FastRand`/`SetInt` en el
arranque (es el patrón común de un programa SOS). Lo diferenciador es `Fade`, `SetCopperCol`,
`Load`/`LoadDecrunch`, `Randomize`/`AltKick`.

## Bloques de código (sos.library + efecto embebido)

| Bloque | l1 | Tags | Identificación | Conf. |
|---|---|---|---|---|
| `0x078A2C` | 73048 | DBUG | **loader `main`** (orquesta los efectos; "SLOADHYB main" lo confirma) | media-alta |
| `0x026A2C` | 114408 | DBUG | el bloque de código más grande; candidato a "main extendido" / runtime completo | baja |
| `0x0B0C2C` | 63064 | DBUG | **motor 3D** (matriz Q15, cámara) + **blobs** (lookup tables) + **fade** + **charmap de fuente** | alta |
| `0x096A28` | 3260 | DBUG, SINE | **efecto de distorsión/ondas** (8 osciladores de fase + copperlist por scanlines) | alta |
| `0x02162C` | 45924 | DBUG | **scrolltext** (fuente 3 planos + diario alemán extraído) | alta |
| `0x07E42C` | 20268 | DBUG | **render de imagen a 4 planos** (zoom) + **créditos "MR.PET"** | media-alta |
| `0x05402C` | 920 | DBUG | **manejador de música** (replay VBlank + copia de `mod.elekfunk`) | alta |
| `0x099A2C` | 12472 | DBUG | efecto con **mensaje coloquial** ("ich bin einfach geiler ficker !!") | media |
| `0x04BC28` | 20100 | DBUG, SINE | efecto que usa **SINE** (rotación/ondas) | media |
| `0x08B028` | 19484 | DBUG, SINE | efecto que usa **SINE** (rotación/ondas) | media |
| `0x03242C` | 26676 | DBUG | efecto (pendiente) | baja |
| `0x03562C` | 34956 | DBUG | efecto (pendiente) | baja |
| `0x04382C` | 33784 | DBUG | efecto (pendiente) | baja |
| `0x04862C` | 21100 | DBUG | efecto (pendiente) | baja |
| `0x0A3C2C` | 38628 | DBUG | efecto (pendiente) | baja |
| `0x0A502C` | 32500 | DBUG | efecto (pendiente; muchos bset.b = dibujo de píxeles) | baja |
| `0x01D82C` | 1688 | DBUG | fragmento pequeño | baja |
| `0x03AC2C` | 1152 | DBUG | fragmento | baja |
| `0x07642C` | 1172 | DBUG | fragmento | baja |
| `0x0AD62C` | 1428 | DBUG | fragmento | baja |

## Bloques de datos (efectos/assets)

| Bloque | l1 | Identificación | Conf. |
|---|---|---|---|
| `0x03AFFC` | 102852 | **túnel** (copperlist + paleta + textura) | media |
| `0x09A940` | 51648 | **plasma/render** (procedural; buffer de display) | media |
| `0x0ADB04` | 61660 | copperlist + datos (efecto) | baja |
| `0x01DDE8` | 59616 | copperlist + datos | baja |
| `0x076844` | 16392 | copperlist + datos | baja |
| `0x0ACE9C` | 6576 | copperlist + datos | baja |
| `0x04EFE8` | 10268 | datos (tablas) | baja |
| `0x08E91C` | 6592 | datos | baja |
| `0x0973D0` | 496 | datos | baja |

## Textos encontrados (alemanes)

- **0x02162C**: diario del autor (35 frases) → `recovered/media/scrolltext/` (original + traducción).
- **0x0B0C2C**: segundo **charmap** (`ABC...XYZ#012...` + minúsculas) → fuente de otro texto.
- **0x099A2C**: mensaje coloquial/vulgar ("ich bin einfach geiler ficker !!").
- **0x07E42C**: créditos con el nombre **"MR.PET"** (Peter Cukierski, coder principal).

## Efectos conocidos por créditos/técnicas

- Motor 3D (Chaos + McDeal), rubber-rotator, esfera 16 colores, color tunnel (Chaos), scrolltext,
  zooming-pictures, plasma. Todos los de Chaos comparten la técnica de texture mapping.
- **Distorsión/ondas**: efecto SINE con 8 osciladores.