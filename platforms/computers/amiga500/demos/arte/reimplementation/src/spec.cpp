// Cargador mínimo de la HIGS (sin dependencias externas).
//
// NOTA: extracción naive de campos por búsqueda de texto; se sustituirá por un lector JSON
// (p. ej. nlohmann/json) cuando el proyecto lo incorpore. Suficiente como esqueleto/verificación.

#include "arte/spec.hpp"

#include <cctype>
#include <fstream>
#include <sstream>

namespace arte {

namespace {

std::string read_file(const std::string& path) {
    std::ifstream f(path, std::ios::binary);
    if (!f) return {};
    std::ostringstream ss;
    ss << f.rdbuf();
    return ss.str();
}

// Devuelve la primera cadena entrecomillada tras la clave `key`.
std::string str_after(const std::string& s, const std::string& key) {
    auto p = s.find("\"" + key + "\"");
    if (p == std::string::npos) return {};
    p = s.find('"', s.find(':', p));
    if (p == std::string::npos) return {};
    auto q = s.find('"', p + 1);
    if (q == std::string::npos) return {};
    return s.substr(p + 1, q - p - 1);
}

// Devuelve el primer entero tras la clave `key`.
int int_after(const std::string& s, const std::string& key) {
    auto p = s.find("\"" + key + "\"");
    if (p == std::string::npos) return 0;
    p = s.find(':', p);
    if (p == std::string::npos) return 0;
    ++p;
    while (p < s.size() && !std::isdigit(static_cast<unsigned char>(s[p]))) ++p;
    int v = 0;
    while (p < s.size() && std::isdigit(static_cast<unsigned char>(s[p]))) {
        v = v * 10 + (s[p] - '0');
        ++p;
    }
    return v;
}

}  // namespace

GameSpec load_spec(const std::string& node_dir) {
    GameSpec spec;
    const std::string path = node_dir + "/spec/game.json";
    const std::string s = read_file(path);
    if (s.empty()) {
        spec.error = "no se pudo leer " + path;
        return spec;
    }
    spec.game_id = str_after(s, "game_id");
    spec.title = str_after(s, "title");
    spec.tick_hz = int_after(s, "tick_hz");
    spec.width = int_after(s, "width");
    spec.height = int_after(s, "height");

    // Recolecta todas las rutas "path": "assets/...".
    const std::string key = "\"path\"";
    std::size_t p = 0;
    while ((p = s.find(key, p)) != std::string::npos) {
        std::string v = str_after(s.substr(p), "path");
        if (v.rfind("assets/", 0) == 0) spec.asset_paths.push_back(v);
        p += key.size();
    }

    spec.valid = !spec.game_id.empty() && spec.tick_hz > 0 && spec.width > 0 && spec.height > 0;
    if (!spec.valid) spec.error = "spec incompleta";
    return spec;
}

bool check_assets(const GameSpec& spec, const std::string& node_dir,
                  std::vector<std::string>& missing) {
    missing.clear();
    for (const auto& rel : spec.asset_paths) {
        std::ifstream f(node_dir + "/" + rel, std::ios::binary);
        if (!f) missing.push_back(rel);
    }
    return missing.empty();
}

}  // namespace arte
