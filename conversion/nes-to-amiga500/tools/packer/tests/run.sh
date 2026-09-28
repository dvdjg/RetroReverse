#!/usr/bin/env bash
# tests/run.sh — round-trip del packer: empaqueta, verifica (CRC) y desempaqueta.
set -euo pipefail
cd "$(dirname "$0")/.."
make -s

T="$(mktemp -d)"
trap 'rm -rf "$T"' EXIT

# Dos casos: contenido muy repetitivo (debe comprimir con ZX0) y aleatorio
# (debe caer a `store` por no mejorar).
python3 - "$T" <<'PY'
import os, random, sys
t = sys.argv[1]
open(os.path.join(t, "rep.bin"), "wb").write(
    (b"AMIGA-500-RETROREVERSE" * 400) + bytes(range(256)) * 8)
random.seed(1)
open(os.path.join(t, "rnd.bin"), "wb").write(
    bytes(random.randrange(256) for _ in range(3000)))
PY

./build/packer "$T/rep.bin:code" "$T/rnd.bin:data" -o "$T/t.rrpk"
./build/packer --list "$T/t.rrpk"
./build/packer --verify "$T/t.rrpk"

mkdir -p "$T/out"
./build/packer --unpack "$T/t.rrpk" "$T/out"
cmp "$T/rep.bin" "$T/out/seg000.bin"
cmp "$T/rnd.bin" "$T/out/seg001.bin"

# El segmento aleatorio no debe comprimir (store); el repetitivo sí (zx0).
if ! grep -q "zx0" <<<"$(./build/packer --list "$T/t.rrpk")"; then
	echo "FALLA: se esperaba al menos un segmento zx0" >&2
	exit 1
fi
if ! grep -q "store" <<<"$(./build/packer --list "$T/t.rrpk")"; then
	echo "FALLA: se esperaba al menos un segmento store" >&2
	exit 1
fi

echo "TEST OK"
