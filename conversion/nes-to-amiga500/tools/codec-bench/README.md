# tools/codec-bench — batería de selección de códecs (proyecto B)

Proyecto **B**: determina **qué algoritmo de compresión y qué pre-procesado (filtro)** conviene a
cada tipo de dato del pipeline NES→Amiga. Su veredicto decide los códecs que usa el empaquetador
**A** ([`../packer`](../packer/README.md)) y, por tanto, el formato `RRPK`.

> 📄 **Estudio completo (método, tablas, análisis y decisión): [`docs/STUDY.md`](docs/STUDY.md).**
> Tablas completas: [`results/RATIOS.md`](results/RATIOS.md) · datos crudos:
> [`results/bench_3roms.csv`](results/bench_3roms.csv).

## Qué se ha medido

- **3 ROMs**: Donkey Kong (`dk`), Super Mario Bros (`smb`), Galaga (`galaga`).
- **Tipos de segmento**: `nes_prg` (código 6502+datos), `nes_chr` (tiles), `m68k_text` (código
  68000 transpilado a `-m68000` con GCC 15.1), `m68k_data` (`.rodata` del transpilado).
- **10 códecs** × **9 filtros reversibles** = 1080 compresiones (media de las 3 ROMs).

Resultados: [`results/RATIOS.md`](results/RATIOS.md) · datos crudos
[`results/bench_3roms.csv`](results/bench_3roms.csv).

## Veredicto (detalle en results/RATIOS.md)

| Tipo | Mejor ratio | Mejor con decruncher rápido (A500) | Filtro |
|---|---|---|---|
| `m68k_text` (código 68000) | shrinkler 20.3 % | **zx0 23.4 %** / aplib 23.2 % | `none` |
| `m68k_data` (.rodata) | shrinkler 37.1 % | **zx0/deflate 38.2 %** | `none` |
| `nes_prg` (PRG) | shrinkler 60.2 % | **deflate 62.0 %** / zx0 62.1 % | `none` |
| `nes_chr` (CHR) | shrinkler 50.7 % | **deflate 51.9 %** / aplib 53.9 % | `none` |

**Conclusiones:**

1. **Los filtros no ayudan** con códecs LZ modernos: `none` gana en los 4 tipos. `eo` es el único
   alternativo razonable en código 68000 (25.5 % vs 20.3 % de shrinkler; sigue peor que `none`).
2. **Shrinkler comprime más** en todo, pero su decruncher es más grande y lento → se reserva como
   opción "máximo ratio a costa de tiempo de carga", no como opción por defecto en A.
3. **ZX0 y aPLib** son prácticamente equivalentes y los mejores entre los de decruncher pequeño
   (código). **Deflate** gana ligeramente en CHR/PRG.
4. **RNC1/RNC2** quedan descartados: el `.exe` decompilado no es reentrante y, en la muestra
   medida (galaga `.text`), RNC1 = 28.6 % y RNC2 = 33.2 % frente a 26.0 % de ZX0.
5. **PowerPacker** da resultados anómalos con filtros en PRG (51–55 %) que no son fiables; se
   descarta.

## Uso

```bash
scripts/fetch_build_codecs.sh     # descarga+compila los códecs en external/ (WSL)
scripts/gen_corpus.sh             # PRG/CHR desde .nes
powershell -File scripts/gen_corpus_m68k.ps1   # código 68000 desde los .cpp transpilados
python3 scripts/bench_3roms.py    # regenera results/RATIOS.md y el CSV
```

## Notas de método

- `deflate` se midió con zopfli `--i5` (compresión offline; en A500 descomprime con un inflate
  pequeño, p. ej. el de Keir Fraser).
- `shrinkler` en modo datos (`-d -3`).
- `zx0`, `aplib` (apultra), `lzsa1/2`, `lz4`, `pp` con sus ajustes por defecto/máximos.
- El corpus 68000 se genera compilando los `.cpp` del transpilador con el cross GCC 15.1 y
  enlazando con `--unresolved-symbols=ignore-all -Ttext=0x10000` para que las relocaciones internas
  (tabla de despacho) apunten a direcciones reales.
