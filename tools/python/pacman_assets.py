#!/usr/bin/env python3
"""Extrae assets arcade de un romset MAME de Pac-Man (tiles 8x8 + PROMs de color).

Formato Namco Pac-Man: los gráficos son 2 planos de bits en `*.5e`/`*.5f`
(16 bytes por tile: 8 filas x 2 planos). Los colores reales salen de la PROM
`82s123.7f` + `82s126.4a` combinados con colorram en runtime; aquí se guardan
crudos y se renderiza con una paleta de 4 colores de referencia.

Uso: python tools/python/pacman_assets.py <pacman.zip> <outdir>
Salidas: <outdir>/pacman_tiles.png, <outdir>/pacman_assets.json
"""
import json
import sys
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from retro_img import tilesheet_png

# Paleta de referencia (índice 0..3). Sustituible decodificando las PROMs.
REF_PALETTE = [(0, 0, 0), (255, 255, 0), (255, 0, 0), (0, 200, 255)]


def pick(names, suffix):
    for n in sorted(names):
        if n.lower().endswith(suffix):
            return n
    return None


def decode(g0, g1):
    """g0=gfx plano bajo (*.5e), g1=plano alto (*.5f). Devuelve tiles 8x8 (idx color)."""
    tiles = []
    ntiles = min(len(g0), len(g1)) // 8
    for t in range(ntiles):
        tile = []
        for r in range(8):
            b0 = g0[t * 8 + r]
            b1 = g1[t * 8 + r]
            for x in range(8):
                bit = 7 - x
                tile.append(((b0 >> bit) & 1) | (((b1 >> bit) & 1) << 1))
        tiles.append(tile)
    return tiles


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    rom = Path(sys.argv[1])
    outdir = Path(sys.argv[2])
    outdir.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(rom) as z:
        names = z.namelist()
        g0n = pick(names, '.5e')
        g1n = pick(names, '.5f')
        if not g0n or not g1n:
            print('ERROR: no encuentro los gráficos *.5e/*.5f', file=sys.stderr)
            return 3
        g0 = z.read(g0n)
        g1 = z.read(g1n)
        proms = {n: z.read(n).hex() for n in names if n.endswith(('.7f', '.4a'))}
        files = {i.filename: i.file_size for i in z.infolist()}
        # Programa Z80 (16 KB): 6e,6f,6h,6j en orden.
        prog = b''
        for suffix in ('.6e', '.6f', '.6h', '.6j'):
            n = pick(names, suffix)
            if n:
                prog += z.read(n)
    (outdir / 'pacman_program.bin').write_bytes(prog)

    tiles = decode(g0, g1)
    png = outdir / 'pacman_tiles.png'
    w, h = tilesheet_png(str(png), tiles, 8, 8, REF_PALETTE, cols=16, scale=2)
    meta = dict(rom=str(rom), files=files, gfx_planes=[g0n, g1n],
                tiles=len(tiles), tile_size=[8, 8],
                tilesheet=dict(file=png.name, width=w, height=h, cols=16, scale=2),
                reference_palette=REF_PALETTE, color_proms=proms,
                note='color final = PROM 82s123/82s126 + colorram (pendiente de decode exacto)')
    (outdir / 'pacman_assets.json').write_text(json.dumps(meta, indent=2), encoding='utf-8')
    print(f'OK {rom.name}: {len(tiles)} tiles, PROMs {list(proms)} -> {png}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
