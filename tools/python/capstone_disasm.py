#!/usr/bin/env python3
"""Desensambla un binario con Capstone y emite ASM + rangos (para puente a Ghidra).

Arquitecturas soportadas por Capstone 5: m6502 (MOS65XX) y m68k.
Z80 NO está en Capstone 5 (se añadió en la rama `next`); para Z80 usar Rizin
(external/rizin-win-installer-clang_cl-64) o actualizar a capstone-next.

Uso:
  python tools/python/capstone_disasm.py --arch m6502|m68k \
      --file <bin> [--base 0x0] [--len N] --out <prefijo>

Genera <prefijo>.asm y <prefijo>.ranges.json
(ranges = [[addr, addr+size], ...] de instrucciones decodificadas).
"""
import argparse
import json
from pathlib import Path

import capstone


ARCH = {
    'm6502': (capstone.CS_ARCH_MOS65XX, capstone.CS_MODE_MOS65XX_6502),
    'm68k':  (capstone.CS_ARCH_M68K, capstone.CS_MODE_BIG_ENDIAN),
}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arch', required=True, choices=list(ARCH))
    ap.add_argument('--file', required=True)
    ap.add_argument('--base', default='0x0')
    ap.add_argument('--len', type=int, default=0)
    ap.add_argument('--out', required=True)
    a = ap.parse_args()

    base = int(a.base, 0)
    data = Path(a.file).read_bytes()
    if a.len:
        data = data[:a.len]

    arch, mode = ARCH[a.arch]
    md = capstone.Cs(arch, mode)
    md.detail = False

    out = Path(a.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    ranges = []
    skipped = 0
    offset = 0
    with out.with_suffix('.asm').open('w', encoding='utf-8') as f:
        f.write(f'; disasm {a.file} base=0x{base:04x} arch={a.arch} ({len(data)} bytes)\n')
        while offset < len(data):
            found = False
            for ins in md.disasm(data[offset:], base + offset, count=1):
                f.write(f'{ins.address:06x}:  {ins.mnemonic:<8} {ins.op_str}\n')
                ranges.append([ins.address, ins.address + ins.size])
                offset += ins.size
                found = True
            if not found:
                f.write(f'{base + offset:06x}:  .byte 0x{data[offset]:02x}\n')
                offset += 1
                skipped += 1

    out.with_suffix('.ranges.json').write_text(
        json.dumps({'arch': a.arch, 'base': base, 'bytes': len(data),
                    'instruction_count': len(ranges), 'skipped_bytes': skipped,
                    'ranges': ranges}, indent=2),
        encoding='utf-8')
    # Formato simple para el puente a Ghidra (ApplyRanges.java): "addr size" en hex.
    with out.with_suffix('.ranges.txt').open('w', encoding='utf-8') as f:
        for start, end in ranges:
            f.write(f'{start:06x} {end - start:02x}\n')
    print(f'OK {a.arch}: {len(ranges)} instrucciones, {skipped} bytes no decodificados -> {out.with_suffix(".asm")}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
