#!/usr/bin/env bash
# gen_frame.sh — transpila una ROM NROM real y la ejecuta con el **código
# generado** dentro del NesSystem (PPU real), comparando con el intérprete.
# Uso:  ROM='.../Donkey Kong (World) (Rev A).nes' bash tests/gen_frame.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"                 # .../tools/transpiler
REPO="$ROOT/../../../.."                                 # raíz del repo
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
RUNTIME="$ROOT/../../runtime"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -w"                              # ROMs generadas: sin -Werror
ROM="${ROM:-$REPO/roms/nes/Donkey Kong (World) (Rev A).nes}"

BIN="$ROOT/build/nes_transpiler"
GEN="$ROOT/generated"
mkdir -p "$ROOT/build" "$GEN"

echo "[1/3] compilando el transpilador"
"$CXX" -std=gnu++23 -O2 -w -I"$ENG_INC" -I"$ROOT/src" "$ROOT/src/main.cpp" -o "$BIN"

echo "[2/3] transpilando '$ROM'"
"$BIN" "$ROM" -o "$GEN/gen_frame_game.cpp"

echo "[3/3] ejecutando el codegen dentro del NesSystem (PPU real)"
"$CXX" $FLAGS -I"$ENG_INC" -I"$RUNTIME/include" -I"$RUNTIME/fallback" -I"$RUNTIME/host" \
	"$ROOT/tests/gen_frame.cpp" -o "$ROOT/build/gen_frame"
"$ROOT/build/gen_frame" "$ROM" 60
echo "GEN_FRAME OK"
