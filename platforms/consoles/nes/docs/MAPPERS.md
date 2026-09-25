# NES — cartuchos y mappers (resumen propio)

## Cabecera iNES

- 16 bytes: `NES\x1A`, PRG (×16 KiB), CHR (×8 KiB), flags6/7 (mapper, mirroring, batería, trainer),
  flags8-10 (formato NES 2.0). Trainer opcional de 512 B.
- `mapper = (flags7 & 0xF0) | (flags6 >> 4)`.

## Mappers habituales en la selección

| Mapper | Nombre | Bancos | Registros / notas |
|---|---|---|---|
| 0 | NROM | fijo | 16/32 KiB PRG, 8 KiB CHR; sin banking. SMB, DK, Pac-Man NES |
| 1 | MMC1 | serial | puerto `$8000-$FFFF`: 5 escrituras serie (bit0→LSB); control/CHR/PRG; mirroring |
| 2 | UxROM | PRG swap | `$8000-$FFFF` selecciona banco de 16 KiB en `$8000`; `$C000` fijo |
| 3 | CNROM | CHR swap | selección de banco CHR de 8 KiB |
| 4 | MMC3 | IRQ | `$8000`/`$8001` (banco + registro), `$A000` mirroring, `$C000`/`$C001` IRQ latch/reload, `$E000`/`$E001` enable/disable; **IRQ por scanline** |

Otros a contemplar según juegos: MMC5, VRC6, VRC4, MMC2/4 (Punch-Out, 4-screen), FDS.

## Aspectos que afectan a la emulación

- **Mirroring** (nametables) y su cambio en runtime (MMC1/MMC3).
- **IRQ del mapper** (MMC3): timing por scanline (A12) — clave para *split-screen*.
- **PRG-RAM/SRAM** con batería (`.sav`), y su banco.
- **CHR-RAM** (algunos cartuchos escriben en CHR).

## Fuentes

[`../../../../docs/REFERENCES.md`](../../../../docs/REFERENCES.md) §NES (NESDev Wiki: mappers).
