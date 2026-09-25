#!/usr/bin/env python3
"""Cobertura de ejecución a partir del trace de libRetroReversing (`src/trace_log.txt`).

Uso: python tools/python/re_trace_to_ranges.py <RE_project_dir> [out.txt]

Cada línea del trace contiene `pc:BBBB:OOOOOOOO` (banco:offset). Se emiten las direcciones
únicas como líneas `ADDR 01` (formato de `tools/ghidra/ApplyRanges.java`). Banco 0 = offset;
otros bancos = `bank*0x8000 + offset` (aprox. para MD sin Sega mapper).
"""
import re
import sys
from pathlib import Path

PC = re.compile(r'pc:([0-9A-Fa-f]{4}):([0-9A-Fa-f]{8})')


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    proj = Path(sys.argv[1])
    trace = proj / 'src' / 'trace_log.txt'
    if not trace.is_file():
        print(f'ERROR: no existe {trace}', file=sys.stderr)
        return 3
    out = Path(sys.argv[2]) if len(sys.argv) > 2 else proj / 'coverage.trace.ranges.txt'
    seen = set()
    with trace.open('r', encoding='utf-8', errors='replace') as fh:
        for line in fh:
            m = PC.search(line)
            if not m:
                continue
            bank = int(m.group(1), 16)
            off = int(m.group(2), 16)
            seen.add(off if bank == 0 else bank * 0x8000 + off)
    with out.open('w', encoding='utf-8') as fh:
        for a in sorted(seen):
            fh.write(f'{a:08x} 01\n')
    print(f'OK: {len(seen)} PCs ejecutados -> {out}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
