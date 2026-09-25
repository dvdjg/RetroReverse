#!/usr/bin/env python3
"""copper_decode.py — decodifica una Copperlist binaria a texto (MOVE/WAIT/SKIP).

Uso:
    python copper_decode.py <fichero.bin> [--base 0x0] [--limit N] [--json]

`--base` es la dirección donde se cargó la lista (para las direcciones impresas).
Cada instrucción Copper son 4 bytes: 2 palabras big-endian.
  - bit0 de la 1ª palabra == 0  -> MOVE: destino = (w1 & 0x1FE), dato = w2
  - bit0 == 1 y w2 == 0         -> WAIT (máscara/valor)
  - bit0 == 1 y w2 != 0         -> SKIP
"""
from __future__ import annotations

import argparse
import json
import sys


def decode(data: bytes, base: int, limit: int | None):
    out = []
    n = len(data) // 4
    if limit:
        n = min(n, limit)
    for i in range(n):
        w1 = (data[i * 4] << 8) | data[i * 4 + 1]
        w2 = (data[i * 4 + 2] << 8) | data[i * 4 + 3]
        addr = base + i * 4
        if (w1 & 1) == 0:
            reg = w1 & 0x1FE
            out.append({"addr": addr, "kind": "move", "reg": reg, "val": w2,
                        "text": f"{addr:#08x}: move.w #${w2:04x}, $dff{reg:03x}"})
        elif w2 == 0:
            out.append({"addr": addr, "kind": "wait", "mask": w1 & 0x1FE, "val": 0,
                        "text": f"{addr:#08x}: WAIT ${w1 & 0x1FE:03x}"})
        else:
            out.append({"addr": addr, "kind": "skip", "mask": w1 & 0x1FE, "val": w2,
                        "text": f"{addr:#08x}: SKIP ${w1 & 0x1FE:03x}"})
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description="decodifica una Copperlist binaria")
    ap.add_argument("file")
    ap.add_argument("--base", default="0x0")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--json", action="store_true")
    args = ap.parse_args()
    base = int(args.base, 16) if args.base.lower().startswith("0x") else int(args.base)
    data = open(args.file, "rb").read()
    ins = decode(data, base, args.limit or None)
    if args.json:
        print(json.dumps(ins, indent=2))
    else:
        for x in ins:
            print(x["text"])
    return 0


if __name__ == "__main__":
    sys.exit(main())
