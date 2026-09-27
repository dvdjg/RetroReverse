#!/usr/bin/env python3
"""trace_diff — compara la traza de CPU del oráculo con una **referencia** (fceumm)
y localiza la **primera divergencia**.

Formatos:
  - nuestra: `frame_probe.cpu` (8 B/instrucción: PClo, PChi, op, A, X, Y, P, SP)
  - referencia: `FCEUMM_TRACE` (6 B/instrucción: PClo, PChi, op, A, X, S)

Uso:  python3 trace_diff.py <nuestra.cpu> <ref.bin>
"""
import sys


def load_ours(path):
    d = open(path, 'rb').read()
    return [(d[8*i] | (d[8*i+1] << 8), d[8*i+2], d[8*i+3], d[8*i+4], d[8*i+7]) for i in range(len(d)//8)]


def load_ref(path):
    d = open(path, 'rb').read()
    return [(d[6*i] | (d[6*i+1] << 8), d[6*i+2], d[6*i+3], d[6*i+4], d[6*i+5]) for i in range(len(d)//6)]


def main():
    O = load_ours(sys.argv[1])
    R = load_ref(sys.argv[2])
    print('nuestras instr:', len(O), ' referencia:', len(R))
    n = min(len(O), len(R))
    for i in range(n):
        if O[i][0] != R[i][0] or O[i][1] != R[i][1]:
            print('PRIMERA divergencia en idx', i)
            for j in range(max(0, i-10), min(len(O), i + 3)):
                o = O[j]
                r = R[j] if j < len(R) else (0, 0, 0, 0, 0)
                mark = '  <-- DIVERGE' if j == i else ''
                print('O %6d PC=%04X op=%02X A=%02X   |   R PC=%04X op=%02X A=%02X%s'
                      % (j, o[0], o[1], o[2], r[0], r[1], r[2], mark))
            return
    print('sin divergencia en las primeras %d instrucciones' % n)


if __name__ == '__main__':
    main()
