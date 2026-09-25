<#
capture-live.ps1 — captura un efecto EN VIVO en una sola invocación de WinUAE-DBG.

Lanza el emulador en PRIMER PLANO (necesario para que la CPU corra; ver tools/README.md),
sondena una firma en RAM hasta que aparezca (a la espera del efecto), y entonces vuelca RAM +
screenshot. Cierra SOLO la instancia propia (por PID).

Uso:
  ./capture-live.ps1 -Config <x.uae> -Adf <x.adf> -ProbeAddr 0x26758 -ProbePattern "0fff0ffc0fd9" `
                     -OutDir <dir> [-TimeoutSec 90]

Ejemplo (corridor de Sanity-Arte; la paleta del tunel aparece en 0x2675A):
  ./capture-live.ps1 -Config ../platforms/computers/amiga500/demos/arte/out/sanity.uae `
                     -Adf    ../platforms/computers/amiga500/demos/arte/out/disk/sanity-arte.adf `
                     -ProbeAddr 0x26758 -ProbePattern 0fff0ffc0fd9 -OutDir ./shots

Notas:
- El canal lateral usa GDB 2445 / side 2446 (override por env WINUAE_GDB_PORT / *_SIDE_CHANNEL_PORT).
- `screenshot` escribe el PNG de forma asincrona; se espera 3 s.
- NO mata otras instancias: Stop-Process solo al PID propio.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$Config,
  [Parameter(Mandatory=$true)][string]$Adf,
  [Parameter(Mandatory=$true)][string]$ProbeAddr,
  [Parameter(Mandatory=$true)][string]$ProbePattern,
  [string]$OutDir = ".",
  [int]$TimeoutSec = 120,
  [string]$WinuaeExe = "C:\Users\dvdjg\Documents\programa\AI\Amiga\WinUAE-DBG\bin\winuae-gdb.exe"
)
$ErrorActionPreference = "Stop"
$nodeDir = Join-Path $PSScriptRoot "node"
$gdb = 2445; $side = 2446
$env:WINUAE_GDB_PORT = "$gdb"; $env:WINUAE_SIDE_CHANNEL_PORT = "$side"
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$probe = Join-Path $env:TEMP "capture-probe.bin"

$args = @("-f", (Resolve-Path $Config), "-portable", "-G", "-s", "headless=no",
          "-s", "debugging_features=gdbserver", "-s", "win32.start_not_captured=yes",
          "-s", "win32.active_capture_automatically=no", "-s", "win32.absolute_mouse=yes",
          "-s", ("floppy0=" + (Resolve-Path $Adf)))
Write-Host "[capture] lanzando WinUAE-DBG (primer plano) ..."
$p = Start-Process -FilePath $WinuaeExe -WorkingDirectory (Split-Path $WinuaeExe) -ArgumentList $args -PassThru
Write-Host "[capture] pid=$($p.Id)"

$found = $false
$deadline = (Get-Date).AddSeconds($TimeoutSec)
while ((Get-Date) -lt $deadline) {
  & node (Join-Path $nodeDir "side.mjs") mem $ProbeAddr 0x40 --out $probe 2>$null | Out-Null
  if (Test-Path $probe) {
    $hex = (([System.IO.File]::ReadAllBytes($probe)) | ForEach-Object { $_.ToString("x2") }) -join ''
    if ($hex -match $ProbePattern) { $found = $true; break }
  }
  Start-Sleep -Seconds 2
}

if ($found) {
  Write-Host "[capture] firma detectada; volcando RAM + screenshot"
  & node (Join-Path $nodeDir "side.mjs") mem 0x0 0x80000 --out (Join-Path $OutDir "capture-chip.bin") 2>$null | Out-Null
  & node (Join-Path $nodeDir "side.mjs") mem 0xC00000 0x40000 --out (Join-Path $OutDir "capture-slow.bin") 2>$null | Out-Null
  & node (Join-Path $nodeDir "side.mjs") screenshot ((Join-Path (Resolve-Path $OutDir) "capture.png")) 2>$null | Out-Null
  Start-Sleep -Seconds 3
} else {
  Write-Warning "[capture] firma NO detectada en $TimeoutSec s"
}

if (Get-Process -Id $p.Id -ErrorAction SilentlyContinue) { Stop-Process -Id $p.Id -Force }
Remove-Item $probe -ErrorAction SilentlyContinue
Write-Host "[capture] hecho (pid $($p.Id) cerrado)"
