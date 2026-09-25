#!/usr/bin/env bash
# Valida la codificación de los ficheros de texto del repo: UTF-8 válido, sin BOM
# y sin mojibake (UTF-8 doblemente codificado). Mismo criterio que Amiga-Cpp.
#
# Uso:  bash scripts/validate-encoding.sh
# Requiere: node (>= 18).
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK="$ROOT/tools/check/encoding.mjs"

if ! command -v node >/dev/null 2>&1; then
	echo "ERROR: se requiere node para el check de codificación." >&2
	exit 2
fi
if [ ! -f "$CHECK" ]; then
	echo "ERROR: no existe $CHECK" >&2
	exit 2
fi

# Se pasa la raíz del repo; el propio script salta directorios generados/pesados.
node "$CHECK" "$ROOT"
