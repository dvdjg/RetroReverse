# Base de conocimiento: patrones de port NES→Amiga (KB creciente)

> Catálogo de **patrones reconocibles** para automatizar el port por intenciones. El decompilador
> ya es genérico (6502→C); el valor está en reconocer cómo cada juego **usa** el hardware y
> traducirlo a los motores del engine. Cada patrón que aparece se cataloga aquí una vez.

## Cómo se usa

1. Decompilar (automático) → 2. Aplicar los reconocedores de esta KB → 3. **Comparar contra el
   oráculo** (transpilado) por frame de RAM+PPU+OAM → 4. Si diverge, identificar el patrón
   desconocido y **añadirlo aquí**.

## A. Mappers

| Mapper | iNES | Qué añade | Estado |
|---|---|---|---|
| NROM | 0 | PRG/CHR sin banco; mirroring del header | Soporte base (DK). |
| UxROM | 2 | Banco PRG conmutable (`$8000-$BFFF`), CHR-ROM | Pendiente. |
| CNROM | 3 | Banco CHR (2 KB) conmutable (`$8000`) | Pendiente (afecta pattern base). |
| MMC1 | 1 | PRG+CHR banking, mirroring, RAM; escritura serie | Pendiente. |
| MMC3 | 4 | PRG/CHR banking fino + IRQ de scanline | Pendiente (IRQ = timing). |

**Regla:** el banco PRG se lee en el HAL (`rd($8000+)`); el banco CHR cambia la **pattern base**
efectiva (ver §B). El IRQ de MMC3 introduce **eventos mid-frame** → necesita el modelo de frame.

## B. Uso del PPU (intenciones + reconocedores)

| Patrón | Firma típica en el 6502 | Traducción al engine |
|---|---|---|
| Escritura de nametable | `$2006`=dir, `$2007`=valor (bloques) | `Layer.set_tile` (dirty) → metatile. |
| Atributos | `$2006`=`$23C0`, `$2007`×64 | subpaleta por celda (2 bits). |
| OAM DMA | `$4014`=página | canales sprites HW (por subpaleta). |
| Scroll | `$2005`×2, `$2000` | `Layer.scroll_to` / Copper `BPLxPT`/`BPLCON1`. |
| Paleta | `$2006`=`$3F00`, `$2007` | `COLORxx` (BG 0-15 / spr 16-31). |
| Pattern base BG/spr | `$2000` bits 4/3 | base del CHR al decodificar (¡DK lo usa!). |
| CHR RAM | escrituras a `$0000-$1FFF` en CHR-RAM | (DK no; los de CHR-ROM se **ignoran**). |
| Split raster | cambios de `$2000/$2005/$2006` en NMI/bucle | zonas de Copper (mid-frame) → **caso**. |
| Apagado de render | `$2001`=0 (blanking) durante updates | evita tearing; el render puede seguir. |

**Sospecha de patrón especial:** cuando el juego escribe `$2006/$2007` **a mitad de frame** (no en
VBlank) esperando efecto raster → requiere Copper por banda; marcarlo como `special`.

## C. APU → Paula

| Patrón | Traducción |
|---|---|
| Canales de pulso/triángulo/ruido | canales Paula (o mixer) por nota. |
| DMC | muestras → canal de audio. |
| Envelopes/barridos | tabla/reconocedor por juego. |

## D. Bucle y sincronía

| Patrón | Firma | Implicación |
|---|---|---|
| Main-loop spin + NMI | `JSR prng; JMP spin` (DK `$C7E1`) | El nº de iteraciones depende del timing → la RAM (PRNG) **diverge** entre port y oráculo. Acotado; alinear el modelo de frame si importa la fidelidad. |
| Espera de VBlank | poll de `$2002` bit 7 | el HAL ya lo modela (`frame_event`). |
| IRQ mapper | MMC3 scanline | evento mid-frame; requiere el modelo de frame fino. |

## E. Registro de hallazgos del pipeline

- **DK (NROM):** BG en pattern table `$1000`; sprites en `$0000`; escribe `$03C0-$03FF` (CHR) que
  **no** debe tocar la nametable; el asterisco del título es un **sprite**; la RAM diverge en el
  PRNG (bucle principal). Todo esto ya resuelto o catalogado aquí.
