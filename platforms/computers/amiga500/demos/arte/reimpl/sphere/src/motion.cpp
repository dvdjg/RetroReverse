// reimpl/sphere/src/motion.cpp
#include "motion.hpp"
#include <cmath>
#include <vector>

namespace rein {

namespace {

// Tabla de seno del original ($3e3c0): 8192 entradas,
//   sine[k] = round(32767 * sin(2*pi*k/8192)).
std::vector<int>& sine_table() {
    static std::vector<int> t = [] {
        constexpr double kPi = 3.14159265358979323846;
        std::vector<int> v(8192);
        for (int k = 0; k < 8192; k++) {
            v[k] = (int)std::lround(32767.0 * std::sin(2.0 * kPi * k / 8192.0));
        }
        return v;
    }();
    return t;
}

inline int fetch(int phase) {
    return sine_table()[(phase & 0x3ffe) >> 1];
}

// asr 16 (shift aritmético), como el 68k.
inline int asr16(int v) { return v >> 16; }

}  // namespace

void Motion::step() {
    pa = (std::uint16_t)((pa + kStepA) & 0xffff);
    pb = (std::uint16_t)((pb + kStepB) & 0xffff);
    pc = (std::uint16_t)((pc + kStepC) & 0xffff);
    pd = (std::uint16_t)((pd + kStepD) & 0xffff);
    int vh = asr16(fetch(pa) * 0x540) + asr16(fetch(pb) * 0x1c0);
    int vv = asr16(fetch(pc) * 0x460) + asr16(fetch(pd) * 0x620);
    acc_h = (std::uint16_t)((acc_h + vh) & 0xffff);
    acc_v = (std::uint16_t)((acc_v + vv) & 0xffff);
}

}  // namespace rein