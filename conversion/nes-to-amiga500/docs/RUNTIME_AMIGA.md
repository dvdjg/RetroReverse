# Runtime Amiga — Chip RAM, pantalla, VBlank, bucle principal e input

Contrato del runtime de destino (donde viven el código transpilado y los motores). Objetivo A500
OCS/ECS: 68000, 512 KB Chip, PAL/NTSC.

## Configuración de pantalla (recomendada)

| Parámetro | Valor | Motivo |
|---|---|---|
| Resolución | 256×240 (256×224 visibles) | exacta a NES NTSC |
| Modo | **Dual Playfield** (3+3 = 6 planos) | dos capas, scroll y prioridad independientes |
| Alternativa | 5 planos normales | si se necesitan más colores |
| Copper | uso agresivo | paletas por franja, splits, multiplex de sprites |
| Sprites HW | 8 + multiplexado | sprites NES |
| Blitter | pesado | actualización de tiles/bobs |

## Chip RAM

Todo lo que el hardware lee debe estar en Chip RAM (`MEMF_CHIP | MEMF_CLEAR`):

| Bloque | Tamaño aprox. | Uso |
|---|---|---|
| Bitmap | ≈ 52 KB | DPF 272×256 × 6 planos |
| Copper0 + Copper1 | ≈ 16 KB | doble buffer de Copperlist |
| Sprite data | ≈ 4 KB | gráficos convertidos |
| Audio buffer | ≈ 2 KB | muestras para el mixer |
| **Total** | **≈ 75 KB** | cabe en 512 KB (dejando sitio para la ROM en RAM) |

```cpp
constexpr int SCREEN_W = 256, SCREEN_H = 240;
constexpr int BUFFER_W = 272, BUFFER_H = 256;     // margen de scroll
constexpr int BPL_COUNT = 6;                       // DPF 3+3
constexpr int BYTES_PER_ROW = BUFFER_W / 8;        // 34
constexpr int BITMAP_SIZE = BYTES_PER_ROW * BUFFER_H * BPL_COUNT;

struct ChipResources {
    uint8_t*  bitmap = nullptr;
    uint16_t* copper0 = nullptr;
    uint16_t* copper1 = nullptr;
    uint16_t* sprite_data = nullptr;
    int8_t*   audio_buffer = nullptr;
    size_t bitmap_size = 0, copper_size = 0, sprite_size = 0, audio_size = 0;
};

bool allocate_chip_resources(ChipResources& r) {
    r.bitmap_size = BITMAP_SIZE;
    r.bitmap = (uint8_t*)AllocMem(r.bitmap_size, MEMF_CHIP | MEMF_CLEAR);
    r.copper_size = 4096 * sizeof(uint16_t);
    r.copper0 = (uint16_t*)AllocMem(r.copper_size, MEMF_CHIP | MEMF_CLEAR);
    r.copper1 = (uint16_t*)AllocMem(r.copper_size, MEMF_CHIP | MEMF_CLEAR);
    r.sprite_size = 64 * 32 * 2 * sizeof(uint16_t);
    r.sprite_data = (uint16_t*)AllocMem(r.sprite_size, MEMF_CHIP | MEMF_CLEAR);
    r.audio_size = 2048;
    r.audio_buffer = (int8_t*)AllocMem(r.audio_size, MEMF_CHIP | MEMF_CLEAR);
    return r.bitmap && r.copper0 && r.copper1 && r.sprite_data && r.audio_buffer;
}
```

## Init de pantalla y VBlank

```cpp
volatile struct Custom* const custom = (volatile struct Custom*)0xDFF000;

void init_screen(const ChipResources& r) {
    custom->dmacon = 0x7FFF;           // clear DMA
    custom->intena = 0x7FFF;           // clear interrupts

    custom->diwstrt = 0x2C81;          // VSTART=0x2C, HSTART=0x81 (PAL, ajustar)
    custom->diwstop = 0x1CC1;          // VSTOP=0x2C+240, HSTOP
    custom->ddfstrt = 0x0038; custom->ddfstop = 0x00D0;

    custom->bplcon0 = 0x6600;          // DPF + 6 planos
    custom->bplcon1 = 0x0000;          // scroll fino
    custom->bplcon2 = 0x0024;          // prioridades
    custom->bpl1mod = 2; custom->bpl2mod = 2;   // (272-256)/8
    custom->color[0] = 0x0000;
    // punteros BPLxPT: los escribe la Copperlist cada frame
    custom->dmacon = 0x87E0;           // SET | BITPLANE|COPPER|SPRITE|BLITTER|MASTER
}

volatile bool g_vblank = false;
void __attribute__((interrupt)) vblank_handler() {
    custom->intreq = 0x0020; g_vblank = true;   // acknowledge VERTB
}
void install_vblank() {
    Forbid();
    old_vblank = *(InterruptHandler*)0x6C;      // nivel 3 (VBR=0, A500 clásico)
    *(InterruptHandler*)0x6C = vblank_handler;
    custom->intena = 0x8020; custom->intreq = 0x0020;
    Permit();
}
```

## Detección de fin de frame (NMI) y `run_nes_frame`

El PPU software avanza 3 ciclos por ciclo de CPU y marca `frame_complete` en la pre-render (línea
261) y `nmi_pending` en la 241.

```cpp
void run_nes_frame(NESMemory& mem) {
    CPU& cpu = mem.cpu; PPU& ppu = mem.ppu;
    ppu.clear_frame_flag(); ppu.clear_nmi();
    constexpr int MAX_CYCLES = 30000;
    int used = 0;
    while (!ppu.frame_complete()) {
        if (ppu.nmi_pending()) { ppu.clear_nmi(); cpu.PC = cpu.read16(0xFFFA); }  // NMI
        uint16_t pc = cpu.PC;
        auto fn = dispatch_table[pc];
        if (fn) fn(cpu); else interpret_one_instruction(cpu);
        int cycles = cpu.last_block_cycles();
        ppu.clock(cycles); mem.apu.clock(cycles);
        if ((used += cycles) > MAX_CYCLES) break;   // anti-cuelgue
    }
}
```

## Bucle principal

```cpp
void emulator_main_loop(Emulator& emu) {
    // init: chip RAM, pantalla, VBlank, motores, ROM/reset
    while (emu.running) {
        wait_vblank();
        // 1. activar Copperlist del frame anterior (doble buffer)
        // custom.cop1lc = (u32)emu.copper_buf[emu.copper_toggle]; emu.copper_toggle ^= 1;
        // 2. ejecutar un frame de la NES (transpilado)
        run_nes_frame(*emu.mem);
        // 3. motores
        emu.tiles->update();                                  // Blitter dirty strips
        emu.sprites->update(emu.mem->scroll_x(), emu.mem->scroll_y());
        emu.sprites->draw_bobs();
        std::array<int8_t, 256> audio; emu.apu->generate_samples_8(audio); // mixer_play(audio);
        // 4. construir nueva Copperlist
        uint16_t* p = emu.copper_buf[emu.copper_toggle];
        PPUView view = emu.mem->get_ppu_view();
        p += emu.copper->generate(view, p);
        emu.sprites->build_copper_sprite_list(p);
        *p++ = 0xFFFF; *p++ = 0xFFFE;
        // 5. input para el siguiente frame
        emu.mem->input.update_from_amiga();
        emu.frame_count++;
    }
}
```

## Input (`$4016`/`$4017`)

Protocolo serie con *strobe*; el estado se actualiza una vez por frame desde joystick/teclado:

```cpp
void Input::write(uint16_t addr, uint8_t v) {
    if (addr == 0x4016) { strobe_ = (v & 1); if (strobe_) { shift1_ = capture(pad1); shift2_ = capture(pad2); } }
}
uint8_t Input::read(uint16_t addr) {
    uint8_t bit = (addr == 0x4016 ? shift1_ : shift2_) & 1;
    if (!strobe_) { (addr == 0x4016 ? shift1_ : shift2_) >>= 1; }
    return bit | 0x40;
}
// Orden oficial: A, B, Select, Start, Up, Down, Left, Right
```

## Orden por frame (resumen)

| # | Paso | Por qué |
|---|---|---|
| 1 | Esperar VBlank | sincronización estable |
| 2 | Activar Copperlist anterior | el HW ya puede usarla |
| 3 | Ejecutar código NES | genera los cambios del frame |
| 4 | Tiles (Blitter) | el fondo debe estar listo |
| 5 | Sprites + bobs | depende del OAM del paso 3 |
| 6 | Audio | puede solaparse |
| 7 | Generar Copperlist | usa la info actualizada |
| 8 | Input / trabajo de emulador | no crítico para el frame actual |

## Pendiente (F0)

Falta de este diseño: **carga de la ROM iNES + creación del mapper**, y afinar
centrado PAL/NTSC (`DIWSTRT/STOP`, `DDFSTRT/STOP`, `FIRST_VISIBLE`).
