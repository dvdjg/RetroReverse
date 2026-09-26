#!/usr/bin/env bash
# Smoke test de cores reales: ejecuta un frame-set corto con una ROM de cada plataforma
# seleccionada (ver docs/ROM_SELECTION.md) y comprueba que corre y es determinista.
# Salidas en /tmp/rr-smoke/<plataforma> (no toca extraction/ de los nodos).
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN="$ROOT/tools/orchestrator/vertical_slice"
OUT="${OUT:-/tmp/rr-smoke}"
rm -rf "$OUT"

[[ -x "$BIN" ]] || make -C "$ROOT/tools/orchestrator" vertical_slice

run() {
	local name="$1" core="$2" rom="$3"
	printf '\n===== %s =====\n' "$name"
	"$BIN" --core "$ROOT/external/$core" --rom "$ROOT/roms/$rom" \
		--out "$OUT/$name" --frames 60 --interval 30 --det 10 || echo "FALLO: $name"
}

run mame          libretro-mame2003-plus/mame2003_plus_libretro.so "arcade/pacman.zip"
run nes           libretro-mesen/mesen_libretro.so                 "nes/Super Mario Bros. (World).nes"
run megadrive     libretro-genesis-plus-gx/genesis_plus_gx_libretro.so "megadrive/Golden Axe (World).md"
run mastersystem  libretro-smsplus/smsplus_libretro.so             "mastersystem/Wonder Boy (USA, Europe).sms"
run gamegear      libretro-smsplus/smsplus_libretro.so             "gamegear/Columns (USA, Europe).gg"
run atari2600     libretro-stella/stella2023_libretro.so           "atari2600/Adventure (1978) (Atari).a26"
run gb            libretro-gambatte/gambatte_libretro.so           "gb/Tetris (World) (Rev A).gb"
run gbc           libretro-gambatte/gambatte_libretro.so           "gbc/Tetris DX (World) (SGB Enhanced) (GB Compatible).gbc"
# Arcade moderno (post-1990) que mame2003-plus no soporta -> FBNeo
run fbneo-1944    libretro-fbneo/fbneo_libretro.so                 "fbneo/1944.zip"
run fbneo-sfiii   libretro-fbneo/fbneo_libretro.so                 "fbneo/sfiii.zip"

echo
echo "salida en $OUT"
