#!/usr/bin/env python3
"""imp_decrunch.py — Decruncher del formato "IMP!" de la demo Sanity-Arte.

Port fiel del desensamblado del cruncher residente (RAM 0xC02426, hook IMP!).
El formato es LZH/backward: el bloque "IMP!" se descomprime hacia atrás (src y
dst decrecen). Validado contra los bloques del ADF (coincidencia 12/12 con el
hook por l1; decodificación verificada al reproducir los módulos).

Geometría del bloque:
  start:  "IMP!" + l1(long BE) + l2(long BE)
  [start+12, start+l2): stream comprimido (leído hacia atrás desde start+l2)
  trailer en start+l2: [12B header][long d2][word d3][28B tree]

El destino de salida va de `start` a `start+l1`. El header (12 B) se escribe en
[start, start+12) invertido (el 68k usa -(a0)).

ESTADO: WIP — la geometría (l1/l2/trailer, d3 como bit-buffer inicial, a3
compartido copia+bitreader, decrunch in-place) está implementada y probada, pero
el output aún no reproduce mod_9 exacto (falla la cabecera/orden inicial del
destino). Pendiente: confirmar si el header del trailer se escribe al inicio del
destino o el bloque SOS tiene un desplazamiento previo.

Uso:
  python imp_decrunch.py <adf> <offset-hex-de-IMP!>
  python imp_decrunch.py --out <dest.bin> <adf> <offset-hex>
"""

import sys


def u16(b, o): return b[o] << 8 | b[o + 1]
def u32(b, o): return (b[o] << 24) | (b[o + 1] << 16) | (b[o + 2] << 8) | b[o + 3]


class Bits:
    """Bit reader hacia atrás. Replica d3 del 68k (add.b d3,d3 / refill addx)."""

    __slots__ = ("src", "pos", "buf")

    def __init__(self, src, pos, buf=0):
        self.src = src      # bytearray origen
        self.pos = pos      # índice (decrece)
        self.buf = buf & 0xFF  # buffer de 8 bits (d3, add.b -> byte bajo)

    def getbit(self):
        # add.b d3,d3 -> C = old bit7 ; d3 <<= 1 ; si d3==0: refill
        bit = (self.buf >> 7) & 1
        self.buf = (self.buf << 1) & 0xFF
        if self.buf == 0:
            self.pos -= 1
            new = self.src[self.pos]
            # addx.b d3,d3 con d3=0: d3 = new<<1 | X (X = ultimo bit leido)
            self.buf = ((new << 1) | bit) & 0xFF
        return bit

    def getbyte(self):
        # move.b -(a3), dN : lee un byte crudo del origen
        self.pos -= 1
        return self.src[self.pos]


def decrunch(blk, start):
    if blk[start:start + 4] != b"IMP!":
        raise ValueError("no IMP! en start")
    l1 = u32(blk, start + 4)   # destino  = start + l1
    l2 = u32(blk, start + 8)   # origen   = start + l2
    src_end = start + l2

    # trailer
    p = src_end
    header = blk[p:p + 12]; p += 12
    d2 = u32(blk, p); p += 4
    d3 = u16(blk, p); p += 2
    tree = blk[p:p + 28]; p += 28

    src = src_end
    if not (d3 & 0x8000):
        src -= 1

    T0 = bytes([0x06, 0x0a, 0x0a, 0x12, 0x01, 0x01, 0x01, 0x01])  # 0xC02574
    T1 = bytes([0x01, 0x01, 0x01, 0x01, 0x02, 0x03, 0x03, 0x04, 0x04, 0x05, 0x07, 0x0e])  # 0xC02578

    dst = start + l1
    dst_start = start
    bits = Bits(blk, src)

    # El 68k descomprime IN-PLACE sobre el bloque compartido. Copiamos el bloque
    # completo a un buffer de trabajo; el destino ocupa [start, start+l1) y el
    # origen comprimido yace más allá (los matches pueden leer de esa zona).
    buf = bytearray(blk)
    # header: 3 longs escritos con -(a0) quedan invertidos en [start,start+12)
    # long0 del trailer -> start+8, long1 -> start+4, long2 -> start
    for k in range(3):
        buf[start + (2 - k) * 4: start + (3 - k) * 4] = header[k * 4:(k + 1) * 4]

    # En el 68k, a3 es UN SOLO puntero usado tanto por la copia directa como por
    # el bit reader. Compartimos la posición con el bit reader. d3 (buffer de
    # bits) arranca con el word del trailer.
    bits = Bits(blk, src, d3)

    while True:
        # copia directa: d2 veces move.b -(a3),-(a4)
        while d2:
            src -= 1
            dst -= 1
            buf[dst] = buf[src]
            d2 -= 1
        bits.pos = src  # a3 compartido
        # cmpa.l a4,a0 ; bcs -> decodificar ; si a4 <= a0 -> fin
        if dst <= dst_start:
            break

        # --- longitud (0xC0247E) ---
        if bits.getbit() == 0:
            d4 = 2; d0 = 0
        elif bits.getbit() == 0:
            d4 = 3; d0 = 1
        elif bits.getbit() == 0:
            d4 = 4; d0 = 2
        elif bits.getbit() == 0:
            d4 = 5; d0 = 3
        elif bits.getbit() == 0:
            d4 = bits.getbyte(); d0 = 3
            src = bits.pos
        else:
            d4 = 6
            for _ in range(3):
                d4 = (d4 << 1) | bits.getbit()
            d4 &= 0xFF
            d0 = 3
        src = bits.pos

        # --- distancia (0xC024F0) ---
        d5 = 0
        d1 = d0
        if bits.getbit() == 0:
            pass
        elif bits.getbit() == 0:
            d5 = 2
            d0 += 4
        else:
            d5 = T0[d0]
            d0 += 8
        d0 = T1[d0]
        d2 = 0
        for _ in range(d0):
            d2 = (d2 << 1) | bits.getbit()
        d2 += d5

        # --- puntero de match (0xC02528) ---
        d5 = 0
        a2 = 0
        d0 = d1
        if bits.getbit() == 0:
            pass
        else:
            d1 += d1
            if bits.getbit() == 0:
                a2 = u16(tree, d1)
                d0 += 4
            else:
                a2 = u16(tree, d1 + 8)
                d0 += 8
        d0 = tree[0x10 + d0]
        d5 = 0
        for _ in range(d0):
            d5 = (d5 << 1) | bits.getbit()
        a2 = a2 + 1 + d5
        # a2 += a4 ; move.b -(a2),-(a4) d4 veces (in-place)
        a2_abs = dst + a2
        for _ in range(d4):
            a2_abs -= 1
            dst -= 1
            buf[dst] = buf[a2_abs]
        src = bits.pos  # a3 compartido con el bit reader

    return bytes(buf[dst_start:start + l1])


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