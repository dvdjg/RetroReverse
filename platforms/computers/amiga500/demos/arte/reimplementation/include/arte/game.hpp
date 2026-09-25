#ifndef ARTE_GAME_HPP
#define ARTE_GAME_HPP

#include "arte/spec.hpp"

namespace arte {

// Bucle de juego agnóstico de hardware: avanza efectos por tick y dibuja.
// SOLO consume GameSpec (spec/) y assets. Ver ../README.md.
struct Game {
    GameSpec spec;
    int tick = 0;

    void init(const GameSpec& s) { spec = s; tick = 0; }
    void update();  // avanza 1 tick (TODO: efectos desde la HIGS)
    void render();  // dibuja (TODO: SDL3)
};

}  // namespace arte

#endif  // ARTE_GAME_HPP
