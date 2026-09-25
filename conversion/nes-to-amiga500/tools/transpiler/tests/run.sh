#!/usr/bin/env bash
# Smoke test del transpilador (WSL/Linux g++ o MinGW g++):
#   1. compila la herramienta
#   2. por cada ROM de prueba propia: la genera, la transpila, compila el C++
#      generado (standalone) y comprueba el estado final (differential smoke)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing"

BIN="$ROOT/build/nes_transpiler"
GEN="$ROOT/generated"
TMP="$ROOT/build/tests"

mkdir -p "$ROOT/build" "$GEN" "$TMP"

if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC' (usa AMIGA_CPP=...)" >&2
	exit 1
fi

echo "[1/3] compilando el transpilador"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/src" "$ROOT/src/main.cpp" -o "$BIN"

# --- Caso 1: ROM minima (LDA/STA/INX/BRK) -----------------------------------
echo "[2/3] caso mini"
"$BIN" --emit-mini-rom "$GEN/mini.nes"
"$BIN" "$GEN/mini.nes" -o "$GEN/mini.cpp"
"$CXX" $FLAGS -I"$ENG_INC" "$GEN/mini.cpp" -o "$TMP/mini_standalone"
"$TMP/mini_standalone"
cat > "$TMP/mini_check.cpp" <<EOF
#define N2A_NO_HOST_MAIN
#include "$GEN/mini.cpp"
int main() {
	game_main();
	return (g_state.cpu.X == 1u && g_state.cpu.A == 0x23u && g_state.mem.ram[0] == 0x23u) ? 0 : 1;
}
EOF
"$CXX" $FLAGS -I"$ENG_INC" "$TMP/mini_check.cpp" -o "$TMP/mini_check"
"$TMP/mini_check"

# --- Caso 2: bucle + ADC + branch + JSR/RTS ---------------------------------
echo "[3/3] caso branch/jsr (bucle 5 iteraciones)"
"$BIN" --emit-branch-rom "$GEN/branch.nes"
"$BIN" "$GEN/branch.nes" -o "$GEN/branch.cpp"
"$CXX" $FLAGS -I"$ENG_INC" "$GEN/branch.cpp" -o "$TMP/branch_standalone"
"$TMP/branch_standalone"
cat > "$TMP/branch_check.cpp" <<EOF
#define N2A_NO_HOST_MAIN
#include "$GEN/branch.cpp"
int main() {
	game_main();
	const bool ok = (g_state.cpu.A == 5u) && (g_state.cpu.X == 5u) &&
			(g_state.mem.ram[0x10] == 5u) && (g_state.mem.ram[0] == 0u);
	return ok ? 0 : 1;
}
EOF
"$CXX" $FLAGS -I"$ENG_INC" "$TMP/branch_check.cpp" -o "$TMP/branch_check"
"$TMP/branch_check"

echo "TEST OK"
