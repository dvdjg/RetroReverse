# examples — ROMs y escenarios de prueba

ROMs **propias** (homebrew o generadas por nosotros) para el *vertical slice*. **No se versionan
binarios**; aquí se documenta cómo generarlas y qué validan.

| Escenario | Mapper | Valida |
|---|---|---|
| ROM mínima | NROM | CPU, bus, arranque, paleta, un scroll |
| Homebrew scroll 8-way | NROM | motor de tiles + Copper (F5) |
| Escena de sprites densa | NROM/UxROM | sprites HW + multiplex + bobs (F6) |
| Demo de audio | NROM | APU → Paula (F7) |
| Juegos por mapper | 0/2/3/1/4 | bankswitching (F9) |

Reglas:
- Contenido **propio** o de dominio público; ver [`../../../docs/LEGAL.md`](../../../docs/LEGAL.md).
- Cada escenario indica `sha1`, comando de generación y frames comparados
  ([`../docs/VALIDATION.md`](../docs/VALIDATION.md)).
