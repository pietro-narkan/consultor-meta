# consultor-meta

Plugin de Claude Code para consultoría de **Meta Ads**, basado en el Playbook Andromeda 2026-2027.

Incluye:
- Skill `meta-ads-strategist` — se autoactiva al pedir creativos, hooks, guiones (UGC/VSSL), copy de statics, o auditorías de anuncios.
- Comando `/meta-brief` — entrevista corta y crea `brief.md` para un cliente nuevo.
- Comando `/meta-audit` — toma un creativo pegado y devuelve diagnóstico + issues priorizados + versión reescrita.

## Instalación (equipo)

En cualquier máquina con Claude Code, dentro de una sesión:

```
/plugin marketplace add pietro-narkan/consultor-meta
/plugin install meta-ads-strategist@consultor-meta
```

Después abrí una sesión nueva — la skill y los comandos aparecen disponibles globalmente.

## Actualizaciones

Cuando se publique una nueva versión:

```
/plugin marketplace update consultor-meta
```

## Uso por cliente

En la carpeta de cada cliente:

1. **Setup inicial** — corré `/meta-brief` una vez, respondé la entrevista corta. Queda guardado como `brief.md` en esa carpeta.
2. **Generar creativos** — pedí en lenguaje natural: "generá 5 conceptos", "necesito hooks de verdad contraria", "hacé un guion VSSL". La skill se autoactiva, lee el brief, y aplica el playbook.
3. **Auditar creativos** — corré `/meta-audit` y pegá el copy, guion, o descripción del creativo. La skill busca `brief.md` en la carpeta actual y devuelve auditoría estructurada.

## Mantenimiento del playbook

El playbook canónico vive en `skills/meta-ads-strategist/references/playbook.md`. Para actualizarlo:

1. Editar ese archivo en este repo.
2. Bump del `version` en `.claude-plugin/plugin.json` y `.claude-plugin/marketplace.json`.
3. Commit + push.
4. Avisar al equipo para que corra `/plugin marketplace update consultor-meta`.

## Estructura del plugin

```
consultor-meta/
├── .claude-plugin/
│   ├── plugin.json           # manifest del plugin
│   └── marketplace.json      # manifest del marketplace
├── skills/
│   └── meta-ads-strategist/
│       ├── SKILL.md          # orquestador
│       └── references/       # playbook + plantillas + checklist
├── commands/
│   ├── meta-brief.md
│   └── meta-audit.md
└── docs/
    └── superpowers/
        ├── specs/            # diseño aprobado
        └── plans/            # plan de implementación
```
