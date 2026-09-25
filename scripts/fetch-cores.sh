#!/usr/bin/env bash
# Clona los cores libretro que no venían en external/ y que usamos para las nuevas
# plataformas: Atari 2600 (stella), Game Boy/Color (gambatte) y MS/SMS/GG (smsplus-gx).
# El binario se compila después con scripts/build-libretro-core.sh (WSL/Linux).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$ROOT/external"

clone() {
	local name="$1" url="$2"
	if [[ -d "$DEST/$name/.git" ]]; then
		echo "ya existe: $name"
	else
		echo "clonando $name <- $url"
		git clone --depth 1 "$url" "$DEST/$name"
	fi
}

clone libretro-stella   https://github.com/libretro/stella.git
clone libretro-gambatte https://github.com/libretro/gambatte-libretro.git
clone libretro-smsplus  https://github.com/libretro/smsplus-gx.git

echo "cores nuevos listos en $DEST"
