#!/usr/bin/env bash
# Ejecuta el slice de reversing sobre varios juegos de Mega Drive.
# Uso: [FRAMES=300] scripts/re-slice-all-md.sh
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FRAMES="${FRAMES:-300}"

games=(
	"Golden Axe (World).md"
	"Altered Beast (USA, Europe).md"
	"Revenge of Shinobi, The (USA, Europe).md"
	"Space Harrier II (World).md"
)

for g in "${games[@]}"; do
	echo "==================== $g ===================="
	FRAMES="$FRAMES" ROM="$ROOT/roms/megadrive/$g" bash "$ROOT/scripts/re-slice.sh" || echo "FALLO: $g"
done
echo "lote MD terminado"
