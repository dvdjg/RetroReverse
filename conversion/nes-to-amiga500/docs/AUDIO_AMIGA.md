# Audio — APU de la NES → Paula

El APU de la NES (2 pulse, triangle, noise, DMC + frame counter) se sintetiza en software y se
entrega a **Paula**. En un A500 el cuello de botella es la **CPU**, no Paula; por eso se genera por
bloques y se evita el trabajo por muestra en el bucle principal.

## Arquitectura

```
Código transpilado  →  write($4000-$4017)
                            ↓
                    ┌───────────────┐
                    │   class APU   │  (estado de los 5 canales + frame counter)
                    └───────┬───────┘
                            │  generate_samples()  (por bloques de 128-256)
                            ▼
                    buffer circular de samples
                            ↓
              Paula (DMA) o AmigaAudioMixer (engine Amiga-Cpp)
```

## Interfaz

```cpp
class APU {
public:
    explicit APU(uint32_t sample_rate = 22050);
    void write(uint16_t addr, uint8_t value);   // desde NESMemory::write
    uint8_t read_status();                      // $4015
    void generate_samples(std::span<int16_t> out);
    void generate_samples_8(std::span<int8_t> out);   // para el mixer 8-bit
    void reset();
    void set_sample_rate(uint32_t hz);
    void set_master_volume(float v);
    void set_memory_reader(uint8_t(*)(uint16_t, void*), void* user);  // DMC
};
```

Enganche en el bus:

```cpp
void NESMemory::write(uint16_t addr, uint8_t value) {
    if (addr >= 0x4000 && addr <= 0x4017) { apu.write(addr, value); return; }
    // ...
}
uint8_t NESMemory::read(uint16_t addr) {
    if (addr == 0x4015) return apu.read_status();
    // ...
}
```

## Canales

| Canal | Tipo | Registros | Notas |
|---|---|---|---|
| Pulse 1/2 | cuadrada | `$4000-$4007` | duty 12.5/25/50/75 %, envelope, sweep |
| Triangle | triángulo | `$4008-$400B` | sin volumen, linear counter |
| Noise | ruido | `$400C-$400F` | LFSR 15-bit, 2 modos, envelope |
| DMC | samples | `$4010-$4013` | modulación delta, lee de memoria |

Frame counter `$4017` (modo 4/5 pasos) relojea envelope/length/sweep.

## Tablas en tiempo de compilación

El APU usa `consteval` para las tablas clásicas de NESdev:

```cpp
consteval std::array<float, 31> make_pulse_table() {
    std::array<float, 31> t{}; t[0] = 0;
    for (int n = 1; n < 31; ++n) t[n] = 95.88f / (8128.0f / n + 100.0f);
    return t;
}
consteval std::array<float, 203> make_tnd_table() {
    std::array<float, 203> t{}; t[0] = 0;
    for (int n = 1; n < 203; ++n) t[n] = 163.67f / (24329.0f / n + 100.0f);
    return t;
}
```

Además: `DUTY_TABLE[4][8]`, `TRIANGLE_SEQUENCE[32]`, `LENGTH_TABLE[32]`,
`NOISE_PERIOD_TABLE[16]`, `DMC_RATE_TABLE[16]`.

## Mezcla

```cpp
float pulse_out = PULSE_TABLE[pulse1.output() + pulse2.output()];
float tnd_out   = TND_TABLE[3*triangle.output() + 2*noise.output() + dmc.output];
float sample    = (pulse_out + tnd_out) * master_volume_;
```

## Generación y temporización

- `cpu_cycles_per_sample_ = 1789773.0 / sample_rate` (NTSC).
- Se acumulan ciclos de CPU por muestra y se relojean los timers de forma aproximada (pulse/noise
  cada 2 ciclos, triangle cada 1, DMC por tabla, frame counter cada 7458).
- **Generar por bloques** (128-256 muestras) para caché y para el mixer.

## Opciones de salida en A500

| Opción | Ventaja | Inconveniente |
|---|---|---|
| 1 canal Paula con mezcla software (22 kHz) | fiel, sencillo | CPU (mitigado por bloques) |
| Aproximar canales con Paula (periodos + volúmenes) | casi sin CPU | menos fiel |
| DMC desactivado al principio | ahorra lo más caro | falta percusión sampleada |

Recomendado: empezar con **1 canal Paula + mezcla software a 22 kHz**; evaluar 11 kHz si el frame no
llega. El **DMC** puede leerse con un callback de memoria o posponerse.

## Integración con el motor Amiga

Rellenar el buffer del mixer (repo hermano `Amiga-Cpp`, no se toca desde aquí) en la fase 4.4 del
bucle principal:

```cpp
std::array<int8_t, 256> audio_buf;
apu.generate_samples_8(audio_buf);
// mixer_play(audio_buf);   // API del mixer del engine
```

No hace falta que coincida con el VBlank; basta con no dejar el buffer vacío.

## Estado

APU (F7) **pendiente**: la especificación completa (implementación C++23 de referencia con los 5
canales, envolventes, sweep, DMC y frame counter) queda descrita aquí como contrato.
