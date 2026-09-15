// reimpl/sphere/src/sphere.cpp
// Implementación fiel de la esfera de «Arte» (port del algoritmo recuperado).
#include "sphere.hpp"
#include "tables.hpp"

namespace rein {

namespace {

// 68000 asr.w: shift aritmético de la word baja, resultado leído como unsigned.
inline u16 asr_w(u16 v, int n) {
    std::int32_t s = (v & 0x8000) ? (std::int32_t)v - 0x10000 : (std::int32_t)v;
    return (u16)((s >> n) & 0xffff);
}

// Interpreta una word como signed.
inline std::int16_t s16(u16 v) {
    return (v & 0x8000) ? (std::int16_t)(v - 0x10000) : (std::int16_t)v;
}

inline std::int16_t tb(int i) {
    // profile_table[i] como byte SIGNED (0..255 -> -128..127).
    return (std::int16_t)(std::int8_t)kProfileTable[i];
}

// El cálculo por muestra, idéntico en ambas pasadas.
u16 profile(int idx, u16 amp) {
    u16 d = (u16)tb(idx);  // el signed se extiende a 16 bits al pasar a word
    d = (u16)((u16)(s16(d) * (std::int16_t)amp) & 0xffff);
    d = asr_w(d, 7);
    d = (u16)((3 * s16(d)) & 0xffff);
    return asr_w(d, 3);
}

}  // namespace

std::vector<u8> generate_sphere_map() {
    const int rows = kHeight, words = kMapWords;
    std::vector<u8> buf((std::size_t)rows * words * 2);
    // sentinela inicial: byte alto 0x7f, bajo 0xfc -> word 0x7ffc -> offset 0xfffc
    for (int i = 0; i < rows * words; i++) {
        buf[i * 2] = 0x7f;
        buf[i * 2 + 1] = 0xfc;
    }

    // pass 1: byte alto (U), un acorde horizontal por fila
    std::uint32_t acc = 0;
    for (int row = 0; row < rows; row++) {
        u8 raw = kExtentTable[(acc >> 16) & 0xff];
        u16 amp = (u16)((0x80 + (raw >> 1)) & 0xffff);
        acc = (acc + 0x0002d82d) & 0xffffffff;
        int n = 2 * ((raw * 0x3000) >> 16);
        if (n > 0) {
            std::uint32_t step = (std::uint32_t)((0x10000 / n) << 8);
            std::uint32_t t = 0;
            int p = 48 + (n / 2);
            for (int k = 1; k <= n; k++) {
                buf[(std::size_t)(row * words + p) * 2] =
                    (u8)(profile((int)(t >> 16), amp) & 0xff);
                p--;
                t = (t + step) & 0xffffffff;
            }
        }
    }

    // pass 2: byte bajo (V, forzado par), un acorde vertical por columna
    acc = 0;
    for (int col = 0; col < words; col++) {
        u8 raw = kExtentTable[(acc >> 16) & 0xff];
        u16 amp = (u16)((0x80 + (raw >> 1)) & 0xffff);
        acc = (acc + 0x0002aaaa) & 0xffffffff;
        int n = 2 * ((raw * 0x2d00) >> 16);
        if (n > 0) {
            std::uint32_t step = (std::uint32_t)((0x10000 / n) << 8);
            std::uint32_t t = 0;
            int r = 45 - (n / 2);
            for (int k = 1; k <= n; k++) {
                buf[(std::size_t)(r * words + col) * 2 + 1] =
                    (u8)(profile((int)(t >> 16), amp) & 0xfe);
                r++;
                t = (t + step) & 0xffffffff;
            }
        }
    }
    return buf;
}

u16 sphere_offset(const std::vector<u8>& map, int row, int word) {
    std::size_t i = ((std::size_t)row * kMapWords + word) * 2;
    u16 v = (u16)((map[i] << 8) | map[i + 1]);
    return (u16)((0x8000 + (std::uint16_t)s16(v)) & 0xffff);
}

std::vector<u8> sphere_render(const std::vector<u8>& texture,
                              const std::vector<u8>& map, u16 rotation) {
    std::vector<u8> dst((std::size_t)kWidth * kHeight);
    u16 d = rotation & 0xffff;
    for (int row = 0; row < kHeight; row++) {
        for (int x = 0; x < kWidth; x++) {
            u16 off = sphere_offset(map, row, x >> 1);
            u8 texel;
            if (off == 0xfffc || off == 0xfffd) {
                texel = 0;  // sentinela -> fondo
            } else {
                texel = texture[(u16)((off + d) & 0xffff)];
            }
            dst[(std::size_t)row * kWidth + x] = texel;
        }
    }
    return dst;
}

std::vector<u8> double_rows(const std::vector<u8>& frame) {
    std::vector<u8> dst(frame.size() * 2);
    for (int y = 0; y < kHeight; y++) {
        for (int x = 0; x < kWidth; x++) {
            u8 v = frame[(std::size_t)y * kWidth + x];
            dst[(std::size_t)(2 * y) * kWidth + x] = v;
            dst[(std::size_t)(2 * y + 1) * kWidth + x] = v;
        }
    }
    return dst;
}

}  // namespace rein