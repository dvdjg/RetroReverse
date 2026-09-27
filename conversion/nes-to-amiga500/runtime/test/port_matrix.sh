#!/usr/bin/env bash
# port_matrix — matriz de compatibilidad del port: para cada ROM de `build/*.nes`
# mide el diff **estructural** (luminancia) del oráculo contra `mesen` a 60 frames.
# Es la referencia contra la que se validará el backend Amiga (ver
# docs/PORT_TEST_PLAN.md). Uso:  bash test/port_matrix.sh
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FRAMES="${FRAMES:-60}"

printf '| ROM | estructura(lum) vs mesen |\n|---|---:|\n'
for rom in "$ROOT"/build/*.nes; do
	[ -f "$rom" ] || continue
	name="$(basename "$rom")"
	line="$(ROM="$rom" FRAMES="$FRAMES" bash "$ROOT/test/diff_mesen.sh" 2>/dev/null | tail -1)"
	struct="$(printf '%s' "$line" | sed -n 's/.*estructura(lum)=\([0-9.]*\)%.*/\1/p')"
	printf '| %s | %s%% |\n' "$name" "${struct:-?}"
done
