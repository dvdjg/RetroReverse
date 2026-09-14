# Guía de interpretación de bitmaps Amiga (OCS/ECS)

Instrucciones del usuario para reconstruir de forma fiable gráficos Amiga. Aplicable a memoria en
runtime (debugger / dump de Chip RAM + custom registers) y a datos crudos de ADF.

Priorizar siempre la configuración hardware actual cuando se esté en runtime. Cuando no haya
registros disponibles (disco), usar heurísticas.

## 1. Lectura de la configuración hardware (runtime)

Registros custom (base `$DFF000`):

| Registro | Dirección | Qué extraer |
|----------|-----------|-------------|
| **BPLCON0** | `$100` | Bits 14-12 = BPU (bitplanes: 1-6). Bit 15 = HIRES. Bit 10 = DPF (dual playfield). Bit 11 = HAM. |
| **BPL1MOD / BPL2MOD** | `$108` / `$10A` | Módulo (bytes a sumar al final de cada línea). Single playfield: suelen ser iguales. |
| **BPLxPTH / BPLxPTL** | `$0E0`…`$0F6` | Punteros de 18/19 bits a cada bitplane (x = 1…6). Combinar en dirección completa de Chip RAM. |
| **DIWSTRT / DIWSTOP** | `$08E` / `$090` | Ventana de visualización (altura real visible). |
| **DDFSTRT / DDFSTOP** | `$092` / `$094` | Fetch de datos (ancho real en bytes). |
| **COLOR00…COLOR31** | `$180`…`$1BE` | Paleta actual (12-bit OCS: `0RGB`). Dual playfield: colores repartidos. |
| **BPLCON1** | `$102` | Scroll horizontal (PF1H / PF2H). |
| **BPLCON2** | `$104` | Prioridades de playfields y sprites. |

### Algoritmo de reconstrucción en runtime

1. Determinar número de bitplanes (`BPU`) y modo (lores/hires, single/dual, HAM/EHB).
2. Calcular ancho en bytes por línea:
   - Lores: normalmente 40 bytes (320 px).
   - Hires: 80 bytes (640 px).
   - Ajustar con `DDFSTRT/STOP` si el fetch es parcial.
3. Calcular altura visible con `DIWSTRT/STOP` (o asumir 200/256/312 según NTSC/PAL si no está claro).
4. Para cada bitplane `x`:
   - Dirección base = `(BPLxPTH << 16) | BPLxPTL`
   - Leer `altura × (ancho_bytes + modulo)` bytes.
5. Intercalar los bitplanes (formato planar / ACBM):
   ```
   para cada línea y:
     para cada byte x:
       para cada bitplane p:
         bit = (plane[p][y*stride + x] >> bit) & 1
         índice_color |= bit << p
   ```
6. Aplicar paleta `COLOR00…` (dual playfield: PF1 = planos impares, PF2 = pares).
7. Si hay Copper activa (`COP1LC`/`COP2LC`), analizar los `MOVE` a `BPLxPT*` y `COLORxx` para
   detectar cambios de punteros o paleta a mitad de pantalla.

## 2. Inferencia de tamaño real y detección de tiles/bobs (sin registros)

Cuando solo se tiene un bloque de memoria (dump o zona de disco):

### Heurísticas de búsqueda de bitplanes

- Buscar zonas alineadas a word (par) con alta entropía pero patrones repetitivos.
- Probar combinaciones comunes:
  - 1–6 bitplanes
  - Anchos: 16, 32, 40, 64, 80, 160 bytes (muy comunes)
  - Alturas: 8, 16, 24, 32, 40, 50, 64, 100, 200, 256…
- Calcular el "stride" más probable: si al visualizar con un ancho candidato aparece una imagen
  coherente (no ruido), es candidato.
- Detectar máscaras: muchos bobs tienen un plano extra de máscara (antes o después). Si el 5º
  plano es casi todo 1s o 0s → probable máscara.

### Detección de tilesets

1. Buscar bloques de tamaño fijo (16×16, 8×8, 32×16, 16×32 son los más frecuentes).
2. Calcular histograma de "similitud" entre bloques consecutivos.
3. Si una zona tiene muchos bloques de 16×16 (o similar) que se repiten con variaciones
   pequeñas → tileset.
4. Extraer el tileset y generar un mapa de tiles (si hay un segundo bloque que parece índices).

### Detección de bobs / sprites

- Sprites hardware: estructura de 2 words de control + datos (altura variable) + 2 words de fin
  (`$0000 $0000`).
- Bobs: normalmente planar + máscara, anchos múltiplos de 16.

## 3. Datos desde disquetes (ADF)

1. Un ADF es imagen raw de 880 KB (DD) o 1760 KB (HD).
2. Los gráficos suelen estar en:
   - Sectores de datos después del bootblock.
   - Archivos dentro del filesystem OFS/FFS (parser simple de directorio Amiga si es necesario).
3. Buscar firmas o patrones:
   - Secuencias de bitplanes consecutivos del mismo tamaño.
   - Tablas de punteros a gráficos (muy comunes en juegos).
4. Aplicar las mismas heurísticas del punto 2 sobre las zonas candidatas.

## 4. Salida esperada

Para cada gráfico encontrado generar:

```text
Tipo: Playfield / Bob / Sprite / Tileset
Bitplanes: N
Ancho: X px (Y bytes)
Alto: Z px
Modo: Lores / Hires / Dual / HAM / EHB
Paleta: [lista de colores 12-bit]
Dirección base (si runtime): $xxxxxx
Formato de almacenamiento: Planar interleaved / ACBM / con máscara antes/después
Vista previa: (descripción o datos listos para convertir a PNG)
```

Si hay incertidumbre, indicar el nivel de confianza y las hipótesis alternativas probadas.

## 5. Reglas adicionales

- **Nunca asumir que los bitplanes están en orden 1-2-3-4-5-6** sin comprobar. Algunos juegos los
  reordenan.
- **Dual playfield**: los planos impares y pares tienen módulos y punteros independientes.
- **El Copper puede cambiar punteros y colores a mitad de frame** → reconstruir por "bandas".
- Preferir siempre la información de los registros hardware cuando esté disponible. Las
  heurísticas solo se usan cuando faltan registros o para datos de disco.
- Si se detecta un tileset, intentar también encontrar el tilemap (array de índices).
- Las imágenes fuente de algunos efectos (corridor/texture-floor) pueden ser **no rectangulares**
  (trapecio/paralelepípedo con más detalle en la base). Empezar por formas rectangulares.