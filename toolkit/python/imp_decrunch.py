#!/usr/bin/env python3
"""imp_decrunch.py — Decruncher del formato "IMP!" de la demo Sanity-Arte.

Port fiel del desensamblado del cruncher residente (RAM 0xC02426, hook IMP!).
El formato es LZH/backward: el bloque "IMP!" se descomprime hacia atrás (src y
dst decrecen). Validado con el par bloque 0x3242C del ADF <-> mod_2 (sos.library).

ESTADO: WIP — la logica del match (distancia/puntero) aun no reproduce los
bloques (falla con IndexError). La geometria del bloque (l1/l2/trailer) esta
confirmada por la coincidencia 12/12 con el hook; falta depurar la decodificacion
LZH de longitud/distancia y el puntero del match.

Uso:
  python imp_decrunch.py <adf> <offset-hex-de-IMP!>
  python imp_decrunch.py --out <dest.bin> <adf> <offset-hex>
"""

import sys


def u16(b, o): return b[o] << 8 | b[o + 1]
def u32(b, o): return (b[o] << 24) | (b[o + 1] << 16) | (b[o + 2] << 8) | b[o + 3]


class Bits:
    """Bit reader hacia atrás. Replica d3 del 68k (add.b d3,d3 / refill)."""

    __slots__ = ("src", "pos", "buf")

    def __init__(self, src, pos):
        self.src = src      # bytearray origen
        self.pos = pos      # índice (decrece)
        self.buf = 0        # buffer de 8 bits (d3)

    def _refill(self):
        # move.b -(a3),d3 ; addx.b d3,d3  (con d3=0 tras shift: d3 = byte<<1|X)
        self.pos -= 1
        b = self.src[self.pos]
        # X del último add.b era 0 (d3==0), así que addx = b<<1 | 0
        self.buf = (b << 1) & 0xFF

    def getbit(self):
        # add.b d3,d3 -> C = old bit7 ; d3 <<= 1
        bit = (self.buf >> 7) & 1
        self.buf = (self.buf << 1) & 0xFF
        if self.buf == 0:
            self._refill()
        return bit

    def getbyte(self):
        # move.b -(a3), dN : lee un byte crudo del origen (sin pasar por bit buffer)
        self.pos -= 1
        return self.src[self.pos]


def decrunch(blk, start):
    """Descomprime el bloque IMP! que empieza en `start`.

    `blk` es un bytearray de TODO el bloque (desde el header 16B o desde IMP!).
    Devuelve los bytes descomprimidos (l1 de longitud).
    """
    if blk[start:start + 4] != b"IMP!":
        raise ValueError("no IMP! en start")
    l1 = u32(blk, start + 4)   # destino  = start + l1
    l2 = u32(blk, start + 8)   # origen   = start + l2
    # a2 = a3 = start + l2 (origen fin)
    src_end = start + l2
    # --- trailer: 3 longs header, long d2, word d3, 28B tree ---
    p = src_end
    header = blk[p:p + 12]; p += 12
    d2 = u32(blk, p); p += 4
    d3 = u16(blk, p); p += 2
    tree = blk[p:p + 28]; p += 28

    # a3 = src_end ; si d3 (signed) >= 0 -> a3 -= 1
    src = src_end
    if not (d3 & 0x8000):
        src -= 1

    # --- tablas fijas del cruncher ---
    T0 = bytes([0x06, 0x0a, 0x0a, 0x12, 0x01, 0x01, 0x01, 0x01])  # 0xC02574
    T1 = bytes([0x01, 0x01, 0x01, 0x01, 0x02, 0x03, 0x03, 0x04, 0x04, 0x05, 0x07, 0x0e])  # 0xC02578

    # --- estado ---
    dst = start + l1        # a4 (destino, decrece)
    dst_start = start
    bits = Bits(blk, src)

    # buffer de salida
    out = bytearray(l1)
    # header al inicio
    out[0:12] = header

    def wbyte(srcpos, dstpos):
        # move.b -(aX),-(a4): ambos decrecen antes de copiar
        pass

    # bucle principal
    # d4 = 0
    while True:
        # copia directa: d2 veces move.b -(a3),-(a4)
        while d2:
            src -= 1
            dst -= 1
            out[dst - dst_start] = blk[src]
            d2 -= 1
        # cmpa.l a4,a0 ; bcs -> decodificar ; si a4 <= a0 -> fin
        if dst <= dst_start:
            break
        # --- decodificar longitud (0xC0247E) ---
        if bits.getbit() == 0:          # bcc
            d4 = 2; d0 = 0
        elif bits.getbit() == 0:
            d4 = 3; d0 = 1
        elif bits.getbit() == 0:
            d4 = 4; d0 = 2
        elif bits.getbit() == 0:
            d4 = 5; d0 = 3
        elif bits.getbit() == 0:
            d4 = bits.getbyte(); d0 = 3          # longitud literal
        else:
            # 3 bits -> d4 = 6 + valor
            d4 = 6
            for _ in range(3):
                d4 = (d4 << 1) | bits.getbit()
            d4 &= 0xFF
            d0 = 3

        # --- decodificar distancia (0xC024F0) ---
        d5 = 0
        d1 = d0
        if bits.getbit() == 0:          # bcc -> 0xC02514 directo
            pass
        elif bits.getbit() == 0:        # 0xC02506 bcc
            d5 = 2
            d0 += 4
        else:
            d5 = T0[d0]                 # move.b $c02574(pc,d0.w),d5
            d0 += 8
        # 0xC02514: d0 = T1[d0]
        d0 = T1[d0]
        # lee d0 bits -> d2
        d2 = 0
        for _ in range(d0):
            d2 = (d2 << 1) | bits.getbit()
        d2 += d5

        # --- construir puntero de match (0xC02528+) ---
        d5 = 0
        a2 = 0
        d0 = d1
        if bits.getbit() == 0:          # bcc -> 0xC02552
            pass
        else:
            d1 += d1                    # add.w d1,d1
            if bits.getbit() == 0:      # bcc -> movea.w (a1,d1.w)
                a2 = u16(tree, d1)      # (a1,d1.w)
                d0 += 4
            else:
                a2 = u16(tree, d1 + 8)  # $8(a1,d1.w)
                d0 += 8
        # 0xC02552: d0 = tree[0x10 + d0]
        d0 = tree[0x10 + d0]
        # lee d0 bits -> d5 (addx.l d5,d5)
        d5 = 0
        for _ in range(d0):
            d5 = (d5 << 1) | bits.getbit()
        a2 = (a2 + 1 + d5) & 0xFFFFFFFF
        a2_abs = dst + a2               # a2 += a4
        # copiar d4 bytes: move.b -(a2),-(a4)
        for _ in range(d4):
            a2_abs -= 1
            dst -= 1
            out[dst - dst_start] = out[a2_abs - dst_start]
        # d2 sigue siendo la distancia -> se usa como longitud de copia directa

    return bytes(out)


def main():
    args = sys.argv[1:]
    outfile = None
    if args and args[0] == "--out":
        outfile = args[1]; args = args[2:]
    if len(args) < 2:
        print(__doc__)
        sys.exit(2)
    fn, off_s = args[0], args[1]
    off = int(off_s, 0)
    blk = bytearray(open(fn, "rb").read())
    result = decrunch(blk, off)
    print(f"descomprimido {len(result)} bytes")
    if outfile:
        open(outfile, "wb").write(result)
        print(f"-> {outfile}")
    else:
        import hashlib
        print("sha1:", hashlib.sha1(result).hexdigest())
        print("primeros 32B:", result[:32].hex(" "))


if __name__ == "__main__":
    main()