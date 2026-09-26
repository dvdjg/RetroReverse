#!/usr/bin/env bash
# Comprueba que el adaptador libretro carga cada core compilado en external/.
# (host_test imprime el nombre del core antes de requerir ROM.)
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ORCH="$ROOT/tools/orchestrator"

cores=(
	"libretro-mame2003-plus/mame2003_plus_libretro.so"
	"libretro-genesis-plus-gx/genesis_plus_gx_libretro.so"
	"libretro-mesen/mesen_libretro.so"
	"libretro-uae/puae_libretro.so"
	"libretro-stella/stella2023_libretro.so"
	"libretro-gambatte/gambatte_libretro.so"
	"libretro-smsplus/smsplus_libretro.so"
	"libretro-fbneo/fbneo_libretro.so"
)

if [[ ! -x "$ORCH/host_test" ]]; then
	echo "ERROR: falta $ORCH/host_test (ejecuta 'make' en tools/orchestrator)" >&2
	exit 2
fi

fails=0
for c in "${cores[@]}"; do
	p="$ROOT/external/$c"
	if [[ ! -f "$p" ]]; then
		echo "FALTA   $(basename "$c")  ($c)"
		fails=1
		continue
	fi
	line="$("$ORCH/host_test" "$p" 2>&1 | head -1)"
	printf '%-32s %s\n' "$(basename "$c")" "$line"
done
exit $fails
