#!/usr/bin/env bash
# Volcado de evidencia (trazas/savestates/screenshots/mem) de títulos arcade post-1990
# usando el core FBNeo (los que mame2003-plus no soporta).
# Salida: platforms/arcade/extraction/fbneo/<juego>/ (ignorado por git).
#
# Uso: [FRAMES=120 OUT=...] scripts/fbneo-slice.sh
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CORE="${CORE:-$ROOT/external/libretro-fbneo/fbneo_libretro.so}"
OUTROOT="${OUT:-$ROOT/platforms/arcade/extraction/fbneo}"
FRAMES="${FRAMES:-120}"
INCLUDE_NEOGEO="${INCLUDE_NEOGEO:-1}"

[[ -x "$ROOT/tools/orchestrator/vertical_slice" ]] || make -C "$ROOT/tools/orchestrator" vertical_slice
[[ -f "$CORE" ]] || { echo "FALTA FBNeo: $CORE (scripts/fetch-cores.sh && scripts/build-libretro-core.sh libretro-fbneo)"; exit 2; }

titles=(1944 s1945 sfiii sfiii3)
[[ "$INCLUDE_NEOGEO" == "1" ]] && titles+=(mslug mslug3)

for t in "${titles[@]}"; do
	rom="$ROOT/roms/fbneo/$t.zip"
	echo "==================== $t ===================="
	[[ -f "$rom" ]] || { echo "FALTA $rom"; continue; }
	"$ROOT/tools/orchestrator/vertical_slice" \
		--core "$CORE" --rom "$rom" --out "$OUTROOT/$t" \
		--frames "$FRAMES" --interval "$FRAMES" --det 10 || echo "FALLO: $t"
done
echo "evidencia FBNeo en $OUTROOT"
