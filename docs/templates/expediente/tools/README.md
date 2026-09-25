# tools — comandos del expediente <Título>

Este expediente usa el **toolkit compartido** [`../../tools/`](../../../../tools/README.md).
No crear scripts propios salvo necesidad real; documentar aquí los comandos exactos.

## DMS -> ADF
```powershell
python ..\..\tools\python\dms_unpack.py <entrada.dms> out\disk\<titulo>.adf --verbose
```

## Volcado de RAM
```powershell
node ..\..\tools\node\dump-ram.mjs --config out\<titulo>.uae --adf out\disk\<titulo>.adf `
  --boot 20 --regions 0x0:0x80000,0xc00000:0x80000 --out out --prefix <titulo> --screenshot
```

## Diagnóstico de breakpoints
```powershell
node ..\..\tools\node\probe-breakpoints.mjs --config out\<titulo>.uae --adf out\disk\<titulo>.adf --boot 15
```

## Volcado de módulos descomprimidos
```powershell
node ..\..\tools\node\hook-trampoline.mjs --config out\<titulo>.uae --adf out\disk\<titulo>.adf `
  --spec specs\<titulo>.json --out out --boot 4
```

## Descubrir el contrato de una rutina (diff de RAM)
```powershell
node ..\..\tools\node\probe-layout.mjs --config out\<titulo>.uae --adf out\disk\<titulo>.adf `
  --spec specs\<rutina>.json --boot 12
```

## Extraer display (Copperlist + bitplanes)
```powershell
node ..\..\tools\node\dump-display.mjs --config out\<titulo>.uae --adf out\disk\<titulo>.adf `
  --boot 20 --out out --prefix <titulo>
```

## Análisis
```powershell
python ..\..\tools\python\bin_scan.py out\ram\<region>.bin --base 0xc00000
```
