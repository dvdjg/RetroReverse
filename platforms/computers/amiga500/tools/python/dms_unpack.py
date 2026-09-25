#!/usr/bin/env python3
"""Descompresor DMS (Disk Masher System) portado desde xDMS (WinUAE archivers/dms).

Soporta los modos NOCOMP, SIMPLE(RLE), QUICK, MEDIUM, DEEP, HEAVY1/HEAVY2.
Valida CRC de cabecera, CRC de pista, CRC de datos comprimidos y checksum
de datos descomprimidos, de modo que cada pista extraida es verificable.

Uso:
    python dms_unpack.py entrada.dms salida.adf [--verbose]
"""

from __future__ import annotations

import argparse
import struct
import sys

HEADLEN = 56
THLEN = 20
TRACK_BUFFER_LEN = 32000
TEXT_LEN = 0x3FC8
HD_STRIDE = 512 * 22

DMSFLAG_ENCRYPTED = 2
DMSFLAG_HD = 16

MASK_BITS = [
    0x000000, 0x000001, 0x000003, 0x000007, 0x00000F, 0x00001F,
    0x00003F, 0x00007F, 0x0000FF, 0x0001FF, 0x0003FF, 0x0007FF,
    0x000FFF, 0x001FFF, 0x003FFF, 0x007FFF, 0x00FFFF, 0x01FFFF,
    0x03FFFF, 0x07FFFF, 0x0FFFFF, 0x1FFFFF, 0x3FFFFF, 0x7FFFFF,
    0xFFFFFF,
]

D_CODE = [
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
    0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
    0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
    0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09,
    0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A,
    0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B,
    0x0C, 0x0C, 0x0C, 0x0C, 0x0D, 0x0D, 0x0D, 0x0D,
    0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x0F, 0x0F, 0x0F,
    0x10, 0x10, 0x10, 0x10, 0x11, 0x11, 0x11, 0x11,
    0x12, 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0x13,
    0x14, 0x14, 0x14, 0x14, 0x15, 0x15, 0x15, 0x15,
    0x16, 0x16, 0x16, 0x16, 0x17, 0x17, 0x17, 0x17,
    0x18, 0x18, 0x19, 0x19, 0x1A, 0x1A, 0x1B, 0x1B,
    0x1C, 0x1C, 0x1D, 0x1D, 0x1E, 0x1E, 0x1F, 0x1F,
    0x20, 0x20, 0x21, 0x21, 0x22, 0x22, 0x23, 0x23,
    0x24, 0x24, 0x25, 0x25, 0x26, 0x26, 0x27, 0x27,
    0x28, 0x28, 0x29, 0x29, 0x2A, 0x2A, 0x2B, 0x2B,
    0x2C, 0x2C, 0x2D, 0x2D, 0x2E, 0x2E, 0x2F, 0x2F,
    0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
    0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
]

D_LEN = [
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06, 0x06,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07, 0x07,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
    0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08, 0x08,
]

CRC_TAB = [
    0x0000, 0xC0C1, 0xC181, 0x0140, 0xC301, 0x03C0, 0x0280, 0xC241,
    0xC601, 0x06C0, 0x0780, 0xC741, 0x0500, 0xC5C1, 0xC481, 0x0440,
    0xCC01, 0x0CC0, 0x0D80, 0xCD41, 0x0F00, 0xCFC1, 0xCE81, 0x0E40,
    0x0A00, 0xCAC1, 0xCB81, 0x0B40, 0xC901, 0x09C0, 0x0880, 0xC841,
    0xD801, 0x18C0, 0x1980, 0xD941, 0x1B00, 0xDBC1, 0xDA81, 0x1A40,
    0x1E00, 0xDEC1, 0xDF81, 0x1F40, 0xDD01, 0x1DC0, 0x1C80, 0xDC41,
    0x1400, 0xD4C1, 0xD581, 0x1540, 0xD701, 0x17C0, 0x1680, 0xD641,
    0xD201, 0x12C0, 0x1380, 0xD341, 0x1100, 0xD1C1, 0xD081, 0x1040,
    0xF001, 0x30C0, 0x3180, 0xF141, 0x3300, 0xF3C1, 0xF281, 0x3240,
    0x3600, 0xF6C1, 0xF781, 0x3740, 0xF501, 0x35C0, 0x3480, 0xF441,
    0x3C00, 0xFCC1, 0xFD81, 0x3D40, 0xFF01, 0x3FC0, 0x3E80, 0xFE41,
    0xFA01, 0x3AC0, 0x3B80, 0xFB41, 0x3900, 0xF9C1, 0xF881, 0x3840,
    0x2800, 0xE8C1, 0xE981, 0x2940, 0xEB01, 0x2BC0, 0x2A80, 0xEA41,
    0xEE01, 0x2EC0, 0x2F80, 0xEF41, 0x2D00, 0xEDC1, 0xEC81, 0x2C40,
    0xE401, 0x24C0, 0x2580, 0xE541, 0x2700, 0xE7C1, 0xE681, 0x2640,
    0x2200, 0xE2C1, 0xE381, 0x2340, 0xE101, 0x21C0, 0x2080, 0xE041,
    0xA001, 0x60C0, 0x6180, 0xA141, 0x6300, 0xA3C1, 0xA281, 0x6240,
    0x6600, 0xA6C1, 0xA781, 0x6740, 0xA501, 0x65C0, 0x6480, 0xA441,
    0x6C00, 0xACC1, 0xAD81, 0x6D40, 0xAF01, 0x6FC0, 0x6E80, 0xAE41,
    0xAA01, 0x6AC0, 0x6B80, 0xAB41, 0x6900, 0xA9C1, 0xA881, 0x6840,
    0x7800, 0xB8C1, 0xB981, 0x7940, 0xBB01, 0x7BC0, 0x7A80, 0xBA41,
    0xBE01, 0x7EC0, 0x7F80, 0xBF41, 0x7D00, 0xBDC1, 0xBC81, 0x7C40,
    0xB401, 0x74C0, 0x7580, 0xB541, 0x7700, 0xB7C1, 0xB681, 0x7640,
    0x7200, 0xB2C1, 0xB381, 0x7340, 0xB101, 0x71C0, 0x7080, 0xB041,
    0x5000, 0x90C1, 0x9181, 0x5140, 0x9301, 0x53C0, 0x5280, 0x9241,
    0x9601, 0x56C0, 0x5780, 0x9741, 0x5500, 0x95C1, 0x9481, 0x5440,
    0x9C01, 0x5CC0, 0x5D80, 0x9D41, 0x5F00, 0x9FC1, 0x9E81, 0x5E40,
    0x5A00, 0x9AC1, 0x9B81, 0x5B40, 0x9901, 0x59C0, 0x5880, 0x9841,
    0x8801, 0x48C0, 0x4980, 0x8941, 0x4B00, 0x8BC1, 0x8A81, 0x4A40,
    0x4E00, 0x8EC1, 0x8F81, 0x4F40, 0x8D01, 0x4DC0, 0x4C80, 0x8C41,
    0x4400, 0x84C1, 0x8581, 0x4540, 0x8701, 0x47C0, 0x4680, 0x8641,
    0x8201, 0x42C0, 0x4380, 0x8341, 0x4100, 0x81C1, 0x8081, 0x4040,
]


def crc16(mem: bytes) -> int:
    crc = 0
    for b in mem:
        crc = (CRC_TAB[(crc ^ b) & 0xFF] ^ ((crc >> 8) & 0xFF)) & 0xFFFF
    return crc


def checksum16(mem: bytes) -> int:
    return sum(mem) & 0xFFFF


class DecodeError(Exception):
    pass


class BitReader:
    """Equivalente a getbits: bitbuf ULONG + bitcount UCHAR (MSB-first)."""

    def __init__(self, data: bytes):
        self.data = data
        self.pos = 0
        self.bitbuf = 0
        self.bitcount = 0
        self._drop(0)

    def _drop(self, n: int) -> None:
        self.bitcount -= n
        self.bitbuf &= MASK_BITS[self.bitcount]
        while self.bitcount < 16:
            if self.pos < len(self.data):
                self.bitbuf = ((self.bitbuf << 8) | self.data[self.pos]) & 0xFFFFFFFF
                self.pos += 1
            else:
                self.bitbuf = (self.bitbuf << 8) & 0xFFFFFFFF
            self.bitcount += 8

    def getbits(self, n: int) -> int:
        return (self.bitbuf >> (self.bitcount - n)) & 0xFFFFFFFF

    def dropbits(self, n: int) -> None:
        self._drop(n)


class DMSDecoder:
    def __init__(self, verbose: bool = False):
        self.verbose = verbose
        self.text = bytearray(TEXT_LEN)
        self.quick_loc = 0
        self.medium_loc = 0
        self.deep_loc = 0
        self.heavy_loc = 0
        self.init_deep_tabs = 1
        self.lastlen = 0
        self.np = 0
        # Deep (LZHUF dynamic huffman)
        N_CHAR = 256 - 2 + 60
        T = N_CHAR * 2 - 1
        self.N_CHAR = N_CHAR
        self.T = T
        self.R = T - 1
        self.freq = [0] * (T + 1)
        self.prnt = [0] * (T + N_CHAR)
        self.son = [0] * T
        # Heavy (LZH)
        self.c_len = [0] * 510
        self.pt_len = [0] * 20
        self.c_table = [0] * 4096
        self.pt_table = [0] * 256
        self.left = [0] * (2 * 510 - 1)
        self.right = [0] * (2 * 510 - 1 + 9)

    # ---- estado global ----

    def init_decrunchers(self) -> None:
        self.quick_loc = 251
        self.medium_loc = 0x3FBE
        self.heavy_loc = 0
        self.deep_loc = 0x3FC4
        self.init_deep_tabs = 1
        self.text = bytearray(TEXT_LEN)
        self.lastlen = 0
        self.np = 0

    # ---- RLE ----

    def unpack_rle(self, data: bytes, pklen1: int, origsize: int) -> bytes:
        out = bytearray()
        i = 0
        limit = len(data)
        while len(out) < origsize:
            if i >= limit:
                raise DecodeError("RLE: fin de datos")
            a = data[i]
            i += 1
            if a != 0x90:
                out.append(a)
            else:
                b = data[i]
                i += 1
                if b == 0:
                    out.append(a)
                else:
                    a = data[i]
                    i += 1
                    if b == 0xFF:
                        n = (data[i] << 8) + data[i + 1]
                        i += 2
                    else:
                        n = b
                    if len(out) + n > origsize:
                        raise DecodeError("RLE overrun")
                    out.extend(bytes([a]) * n)
        return bytes(out)

    # ---- QUICK ----

    def unpack_quick(self, data: bytes, pklen1: int, origsize: int) -> bytes:
        br = BitReader(data)
        out = bytearray()
        text = self.text
        loc = self.quick_loc
        while len(out) < origsize:
            if br.getbits(1) != 0:
                br.dropbits(1)
                v = br.getbits(8) & 0xFF
                br.dropbits(8)
                text[loc & 0xFF] = v
                loc += 1
                out.append(v)
            else:
                br.dropbits(1)
                j = (br.getbits(2) & 0xFFFF) + 2
                br.dropbits(2)
                i = (loc - (br.getbits(8) & 0xFFFF) - 1) & 0xFFFF
                br.dropbits(8)
                while j:
                    v = text[i & 0xFF]
                    i += 1
                    text[loc & 0xFF] = v
                    loc += 1
                    out.append(v)
                    j -= 1
        self.quick_loc = (loc + 5) & 0xFF
        return bytes(out)

    # ---- MEDIUM ----

    def unpack_medium(self, data: bytes, pklen1: int, origsize: int) -> bytes:
        br = BitReader(data)
        out = bytearray()
        text = self.text
        loc = self.medium_loc
        while len(out) < origsize:
            if br.getbits(1) != 0:
                br.dropbits(1)
                v = br.getbits(8) & 0xFF
                br.dropbits(8)
                text[loc & 0x3FFF] = v
                loc += 1
                out.append(v)
            else:
                br.dropbits(1)
                c = br.getbits(8) & 0xFF
                br.dropbits(8)
                j = D_CODE[c] + 3
                u = D_LEN[c]
                c = ((c << u) | br.getbits(u)) & 0xFF
                br.dropbits(u)
                u = D_LEN[c]
                c = (D_CODE[c] << 8) | (((c << u) | br.getbits(u)) & 0xFF)
                br.dropbits(u)
                i = (loc - c - 1) & 0xFFFF
                while j:
                    v = text[i & 0x3FFF]
                    i += 1
                    text[loc & 0x3FFF] = v
                    loc += 1
                    out.append(v)
                    j -= 1
        self.medium_loc = (loc + 66) & 0x3FFF
        return bytes(out)

    # ---- DEEP ----

    def _init_deep_tabs(self) -> None:
        N_CHAR, T, R = self.N_CHAR, self.T, self.R
        for i in range(N_CHAR):
            self.freq[i] = 1
            self.son[i] = i + T
            self.prnt[i + T] = i
        i, j = 0, N_CHAR
        while j <= R:
            self.freq[j] = self.freq[i] + self.freq[i + 1]
            self.son[j] = i
            self.prnt[i] = self.prnt[i + 1] = j
            i += 2
            j += 1
        self.freq[T] = 0xFFFF
        self.prnt[R] = 0
        self.init_deep_tabs = 0

    def _decode_char(self, br: BitReader) -> int:
        T = self.T
        c = self.son[self.R]
        while c < T:
            c = self.son[c + (br.getbits(1) & 1)]
            br.dropbits(1)
        c -= T
        self._deep_update(c)
        return c

    def _decode_position(self, br: BitReader) -> int:
        i = br.getbits(8) & 0xFF
        br.dropbits(8)
        c = D_CODE[i] << 8
        j = D_LEN[i]
        i = ((i << j) | br.getbits(j)) & 0xFF
        br.dropbits(j)
        return c | i

    def _reconst(self) -> None:
        T, N_CHAR = self.T, self.N_CHAR
        freq, son, prnt = self.freq, self.son, self.prnt
        j = 0
        for i in range(T):
            if son[i] >= T:
                freq[j] = (freq[i] + 1) // 2
                son[j] = son[i]
                j += 1
        i, j = 0, N_CHAR
        while j < T:
            k = i + 1
            f = freq[i] + freq[k]
            freq[j] = f
            k = j - 1
            while f < freq[k]:
                k -= 1
            k += 1
            l = (j - k) * 2
            tmp_f = freq[k:k + l]
            freq[k + 1:k + 1 + l] = tmp_f
            freq[k] = f
            tmp_s = son[k:k + l]
            son[k + 1:k + 1 + l] = tmp_s
            son[k] = i
            i += 2
            j += 1
        for i in range(T):
            k = son[i]
            if k >= T:
                prnt[k] = i
            else:
                prnt[k] = prnt[k + 1] = i

    def _deep_update(self, c: int) -> None:
        T = self.T
        freq, son, prnt = self.freq, self.son, self.prnt
        if freq[self.R] == 0x8000:
            self._reconst()
        c = prnt[c + T]
        while True:
            freq[c] += 1
            k = freq[c]
            l = c + 1
            if k > freq[l]:
                while k > freq[l + 1]:
                    l += 1
                freq[c] = freq[l]
                freq[l] = k
                i = son[c]
                prnt[i] = l
                if i < T:
                    prnt[i + 1] = l
                j = son[l]
                son[l] = i
                prnt[j] = c
                if j < T:
                    prnt[j + 1] = c
                son[c] = j
                c = l
            c = prnt[c]
            if c == 0:
                break

    def unpack_deep(self, data: bytes, pklen1: int, origsize: int) -> bytes:
        br = BitReader(data)
        if self.init_deep_tabs:
            self._init_deep_tabs()
        out = bytearray()
        text = self.text
        loc = self.deep_loc
        while len(out) < origsize:
            c = self._decode_char(br)
            if c < 256:
                text[loc & 0x3FFF] = c
                loc += 1
                out.append(c)
            else:
                j = c - 255 + 2
                i = (loc - self._decode_position(br) - 1) & 0xFFFF
                while j:
                    v = text[i & 0x3FFF]
                    i += 1
                    text[loc & 0x3FFF] = v
                    loc += 1
                    out.append(v)
                    j -= 1
        self.deep_loc = (loc + 60) & 0x3FFF
        return bytes(out)

    # ---- HEAVY ----

    def _make_table(self, nchar: int, bitlen, tablebits: int, table) -> int:
        NC = nchar
        tblsiz = 1 << tablebits
        state = {
            "n": NC, "blen": bitlen, "tbl": table, "tblsiz": tblsiz,
            "bit": tblsiz // 2, "maxdepth": tablebits + 1, "depth": 1,
            "len": 1, "c": -1, "codeword": 0, "taberr": 0, "avail": NC,
        }

        def mktbl() -> int:
            if state["taberr"]:
                return 0
            i = 0
            if state["len"] == state["depth"]:
                while True:
                    state["c"] += 1
                    if state["c"] >= state["n"]:
                        break
                    if state["blen"][state["c"]] == state["len"]:
                        i = state["codeword"]
                        state["codeword"] += state["bit"]
                        if state["codeword"] > state["tblsiz"]:
                            state["taberr"] = 1
                            return 0
                        while i < state["codeword"]:
                            state["tbl"][i] = state["c"]
                            i += 1
                        return state["c"]
                state["c"] = -1
                state["len"] += 1
                state["bit"] >>= 1
            state["depth"] += 1
            if state["depth"] < state["maxdepth"]:
                mktbl()
                mktbl()
            elif state["depth"] > 32:
                state["taberr"] = 2
                return 0
            else:
                i = state["avail"]
                state["avail"] += 1
                if i >= 2 * state["n"] - 1:
                    state["taberr"] = 3
                    return 0
                self.left[i] = mktbl()
                self.right[i] = mktbl()
                if state["codeword"] >= state["tblsiz"]:
                    state["taberr"] = 4
                    return 0
                if state["depth"] == state["maxdepth"]:
                    state["tbl"][state["codeword"]] = i
                    state["codeword"] += 1
            state["depth"] -= 1
            return i

        mktbl()
        if state["taberr"]:
            return state["taberr"]
        mktbl()
        if state["taberr"]:
            return state["taberr"]
        if state["codeword"] != tblsiz:
            return 5
        return 0

    def _read_tree_c(self, br: BitReader) -> int:
        n = br.getbits(9) & 0xFFFF
        br.dropbits(9)
        if n > 0:
            for i in range(n):
                self.c_len[i] = br.getbits(5) & 0xFF
                br.dropbits(5)
            for i in range(n, 510):
                self.c_len[i] = 0
            return self._make_table(510, self.c_len, 12, self.c_table)
        else:
            n = br.getbits(9) & 0xFFFF
            br.dropbits(9)
            for i in range(510):
                self.c_len[i] = 0
            for i in range(4096):
                self.c_table[i] = n
            return 0

    def _read_tree_p(self, br: BitReader) -> int:
        n = br.getbits(5) & 0xFFFF
        br.dropbits(5)
        if n > 0:
            for i in range(n):
                self.pt_len[i] = br.getbits(4) & 0xFF
                br.dropbits(4)
            for i in range(n, self.np):
                self.pt_len[i] = 0
            return self._make_table(self.np, self.pt_len, 8, self.pt_table)
        else:
            n = br.getbits(5) & 0xFFFF
            br.dropbits(5)
            for i in range(self.np):
                self.pt_len[i] = 0
            for i in range(256):
                self.pt_table[i] = n
            return 0

    def _decode_c(self, br: BitReader) -> int:
        j = self.c_table[br.getbits(12) & 0xFFF]
        if j < 510:
            br.dropbits(self.c_len[j])
        else:
            br.dropbits(12)
            i = br.getbits(16)
            m = 0x8000
            while True:
                if i & m:
                    j = self.right[j]
                else:
                    j = self.left[j]
                m >>= 1
                if j < 510:
                    break
            br.dropbits(self.c_len[j] - 12)
        return j

    def _decode_p(self, br: BitReader) -> int:
        j = self.pt_table[br.getbits(8) & 0xFF]
        if j < self.np:
            br.dropbits(self.pt_len[j])
        else:
            br.dropbits(8)
            i = br.getbits(16)
            m = 0x8000
            while True:
                if i & m:
                    j = self.right[j]
                else:
                    j = self.left[j]
                m >>= 1
                if j < self.np:
                    break
            br.dropbits(self.pt_len[j] - 8)
        if j != self.np - 1:
            if j > 0:
                n = j - 1
                j = br.getbits(n) | (1 << n)
                br.dropbits(n)
            self.lastlen = j
        return self.lastlen

    def unpack_heavy(self, data: bytes, flags: int, origsize: int) -> bytes:
        if flags & 8:
            self.np = 15
            bitmask = 0x1FFF
        else:
            self.np = 14
            bitmask = 0x0FFF
        br = BitReader(data)
        if flags & 2:
            if self._read_tree_c(br):
                raise DecodeError("read_tree_c")
            if self._read_tree_p(br):
                raise DecodeError("read_tree_p")
        out = bytearray()
        text = self.text
        loc = self.heavy_loc
        while len(out) < origsize:
            c = self._decode_c(br)
            if c < 256:
                text[loc & bitmask] = c
                loc += 1
                out.append(c)
            else:
                j = c - 253
                i = (loc - self._decode_p(br) - 1) & 0xFFFF
                while j:
                    v = text[i & bitmask]
                    i += 1
                    text[loc & bitmask] = v
                    loc += 1
                    out.append(v)
                    j -= 1
        self.heavy_loc = loc
        return bytes(out)

    # ---- modo ----

    def unpack_track_2(self, b1: bytes, pklen1: int, pklen2: int, unpklen: int,
                       cmode: int, flags: int) -> bytes:
        if cmode == 0:
            return b1[:unpklen]
        if cmode == 1:
            return self.unpack_rle(b1, pklen1, unpklen)
        if cmode == 2:
            t = self.unpack_quick(b1, pklen1, pklen2)
            return self.unpack_rle(t, pklen2, unpklen)
        if cmode == 3:
            t = self.unpack_medium(b1, pklen1, pklen2)
            return self.unpack_rle(t, pklen2, unpklen)
        if cmode == 4:
            t = self.unpack_deep(b1, pklen1, pklen2)
            return self.unpack_rle(t, pklen2, unpklen)
        if cmode in (5, 6):
            if cmode == 5:
                t = self.unpack_heavy(b1, flags & 7, pklen2)
            else:
                t = self.unpack_heavy(b1, flags | 8, pklen2)
            if flags & 4:
                t = self.unpack_rle(t, pklen2, unpklen)
            return t
        raise DecodeError(f"modo desconocido {cmode}")


def process(data: bytes, verbose: bool = False):
    """Devuelve (adf: bytearray, unpkfsize, from, to, tracks_info)."""
    if len(data) < HEADLEN or data[:4] != b"DMS!":
        raise DecodeError("No es un archivo DMS")
    hcrc = (data[HEADLEN - 2] << 8) | data[HEADLEN - 1]
    calc = crc16(data[4:HEADLEN - 2])
    if hcrc != calc:
        raise DecodeError(f"CRC de cabecera incorrecto: {hcrc:04X} != {calc:04X}")

    geninfo = (data[10] << 8) | data[11]
    frm = (data[16] << 8) | data[17]
    to = (data[18] << 8) | data[19]
    pkfsize = (data[21] << 16) | (data[22] << 8) | data[23]
    unpkfsize = (data[25] << 16) | (data[26] << 8) | data[27]
    c_version = (data[46] << 8) | data[47]
    disktype = (data[50] << 8) | data[51]
    cmode = (data[52] << 8) | data[53]

    if verbose:
        modes = ["NOCOMP", "SIMPLE", "QUICK", "MEDIUM", "DEEP", "HEAVY1", "HEAVY2"]
        print(f"header CRC OK ({hcrc:04X})")
        print(f"  version DMS        : {c_version//100}.{c_version%100:02d}")
        print(f"  geninfo            : 0x{geninfo:04X}"
              f"{' (registered)' if geninfo & 0x80 else ' (eval)'}"
              f"{' NoZero' if geninfo & 1 else ''}"
              f"{' Encrypted' if geninfo & 2 else ''}"
              f"{' Appends' if geninfo & 4 else ''}"
              f"{' Banner' if geninfo & 8 else ''}"
              f"{' HD' if geninfo & 16 else ''}")
        print(f"  tracks             : {frm}..{to}")
        print(f"  packed size        : {pkfsize}")
        print(f"  unpacked size      : {unpkfsize}")
        print(f"  disktype           : {disktype}")
        print(f"  compression mode   : {modes[cmode] if cmode < 7 else '?'}")

    hd = bool(geninfo & DMSFLAG_HD)
    adf = bytearray(unpkfsize)
    decoder = DMSDecoder(verbose=verbose)
    decoder.init_decrunchers()
    pos = HEADLEN
    tracks_info = []

    while pos < len(data):
        if pos + THLEN > len(data):
            break
        th = data[pos:pos + THLEN]
        if th[0:2] != b"TR":
            if verbose:
                print(f"  fin de datos en 0x{pos:X} (no hay cabecera TR)")
            break
        thcrc = (th[THLEN - 2] << 8) | th[THLEN - 1]
        if crc16(th[:THLEN - 2]) != thcrc:
            raise DecodeError(f"CRC de cabecera de pista incorrecto en 0x{pos:X}")
        number = (th[2] << 8) | th[3]
        pklen1 = (th[6] << 8) | th[7]
        pklen2 = (th[8] << 8) | th[9]
        unpklen = (th[10] << 8) | th[11]
        flags = th[12]
        tcmode = th[13]
        usum = (th[14] << 8) | th[15]
        dcrc = (th[16] << 8) | th[17]
        pos += THLEN

        if pklen1 > TRACK_BUFFER_LEN or pklen2 > TRACK_BUFFER_LEN or unpklen > TRACK_BUFFER_LEN:
            raise DecodeError(f"pista demasiado grande (track {number})")
        b1 = data[pos:pos + pklen1]
        pos += pklen1
        crcerr = crc16(b1) != dcrc
        tracks_info.append((number, pklen1, pklen2, unpklen, tcmode, flags))

        normaltrack = False
        if number < 80 and unpklen > 2048 and not crcerr:
            b2 = decoder.unpack_track_2(b1, pklen1, pklen2, unpklen, tcmode, flags)
            got = checksum16(b2)
            if got != usum:
                raise DecodeError(
                    f"checksum pista {number} incorrecto: {got:04X} != {usum:04X}")
            off = number * HD_STRIDE * (2 if hd else 1)
            adf[off:off + unpklen] = b2
            normaltrack = True
            if verbose:
                print(f"  track {number:3d}: pk={pklen1:5d} mid={pklen2:5d} unpk={unpklen:5d}"
                      f" cmode={tcmode} flags=0x{flags:02X} OK")
        elif crcerr:
            if verbose:
                print(f"  track {number:3d}: CRC de datos incorrecto (saltada)")
        if not normaltrack:
            decoder.init_decrunchers()

    return adf, unpkfsize, frm, to, tracks_info


def main() -> int:
    ap = argparse.ArgumentParser(description="Descompresor DMS -> ADF")
    ap.add_argument("input")
    ap.add_argument("output")
    ap.add_argument("--verbose", action="store_true")
    args = ap.parse_args()

    with open(args.input, "rb") as f:
        data = f.read()
    adf, unpkfsize, frm, to, tracks = process(data, args.verbose)
    with open(args.output, "wb") as f:
        f.write(adf)
    print(f"ADF: {args.output} ({len(adf)} bytes), pistas {frm}..{to}, "
          f"{len(tracks)} pistas decodificadas")
    return 0


if __name__ == "__main__":
    sys.exit(main())
