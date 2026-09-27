# build-pc.ps1 — compila el runner SDL3 (PC/Windows) con MinGW g++.
#
# Usa SDL3 descargado en external/SDL3 (devel MinGW) y eng/core de Amiga-Cpp.
# Salida: runtime/host/build/nes_sdl.exe (+ SDL3.dll copiada al lado).

param([string]$CodegenRom = '')   # opcional: ROM a transpilar y enlazar (motor codegen)

$ErrorActionPreference = 'Stop'

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path          # .../runtime/host
$Repo = Resolve-Path (Join-Path $Here '..\..\..\..')             # raíz del repo
$AmigaCpp = Resolve-Path (Join-Path $Here '..\..\..\..\..\..\Amiga-Cpp')
$SDL3 = Join-Path $Repo 'external\SDL3\devel\SDL3-3.4.16\x86_64-w64-mingw32'

# Compilador: el MinGW del entorno del proyecto si existe; si no, `g++` del PATH.
$Cxx = 'C:\Users\dvdjg\Documents\programa\AI\Amiga\mingw64\bin\g++.exe'
if (-not (Test-Path -LiteralPath $Cxx)) { $Cxx = 'g++' }

if (-not (Test-Path -LiteralPath (Join-Path $SDL3 'include\SDL3\SDL.h'))) {
	throw "No encuentro SDL3 en '$SDL3' (¿se descargó? ver runtime/platform/README.md)"
}
if (-not (Test-Path -LiteralPath (Join-Path $AmigaCpp 'engine\include\eng\core\types\types.hpp'))) {
	throw "No encuentro eng/core en '$AmigaCpp\engine\include'"
}

$Build = Join-Path $Here 'build'
New-Item -ItemType Directory -Force -Path $Build | Out-Null

$Inc = @(
	"-I$(Join-Path $AmigaCpp 'engine\include')",
	"-I$(Join-Path $Here '..\include')",
	"-I$(Join-Path $Here '..\fallback')",
	"-I$(Join-Path $Here '..\platform')",
	"-I$(Join-Path $Here '..\..\tools\transpiler\src')",
	"-I$(Join-Path $SDL3 'include')"
)
$Defs = @()
$Out = Join-Path $Build 'nes_sdl.exe'

if ($CodegenRom) {
	# Transpila la ROM y la enlaza en el host (motor codegen).
	$TpSrc = Join-Path $Here '..\..\tools\transpiler\src'
	$TpBin = Join-Path $Build 'nes_transpiler.exe'
	Write-Host "Transpilando '$CodegenRom' ..."
	& $Cxx -std=gnu++23 -O2 -w -static "-I$(Join-Path $AmigaCpp 'engine\include')" "-I$TpSrc" `
		(Join-Path $TpSrc 'main.cpp') -o $TpBin
	if ($LASTEXITCODE -ne 0) { throw "no se pudo compilar el transpilador" }
	& $TpBin $CodegenRom -o (Join-Path $Build 'codegen_rom.cpp')
	if ($LASTEXITCODE -ne 0) { throw "no se pudo transpilar '$CodegenRom'" }
	$Inc += "-I$Build"
	$Defs += '-DN2A_CODEGEN'
	$Out = Join-Path $Build 'nes_sdl_codegen.exe'
}

Write-Host "Compilando $(Join-Path $Here 'main.cpp') ..."
& $Cxx -std=gnu++23 -O2 -Wall -Wextra -static-libgcc -static-libstdc++ @Inc @Defs `
	(Join-Path $Here 'main.cpp') (Join-Path $Here 'sdl_host.cpp') `
	"-L$(Join-Path $SDL3 'lib')" -lSDL3 -o $Out
if ($LASTEXITCODE -ne 0) { throw "la compilación falló (exit $LASTEXITCODE)" }

Copy-Item -LiteralPath (Join-Path $SDL3 'bin\SDL3.dll') -Destination $Build -Force
# Runtime de MinGW (pthread) junto al exe, para que arranque sin el PATH.
$CxxDir = Split-Path -Parent $Cxx
if ($CxxDir -and (Test-Path -LiteralPath $CxxDir)) {
	foreach ($dll in @('libwinpthread-1.dll', 'libgcc_s_seh-1.dll', 'libstdc++-6.dll')) {
		$p = Join-Path $CxxDir $dll
		if (Test-Path -LiteralPath $p) { Copy-Item -LiteralPath $p -Destination $Build -Force }
	}
}
# 7-Zip standalone (7zr.exe) junto al exe, para leer juegos `.7z`.
$SevenZip = Join-Path $Here '..\..\..\..\external\7zip\7zr.exe'
if (Test-Path -LiteralPath $SevenZip) { Copy-Item -LiteralPath $SevenZip -Destination $Build -Force }
Write-Host "OK -> $Out"
