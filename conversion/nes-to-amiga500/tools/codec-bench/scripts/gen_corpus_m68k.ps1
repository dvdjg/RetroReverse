# _corpus_m68k.ps1 — fase m68k del corpus: compila el C++ transpilado con el
# cross GCC 15.1 (Windows) a -m68000, lo enlaza permitiendo símbolos del runtime
# sin resolver (para que las relocaciones internas, p.ej. la init de la tabla de
# despacho, apunten a direcciones reales) y extrae .text y .rodata+.data crudos.
# Se ejecuta en Windows (el .exe no resuelve cc1plus desde rutas WSL).
$ErrorActionPreference = 'Continue'
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Node = 'C:\Users\dvdjg\Documents\programa\AI\Amiga\RetroReverse\repo\conversion\nes-to-amiga500'
$Bin  = 'C:\Users\dvdjg\Documents\programa\AI\Amiga\vscode-amiga-debug\bin\win32\opt\bin'
$M68K = Join-Path $Bin 'm68k-amiga-elf-g++.exe'
$Objcopy = Join-Path $Bin 'm68k-amiga-elf-objcopy.exe'
$Out = Join-Path $Root 'corpus'
$Work = Join-Path $Root '_corpus_work'
New-Item -ItemType Directory -Force -Path (Join-Path $Out 'm68k_text'), (Join-Path $Out 'm68k_data'), $Work | Out-Null

$Flags = @('-std=gnu++23','-O2','-m68000','-ffreestanding','-fno-exceptions','-fno-rtti',
           '-fno-threadsafe-statics','-w','-DN2A_NO_MAIN',
           "-I$Node\tools\m68k\shim", "-I$Node\runtime\include", "-I$Node\runtime\host")
$LinkFlags = @('-nostdlib','-static','-Wl,--unresolved-symbols=ignore-all','-Wl,--entry=0','-Wl,-e,0','-Wl,-Ttext=0x10000')

Write-Host "== compilando C++ transpilado a m68k (GCC 15.1) =="
Get-ChildItem (Join-Path $Node 'transpiled') -Filter *.cpp | ForEach-Object {
    $base = $_.BaseName
    if ($base -eq 'n2a_game_impl') { return }
    if ($base -like 'nes_transpiled*') { return }
    $obj = Join-Path $Work "$base.o"
    & $M68K @Flags -c $_.FullName -o $obj 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { Write-Host "  SKIP $base (compile)"; return }
    $elf = Join-Path $Work "$base.elf"
    & $M68K @LinkFlags -o $elf $obj 2>&1 | Out-Null
    $srcElf = if ($LASTEXITCODE -eq 0) { $elf } else { $obj }
    $txt = Join-Path $Out "m68k_text\$base.bin"
    $dat = Join-Path $Out "m68k_data\$base.bin"
    & $Objcopy -O binary --only-section=.text $srcElf $txt 2>$null
    & $Objcopy -O binary -j .rodata -j .data $srcElf $dat 2>$null
    $t = (Get-Item $txt -ErrorAction SilentlyContinue).Length
    $d = (Get-Item $dat -ErrorAction SilentlyContinue).Length
    $linked = if ($srcElf -eq $elf) { 'link' } else { 'OBJ' }
    Write-Host ("  {0,-9} [{1,4}] text={2,7} data={3,7}" -f $base, $linked, $t, $d)
}
Write-Host "FIN m68k"
