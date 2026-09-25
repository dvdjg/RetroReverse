#ifndef ARTE_SPEC_HPP
#define ARTE_SPEC_HPP

// RetroReverse — cargador de la HIGS de «Arte».
// La reimplementación SOLO lee spec/ + assets/ (ADR 0003). Ver ../README.md.

#include <string>
#include <vector>

namespace arte {

struct GameSpec {
    std::string game_id;
    std::string title;
    int tick_hz = 0;
    int width = 0;
    int height = 0;
    std::vector<std::string> asset_paths;  // rutas relativas al nodo (p. ej. "assets/...")
    bool valid = false;
    std::string error;
};

// Carga <node_dir>/spec/game.json. `node_dir` = raíz del nodo (por defecto "..").
GameSpec load_spec(const std::string& node_dir);

// Comprueba que existen todos los assets referenciados por la spec.
bool check_assets(const GameSpec& spec, const std::string& node_dir,
                  std::vector<std::string>& missing);

}  // namespace arte

#endif  // ARTE_SPEC_HPP
