#!/usr/bin/env bash
# Benchmark del **código generado** por el transpilador frente al intérprete y al
# ejecutor rápido, sobre la ROM de cálculo (`--emit-bench-rom`). WSL/Linux g++.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
RUNTIME_INC="$ROOT/../../runtime/include"
RUNTIME_FB="$ROOT/../../runtime/fallback"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra"

BIN="$ROOT/build/nes_transpiler"
GEN="$ROOT/generated"
mkdir -p "$ROOT/build" "$GEN"

echo "[1/3] compilando el transpilador"
"$CXX" $FLAGS -I"$ENG_INC" -I"$ROOT/src" "$ROOT/src/main.cpp" -o "$BIN"

echo "[2/3] generando y transpilando la ROM de calculo"
"$BIN" --emit-bench-rom "$GEN/bench.nes"
"$BIN" "$GEN/bench.nes" -o "$GEN/bench.cpp"

echo "[3/3] compilando y midiendo codegen vs interprete vs rapido"
"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME_INC" -I"$RUNTIME_FB" \
	"$ROOT/tests/bench_codegen.cpp" -o "$ROOT/build/bench_codegen"
"$ROOT/build/bench_codegen"
echo "BENCH OK"
