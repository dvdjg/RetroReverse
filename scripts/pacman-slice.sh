#!/usr/bin/env bash
# Vertical slice P0.3 — Pac-Man (MAME 2003-Plus) vía el orquestador.
# Ejecuta el core real, comprueba determinismo y vuelca trazas/savestates/capturas
# a extraction/. Ver platforms/.../pacman/docs/INSTRUMENTATION.md.
#
# Uso: scripts/pacman-slice.sh
# Variables de entorno (opcionales):
#   CORE, ROM, OUT, FRAMES, INTERVAL, SCENARIO (idle|start), DET, DUMP_RAM
#   DUMP_RAM: rangos (offset relativo a RETRO_MEMORY_SYSTEM_RAM) "A:L,A:L".
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NODE="$ROOT/platforms/arcade/dedicated/namco_pacman/pacman"
CORE="${CORE:-$ROOT/external/libretro-mame2003-plus/mame2003_plus_libretro.so}"
ROM="${ROM:-$NODE/rom/raw/pacman.zip}"
OUT="${OUT:-$NODE/extraction}"
FRAMES="${FRAMES:-600}"
INTERVAL="${INTERVAL:-60}"
SCENARIO="${SCENARIO:-start}"
DET="${DET:-30}"
DUMP_RAM="${DUMP_RAM:-0x4c00:0x0400,0x4ff0:0x0100,0x4000:0x0400,0x4400:0x0400}"

[[ -f "$CORE" ]] || { echo "FALTA el core: $CORE"; echo "  compílalo: scripts/build-libretro-core.sh libretro-mame2003-plus"; exit 2; }
[[ -f "$ROM" ]] || { echo "FALTA la ROM: $ROM"; echo "  pon el romset pacman.zip en rom/raw/ (o pasa ROM=...)"; exit 3; }

make -C "$ROOT/tools/orchestrator" vertical_slice
exec "$ROOT/tools/orchestrator/vertical_slice" \
	--core "$CORE" --rom "$ROM" --out "$OUT" \
	--frames "$FRAMES" --interval "$INTERVAL" --scenario "$SCENARIO" --det "$DET" \
	--dump-ram "$DUMP_RAM"
