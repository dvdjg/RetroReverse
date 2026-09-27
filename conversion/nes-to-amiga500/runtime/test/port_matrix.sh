#!/usr/bin/env bash
# port_matrix — matriz de compatibilidad del port: por cada ROM de `build/*.nes`
# muestra mapper, hash de framebuffer del oráculo y diff **estructural** vs `mesen`.
# Es la referencia congelada contra la que se validará el backend Amiga (ver
# docs/PORT_TEST_PLAN.md) y una puerta de regresión (`port_matrix.baseline`).
#
# Uso:
#   bash test/port_matrix.sh            # tabla legible (mapper | hash | estructura)
#   bash test/port_matrix.sh --gate     # falla si algún juego empeora > TOL
#   bash test/port_matrix.sh --subset   # solo unos pocos juegos (rápido)
#   bash test/port_matrix.sh --update   # reescribe el baseline
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="$ROOT/../../.."
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
FRAMES="${FRAMES:-60}"
CXX="${CXX:-g++}"
BASELINE="$ROOT/test/port_matrix.baseline"
TOL="${TOL:-1.0}"
MODE="${1:-table}"
SUBSET_RE="${SUBSET_RE:-smb|bf|dk|ic|galaga|xevious}"

mapper_of() { # lee el mapper del header iNES sin depender de jq
	local b
	b="$(od -An -tu1 -N8 "$1" | tr -s ' ')"
	set -- $b
	echo $(( ( $7 >> 4 ) | ( $8 & 0xF0 ) ))
}

hash_of() { # hash del framebuffer del oráculo
	local rom="$1"
	"$ROOT/build/nes_frame" "$rom" /dev/null "$FRAMES" 2>/dev/null |
		sed -n 's/.*hash=\([0-9a-f]*\).*/\1/p'
}

struct_of() { # % estructural vs mesen
	local line
	line="$(ROM="$1" FRAMES="$FRAMES" bash "$ROOT/test/diff_mesen.sh" 2>/dev/null | tail -1)"
	printf '%s' "$line" | sed -n 's/.*estructura(lum)=\([0-9.]*\)%.*/\1/p'
}

# Compila nes_frame una vez (para el hash).
"$CXX" -std=gnu++23 -O2 -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" \
	"$ROOT/tools/nes_frame.cpp" -o "$ROOT/build/nes_frame" 2>/dev/null || true

rows() {
	for rom in "$ROOT"/build/*.nes; do
		[ -f "$rom" ] || continue
		local name; name="$(basename "$rom")"
		if [ "$MODE" = "--subset" ] && ! printf '%s' "$name" | grep -qE "$SUBSET_RE"; then
			continue
		fi
		printf '%s %s %s %s\n' "$name" "$(mapper_of "$rom")" "$(hash_of "$rom")" "$(struct_of "$rom")"
	done
}

case "$MODE" in
--update)
	: > "$BASELINE"
	echo "# Baseline (mapper hash estructura vs mesen, $FRAMES frames)." >> "$BASELINE"
	rows | while read -r n m h s; do printf '%s %s\n' "$n" "${s:-?}" >> "$BASELINE"; done
	echo "baseline actualizado: $BASELINE"
	;;
--gate)
	rc=0
	printf '| ROM | estructura | baseline |\n|---|---:|---:|\n'
	rows | while read -r n m h s; do
		want="$(awk -v x="$n" '$1==x{print $2}' "$BASELINE")"
		flag="$(awk -v g="$s" -v w="$want" -v t="$TOL" 'BEGIN{print(w!=""&&g+0>w+0+t)?" REGRESION":""}')"
		[ -n "$flag" ] && rc=1
		printf '| %s | %s%% | %s%%%s |\n' "$n" "$s" "${want:-?}" "$flag"
	done
	# `rc` no sale del subshell; recomprueba en un segundo pase.
	rows | while read -r n m h s; do
		want="$(awk -v x="$n" '$1==x{print $2}' "$BASELINE")"
		awk -v g="$s" -v w="$want" -v t="$TOL" 'BEGIN{exit !(w!=""&&g+0>w+0+t)}' && exit 1
	done || rc=1
	exit "$rc"
	;;
*)
	printf '| ROM | mapper | hash (oráculo) | estructura vs mesen |\n|---|---:|---|---:|\n'
	rows | while read -r n m h s; do printf '| %s | %s | %s | %s%% |\n' "$n" "$m" "$h" "$s"; done
	;;
esac
