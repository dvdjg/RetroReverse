# run.ps1 — compila el benchmark NES (intérprete vs ejecutor rápido) para
# **m68k-amiga** con el toolchain de vscode-amiga-debug, SIN el engine Amiga-Cpp
# (usa el shim tools/m68k/shim). Reporta tamaño de `.text` (crítico en A500) y,
# en host, valida que ambos motores dan el mismo resultado.
#
# Uso:  powershell -File run.ps1
#       (opcional) $env:M68K_CXX / $env:M68K_OBJDUMP para otra toolchain.

$ErrorActionPreference = 'Stop'

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path          # .../tools/m68k
$Runtime = (Resolve-Path (Join-Path $Here '..\..\runtime')).Path # .../runtime
$Shim = Join-Path $Here 'shim'
$Build = Join-Path $Here 'build'
New-Item -ItemType Directory -Force -Path $Build | Out-Null

$Cxx = if ($env:M68K_CXX) { $env:M68K_CXX } else {
	'C:\Users\dvdjg\Documents\programa\AI\Amiga\vscode-amiga-debug\bin\win32\opt\bin\m68k-amiga-elf-g++.exe'
}
$Objdump = if ($env:M68K_OBJDUMP) { $env:M68K_OBJDUMP } else {
	'C:\Users\dvdjg\Documents\programa\AI\Amiga\vscode-amiga-debug\bin\win32\opt\bin\m68k-amiga-elf-objdump.exe'
}
if (-not (Test-Path -LiteralPath $Cxx)) {
	throw "No encuentro el compilador m68k en '$Cxx' (usa `$env:M68K_CXX)"
}

$Inc = @(
	"-I$Shim",
	"-I$(Join-Path $Runtime 'include')",
	"-I$(Join-Path $Runtime 'host')"
)
$M68kFlags = @('-std=gnu++23', '-O2', '-m68000', '-ffreestanding', '-fno-exceptions',
	'-fno-rtti', '-fno-threadsafe-statics', '-DN2A_NO_MAIN')

function Get-TextSize([string]$obj) {
	$out = & $Objdump -h $obj 2>&1
	foreach ($line in $out) {
		$m = [regex]::Match($line, '^\s*\d+\s+\.text\s+([0-9a-fA-F]+)')
		if ($m.Success) { return [Convert]::ToInt64($m.Groups[1].Value, 16) }
	}
	return -1
}

Write-Host "[1/2] compilando para m68k-amiga (-m68000, sin engine)"
$Src = Join-Path $Here 'bench_m68k.cpp'
foreach ($cfg in @(@{ name = 'interp'; def = @() }, @{ name = 'fast'; def = @('-DN2A_USE_FAST') })) {
	$obj = Join-Path $Build ("bench_{0}_m68k.o" -f $cfg.name)
	& $Cxx @M68kFlags @($cfg.def) @Inc -c $Src -o $obj
	if ($LASTEXITCODE -ne 0) { throw "la compilación m68k ($($cfg.name)) falló" }
	$size = Get-TextSize $obj
	Write-Host ("  {0,-6} .text = {1,7} bytes" -f $cfg.name, $size)
}

Write-Host "[2/2] validación en host (mismo resultado ambos motores)"
$Gxx = 'C:\Users\dvdjg\Documents\programa\AI\Amiga\mingw64\bin\g++.exe'
if (-not (Test-Path -LiteralPath $Gxx)) { $Gxx = 'g++' }
$AmigaCpp = (Resolve-Path (Join-Path $Here '..\..\..\..\..\..\Amiga-Cpp')).Path
$EngInc = Join-Path $AmigaCpp 'engine\include'
$HostInc = @("-I$EngInc", "-I$(Join-Path $Runtime 'include')", "-I$(Join-Path $Runtime 'host')")
foreach ($cfg in @(@{ name = 'interp'; def = @() }, @{ name = 'fast'; def = @('-DN2A_USE_FAST') })) {
	$exe = Join-Path $Build ("bench_{0}_host.exe" -f $cfg.name)
	& $Gxx -std=gnu++23 -O2 -static @HostInc @($cfg.def) $Src -o $exe
	if ($LASTEXITCODE -ne 0) { throw "la compilación host ($($cfg.name)) falló" }
	Write-Host ("  {0,-6} " -f $cfg.name) -NoNewline
	& $exe
}
Write-Host "M68K OK"
