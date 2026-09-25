# ADR 0001 — Monorepo por plataforma → placa → juego

- **Estado**: aceptado
- **Fecha**: 2026

## Contexto

El marco debe cubrir muchas plataformas (arcade, consolas, ordenadores) y muchos juegos, con áreas
compartidas (emuladores, tools, frontend) y áreas por juego (rom, extraction, assets, spec, reimpl).
Se necesita una estructura que evite duplicación y deje claro qué es compartido y qué es de un juego.

## Decisión

Monorepo con jerarquía **plataforma → arquitectura/placa → [variante] → juego**, más áreas
compartidas (`emulators/`, `frontend/`, `tools/`, `scripts/`, `docs/`). Cada juego es un
**leaf node** autocontenido (`rom/ extraction/ assets/ spec/ reimplementation/`).

## Consecuencias

- ✅ Hardware compartido (p. ej. `sega_system16`) se documenta **una vez**; los juegos lo heredan.
- ✅ Se distingue evidencia (`extraction/`), curaduría (`spec/`, `assets/`) y código (`reimplementation/`).
- ✅ Un juego nuevo = copiar el leaf node; no toca el núcleo.
- ⚠️ Riesgo de nodos poco poblados (categorías casi vacías al inicio) → se acepta; el tiempo las llena.
- ⚠️ Requiere higiene de `.gitignore` por juego para no versionar ROMs/assets originales.

## Alternativas consideradas

- **Un repo por juego**: mucha duplicación de tooling/emuladores; descartado.
- **Monorepo plano (todos los juegos juntos)**: no expresa herencia de hardware; descartado.
