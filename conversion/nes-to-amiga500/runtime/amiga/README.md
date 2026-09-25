# runtime/amiga — hardware del A500

Código específico del destino: acceso a registros custom (`$DFFxxx`), Copper, Blitter, sprites
hardware, Paula, VBlank (nivel 3) y configuración de pantalla.

- Pantalla (Dual Playfield), Chip RAM, VBlank, bucle y input:
  [`../../docs/RUNTIME_AMIGA.md`](../../docs/RUNTIME_AMIGA.md).
- Generación de Copperlist, atributos y splits: [`../../docs/COPPER.md`](../../docs/COPPER.md).
- Motor de tiles/scroll: [`../../docs/PPU_AMIGA.md`](../../docs/PPU_AMIGA.md).
- Sprites y multiplex: [`../../docs/SPRITES_AMIGA.md`](../../docs/SPRITES_AMIGA.md).
- Audio → Paula: [`../../docs/AUDIO_AMIGA.md`](../../docs/AUDIO_AMIGA.md).

Referencia de registros y memoria: `platforms/computers/amiga500/hardware_spec/`. Convenciones Q15/
Q16, ABI y uso de ASM: [`../../../../PORTING.md`](../../../../PORTING.md).

> El engine de juegos Amiga de referencia vive en el repo hermano `Amiga-Cpp` (no se toca desde
> aquí); este runtime es **autónomo** salvo por el mixer de audio, que se integra por su API.
