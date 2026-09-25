#!/usr/bin/env bash
# Decompile one or more addresses with rz-ghidra (`pdg`) and append the C to a file.
# Useful to dump a SECOND decompiler's output for cross-checking Ghidra.
#
# Usage:  bash pdg-dump.sh <in.bin> <out.c> <addr1> [addr2 ...]
#         RZ=~/rizin/bin/rizin bash pdg-dump.sh ...   # override rizin
#
# Note: m68k is big-endian and we import the raw module at base 0 (same as the curated .asm).

set -e
RZ="${RZ:-$HOME/rizin/bin/rizin}"
IN="$1"; OUT="$2"; shift 2

{
	echo "// rz-ghidra (Rizin 0.9.0 + rz-ghidra 0.9.0) -- m68k -- base 0x0"
	for a in "$@"; do
		echo "// ===================== @ $a ====================="
		"$RZ" -a m68k -b 32 -E big -m 0x0 -q -e scr.color=0 -c "s $a" -c "af" -c "pdg" "$IN"
	done
} >> "$OUT" 2>&1
echo "appended to $OUT"
