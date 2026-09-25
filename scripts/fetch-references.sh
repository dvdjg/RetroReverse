#!/usr/bin/env bash
# Descarga documentación y desensamblados de referencia a external/references/ (NO versionado).
# Fuentes citadas en docs/REFERENCES.md. Solo material de estudio; no se redistribuye.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REF="$ROOT/external/references"
mkdir -p "$REF/repos" "$REF/docs"

clone() {
	local name="$1" url="$2"
	if [[ -d "$REF/repos/$name/.git" ]]; then
		echo "ya existe: $name"
	else
		echo "clonando $name <- $url"
		git clone --depth 1 "$url" "$REF/repos/$name"
	fi
}

# --- Pac-Man / Ms. Pac-Man ---
clone GameDocs            https://github.com/BleuLlama/GameDocs.git
clone pac-superzazu       https://github.com/superzazu/pac.git
clone pacman-emulator     https://github.com/frisnit/pacman-emulator.git

# --- NES ---
clone SuperMarioBros-C    https://github.com/MitchellSternke/SuperMarioBros-C.git
clone smb-nathsou         https://github.com/nathsou/smb.git
clone zelda1-disassembly  https://github.com/aldonunez/zelda1-disassembly.git

# --- NES: documentación de hardware y emuladores de referencia (emulador óptimo) ---
clone nes-test-roms       https://github.com/christopherpow/nes-test-roms.git
clone mesen2              https://github.com/SourMesen/Mesen2.git
clone olcNES              https://github.com/onelonecoder/olcNES.git
clone fceux               https://github.com/TASEmulators/fceux.git
clone nesium              https://github.com/mikai233/nesium.git

# --- Mega Drive / Genesis ---
clone s1disasm            https://github.com/sonicretro/s1disasm.git

# --- Amiga ---
clone populous            https://github.com/tetracorp/populous.git
clone driller             https://github.com/hitchhikr/driller.git

# --- PDFs de referencia ---
download() {
	local out="$1" url="$2"
	if [[ -s "$REF/docs/$out" ]]; then echo "ya existe: $out"; return; fi
	echo "descargando $out"
	curl -fsSL -o "$REF/docs/$out" "$url" || echo "  (falló: $url)"
}

download "pac-man-dossier.pdf" "https://cs.au.dk/~ocaprani/GameAI/PacMan/The%20Pac-Man%20Dossier.pdf"
download "pacman-emulation-lomont.pdf" "https://www.lomont.org/software/games/pacman/PacmanEmulation.pdf"

# --- NES: documentación (snapshots HTML/markdown) ---
download "nesdev-wiki.html" "https://www.nesdev.org/wiki/"
download "nes-emulator-dev-guide.md" "https://gist.githubusercontent.com/rhysd/ec4eec8b70dabc196a21a37c0ba4688e/raw"
download "6502-instruction-set.html" "https://www.masswerk.at/6502/6502_instruction_set.html"

echo "referencias en $REF"
