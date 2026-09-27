#!/usr/bin/env python3
"""trace_diff — compara la traza de CPU del oráculo con una **referencia** (mesen)
y localiza la **primera divergencia** instrucción a instrucción.

Formatos reales (los que escriben hoy las herramientas):
  - nuestra (`frame_probe.cpu`):   12 B/instrucción
        PClo, PChi, op, A, X, Y, P, SP, cyc(4 LE)
  - referencia (`$MESEN_TRACE` / `$FCEUMM_TRACE`): 10 B/instrucción
        PClo, PChi, op, A, X, S, timestamp(4 LE)

Re-sincronización por PC: cuando las trazas divergen en el índice, es habitual que
una haya ejecutado **iteraciones extra de un bucle benigno** (p. ej. el bucle
`LDA $2002/BPL` de espera de VBlank). Comparar por índice se atasca ahí y no deja
ver la divergencia **real**. Este script alinea por contenido: en un desajuste busca
el salto mínimo (k en la nuestra, l en la referencia) que vuelve a emparejar
(PC, opcode) y lo reporta como "resync"; la **primera divergencia que NO puede
re-sincronizar** dentro de la ventana es la divergencia de camino real.

Uso:
    python3 trace_diff.py <nuestra.cpu> <ref.bin> [--window N] [--maxskip M]
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
    """Carga la traza de la referencia (10 B/inst): (pc, op, A, X, S, timestamp)."""
    d = open(path, 'rb').read()
    n = len(d) // 10
    out = []
    for i in range(n):
        b = d[10 * i:10 * i + 10]
        pc = b[0] | (b[1] << 8)
        cyc = b[6] | (b[7] << 8) | (b[8] << 16) | (b[9] << 24)
        out.append((pc, b[2], b[3], b[4], b[5], cyc))
    return out


def resync(O, R, i, j, maxskip):
    """Busca el salto mínimo (k>0 en O o l>0 en R) que reempareja (PC, op).

    Devuelve (k, l) o None si no hay emparejamiento dentro de la ventana. Se
    prefiere el salto total k+l más pequeño; en empate, el que menos avanza en O.
    """
    best = None
    for k in range(maxskip + 1):
        if i + k >= len(O):
            break
        ko = (O[i + k][0], O[i + k][1])
        # el delta actual ya es peor que el mejor: no puede mejorar
        if best is not None and k > best[0]:
            break
        for l in range(maxskip + 1):
            if j + l >= len(R) or k + l > (best[0] if best else maxskip):
                break
            if l == 0 and k == 0:
                continue  # eso es el emparejamiento trivial
            kr = (R[j + l][0], R[j + l][1])
            if ko == kr:
                tot = k + l
                if best is None or tot < best[0] or (tot == best[0] and k < best[1]):
                    best = (tot, k, l)
                break  # para este k, el menor l es el mejor
    return None if best is None else (best[1], best[2])


def fmt(seq, idx):
    if idx >= len(seq):
        return '(fin)'
    t = seq[idx]
    return 'PC=%04X op=%02X A=%02X' % (t[0], t[1], t[2])


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    win = 6
    if '--window' in sys.argv:
        win = int(sys.argv[sys.argv.index('--window') + 1])
    maxskip = 128
    if '--maxskip' in sys.argv:
        maxskip = int(sys.argv[sys.argv.index('--maxskip') + 1])
    if len(args) < 2:
        print(__doc__)
        return
    O = load_ours(args[0])
    R = load_ref(args[1])
    print('nuestras instr:', len(O), ' referencia:', len(R))

    i = j = 0
    nres = 0
    while i < len(O) and j < len(R):
        if O[i][0] == R[j][0] and O[i][1] == R[j][1]:
            i += 1
            j += 1
            continue
        rs = resync(O, R, i, j, maxskip)
        if rs is None:
            print('\nDIVERGENCIA DE CAMINO (sin re-sync) en idx O=%d R=%d' % (i, j))
            for t in range(win):
                print('  O %6d %s   |   R %6d %s' % (i + t, fmt(O, i + t), j + t, fmt(R, j + t)))
            return
        k, l = rs
        if nres < 12:
            print('resync #%d: salto O+%d R+%d en idx O=%d R=%d  (%s | %s)'
                  % (nres, k, l, i, j, fmt(O, i), fmt(R, j)))
        nres += 1
        i += k
        j += l
    print('\nfin: %d re-syncs benignos; se agotó una traza (O=%d R=%d sin divergencia de camino)'
          % (nres, i, j))


if __name__ == '__main__':
    main()
