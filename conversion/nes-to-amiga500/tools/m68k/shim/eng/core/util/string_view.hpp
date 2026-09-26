#pragma once

/// \file string_view.hpp (shim m68k)
/// `eng::util::StringView` mínimo (vista no propietaria sobre `const char*`) para
/// compilar el decodificador del ejecutor rápido sin el engine. Solo implementa
/// lo que usa `fastcpu.hpp`: construcción desde `const char*`, `operator==`/`!=`,
/// `size`/`empty`/`data`/`operator[]`.
#include <eng/core/types/types.hpp>

namespace eng {
namespace util {

/// Vista no propietaria de una cadena de caracteres.
struct StringView {
	const char* ptr_ = nullptr; ///< Puntero al inicio (o `nullptr`).
	eng::usize len_ = 0u;       ///< Longitud en bytes.

	/// Construye una vista vacía.
	constexpr StringView() noexcept = default;

	/// Construye una vista sobre una cadena terminada en `\0` (`nullptr` = vacía).
	/// \param s Cadena de origen (no se copia).
	constexpr StringView(const char* s) noexcept : ptr_(s), len_(s != nullptr ? len_of(s) : 0u) {}

	/// \return Puntero al inicio (puede ser `nullptr`).
	[[nodiscard]] constexpr const char* data() const noexcept { return ptr_; }

	/// \return Longitud en bytes.
	[[nodiscard]] constexpr eng::usize size() const noexcept { return len_; }

	/// \return `true` si la longitud es 0.
	[[nodiscard]] constexpr bool empty() const noexcept { return len_ == 0u; }

	/// Byte en la posición `i`.
	/// \param i Índice en `[0, size())`.
	/// \return Carácter en `i`.
	[[nodiscard]] constexpr char operator[](eng::usize i) const noexcept { return ptr_[i]; }

	/// Compara dos vistas por contenido.
	friend constexpr bool operator==(StringView a, StringView b) noexcept {
		if (a.len_ != b.len_) {
			return false;
		}
		for (eng::usize i = 0u; i < a.len_; ++i) {
			if (a.ptr_[i] != b.ptr_[i]) {
				return false;
			}
		}
		return true;
	}

	/// \return `true` si difieren en contenido.
	friend constexpr bool operator!=(StringView a, StringView b) noexcept { return !(a == b); }

private:
	/// Longitud de una cadena terminada en `\0`.
	/// \param s Cadena no nula.
	/// \return Número de bytes antes del terminador.
	static constexpr eng::usize len_of(const char* s) noexcept {
		eng::usize n = 0u;
		while (s[n] != '\0') {
			++n;
		}
		return n;
	}
};

} // namespace util
} // namespace eng
