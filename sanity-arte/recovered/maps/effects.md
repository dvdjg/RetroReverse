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
| `0x03242C` | 26676 | DBUG | efecto (22 rutinas, 25 muls); strings tipo glifo `BAHA0/BBHB2` → ¿fuente/tiles? | baja |
| `0x03562C` | 34956 | DBUG | efecto (23 rutinas, 46 muls); configura **5 planos** ($5200) | media |
| `0x04382C` | 33784 | DBUG | efecto (23 rutinas, 16 muls); strings `ZlTZy/CBCrC/D4DeD/FEFuF` → ¿glifos de fuente? | baja |
| `0x04862C` | 21100 | DBUG | efecto (21 rutinas, 14 muls) | baja |
| `0x0A3C2C` | 38628 | DBUG | efecto **sin SetCopperAdr** (¿blitter/dibujo directo?) | baja |
| `0x0A502C` | 32500 | DBUG | efecto (11 rutinas, **77 muls**, 4 dbra) → motor matemático/3D | media |
| `0x01D82C` | 1688 | DBUG | fragmento pequeño | baja |
| `0x03AC2C` | 1152 | DBUG | fragmento | baja |
| `0x07642C` | 1172 | DBUG | fragmento | baja |
| `0x0AD62C` | 1428 | DBUG | fragmento | baja |

## Notas de densidad (código vs datos)

Los bloques "sos.library" varían mucho en proporción código/datos:

- **Pocos `rts`** (código escaso, mayormente tablas/datos): `0x026A2C` (10 rts / 34849 insns),
  `0x0A502C` (11 rts / 12131 insns). Son **datos + poco código**.
- **Muchos `rts`** (código de efecto denso): `0x03242C` (22), `0x03562C` (23), `0x04382C` (23),
  `0x04862C` (21), `0x07E42C` (zoom), `0x096A28` (distorsión).

Los strings binarios tipo glifo (`BAHA0`, `BBHB2` en 0x03242C; `D4DeD`, `FEFuF`, `M5MbM`,
`NENsN`, `RFRqR` en 0x04382C) sugieren **fuentes/tilesets** (patrones de bits que forman letras).

## Bloques de datos (efectos/assets)

| Bloque | l1 | Identificación | Conf. |
|---|---|---|---|
| `0x03AFFC` | 102852 | buffer del efecto **corridor/túnel**: copperlist (5 planos, `BPLCON0=$5200`) + paleta (offset `0x146`) + datos. El túnel de Arte = **corridor de Chaos** (32 colores). Validación: `../media/palettes/tunnel-VALIDACION.md` | alta (paleta) |
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

## Paletas candidatas por bloque (método aplicado a los efectos restantes)

Búsqueda de runs de words 12-bit (`$0RGB`) a continuación de la cabecera de cada bloque de efecto
(heurística; los que empiezan con `000` suelen ser **Copperlist**, no paleta):

| Bloque | Efecto | Paleta candidata | Notas |
|---|---|---|---|
| `0x07E42C` | zoom/créditos | @`0x232` (17) — dudosa | contiene "MR.PET" |
| `0x078A2C` | ¿? | @`0xE0A`: `23C,478,6B3,8EE,B28,D61,F99` | **rampa clara** (candidata real) |
| `0x0B0C2C` | motor 3D + fade | @`0x8B6` (32) | alterna `000` → **Copper**, no paleta |
| `0x09A940` | plasma (buffer) | — | datos de display (procedural) |
| `0x0ACE9C` / `0x076844` | copper+datos | `092,038,094,100,200…` | **Copperlist** |
| `0x0A3C2C` | ¿? | @`0x817A` (953) | probablemente datos |

**Pendiente (siguiente fase):** para cada efecto (plasma, rubber-rotator, zoom) hay que
**capturar su frame en vivo** (receta en `toolkit/README.md`) y localizar su paleta/estructura
antes de reimplementar — igual que se hizo con el túnel.
