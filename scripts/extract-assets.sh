#!/usr/bin/env bash
# Extrae assets y desensamblados de la selección de ROMs a tools/out/assets/ (ignorado por git).
# - NES: CHR (tiles) + paleta + PRG
# - Arcade (Pac-Man): tiles + PROMs + programa Z80
# - Capstone: desensamblado 6502 (NES) y 68k (Mega Drive) + rangos para Ghidra
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="${OUT:-$ROOT/tools/out/assets}"
PY=python3

"$PY" "$ROOT/tools/python/nes_assets.py" \
	"$ROOT/roms/nes/Super Mario Bros. (World).nes" "$OUT/nes"
"$PY" "$ROOT/tools/python/pacman_assets.py" \
	"$ROOT/roms/arcade/pacman.zip" "$OUT/arcade"
"$PY" "$ROOT/tools/python/capstone_disasm.py" --arch m6502 \
	--file "$OUT/nes/Super_Mario_Bros._(World)_prg.bin" --base 0x8000 --out "$OUT/nes/smb_prg"
"$PY" "$ROOT/tools/python/capstone_disasm.py" --arch m68k \
	--file "$ROOT/roms/megadrive/Golden Axe (World).md" --base 0x0 --len 8192 \
	--out "$OUT/megadrive/goldenaxe"

echo "assets y desensamblados en $OUT"
