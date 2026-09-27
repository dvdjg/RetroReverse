#!/usr/bin/env bash
# Validación diferencial: compara el frame de nuestro runtime con el de `mesen`
# (vía el orquestador libretro). Es informativa: si faltan recursos, se omite.
#
# Uso: bash test/diff_mesen.sh   (ROM=... para forzar una ROM; FRAMES=... )
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"           # .../nes-to-amiga500/runtime
REPO="$ROOT/../../.."                               # raíz del repo
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
CXX="${CXX:-g++}"
MESEN="$REPO/external/libretro-mesen/mesen_libretro.so"
ORCH="$REPO/tools/orchestrator/vertical_slice"
FRAMES="${FRAMES:-60}"
THRESHOLD="${THRESHOLD:-25.0}"
ROM="${ROM:-}"

if [ -z "$ROM" ]; then
	ROM="$(find "$REPO/roms/nes" -maxdepth 1 -name '*.nes' 2>/dev/null | sort | head -1 || true)"
fi
[ -f "$MESEN" ] || { echo "diff_mesen: sin '$MESEN'; se omite."; exit 0; }
[ -x "$ORCH" ] || { echo "diff_mesen: sin '$ORCH'; se omite."; exit 0; }
[ -n "$ROM" ] && [ -f "$ROM" ] || { echo "diff_mesen: sin ROM; se omite."; exit 0; }
command -v python3 >/dev/null 2>&1 || { echo "diff_mesen: sin python3; se omite."; exit 0; }

mkdir -p "$ROOT/build/mesen"
echo "diff_mesen: ROM=$(basename "$ROM") frames=$FRAMES"
"$CXX" -std=gnu++23 -O2 -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" \
	"$ROOT/tools/nes_frame.cpp" -o "$ROOT/build/nes_frame"
"$ROOT/build/nes_frame" "$ROM" "$ROOT/build/ours.ppm" "$FRAMES" >/dev/null
"$ORCH" --core "$MESEN" --rom "$ROM" --out "$ROOT/build/mesen" --frames "$FRAMES" --interval 0 \
	>/dev/null 2>&1 || { echo "diff_mesen: el orquestador falló; se omite."; exit 0; }
REF="$(find "$ROOT/build/mesen/screenshots" -name '*.ppm' 2>/dev/null | sort | tail -1 || true)"
[ -n "$REF" ] || { echo "diff_mesen: mesen no dejó frame; se omite."; exit 0; }

python3 - "$ROOT/build/ours.ppm" "$REF" "$THRESHOLD" <<'PY'
import sys
def readp6(p):
    f=open(p,'rb'); assert f.readline().strip()==b'P6'
    w,h=map(int,f.readline().split()); int(f.readline()); return w,h,f.read()
wa,ha,da=readp6(sys.argv[1]); wb,hb,db=readp6(sys.argv[2]); thr=float(sys.argv[3])
if (wa,ha)!=(wb,hb):
    print('diff_mesen: dimensiones distintas'); sys.exit(1)
n=wa*ha; diff=0; sdiff=0
lr,lg,lb=0.299,0.587,0.114
for i in range(n):
    r1,g1,b1=da[3*i],da[3*i+1],da[3*i+2]
    r2,g2,b2=db[3*i],db[3*i+1],db[3*i+2]
    if abs(r1-r2)+abs(g1-g2)+abs(b1-b2)>30: diff+=1
    # Métrica estructural: solo cuenta diferencias de LUMINANCIA > umbral (ignora
    # el tono de paleta, que es ruido entre emuladores). Refleja geometría/tiles.
    if abs((r1*lr+g1*lg+b1*lb)-(r2*lr+g2*lg+b2*lb))>48: sdiff+=1
pct=100.0*diff/n; spct=100.0*sdiff/n
print('diff_mesen: color=%.1f%%  estructura(lum)=%.1f%% (umbral %.1f%%)'%(pct,spct,thr))
sys.exit(0 if pct<thr else 1)
PY
