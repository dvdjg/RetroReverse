#pragma once

/// \file n2a_config.hpp
/// **Archivo de configuración** del host, en texto editable (`clave = valor`,
/// `#` comenta). Guarda el escalado de la ventana, el shader activo y sus teclas,
/// y la integración con ShaderGlass. Se guarda al vuelo al cambiar opciones.

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>

namespace n2a {

/// Opciones persistentes del host.
struct N2AConfig {
	int scale = 4;                       ///< Escala de la ventana al arrancar (entera; 4 = pixel 4x4).
	std::string shader = "crt80s";       ///< Shader activo (ver `n2a_shaders.hpp`).
	std::string shader_next = "F1";      ///< Tecla para el siguiente shader (nombre SDL).
	std::string shader_prev = "F2";      ///< Tecla para el shader anterior.
	std::string shaderglass_exe;         ///< Ruta a `ShaderGlass.exe` (opcional).
	std::string shaderglass_profile;     ///< Perfil `.sgp` a cargar en ShaderGlass (opcional).

	/// Carga `path`. Los campos ausentes conservan su valor por defecto.
	/// \return `true` si el fichero existía y se leyó.
	bool load(const char* path) {
		std::FILE* f = std::fopen(path, "rb");
		if (f == nullptr) {
			return false;
		}
		char line[512];
		while (std::fgets(line, sizeof line, f) != nullptr) {
			char* s = line;
			while (*s == ' ' || *s == '\t') {
				++s;
			}
			if (*s == '#' || *s == '\n' || *s == '\0' || *s == '\r') {
				continue;
			}
			char* eq = std::strchr(s, '=');
			if (eq == nullptr) {
				continue;
			}
			*eq = '\0';
			std::string key = trim(s);
			std::string val = trim(eq + 1);
			if (key == "scale") {
				scale = std::atoi(val.c_str());
				if (scale < 1) {
					scale = 1;
				}
			} else if (key == "shader") {
				shader = val;
			} else if (key == "shader_next") {
				shader_next = val;
			} else if (key == "shader_prev") {
				shader_prev = val;
			} else if (key == "shaderglass_exe") {
				shaderglass_exe = val;
			} else if (key == "shaderglass_profile") {
				shaderglass_profile = val;
			}
		}
		std::fclose(f);
		return true;
	}

	/// Guarda la configuración en `path`.
	/// \return `true` si se pudo escribir.
	bool save(const char* path) const {
		std::FILE* f = std::fopen(path, "wb");
		if (f == nullptr) {
			return false;
		}
		std::fprintf(f, "# nes_sdl config (editable a mano)\n");
		std::fprintf(f, "# scale: escala entera de la ventana (4 => pixel NES = 4x4 px).\n");
		std::fprintf(f, "scale = %d\n", scale);
		std::fprintf(f, "# shader activo (ver n2a_shaders.hpp): none | scanlines | crt80s\n");
		std::fprintf(f, "shader = %s\n", shader.c_str());
		std::fprintf(f, "# teclas (nombres SDL) para cambiar de shader en partida\n");
		std::fprintf(f, "shader_next = %s\n", shader_next.c_str());
		std::fprintf(f, "shader_prev = %s\n", shader_prev.c_str());
		std::fprintf(f, "# ShaderGlass (opcional): lanzar al arrancar con un perfil\n");
		std::fprintf(f, "shaderglass_exe = %s\n", shaderglass_exe.c_str());
		std::fprintf(f, "shaderglass_profile = %s\n", shaderglass_profile.c_str());
		std::fclose(f);
		return true;
	}

private:
	/// Recorta espacios al principio y final de `s`.
	static std::string trim(std::string s) {
		std::size_t b = 0;
		while (b < s.size() && (s[b] == ' ' || s[b] == '\t')) {
			++b;
		}
		std::size_t e = s.size();
		while (e > b && (s[e - 1] == ' ' || s[e - 1] == '\t' || s[e - 1] == '\r' ||
				 s[e - 1] == '\n')) {
			--e;
		}
		return s.substr(b, e - b);
	}
};

} // namespace n2a
