// ============================================================
// codecs.cpp — Implementación de compresión (Store, ZX0) y descompresión ZX0.
// ============================================================
//
// QUÉ ES
//   `Store`: copia. `Zx0`: usa el compresor vendorizado (`vendor/zx0/`,
//   funciones `optimize()` + `compress()`), y el decodificador es una
//   implementación propia del formato ZX0 v2.2 en modo forward "invertido"
//   (idéntico al del CLI `dzx0`, sin E/S de fichero).
//
// QUIÉN LO USA
//   - `main.cpp` al empaquetar y al verificar/desempaquetar.
//
// RECURSOS
//   Memoria host. `zx0_compress` reserva ~O(input_size) para el optimizador.

#include "codecs.hpp"

extern "C" {
#include "zx0.h" // vendor/zx0/zx0.h — optimize() + compress()
}

#include <cstdlib>
#include <cstring>

namespace rrpk {

// Offset máximo del formato ZX0 (zx0.c: MAX_OFFSET_ZX0).
static constexpr int kZx0MaxOffset = 32640;

std::vector<uint8_t> zx0_compress(const std::vector<uint8_t>& in) {
	if (in.empty()) {
		return {};
	}
	// `optimize`/`compress` reciben punteros no-const: copiamos a un búfer mutable.
	std::vector<uint8_t> src = in;
	BLOCK* optimal = optimize(src.data(), static_cast<int>(in.size()), 0, kZx0MaxOffset);
	if (optimal == nullptr) {
		return {};
	}
	int out_size = 0;
	int delta = 0;
	unsigned char* packed = compress(optimal, src.data(), static_cast<int>(in.size()), 0,
					 /*backwards_mode=*/0, /*invert_mode=*/1, &out_size, &delta);
	if (packed == nullptr || out_size <= 0) {
		std::free(packed);
		return {};
	}
	std::vector<uint8_t> out(packed, packed + out_size);
	std::free(packed);
	return out;
}

namespace {

/// Lector de bits del stream ZX0 (orden MSB, con el truco "backtrack").
struct BitReader {
	const uint8_t* src;
	size_t size;
	size_t pos = 0;
	int bit_mask = 0;
	int bit_value = 0;
	bool backtrack = false;
	int last_byte = 0;
	bool ok = true;

	BitReader(const uint8_t* s, size_t n) : src(s), size(n) {}

	/// Lee un byte del stream; marca `ok=false` si se agota.
	int read_byte() {
		if (pos >= size) {
			ok = false;
			return 0;
		}
		last_byte = src[pos++];
		return last_byte;
	}

	/// Lee un bit (MSB-first) o reutiliza el último byte si estamos en backtrack.
	int read_bit() {
		if (backtrack) {
			backtrack = false;
			return last_byte & 1;
		}
		bit_mask >>= 1;
		if (bit_mask == 0) {
			bit_mask = 128;
			bit_value = read_byte();
		}
		return (bit_value & bit_mask) ? 1 : 0;
	}

	/// Elias gamma intercalado de ZX0. `inverted` = modo v2 (no clásico).
	int read_elias(bool inverted) {
		int value = 1;
		while (read_bit() == 0) {
			value = (value << 1) | (read_bit() ^ (inverted ? 1 : 0));
		}
		return value;
	}
};

} // namespace

bool zx0_decompress(const uint8_t* src, size_t n, std::vector<uint8_t>& out, size_t expected) {
	out.clear();
	out.reserve(expected);
	BitReader r(src, n);
	int last_offset = 1;

	// Copia `length` bytes desde `out.size()-offset` (admite solapamiento LZ).
	auto copy_match = [&](int offset, int length) -> bool {
		if (offset <= 0) {
			return false;
		}
		for (int k = 0; k < length; ++k) {
			const size_t cur = out.size();
			if (cur < static_cast<size_t>(offset)) {
				return false;
			}
			const uint8_t v = out[cur - static_cast<size_t>(offset)];
			out.push_back(v);
		}
		return true;
	};

	goto copy_literals;

copy_literals:
	{
		const int length = r.read_elias(false);
		for (int i = 0; i < length; ++i) {
			out.push_back(static_cast<uint8_t>(r.read_byte()));
		}
		if (!r.ok) {
			return false;
		}
		if (r.read_bit() != 0) {
			goto copy_from_new_offset;
		}
	}
	// Repetición del último offset.
	{
		const int length = r.read_elias(false);
		if (!copy_match(last_offset, length)) {
			return false;
		}
		if (r.read_bit() == 0) {
			goto copy_literals;
		}
	}
	goto copy_from_new_offset;

copy_from_new_offset:
	last_offset = r.read_elias(true);
	if (last_offset == 256) {
		return r.ok && out.size() == expected;
	}
	last_offset = last_offset * 128 - (r.read_byte() >> 1);
	r.backtrack = true;
	{
		const int length = r.read_elias(false) + 1;
		if (!copy_match(last_offset, length)) {
			return false;
		}
	}
	if (r.read_bit() != 0) {
		goto copy_from_new_offset;
	}
	goto copy_literals;
}

std::vector<uint8_t> compress_segment(Codec codec, const std::vector<uint8_t>& in) {
	switch (codec) {
	case Codec::Store:
		return in;
	case Codec::Zx0:
		return zx0_compress(in);
	case Codec::Aplib:
	case Codec::Deflate:
		return {}; // No implementados en A (ver ADR 0006).
	}
	return {};
}

bool decompress_segment(Codec codec, const uint8_t* src, size_t n, size_t orig_size,
			std::vector<uint8_t>& out) {
	switch (codec) {
	case Codec::Store:
		out.assign(src, src + n);
		return out.size() == orig_size;
	case Codec::Zx0:
		return zx0_decompress(src, n, out, orig_size);
	case Codec::Aplib:
	case Codec::Deflate:
		return false;
	}
	return false;
}

} // namespace rrpk
