#include "cartridge.hpp"

#include <cstdio>
#include <fstream>
#include <iterator>
#include <stdexcept>

bool Cartridge::load(const std::string& path) {
    std::ifstream f(path, std::ios::binary);
    if (!f) return false;
    std::vector<std::uint8_t> d((std::istreambuf_iterator<char>(f)), std::istreambuf_iterator<char>());
    if (d.size() < 16 || d[0] != 'N' || d[1] != 'E' || d[2] != 'S' || d[3] != 0x1A) return false;

    const int prg_banks = d[4];
    const int chr_banks = d[5];
    const std::uint8_t flags6 = d[6];
    const std::uint8_t flags7 = d[7];
    mapper_ = (flags7 & 0xF0) | (flags6 >> 4);
    vertical_ = (flags6 & 0x01) != 0;  // 0=horizontal, 1=vertical
    const std::size_t trainer = (flags6 & 0x04) ? 512 : 0;
    const std::size_t off = 16 + trainer;
    const std::size_t prg = static_cast<std::size_t>(prg_banks) * 0x4000;
    const std::size_t chr = static_cast<std::size_t>(chr_banks) * 0x2000;
    if (off + prg > d.size()) return false;
    prg_.assign(d.begin() + off, d.begin() + off + prg);
    const std::size_t chr_off = off + prg;
    if (chr_off + chr <= d.size()) chr_.assign(d.begin() + chr_off, d.begin() + chr_off + chr);
    return true;
}

std::uint8_t Cartridge::cpu_read(std::uint16_t addr) const {
    if (addr >= 0x8000 && !prg_.empty()) {
        std::size_t idx = addr - 0x8000;
        if (prg_.size() == 0x4000) idx &= 0x3FFF;  // NROM-128: 16 KiB espejados
        return prg_[idx % prg_.size()];
    }
    if (addr >= 0x6000 && addr < 0x8000) return prg_ram_[addr - 0x6000];
    return 0;
}

void Cartridge::cpu_write(std::uint16_t addr, std::uint8_t v) {
    if (addr >= 0x6000 && addr < 0x8000) prg_ram_[addr - 0x6000] = v;
    // Mappers 1-4: pendiente de implementar.
}

std::uint8_t Cartridge::ppu_read(std::uint16_t addr) const {
    if (chr_.empty()) return 0;
    return chr_[addr % chr_.size()];
}
