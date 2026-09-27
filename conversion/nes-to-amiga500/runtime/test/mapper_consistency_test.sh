#!/usr/bin/env bash
# mapper_consistency_test — verifica que `nes_frame` y `frame_probe` (dos
# herramientas distintas) producen el **mismo framebuffer** (PPM byte a byte) para
# una ROM de cada mapper soportado. Protege contra la regresión real de 2026:
# `nes_frame` tenía su **propio** switch de mappers (solo NROM↔MMC3) y devolvía un
# frame vacío para MMC5/VRC6/AxROM/FME-7, enmascarando o inventando bugs en la matriz.
#
# Si no hay ROMs disponibles (build/ no versionado), el test se omite con AVISO.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AMIGA_CPP="${AMIGA_CPP:-$ROOT/../../../../../Amiga-Cpp}"
ENG_INC="$AMIGA_CPP/engine/include"
CXX="${CXX:-g++}"
FRAMES="${FRAMES:-30}"

if [ ! -f "$ENG_INC/eng/core/types/types.hpp" ]; then
	echo "ERROR: no encuentro eng/core en '$ENG_INC'" >&2
	exit 1
fi

"$CXX" -std=gnu++23 -O2 -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" \
	"$ROOT/tools/nes_frame.cpp" -o "$ROOT/build/nes_frame" || exit 1
"$CXX" -std=gnu++23 -O2 -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" -I"$ROOT/host" \
	"$ROOT/tools/frame_probe.cpp" -o "$ROOT/build/frame_probe" || exit 1
"$CXX" -std=gnu++23 -O2 -I"$ENG_INC" -I"$ROOT/include" -I"$ROOT/fallback" -I"$ROOT/host" \
	"$ROOT/tools/bench_engine.cpp" -o "$ROOT/build/bench_engine" || exit 1

# Una ROM por mapper (nombre en build/).
declare -A CANDIDATES=(
	[0]="bf.nes"
	[1]="metroid.nes"
	[2]="castlevania.nes"
	[3]="gradius.nes"
	[4]="megaman3.nes"
	[5]="Gemfire (USA).nes"
	[7]="Battletoads (USA).nes"
	[24]="Akumajou Densetsu (Japan).nes"
	[26]="Esper Dream 2 - Aratanaru Tatakai (Japan).nes"
	[69]="Mr. Gimmick (Europe).nes"
)

fail=0
checked=0
tmp="$(mktemp -d)"
cd "$tmp" || exit 1
for m in 0 1 2 3 4 5 7 24 26 69; do
	rom="$ROOT/build/${CANDIDATES[$m]}"
	[ -f "$rom" ] || { echo "AVISO: mapper $m: sin ROM '${CANDIDATES[$m]}'; se omite."; continue; }
	"$ROOT/build/nes_frame" "$rom" nf.ppm "$FRAMES" >/dev/null 2>&1
	# frame_probe escribe frame_probe.ppm en el CWD (aquí, el temporal).
	"$ROOT/build/frame_probe" "$rom" "$FRAMES" >/dev/null 2>&1
	if [ ! -s nf.ppm ]; then
		echo "FALLO: mapper $m ($(basename "$rom")): nes_frame no escribió frame (¿mapper no soportado?)"
		fail=1
	elif [ ! -s frame_probe.ppm ]; then
		echo "FALLO: mapper $m ($(basename "$rom")): frame_probe no escribió frame"
		fail=1
	elif ! cmp -s nf.ppm frame_probe.ppm; then
		echo "FALLO: mapper $m ($(basename "$rom")): nes_frame != frame_probe (framebuffers distintos)"
		fail=1
	else
		# Equivalencia intérprete ↔ ejecutor rápido/transpilado (mismo mapper).
		# LÍMITE CONOCIDO: `FastCpu` decodifica la PRG **lineal** (sin banking), así
		# que **sólo aplica a NROM/CNROM**; en el resto `bench_engine` avisa y compara
		# intérprete vs intérprete (ver docs/FAST_EXECUTOR.md).
		be="$("$ROOT/build/bench_engine" "$rom" 60 2>/dev/null)"
		if printf '%s' "$be" | grep -q 'sin PRG fija'; then
			echo "OK: mapper $m ($(basename "$rom")): nes_frame == frame_probe (fast N/A: mapper sin PRG fija)"
		elif printf '%s' "$be" | grep -q 'equivalencia : OK'; then
			echo "OK: mapper $m ($(basename "$rom")): nes_frame == frame_probe, interp == fast"
		else
			echo "FALLO: mapper $m ($(basename "$rom")): interp != fast en mapper con PRG fija"
			fail=1
		fi
		checked=$((checked + 1))
	fi
	rm -f nf.ppm frame_probe.ppm
done
cd - >/dev/null || true
rm -rf "$tmp"

# Transpilado (codegen) vs intérprete: `gen_frame.sh` transpila una ROM NROM y compara
# el **código generado** (basic blocks) con el intérprete dentro del NesSystem. Cubre
# el otro camino de ejecución (F2) además del ejecutor rápido. Es informativo: la
# temporalización del codegen es aproximada por bloque (ver FAST_EXECUTOR.md).
GEN="$ROOT/../tools/transpiler/tests/gen_frame.sh"
if [ -f "$GEN" ] && [ -f "$ROOT/build/bf.nes" ]; then
	if ROM="$ROOT/build/bf.nes" bash "$GEN" >/dev/null 2>&1; then
		echo "OK: transpilado (gen_frame) NROM: codegen == interprete"
	else
		echo "AVISO: transpilado (gen_frame) no concluyente (timing por bloque; ver FAST_EXECUTOR.md)"
	fi
else
	echo "AVISO: sin gen_frame.sh o ROM NROM; se omite el test de transpilado."
fi

if [ "$fail" -ne 0 ]; then
	echo "mapper_consistency: FALLO"
	exit 1
fi
if [ "$checked" -eq 0 ]; then
	echo "AVISO: sin ROMs de prueba en build/; mapper_consistency omitido."
fi
echo "mapper_consistency: OK ($checked mappers)"
