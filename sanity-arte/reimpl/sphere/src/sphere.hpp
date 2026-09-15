#ifndef REIN_SPHERE_HPP
#define REIN_SPHERE_HPP

// reimpl/sphere — esfera con textura mapeada de «Arte» (Sanity, 1993).
//
// Recreación en C++ del efecto "16 color sphere" de Chaos, a partir de los datos
// y la técnica recuperados (ver README.md). Es un **mapa de coordenadas fijo** de
// la pantalla (208 columnas útiles × 90 filas) sobre una textura de 256×256; girar
// la bola = sumar `rotation` (16 bits) a cada offset y envolver con & 0xffff.
//
// La textura es obra de Ra/Sanity (asset recuperado, ver data/ y atribución).

#include <cstdint>
#include <vector>

namespace rein {

using u8 = std::uint8_t;
using u16 = std::uint16_t;

constexpr int kWidth = 192;        // columnas mostradas
constexpr int kHeight = 90;        // filas mostradas (el copper las duplica)
constexpr int kBufferWidth = 208;  // ancho del buffer (192 útiles)
constexpr int kMapWords = 96;      // words por fila en el mapa
constexpr int kTexSize = 0x10000;  // 256x256

// Mapa de coordenadas generado (90 * 96 words big-endian).
std::vector<u8> generate_sphere_map();

// Offset de textura (16 bits) desde el mapa, con el sesgo $8000.
u16 sphere_offset(const std::vector<u8>& map, int row, int word);

// Renderiza un frame (192x90 índices de paleta 0..15) para la rotación dada.
// `texture` = 65536 bytes (0..15 por texel).
std::vector<u8> sphere_render(const std::vector<u8>& texture,
                              const std::vector<u8>& map, u16 rotation);

// Duplica cada fila (lo que hace el copper -> 192x180).
std::vector<u8> double_rows(const std::vector<u8>& frame);

}  // namespace rein

#endif  // REIN_SPHERE_HPP