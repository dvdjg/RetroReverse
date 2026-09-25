#ifndef REIN_ZOOM_ZOOM_HPP
#define REIN_ZOOM_ZOOM_HPP

// reimpl/zoom — efecto de zoom/créditos de «Arte» (Sanity, 1993).
//
// Recreación en C++ del núcleo algorítmico recuperado del módulo `0x07E42C`
// (`out/modules_all/blk_07E42C_l1_20268.bin`), a partir del desensamblado canónico y del
// decompilado de Ghidra. Rutinas:
//   - FUN_0000024c (0x24C): paso de zoom por frame (tabla de factores Q16).
//   - FUN_000002d4 (0x2D4): trayectoria del objeto + cálculo de las bandas de BPLCON0
//     que se escriben en la copperlist.
//
// Fidelidad: la aritmética Q16 del 68k es `muls.w #c,d ; swap d` = (v*c)>>16. Las tablas
// se leen como shorts **big-endian** en offsets de byte (igual que el asm, que indexa con
// `&DAT_xxxx + byte_offset`).
//
// NO portado aquí: el blit/escalado por hardware (FUN_0000193e y el blitter) y la escritura
// real de la copperlist; se expone el cálculo de las bandas.

#include <cstdint>

namespace rein {

using i16 = std::int16_t;
using i32 = std::int32_t;
using u8 = std::uint8_t;
using u16 = std::uint16_t;
using u32 = std::uint32_t;

// Lee un short big-endian (como en memoria Amiga).
inline i16 rd_be16(const u8* p) {
    return static_cast<i16>(static_cast<u16>((static_cast<u16>(p[0]) << 8) | p[1]));
}

// Q16: (v*c)>>16  (`muls.w #c,d ; swap d`).
inline i16 q16_mul(i16 v, i16 c) {
    return static_cast<i16>((static_cast<i32>(v) * c) >> 16);
}

// --- zoom (FUN_0000024c, 0x24C) ---

struct ZoomState {
    i16 frame = 0;  // $232: contador de frames del efecto
    i16 idx = 0;    // $02D0: índice (avanza +6 por frame hasta 0xb4)
    i16 base = 0;   // $02D2: 0 o 0xb4 (segunda mitad de la tabla)
    i16 scale = 0;  // $02CE: centro de escala resultante
};

// Avanza un frame. `factor_table` apunta a la tabla de factores en el offset $3EE2.
// Devuelve el nº de bloques a dibujar (0 si el efecto aún no ha empezado, 4 en marcha).
int zoom_step(ZoomState& s, const u8* factor_table);

// --- trayectoria (FUN_000002d4, 0x2D4) ---

struct TrajState {
    i16 idx = 0;      // $238: índice de las tablas de trayectoria (+2)
    i16 idx2 = 0;     // $23a: índice de la 3ª tabla (+6)
    i16 x = 0;        // $416
    i16 y = 0;        // $41a
    i16 z = 0;        // $418
    i16 a = 0;        // $41c
    i16 b = 0;        // $420
    i16 c = 0;        // $41e (= z)
    i16 vx = 0;       // valor crudo de la tabla $3944 (para las bandas)
    bool active = false;
};

// Avanza la trayectoria un frame. Tablas: $3944, $38AA, $3A78 del módulo.
// Devuelve false si la trayectoria está desactivada ($238 == -1).
bool traj_step(TrajState& s, const u8* t3944, const u8* t38aa, const u8* t3a78);

// Bandas de BPLCON0 escritas en la copperlist: `n_before` líneas con 0x200, `n_5planes`
// con 0x5200 y `n_after` con 0x200 (recorte vertical del zoom).
struct Bands {
    int n_before = 0;
    int n_5planes = 0;
    int n_after = 0;
    bool valid = false;
};

Bands copper_bands(const TrajState& s);

}  // namespace rein

#endif  // REIN_ZOOM_ZOOM_HPP
