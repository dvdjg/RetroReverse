# NES — pruebas y validación

## `nestest` (CPU 6502)

ROM de referencia de la comunidad (`nes-test-roms/other/nestest.nes`) con un log
`nestest.log` de 8991 líneas generado por Nintendulator. Dos modos:

1. **Automático (el que usa el arnés)**: arrancar con `PC=0xC000`, `SP=0xFD`, `P=0x24`.
   La ROM recorre las pruebas y escribe el resultado en memoria:
   - `$02` = nº de test **oficial** fallido (0 = todos OK),
   - `$03` = nº de test **ilegal** fallido (0 = todos OK).
   Se ejecuta hasta que deja de avanzar (bucle final) o un máximo de instrucciones.
2. **Log**: comparar registro a registro línea a línea con `nestest.log`
   (columnas: PC, bytes, ASM, A, X, Y, P, SP, PPU, CYC). El arnés puede comparar
   `PC/A/X/Y/P/SP` (ignora PPU/ASM/CYC) para depurar divergencias.

### Criterio de cierre del núcleo de CPU

- **H1**: `$02 == 0` (oficiales). **HECHO**.
- **H2**: `$03 == 0` (ilegales). **HECHO** — además, comparación traza a traza:
  `make trace` verifica **8991/8991** líneas de `nestest.log` (PC/A/X/Y/P/SP).

## Otros test ROMs (`nes-test-roms`)

| ROM | Qué valida |
|---|---|
| `cpu/` (blargg) | instrucciones/tiempos, `nestest` |
| `ppu/` | timing de PPU, VBlank/NMI, `$2002` |
| `apu/` | longitudes/envelopes, frame counter |
| `mmc3_test/` | IRQ del MMC3 por scanline |
| `other/` | misc (p. ej. `ppu_vbl_nmi`) |

Se integrarán en `make test` por fases (CPU → PPU → APU → mappers).

## Arnés

```powershell
wsl -d Ubuntu -- bash -lc "cd /mnt/c/Users/dvdjg/Documents/programa/AI/Amiga/RetroReverse/repo/platforms/consoles/nes/reimplementation && make test"
# personalizado:
#   NESTEST=<ruta a nestest.nes>  make test
```

Salida esperada (H1+H2): `nestest: $02=0 $03=0 -> CPU OK`.

## Cobertura de ejecución

El runner registra qué direcciones fueron **inicio de instrucción** y cuáles se alcanzaron
secuencialmente, y puede volcar los **inicios de bloque** ejecutados en ROM:

```powershell
./nestest_runner <nestest.nes> --coverage coverage.txt
```

`coverage.txt` (líneas `ADDR 01`) alimenta el puente a Ghidra
(`tools/ghidra/ApplyRanges.java`): importar la ROM y ejecutar el script con ese fichero crea
funciones en los bloques **realmente ejecutados** (en vez de disasm lineal).
