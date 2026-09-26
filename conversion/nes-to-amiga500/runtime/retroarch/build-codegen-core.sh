#!/usr/bin/env bash
# build-codegen-core.sh — compila un core libretro "codegen" para una ROM NROM
# concreta: transpila la ROM y enlaza el C++ generado con el core. El core
# resultante usa el motor `codegen` (nes_engine=auto lo selecciona solo).
#
# Uso: bash build-codegen-core.sh <rom.nes> [salida.so]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"                 # .../runtime/retroarch
REPO="$ROOT/../../../.."                              # raíz del repo
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
LIBRETRO_INC="$REPO/external/libretro-common/include"
TP="$ROOT/../../tools/transpiler"
CXX="${CXX:-g++}"

ROM="${1:?uso: build-codegen-core.sh <rom.nes> [salida.so]}"
OUT="${2:-$ROOT/build/nes_libretro_codegen.so}"
BUILD="$ROOT/build"
mkdir -p "$BUILD"

echo "[1/2] transpilando '$ROM'"
"$CXX" -std=gnu++23 -O2 -w -I"$ENG_INC" -I"$TP/src" "$TP/src/main.cpp" -o "$BUILD/nes_transpiler"
"$BUILD/nes_transpiler" "$ROM" -o "$BUILD/gen_rom.cpp"

echo "[2/2] compilando el core codegen"
cp "$ROOT/gen_engine_example.cpp" "$BUILD/gen_engine.cpp"
INC="-I$LIBRETRO_INC -I$ENG_INC -I$ROOT/../include -I$ROOT/../fallback -I$ROOT/../platform -I$ROOT/../host -I$TP/src"
"$CXX" -std=gnu++23 -O2 -fPIC -w $INC -shared "$ROOT/libretro_core.cpp" "$BUILD/gen_engine.cpp" -o "$OUT"
echo "core codegen -> $OUT"
