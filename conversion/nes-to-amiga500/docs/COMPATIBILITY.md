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
- **ic 92.2%**: **anómalo** → candidato a **bug real** de render (tiles/sprites/nametable) o a
  deriva severa. Pendiente de investigar.

## Por qué esta matriz importa para el Amiga

Es la **referencia congelada** contra la que se validará el backend Amiga sin rehacer nada: el Amiga
se compara con el **oráculo** (mismos `hash`/estructura), y esta tabla dice qué se espera de cada
juego hoy. Ver [`PORT_TEST_PLAN.md`](PORT_TEST_PLAN.md).
