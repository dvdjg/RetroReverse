// reimpl/tunnel — túnel bitmap raytraced de «Arte» (Sanity, 1993).
// Núcleo del render + overlay (pared del fondo y colgantes del techo).
// Puertos fieles a bitmap-tunnel-scene.js.

#include "tunnel.hpp"

#include <cmath>

namespace rein {

static const char* kFloorScript =
    "    aaa aaaabbbb ccdccaabbccccbddddaaaaaabbbabccdda abdbccdccc    "
    "caaabbbbbaaabbbb ccccaabbccccbdaaabbcccdaaa aaaabbbbaaabbcccdaaabbabbcab";
static const char* kCeilingScript =
    "    aaa aabbccddadddddaabbccdd abaabbcccdaaa aacaabbbb ccccbbb    cc "
    "ddddaaddddaaaaaabbbbccdda abccccaabbccccbddddaaaaaabbccddadddddaabbcc";

static constexpr double kPi = 3.14159265358979323846;

static double sinus_tab(int i) {
    i &= 0xffff;
    return std::sin(i / 65536.0 * 2.0 * kPi);
}

static double smooth(double complete) {
    return (1.0 - std::cos(complete * kPi)) / 2.0;
}

TunnelOffsets tunnel_offsets() {
    TunnelOffsets o;
    for (const char* p = kFloorScript; *p; ++p)
        o.floorOff.push_back(*p == ' ' ? -1 : (*p - 'a') * 20);
    for (const char* p = kCeilingScript; *p; ++p)
        o.ceilingOff.push_back(*p == ' ' ? -1 : (*p - 'a') * 20);
    return o;
}

// ---- overlay ----

struct HangingWall {
    double topY, minX, maxX, height, alpha;
};

static void fill_black(std::vector<u8>& dst, int dw, int dh, int x, int y, int w, int h) {
    for (int yy = y; yy < y + h; ++yy) {
        if (yy < 0 || yy >= dh) continue;
        for (int xx = x; xx < x + w; ++xx) {
            if (xx < 0 || xx >= dw) continue;
            u8* d = &dst[((std::size_t)yy * dw + xx) * 4];
            d[0] = d[1] = d[2] = 0;
            d[3] = 255;
        }
    }
}

// Escala (nearest-neighbour, como imageSmoothingEnabled=false) y compone con alpha.
static void blit_scaled(std::vector<u8>& dst, int dw, int dh, const std::vector<u8>& src, int sw,
                        int sh, int dx, int dy, int dwei, int dhei, double alpha) {
    if (dwei <= 0 || dhei <= 0 || sw <= 0 || sh <= 0) return;
    for (int y = 0; y < dhei; ++y) {
        const int ty = dy + y;
        if (ty < 0 || ty >= dh) continue;
        int sy = (int)((double)y * sh / dhei);
        if (sy < 0) sy = 0;
        if (sy >= sh) sy = sh - 1;
        for (int x = 0; x < dwei; ++x) {
            const int tx = dx + x;
            if (tx < 0 || tx >= dw) continue;
            int sx = (int)((double)x * sw / dwei);
            if (sx < 0) sx = 0;
            if (sx >= sw) sx = sw - 1;
            const u8* s = &src[((std::size_t)sy * sw + sx) * 4];
            u8* d = &dst[((std::size_t)ty * dw + tx) * 4];
            const double a = alpha * (s[3] / 255.0);
            d[0] = (u8)(s[0] * a + d[0] * (1.0 - a));
            d[1] = (u8)(s[1] * a + d[1] * (1.0 - a));
            d[2] = (u8)(s[2] * a + d[2] * (1.0 - a));
            d[3] = 255;
        }
    }
}

std::vector<u8> render_tunnel(const TunnelAssets& a, const TunnelOffsets& off, double time) {
    const int W = kTunnelWidth, H = kTunnelHeight;
    std::vector<u8> out((std::size_t)W * H * 4, 0);

    const double halfW = W / 2.0;
    const double halfH = H / 2.0;
    const double maxY = halfH;

    // ---- guiño lateral (veer) ----
    double veerOffset = time - 15490.0;
    double veer = 0.0;
    if (veerOffset > 0.0) {
        if (veerOffset < (16384.0 / 5.0))
            veerOffset = (16384.0 / 5.0) * smooth(veerOffset / 16384.0 * 5.0);
        veer = 0.25 * sinus_tab((int)(veerOffset * 5.0));
    }

    // ---- geometría del túnel ----
    const double zFocus = -150.0, yFocus = 0.0, zScreen = -100.0, zFloor = 0.0;
    const double yFloor = 288.0, yCeiling = -288.0;

    double slopeOffset = time - 5000.0;
    if (slopeOffset < 0.0) slopeOffset = 0.0;
    const double trueSlope = sinus_tab((int)(slopeOffset * 7.0)) * 1.5;

    const double millisUntilEnd = 30720.0 - time;
    if (millisUntilEnd < 0.0) return out;  // efecto terminado
    const double millisUntilMid = 15360.0 - time;
    const double millisUntilWall = millisUntilMid > 0.0 ? millisUntilMid : millisUntilEnd;
    const double distanceToWallZ = millisUntilWall / kTunnelSpeed;
    const bool showWall = (distanceToWallZ < 500.0 && distanceToWallZ > 0.0);

    double nextHangingWallZ =
        (time > 16500.0) ? (1100.0 - std::fmod(time / kTunnelSpeed, 1600.0)) : 20000.0;
    int maxHangingWallIterations = 4;
    while (nextHangingWallZ < 0.0) {
        --maxHangingWallIterations;
        nextHangingWallZ += kHangingWallDistance;
    }

    std::vector<HangingWall> hangingWalls;
    double wallMinY = maxY, wallMaxY = -maxY, wallMinX = 0.0, wallMaxX = 0.0;

    int targetIndex = 0;
    for (double y = -maxY; y <= maxY; y += 1.0) {
        if (y == 0.0) continue;

        const double slope = (trueSlope * std::fabs(y) / maxY + trueSlope) / 2.0;
        const double kk = y / (zScreen - zFocus);
        const double mm = y + (zFloor - zScreen) / (zScreen - zFocus) * (y - yFocus);

        double z = (yFloor - mm) / (kk - slope);
        const bool upsideDown = (z < 0.0);
        if (upsideDown) z = (yCeiling - mm) / (kk - slope);

        const std::vector<int>& offsets = upsideDown ? off.ceilingOff : off.floorOff;
        const double inverseZFactor = (z - zFocus) / (-zFocus);

        if (upsideDown && z > nextHangingWallZ && z < 500.0 &&
            (!showWall || z < distanceToWallZ) && maxHangingWallIterations > 0) {
            HangingWall hw;
            hw.topY = y;
            hw.minX = (-halfW / inverseZFactor) - z * veer;
            hw.maxX = (halfW / inverseZFactor) - z * veer;
            hw.height = 100.0 / inverseZFactor;
            hw.alpha = 1.0 - z / 500.0;
            hangingWalls.push_back(hw);
            nextHangingWallZ += kHangingWallDistance;
            --maxHangingWallIterations;
        }

        int tileBitmapOffsetX = -1;
        double veerX = 0.0;
        int bitmapY = 0;
        int alpha8bit = 0;
        if (showWall && z > distanceToWallZ) {
            if (y < wallMinY) wallMinY = y;
            if (y > wallMaxY) {
                wallMaxY = y;
                wallMinX = (-halfW / inverseZFactor) - distanceToWallZ * veer;
                wallMaxX = (halfW / inverseZFactor) - distanceToWallZ * veer;
            }
        } else if (z < 500.0) {
            const double trueY = z + time / kTunnelSpeed;
            alpha8bit = ((int)((1.0 - z / 500.0) * 256.0)) & 0x1ff;
            veerX = z * veer;
            const int tileScriptPos = ((int)(trueY / a.bitsH / 4.0)) & 0xff;
            tileBitmapOffsetX =
                (tileScriptPos >= 0 && tileScriptPos < (int)offsets.size()) ? offsets[tileScriptPos]
                                                                            : -1;
            bitmapY = ((int)trueY % a.bitsH) & 0xff;
        }

        const double minScreenX = (-halfW / inverseZFactor) - veerX;
        const double maxScreenX = (halfW / inverseZFactor) - veerX;

        for (double xd = -halfW; xd < halfW; xd += 1.0) {
            u8* px = &out[targetIndex];
            if (xd < minScreenX || xd > maxScreenX || tileBitmapOffsetX < 0) {
                px[0] = 0; px[1] = 0; px[2] = 0;
            } else {
                const double trueX = (xd + veerX) * inverseZFactor;
                const int bitmapX = ((((int)(trueX + halfW)) >> 1) % 20) & 0xfff;
                const int sourceIndex = (bitmapY * a.bitsW + bitmapX + tileBitmapOffsetX) * 4;
                px[0] = (u8)(a.bits[sourceIndex] * alpha8bit >> 8);
                px[1] = (u8)(a.bits[sourceIndex + 1] * alpha8bit >> 8);
                px[2] = (u8)(a.bits[sourceIndex + 2] * alpha8bit >> 8);
            }
            px[3] = 255;
            targetIndex += 4;
        }
    }

    // ---- overlay: pared del fondo ----
    if (showWall) {
        const double ga = 1.0 - distanceToWallZ / 500.0;
        const int x = (int)(wallMinX + halfW);
        const int yw = (int)(wallMinY + halfH);
        const int ww = (int)(wallMaxX - wallMinX);
        const int wh = (int)(wallMaxY - wallMinY);
        blit_scaled(out, W, H, a.wall, 128, 64, x, yw, ww, wh, ga);
    }

    // ---- overlay: colgantes del techo (de atrás hacia delante) ----
    for (std::size_t i = hangingWalls.size(); i-- > 0;) {
        const HangingWall& hw = hangingWalls[i];
        const int l = (int)(hw.minX + halfW);
        const int w = (int)(hw.maxX - hw.minX);
        const int t = (int)(hw.topY + halfH);
        const int h = (int)hw.height;
        fill_black(out, W, H, l, t, w, h);
        blit_scaled(out, W, H, a.hanger, 160, 30, l, t, w, h, hw.alpha);
    }

    return out;
}

}  // namespace rein
