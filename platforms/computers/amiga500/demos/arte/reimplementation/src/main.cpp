// Arte (Sanity, 1993) — reimplementación (esqueleto).
//
// Regla (ADR 0003): esta carpeta SOLO lee `spec/` (HIGS) + `assets/`. No conoce el hardware
// original (Agnus/Denise/Paula) ni el desensamblado.
//
// Uso:
//   arte_check [node_dir]     # valida la HIGS y la presencia de assets (por defecto node_dir = "..")

#include <cstdio>
#include <string>
#include <vector>

#include "arte/game.hpp"
#include "arte/spec.hpp"

#ifdef ARTE_WITH_SDL
#include <SDL3/SDL.h>
#endif

int main(int argc, char** argv) {
    const std::string node_dir = (argc > 1) ? argv[1] : "..";

    arte::GameSpec spec = arte::load_spec(node_dir);
    if (!spec.valid) {
        std::printf("HIGS INVALIDA: %s\n", spec.error.c_str());
        return 1;
    }
    std::printf("game_id=%s  tick_hz=%d  res=%dx%d  assets=%zu\n",
                spec.game_id.c_str(), spec.tick_hz, spec.width, spec.height,
                spec.asset_paths.size());

    std::vector<std::string> missing;
    if (!arte::check_assets(spec, node_dir, missing)) {
        std::printf("ASSETS FALTANTES: %zu\n", missing.size());
        for (const auto& m : missing) std::printf("  - %s\n", m.c_str());
        return 2;
    }
    std::printf("HIGS OK: spec valida y assets presentes\n");

    arte::Game game;
    game.init(spec);

#ifdef ARTE_WITH_SDL
    // TODO: ventana SDL3 + bucle (update/render a tick_hz). Esqueleto.
    if (!SDL_Init(SDL_INIT_VIDEO)) {
        std::printf("SDL3 Init: %s\n", SDL_GetError());
        return 3;
    }
    SDL_Quit();
    std::printf("(SDL3 disponible: bucle de render pendiente)\n");
#else
    std::printf("(sin SDL3: solo verificacion de la HIGS)\n");
#endif
    return 0;
}
