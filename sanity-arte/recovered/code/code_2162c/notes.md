# Scrolltext de «Arte» — módulo 0x02162C

- **Origen**: `out/modules_all/blk_02162C_45924.bin` (descomprimido del ADF 0x02162C,
  track 12, l1=45924). SHA1 `198b23f547...`.
- **Desensamblado**: `code_2162c/code_2162c.asm`.
- **Técnica**: ver `docs/TECNICAS.md` → "Scrolltext con fuente de 3 planos".
- **Confianza**: alta (rutina completa + mapa de chars + texto extraídos).

## Contenido del módulo

| Offset | Qué es | Confianza |
|---|---|---|
| `0x1A80` | mapa de caracteres `" abcdefghijklmnopqrstuvwxyz0123456789.,!?:-"` (43) | alta |
| `~0x2800-0x3400` | glifos (3 planos × 8 filas × 2 bytes, interleaved) | media (layout byte exacto pendiente) |
| `0x352A` | **texto del scrolltext** (alemán, 35 frases) → `recovered/media/scrolltext/scrolltext.txt` | alta |
| `0x1AAC` | limpieza de bitplane `$60000` (0x3C00 longs) | alta |

## Texto del scrolltext (contenido)

Diario del desarrollo escrito por el coautor de Sanity (**procedencia: ingeniería inversa** del
módulo; es el texto que él mismo escribió dentro de la demo, no documentación externa). Menciona
que piensa publicar un **source-code** de uno de estos efectos: **"den tunel, oder diesen
plasma-effekt oder nur die 3d-sterne"** (el túnel, el plasma, o las **estrellas 3D**, "la rutina
más optimizada"). También: fuente heredada de la demo WOC-92, avance "al 80%", saludos a
Arne/Jester/Dierk, la party WC-93 (6.11.93), y detalles personales (26.10.93). Es la **hoja de
ruta de los efectos a reimplementar**: túnel, plasma, estrellas 3D. Original + traducción al
español en `recovered/media/scrolltext/` (`scrolltext.txt`, `scrolltext-es.md`, `README.md`).

## Pistas para la fuente (glifos)

- Cada char = 3 planos × 8 filas × 2 bytes (16 px de ancho). offsets de fila dentro del plano:
  `0,0x2c,0x58,0x84,0xb0,0xdc,0x108,0x134`; el plano avanza `0x160`.
- La rutina copia `move.b` de cada fila del glifo al bitplane en `$60000` (stride `0x5000`).
- El byte exacto de cada glifo se deriva de la rutina al reimplementar (los datos están en
  `~0x2800`).