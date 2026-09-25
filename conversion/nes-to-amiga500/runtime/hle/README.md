# runtime/hle — handlers de alto nivel

Rutinas nativas que traducen **intenciones** reconocidas de la NES a operaciones Amiga. Contrato y
catálogo de patrones en [`../../docs/HLE.md`](../../docs/HLE.md).

## Handlers previstos

| Fichero | Función | Destino |
|---|---|---|
| `hle_scroll.*` | `hle_set_scroll(x, y)` | `BPLxPT` + `BPLCON1` + Copper |
| `hle_vram.*` | `hle_vram_write(addr, v)` / dirty tiles | TileEngine / Blitter |
| `hle_oam.*` | `hle_oam_dma(page)` | SpriteEngine (HW + bobs) |
| `hle_mapper.*` | `hle_bankswitch(bank)` | tablas de despacho por banco |
| `hle_split.*` | sprite 0 hit / IRQ → Copper `WAIT` | CopperGenerator |

Implementación en C de bajo nivel o **asm 68000** donde el coste lo justifique (medir; ver
[`../../docs/VALIDATION.md`](../../docs/VALIDATION.md)).

Regla: el estado emulado es **único**; el handler lo actualiza y el hardware Amiga es una *vista*.
Se puede desactivar cada handler para comparar HLE vs fallback.
