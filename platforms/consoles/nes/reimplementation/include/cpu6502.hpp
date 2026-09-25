#ifndef RR_NES_CPU6502_HPP
#define RR_NES_CPU6502_HPP

#include <cstdint>

#include "bus.hpp"

// Núcleo MOS 6502 (variante 2A03: sin modo decimal). Oficiales + ilegales.
class CPU6502 {
public:
    explicit CPU6502(Bus& b) : bus(b) {}

    void reset();       // estado de reset (usa vector $FFFC)
    void start_test();  // arranque del test automático de nestest: PC=C000 SP=FD P=24

    int step();  // ejecuta una instrucción; devuelve ciclos (aprox.)

    // Registros
    std::uint8_t a = 0, x = 0, y = 0, sp = 0xFD, p = 0x24;
    std::uint16_t pc = 0;
    std::uint64_t cycles = 0;
    bool jammed = false;

    // Flags
    enum : std::uint8_t { C = 0x01, Z = 0x02, I = 0x04, D = 0x08, B = 0x10, U = 0x20, V = 0x40, N = 0x80 };

private:
    Bus& bus;

    std::uint8_t read(std::uint16_t addr) { return bus.read(addr); }
    void write(std::uint16_t addr, std::uint8_t v) { bus.write(addr, v); }

    std::uint8_t fetch() { return read(pc++); }
    void push(std::uint8_t v) { write(0x0100 | sp, v); --sp; }
    std::uint8_t pull() { ++sp; return read(0x0100 | sp); }

    void set_zn(std::uint8_t v) { p = (p & ~(Z | N)) | (v == 0 ? Z : 0) | (v & 0x80); }
    void set_flag(std::uint8_t f, bool on) { if (on) p |= f; else p &= ~f; }
    bool flag(std::uint8_t f) const { return (p & f) != 0; }

    // Direcciones efectivas (avanzan PC según el modo).
    std::uint16_t addr_zp()  { return fetch(); }
    std::uint16_t addr_zpx() { return (fetch() + x) & 0xFF; }
    std::uint16_t addr_zpy() { return (fetch() + y) & 0xFF; }
    std::uint16_t addr_abs() { std::uint16_t lo = fetch(); std::uint16_t hi = fetch(); return (hi << 8) | lo; }
    std::uint16_t addr_abx() { return addr_abs() + x; }
    std::uint16_t addr_aby() { return addr_abs() + y; }
    std::uint16_t addr_izx() {
        std::uint8_t ptr = fetch() + x;
        std::uint16_t lo = read(ptr);
        std::uint16_t hi = read((ptr + 1) & 0xFF);
        return (hi << 8) | lo;
    }
    std::uint16_t addr_izy() {
        std::uint8_t ptr = fetch();
        std::uint16_t lo = read(ptr);
        std::uint16_t hi = read((ptr + 1) & 0xFF);
        return ((hi << 8) | lo) + y;
    }

    // Operaciones
    void adc(std::uint8_t v);
    void sbc(std::uint8_t v);
    void cmp(std::uint8_t reg, std::uint8_t v);
    std::uint8_t asl(std::uint8_t v);
    std::uint8_t lsr(std::uint8_t v);
    std::uint8_t rol(std::uint8_t v);
    std::uint8_t ror(std::uint8_t v);
    void branch(bool taken);

    std::uint16_t read16(std::uint16_t addr) { return read(addr) | (read(addr + 1) << 8); }
    std::uint16_t read16_zp(std::uint8_t zp) { return read(zp) | (read((std::uint8_t)(zp + 1)) << 8); }
};

#endif  // RR_NES_CPU6502_HPP
