#!/usr/bin/env bash
# import-new-roms — extrae de `roms/nes/dificiles/*.zip` las ROMs de los mappers
# que el oráculo soporta ahora (VRC6, MMC5, AxROM, FME-7) a `runtime/build/`, con
# nombres canónicos, para que `port_matrix.sh` sea **reproducible** (build/ está en
# .gitignore; el contenido de las ROMs NO se versiona).
#
# Uso: bash runtime/test/import-new-roms.sh
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"     # .../nes-to-amiga500/runtime
REPO="$ROOT/../../.."                        # raíz del repo
SRC="$REPO/roms/nes/dificiles"
DST="$ROOT/build"
mkdir -p "$DST"

# zip (en SRC) -> nombre destino en build/
declare -A MAP=(
	["Akumajou Densetsu (Japan) (T).zip"]=akumajou.nes
	["Esper Dream 2 - Aratanaru Tatakai (Japan) (T).zip"]=esperdream2.nes
	["Castlevania III - Dracula's Curse (USA).zip"]=cv3.nes
	["Battletoads (USA).zip"]=battletoads.nes
	["Mr. Gimmick (Europe).zip"]=mrgimmick.nes
)

command -v python3 >/dev/null 2>&1 || { echo "import-new-roms: sin python3"; exit 0; }
for z in "${!MAP[@]}"; do
	out="$DST/${MAP[$z]}"
	if [ -f "$out" ]; then
		echo "ya existe: ${MAP[$z]}"
		continue
	fi
	[ -f "$SRC/$z" ] || { echo "falta $z (omitido)"; continue; }
	# Extrae el .nes del zip (primer fichero .nes) a `out`.
	python3 - "$SRC/$z" "$out" <<'PY'
import sys, zipfile
zf = zipfile.ZipFile(sys.argv[1])
for n in zf.namelist():
	if n.lower().endswith('.nes'):
		open(sys.argv[2], 'wb').write(zf.read(n))
		break
PY
	[ -f "$out" ] && echo "importado: ${MAP[$z]}"
done
