#!/usr/bin/env bash
# uxrom_test.sh — verifica que el transpilado de una ROM **UxROM (mapper 2)** con
# bloques por banco (F9/B1b/B2) da el **mismo framebuffer** que el intérprete dentro
# de `NesSystem` (equivalencia de frame).
#
# Uso:  bash tests/uxrom_test.sh [rom.nes]
#   Por defecto usa `$RUNTIME/build/castlevania.nes` (ROM no versionada).
#   Si la ROM no existe, el test se **salta** (exit 0) — CI sin ROMs.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"                       # .../tools/transpiler
RUNTIME="$ROOT/../../runtime"
ROM="${1:-$RUNTIME/build/castlevania.nes}"

if [ ! -f "$ROM" ]; then
	echo "SKIP: no hay ROM UxROM en '$ROM' (paso la ruta como argumento)"
	exit 0
fi

OUT="$(ROM="$ROM" bash "$HERE/gen_frame.sh" 2>&1)"
echo "$OUT" | tail -6

# La verificación fuerte: framebuffer idéntico (0 píxeles distintos) al intérprete.
if echo "$OUT" | grep -q "pixeles disp: 0 /"; then
	echo "UXROM OK: framebuffer idéntico al intérprete"
	exit 0
fi
echo "UXROM FALLA: el framebuffer difiere del intérprete" >&2
exit 1
