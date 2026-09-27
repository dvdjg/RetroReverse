#!/usr/bin/env bash
# port_matrix — matriz de compatibilidad del port: para cada ROM de `build/*.nes`
# mide el diff **estructural** (luminancia) del oráculo contra `mesen` a 60 frames.
# Es la referencia contra la que se validará el backend Amiga (ver
# docs/PORT_TEST_PLAN.md) y una puerta de regresión contra `port_matrix.baseline`.
#
# Uso:
#   bash test/port_matrix.sh            # tabla legible
#   bash test/port_matrix.sh --gate     # falla si algún juego empeora > TOL
#   bash test/port_matrix.sh --update   # reescribe el baseline
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FRAMES="${FRAMES:-60}"
BASELINE="$ROOT/test/port_matrix.baseline"
TOL="${TOL:-1.0}"   # % de tolerancia antes de considerar regresión
MODE="${1:-table}"

measure() { # $1 = rom ; imprime el % estructural
	local rom="$1"
	local line struct
	line="$(ROM="$rom" FRAMES="$FRAMES" bash "$ROOT/test/diff_mesen.sh" 2>/dev/null | tail -1)"
	struct="$(printf '%s' "$line" | sed -n 's/.*estructura(lum)=\([0-9.]*\)%.*/\1/p')"
	printf '%s' "${struct:-?}"
}

case "$MODE" in
--update)
	: > "$BASELINE"
	echo "# Baseline de la matriz (estructura(lum) vs mesen, $FRAMES frames)." >> "$BASELINE"
	for rom in "$ROOT"/build/*.nes; do
		[ -f "$rom" ] || continue
		printf '%s %s\n' "$(basename "$rom")" "$(measure "$rom")" >> "$BASELINE"
	done
	echo "baseline actualizado: $BASELINE"
	;;
--gate)
	rc=0
	printf '| ROM | medido | baseline |\n|---|---:|---:|\n'
	for rom in "$ROOT"/build/*.nes; do
		[ -f "$rom" ] || continue
		name="$(basename "$rom")"
		got="$(measure "$rom")"
		want="$(awk -v n="$name" '$1==n{print $2}' "$BASELINE")"
		flag=""
		if [ -n "$want" ]; then
			flag="$(awk -v g="$got" -v w="$want" -v t="$TOL" 'BEGIN{print(g+0>w+0+t)?" REGRESION":""}')"
		fi
		[ -n "$flag" ] && rc=1
		printf '| %s | %s%% | %s%%%s |\n' "$name" "$got" "${want:-?}" "$flag"
	done
	exit "$rc"
	;;
*)
	printf '| ROM | estructura(lum) vs mesen |\n|---|---:|\n'
	for rom in "$ROOT"/build/*.nes; do
		[ -f "$rom" ] || continue
		printf '| %s | %s%% |\n' "$(basename "$rom")" "$(measure "$rom")"
	done
	;;
esac
