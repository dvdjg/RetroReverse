#!/usr/bin/env bash
# build_web.sh — compila el runner SDL3 para **navegador** con Emscripten.
#
# Requiere `emcc` en el PATH (emsdk instalado y activado):
#   git clone https://github.com/emscripten-core/emsdk.git
#   cd emsdk && ./emsdk install latest && ./emsdk activate latest
#   source ./emsdk_env.sh
#
# SDL3 se aporta como *port* de Emscripten (`-sUSE_SDL=3`); no hace falta compilar
# SDL3 a mano para el navegador.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"              # .../runtime/web
HOST="$HERE/../host"
AMIGA_CPP="${AMIGA_CPP:-$HERE/../../../../../../Amiga-Cpp}"

if ! command -v emcc >/dev/null 2>&1; then
	echo "ERROR: 'emcc' no está en el PATH. Instala y activa emsdk (ver cabecera)." >&2
	exit 1
fi

mkdir -p "$HOST/build/web"
emcc -std=gnu++23 -O2 \
	-I"$AMIGA_CPP/engine/include" \
	-I"$HOST/../include" -I"$HOST/../fallback" -I"$HOST/../platform" \
	-sUSE_SDL=3 -sALLOW_MEMORY_GROWTH=1 -sASYNCIFY \
	--shell-file "$HERE/shell.html" \
	"$HOST/main.cpp" "$HOST/sdl_host.cpp" \
	-o "$HOST/build/web/nes_sdl.html"

echo "OK -> $HOST/build/web/nes_sdl.html (sírvelo con un servidor HTTP)"
