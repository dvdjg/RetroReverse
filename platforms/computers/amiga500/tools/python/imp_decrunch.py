#!/usr/bin/env python3
"""imp_decrunch.py — Decruncher del formato "IMP!" (File Imploder) de la demo Sanity-Arte.

ESTADO: FUNCIONAL vía `ancient` (temisu/ancient, compilado en platforms/computers/amiga500/tools/bin/ancient).
El port Python de abajo es WIP/referencia. El formato IMP! = File Imploder de la
escena Amiga (firma 0x494D5021, clones ATN!/EDAM/M.H.). Sanity usa IMP! SIN
checksum estándar (en ancient: addition=0). Ver LECCIONES_APRENDIDAS.md.

Uso (recomendado, vía ancient):
  python imp_decrunch.py --ancient <adf> <offset-hex-de-IMP!> [--out <dest.bin>]
Uso (port Python WIP):
  python imp_decrunch.py <adf> <offset-hex-de-IMP!> [--out <dest.bin>]

Formato:
  [0x00] "IMP!" (o clon)
  [0x04] rawSize (tamaño descomprimido) — long BE
  [0x08] endOffset (fin de datos comprimidos) — long BE, siempre par
  [0x0C .. endOffset) stream comprimido
  [endOffset+0x00] 3 longs (long3, long2, long1)  -> cabecera "reordenada"
  [endOffset+0x0C] litLength inicial (long BE)
  [endOffset+0x10] markerByte (1B)
  [endOffset+0x11] anchor halfByte (1B)
  [endOffset+0x12] tabla distancias: 8 words BE (16 B)
  [endOffset+0x22] tabla extra bits: 12 bytes
  [endOffset+0x2E] checksum (long BE, addition=7 para IMP!)

Uso:
  python imp_decrunch.py <adf> <offset-hex-de-IMP!> [--out <dest.bin>]
"""

import sys


def u16(b, o): return b[o] << 8 | b[o + 1]
def u32(b, o): return (b[o] << 24) | (b[o + 1] << 16) | (b[o + 2] << 8) | b[o + 3]


class IMPInputStream:
    """Stream hacia atrás con el 'funny ordering' de los primeros 12 bytes.
    Trabaja con offsets RELATIVOS al bloque; `base` es el offset del bloque en
    el fichero (para acceder al buffer)."""

    __slots__ = ("buffer", "base", "currentOffset", "endOffset", "refOffset")

    def __init__(self, buffer, base, startOffset, endOffset):
        self.buffer = buffer
        self.base = base
        self.currentOffset = endOffset
        self.endOffset = startOffset
        self.refOffset = endOffset

    def sourceOffset(self, i):
        if i >= 12:
            return i
        if i < 4:
            return i + self.refOffset + 8
        if i < 8:
            return i + self.refOffset
        return i + self.refOffset - 8

    def readByte(self):
        if self.currentOffset <= self.endOffset:
            raise ValueError("IMP: eof al leer byte")
        self.currentOffset -= 1
        return self.buffer[self.base + self.sourceOffset(self.currentOffset)]

    def eof(self):
        return self.currentOffset == self.endOffset


class MSBBitReader:
    """Lee bits MSB-first; recarga byte del stream cuando se agota."""

    __slots__ = ("stream", "bitBuffer", "bitCount")

    def __init__(self, stream):
        self.stream = stream
        self.bitBuffer = 0
        self.bitCount = 0

    def reset(self, value, count):
        self.bitBuffer = value
        self.bitCount = count

    def readBits8(self, count):
        val = 0
        for _ in range(count):
            if self.bitCount == 0:
                self.bitBuffer = self.stream.readByte()
                self.bitCount = 8
            self.bitCount -= 1
            val = (val << 1) | ((self.bitBuffer >> self.bitCount) & 1)
        return val


# Tabla Huffman estática de la longitud (lldDecoder)
LLD = {  # code, bits -> valor
    0b0: 0,        # 1 bit   '0'
    0b10: 1,       # 2 bits  '10'
    0b110: 2,      # 3 bits  '110'
    0b1110: 3,     # 4 bits  '1110'
    0b11110: 4,    # 5 bits  '11110'
    0b11111: 5,    # 5 bits  '11111'
}
LLD_BITS = {0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 5}

LLD2 = {  # lldDecoder2
    0b0: 0,   # '0'
    0b10: 1,  # '10'
    0b11: 2,  # '11'
}
LLD2_BITS = {0: 1, 1: 2, 2: 2}

LITERAL_LENGTHS = [6, 10, 10, 18]
LITERAL_BITS = [
    [1, 1, 1, 1],
    [2, 3, 3, 4],
    [4, 5, 7, 14],
]


def decode_ll(bitreader):
    """Decodifica lldDecoder (intertwined): devuelve (selector, count)."""
    val = 0
    bits = 0
    got = None
    while got is None:
        b = bitreader.readBits8(1)
        val = (val << 1) | b
        bits += 1
        if val in LLD and bits == LLD_BITS[LLD[val]]:
            got = LLD[val]
    selector = got if got < 4 else 3
    count = got + 2
    if count == 6:
        count += bitreader.readBits8(3)
    elif count == 7:
        count = bitreader.readBits8(8)
        if not count:
            raise ValueError("IMP: match_len=0")
    return selector, count


def decode_ll2(bitreader):
    """Decodifica lldDecoder2."""
    val = 0
    bits = 0
    got = None
    while got is None:
        b = bitreader.readBits8(1)
        val = (val << 1) | b
        bits += 1
        if val in LLD2 and bits == LLD2_BITS[LLD2[val]]:
            got = LLD2[val]
    return got


def decrunch(data, start):
    """Descomprime el bloque IMP! que empieza en `start` de `data`.

    Devuelve los bytes descomprimidos (rawSize de longitud).
    """
    if data[start:start + 4] != b"IMP!":
        raise ValueError("no IMP! en start")
    raw_size = u32(data, start + 4)
    end_offset = u32(data, start + 8)
    if end_offset & 1:
        raise ValueError("endOffset impar")

    # --- input stream con funny ordering (offsets relativos al bloque) ---
    stream = IMPInputStream(data, start, 0, end_offset)

    # --- inicializar bit reader: anchor bit en endOffset+17 ---
    bitreader = MSBBitReader(stream)
    half_byte = data[start + end_offset + 17]
    for i in range(7):
        if half_byte & (1 << i):
            bitreader.reset(half_byte >> (i + 1), 7 - i)
            break

    # --- tablas de distancia desde endOffset+18 ---
    distance_values = [[0] * 4 for _ in range(2)]
    for i in range(8):
        distance_values[i >> 2][i & 3] = u16(data, start + end_offset + 18 + i * 2)
    distance_bits = [[0] * 4 for _ in range(3)]
    for i in range(12):
        distance_bits[i >> 2][i & 3] = data[start + end_offset + 34 + i]

    # --- output: decrunch in-place sobre el bloque (el match puede leer del
    # origen comprimido más allá del destino, como hace el 68k) ---
    buf = bytearray(data)           # copia del bloque completo
    o = start + raw_size            # puntero de salida (absoluto en buf), decrece
    dst_start = start

    def write_byte(v):
        nonlocal o
        o -= 1
        buf[o] = v

    lit_length = u32(data, start + end_offset + 12)

    while True:
        for _ in range(lit_length):
            write_byte(stream.readByte())
        if o <= dst_start:
            break

        # intertwined Huffman
        selector, count = decode_ll(bitreader)

        i1 = decode_ll2(bitreader)
        ll = i1 + i1
        if ll == 4:
            ll = LITERAL_LENGTHS[selector]
        ll += bitreader.readBits8(LITERAL_BITS[i1][selector])

        i2 = decode_ll2(bitreader)
        distance = 1 + ((distance_values[i2 - 1][selector]) if i2 else 0) + \
            bitreader.readBits8(distance_bits[i2][selector])

        # copiar match: count bytes hacia atrás desde o+distance (in-place)
        src = o + distance
        for _ in range(count):
            src -= 1
            o -= 1
            buf[o] = buf[src]

        lit_length = ll

    return bytes(buf[dst_start:start + raw_size])


def main():
    args = sys.argv[1:]
    outfile = None
    use_ancient = False
    if args and args[0] == "--ancient":
        use_ancient = True
        args = args[1:]
    if args and args[0] == "--out":
        outfile = args[1]
        args = args[2:]
    if len(args) < 2:
        print(__doc__)
        sys.exit(2)
    fn, off_s = args[0], args[1]
    off = int(off_s, 0)
    data = bytearray(open(fn, "rb").read())
    if use_ancient:
        # usa platforms/computers/amiga500/tools/bin/ancient/ancient.exe (compilado, verificado)
        import subprocess, os
        eo = u32(data, off + 8)
        blk = bytes(data[off:off + eo + 0x32])
        tmp_in = os.path.join(os.environ.get("TEMP", "."), "imp_in.bin")
        tmp_out = os.path.join(os.environ.get("TEMP", "."), "imp_out.bin")
        open(tmp_in, "wb").write(blk)
        ancient = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "bin", "ancient", "ancient.exe")
        r = subprocess.run([ancient, "decompress", tmp_in, tmp_out], capture_output=True, text=True)
        if os.path.exists(tmp_out):
            result = open(tmp_out, "rb").read()
        else:
            raise RuntimeError(f"ancient fallo: {r.stderr[:200]}")
    else:
        result = decrunch(data, off)
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