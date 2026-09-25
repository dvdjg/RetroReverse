# bootblock — notas

- Origen: `rom/raw/bootblock.bin` (primeros 1024 bytes del ADF; sha1 en `SOURCE`).
- Dirección de carga/ejecución: `0x000000` (bootblock de Amiga).
- Nombre en cabecera: `SOS1` (offset 0x10). Firma de disco `DOS\0` (pero **no hay filesystem**).

## Qué hace (lectura del desensamblado)

- Limpia memoria a partir de `0x120` (`0xB8` longs) y prepara el entorno.
- Abre `trackdisk.device` y `graphics.library` (strings en el propio bloque).
- Reserva y lee datos por pistas (carga el loader/SOS desde el disco).
- No usa el filesystem de AmigaDOS: el resto del disco son pistas con datos propios.

## Estado

- Desensamblado completo en `bootblock.asm`.
- Anotación fina (rutinas y contratos) **pendiente**; el interés principal está en el kernel SOS
  y los crunchers (`../sos_cruncher/`), que es donde vive el demo.
