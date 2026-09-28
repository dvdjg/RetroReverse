#!/usr/bin/env bash
# banks_test.sh — verifica equivalencia de frame (codegen == intérprete) para ROMs
# con PRG bancada: **UxROM (2)** y **MMC1 (1)**. Es el equivalente de
# `uxrom_test.sh` para varios juegos.
#
# Uso:  bash tests/banks_test.sh
#   Requiere las ROMs en `runtime/build/<juego>.nes`; las ausentes se **saltan**.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
RUNTIME="$ROOT/../../runtime"

# UxROM (2), MMC1 (1), MMC3 (4) y FME-7 (69). Un nombre por línea (admite espacios).
ROMS="
castlevania
contra
metroid
megaman2
blastermaster
megaman3
smb3
megaman4
crystalis
tinytoonadventures
metalstorm
Mr. Gimmick (Europe)
Akumajou Densetsu (Japan)
Gemfire (USA)
"
ran=0
while IFS= read -r rom; do
	[ -n "$rom" ] || continue
	f="$RUNTIME/build/$rom.nes"
	if [ ! -f "$f" ]; then
		echo "SKIP $rom (sin ROM)"
		continue
	fi
	out="$(ROM="$f" bash "$HERE/gen_frame.sh" 2>&1)"
	ran=$((ran + 1))
	if echo "$out" | grep -q "pixeles disp: 0 /"; then
		echo "OK   $rom (framebuffer idéntico)"
	else
		echo "FALLA $rom"
		echo "$out" | grep -E 'RAM|pixeles' | sed 's/^/    /'
		exit 1
	fi
done <<EOF
$ROMS
EOF
if [ "$ran" = 0 ]; then
	echo "SKIP: no hay ROMs bancadas"; exit 0
fi
echo "BANKS OK ($ran ROMs)"
