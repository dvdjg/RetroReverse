#!/usr/bin/env bash
# Tests del runtime del nodo:
#   1. CPU validada con nestest; 2. PPU (fondo+sprites); 3. APU (DMC); 4. ciclos;
#   5. sistema NES + HLE; extra: telemetría de hechos; y validación diferencial
#   con mesen (informativa).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"                 # .../nes-to-amiga500/runtime
REPO="$ROOT/../../.."
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
NESTEST="${NESTEST:-$REPO/external/references/repos/nes-test-roms/other/nestest.nes}"
ROM_NES="${ROM_NES:-$(find "$REPO/roms/nes" -maxdepth 1 -name '*.nes' 2>/dev/null | sort | head -1 || true)}"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing"

mkdir -p "$ROOT/build"

if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC' (usa AMIGA_CPP=...)" >&2
	exit 1
fi

echo "[1/5] CPU del runtime (nestest)"
if [ -f "$NESTEST" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/test/nestest_runner.cpp" -o "$ROOT/build/nestest_runner"
	"$ROOT/build/nestest_runner" "$NESTEST"
else
	echo "AVISO: no existe '$NESTEST'; se omite nestest."
fi

echo "[2/5] PPU software (fallback)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/fallback" "$ROOT/fallback/test/ppu_test.cpp" -o "$ROOT/build/ppu_test"
"$ROOT/build/ppu_test"

echo "[3/5] APU software (fallback)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/fallback" "$ROOT/fallback/test/apu_test.cpp" -o "$ROOT/build/apu_test"
"$ROOT/build/apu_test"

echo "[4/5] conteo de ciclos (interprete)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/test/cycles_test.cpp" -o "$ROOT/build/cycles_test"
"$ROOT/build/cycles_test"

echo "[5/5] sistema NES + HLE"
if [ -n "$ROM_NES" ] && [ -f "$ROM_NES" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" "$ROOT/test/system_test.cpp" -o "$ROOT/build/system_test"
	"$ROOT/build/system_test" "$ROM_NES" 60
else
	echo "AVISO: sin ROM en roms/nes; se omite el test del sistema."
fi

echo "[extra] ajustes por ROM (pack 4 bpp sin afectar a la emulacion)"
if [ -n "$ROM_NES" ] && [ -f "$ROM_NES" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" -I"$ROOT/host" \
		"$ROOT/enhance/test/enhance_test.cpp" -o "$ROOT/build/enhance_test"
	"$ROOT/build/enhance_test" "$ROM_NES" 30
else
	echo "AVISO: sin ROM en roms/nes; se omite el test de ajustes por ROM."
fi

echo "[extra] motor rapido: equivalencia + FPS (interprete vs pre-decodificado)"
if [ -n "$ROM_NES" ] && [ -f "$ROM_NES" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" -I"$ROOT/host" \
		"$ROOT/tools/bench_engine.cpp" -o "$ROOT/build/bench_engine"
	"$ROOT/build/bench_engine" "$ROM_NES" 120
else
	echo "AVISO: sin ROM en roms/nes; se omite el test del motor rapido."
fi

echo "[extra] telemetria de valores (--facts)"
if [ -f "$NESTEST" ]; then
	"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/include" "$ROOT/tools/facts_from_run.cpp" -o "$ROOT/build/facts_from_run"
	"$ROOT/build/facts_from_run" "$NESTEST" "$ROOT/build/facts_nestest.txt" 8000 C000
	test -s "$ROOT/build/facts_nestest.txt"
fi

echo "[extra] validacion diferencial con mesen"
bash "$ROOT/test/diff_mesen.sh" || echo "diff_mesen: divergencia por encima del umbral (informativo)."

echo "RUNTIME OK"
