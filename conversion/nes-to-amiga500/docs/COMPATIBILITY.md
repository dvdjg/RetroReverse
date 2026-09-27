# Matriz de compatibilidad (oráculo vs `mesen`)

Diff **estructural** (luminancia, tolerante a la paleta) del framebuffer del oráculo contra **mesen**
a 60 frames, por ROM de `runtime/build/*.nes`. Regenerar: `bash runtime/test/port_matrix.sh`.

| ROM | estructura(lum) vs mesen |
|---|---:|
| bf, dk, dkjr, exb, kungfu, mariobros, mspacman, popeye | **0.0%** |
| smb | 3.1% |
| xevious | 4.4% |
| pacman | 12.9% |
| galaga | 36.4% |
| ic | 92.2% |

## Lectura

- **0.0% (8 juegos)**: geometría/tiles idénticos a `mesen`; lo que queda es solo paleta.
- **smb 3.1% / xevious 4.4%**: residual de timing (SMB, ver `RISKS.md`) y del cruce de nametable
  (Xevious).
- **pacman 12.9% / galaga 36.4%**: conocidos por **deriva de frames** (nuestro emulador no es
  dot-exacto sub-ciclo); a más frames, la comparación se desalinea.
- **ic 92.2%**: **bug real confirmado**. El framebuffer sale de **un solo color** (fondo): la
  **paleta no se carga**. Evidencia (traza `$2007` a 60 frames): solo se escribe `palette[0x1F]`;
  el juego escribe a `$3F1F,$3F3F,…` (paso `$20`) con valor `$5F` — un run de relleno de la
  nametable (`$3D5F+0x20k`) que **desborda hacia `$3F00+`** (paleta) y a `$4000+` (patrón). El
  render es correcto dado una paleta vacía; el fallo está en la **carga de paleta** (la rutina que
  fija `v=$3F00` en `$80A8` hace un "warm-up" y luego `v=$0000`; el cargador real no llega a
  escribir `$3F00-$3F1E`). Pendiente de trazar `$2006` para localizar el cargador y ver por qué no
  corre.

## Por qué esta matriz importa para el Amiga

Es la **referencia congelada** contra la que se validará el backend Amiga sin rehacer nada: el Amiga
se compara con el **oráculo** (mismos `hash`/estructura), y esta tabla dice qué se espera de cada
juego hoy. Ver [`PORT_TEST_PLAN.md`](PORT_TEST_PLAN.md).
