// Esqueleto del bucle de juego (TODO: efectos desde la HIGS; render SDL3).
#include "arte/game.hpp"

namespace arte {

void Game::update() {
    ++tick;  // TODO: paso de los efectos declarados en spec (entities/timing_sequences).
}

void Game::render() {
    // TODO: composición SDL3 (efectos + assets). Agnóstico de hardware original.
}

}  // namespace arte
