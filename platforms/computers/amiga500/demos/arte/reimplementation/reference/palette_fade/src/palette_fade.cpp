// reimplementation/reference/palette_fade/src/palette_fade.cpp
#include "palette_fade.hpp"

namespace rein {

namespace {
// Acerca un nibble de `cur` hacia `dst` (1 paso).
u16 fade_nibble(u16 cur, u16 dst, int shift) {
    int c = (cur >> shift) & 0xF;
    int d = (dst >> shift) & 0xF;
    if (c < d) c++;
    else if (c > d) c--;
    return (u16)((cur & ~(0xF << shift)) | (c << shift));
}
}  // namespace

bool fade_palette_step(std::vector<u16>& cur, const std::vector<u16>& dst) {
    bool changed = false;
    for (std::size_t i = 0; i < cur.size() && i < dst.size(); i++) {
        u16 v = cur[i];
        // Los 3 nibbles: R (8-11), G (4-7), B (0-3). El asm los procesa con
        // +1/-1 (B), +0x10/-0x10 (G), +0x100/-0x100 (R) = un paso por nibble.
        v = fade_nibble(v, dst[i], 0);
        v = fade_nibble(v, dst[i], 4);
        v = fade_nibble(v, dst[i], 8);
        // El bit 12 de OCS (0RGB) se ignora.
        if (v != cur[i]) { cur[i] = v; changed = true; }
    }
    return changed;
}

void fade_palette(std::vector<u16>& cur, const std::vector<u16>& dst, int max_steps) {
    for (int s = 0; s < max_steps; s++) {
        if (!fade_palette_step(cur, dst)) break;
    }
}

}  // namespace rein