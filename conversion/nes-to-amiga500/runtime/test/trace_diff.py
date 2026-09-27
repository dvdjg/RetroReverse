#!/usr/bin/env python3
"""trace_diff — compara la traza de CPU del oráculo con una **referencia** (mesen) y
localiza la **primera divergencia** instrucción a instrucción.

Formatos (los que escriben hoy las herramientas):
  - nuestra (`frame_probe.cpu`):   **16 B**/instrucción
        PClo, PChi, op, A, X, Y, P, SP, cyc(4 LE), ppu(4 LE = scanline*341+dot)
  - referencia (`$MESEN_TRACE`): **14 B**/instrucción
        PClo, PChi, op, A, X, S, timestamp(4 LE), ppu(4 LE = (scanline+1)*341+cycle)
  - compatibilidad: acepta también 12 B (sin ppu) y 10 B (sin ppu) por si se usan
    trazas antiguas o el parche de fceumm (10 B).

La columna **dPPU** (posición del PPU de la referencia − la nuestra, alineadas por la
base de una línea) revela el **desfase de fase** CPU↔PPU: si es constante, el problema
es de fase (ver docs/TIMING_ROADMAP.md).

Uso:  python3 trace_diff.py <nuestra.cpu> <ref.bin> [--window N] [--maxskip M]
"""

import sys


def _load(path, rec, rec_small, cyc_off, sp_off, ppu_off):
    """Lee una traza con tamaño de registro `rec` (con ppu) o `rec_small` (sin ppu).
    \return Lista de `(pc, op, A, sp, cyc, ppu)`.
    """
    d = open(path, 'rb').read()
    r = rec if len(d) % rec == 0 else rec_small
    with_ppu = r == rec
    out = []
    for i in range(len(d) // r):
        b = d[r * i:r * i + r]
        pc = b[0] | (b[1] << 8)
        cyc = b[cyc_off] | (b[cyc_off + 1] << 8) | (b[cyc_off + 2] << 16) | (b[cyc_off + 3] << 24)
        ppu = 0
        if with_ppu:
            ppu = (b[ppu_off] | (b[ppu_off + 1] << 8) | (b[ppu_off + 2] << 16) |
                   (b[ppu_off + 3] << 24))
        out.append((pc, b[2], b[3], b[sp_off], cyc, ppu))
    return out


def load_ours(path):
    """Traza del oráculo: 16 B (con ppu) o 12 B (sin ppu)."""
    return _load(path, 16, 12, 8, 7, 12)


def load_ref(path):
    """Traza de la referencia: 14 B (con ppu) o 10 B (sin ppu)."""
    return _load(path, 14, 10, 6, 5, 10)


def resync(O, R, i, j, maxskip):
    """Salto mínimo (k>0 en O o l>0 en R) que reempareja (PC, opcode), o None."""
    best = None
    for k in range(maxskip + 1):
        if i + k >= len(O):
            break
        ko = (O[i + k][0], O[i + k][1])
        if best is not None and k > best[0]:
            break
        for l in range(maxskip + 1):
            if j + l >= len(R) or k + l > (best[0] if best else maxskip):
                break
            if l == 0 and k == 0:
                continue
            if ko == (R[j + l][0], R[j + l][1]):
                tot = k + l
                if best is None or tot < best[0] or (tot == best[0] and k < best[1]):
                    best = (tot, k, l)
                break
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
                o, r = O[i + t] if i + t < len(O) else None, R[j + t] if j + t < len(R) else None
                dppu = (r[5] - o[5]) if (o and r and (o[5] or r[5])) else 0
                print('  O %6d %s   |   R %6d %s  dPPU=%+d'
                      % (i + t, fmt(O, i + t), j + t, fmt(R, j + t), dppu))
            return
        k, l = rs
        if nres < 12:
            print('resync #%d: salto O+%d R+%d en idx O=%d R=%d  (%s | %s)'
                  % (nres, k, l, i, j, fmt(O, i), fmt(R, j)))
        nres += 1
        i += k
        j += l
    print('\nfin: %d re-syncs benignos (O=%d R=%d sin divergencia de camino)' % (nres, i, j))


if __name__ == '__main__':
    main()
