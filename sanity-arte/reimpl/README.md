# reimpl — recreación en C++ (Sanity-Arte)

Destino final: reescribir como **algoritmo propio** cada técnica recuperada. Reglas generales en
[`../../_template/reimpl/README.md`](../../_template/reimpl/README.md).

**Criterio (usuario)**: las **rutinas optimizadas** del ensamblador se conservan como **versión
canónica** en `reference/*_amiga.asm` (desensamblado del binario, con comentarios) y se usan en la
reconstrucción donde el rendimiento es crítico (inline asm o traducción literal). La versión C++ es
la **referencia funcional** equivalente.

## Técnicas portadas

| Técnica | Origen (bloque/rutina) | Estado | Asm canónico |
|---|---|---|---|
| `sine_table` — seno precalculado Q1.14 | `SINE.soslibrary` (idea) | PORTADO (test OK) | — |
| `motor_3d` — transformación 3D Q15 (matriz rotación + punto) | 0x0B0C2C (0x0C16-0x0D58) | PORTADO (test OK) | `reference/transform3d_q15_amiga.asm` |
| `blob_render` — blobs/sprites planares con LUT de expansión | 0x0B0C2C (0x3318-0x3560) | PORTADO (test OK) | `reference/blob_render_amiga.asm` |
| `sine_wobble` — distorsión por scanlines (8 osciladores) | 0x096A28 (0x150-0x82E) | PORTADO (test OK) | `reference/sine_wobble_amiga.asm` |
| `scrolltext` — scrolltext con fuente de 3 planos | 0x02162C (0x196E-0x1A70) | PORTADO (test OK) | `reference/scrolltext_amiga.asm` |
| `palette_fade` — fade de paleta por nibbles (R/G/B) | 0x0B0C2C (0x031C-0x03E2) | PORTADO (test OK) | `reference/palette_fade_amiga.asm` |
| (pendiente) túnel / esfera-lente / plasma / zoom | 0x03AFFC / 0x07E42C / 0x09A940 | PENDIENTE | — |

## Construir

```sh
make test-all   # compila y ejecuta los tests host de todas las técnicas
make asm        # lista los asm canónicos preservados
```

Cada técnica tiene su carpeta con `README.md` (mapeo desde el código recuperado), `src/`
(implementación de referencia), `reference/` (asm canónico) y `SOURCE` (trazabilidad).