#!/usr/bin/env python3
"""bin_scan.py — escaneo genérico de un binario (ADF, volcado de RAM, módulo).

Muestra strings legibles con su offset (y dirección si se da --base) y un mapa de
entropía por bloque, útil para localizar código, texto, gráficos y datos comprimidos.

Uso:
    python bin_scan.py <fichero> [--base 0xC00000] [--block 4096]
                       [--min-str 6] [--max-strings 80] [--no-entropy]

Ejemplos:
    python bin_scan.py out/disk/game.adf
    python bin_scan.py out/ram/slowc00000.bin --base 0xc00000
"""
from __future__ import annotations

import argparse
import collections
import math
import re
import sys


def entropy(b: bytes) -> float:
    if not b:
        return 0.0
    c = collections.Counter(b)
    n = len(b)
    return -sum((v / n) * math.log2(v / n) for v in c.values())


def scan_strings(d: bytes, minlen: int, maxout: int):
    out = []
    for m in re.finditer(rb"[\x20-\x7e]{%d,}" % minlen, d):
        s = m.group()
        if sum(chr(c).isalpha() for c in s) >= 4:
            out.append((m.start(), s[:80].decode("latin1")))
            if len(out) >= maxout:
                break
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description="strings + entropía de un binario")
    ap.add_argument("file")
    ap.add_argument("--base", default="0", help="dirección del offset 0 (hex o dec)")
    ap.add_argument("--block", type=int, default=4096)
    ap.add_argument("--min-str", type=int, default=6)
    ap.add_argument("--max-strings", type=int, default=80)
    ap.add_argument("--no-entropy", action="store_true")
    args = ap.parse_args()

    base = int(args.base, 16) if args.base.lower().startswith("0x") else int(args.base)
    d = open(args.file, "rb").read()
    print(f"fichero: {args.file} ({len(d)} bytes)")
    print(f"-- strings (>= {args.min_str}) --")
    for off, s in scan_strings(d, args.min_str, args.max_strings):
        print(f"{off:#08x}  {(base + off):#08x}  {s}")
    if not args.no_entropy:
        print(f"-- entropía por bloque de {args.block} --")
        for off in range(0, len(d), args.block):
            b = d[off:off + args.block]
            print(f"{off:#08x}  {(base + off):#08x}  {entropy(b):.2f}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
