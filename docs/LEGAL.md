# Legalidad y licencias

Principio: el **sistema** (emuladores open-source + instrumentación propia + análisis) es legal.
Lo que hay que cuidar es el **material de terceros**: ROMs y assets originales.

## Reglas

1. **Solo ROMs propias**. Nada de descargas de ROMs de terceros ni redistribución de ROMs.
2. **No versionar** ROMs, assets originales ni binarios/savestates que los contengan (usar
   `.gitignore` por juego; `git-lfs`/almacenamiento local **solo** en repos privados).
3. **Documentar ideas/algoritmos**, no redistribuir el código ajeno. La **reimplementación** es
   propia; el desensamblado y los assets se conservan como **referencia de estudio**.
4. **Material de la comunidad** (dossiers, desensamblados, docs): citar y enlazar; **no** copiar
   bloques extensos. Ver [`RESEARCH_FIRST.md`](RESEARCH_FIRST.md).
5. **Repos privados** mientras contengan material de terceros. Si un repo pasa a **público**,
   excluir binarios/assets originales y conservar solo análisis, HIGS, assets decodificados
   (cuando su licencia lo permita) y reimplementación propia.

## Licencia del código del marco

- **Contenido propio** (orquestador, tools, docs, reimplementaciones): **MIT** (o la que se decida
  para el marco). Las reimplementaciones no contienen código ajeno.
- **Material de terceros** (ROMs, assets originales, desensamblados): **no** cubierto por esa
  licencia; derechos de sus autores.

## Atribución y trazabilidad

- Cada juego documenta en `docs/RESEARCH.md` las **fuentes** usadas (comunidad + propias).
- Las **mecánicas/inferencias** llevan confianza y evidencia; si proceden de una fuente, se cita.
- Los **assets** registran origen y método de decodificación en `assets.json`.

## Riesgos concretos

| Riesgo | Mitigación |
|---|---|
| Distribuir ROMs/assets originales | no versionarlos; repo privado; excluir al publicar |
| Copiar un desensamblado ajeno a la reimpl | la reimpl consume **solo** la HIGS (prohibido mirar el asm) |
| Reutilizar assets de la comunidad sin licencia | usar solo lo que permita su licencia; si no, extraer del propio dump |
| Publicar specs derivadas de material con copyright | las specs describen **ideas/tiempos**; evitar reproducir tablas de datos protegidas |

> Aplica también a `Amiga-Reverse`: ver `LECCIONES_APRENDIDAS.md` §8 y
> `platforms/computers/amiga500/demos/arte/recovered/README.md`.
