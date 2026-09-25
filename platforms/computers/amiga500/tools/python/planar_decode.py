#!/usr/bin/env python3
"""planar_decode.py — Decodifica bitplanes OCS/ECS (Amiga) a imagen.

Formato planar clásico: cada plano es una imagen de 1 bit, `planes` planos por
línea, bytes contiguos por línea (el módulo entre líneas suele ser 0 en los
buffers de los demos, o `ancho_bytes`). Acepta paleta en formato de
`assets/palettes/*.json` (lista de "#rrggbb").

Uso:
  python planar_decode.py <bitplanes.bin> <planes> <width_px> <height> <paleta.json> [--out a.png]
  python planar_decode.py <bitplanes.bin> 5 320 200 paleta.json --out titulo.png

Opciones:
  --offset <bytes>     desplazamiento al inicio de la primera imagen
  --stride <bytes>     bytes por línea de TODOS los planos (def width*planes)
  --out <file.png>     salida PNG (requiere Pillow; si no, escribe PPM)
"""

import sys
import os
import json


def decode_planar(data, planes, width, height, offset=0, stride=None):
    """Devuelve bytearray de índices de color (width*height) o None si no hay datos."""
    wb = (width + 7) // 8
    if stride is None:
        stride = wb * planes
    need = offset + height * stride
    if need > len(data):
        return None
    px = bytearray(width * height)
    for y in range(height):
        base = offset + y * stride
        for x in range(width):
            idx = 0
            for p in range(planes):
                if data[base + p * wb + (x >> 3)] & (0x80 >> (x & 7)):
                    idx |= 1 << p
            px[y * width + x] = idx
    return px


def pal_to_rgb(pal):
    out = []
    for c in pal:
        c = c.lstrip("#")
        out.append((int(c[0:2], 16), int(c[2:4], 16), int(c[4:6], 16)))
    return out


def to_ppm(px, width, height, rgb):
    lines = [f"P3\n{width} {height}\n255\n"]
    for i in range(len(px)):
        r, g, b = rgb[px[i]] if px[i] < len(rgb) else (0, 0, 0)
        lines.append(f"{r} {g} {b}")
    return "\n".join(lines)


def main():
    args = sys.argv[1:]
    def get(flag, defv=None):
        i = args.index(flag) if flag in args else -1
        if i >= 0:
            return args[i + 1]
        return defv
    offset = int(get("--offset", "0"), 0)
    stride_s = get("--stride")
    out = get("--out")

    rest = [a for a in args if not a.startswith("--") or a in ("--out", "--offset", "--stride")]
    # rest contiene el argumento --out consumido arriba; filtrar
    rest = []
    skip = False
    for a in args:
        if skip:
            skip = False
            continue
        if a == "--out":
            skip = True
            continue
        if a == "--offset":
            skip = True
            continue
        if a == "--stride":
            skip = True
            continue
        if not a.startswith("--"):
            rest.append(a)

    if len(rest) < 5:
        print(__doc__)
        sys.exit(2)
    fn, planes, width, height, pal_fn = rest[0], int(rest[1]), int(rest[2]), int(rest[3]), rest[4]
    data = open(fn, "rb").read()
    pal = json.load(open(pal_fn))
    rgb = pal_to_rgb(pal)
    stride = int(stride_s, 0) if stride_s else None

    px = decode_planar(data, planes, width, height, offset, stride)
    if px is None:
        print(f"error: el fichero no llega a {offset + height * (stride or (width + 7) // 8 * planes)} B")
        sys.exit(1)

    try:
        from PIL import Image
        img = Image.new("RGB", (width, height))
        img.putdata([rgb[i] if i < len(rgb) else (0, 0, 0) for i in px])
        dest = out or (os.path.splitext(fn)[0] + ".png")
        img.save(dest)
        print(f"png -> {dest}")
    except ImportError:
        dest = out or (os.path.splitext(fn)[0] + ".ppm")
        open(dest, "w").write(to_ppm(px, width, height, rgb))
        print(f"ppm -> {dest} (instala Pillow para PNG)")


if __name__ == "__main__":
    main()