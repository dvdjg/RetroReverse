#pragma once

/// \file n2a_log.hpp
/// **Sistema de trazas** del host (nivel configurable) para saber por dónde iba el
/// programa cuando algo falla. Escribe a `stderr` (sin búfer, así la última línea
/// sobrevive a un *crash*) y, opcionalmente, a un fichero de log.
///
/// Niveles: `Error < Warn < Info < Debug < Trace`. Por defecto **Info** (mínimo en
/// release); `--verbose` sube a `Debug`, `--trace` a `Trace`; también por entorno
/// `N2A_LOG=<error|warn|info|debug|trace>`.
///
/// Uso:
/// ```cpp
/// N2A_LOGI("cargando plugin '%s'", path);
/// N2A_LOGE("no se pudo abrir '%s'", path);
/// ```

#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>

namespace n2a {

/// Nivel de detalle del log.
enum class LogLevel : int {
	Error = 0, ///< Solo errores.
	Warn = 1,  ///< Errores + avisos.
	Info = 2,  ///< + hitos (por defecto).
	Debug = 3, ///< + pasos internos.
	Trace = 4, ///< + todo (incluye per-frame).
};

/// Nivel de log global (por defecto `Info`).
inline int& log_level_ref() {
	static int lvl = static_cast<int>(LogLevel::Info);
	return lvl;
}

/// Fichero de log opcional (por defecto `stderr`).
inline std::FILE*& log_file_ref() {
	static std::FILE* f = nullptr;
	return f;
}

/// Fija el nivel de log.
inline void log_set_level(LogLevel l) { log_level_ref() = static_cast<int>(l); }

/// \return El nivel de log actual.
inline int log_level() { return log_level_ref(); }

/// Abre (trunca) `path` como fichero de log además de `stderr`.
/// \return `true` si se abrió.
inline bool log_set_file(const char* path) {
	std::FILE* f = std::fopen(path, "w");
	if (f == nullptr) {
		return false;
	}
	log_file_ref() = f;
	return true;
}

/// Traduce `"error"|"warn"|"info"|"debug"|"trace"` a nivel (por defecto `Info`).
inline LogLevel log_parse_level(const char* s) {
	if (s == nullptr) {
		return LogLevel::Info;
	}
	if (std::strcmp(s, "error") == 0) {
		return LogLevel::Error;
	}
	if (std::strcmp(s, "warn") == 0) {
		return LogLevel::Warn;
	}
	if (std::strcmp(s, "debug") == 0 || std::strcmp(s, "verbose") == 0) {
		return LogLevel::Debug;
	}
	if (std::strcmp(s, "trace") == 0) {
		return LogLevel::Trace;
	}
	return LogLevel::Info;
}

/// Emite una línea si `l <= nivel`. Prefija con `[n2a][TAG]`.
/// \param l Nivel del mensaje.
/// \param tag Etiqueta corta (`ERROR`, `INFO`, …).
/// \param fmt Formato printf.
inline void log_emit(LogLevel l, const char* tag, const char* fmt, ...) {
	if (static_cast<int>(l) > log_level()) {
		return;
	}
	char buf[1024];
	va_list ap;
	va_start(ap, fmt);
	std::vsnprintf(buf, sizeof buf, fmt, ap);
	va_end(ap);
	std::fprintf(stderr, "[n2a][%s] %s\n", tag, buf);
	if (log_file_ref() != nullptr) {
		std::fprintf(log_file_ref(), "[n2a][%s] %s\n", tag, buf);
		std::fflush(log_file_ref());
	}
}

} // namespace n2a

/// \def N2A_LOGE
/// Log de error.
#define N2A_LOGE(...) n2a::log_emit(n2a::LogLevel::Error, "ERROR", __VA_ARGS__)
/// \def N2A_LOGW
/// Log de aviso.
#define N2A_LOGW(...) n2a::log_emit(n2a::LogLevel::Warn, "WARN", __VA_ARGS__)
/// \def N2A_LOGI
/// Log informativo (hitos).
#define N2A_LOGI(...) n2a::log_emit(n2a::LogLevel::Info, "INFO", __VA_ARGS__)
/// \def N2A_LOGD
/// Log de depuración (pasos internos).
#define N2A_LOGD(...) n2a::log_emit(n2a::LogLevel::Debug, "DEBUG", __VA_ARGS__)
/// \def N2A_LOGT
/// Log de traza (todo, incl. per-frame).
#define N2A_LOGT(...) n2a::log_emit(n2a::LogLevel::Trace, "TRACE", __VA_ARGS__)
