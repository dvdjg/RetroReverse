#!/usr/bin/env python3
# bench.py — banco comparativo de compresión para el formato RetroReverse.
# Prueba, sobre el corpus segmentado por tipo, el producto cartesiano
# filtro reversible (para 68000/6502/datos) x algoritmo de compresión, y emite
# un CSV crudo + un resumen agregado por tipo de segmento.
#
# No se versiona (external/ gitignored). Ejecutar en WSL Ubuntu.
import os, sys, subprocess, tempfile, csv, statistics, concurrent.futures as cf

ROOT = os.path.dirname(os.path.abspath(__file__))
P = lambda *a: os.path.join(ROOT, *a)
TMPBASE = '/tmp/rrp_bench'          # FS nativo de Linux (rápido); /mnt/c es lentísimo
TIMEOUT = 120                       # s por compresión; evita cuelgues (p.ej. Shrinkler)

# ------------------------------------------------------------------ filtros
def f_none(b): return b

def f_d8(b):
    out = bytearray(len(b)); prev = 0
    for i, v in enumerate(b):
        out[i] = (v - prev) & 0xFF; prev = v
    return bytes(out)

def f_d16(b):
    # delta por palabra big-endian (Amiga 68000): out_w[i] = w[i]-w[i-1]
    out = bytearray(b); n = len(b) & ~1; prev = 0
    for i in range(0, n, 2):
        w = (b[i] << 8) | b[i+1]; d = (w - prev) & 0xFFFF
        out[i] = d >> 8; out[i+1] = d & 0xFF; prev = w
    if len(b) & 1: out[-1] = b[-1]
    return bytes(out)

def f_x8(b):
    out = bytearray(len(b)); prev = 0
    for i, v in enumerate(b):
        out[i] = v ^ prev; prev = v
    return bytes(out)

def f_eo(b):
    # separación even/odd (parity): bytes pares y luego impares
    return b[0::2] + b[1::2]

def f_d16_eo(b): return f_eo(f_d16(b))
def f_d8_eo(b):  return f_eo(f_d8(b))

def f_t16(b):
    # transpose por tile de 16 B (CHR NES: 8 B plano0 + 8 B plano1 por tile)
    out = bytearray()
    for j in range(16):
        out += b[j::16]
    return bytes(out)

def f_t16d(b):
    # delta contra el tile anterior (16 B)
    out = bytearray(b)
    for i in range(16, len(b)):
        out[i] = (b[i] - b[i-16]) & 0xFF
    return bytes(out)

FILTERS = {
    'none':    f_none,
    'd8':      f_d8,
    'd16':     f_d16,
    'x8':      f_x8,
    'eo':      f_eo,
    'd16eo':   f_d16_eo,
    'd8eo':    f_d8_eo,
    't16':     f_t16,
    't16d':    f_t16d,
}
# Conjunto reducido para la matriz final (el resto de filtros se probó y no mejora).
FILTERS_FAST = {k: FILTERS[k] for k in ('none', 'd8', 'd16', 'x8', 'eo', 'd16eo', 'd8eo')}
ACTIVE_FILTERS = FILTERS_FAST

# ------------------------------------------------------------------ códecs
def _run(cmd, o, stdout0=False):
    if stdout0:
        with open(o, 'wb') as f:
            subprocess.run(cmd, stdout=f, stderr=subprocess.DEVNULL, timeout=TIMEOUT)
    else:
        subprocess.run(cmd, capture_output=True, timeout=TIMEOUT)

def c_zx0(i, o):      _run([P('ZX0/src/zx0'), i, o], o)
def c_aplib(i, o):    _run([P('apultra/apultra'), '-c', i, o], o)
def c_lzsa1(i, o):    _run([P('lzsa/lzsa'), '-c', '-f', '1', i, o], o)
def c_lzsa2(i, o):    _run([P('lzsa/lzsa'), '-c', '-f', '2', i, o], o)
def c_lz4(i, o):      _run([P('lz4/programs/lz4'), '-12', '-f', i, o], o)
def c_rnc1(i, o):     _run([P('rnc_propack/rnc64'), 'p', i, o, '-m=1'], o)
def c_rnc2(i, o):     _run([P('rnc_propack/rnc64'), 'p', i, o, '-m=2'], o)
def c_pp(i, o):       _run([P('powerpacker/powerpack'), i, o, '-c', '-e=5'], o)
def c_deflate(i, o):  _run([P('zopfli/zopfli'), '--deflate', '-c', i], o, stdout0=True)
def c_shrink(i, o):   _run([P('Shrinkler/build/native/Shrinkler'), '-d', '-9', '--no-progress', i, o], o)

# Finalistas + clásicos de referencia (la matriz completa ya se obtuvo aparte).
CODECS = {
    'zx0': c_zx0, 'aplib': c_aplib, 'lzsa2': c_lzsa2, 'deflate': c_deflate,
    'lz4': c_lz4, 'shrinkler': c_shrink, 'rnc1': c_rnc1, 'pp': c_pp,
}

# ------------------------------------------------------------------ corpus
SELECT = {
    'm68k_text': ['dk','smb','galaga','pacman','popeye','bf','kungfu','exb'],
    'm68k_data': ['dk','smb','galaga','pacman','popeye','bf','kungfu','exb'],
    'nes_prg':   ['dk','smb','galaga','pacman','popeye','mariobros','gradius','megaman3','contra'],
    'nes_chr':   ['dk','smb','galaga','pacman','popeye','mariobros','gradius','megaman3'],
}

def task(args):
    stype, name, filt, codec = args
    src = (P('corpus', stype, name + '.x64nt.n2x') if stype == 'dll'
           else P('corpus', stype, name + '.bin'))
    try:
        data = open(src, 'rb').read()
    except FileNotFoundError:
        return None
    fb = FILTERS[filt](data)
    with tempfile.TemporaryDirectory(dir=TMPBASE) as td:
        fi = os.path.join(td, 'in.bin'); fo = os.path.join(td, 'out.bin')
        open(fi, 'wb').write(fb)
        try:
            CODECS[codec](fi, fo)
            comp = os.path.getsize(fo)
        except Exception:
            comp = -1
    return (stype, name, filt, codec, len(data), comp)

def main():
    os.makedirs(TMPBASE, exist_ok=True)
    jobs = []
    for stype, names in SELECT.items():
        for n in names:
            for filt in ACTIVE_FILTERS:
                for codec in CODECS:
                    jobs.append((stype, n, filt, codec))
    print(f"[bench] {len(jobs)} compresiones ({len(ACTIVE_FILTERS)} filtros x {len(CODECS)} codecs)", flush=True)
    rows = []
    done = 0
    with open(P('bench_results.csv'), 'w', newline='') as f:
        w = csv.writer(f)
        w.writerow(['type', 'file', 'filter', 'codec', 'orig', 'comp', 'ratio', 'bpb'])
        with cf.ProcessPoolExecutor(max_workers=min(10, os.cpu_count() or 4)) as ex:
            for r in ex.map(task, jobs, chunksize=4):
                done += 1
                if r:
                    rows.append(r)
                    st, n, fi, co, orig, comp = r
                    ratio = comp / orig if (comp > 0 and orig) else 99
                    bpb = comp * 8 / orig if orig else 99
                    w.writerow([st, n, fi, co, orig, comp, f"{ratio:.4f}", f"{bpb:.4f}"])
                if done % 200 == 0:
                    f.flush(); print(f"  {done}/{len(jobs)}", flush=True)
    print("[bench] bench_results.csv escrito")
    summary(rows)

def summary(rows):
    # media de ratio por (tipo, filtro, codec)
    from collections import defaultdict
    agg = defaultdict(list)
    for st, n, fi, co, orig, comp in rows:
        if comp > 0 and orig:
            agg[(st, fi, co)].append(comp / orig)
    lines = ["# Banco comparativo — ratio medio (comprimido/original, menor = mejor)", ""]
    for stype in SELECT:
        lines.append(f"## {stype}")
        lines.append("")
        codecs = list(CODECS)
        lines.append("| filtro | " + " | ".join(codecs) + " | mejor |")
        lines.append("|" + "---|" * (len(codecs) + 2))
        for fi in ACTIVE_FILTERS:
            vals = {co: statistics.mean(agg[(stype, fi, co)]) for co in codecs if (stype, fi, co) in agg}
            if not vals: continue
            best = min(vals, key=vals.get)
            cells = " | ".join(f"{vals[co]*100:.1f}" if co in vals else "-" for co in codecs)
            lines.append(f"| {fi} | {cells} | **{best} {vals[best]*100:.1f}** |")
        # mejor global por códec (mejor filtro)
        lines.append("")
        lines.append("Mejor por códec (con su filtro):")
        for co in codecs:
            best = min(((fi, statistics.mean(agg[(stype, fi, co)])) for fi in ACTIVE_FILTERS
                        if (stype, fi, co) in agg), key=lambda x: x[1], default=(None, None))
            if best[0]: lines.append(f"- **{co}**: {best[1]*100:.1f}% con `{best[0]}`")
        lines.append("")
    open(P('bench_summary.md'), 'w').write("\n".join(lines))
    print("[bench] bench_summary.md escrito")

if __name__ == '__main__':
    main()
