#!/usr/bin/env bash
# Compila en serie los cores libretro indicados (o los de la lista por defecto).
# Uso: scripts/build-cores.sh [core-dir...]
#      scripts/build-cores.sh                 # lista por defecto
set -uo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
default=(libretro-mame2003-plus libretro-genesis-plus-gx libretro-mesen libretro-uae)
cores=("$@")
[[ ${#cores[@]} -gt 0 ]] || cores=("${default[@]}")

fail=0
for c in "${cores[@]}"; do
	echo "===== $c ====="
	if bash "$REPO_DIR/scripts/build-libretro-core.sh" "$c"; then
		echo "===== $c OK ====="
	else
		echo "===== $c FALLÓ (rc=$?) ====="
		fail=1
	fi
done
echo "resultado: $([[ $fail -eq 0 ]] && echo OK || echo CON-FALLOS)"
exit $fail
