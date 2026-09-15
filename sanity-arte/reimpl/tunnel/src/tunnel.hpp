#ifndef REIN_TUNNEL_HPP
#define REIN_TUNNEL_HPP

// reimpl/tunnel — túnel bitmap raytraced de «Arte» (Sanity, 1993).
//
// Recreación en C++ del efecto "Bitmap Tunnel" a partir del código de referencia
// de Anders Tornblad (remake JS "artsy", ver SOURCE) y de los assets reales
// recuperados (tunnelBits / tunnelWall / tunnelHanger).
//
// Técnica (confianza ALTA para la mecánica, MEDIA para los parámetros exactos de
// la demo original): por cada fila de pantalla se lanza un rayo desde el foco,
// se interseca con el plano del suelo (y = a*z + b) o del techo, y se calcula
// la Z de la pared. Con la Z se obtiene el factor de perspectiva y se mapea una
// textura de bits (tunnelBits) al ancho de la fila, atenuada por la distancia
// (alpha = 1 - z/500). El "avance" dentro del túnel es sumar time/velocidad a
// la coordenada Y de textura; el script de suelo/techo (floorScript/ceilingScript)
// selecciona el tile de la textura según la profundidad.

#include <cstdint>
#include <vector>

namespace rein {

using u8 = std::uint8_t;

constexpr int kTunnelWidth = 320;   // ancho del target (se escala a 640 en la demo)
constexpr int kTunnelHeight = 192;  // alto del target ((512-128)/2)
constexpr int kTunnelSpeed = 2;     // factor de velocidad (velocidad Z = 1/factor)
constexpr int kHangingWallDistance = 120;

struct TunnelAssets {
    std::vector<u8> bits;    // textura: 80x30 RGBA (4 tiles "a".."d" de 20 px)
    std::vector<u8> wall;    // pared del fondo: 128x64 RGBA
    std::vector<u8> hanger;  // colgantes del techo: 160x30 RGBA
    int bitsW = 80;
    int bitsH = 30;
};

// Offsets de tile por posición del script (-1 = hueco, sin dibujar).
struct TunnelOffsets {
    std::vector<int> floorOff;
    std::vector<int> ceilingOff;
};

// Precalcula los offsets a partir de floorScript/ceilingScript.
TunnelOffsets tunnel_offsets();

// Render del túnel a `time` ms. Devuelve kTunnelWidth*kTunnelHeight*4 bytes RGBA.
std::vector<u8> render_tunnel(const TunnelAssets& a, const TunnelOffsets& off, double time);

// Compositing del "canvas" completo (como el JS): 640x512 con las bandasde fondo
// (#350000 / #46051e) y el túnel escalado 2x en y=64. Reduce el negro respecto al
// original capturado (corridor-live.png). Devuelve 640*512*4 bytes RGBA.
constexpr int kCanvasWidth = 640;
constexpr int kCanvasHeight = 512;
std::vector<u8> render_tunnel_canvas(const TunnelAssets& a, const TunnelOffsets& off, double time);

}  // namespace rein

#endif  // REIN_TUNNEL_HPP
