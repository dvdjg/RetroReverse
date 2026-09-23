#!/usr/bin/env bash
# Builds Rizin + rz-ghidra FROM SOURCE in WSL/Linux, to use rz-ghidra as a SECOND m68k
# decompiler for cross-checking the Ghidra GUI decompiler.
#
# Why WSL: rz-ghidra ships no Windows binaries (releases only have `rz-ghidra-src-*.tar.gz`),
# and the prebuilt Rizin for Windows lacks the CMake config (RizinConfig.cmake) that rz-ghidra's
# `find_package(Rizin)` needs. On Linux we build Rizin from source (meson) which installs it.
#
# Prereqs (Ubuntu 24.04 WSL): gcc/g++/pkg-config/git/python3 (present by default), network.
# No sudo needed (cmake/ninja/meson are installed via pip --user).
#
# Sources expected next to the Amiga dir:  rizin-v0.9.0/  and  rz-ghidra/  (with its ghidra/
# submodule, i.e. the rz-ghidra-src tarball, ~362 MB).
#
# Usage:  bash build-rzghidra.sh [AMIGA_DIR]
#         (default AMIGA_DIR=/mnt/c/Users/dvdjg/Documents/programa/AI/Amiga)

set -e
AMIGA="${1:-/mnt/c/Users/dvdjg/Documents/programa/AI/Amiga}"
export PATH="$HOME/.local/bin:$PATH"
export PIP_BREAK_SYSTEM_PACKAGES=1

echo "=== 1) tools (pip --user: cmake ninja meson) ==="
python3 -m pip install --user --quiet cmake ninja meson
echo "cmake $(cmake --version | head -1) | meson $(meson --version) | ninja $(ninja --version)"

echo "=== 2) sources -> ~/rzbuild ==="
mkdir -p "$HOME/rzbuild"; cd "$HOME/rzbuild"
[ -d rizin ]     || cp -r "$AMIGA/rizin-v0.9.0" rizin
[ -d rz-ghidra ] || cp -r "$AMIGA/rz-ghidra"     rz-ghidra

echo "=== 3) Rizin 0.9.0 (matches rz-ghidra 0.9.0) -> installs RizinConfig.cmake ==="
cd rizin
meson setup build --buildtype=release --prefix="$HOME/rizin" --default-library=shared
ninja -C build
ninja -C build install

echo "=== 4) rz-ghidra 0.9.0 (system zlib: the bundled one lacks -fPIC and fails to link .so) ==="
cd ../rz-ghidra; rm -rf build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH="$HOME/rizin" -DCMAKE_INSTALL_PREFIX="$HOME/rizin" \
  -DBUILD_SLASSPECS=OFF -DBUILD_SLEIGH_PLUGIN=OFF -DUSE_SYSTEM_ZLIB=ON
cmake --build build -j"$(nproc)"
cmake --install build

echo "OK -> $HOME/rizin/bin/rizin  +  core_ghidra.so"
echo "Test:  RZ=\$HOME/rizin/bin/rizin; \$RZ -a m68k -b 32 -E big -m 0x0 -q -c 's 0xcba' -c af -c pdg <bin>"
