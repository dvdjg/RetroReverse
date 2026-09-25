#!/usr/bin/env python3
"""Cobertura de ejecución a partir del trace de libRetroReversing (`src/trace_log.txt`).

Uso: python tools/python/re_trace_to_ranges.py <RE_project_dir> [out.txt] [--rom ROM]

Cada línea del trace contiene `pc:BBBB:OOOOOOOO` (banco:offset). Por defecto emite **inicios de
bloque** (una instrucción que NO es el fall-through de la anterior), calculando la longitud de la
instrucción con Capstone (m68k) sobre la ROM. Sin `--rom`, emite todos los PCs únicos.

Salida: líneas `ADDR 01` (formato de `tools/ghidra/ApplyRanges.java`). Banco 0 = offset del ROM;
otros bancos = `bank*0x8000 + offset` (aprox. para MD sin Sega mapper).
"""
import argparse
import re
from pathlib import Path

PC = re.compile(r'pc:([0-9A-Fa-f]{4}):([0-9A-Fa-f]{8})')


def linear(bank, off):
    return off if bank == 0 else bank * 0x8000 + off


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('project')
    ap.add_argument('out', nargs='?')
    ap.add_argument('--rom', default=None)
    a = ap.parse_args()

    proj = Path(a.project)
    trace = proj / 'src' / 'trace_log.txt'
    if not trace.is_file():
        print(f'ERROR: no existe {trace}')
        return 3
    out = Path(a.out) if a.out else proj / 'coverage.trace.ranges.txt'

    insn_len = None
    rom = None
    if a.rom:
        import capstone
        rom = Path(a.rom).read_bytes()
        md = capstone.Cs(capstone.CS_ARCH_M68K, capstone.CS_MODE_BIG_ENDIAN)
        cache = {}

        def length(off):
            if off in cache:
                return cache[off]
            if off + 2 > len(rom):
                cache[off] = 0
                return 0
            n = 0
            for ins in md.disasm(rom[off:off + 16], 0, count=1):
                n = ins.size
            cache[off] = n
            return n

        insn_len = length

    blocks = set()
    prev_end = None
    with trace.open('r', encoding='utf-8', errors='replace') as fh:
        for line in fh:
            m = PC.search(line)
            if not m:
                continue
            bank = int(m.group(1), 16)
            off = int(m.group(2), 16)
            addr = linear(bank, off)
            if insn_len is None or bank != 0:
                blocks.add(addr)  # sin ROM (o banco != 0): todos los PCs
                prev_end = None
                continue
            if prev_end != addr:
                blocks.add(addr)
            n = insn_len(off)
            prev_end = addr + (n if n else 2)

    with out.open('w', encoding='utf-8') as fh:
        for x in sorted(blocks):
            fh.write(f'{x:08x} 01\n')
    print(f'OK: {len(blocks)} {"inicios de bloque" if insn_len else "PCs"} -> {out}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
