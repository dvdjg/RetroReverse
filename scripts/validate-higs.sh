#!/usr/bin/env bash
# Valida todas las specs HIGS del repo: JSON Schema + HIGS lint.
#
# Uso:  bash scripts/validate-higs.sh
# Requiere: python3 + jsonschema (pip install jsonschema).
#
# Busca: docs/higs/examples/*.json y cualquier */spec/game.json del repo.

set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LINT="$ROOT/docs/higs/higs_lint.py"

if [ ! -f "$LINT" ]; then
	echo "ERROR: no existe $LINT"
	exit 2
fi

mapfile -t specs < <(
	find "$ROOT" -path '*/spec/game.json' -not -path '*/node_modules/*' -not -path '*/out/*'
	printf '%s\n' "$ROOT"/docs/higs/examples/*.json
)

found=0
fail=0
for s in "${specs[@]}"; do
	[ -f "$s" ] || continue
	found=$((found + 1))
	if ! python3 "$LINT" "$s"; then
		fail=1
	fi
done

if [ "$found" -eq 0 ]; then
	echo "No se encontraron specs HIGS (no es un error)."
	exit 0
fi

echo "Specs validadas: $found"
exit "$fail"
