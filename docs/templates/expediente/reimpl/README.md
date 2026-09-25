# reimpl — recreación en C++

Destino final del expediente: reescribir como **algoritmo propio** cada técnica recuperada.

**Contrato de técnica y uso en el engine**: ver [`../../PORTING.md`](../../../../PORTING.md)
(funcionamiento + C/C++ de referencia + ASM canónico + contrato de llamada/ABI + checklist).

## Reglas

- Una carpeta por técnica: `reimpl/<tecnica>/`.
- `README.md` explica de qué código recuperado sale y cómo se porta (mapeo de registros,
  tablas, invariantes).
- Código en `src/`. Si es matemática/algoritmo puro, que compile en **host** para test rápido;
  si toca hardware, como demo Amiga (toolchain `m68k-amiga-elf-g++`).
- No copiar código del original: portar la idea (ver `../../LECCIONES_APRENDIDAS.md` §8).
- Estado por técnica: `TODO` / `WIP` / `PORTADO`.

## Índice

| Técnica | Origen (módulo/rutina) | Estado |
|---|---|---|
| | | |
