#pragma once

/// \file array.hpp (shim m68k)
/// `eng::util::Array<T,N>` mínimo para la tabla de opcodes (`opcodes.hpp`) sin el
/// engine. Es un array fijo indexable (`operator[]`) con `size()`, sin STL.
#include <eng/core/types/types.hpp>

namespace eng {
namespace util {

/// Array de tamaño fijo `N` de elementos `T`, sin memoria dinámica.
/// \tparam T Tipo de los elementos.
/// \tparam N Número de elementos.
template <class T, eng::usize N>
struct Array {
	T data[N] {}; ///< Almacenamiento contiguo, inicializado a `T{}`.

	/// Acceso al elemento `i` (sin comprobación de límites).
	/// \param i Índice en `[0, N)`.
	/// \return Referencia al elemento.
	constexpr T& operator[](eng::usize i) noexcept { return data[i]; }

	/// \copydoc operator[](eng::usize)
	constexpr const T& operator[](eng::usize i) const noexcept { return data[i]; }

	/// \return Número de elementos (`N`).
	[[nodiscard]] constexpr eng::usize size() const noexcept { return N; }
};

} // namespace util
} // namespace eng
