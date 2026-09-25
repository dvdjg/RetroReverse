#include "bus.hpp"

std::uint8_t Bus::read(std::uint16_t addr) {
    if (addr < 0x2000) return ram[addr & 0x07FF];
    if (addr < 0x4000) return ppu_regs[addr & 0x07];
    if (addr == 0x4015) return io[0x15];
    if (addr < 0x4020) return io[addr - 0x4000];
    return cart.cpu_read(addr);
}

void Bus::write(std::uint16_t addr, std::uint8_t v) {
    if (addr < 0x2000) { ram[addr & 0x07FF] = v; return; }
    if (addr < 0x4000) { ppu_regs[addr & 0x07] = v; return; }
    if (addr < 0x4020) { io[addr - 0x4000] = v; return; }
    cart.cpu_write(addr, v);
}
