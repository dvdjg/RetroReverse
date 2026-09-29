#!/usr/bin/env bash
# static_size_test.sh — guarda contra estructuras estáticas enormes en el código
# generado (coste de RAM del plugin en Amiga). En particular, prohíbe la tabla
# densa `[0x10000]` (256 KB en 68000) y limita el `.bss` del objeto.
#
# Uso: bash tests/static_size_test.sh
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"                       # .../tools/transpiler
RUNTIME="$ROOT/../../runtime"
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
CXX="${CXX:-g++}"
MAX_BSS="${MAX_BSS:-16384}"                          # 16 KB: holgado para el estado normal
MAX_TEXT="${MAX_TEXT:-8192}"                         # 8 KB: gate anti-explosión del ROM mini (host)

cd "$ROOT" || exit 1
make -s || exit 1

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# ROM propia mínima (sin dependencias de ROMs externas).
./build/nes_transpiler --emit-mini-rom "$TMP/mini.nes" >/dev/null || { echo "FALLA: emit-mini-rom"; exit 1; }
./build/nes_transpiler "$TMP/mini.nes" -o "$TMP/mini.cpp" >/dev/null || { echo "FALLA: transpilar"; exit 1; }

# 1) Ninguna **declaración** de tabla densa [0x10000].
if grep -qE '(static|const)[^;]*\[0x10000\]' "$TMP/mini.cpp"; then
	echo "FALLA: el generado declara una tabla densa [0x10000]" >&2
	grep -nE '(static|const)[^;]*\[0x10000\]' "$TMP/mini.cpp" >&2
	exit 1
fi

# 2) `.bss` del objeto por debajo del umbral.
"$CXX" -std=gnu++23 -O2 -w -c "$TMP/mini.cpp" -I "$RUNTIME/include" -I "$ENG_INC" -o "$TMP/mini.o" \
	|| { echo "FALLA: no compila el generado"; exit 1; }
BSS="$(size -A "$TMP/mini.o" | awk '$1==".bss"{print $2}')"
BSS="${BSS:-0}"
if [ "$BSS" -gt "$MAX_BSS" ]; then
	echo "FALLA: .bss=${BSS} > ${MAX_BSS} B" >&2
	exit 1
fi

# 2b) `.text` del ROM mini por debajo del umbral (gate anti-explosión de codigo; el
# presupuesto real de un juego se mide en 68000, ver OPTIMIZACIONES_PROPUESTAS.md).
TEXT="$(size -A "$TMP/mini.o" | awk '$1==".text"{print $2}')"
TEXT="${TEXT:-0}"
if [ "$TEXT" -gt "$MAX_TEXT" ]; then
	echo "FALLA: mini .text=${TEXT} > ${MAX_TEXT} B" >&2
	exit 1
fi

# 3) Si hay una ROM UxROM real, comprobar también ahí (bancos + despacho disperso).
UX="$RUNTIME/build/castlevania.nes"
if [ -f "$UX" ]; then
	./build/nes_transpiler "$UX" -o "$TMP/ux.cpp" >/dev/null 2>&1 || true
	if [ -f "$TMP/ux.cpp" ]; then
		if grep -qE '(static|const)[^;]*\[0x10000\]' "$TMP/ux.cpp"; then
			echo "FALLA: UxROM declara tabla densa [0x10000]" >&2
			exit 1
		fi
		"$CXX" -std=gnu++23 -O2 -w -c "$TMP/ux.cpp" -I "$RUNTIME/include" -I "$ENG_INC" -o "$TMP/ux.o" 2>/dev/null
		UXBSS="$(size -A "$TMP/ux.o" 2>/dev/null | awk '$1==".bss"{print $2}')"
		UXBSS="${UXBSS:-0}"
		if [ "$UXBSS" -gt "$MAX_BSS" ]; then
			echo "FALLA: UxROM .bss=${UXBSS} > ${MAX_BSS} B" >&2
			exit 1
		fi
		echo "STATIC_SIZE OK (mini .bss=$BSS, uxrom .bss=$UXBSS, límite=$MAX_BSS)"
		exit 0
	fi
fi
echo "STATIC_SIZE OK (mini .bss=$BSS, límite=$MAX_BSS)"
