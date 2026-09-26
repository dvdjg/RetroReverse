#pragma once

/// \file types.hpp (shim m68k)
/// Sustituto mínimo de `eng/core/types/types.hpp` para compilar el runtime
/// (intérprete y ejecutor rápido) para `m68k-amiga` **sin** depender del engine
/// `Amiga-Cpp` (en desarrollo). Solo define los alias de enteros que usan esos
/// headers; se apoya en los tipos predefinidos del compilador, así que es
/// correcto en cualquier arquitectura (en `m68k`, `usize` = 32 bits).
namespace eng {
using u8 = __UINT8_TYPE__;
using u16 = __UINT16_TYPE__;
using u32 = __UINT32_TYPE__;
using u64 = __UINT64_TYPE__;
using s8 = __INT8_TYPE__;
using s16 = __INT16_TYPE__;
using s32 = __INT32_TYPE__;
using s64 = __INT64_TYPE__;
using usize = __SIZE_TYPE__;
using isize = __PTRDIFF_TYPE__;
} // namespace eng
