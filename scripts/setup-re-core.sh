#!/usr/bin/env bash
# Prepara el fork instrumentado de Genesis Plus GX (libRetroReversing) en external/:
#   - clona el fork + submódulo si falta
#   - aplica los parches mínimos (cstdint, -lc++, shim `rr_re_command`, Makefile, link.T)
# Después:  bash scripts/build-libretro-core.sh libretro-gpgx-reversing
#
# Conducción headless: tools/orchestrator/re_drive usa el canal `rr_re_command`
# (implementado por el shim) para play/pause/save_state/export sin UI web.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIR="$ROOT/external/libretro-gpgx-reversing"
REPO_URL="https://github.com/RetroReversing/Genesis-Plus-GX.git"

if [[ ! -d "$DIR/.git" ]]; then
	echo "clonando $REPO_URL"
	git clone --depth 1 --recurse-submodules "$REPO_URL" "$DIR"
fi

FR="$DIR"
RE="$DIR/libRetroReversing"

# 1) cstdint en CDL_FileWriting.hpp (GCC moderno).
grep -q '#include <cstdint>' "$RE/cdl/CDL_FileWriting.hpp" || \
	sed -i 's|#include <stdio.h>|#include <stdio.h>\n#include <cstdint>|' "$RE/cdl/CDL_FileWriting.hpp"

# 2) libc++ no está instalado; el core usa libstdc++.
sed -i 's| -lc++||' "$RE/Makefile.retroreversing"

# 3) Shim C++ que expone el despachador de comandos del reversing como símbolo C.
cat > "$FR/libretro/re_driver.cpp" <<'EOF'
// RetroReverse: canal C directo para conducir libRetroReversing SIN la UI web.
#include <exception>
#include <string>

#include "../libRetroReversing/include/libRR.h"

extern "C" const char* rr_re_command(const char* message) {
    static std::string result;
    try {
        result = libRR_parse_message_from_web(json::parse(std::string(message)));
    } catch (const std::exception& e) {
        result = std::string("error: ") + e.what();
    } catch (...) {
        result = "error";
    }
    return result.c_str();
}
EOF

# 4) Compilar el shim y 5) exportarlo.
grep -q 'libretro/re_driver.cpp' "$FR/Makefile.libretro" || \
	sed -i 's|^OBJECTS := |SOURCES_CXX += libretro/re_driver.cpp\nOBJECTS := |' "$FR/Makefile.libretro"
grep -q 'rr_re_command' "$FR/libretro/link.T" || \
	sed -i 's|global: retro_\*;|global: retro_*; rr_re_command;|' "$FR/libretro/link.T"

echo "RE core preparado en $FR"
echo "compila con: bash scripts/build-libretro-core.sh libretro-gpgx-reversing"
