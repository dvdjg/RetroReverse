#include "cpu6502.hpp"

#include "bus.hpp"

void CPU6502::reset() {
    a = x = y = 0;
    sp = 0xFD;
    p = 0x24;
    pc = read16(0xFFFC);
    cycles = 7;
    jammed = false;
}

void CPU6502::start_test() {
    a = x = y = 0;
    sp = 0xFD;
    p = 0x24;
    pc = 0xC000;
    cycles = 7;
    jammed = false;
}

void CPU6502::adc(std::uint8_t v) {
    const unsigned r = a + v + (flag(C) ? 1u : 0u);
    set_flag(C, r > 0xFF);
    set_flag(V, (~(a ^ v) & (a ^ r) & 0x80) != 0);
    a = static_cast<std::uint8_t>(r);
    set_zn(a);
}

void CPU6502::sbc(std::uint8_t v) { adc(static_cast<std::uint8_t>(v ^ 0xFF)); }

void CPU6502::cmp(std::uint8_t reg, std::uint8_t v) {
    set_flag(C, reg >= v);
    set_zn(static_cast<std::uint8_t>(reg - v));
}

std::uint8_t CPU6502::asl(std::uint8_t v) {
    set_flag(C, (v & 0x80) != 0);
    v = static_cast<std::uint8_t>(v << 1);
    set_zn(v);
    return v;
}

std::uint8_t CPU6502::lsr(std::uint8_t v) {
    set_flag(C, (v & 0x01) != 0);
    v >>= 1;
    set_zn(v);
    return v;
}

std::uint8_t CPU6502::rol(std::uint8_t v) {
    const bool c = flag(C);
    set_flag(C, (v & 0x80) != 0);
    v = static_cast<std::uint8_t>((v << 1) | (c ? 1 : 0));
    set_zn(v);
    return v;
}

std::uint8_t CPU6502::ror(std::uint8_t v) {
    const bool c = flag(C);
    set_flag(C, (v & 0x01) != 0);
    v = static_cast<std::uint8_t>((v >> 1) | (c ? 0x80 : 0));
    set_zn(v);
    return v;
}

void CPU6502::branch(bool taken) {
    const std::int8_t off = static_cast<std::int8_t>(fetch());
    if (taken) pc = static_cast<std::uint16_t>(pc + off);
}

int CPU6502::step() {
    if (jammed) return 1;
    coverage[pc] = 1;  // cobertura: dirección de inicio de instrucción ejecutada
    if (has_expected && pc == expected_next) sequential[pc] = 1;
    const std::uint8_t op = fetch();
    auto rd = [&](std::uint16_t a) { return read(a); };
    auto wr = [&](std::uint16_t a, std::uint8_t v) { write(a, v); };

    switch (op) {
        // --- LDA ---
        case 0xA9: a = fetch(); set_zn(a); break;
        case 0xA5: a = rd(addr_zp()); set_zn(a); break;
        case 0xB5: a = rd(addr_zpx()); set_zn(a); break;
        case 0xAD: a = rd(addr_abs()); set_zn(a); break;
        case 0xBD: a = rd(addr_abx()); set_zn(a); break;
        case 0xB9: a = rd(addr_aby()); set_zn(a); break;
        case 0xA1: a = rd(addr_izx()); set_zn(a); break;
        case 0xB1: a = rd(addr_izy()); set_zn(a); break;
        // --- LDX ---
        case 0xA2: x = fetch(); set_zn(x); break;
        case 0xA6: x = rd(addr_zp()); set_zn(x); break;
        case 0xB6: x = rd(addr_zpy()); set_zn(x); break;
        case 0xAE: x = rd(addr_abs()); set_zn(x); break;
        case 0xBE: x = rd(addr_aby()); set_zn(x); break;
        // --- LDY ---
        case 0xA0: y = fetch(); set_zn(y); break;
        case 0xA4: y = rd(addr_zp()); set_zn(y); break;
        case 0xB4: y = rd(addr_zpx()); set_zn(y); break;
        case 0xAC: y = rd(addr_abs()); set_zn(y); break;
        case 0xBC: y = rd(addr_abx()); set_zn(y); break;
        // --- STA ---
        case 0x85: wr(addr_zp(), a); break;
        case 0x95: wr(addr_zpx(), a); break;
        case 0x8D: wr(addr_abs(), a); break;
        case 0x9D: wr(addr_abx(), a); break;
        case 0x99: wr(addr_aby(), a); break;
        case 0x81: wr(addr_izx(), a); break;
        case 0x91: wr(addr_izy(), a); break;
        // --- STX / STY ---
        case 0x86: wr(addr_zp(), x); break;
        case 0x96: wr(addr_zpy(), x); break;
        case 0x8E: wr(addr_abs(), x); break;
        case 0x84: wr(addr_zp(), y); break;
        case 0x94: wr(addr_zpx(), y); break;
        case 0x8C: wr(addr_abs(), y); break;
        // --- transfers ---
        case 0xAA: x = a; set_zn(x); break;
        case 0xA8: y = a; set_zn(y); break;
        case 0x8A: a = x; set_zn(a); break;
        case 0x98: a = y; set_zn(a); break;
        case 0xBA: x = sp; set_zn(x); break;
        case 0x9A: sp = x; break;
        // --- stack ---
        case 0x48: push(a); break;
        case 0x68: a = pull(); set_zn(a); break;
        case 0x08: push(static_cast<std::uint8_t>(p | B | U)); break;
        case 0x28: p = static_cast<std::uint8_t>((pull() & ~B) | U); break;
        // --- AND / EOR / ORA ---
        case 0x29: a &= fetch(); set_zn(a); break;
        case 0x25: a &= rd(addr_zp()); set_zn(a); break;
        case 0x35: a &= rd(addr_zpx()); set_zn(a); break;
        case 0x2D: a &= rd(addr_abs()); set_zn(a); break;
        case 0x3D: a &= rd(addr_abx()); set_zn(a); break;
        case 0x39: a &= rd(addr_aby()); set_zn(a); break;
        case 0x21: a &= rd(addr_izx()); set_zn(a); break;
        case 0x31: a &= rd(addr_izy()); set_zn(a); break;
        case 0x49: a ^= fetch(); set_zn(a); break;
        case 0x45: a ^= rd(addr_zp()); set_zn(a); break;
        case 0x55: a ^= rd(addr_zpx()); set_zn(a); break;
        case 0x4D: a ^= rd(addr_abs()); set_zn(a); break;
        case 0x5D: a ^= rd(addr_abx()); set_zn(a); break;
        case 0x59: a ^= rd(addr_aby()); set_zn(a); break;
        case 0x41: a ^= rd(addr_izx()); set_zn(a); break;
        case 0x51: a ^= rd(addr_izy()); set_zn(a); break;
        case 0x09: a |= fetch(); set_zn(a); break;
        case 0x05: a |= rd(addr_zp()); set_zn(a); break;
        case 0x15: a |= rd(addr_zpx()); set_zn(a); break;
        case 0x0D: a |= rd(addr_abs()); set_zn(a); break;
        case 0x1D: a |= rd(addr_abx()); set_zn(a); break;
        case 0x19: a |= rd(addr_aby()); set_zn(a); break;
        case 0x01: a |= rd(addr_izx()); set_zn(a); break;
        case 0x11: a |= rd(addr_izy()); set_zn(a); break;
        // --- BIT ---
        case 0x24: { std::uint8_t m = rd(addr_zp()); set_flag(Z, (a & m) == 0); p = (p & ~(V | N)) | (m & 0xC0); break; }
        case 0x2C: { std::uint8_t m = rd(addr_abs()); set_flag(Z, (a & m) == 0); p = (p & ~(V | N)) | (m & 0xC0); break; }
        // --- ADC / SBC ---
        case 0x69: adc(fetch()); break;
        case 0x65: adc(rd(addr_zp())); break;
        case 0x75: adc(rd(addr_zpx())); break;
        case 0x6D: adc(rd(addr_abs())); break;
        case 0x7D: adc(rd(addr_abx())); break;
        case 0x79: adc(rd(addr_aby())); break;
        case 0x61: adc(rd(addr_izx())); break;
        case 0x71: adc(rd(addr_izy())); break;
        case 0xE9: case 0xEB: sbc(fetch()); break;
        case 0xE5: sbc(rd(addr_zp())); break;
        case 0xF5: sbc(rd(addr_zpx())); break;
        case 0xED: sbc(rd(addr_abs())); break;
        case 0xFD: sbc(rd(addr_abx())); break;
        case 0xF9: sbc(rd(addr_aby())); break;
        case 0xE1: sbc(rd(addr_izx())); break;
        case 0xF1: sbc(rd(addr_izy())); break;
        // --- CMP / CPX / CPY ---
        case 0xC9: cmp(a, fetch()); break;
        case 0xC5: cmp(a, rd(addr_zp())); break;
        case 0xD5: cmp(a, rd(addr_zpx())); break;
        case 0xCD: cmp(a, rd(addr_abs())); break;
        case 0xDD: cmp(a, rd(addr_abx())); break;
        case 0xD9: cmp(a, rd(addr_aby())); break;
        case 0xC1: cmp(a, rd(addr_izx())); break;
        case 0xD1: cmp(a, rd(addr_izy())); break;
        case 0xE0: cmp(x, fetch()); break;
        case 0xE4: cmp(x, rd(addr_zp())); break;
        case 0xEC: cmp(x, rd(addr_abs())); break;
        case 0xC0: cmp(y, fetch()); break;
        case 0xC4: cmp(y, rd(addr_zp())); break;
        case 0xCC: cmp(y, rd(addr_abs())); break;
        // --- INC / DEC ---
        case 0xE6: { std::uint16_t ad = addr_zp(); wr(ad, rd(ad) + 1); set_zn(rd(ad)); break; }
        case 0xF6: { std::uint16_t ad = addr_zpx(); wr(ad, rd(ad) + 1); set_zn(rd(ad)); break; }
        case 0xEE: { std::uint16_t ad = addr_abs(); wr(ad, rd(ad) + 1); set_zn(rd(ad)); break; }
        case 0xFE: { std::uint16_t ad = addr_abx(); wr(ad, rd(ad) + 1); set_zn(rd(ad)); break; }
        case 0xC6: { std::uint16_t ad = addr_zp(); wr(ad, rd(ad) - 1); set_zn(rd(ad)); break; }
        case 0xD6: { std::uint16_t ad = addr_zpx(); wr(ad, rd(ad) - 1); set_zn(rd(ad)); break; }
        case 0xCE: { std::uint16_t ad = addr_abs(); wr(ad, rd(ad) - 1); set_zn(rd(ad)); break; }
        case 0xDE: { std::uint16_t ad = addr_abx(); wr(ad, rd(ad) - 1); set_zn(rd(ad)); break; }
        case 0xE8: ++x; set_zn(x); break;
        case 0xC8: ++y; set_zn(y); break;
        case 0xCA: --x; set_zn(x); break;
        case 0x88: --y; set_zn(y); break;
        // --- shifts ---
        case 0x0A: a = asl(a); break;
        case 0x06: { std::uint16_t ad = addr_zp(); wr(ad, asl(rd(ad))); break; }
        case 0x16: { std::uint16_t ad = addr_zpx(); wr(ad, asl(rd(ad))); break; }
        case 0x0E: { std::uint16_t ad = addr_abs(); wr(ad, asl(rd(ad))); break; }
        case 0x1E: { std::uint16_t ad = addr_abx(); wr(ad, asl(rd(ad))); break; }
        case 0x4A: a = lsr(a); break;
        case 0x46: { std::uint16_t ad = addr_zp(); wr(ad, lsr(rd(ad))); break; }
        case 0x56: { std::uint16_t ad = addr_zpx(); wr(ad, lsr(rd(ad))); break; }
        case 0x4E: { std::uint16_t ad = addr_abs(); wr(ad, lsr(rd(ad))); break; }
        case 0x5E: { std::uint16_t ad = addr_abx(); wr(ad, lsr(rd(ad))); break; }
        case 0x2A: a = rol(a); break;
        case 0x26: { std::uint16_t ad = addr_zp(); wr(ad, rol(rd(ad))); break; }
        case 0x36: { std::uint16_t ad = addr_zpx(); wr(ad, rol(rd(ad))); break; }
        case 0x2E: { std::uint16_t ad = addr_abs(); wr(ad, rol(rd(ad))); break; }
        case 0x3E: { std::uint16_t ad = addr_abx(); wr(ad, rol(rd(ad))); break; }
        case 0x6A: a = ror(a); break;
        case 0x66: { std::uint16_t ad = addr_zp(); wr(ad, ror(rd(ad))); break; }
        case 0x76: { std::uint16_t ad = addr_zpx(); wr(ad, ror(rd(ad))); break; }
        case 0x6E: { std::uint16_t ad = addr_abs(); wr(ad, ror(rd(ad))); break; }
        case 0x7E: { std::uint16_t ad = addr_abx(); wr(ad, ror(rd(ad))); break; }
        // --- jumps / subroutines ---
        case 0x4C: pc = addr_abs(); break;
        case 0x6C: {
            std::uint16_t ptr = addr_abs();
            std::uint16_t lo = read(ptr);
            std::uint16_t hi = read((ptr & 0xFF00) | ((ptr + 1) & 0x00FF));
            pc = (hi << 8) | lo;
            break;
        }
        case 0x20: {
            std::uint16_t target = addr_abs();
            const std::uint16_t ret = static_cast<std::uint16_t>(pc - 1);
            push(ret >> 8);
            push(ret & 0xFF);
            pc = target;
            break;
        }
        case 0x60: {
            std::uint16_t lo = pull();
            std::uint16_t hi = pull();
            pc = ((hi << 8) | lo) + 1;
            break;
        }
        case 0x40: {
            p = static_cast<std::uint8_t>((pull() & ~B) | U);
            std::uint16_t lo = pull();
            std::uint16_t hi = pull();
            pc = (hi << 8) | lo;
            break;
        }
        case 0x00: {  // BRK
            const std::uint16_t ret = static_cast<std::uint16_t>(pc + 1);
            push(ret >> 8);
            push(ret & 0xFF);
            push(static_cast<std::uint8_t>(p | B | U));
            set_flag(I, true);
            pc = read16(0xFFFE);
            break;
        }
        // --- branches ---
        case 0x10: branch(!flag(N)); break;
        case 0x30: branch(flag(N)); break;
        case 0x50: branch(!flag(V)); break;
        case 0x70: branch(flag(V)); break;
        case 0x90: branch(!flag(C)); break;
        case 0xB0: branch(flag(C)); break;
        case 0xD0: branch(!flag(Z)); break;
        case 0xF0: branch(flag(Z)); break;
        // --- flags ---
        case 0x18: set_flag(C, false); break;
        case 0x38: set_flag(C, true); break;
        case 0x58: set_flag(I, false); break;
        case 0x78: set_flag(I, true); break;
        case 0xB8: set_flag(V, false); break;
        case 0xD8: set_flag(D, false); break;
        case 0xF8: set_flag(D, true); break;
        case 0xEA: break;  // NOP

        // ================= ILEGALES =================
        // SLO
        case 0x03: { std::uint16_t ad = addr_izx(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x07: { std::uint16_t ad = addr_zp(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x0F: { std::uint16_t ad = addr_abs(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x13: { std::uint16_t ad = addr_izy(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x17: { std::uint16_t ad = addr_zpx(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x1B: { std::uint16_t ad = addr_aby(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        case 0x1F: { std::uint16_t ad = addr_abx(); std::uint8_t m = asl(rd(ad)); wr(ad, m); a |= m; set_zn(a); break; }
        // RLA
        case 0x23: { std::uint16_t ad = addr_izx(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x27: { std::uint16_t ad = addr_zp(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x2F: { std::uint16_t ad = addr_abs(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x33: { std::uint16_t ad = addr_izy(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x37: { std::uint16_t ad = addr_zpx(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x3B: { std::uint16_t ad = addr_aby(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        case 0x3F: { std::uint16_t ad = addr_abx(); std::uint8_t m = rol(rd(ad)); wr(ad, m); a &= m; set_zn(a); break; }
        // SRE
        case 0x43: { std::uint16_t ad = addr_izx(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x47: { std::uint16_t ad = addr_zp(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x4F: { std::uint16_t ad = addr_abs(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x53: { std::uint16_t ad = addr_izy(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x57: { std::uint16_t ad = addr_zpx(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x5B: { std::uint16_t ad = addr_aby(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        case 0x5F: { std::uint16_t ad = addr_abx(); std::uint8_t m = lsr(rd(ad)); wr(ad, m); a ^= m; set_zn(a); break; }
        // RRA
        case 0x63: { std::uint16_t ad = addr_izx(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x67: { std::uint16_t ad = addr_zp(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x6F: { std::uint16_t ad = addr_abs(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x73: { std::uint16_t ad = addr_izy(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x77: { std::uint16_t ad = addr_zpx(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x7B: { std::uint16_t ad = addr_aby(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        case 0x7F: { std::uint16_t ad = addr_abx(); std::uint8_t m = ror(rd(ad)); wr(ad, m); adc(m); break; }
        // SAX
        case 0x83: wr(addr_izx(), a & x); break;
        case 0x87: wr(addr_zp(), a & x); break;
        case 0x8F: wr(addr_abs(), a & x); break;
        case 0x97: wr(addr_zpy(), a & x); break;
        // LAX
        case 0xA3: a = x = rd(addr_izx()); set_zn(a); break;
        case 0xA7: a = x = rd(addr_zp()); set_zn(a); break;
        case 0xAB: a = x = fetch(); set_zn(a); break;
        case 0xAF: a = x = rd(addr_abs()); set_zn(a); break;
        case 0xB3: a = x = rd(addr_izy()); set_zn(a); break;
        case 0xB7: a = x = rd(addr_zpy()); set_zn(a); break;
        case 0xBF: a = x = rd(addr_aby()); set_zn(a); break;
        // DCP
        case 0xC3: { std::uint16_t ad = addr_izx(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xC7: { std::uint16_t ad = addr_zp(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xCF: { std::uint16_t ad = addr_abs(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xD3: { std::uint16_t ad = addr_izy(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xD7: { std::uint16_t ad = addr_zpx(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xDB: { std::uint16_t ad = addr_aby(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        case 0xDF: { std::uint16_t ad = addr_abx(); wr(ad, rd(ad) - 1); cmp(a, rd(ad)); break; }
        // ISC
        case 0xE3: { std::uint16_t ad = addr_izx(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xE7: { std::uint16_t ad = addr_zp(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xEF: { std::uint16_t ad = addr_abs(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xF3: { std::uint16_t ad = addr_izy(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xF7: { std::uint16_t ad = addr_zpx(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xFB: { std::uint16_t ad = addr_aby(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        case 0xFF: { std::uint16_t ad = addr_abx(); wr(ad, rd(ad) + 1); sbc(rd(ad)); break; }
        // ANC / ALR / ARR / SBX / LAS
        case 0x0B: case 0x2B: a &= fetch(); set_zn(a); set_flag(C, (a & 0x80) != 0); break;
        case 0x4B: a &= fetch(); a = lsr(a); break;
        case 0x6B: {
            a &= fetch();
            const bool c = flag(C);
            a = static_cast<std::uint8_t>((a >> 1) | (c ? 0x80 : 0));
            set_zn(a);
            set_flag(C, (a & 0x40) != 0);
            set_flag(V, ((a >> 6) ^ (a >> 5)) & 1);
            break;
        }
        case 0xCB: { std::uint8_t m = fetch(); std::uint16_t t = (a & x) - m; x = static_cast<std::uint8_t>(t); set_flag(C, (a & x) >= m); set_zn(x); break; }
        case 0xBB: { std::uint16_t ad = addr_aby(); std::uint8_t m = rd(ad); a = x = sp = m & sp; set_zn(a); break; }
        // SHA / SHX / SHY / TAS (unstable: usamos valor determinista)
        case 0x93: { std::uint16_t ad = addr_izy(); wr(ad, a & x); break; }
        case 0x9F: { std::uint16_t ad = addr_aby(); wr(ad, a & x); break; }
        case 0x9E: { std::uint16_t ad = addr_aby(); wr(ad, x); break; }
        case 0x9C: { std::uint16_t ad = addr_abx(); wr(ad, y); break; }
        case 0x9B: { sp = a & x; std::uint16_t ad = addr_aby(); wr(ad, sp); break; }
        // NOP ilegales (implicado / inmediato)
        case 0x1A: case 0x3A: case 0x5A: case 0x7A: case 0xDA: case 0xFA: break;
        case 0x80: case 0x82: case 0x89: case 0xC2: case 0xE2: (void)fetch(); break;
        // NOP ilegales (lectura)
        case 0x04: case 0x44: case 0x64: (void)rd(addr_zp()); break;
        case 0x0C: (void)rd(addr_abs()); break;
        case 0x14: case 0x34: case 0x54: case 0x74: case 0xD4: case 0xF4: (void)rd(addr_zpx()); break;
        case 0x1C: case 0x3C: case 0x5C: case 0x7C: case 0xDC: case 0xFC: (void)rd(addr_abx()); break;
        // KIL / JAM
        case 0x02: case 0x12: case 0x22: case 0x32: case 0x42: case 0x52:
        case 0x62: case 0x72: case 0x92: case 0xB2: case 0xD2: case 0xF2:
            jammed = true;
            break;

        default:
            jammed = true;
            break;
    }
    cycles += 2;  // ciclos aproximados (no usados por el criterio $02/$03)
    expected_next = boundary;  // fall-through real tras los bytes de la instrucción
    has_expected = true;
    return 2;
}
