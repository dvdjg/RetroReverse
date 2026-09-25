#!/usr/bin/env bash
# Compila un core libretro de external/<name> (WSL/Linux) y copia el binario a external/<name>/.
#
# Uso:
#   scripts/build-libretro-core.sh <core-dir> [-- <args de make...>]
#
# Ejemplos:
#   scripts/build-libretro-core.sh libretro-mame2003-plus
#   scripts/build-libretro-core.sh libretro-mesen -- platform=unix
#
# Motivo: compilar sobre ext4 (~/rrbuild, nativo de WSL) es mucho más rápido que sobre
# /mnt/c (DrvFs). El árbol fuente se sincroniza (sin .git), se compila y el .so/.dylib
# resultante se copia de vuelta a external/<name>/ para que el orquestador lo cargue.
#
# Variables: RR_BUILD_ROOT (por defecto ~/rrbuild), RR_JOBS (por defecto nproc).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
name="${1:?uso: $0 <core-dir> [-- make args...]}"
shift || true
if [[ "${1:-}" == "--" ]]; then shift; fi

src="$REPO_DIR/external/$name"
[[ -d "$src" ]] || { echo "ERROR: no existe $src" >&2; exit 2; }

build_root="${RR_BUILD_ROOT:-$HOME/rrbuild}"
work="$build_root/$name"
mkdir -p "$build_root"

echo "==> sincronizando $src -> $work (sin .git)"
if command -v rsync >/dev/null 2>&1; then
	rsync -a --delete --exclude '.git' "$src/" "$work/"
else
	rm -rf "$work"; mkdir -p "$work"
	cp -a "$src/." "$work/"
	rm -rf "$work/.git"
fi

jobs="${RR_JOBS:-$(nproc)}"

# Localiza el Makefile del core. Se priorizan los Makefiles específicos de libretro
# (algunos repos traen, además, un Makefile "standalone" que no queremos).
if [[ -n "${MAKE_DIR:-}" ]]; then
	make_dir="$work/$MAKE_DIR"; make_file="${MAKE_FILE:-Makefile}"
elif [[ -f "$work/Makefile.libretro" ]]; then
	make_dir="$work"; make_file="Makefile.libretro"
elif [[ -f "$work/src/os/libretro/Makefile" ]]; then
	make_dir="$work/src/os/libretro"; make_file="Makefile"
elif [[ -f "$work/libretro/Makefile" ]]; then
	make_dir="$work/libretro"; make_file="Makefile"
elif [[ -f "$work/Libretro/Makefile" ]]; then
	make_dir="$work/Libretro"; make_file="Makefile"
elif [[ -f "$work/Makefile" ]]; then
	make_dir="$work"; make_file="Makefile"
else
	echo "ERROR: no encuentro Makefile en $work" >&2; exit 4
fi

# Algunos cores (p. ej. stella) usan autotools: requieren ./configure antes de make.
if [[ ! -f "$make_dir/config.mak" && -x "$make_dir/configure" && "$make_file" == "Makefile" ]]; then
	echo "==> ./configure en $make_dir"
	( cd "$make_dir" && ./configure )
fi

echo "==> make -C $make_dir -f $make_file -j$jobs $*"
make -C "$make_dir" -f "$make_file" -j"$jobs" "$@"

shopt -s nullglob
bins=("$work"/*.so "$work"/*.dylib "$work/libretro"/*.so "$work/libretro"/*.dylib "$work/Libretro"/*.so "$work/Libretro"/*.dylib "$work/src/os/libretro"/*.so "$work/src/os/libretro"/*.dylib)
[[ ${#bins[@]} -gt 0 ]] || { echo "ERROR: no se generó ningún binario en $work" >&2; exit 3; }
for b in "${bins[@]}"; do
	cp -f "$b" "$src/"
	sha1="$(sha1sum "$b" | cut -d' ' -f1)"
	echo "OK -> $src/$(basename "$b")  sha1=$sha1"
done
