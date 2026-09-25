#!/usr/bin/env python3
"""Extrae assets NES de un ROM iNES: cabecera, CHR (tiles 8x8, 2bpp) y paleta.

Uso: python tools/python/nes_assets.py <rom.nes> <outdir>

Salidas: <outdir>/<stem>_chr.png (tilesheet) y <stem>_assets.json.
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from retro_img import tilesheet_png

# Paleta 2C02 aproximada (64 colores), índices estándar NES.
NES_PALETTE = [
    (124, 124, 124), (0, 0, 252), (0, 0, 188), (68, 40, 188), (148, 0, 132), (168, 0, 32), (168, 16, 0), (136, 20, 0),
    (80, 48, 0), (0, 120, 0), (0, 104, 0), (0, 88, 0), (0, 64, 88), (0, 0, 0), (0, 0, 0), (0, 0, 0),
    (188, 188, 188), (0, 120, 248), (0, 88, 248), (104, 68, 248), (216, 0, 204), (228, 0, 88), (248, 56, 0), (228, 92, 16),
    (172, 124, 0), (0, 184, 0), (0, 168, 0), (0, 168, 68), (0, 136, 136), (0, 0, 0), (0, 0, 0), (0, 0, 0),
    (248, 248, 248), (60, 188, 252), (104, 136, 252), (152, 120, 248), (248, 120, 248), (248, 88, 152), (248, 120, 88), (252, 160, 68),
    (248, 184, 0), (184, 248, 24), (88, 216, 84), (88, 248, 152), (0, 232, 216), (120, 120, 120), (0, 0, 0), (0, 0, 0),
    (252, 252, 252), (164, 228, 252), (184, 184, 248), (208, 184, 248), (248, 184, 248), (248, 164, 192), (240, 208, 176), (252, 224, 168),
    (248, 216, 120), (216, 248, 120), (184, 248, 184), (184, 248, 216), (0, 252, 252), (248, 216, 248), (0, 0, 0), (0, 0, 0),
]


def parse_ines(data):
    if data[:4] != b'NES\x1a':
        raise ValueError('no es un ROM iNES')
    prg = data[4]
    chr_ = data[5]
    flags6 = data[6]
    flags7 = data[7]
    mapper = (flags7 & 0xF0) | (flags6 >> 4)
    trainer = 512 if (flags6 & 0x04) else 0
    offset = 16 + trainer
    prg_data = data[offset:offset + prg * 0x4000]
    chr_off = offset + prg * 0x4000
    chr_data = data[chr_off:chr_off + chr_ * 0x2000] if chr_ else b''
    return dict(prg_banks=prg, chr_banks=chr_, mapper=mapper, trainer=trainer,
                prg_bytes=len(prg_data), chr_bytes=len(chr_data)), prg_data, chr_data


def decode_chr(chr_data):
    tiles = []
    for t in range(len(chr_data) // 16):
        base = t * 16
        tile = []
        for row in range(8):
            p0 = chr_data[base + row]
            p1 = chr_data[base + 8 + row]
            for x in range(8):
                bit = 7 - x
                tile.append(((p0 >> bit) & 1) | (((p1 >> bit) & 1) << 1))
        tiles.append(tile)
    return tiles


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    rom = Path(sys.argv[1])
    outdir = Path(sys.argv[2])
    outdir.mkdir(parents=True, exist_ok=True)
    header, prg, chr_ = parse_ines(rom.read_bytes())
    (outdir / f'{rom.stem.replace(" ", "_")}_prg.bin').write_bytes(prg)
    tiles = decode_chr(chr_)
    # Paleta de render por defecto (BG: 0x0F,0x01,0x21,0x11).
    render_idx = [0x0F, 0x01, 0x21, 0x11]
    palette = [NES_PALETTE[i] for i in render_idx]
    stem = rom.stem.replace(' ', '_')
    png = outdir / f'{stem}_chr.png'
    w, h = tilesheet_png(str(png), tiles, 8, 8, palette, cols=16, scale=2)
    meta = dict(rom=str(rom), header=header, tiles=len(tiles), tile_size=[8, 8],
                tilesheet=dict(file=png.name, width=w, height=h, cols=16, scale=2),
                render_palette=render_idx)
    (outdir / f'{stem}_assets.json').write_text(json.dumps(meta, indent=2), encoding='utf-8')
    print(f'OK {rom.name}: {len(tiles)} tiles, {header["mapper"]=} -> {png}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
