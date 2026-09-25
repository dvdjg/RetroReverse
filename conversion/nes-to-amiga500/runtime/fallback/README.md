# runtime/fallback — PPU/APU software

Camino **lento pero completo**: emulación software de la PPU (render 256×240, attributes, sprites,
scroll, sprite-0 hit, VBlank/NMI, `$2000-$2007`, OAM, DMA) y del APU (5 canales + frame counter).
Es el **oráculo** del nodo y garantiza que, aunque un patrón no se reconozca, el juego funcione.

- Diseño y flujo: [`../../docs/ARCHITECTURE.md`](../../docs/ARCHITECTURE.md).
- En Amiga, el framebuffer chunky resultante se convierte a **bitplanes** con el Blitter.
- Base de la **F3** (host, validado contra `mesen`) y del arranque de la **F4** en A500.

Se usa lo mínimo posible una vez los motores HLE (F5/F6) están maduros; el ratio HLE se mide
([`../../docs/VALIDATION.md`](../../docs/VALIDATION.md)).
