// ============================================================
// codecs.hpp — Compresión/descompresión por segmento (RRPK).
// ============================================================
//
// QUÉ ES
//   API única para comprimir y descomprimir un segmento según su `Codec`:
//   `Store` (copia) y `Zx0` (comprime con el ZX0 vendorizado; descomprime con
//   una implementación propia del formato ZX0 v2.2).
//
// QUIÉN LO USA
//   - `main.cpp` (packer): elige el códec por segmento y lo aplica.
//
// RECURSOS
//   Memoria host (std::vector). El compresor ZX0 reserva memoria de trabajo
//   proporcional al tamaño del segmento.

#pragma once

#include "rrpk_format.hpp"

#include <cstddef>
#include <cstdint>
#include <vector>

namespace rrpk {

/// Comprime `in` con `codec`.
/// \param codec `Store` (devuelve copia) o `Zx0`.
/// \param in Datos de entrada.
/// \return Stream comprimido (vacío si el códec falla).
[[nodiscard]] std::vector<uint8_t> compress_segment(Codec codec, const std::vector<uint8_t>& in);

/// Descomprime `src[0..n)` con `codec` a un búfer de `orig_size` bytes.
/// \param codec Códec usado al comprimir.
/// \param src Payload comprimido.
/// \param n Tamaño del payload.
/// \param orig_size Tamaño esperado de salida.
/// \param out Salida (se redimensiona a `orig_size`).
/// \return `true` si se descomprimió exactamente `orig_size` bytes sin error.
bool decompress_segment(Codec codec, const uint8_t* src, size_t n, size_t orig_size,
                        std::vector<uint8_t>& out);

/// Descomprime un stream ZX0 (forward, formato "invertido" v2) ya en memoria.
/// \param src Stream ZX0.
/// \param n Tamaño del stream.
/// \param out Salida (se limpia y rellena).
/// \param expected Tamaño esperado de la salida (para validar).
/// \return `true` si ok y `out.size() == expected`.
bool zx0_decompress(const uint8_t* src, size_t n, std::vector<uint8_t>& out, size_t expected);

/// Comprime `in` con ZX0 (offset máximo 32640, forward, modo invertido v2).
/// \return Stream ZX0 (vacío si falla).
[[nodiscard]] std::vector<uint8_t> zx0_compress(const std::vector<uint8_t>& in);

} // namespace rrpk
