"""Escritura de imágenes sin dependencias externas (PNG RGB y PPM)."""
import struct
import zlib


def write_png_rgb(path, width, height, rgb):
    """rgb: bytes de longitud width*height*3 (filas de arriba a abajo)."""
    stride = width * 3
    raw = bytearray()
    for y in range(height):
        raw.append(0)  # filtro 0
        raw += rgb[y * stride:(y + 1) * stride]

    def chunk(tag, data):
        return (struct.pack('>I', len(data)) + tag + data +
                struct.pack('>I', zlib.crc32(tag + data) & 0xffffffff))

    out = b'\x89PNG\r\n\x1a\n'
    out += chunk(b'IHDR', struct.pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0))
    out += chunk(b'IDAT', zlib.compress(bytes(raw), 9))
    out += chunk(b'IEND', b'')
    with open(path, 'wb') as f:
        f.write(out)


def write_ppm_rgb(path, width, height, rgb):
    with open(path, 'wb') as f:
        f.write(f'P6\n{width} {height}\n255\n'.encode())
        f.write(rgb)


def tilesheet_png(path, tiles, tile_w, tile_h, palette, cols=16, scale=2):
    """tiles: lista de tiles, cada uno lista de índices de color (tile_w*tile_h)."""
    rows = (len(tiles) + cols - 1) // cols
    width = cols * tile_w * scale
    height = rows * tile_h * scale
    rgb = bytearray(width * height * 3)
    for i, tile in enumerate(tiles):
        cx = (i % cols) * tile_w * scale
        cy = (i // cols) * tile_h * scale
        for y in range(tile_h):
            for x in range(tile_w):
                idx = tile[y * tile_w + x] % len(palette)
                r, g, b = palette[idx]
                for sy in range(scale):
                    for sx in range(scale):
                        o = ((cy + y * scale + sy) * width + (cx + x * scale + sx)) * 3
                        rgb[o:o + 3] = bytes((r, g, b))
    write_png_rgb(path, width, height, bytes(rgb))
    return width, height
