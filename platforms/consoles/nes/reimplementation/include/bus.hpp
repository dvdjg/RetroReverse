#ifndef RR_NES_BUS_HPP
#define RR_NES_BUS_HPP

#include <array>
#include <cstdint>

#include "cartridge.hpp"

// Bus de la CPU (64 KiB) con espejos y mapeo de cartucho. PPU/APU como stubs por ahora.
class Bus {
public:
    explicit Bus(Cartridge& c) : cart(c) {}

    std::uint8_t read(std::uint16_t addr);
    void write(std::uint16_t addr, std::uint8_t v);

    std::array<std::uint8_t, 0x800> ram{};   // 2 KiB
    std::array<std::uint8_t, 8> ppu_regs{};  // $2000-$2007
    std::array<std::uint8_t, 0x18> io{};     // $4000-$4017

private:
    Cartridge& cart;
};

#endif  // RR_NES_BUS_HPP
