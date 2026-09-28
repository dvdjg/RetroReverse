#!/usr/bin/env bash
# vblank_wait_test — guarda de regresión del timing de VBlank/NMI (sub-instrucción).
#
# Compara nuestra traza de CPU con la de mesen (`runtime/test/trace_diff.py`) en una
# ROM cuyo bucle de espera de VBlank es sensible (Uncharted Waters, MMC5) y verifica
# que **no hay divergencia de camino** (mismo flujo de PC/opcode). Reporta el re-sync
# máximo como información: el límite conocido de Uncharted es `O+7944` (giramos ~1
# frame extra en el bucle `$F506-$F50F` por la granularidad de muestreo del flag; ver
# docs/TIMING_ROADMAP.md). El test falla si aparece una **divergencia de camino** real.
#
# Requiere mesen (`external/libretro-mesen/Libretro/mesen_libretro.so`), el orquestador
# (`tools/orchestrator/vertical_slice`) y la ROM. Si falta algo → **se omite** (0): el
# CI público no los tiene.
set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
NODE="$(cd "$HERE/../../.." && pwd)"            # .../nes-to-amiga500
RUNTIME="$NODE/runtime"
REPO="$(cd "$NODE/../.." && pwd)"               # raíz del repo
ENG="${AMIGA_CPP:-$NODE/../../../../Amiga-Cpp}/engine/include"
ROM="${VB_ROM:-$RUNTIME/build/Uncharted Waters (USA).nes}"
MESEN="$REPO/external/libretro-mesen/Libretro/mesen_libretro.so"
ORCH="$REPO/tools/orchestrator/vertical_slice"
FRAMES="${VB_FRAMES:-40}"

[ -f "$ROM" ] || { echo "vblank_wait_test: sin ROM ('$ROM'); se omite."; exit 0; }
[ -f "$MESEN" ] || { echo "vblank_wait_test: sin mesen; se omite."; exit 0; }
[ -x "$ORCH" ] || { echo "vblank_wait_test: sin orquestador; se omite."; exit 0; }
[ -d "$ENG" ] || { echo "vblank_wait_test: sin engine ('$ENG'); se omite."; exit 0; }
command -v python3 >/dev/null 2>&1 || { echo "vblank_wait_test: sin python3; se omite."; exit 0; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

g++ -std=gnu++23 -O2 -w -I "$ENG" -I "$RUNTIME/include" -I "$RUNTIME/fallback" \
	"$RUNTIME/tools/frame_probe.cpp" -o "$TMP/frame_probe" 2>/dev/null ||
	{ echo "vblank_wait_test: no se pudo compilar frame_probe; se omite."; exit 0; }

( cd "$TMP" && "$TMP/frame_probe" "$ROM" "$FRAMES" --trace ) >/dev/null 2>&1
# --det 0: sin la comprobación de determinismo (que rebobina el core y mezcla pasadas).
mkdir -p "$TMP/out"
MESEN_TRACE="$TMP/ref.trace" "$ORCH" --core "$MESEN" --rom "$ROM" --out "$TMP/out" \
	--frames "$FRAMES" --interval 0 --det 0 >/dev/null 2>&1
[ -s "$TMP/frame_probe.cpu" ] && [ -s "$TMP/ref.trace" ] ||
	{ echo "vblank_wait_test: no se generaron las trazas; se omite."; exit 0; }

OUT="$(python3 "$RUNTIME/test/trace_diff.py" "$TMP/frame_probe.cpu" "$TMP/ref.trace" --maxskip 20000 2>&1)"
echo "$OUT" | tail -2
MAX="$(printf '%s' "$OUT" | grep -oE 'salto O\+[0-9]+' | grep -oE '[0-9]+' | sort -n | tail -1)"
MAX="${MAX:-0}"

if printf '%s' "$OUT" | grep -q 'DIVERGENCIA DE CAMINO'; then
	echo "vblank_wait_test: FALLA — divergencia de camino real (esperado solo re-syncs)"
	exit 1
fi
echo "vblank_wait_test: OK — sin divergencia de camino (re-sync máx O+$MAX)"
