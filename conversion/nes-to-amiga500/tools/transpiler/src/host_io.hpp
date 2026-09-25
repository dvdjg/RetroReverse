#pragma once

/// \file host_io.hpp
/// E/S de fichero y consola para la **herramienta host** (el transpilador). Usa la
/// libreria C (`<cstdio>`) y los contenedores del engine; **no** usa la STL de
/// C++ (`<fstream>`, `<iostream>`, `<filesystem>`, `<string>`, `<format>`).

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/string_view.hpp>
#include <eng/core/util/vector.hpp>

#include <cstdio>

namespace n2a {

using ByteBuffer = eng::util::Vector<eng::u8, eng::util::HeapAlloc>;

/// Lee un fichero entero a `out`. `false` si no se puede abrir o leer completo.
inline bool read_whole_file(const char* path, ByteBuffer& out) {
	std::FILE* f = std::fopen(path, "rb");
	if (f == nullptr) {
		return false;
	}
	std::fseek(f, 0, SEEK_END);
	const long n = std::ftell(f);
	std::fseek(f, 0, SEEK_SET);
	if (n < 0) {
		std::fclose(f);
		return false;
	}
	if (!out.resize(static_cast<eng::usize>(n), 0u)) {
		std::fclose(f);
		return false;
	}
	const eng::usize got =
		(n == 0) ? 0u : static_cast<eng::usize>(std::fread(out.data(), 1, static_cast<size_t>(n), f));
	std::fclose(f);
	return got == static_cast<eng::usize>(n);
}

/// Escribe `text` a un fichero (binario). `false` si falla.
inline bool write_whole_file(const char* path, eng::util::StringView text) {
	std::FILE* f = std::fopen(path, "wb");
	if (f == nullptr) {
		return false;
	}
	const eng::usize written =
		text.empty()
			? 0u
			: static_cast<eng::usize>(std::fwrite(text.data(), 1, static_cast<size_t>(text.size()), f));
	std::fclose(f);
	return written == text.size();
}

/// Escribe `text` + salto de linea en stdout.
inline void out_line(eng::util::StringView text) {
	if (!text.empty()) {
		std::fwrite(text.data(), 1, static_cast<size_t>(text.size()), stdout);
	}
	std::fputc('\n', stdout);
}

/// Escribe `text` + salto de linea en stderr.
inline void err_line(eng::util::StringView text) {
	if (!text.empty()) {
		std::fwrite(text.data(), 1, static_cast<size_t>(text.size()), stderr);
	}
	std::fputc('\n', stderr);
}

} // namespace n2a
