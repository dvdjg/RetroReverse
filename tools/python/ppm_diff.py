#!/usr/bin/env python3
"""Diff de framebuffers PPM (P6) para validación diferencial emulador vs reimpl.

Uso: python tools/python/ppm_diff.py <a.ppm> <b.ppm> [--out diff.ppm] [--tol 0]

Salida: resumen por stdout; código 0 si son iguales (dentro de tolerancia),
1 si difieren, 2 si error de formato.
"""
import sys


def read_ppm(path):
    with open(path, 'rb') as f:
        data = f.read()
    # Cabecera P6: P6 <w> <h> <max>, con comentarios/espacios.
    fields = []
    i = 0
    while len(fields) < 4:
        while i < len(data) and data[i:i + 1].isspace():
            i += 1
        if data[i:i + 1] == b'#':
            while i < len(data) and data[i] != 0x0A:
                i += 1
            continue
        j = i
        while j < len(data) and not data[j:j + 1].isspace():
            j += 1
        fields.append(data[i:j])
        i = j
    if fields[0] != b'P6':
        raise ValueError('no es P6')
    w, h = int(fields[1]), int(fields[2])
    i += 1  # un separador tras maxval
    pix = data[i:i + w * h * 3]
    if len(pix) != w * h * 3:
        raise ValueError('datos de píxeles incompletos')
    return w, h, pix


def main():
    args = sys.argv[1:]
    if len(args) < 2:
        print(__doc__)
        return 2
    a, b = args[0], args[1]
    out = None
    tol = 0
    if '--out' in args:
        out = args[args.index('--out') + 1]
    if '--tol' in args:
        tol = int(args[args.index('--tol') + 1])

    wa, ha, pa = read_ppm(a)
    wb, hb, pb = read_ppm(b)
    if (wa, ha) != (wb, hb):
        print(f'DIM mismatch: {wa}x{ha} vs {wb}x{hb}')
        return 1

    diff_count = 0
    max_delta = 0
    total_delta = 0
    minx, miny, maxx, maxy = wa, ha, -1, -1
    dpix = bytearray(len(pa)) if out else None
    for y in range(ha):
        for x in range(wa):
            o = (y * wa + x) * 3
            d = max(abs(pa[o] - pb[o]), abs(pa[o + 1] - pb[o + 1]), abs(pa[o + 2] - pb[o + 2]))
            if d > tol:
                diff_count += 1
                total_delta += d
                max_delta = max(max_delta, d)
                minx, miny = min(minx, x), min(miny, y)
                maxx, maxy = max(maxx, x), max(maxy, y)
            if dpix is not None:
                dpix[o:o + 3] = bytes((255, 0, 0)) if d > tol else bytes((pa[o] // 2, pa[o + 1] // 2, pa[o + 2] // 2))

    total = wa * ha
    print(f'tamaño: {wa}x{ha} ({total} px)')
    print(f'diferentes: {diff_count} ({100.0 * diff_count / total:.4f}%), maxΔ={max_delta}, mediaΔ={total_delta / max(diff_count, 1):.2f}')
    if diff_count:
        print(f'bbox diferencias: ({minx},{miny})-({maxx},{maxy})')
    if out and dpix is not None:
        with open(out, 'wb') as f:
            f.write(f'P6\n{wa} {ha}\n255\n'.encode())
            f.write(dpix)
        print(f'diff -> {out}')
    return 0 if diff_count == 0 else 1


if __name__ == '__main__':
    raise SystemExit(main())
