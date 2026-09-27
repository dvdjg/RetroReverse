#!/usr/bin/env bash
# band_diff.sh — localiza DÓNDE difiere nuestro frame del de mesen: imprime el %
# de diferencia **estructural** (luminancia) por banda horizontal (8 filas) y
# vertical (8 columnas). Ayuda a distinguir sprites / banda de scroll / atributos.
#
# Uso: ROM=build/xevious.nes FRAMES=1 bash test/band_diff.sh
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ROM="${ROM:-}"
FRAMES="${FRAMES:-1}"

ROM="$ROM" FRAMES="$FRAMES" bash "$ROOT/test/diff_mesen.sh" >/dev/null 2>&1 || true
REF="$(find "$ROOT/build/mesen/screenshots" -name '*.ppm' 2>/dev/null | sort | tail -1 || true)"
[ -n "$REF" ] || { echo "band_diff: sin frame de referencia"; exit 0; }

python3 - "$ROOT/build/ours.ppm" "$REF" <<'PY'
import sys
def rp(p):
    f=open(p,'rb');f.readline();w,h=map(int,f.readline().split());f.readline();return w,h,f.read()
wa,ha,a=rp(sys.argv[1]);wb,hb,b=rp(sys.argv[2])
if (wa,ha)!=(wb,hb):
    print('band_diff: dimensiones distintas'); sys.exit(0)
lr,lg,lb=0.299,0.587,0.114
def lum(d,i): return d[3*i]*lr+d[3*i+1]*lg+d[3*i+2]*lb
band_h=ha//8; band_w=wa//8
print('  filas (arriba->abajo):', end='')
for by in range(8):
    c=t=0
    for y in range(by*band_h,(by+1)*band_h):
        for x in range(wa):
            i=y*wa+x;t+=1
            if abs(lum(a,i)-lum(b,i))>48:c+=1
    print(' %2.0f%%'%(100*c/t),end='')
print()
print('  cols  (izq->dcha)  :', end='')
for bx in range(8):
    c=t=0
    for x in range(bx*band_w,(bx+1)*band_w):
        for y in range(ha):
            i=y*wa+x;t+=1
            if abs(lum(a,i)-lum(b,i))>48:c+=1
    print(' %2.0f%%'%(100*c/t),end='')
print()
PY
