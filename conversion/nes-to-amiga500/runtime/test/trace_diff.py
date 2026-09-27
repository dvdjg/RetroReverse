#!/usr/bin/env python3
"""trace_diff — compara la traza de CPU del oráculo con una **referencia** (fceumm)
y localiza la **primera divergencia** instrucción a instrucción.

Formatos reales (los que escriben hoy las herramientas):
  - nuestra (`frame_probe.cpu`):   12 B/instrucción
        PClo, PChi, op, A, X, Y, P, SP, cyc(4 LE)
  - referencia (`$FCEUMM_TRACE`):  10 B/instrucción
        PClo, PChi, op, A, X, S, timestamp(4 LE)  (timestamp = ciclos totales del CPU)

El `timestamp` de fceumm y nuestro `cyc` son la misma magnitud (ciclos de CPU totales
acumulados), así que la columna de ciclos permite distinguir "diverge por fase del PPU"
(PC/op iguales, ciclos iguales) de "diverge por conteo de ciclos" (ciclos distintos).

Uso:
    python3 trace_diff.py <nuestra.cpu> <ref.bin> [--n N] [--window W]
"""

import sys


def load_ours(path):
    """Carga la traza del oráculo (12 B/inst): (pc, op, A, X, SP, cyc)."""
    d = open(path, 'rb').read()
    n = len(d) // 12
    out = []
    for i in range(n):
        b = d[12 * i:12 * i + 12]
        pc = b[0] | (b[1] << 8)
        cyc = b[8] | (b[9] << 8) | (b[10] << 16) | (b[11] << 24)
        out.append((pc, b[2], b[3], b[4], b[7], cyc))
    return out


def load_ref(path):
    """Carga la traza de fceumm (10 B/inst): (pc, op, A, X, S, timestamp)."""
    d = open(path, 'rb').read()
    n = len(d) // 10
    out = []
    for i in range(n):
        b = d[10 * i:10 * i + 10]
        pc = b[0] | (b[1] << 8)
        cyc = b[6] | (b[7] << 8) | (b[8] << 16) | (b[9] << 24)
        out.append((pc, b[2], b[3], b[4], b[5], cyc))
    return out


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    win = 12
    if '--window' in sys.argv:
        win = int(sys.argv[sys.argv.index('--window') + 1])
    if len(args) < 2:
        print(__doc__)
        return
    O = load_ours(args[0])
    R = load_ref(args[1])
    print('nuestras instr:', len(O), ' referencia:', len(R))
    n = min(len(O), len(R))
    for i in range(n):
        if O[i][0] != R[i][0] or O[i][1] != R[i][1]:
            print('PRIMERA divergencia en idx', i)
            lo = max(0, i - win)
            for j in range(lo, min(len(O), i + 3)):
                o = O[j]
                r = R[j] if j < len(R) else (0, 0, 0, 0, 0, 0)
                cyc = ''
                if o[5] != r[5]:
                    cyc = '  CYC O=%d R=%d (%+d)' % (o[5], r[5], o[5] - r[5])
                mark = '  <-- DIVERGE' if j == i else ''
                print('O %6d PC=%04X op=%02X A=%02X   |   R PC=%04X op=%02X A=%02X%s%s'
                      % (j, o[0], o[1], o[2], r[0], r[1], r[2], cyc, mark))
            return
    print('sin divergencia en las primeras %d instrucciones' % n)
    oc, rc = O[n - 1][5], R[n - 1][5]
    print('ciclos al final: O=%d R=%d (diff %+d)' % (oc, rc, oc - rc))


if __name__ == '__main__':
    main()
