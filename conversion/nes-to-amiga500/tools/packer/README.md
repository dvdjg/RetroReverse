# tools/packer — utilidad de empaquetado (formato RRPK)

Proyecto **A**: programa de host (C++23) que toma **ficheros transpilados para Amiga** (el
`<juego>.m68k.n2x`, secciones crudas de código/datos, ROMs PRG/CHR…) y produce **un contenedor
comprimido `RRPK`** listo para que el cargador del Amiga lo descomprima y salte a ejecutarlo.

Para cada **zona** (segmento) del binario de entrada prueba varias combinaciones de
**filtro reversible × algoritmo de compresión**, se queda con la que menos ocupa y registra en la
**cabecera** qué códec, filtro y tipo tiene cada segmento, con sus offsets y tamaños. El resultado
del análisis que decide *qué* combinaciones merecen la pena es el proyecto **B**
([`../codec-bench`](../codec-bench/README.md)).

## Por qué no 7‑zip

El Amiga 500 (68000 @7 MHz) tiene que **descomprimir en el arranque**. 7z/Deflate máximo dan buen
ratio pero su decruncher es grande y lento. El formato usa decrunchers pequeños y rápidos
(ZX0, aPLib) para el código, y Deflate solo donde aporta (gráficos/datos).

## Formato y códecs

- Especificación del contenedor: [`docs/FORMAT.md`](docs/FORMAT.md).
- **Decisión ([ADR 0006](../../../../docs/adr/0006-compresion-zx0.md)): ZX0 para todo**, con
  `store` de respaldo (si ZX0 no reduce). El campo `codec` por segmento se mantiene extensible.
- Códecs implementados: `store` y `zx0` (vendorizado, BSD‑3). `aplib`/`deflate`/`shrinkler` quedan
  reservados (medidos en B; descartados por ratio/decoder).
- **Filtro: `none`**. El banco de B mostró que ningún filtro (`delta`, `evenodd`, bitplanes…)
  mejora el ratio con ZX0; los demás valores de `enum Filter` quedan **reservados** en el formato.

## Uso

```bash
make                      # compila vendor/ + el packer
build/packer --list  juego.rrpk
build/packer --unpack juego.rrpk salida/
build/packer --verify juego.rrpk                 # round-trip de todos los segmentos
build/packer codigo.bin:code datos.bin:data -o juego.rrpk
```

`fichero:type` etiqueta el tipo de segmento (`code`, `data`, `prg`, `chr`, `other`) para que la
elección de códec use las preferencias aprendidas por B. Sin etiqueta se asume `other` (= `none`).

## Integración con la emisión del artefacto Amiga

[`pack_amiga.sh`](pack_amiga.sh) es el punto de llamada desde el pipeline de conversión: toma el
código/datos 68000 (`.text`/`.rodata` extraídos por
[`../codec-bench/scripts/gen_corpus_m68k.ps1`](../codec-bench/scripts/gen_corpus_m68k.ps1)) y la
ROM `.nes`, y produce el `.rrpk` etiquetando cada rango (`code`/`data`/`prg`/`chr`). El transpilador
(`nes_transpiler --emit-lib`) debe invocarlo para el destino Amiga cuando exista el build del plugin
en 68000; ver el contrato en
[`../transpiler/README.md`](../transpiler/README.md#empaquetado-para-amiga-rrpk).

```bash
packer/pack_amiga.sh code.bin data.bin juego.nes juego.rrpk
```

## Estado

- [x] Contenedor `RRPK` + cabecera con tabla de segmentos (códec/filtro/tipo/offsets).
- [x] Códec ZX0 (compresor vendorizado + decodificador propio) y `store` de respaldo.
- [x] Round-trip PC (`--verify`) y resultado real (dk: 288858 → 76639 B, 26.5 %).
- [x] Integración (`pack_amiga.sh`) y decruncher ASM 68k vendorizado (`vendor/zx0/asm68000/`).
- [ ] Ensamblar y probar el decruncher 68k en emulador (fase Amiga, cuando exista el engine).
