#!/usr/bin/env bash
# Depura la carga de un core con host_test (imprime nombre, error y código de salida).
# Uso: scripts/probe-core.sh <ruta-al-core>
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
core="${1:?uso: $0 <core.(so|dll)>}"
cd "$ROOT/tools/orchestrator"
if command -v gdb >/dev/null 2>&1; then
	gdb -q -batch -ex run -ex 'bt' --args ./host_test "$core" 2>&1
else
	./host_test "$core"
	echo "EXIT=$?"
fi
