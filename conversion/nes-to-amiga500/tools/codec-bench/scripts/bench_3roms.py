#!/usr/bin/env python3
# bench3.py — bateria focalizada: 3 ROMs x TODOS los codecs x TODOS los filtros,
# para los tipos PRG/CHR (ROM NES) y codigo/datos 68000 (transpilado).
# Emite results3.csv y results3.md (tablas listas para pegar).
import os, subprocess, tempfile, csv, statistics, concurrent.futures as cf

ROOT = os.path.dirname(os.path.abspath(__file__))
P = lambda *a: os.path.join(ROOT, *a)
TMPBASE = '/tmp/rrp_bench3'
TIMEOUT = 600

# ---- filtros ----
def f_none(b): return b
def f_d8(b):
    o = bytearray(len(b)); p = 0
    for i, v in enumerate(b): o[i] = (v - p) & 255; p = v
    return bytes(o)
def f_d16(b):
    o = bytearray(b); n = len(b) & ~1; p = 0
    for i in range(0, n, 2):
        w = (b[i] << 8) | b[i+1]; d = (w - p) & 0xFFFF; o[i] = d >> 8; o[i+1] = d & 255; p = w
    return bytes(o)
def f_x8(b):
    o = bytearray(len(b)); p = 0
    for i, v in enumerate(b): o[i] = v ^ p; p = v
    return bytes(o)
def f_eo(b):  return b[0::2] + b[1::2]
def f_d16eo(b): return f_eo(f_d16(b))
def f_d8eo(b):  return f_eo(f_d8(b))
def f_t16(b):
    o = bytearray()
    for j in range(16): o += b[j::16]
    return bytes(o)
def f_t16d(b):
    o = bytearray(b)
    for i in range(16, len(b)): o[i] = (b[i] - b[i-16]) & 255
    return bytes(o)

FILTERS = {'none': f_none, 'd8': f_d8, 'd16': f_d16, 'x8': f_x8, 'eo': f_eo,
           'd16eo': f_d16eo, 'd8eo': f_d8eo, 't16': f_t16, 't16d': f_t16d}

# ---- codecs ----
def _run(cmd, o, to_stdout=False):
    if to_stdout:
        with open(o, 'wb') as f: subprocess.run(cmd, stdout=f, stderr=subprocess.DEVNULL, timeout=TIMEOUT)
    else:
        subprocess.run(cmd, capture_output=True, timeout=TIMEOUT)
CODECS = {
    'zx0':       lambda i, o: _run([P('ZX0/src/zx0'), i, o], o),
    'aplib':     lambda i, o: _run([P('apultra/apultra'), '-c', i, o], o),
    'lzsa1':     lambda i, o: _run([P('lzsa/lzsa'), '-c', '-f', '1', i, o], o),
    'lzsa2':     lambda i, o: _run([P('lzsa/lzsa'), '-c', '-f', '2', i, o], o),
    'deflate':   lambda i, o: _run([P('zopfli/zopfli'), '--i5', '--deflate', '-c', i], o, True),
    'lz4':       lambda i, o: _run([P('lz4/programs/lz4'), '-12', '-f', i, o], o),
    'shrinkler': lambda i, o: _run([P('Shrinkler/build/native/Shrinkler'), '-d', '-3', '--no-progress', i, o], o),
    'rnc1':      lambda i, o: _run([P('rnc_propack/rnc64'), 'p', i, o, '-m=1'], o),
    'rnc2':      lambda i, o: _run([P('rnc_propack/rnc64'), 'p', i, o, '-m=2'], o),
    'pp':        lambda i, o: _run([P('powerpacker/powerpack'), i, o, '-c', '-e=5'], o),
}

ROMS = ['dk', 'smb', 'galaga']
SELECT = {'nes_prg': ROMS, 'nes_chr': ROMS, 'm68k_text': ROMS, 'm68k_data': ROMS}
TYPE_LABEL = {'nes_prg': 'ROM NES - PRG (codigo 6502+datos)',
              'nes_chr': 'ROM NES - CHR (tiles)',
              'm68k_text': '68000 - codigo (.text)',
              'm68k_data': '68000 - datos (.rodata)'}

def task(args):
    stype, name, filt, codec = args
    src = P('corpus', stype, name + '.bin')
    try: data = open(src, 'rb').read()
    except FileNotFoundError: return None
    fb = FILTERS[filt](data)
    with tempfile.TemporaryDirectory(dir=TMPBASE) as td:
        fi = os.path.join(td, 'in.bin'); fo = os.path.join(td, 'out.bin')
        open(fi, 'wb').write(fb)
        try:
            CODECS[codec](fi, fo); comp = os.path.getsize(fo)
        except Exception:
            comp = -1
    return (stype, name, filt, codec, len(data), comp)

def main():
    os.makedirs(TMPBASE, exist_ok=True)
    jobs = [(st, n, fi, co) for st, names in SELECT.items() for n in names
            for fi in FILTERS for co in CODECS]
    print(f"[bench3] {len(jobs)} compresiones", flush=True)
    rows, done = [], 0
    with cf.ProcessPoolExecutor(max_workers=min(12, os.cpu_count() or 4)) as ex:
        for r in ex.map(task, jobs, chunksize=2):
            done += 1
            if r: rows.append(r)
            if done % 100 == 0: print(f"  {done}/{len(jobs)}", flush=True)
    with open(P('results3.csv'), 'w', newline='') as f:
        w = csv.writer(f)
        w.writerow(['type', 'file', 'filter', 'codec', 'orig', 'comp', 'ratio'])
        for st, n, fi, co, orig, comp in rows:
            w.writerow([st, n, fi, co, orig, comp,
                        f"{comp/orig:.4f}" if comp > 0 and orig else 'NA'])

    agg = {}
    for st, n, fi, co, orig, comp in rows:
        if comp > 0 and orig: agg.setdefault((st, fi, co), []).append(comp / orig)

    lines = ["# Batería focalizada — 3 ROMs (dk, smb, galaga)", "",
             "Ratio = comprimido/original (menor = mejor), media de las 3 ROMs.",
             f"Codecs: {', '.join(CODECS)}. Filtros: {', '.join(FILTERS)}.", ""]
    codecs = list(CODECS)
    for st in SELECT:
        lines += [f"## {TYPE_LABEL[st]}", "",
                  "| filtro | " + " | ".join(codecs) + " | mejor |",
                  "|" + "---|" * (len(codecs) + 2)]
        for fi in FILTERS:
            vals = {co: statistics.mean(agg[(st, fi, co)]) for co in codecs if (st, fi, co) in agg}
            if not vals: continue
            best = min(vals, key=vals.get)
            cells = " | ".join(f"{vals[co]*100:.1f}" if co in vals else "-" for co in codecs)
            lines.append(f"| {fi} | {cells} | **{best} {vals[best]*100:.1f}%** |")
        lines.append("")
        lines.append("Mejor por códec (y su filtro): " + " · ".join(
            f"{co} {min(((fi, statistics.mean(agg[(st,fi,co)])) for fi in FILTERS if (st,fi,co) in agg), key=lambda x: x[1])[1]*100:.1f}%@{min(((fi, statistics.mean(agg[(st,fi,co)])) for fi in FILTERS if (st,fi,co) in agg), key=lambda x: x[1])[0]}"
            for co in codecs if any((st,fi,co) in agg for fi in FILTERS)))
        lines.append("")
    open(P('results3.md'), 'w').write("\n".join(lines))
    print("[bench3] results3.csv y results3.md escritos")

if __name__ == '__main__':
    main()
