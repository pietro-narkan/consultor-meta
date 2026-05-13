# consultor-meta

Estrategia y herramientas para consultoría de Meta Ads basadas en el **Playbook Andromeda 2026-2027**.

## Contenido

- `El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md` — documento base de estrategia. Fuente de verdad para la skill.
- `docs/superpowers/specs/` — diseño aprobado de la skill `meta-ads-strategist`.
- `docs/superpowers/plans/` — plan de implementación.

## Skill global

Esta carpeta es la fuente del playbook. La skill `meta-ads-strategist` vive en `~/.claude/skills/meta-ads-strategist/` y mantiene una copia interna.

**Sincronizar el playbook cuando lo edites:**

```bash
cp "El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md" ~/.claude/skills/meta-ads-strategist/references/playbook.md
```

## Uso por cliente

En la carpeta de cada cliente:
1. Correr `/meta-brief` una vez para crear el `brief.md`.
2. Desde ahí, pedir creativos en lenguaje natural (la skill se autoactiva).
3. Para auditar un creativo existente, correr `/meta-audit` y pegar el contenido.
