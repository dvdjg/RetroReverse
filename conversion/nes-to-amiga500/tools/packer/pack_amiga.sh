#!/usr/bin/env bash
# pack_amiga.sh — empaqueta un juego transpilado para Amiga en un contenedor RRPK.
#
# Punto de integración de la emisión del artefacto Amiga: los rangos se etiquetan
# por tipo (code / data / prg / chr) para que el packer elija el códec por
# segmento. Con la decisión del ADR 0006, todos van con ZX0 (o `store`).
#
# Uso:
#   pack_amiga.sh <code.bin> <data.bin> <game.nes> <salida.rrpk>
#
#   code.bin : sección .text del transpilado compilado a -m68000
#              (lo extrae ../codec-bench/scripts/gen_corpus_m68k.ps1)
#   data.bin : .rodata+.data del mismo objeto
#   game.nes : ROM de origen, de donde se extraen PRG y CHR
set -euo pipefail
cd "$(dirname "$0")"

if [ "$#" -ne 4 ]; then
	echo "Uso: pack_amiga.sh <code.bin> <data.bin> <game.nes> <salida.rrpk>" >&2
	exit 2
fi
CODE="$1"; DATA="$2"; NES="$3"; OUT="$4"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# Extrae PRG y CHR crudos del iNES.
python3 - "$NES" "$TMP" <<'PY'
import sys
data = open(sys.argv[1], 'rb').read()
h = data[:16]
if h[:4] != b"NES\x1a":
    sys.exit("no es iNES")
prg, chr_ = h[4] * 16384, h[5] * 8192
t = 512 if (h[6] & 0x04) else 0
body = data[16 + t:]
if prg:
    open(sys.argv[2] + "/prg.bin", "wb").write(body[:prg])
if chr_:
    open(sys.argv[2] + "/chr.bin", "wb").write(body[prg:prg + chr_])
PY

make -s
ARGS=("$CODE:code" "$DATA:data")
[ -f "$TMP/prg.bin" ] && ARGS+=("$TMP/prg.bin:prg")
[ -f "$TMP/chr.bin" ] && ARGS+=("$TMP/chr.bin:chr")

./build/packer "${ARGS[@]}" -o "$OUT"
./build/packer --verify "$OUT"
echo "OK -> $OUT"
