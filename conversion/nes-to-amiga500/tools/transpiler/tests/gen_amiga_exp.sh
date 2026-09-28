#!/usr/bin/env bash
# gen_amiga_exp.sh — genera artefactos de las pruebas de codegen Amiga/NES en
# conversion/nes-to-amiga500/transpiled/amiga-exp/ (carpeta ignorada por git).
#
#   - transpila la ROM con los backends --amiga (bloques) y --native (descompilador);
#   - compila ambos a 68000 (.o/.s) con el toolchain del engine (si está disponible);
#   - compila y ejecuta el arnés de frames del nativo (host).
#
# Uso:
#   bash tests/gen_amiga_exp.sh ["<rom.nes>"] [--no-m68k] [--frames N]
#
# Variables: CXX (host), M68K_CXX (cross), AMIGA_BIN_PATH (toolchain), AMIGA_CPP (engine).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"          # .../tools/transpiler
CONV="$(cd "$ROOT/../.." && pwd)"                 # .../conversion/nes-to-amiga500
OUT="$CONV/transpiled/amiga-exp"
GEN="$ROOT/generated"
TMP="$ROOT/build/tests"
ENG_INC="${ENG_INC:-${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}/engine/include}"
RUNTIME_INC="$CONV/runtime/include"
SHIM="$CONV/tools/m68k/shim"
CXX="${CXX:-g++}"
FLAGS="-std=gnu++23 -O2 -Wall -Wextra"
# En MinGW, enlazar estático evita depender de las DLL de libstdc++/libgcc al ejecutar.
case "$(uname -s 2>/dev/null || echo unknown)" in
	MINGW*|MSYS*|CYGWIN*) STATIC="-static -static-libgcc -static-libstdc++" ;;
	*) STATIC="" ;;
esac

# Normaliza una ruta Windows (C:\a\b) a posix (/c/a/b) para Git Bash/WSL.
norm() {
	local p="$1"
	case "$p" in
		[A-Za-z]:[\\/]*)
			local d="${p:0:1}"
			p="${p:2}"
			p="${p//\\//}"
			if [ -d /mnt/c ]; then
				printf '/mnt/%s/%s' "${d,,}" "$p"   # WSL
			else
				printf '/%s/%s' "${d,,}" "$p"       # Git Bash
			fi
			;;
		*)
			printf '%s' "$p"
			;;
	esac
}

ROM=""
DO_M68K=1
FRAMES=60
while [ $# -gt 0 ]; do
	case "$1" in
		--no-m68k) DO_M68K=0 ;;
		--frames) FRAMES="$2"; shift ;;
		*) ROM="$1" ;;
	esac
	shift
done
if [ -z "$ROM" ]; then
	ROM="$CONV/../../roms/nes/Donkey Kong (World) (Rev A).nes"
fi
if [ ! -f "$ROM" ]; then
	echo "ERROR: no encuentro la ROM '$ROM' (pásala como argumento)" >&2
	exit 1
fi
if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC' (usa AMIGA_CPP=...)" >&2
	exit 1
fi

mkdir -p "$OUT" "$GEN" "$TMP" "$ROOT/build"

echo "[1/5] compilando el transpilador de host"
"$CXX" $FLAGS $STATIC -I"$ENG_INC" -I"$ROOT/src" "$ROOT/src/main.cpp" -o "$ROOT/build/nes_transpiler"
BIN="$ROOT/build/nes_transpiler"
[ -x "$BIN" ] || BIN="$BIN.exe"   # MinGW añade .exe

echo "[2/5] transpilando '$ROM'"
"$BIN" "$ROM" --amiga -o "$OUT/game_amiga.cpp"
"$BIN" "$ROM" --native -o "$OUT/game_native.cpp"
"$BIN" "$ROM" --best -o "$OUT/game_best.cpp"

echo "[3/5] compilando a 68000"
M68K="${M68K_CXX:-}"
if [ -z "$M68K" ] && [ -n "${AMIGA_BIN_PATH:-}" ]; then
	AB="$(norm "$AMIGA_BIN_PATH")"
	M68K="$AB/opt/bin/m68k-amiga-elf-g++"
	[ -x "$M68K" ] || M68K="$M68K.exe"
fi
if [ "$DO_M68K" -eq 1 ] && [ -n "$M68K" ] && [ -x "$M68K" ]; then
	M68K_FLAGS=(-std=gnu++23 -m68000 -O3 -nostdlib -fomit-frame-pointer
		-fno-exceptions -fno-rtti -ffunction-sections -fdata-sections
		-I"$SHIM" -I"$RUNTIME_INC")
	"$M68K" "${M68K_FLAGS[@]}" -c "$OUT/game_native.cpp" -o "$OUT/game_native.o"
	"$M68K" "${M68K_FLAGS[@]}" -c "$OUT/game_amiga.cpp" -o "$OUT/game_amiga.o"
	"$M68K" "${M68K_FLAGS[@]}" -S "$OUT/game_native.cpp" -o "$OUT/game_native.s"
	if command -v m68k-amiga-elf-size >/dev/null 2>&1; then
		m68k-amiga-elf-size "$OUT/game_native.o" "$OUT/game_amiga.o"
	fi
else
	echo "  (toolchain m68k no disponible; usa M68K_CXX= o AMIGA_BIN_PATH=; omito .o/.s)"
fi

echo "[4/5] arnés de frames del nativo (host)"
cp "$OUT/game_native.cpp" "$GEN/native_game.cpp"
if ! "$CXX" $FLAGS $STATIC -I"$ENG_INC" -I"$RUNTIME_INC" -I"$ROOT" \
	"$ROOT/tests/native_frame.cpp" -o "$TMP/native_frame" 2>"$TMP/native_frame.err"; then
	echo "  (no compila el arnés; ver $TMP/native_frame.err)"
else
	"$TMP/native_frame" "$FRAMES"
fi

echo "[5/5] comparación de RAM nativo vs intérprete"
# Modelo de frame en stub (VBlank por $2002 + NMI por cesión) frente al NesSystem real.
# La comparación es informativa: la sincronización NMI del stub no es exacta.
if "$CXX" $FLAGS $STATIC -I"$ENG_INC" -I"$CONV/runtime/include" -I"$CONV/runtime/fallback" \
	-I"$CONV/runtime/host" -I"$CONV/runtime/enhance" -I"$ROOT" \
	"$ROOT/tests/native_diff.cpp" -o "$TMP/native_diff" 2>"$TMP/native_diff.err"; then
	"$TMP/native_diff" "$ROM" "$FRAMES" || true
else
	echo "  (no compila native_diff; ver $TMP/native_diff.err)"
fi

echo "OK -> $OUT"
