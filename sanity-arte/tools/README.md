# tools — comandos del expediente Sanity-Arte

Este expediente **no tiene scripts propios**: usa el toolkit compartido
[`../../toolkit/`](../../toolkit/README.md). Aquí quedan documentados los comandos exactos
usados para este título, para reproducirlo.

## 0. DMS -> ADF (verificado)

```powershell
python ..\..\toolkit\python\dms_unpack.py C:\Users\dvdjg\Downloads\Sanity-Arte.dms out\disk\sanity-arte.adf --verbose
```

Esperado: `80 pistas decodificadas`, ADF de 901120 bytes.

## 1. Volcado de RAM (Chip 512K + Slow 512K) + captura

```powershell
node ..\..\toolkit\node\dump-ram.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --boot 20 --regions 0x0:0x80000,0xc00000:0x80000 --out out --prefix sanity --screenshot
```

Salida: `out/ram/sanity_000000.bin`, `out/ram/sanity_c00000.bin`, `out/screens/sanity-boot.png`.

> Nota: los volcados iniciales se hicieron antes de unificar el toolkit y están en
> `out/ram/chip000000.bin`, `out/ram/slowc00000.bin` (mismos rangos).

## 2. Diagnóstico de breakpoints

```powershell
node ..\..\toolkit\node\probe-breakpoints.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf --boot 15
```

## 3. Volcado de módulos descomprimidos (de-cruncher SOS `CrM!`/`CrM2`)

```powershell
node ..\..\toolkit\node\hook-trampoline.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --spec specs\imp-dump.json --out out --boot 5
```

- `specs/sanity-arte.json` describe el trampoline `CrM!` (no era el usado).
- `specs/imp-routine.json` (sondeo del contrato de `IMP!`, con `probe-layout.mjs`).
- `specs/imp-dump.json` (hook del `IMP!` en modo routine): volcó 12 bloques a `out/modules/`.

## 4. Extracción de display (Copperlist + assets)

```powershell
node ..\..\toolkit\node\dump-display.mjs --config out\sanity.uae --adf out\disk\sanity-arte.adf `
  --boot 21 --out out --prefix arte-title
```

Salida en `out/display/` (`-custom.json`, `-copper.txt`, `-copper.bin`, `-palette.json`, `-bitplanes.bin`, `-png`).

## Análisis de volcados/ADF

```powershell
python ..\..\toolkit\python\bin_scan.py out\ram\slowc00000.bin --base 0xc00000
python ..\..\toolkit\python\bin_scan.py out\modules\mod_000_c5cbb2_114408.bin
```
