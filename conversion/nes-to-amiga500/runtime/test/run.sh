#!/usr/bin/env bash
# Tests del runtime del nodo:
#   1. CPU del runtime validada con `nestest` (F1);
#   2. PPU software (fondo + registros) del fallback (F3).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"                 # .../nes-to-amiga500/runtime
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
NESTEST="${NESTEST:-$ROOT/../../../external/references/repos/nes-test-roms/other/nestest.nes}"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing"

mkdir -p "$ROOT/build"

if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC' (usa AMIGA_CPP=...)" >&2
	exit 1
fi

echo "[1/4] CPU del runtime (nestest)"
if [ -f "$NESTEST" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/test/nestest_runner.cpp" -o "$ROOT/build/nestest_runner"
	"$ROOT/build/nestest_runner" "$NESTEST"
else
	echo "AVISO: no existe '$NESTEST'; se omite nestest (clona external/references)."
fi

echo "[2/4] PPU software (fallback)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/fallback" "$ROOT/fallback/test/ppu_test.cpp" -o "$ROOT/build/ppu_test"
"$ROOT/build/ppu_test"

echo "[3/4] APU software (fallback)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/fallback" "$ROOT/fallback/test/apu_test.cpp" -o "$ROOT/build/apu_test"
"$ROOT/build/apu_test"

echo "[4/4] conteo de ciclos (interprete)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/test/cycles_test.cpp" -o "$ROOT/build/cycles_test"
"$ROOT/build/cycles_test"

echo "[extra] telemetria de valores (--facts)"
if [ -f "$NESTEST" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/tools/facts_from_run.cpp" -o "$ROOT/build/facts_from_run"
	"$ROOT/build/facts_from_run" "$NESTEST" "$ROOT/build/facts_nestest.txt" 8000 C000
	test -s "$ROOT/build/facts_nestest.txt"
else
	echo "AVISO: sin '$NESTEST'; se omite la telemetría."
fi

echo "RUNTIME OK"
