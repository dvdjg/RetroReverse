#!/usr/bin/env bash
# Smoke test del transpilador (WSL/Linux g++ o MinGW g++):
#   1. compila la herramienta;
#   2. por cada ROM de prueba propia: la genera, la transpila, compila el C++
#      generado (con el runtime del nodo) y comprueba el estado final.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
RUNTIME_INC="$ROOT/../../runtime/include"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing"

BIN="$ROOT/build/nes_transpiler"
GEN="$ROOT/generated"
TMP="$ROOT/build/tests"

compile_generated() {  # $1 = nombre del caso; $2 = cuerpo del main de comprobación
	local name="$1"
	"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME_INC" "$GEN/$name.cpp" -o "$TMP/${name}_standalone"
	"$TMP/${name}_standalone"
	cat > "$TMP/${name}_check.cpp" <<EOF
#define N2A_NO_HOST_MAIN
#include "$GEN/$name.cpp"
$2
EOF
	"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME_INC" "$TMP/${name}_check.cpp" -o "$TMP/${name}_check"
	"$TMP/${name}_check"
}

mkdir -p "$ROOT/build" "$GEN" "$TMP"

if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC' (usa AMIGA_CPP=...)" >&2
	exit 1
fi
if [ ! -f "$RUNTIME_INC/nes_runtime.hpp" ]; then
	echo "ERROR: no encuentro el runtime en '$RUNTIME_INC/nes_runtime.hpp'" >&2
	exit 1
fi

echo "[1/5] compilando el transpilador"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/src" "$ROOT/src/main.cpp" -o "$BIN"

echo "[2/5] caso mini (LDA/STA/INX/BRK)"
"$BIN" --emit-mini-rom "$GEN/mini.nes"
"$BIN" "$GEN/mini.nes" -o "$GEN/mini.cpp"
compile_generated mini 'int main() {
	game_main();
	return (g_state.cpu.X == 1u && g_state.cpu.A == 0x23u && g_state.mem.ram[0] == 0x23u) ? 0 : 1;
}'

echo "[3/5] caso branch/jsr (bucle 5 con ADC/BNE/JSR/RTS)"
"$BIN" --emit-branch-rom "$GEN/branch.nes"
"$BIN" "$GEN/branch.nes" -o "$GEN/branch.cpp"
compile_generated branch 'int main() {
	game_main();
	const bool ok = (g_state.cpu.A == 5u) && (g_state.cpu.X == 5u) &&
			(g_state.mem.ram[0x10] == 5u) && (g_state.mem.ram[0] == 0u);
	return ok ? 0 : 1;
}'

echo "[4/5] caso misc (PHA/PLA, shifts, INC/DEC memoria, JMP indirecto, --facts)"
"$BIN" --emit-misc-rom "$GEN/misc.nes"
"$BIN" "$GEN/misc.nes" --facts "$ROOT/tests/facts/misc.txt" -o "$GEN/misc.cpp"
if ! grep -q "N2A_ASSUME" "$GEN/misc.cpp"; then
	echo "ERROR: el codegen no emitió N2A_ASSUME a partir de --facts" >&2
	exit 1
fi
compile_generated misc 'int main() {
	game_main();
	const bool ok = (g_state.cpu.A == 0x55u) && (g_state.cpu.X == 0u) &&
			(g_state.mem.ram[0x10] == 0x40u) && (g_state.mem.ram[0x20] == 0x06u) &&
			(g_state.mem.ram[0x40] == 0x55u);
	return ok ? 0 : 1;
}'
# Calor de bloque: un hecho `hot` marca el bloque como __attribute__((hot)).
printf 'hot 8000 5\n' > "$TMP/hot.txt"
"$BIN" "$GEN/misc.nes" --facts "$TMP/hot.txt" -o "$GEN/misc_hot.cpp"
if ! grep -q "__attribute__((hot)) bb_8000" "$GEN/misc_hot.cpp"; then
	echo "ERROR: el codegen no marco el bloque caliente con --facts hot" >&2
	exit 1
fi

echo "[5/5] caso VSA (N2A_ASSUME inferido sin --facts)"
"$BIN" --emit-vsa-rom "$GEN/vsa.nes"
"$BIN" "$GEN/vsa.nes" -o "$GEN/vsa.cpp"
if ! grep -q "N2A_ASSUME" "$GEN/vsa.cpp"; then
	echo "ERROR: el VSA no emitió N2A_ASSUME" >&2
	exit 1
fi
compile_generated vsa 'int main() {
	game_main();
	return (g_state.cpu.A == 0x2Au) ? 0 : 1;
}'

echo "[6/7] perfil --amiga (chain+liveness+yield+ROM/ZP directas): equivalencia host"
# El codigo de `--amiga` (bloques encadenados, lectura directa de ROM/ZP, helper de
# desplazamiento multibyte con fallback portable y cesion `cpu.yield`) debe dar el
# **mismo estado final** que la version base. Se comprueba en host con las mismas ROM.
compile_amiga() {  # $1 = nombre del caso; $2 = cuerpo del main de comprobacion
	local name="$1"
	"$BIN" "$GEN/$name.nes" --amiga -o "$GEN/${name}_amiga.cpp"
	cat > "$TMP/${name}_amiga_check.cpp" <<EOF
#define N2A_NO_HOST_MAIN
#include "$GEN/${name}_amiga.cpp"
$2
EOF
	"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME_INC" "$TMP/${name}_amiga_check.cpp" -o "$TMP/${name}_amiga_check"
	"$TMP/${name}_amiga_check"
}
compile_amiga mini 'int main() {
	game_main();
	return (g_state.cpu.X == 1u && g_state.cpu.A == 0x23u && g_state.mem.ram[0] == 0x23u) ? 0 : 1;
}'
compile_amiga branch 'int main() {
	game_main();
	const bool ok = (g_state.cpu.A == 5u) && (g_state.cpu.X == 5u) &&
			(g_state.mem.ram[0x10] == 5u) && (g_state.mem.ram[0] == 0u);
	return ok ? 0 : 1;
}'
compile_amiga misc 'int main() {
	game_main();
	const bool ok = (g_state.cpu.A == 0x55u) && (g_state.cpu.X == 0u) &&
			(g_state.mem.ram[0x10] == 0x40u) && (g_state.mem.ram[0x20] == 0x06u) &&
			(g_state.mem.ram[0x40] == 0x55u);
	return ok ? 0 : 1;
}'
compile_amiga vsa 'int main() {
	game_main();
	return (g_state.cpu.A == 0x2Au) ? 0 : 1;
}'

echo "[7/8] helpers rapidos del runtime (equivalencia n2a_ror_run/n2a_rol_run)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME_INC" "$ROOT/tests/fastops_test.cpp" -o "$TMP/fastops_test"
"$TMP/fastops_test"

echo "[8/8] benchmark codegen vs interprete vs ejecutor rapido"
bash "$ROOT/tests/bench_codegen.sh"

echo "TEST OK"
