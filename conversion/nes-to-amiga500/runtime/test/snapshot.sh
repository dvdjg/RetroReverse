#!/usr/bin/env bash
# snapshot — registra la validación del oráculo (suite + matriz) en un fichero
# Markdown, para tener un baseline **inmutable** por versión (ver docs/VERSIONS.md).
#
# Uso:  bash test/snapshot.sh [salida.md]
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="$ROOT/../../.."
OUT="${1:-$ROOT/build/oracle_snapshot.md}"

{
	echo "# Validación del oráculo"
	echo
	echo "- commit: \`$(git -C "$REPO" rev-parse --short HEAD 2>/dev/null || echo '?')\`"
	echo "- tag: \`$(git -C "$REPO" describe --tags 2>/dev/null || echo '?')\`"
	echo "- fecha: $(date -u +%Y-%m-%dT%H:%MZ)"
	echo
	echo "## Suite (\`test/run.sh\`)"
	echo '```'
	bash "$ROOT/test/run.sh" 2>&1 | tail -40
	echo '```'
	echo
	echo "## Matriz de compatibilidad"
	bash "$ROOT/test/port_matrix.sh"
} > "$OUT" 2>&1

echo "snapshot -> $OUT"
