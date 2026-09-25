#ifndef RR_NES_CARTRIDGE_HPP
#define RR_NES_CARTRIDGE_HPP

#include <cstdint>
#include <string>
#include <vector>

// Cartucho iNES. Mapper 0 (NROM) implementado; base para 1/2/3/4.
class Cartridge {
public:
    bool load(const std::string& path);

    std::uint8_t cpu_read(std::uint16_t addr) const;
    std::uint8_t ppu_read(std::uint16_t addr) const;
    void cpu_write(std::uint16_t addr, std::uint8_t v);

    int mapper() const { return mapper_; }
    int prg_bytes() const { return static_cast<int>(prg_.size()); }
    int chr_bytes() const { return static_cast<int>(chr_.size()); }
    bool mirroring_vertical() const { return vertical_; }
    bool valid() const { return !prg_.empty(); }

private:
    std::vector<std::uint8_t> prg_, chr_;
    std::vector<std::uint8_t> prg_ram_ = std::vector<std::uint8_t>(0x2000, 0);
    int mapper_ = 0;
    bool vertical_ = false;
};

#endif  // RR_NES_CARTRIDGE_HPP
