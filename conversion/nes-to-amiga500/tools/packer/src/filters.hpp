// ============================================================
// filters.hpp — Filtros reversibles delante de la compresión.
// ============================================================
//
// QUÉ ES
//   API de transformación reversible que se aplica a un segmento ANTES de
//   comprimir; el cargador aplica el inverso DESPUÉS de descomprimir.
//
// DECISIÓN (ADR 0006)
//   El banco del proyecto B mostró que ningún filtro mejora el ratio con ZX0
//   (ni con los demás códecs LZ modernos): `none` gana en los 4 tipos de dato.
//   Se implementa SOLO `Filter::None`; el resto de valores de `enum Filter`
//   quedan **reservados** en el formato por si un corpus futuro los justifica.
//
// QUIÉN LO USA
//   - `main.cpp` (packer): aplica el filtro elegido por segmento.
//   - `main.cpp` (--unpack/--verify): aplica el inverso.
//
// RECURSOS
//   Solo memoria host (std::vector).

#pragma once

#include "rrpk_format.hpp"

#include <vector>

namespace rrpk {

/// ¿El packer sabe aplicar/deshacer este filtro?
/// \param f Identificador del filtro.
/// \return `true` solo para `Filter::None` en esta versión.
[[nodiscard]] inline bool filter_supported(Filter f) noexcept {
	return f == Filter::None;
}

/// Aplica el filtro `f` a `in`.
/// \param f Filtro a aplicar (debe cumplir `filter_supported`).
/// \param in Datos originales.
/// \return Datos filtrados, o vacío si el filtro no está soportado.
[[nodiscard]] inline std::vector<uint8_t> filter_apply(Filter f, const std::vector<uint8_t>& in) {
	if (f == Filter::None) {
		return in;
	}
	return {};
}

/// Deshace el filtro `f` **in situ** sobre `data`.
/// \param f Filtro aplicado originalmente.
/// \param data Datos descomprimidos (se modifican).
/// \return `true` si el inverso se aplicó (filtro soportado).
[[nodiscard]] inline bool filter_inverse(Filter f, std::vector<uint8_t>& data) {
	(void)data;
	return f == Filter::None;
}

} // namespace rrpk
