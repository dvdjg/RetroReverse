#!/usr/bin/env bash
# Vertical slice de REVERSING end-to-end: ejecuta el core instrumentado con libRetroReversing
# (vía `vertical_slice --re`), deja la evidencia en extraction/ y extrae la cobertura para Ghidra.
#
# Uso:  [CORE=... ROM=... OUT=... FRAMES=N] scripts/re-slice.sh [ROM]
# Requiere: scripts/setup-re-core.sh && scripts/build-libretro-core.sh libretro-gpgx-reversing
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORE="${CORE:-$ROOT/external/libretro-gpgx-reversing/genesis_plus_gx_libretro.so}"
ROM="${1:-${ROM:-$ROOT/roms/megadrive/Golden Axe (World).md}}"
GAME="$(basename "${ROM%.*}")"
OUT="${OUT:-$ROOT/platforms/consoles/megadrive/extraction/re/$GAME}"
FRAMES="${FRAMES:-240}"

[[ -f "$CORE" ]] || { echo "FALTA el core RE: $CORE"; echo "  scripts/setup-re-core.sh && scripts/build-libretro-core.sh libretro-gpgx-reversing"; exit 2; }
[[ -f "$ROM" ]] || { echo "FALTA la ROM: $ROM"; exit 3; }

make -C "$ROOT/tools/orchestrator" vertical_slice
"$ROOT/tools/orchestrator/vertical_slice" \
	--core "$CORE" --rom "$ROM" --out "$OUT" \
	--frames "$FRAMES" --interval "$FRAMES" --det 0 --re

PROJ="$(find "$OUT/RE_projects" -mindepth 2 -maxdepth 2 -type d 2>/dev/null | head -1)"
[[ -n "$PROJ" ]] || { echo "no se generó proyecto RE en $OUT"; exit 4; }

python3 "$ROOT/tools/python/re_functions_to_ranges.py" "$PROJ" "$OUT/coverage.functions.ranges.txt" || true
python3 "$ROOT/tools/python/re_trace_to_ranges.py" "$PROJ" "$OUT/coverage.trace.ranges.txt" --rom "$ROM" || true

echo "evidencia RE en $OUT"
echo "cobertura -> $OUT/coverage.functions.ranges.txt, $OUT/coverage.trace.ranges.txt"
