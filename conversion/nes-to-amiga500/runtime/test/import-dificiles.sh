#!/usr/bin/env bash
# import-dificiles — extrae TODAS las ROMs de `roms/nes/dificiles/*.zip` a
# `runtime/build/` (nombre = el del fichero .nes dentro del zip), para ampliar la
# matriz de compatibilidad. El contenido de las ROMs NO se versiona (`build/` está
# en .gitignore).
#
# Uso: bash runtime/test/import-dificiles.sh
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"     # .../nes-to-amiga500/runtime
REPO="$ROOT/../../.."                        # raíz del repo
SRC="$REPO/roms/nes/dificiles"
DST="$ROOT/build"
mkdir -p "$DST"
command -v python3 >/dev/null 2>&1 || { echo "import-dificiles: sin python3"; exit 0; }

for z in "$SRC"/*.zip; do
	[ -f "$z" ] || continue
	python3 - "$z" "$DST" <<'PY'
import sys, os, zipfile
try:
	zf = zipfile.ZipFile(sys.argv[1])
except Exception:
	sys.exit(0)
for n in zf.namelist():
	if n.lower().endswith('.nes'):
		out = os.path.join(sys.argv[2], os.path.basename(n))
		if not os.path.exists(out):
			open(out, 'wb').write(zf.read(n))
			print('importado:', os.path.basename(n))
		break
PY
done
