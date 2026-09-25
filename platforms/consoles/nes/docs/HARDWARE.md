# NES — hardware (resumen propio)

Resumen de referencia para el emulador. Datos de hardware (no textos ajenos). Ver
[`../../../../docs/REFERENCES.md`](../../../../docs/REFERENCES.md) §NES para las fuentes.

## CPU — Ricoh 2A03

- Núcleo **MOS 6502** sin **modo decimal** (el flag `D` se ignora); 2A03 = 6502 + APU + I/O.
- Reloj NTSC **1.789773 MHz** (PAL 1.662607 MHz). ISA en [`CPU_6502.md`](CPU_6502.md).
- Sin puertos de E/S propios: los periféricos (controles, APU, OAM DMA) están mapeados en el bus.

## PPU — Ricoh 2C02

- Reloj **3× la CPU** (NTSC 5.369318 MHz). **CPU:PPU = 1:3**.
- Frame NTSC: **262 scanlines** × **341 dots** = 89 342 ppu-dots ≈ **29 780.5 ciclos de CPU**.
- Render por scanline; los registros `$2000-$2007` (CPU) y la VRAM interna se pueden escribir en
  cualquier momento, pero el comportamiento depende del ciclo/scanline (detalles por banda).
- **VBlank** en la scanline 241; genera **NMI** si está habilitada (`$2000` bit 7).
- Memoria:
  - **CHR/Pattern tables** 2×4 KiB (8×8 px, 2 bpp, 16 B por tile),
  - **Nametables** 2 KiB VRAM + mirroring (horizontal/vertical/4-screen) + attribute tables,
  - **Palette** 32 B (4 grupos × 4 colores; 64 colores base, ~54 únicos),
  - **OAM** 256 B (64 sprites), **secondary OAM** 32 B.
- Registros: `$2000` PPUCTRL, `$2001` PPUMASK, `$2002` PPUSTATUS, `$2003` OAMADDR,
  `$2004` OAMDATA, `$2005` PPUSCROLL, `$2006` PPUADDR, `$2007` PPUDATA; `$4014` OAMDMA.
- Sprites 8×8 / 8×16 (según `$2000`), flip H/V, prioridad, paleta por sprite (attr de OAM).

## APU

- 5 canales: **2 pulse** (duty, envelope/sweep), **triangle**, **noise** (LFSR), **DMC** (samples).
- Registros `$4000-$4013`, estado `$4015`, frame counter `$4017` (4-step/5-step, IRQ).
- Mezcla no lineal (tablas) por canal en el 2A03 real → importante para exactitud de audio.

## Mapa de memoria (bus CPU)

| Rango | Uso |
|---|---|
| `$0000-$07FF` | RAM 2 KiB (espejada hasta `$1FFF`) |
| `$2000-$3FFF` | Registros PPU (espejados cada 8) |
| `$4000-$4017` | APU / `$4014` OAMDMA / `$4016-$4017` mandos |
| `$4018-$401F` | APU test / deshabilitado |
| `$4020-$FFFF` | Cartucho (PRG-ROM/RAM, mapper) |

- **Mandos NES** en `$4016`/`$4017` (escritura a `$4016` reinicia el *strobe*; lectura serie de 8 bits).
- **NMI** (`$FFFA` vector) y **IRQ** (mapper, APU, DMC; `$FFFE`). Reset `$FFFC`.

## Espejos y detalles que suelen fallar

- RAM espejada cada 0x800; registros PPU cada 8.
- `$2002`/`$2004`/`$2007` *read buffer* y *dummy read* de PPU.
- OAM en 8×8 y wrap de Y (hardware quirk de sprites).
- Orden de lecturas en `$4016/$4017` (bit a bit) y `$4015`.
