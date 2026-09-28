#!/usr/bin/env bash
# _build_pc.sh (v2) — compila los CLIs PC de cada codec para el banco comparativo.
# No se versiona (external/ gitignored). Ejecutar dentro de WSL Ubuntu.
set -u
cd "$(dirname "$0")" || exit 1
ROOT="$(pwd)"
echo "ROOT=$ROOT"

run() {
  local tag="$1"; shift
  echo "=================================================================="
  echo ">> $tag : $*"
  "$@" >"$ROOT/_log_${tag}.txt" 2>&1
  local rc=$?
  if [ $rc -ne 0 ]; then
    echo "FALLO($rc) $tag — ver _log_${tag}.txt"; tail -n 12 "$ROOT/_log_${tag}.txt"
  else
    echo "OK $tag"
  fi
}

# ZX0 (Makefile usa OpenWatcom -> forzamos gcc).
run ZX0 make -C ZX0/src CC=cc CFLAGS="-O3 -w"
# apultra / lzsa (Makefile usa clang -> forzamos gcc).
run apultra make -C apultra CC=gcc -j4
run lzsa    make -C lzsa    CC=gcc -j4
# lz4, zopfli, Shrinkler (ya compilan con gcc).
run lz4       make -C lz4 -j4
run zopfli    make -C zopfli -j4
run Shrinkler make -C Shrinkler -j4
# RNC ProPack: target de 64 bits (el de 32 falla sin headers multilib).
run rnc make -C rnc_propack rnc64
# PowerPacker: main.cpp portable -> g++.
run powerpacker bash -c 'g++ -O2 -std=c++17 -o powerpacker/powerpack powerpacker/main.cpp'
# ancient: CLI de descompresion (incluye RNC, Imploder PP20/IMP, StoneCracker...).
run ancient bash -c 'g++ -O2 -std=c++17 -I ancient/api -I ancient/src -I ancient/src/common -o ancient/ancient_cli ancient/main.cpp ancient/src/*.cpp ancient/src/common/*.cpp 2>/dev/null || g++ -O2 -std=c++17 -I ancient/api -I ancient/src -I ancient/src/common -o ancient/ancient_cli ancient/main.cpp ancient/src/*.cpp'

echo "=================================================================="
echo "BINARIOS:"
find "$ROOT" -maxdepth 3 -type f -perm -u+x \
  \( -name 'zx0' -o -name 'salvador' -o -name 'apultra' -o -name 'lzsa' \
     -o -name 'lz4' -o -name 'zopfli' -o -name 'Shrinkler' -o -name 'unshrinkler' \
     -o -name 'rnc64' -o -name 'powerpack' -o -name 'ancient_cli' \) \
  -printf '%10s  %p\n' 2>/dev/null | sort -k2
echo "FIN"
