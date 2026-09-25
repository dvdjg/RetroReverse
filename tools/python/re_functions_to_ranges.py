#!/usr/bin/env python3
"""Convierte la salida de libRetroReversing (functions.json) en rangos para ApplyRanges.

Uso: python tools/python/re_functions_to_ranges.py <RE_project_dir> [out.txt]

Lee `<dir>/functions.json` (lista de [idx, {func_name, func_offset, ...}]) y escribe
líneas `ADDR 01` (hex) con la dirección lineal de cada función ejecutada. Para mappers
con banco (nombre `_BBBB_func_XXXXXXXX`), banco 0 se mapea a su offset; otros bancos se
mapean a `bank*0x8000 + offset` (aprox. MD sin Sega mapper, suficiente como cobertura).
"""
import json
import re
import sys
from pathlib import Path

NAME = re.compile(r'^_([0-9A-Fa-f]{4})_func_([0-9A-Fa-f]+)$')


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    proj = Path(sys.argv[1])
    out = Path(sys.argv[2]) if len(sys.argv) > 2 else proj / 'coverage.ranges.txt'
    funcs = json.loads((proj / 'functions.json').read_text(encoding='utf-8'))
    seen = set()
    for _key, f in funcs:
        m = NAME.match(str(f.get('func_name', '')))
        if not m:
            continue
        bank = int(m.group(1), 16)
        off = int(f.get('func_offset') or m.group(2), 16)
        addr = off if bank == 0 else bank * 0x8000 + off
        seen.add(addr)
    with out.open('w', encoding='utf-8') as fh:
        for a in sorted(seen):
            fh.write(f'{a:08x} 01\n')
    print(f'OK: {len(seen)} funciones -> {out}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
