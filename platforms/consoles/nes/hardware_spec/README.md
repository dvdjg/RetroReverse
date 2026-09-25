# NES — `hardware_spec/`

Resumen operativo del hardware para el emulador. Detalle en
[`../docs/HARDWARE.md`](../docs/HARDWARE.md).

## CPU (2A03, 6502) — registros del sistema

| Región | Dirección | Bits | Notas |
|---|---|---|---|
| RAM | `$0000-$07FF` | 8 | 2 KiB, espejada a `$1FFF` |
| PPU | `$2000-$2007` | 8 | espejada cada 8 hasta `$3FFF` |
| APU/IO | `$4000-$4017` | 8 | canales + `$4014` OAMDMA + mandos |
| PRG/RAM | `$4020-$FFFF` | 8 | cartucho |

## PPU (2C02) — registros

| Reg | Dir | Función |
|---|---|---|
| PPUCTRL | `$2000` | NMI enable, sprite size, BG pattern, incremento, nametable |
| PPUMASK | `$2001` | BG/sprite enable (izq), énfasis, greyscale |
| PPUSTATUS | `$2002` | VBlank, sprite 0 hit, overflow, lectura limpia VBlank |
| OAMADDR | `$2003` | dirección OAM |
| OAMDATA | `$2004` | datos OAM |
| PPUSCROLL | `$2005` | scroll X/Y (2 escrituras) |
| PPUADDR | `$2006` | VRAM address (2 escrituras) |
| PPUDATA | `$2007` | datos VRAM/CHR/paleta (con buffer) |

## APU — registros

`$4000-$4003` pulse1, `$4004-$4007` pulse2, `$4008-$400B` triangle, `$400C-$400F` noise,
`$4010-$4013` DMC, `$4015` status, `$4017` frame counter.

## Timing (NTSC)

- CPU 1.789773 MHz; PPU = 3×CPU.
- Frame: 341 dots × 262 líneas = 89 342 dots ≈ 29 780.5 ciclos CPU.
- VBlank: scanline 241 (dot 1).

## Espejos / quirks

RAM `0x800`, PPU regs `0x8`; buffer de `$2007`; OAM Y-wrap; DMC/OAM DMA stalls; IRQ de mapper.
