<#
.SYNOPSIS
  Importa una ROM en Ghidra (headless) y crea funciones a partir de una cobertura,
  usando tools/ghidra/ApplyRanges.java. Encadena lo que antes era manual.

.EXAMPLE
  ./scripts/ghidra-coverage.ps1 -Rom "roms/megadrive/Golden Axe (World).md" `
      -Coverage "platforms/consoles/megadrive/extraction/re/Golden Axe (World)/coverage.trace.ranges.txt"

.EXAMPLE
  # NES (usa GhidraNes por extensión .nes; sin flags de loader/processor)
  ./scripts/ghidra-coverage.ps1 -Rom "roms/nes/Super Mario Bros. (World).nes" -Coverage cov.txt -Nes
#>
param(
    [Parameter(Mandatory = $true)][string]$Rom,
    [Parameter(Mandatory = $true)][string]$Coverage,
    [string]$Processor = "68000:BE:32:MC68020",
    [string]$Loader = "BinaryLoader",
    [switch]$Nes,
    [string]$Ghidra = "",
    [string]$ProjectName = "rr_cov"
)

$ErrorActionPreference = "Stop"
$repo = Split-Path $PSScriptRoot -Parent
if (-not $Ghidra) { $Ghidra = Join-Path $repo "external\ghidra_12.0.1_PUBLIC" }

$headless = Join-Path $Ghidra "support\analyzeHeadless.bat"
$scriptPath = Join-Path $repo "tools\ghidra"
if (-not (Test-Path $headless)) { throw "No encuentro analyzeHeadless: $headless" }

$proj = Join-Path $env:TEMP ("rr_ghidra_" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Force -Path $proj | Out-Null

# analyzeHeadless.bat (cmd) no maneja bien rutas con espacios/paréntesis: copiamos a TEMP.
$romTmp = Join-Path $env:TEMP ("rr_rom" + [IO.Path]::GetExtension($Rom))
$covTmp = Join-Path $env:TEMP "rr_coverage.ranges.txt"
Copy-Item -LiteralPath (Resolve-Path -LiteralPath $Rom).Path -Destination $romTmp -Force
Copy-Item -LiteralPath (Resolve-Path -LiteralPath $Coverage).Path -Destination $covTmp -Force

$hargs = @(
    $proj, $ProjectName,
    "-import", $romTmp,
    "-scriptPath", $scriptPath,
    "-postScript", "ApplyRanges.java", $covTmp,
    "-noanalysis"
)
if (-not $Nes) {
    $hargs += @("-loader", $Loader, "-loader-baseAddr", "0x0", "-processor", $Processor)
}

Write-Host "Ghidra: $headless"
& $headless @hargs 2>&1 | Select-String -Pattern "Using Loader|Using Language|ApplyRanges:|ERROR"
$code = $LASTEXITCODE
Remove-Item -Recurse -Force $proj -ErrorAction SilentlyContinue
exit $code
