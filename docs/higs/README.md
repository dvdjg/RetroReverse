# HIGS — esquema, ejemplo y lint

Artefactos del contrato **HIGS** (Hardware-Independent Game Spec). Concepto en
[`../HIGS.md`](../HIGS.md); este directorio contiene el **esquema ejecutable** y un **ejemplo**.

| Fichero | Qué es |
|---|---|
| `game.schema.json` | **JSON Schema (draft 2020-12)** de una spec de juego |
| `examples/pacman.game.json` | Ejemplo de instancia válida (Pac-Man) |

## Uso por juego

Cada nodo de juego tiene su `spec/` (ver [`../REPO_LAYOUT.md`](../REPO_LAYOUT.md)). La spec completa
se valida contra este esquema. Ejemplo de árbol:

```
spec/
  game.json                  # instancia raíz (valida contra game.schema.json)
  state_machines/*.json      # opcional: se pueden separar y referenciar
  timing_rules.yaml          # opcional (YAML) para secuencias largas
```

## Validar (JSON Schema)

```bash
# con Python (jsonschema)
python -m jsonschema -i spec/game.json docs/higs/game.schema.json

# o Node (ajv-cli)
npx ajv-cli validate -s docs/higs/game.schema.json -d spec/game.json
```

## Lint (reglas más allá del esquema)

El esquema valida **forma**; el `HIGS lint` valida **coherencia**. Reglas:

1. **Sin términos de hardware**: prohibido en `spec/` (solo metadato en `platform_origin`). Lista
   negra: `Z80`, `68000`, `m68k`, `PPU`, `APU`, `Denise`, `Agnus`, `Paula`, `VRAM`, `$DFF`,
   direcciones hex de registros, etc.
2. **Assets existentes**: toda ruta en `assets[]` existe bajo `assets/`.
3. **Evidencia resoluble**: todo `id` citado en `confidence/evidence` de reglas/entidades existe
   en `evidence[]`; y cada `refs[].path` existe (o está marcado como pendiente).
4. **Unidades**: `tick_hz` presente y coherente con `timing_sequences` (`at_tick` en esa unidad).
5. **Confianza**: todo hallazgo con `confidence: baja` debe tener evidencia o estar en la lista de
   lagunas de `docs/RESEARCH.md`.
6. **Sin copia del asm**: `mechanics.rules.description` no debe contener volcados de instrucciones
   ni opcodes.
7. **Mapas**: filas de `grid` con la misma longitud; `legend` cubre todos los caracteres usados.

## Validación local y en CI

```bash
bash scripts/validate-higs.sh      # valida docs/higs/examples/*.json y todas las */spec/game.json
```

- Script de lint: [`higs_lint.py`](higs_lint.py) (usa `jsonschema` si está; si no, avisa y aplica
  solo las reglas de coherencia).
- CI: [`.github/workflows/validate.yml`](../../.github/workflows/validate.yml) instala `jsonschema`
  y ejecuta el script en cada push/PR.

`HIGS lint` se irá ampliando (reglas R2/R5/R6 y regresión diferencial) según avance el marco.

## Versionado

- `schema_version` es **obligatorio**. Cambios incompatibles incrementan la versión menor/mayor.
- El esquema va por delante; las specs indican la versión con la que se crearon.

## Nota

La HIGS es la **única** entrada de la reimplementación (ADR 0003). Si un dato no está en la spec, la
reimpl no debe inferirlo de `extraction/` ni de `assets/` sin pasar por la spec.
