#pragma once

/// \file host_io.hpp
/// Entrada/salida de la herramienta **host** (el transpilador): lectura y
/// escritura de ficheros y mensajes por consola.
///
/// Usa la biblioteca C (`<cstdio>`) y los contenedores de `eng/core`; **no** usa
/// la STL de C++ (`<fstream>`, `<iostream>`, `<filesystem>`, `<string>`,
/// `<format>`). Se separa aquí para que el resto del código no dependa de E/S y
/// sea más fácil de probar.

#include <eng/core/types/span.hpp>
#include <eng/core/types/types.hpp>
#include <eng/core/util/heap_alloc.hpp>
#include <eng/core/util/string_view.hpp>
#include <eng/core/util/vector.hpp>

#include <cstdio>

namespace n2a {

/// Búfer de bytes en el heap del host (para ROMs y salidas).
using ByteBuffer = eng::util::Vector<eng::u8, eng::util::HeapAlloc>;

/// Lee un fichero completo a `out` en modo binario.
///
/// Redimensiona `out` al tamaño del fichero y lo rellena de una vez. Si ya tenía
/// contenido, se sobreescribe.
///
/// \param path Ruta del fichero (cadena terminada en NUL).
/// \param out  Destino; queda con exactamente `size` bytes.
/// \return `true` si se abrió y se leyó entero; `false` si no se pudo abrir o leer.
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

/// Escribe `text` a un fichero en modo binario (lo crea o lo trunca).
///
/// \param path Ruta de destino.
/// \param text Texto a escribir (típicamente el `.cpp` generado).
/// \return `true` si se escribió todo; `false` si no se pudo abrir o escribir.
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

/// Escribe `text` seguido de un salto de línea en la salida estándar.
/// \param text Texto a mostrar (no añade nada si está vacío).
inline void out_line(eng::util::StringView text) {
	if (!text.empty()) {
		std::fwrite(text.data(), 1, static_cast<size_t>(text.size()), stdout);
	}
	std::fputc('\n', stdout);
}

/// Escribe `text` seguido de un salto de línea en la salida de error.
/// \param text Mensaje de diagnóstico.
inline void err_line(eng::util::StringView text) {
	if (!text.empty()) {
		std::fwrite(text.data(), 1, static_cast<size_t>(text.size()), stderr);
	}
	std::fputc('\n', stderr);
}

} // namespace n2a
