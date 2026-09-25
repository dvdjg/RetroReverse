# decompile-modules.ps1 - pipeline headless: decompila en lote los modulos de un modules.json
#
# Lee un JSON de modulos (out/modules/modules.json o out/modules_all/index.json), importa cada
# binario como Raw Binary en su direccion de carga y vuelca el pseudo-C de todas sus funciones a
# out/ghidra/. Salida NO curada (regenerable). Ver toolkit/ghidra/README.md y STRUCTURE.md regla 8.
#
# Uso:
#   ./decompile-modules.ps1 -ModulesJson ..\..\sanity-arte\out\modules\modules.json `
#       -OutDir ..\..\sanity-arte\out\ghidra [-Only 'mod_00'] [-BaseField dest]
#
# Campos del JSON:
#   - "file": nombre del binario (relativo al JSON)
#   - "dest" (o el campo -BaseField): direccion de carga en hex sin 0x; si falta -> base 0
#   (out/modules_all/index.json usa "offset" = offset en el ADF, NO direccion de carga -> base 0)

[CmdletBinding()]
param(
	[Parameter(Mandatory = $true)][string]$ModulesJson,
	[Parameter(Mandatory = $true)][string]$OutDir,
	[string]$GhidraDir = "C:\Users\dvdjg\Documents\programa\AI\Amiga\ghidra_12.0.1_PUBLIC",
	[string]$ScriptPath = $PSScriptRoot,
	[string]$ProjectDir,
	[string]$Processor = "68000:BE:32:default",
	[string]$BaseField = "dest",
	[string]$Only = "",
	[int]$AnalysisTimeoutSec = 300
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ModulesJson)) { throw "No existe ModulesJson: $ModulesJson" }
if (-not $ProjectDir) { $ProjectDir = Join-Path $OutDir "project" }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
New-Item -ItemType Directory -Force -Path $ProjectDir | Out-Null

if (-not $env:JAVA_HOME -and (Test-Path "C:\Program Files\Java\jdk-21")) {
	$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"
}

$jsonDir = Split-Path -Parent (Resolve-Path -LiteralPath $ModulesJson)
$entries = Get-Content -LiteralPath $ModulesJson -Raw | ConvertFrom-Json
$headless = Join-Path $GhidraDir "support\analyzeHeadless.bat"
if (-not (Test-Path -LiteralPath $headless)) { throw "No existe analyzeHeadless: $headless" }

$n = 0
foreach ($e in $entries) {
	$file = Join-Path $jsonDir $e.file
	if ($Only -and ($e.file -notmatch $Only)) { continue }
	if (-not (Test-Path -LiteralPath $file)) { Write-Warning "falta $file"; continue }

	$baseRaw = "0"
	if ($e.PSObject.Properties.Name -contains $BaseField) { $baseRaw = "$($e.$BaseField)" }
	$baseRaw = $baseRaw -replace '^0[xX]', ''
	$baseAddr = "0x" + $baseRaw
	$name = [System.IO.Path]::GetFileNameWithoutExtension($e.file)
	$decomp = Join-Path $OutDir "$name.decomp.c"
	$info = Join-Path $OutDir "$name.info.txt"

	Write-Host "== $name  base=$baseAddr  ($file)"
	& $headless $ProjectDir sanity `
		-import $file -overwrite `
		-processor $Processor -loader BinaryLoader -loader-baseAddr $baseAddr `
		-scriptPath $ScriptPath `
		-postScript DumpDecomp.java $decomp `
		-postScript InfoDump.java $info `
		-analysisTimeoutPerFile $AnalysisTimeoutSec 2>&1 |
		Select-String -Pattern "Wrote|decompiled|ERROR|Exception" | ForEach-Object { "   $($_.Line)" }
	$n++
}

Write-Host "Modulos procesados: $n. Salidas en $OutDir"
