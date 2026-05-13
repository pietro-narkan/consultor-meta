# consultor-meta

Skill + comandos para Claude Code, para consultoría de **Meta Ads** basada en el Playbook Andromeda 2026-2027.

Incluye:
- Skill `meta-ads-strategist` — se autoactiva al pedir creativos, hooks, guiones (UGC/VSSL), copy de statics, o auditorías de anuncios.
- Comando `/meta-brief` — entrevista corta y crea `brief.md` para un cliente nuevo.
- Comando `/meta-audit` — toma un creativo pegado y devuelve diagnóstico + issues priorizados + versión reescrita.

## Instalación (una línea)

En cualquier máquina con Claude Code instalado:

```bash
curl -fsSL https://raw.githubusercontent.com/pietro-narkan/consultor-meta/main/install.sh | bash
```

O en dos pasos si preferís ver el código antes:

```bash
git clone https://github.com/pietro-narkan/consultor-meta && cd consultor-meta && bash install.sh
```

Después abrí una sesión nueva de Claude Code — la skill y los comandos quedan disponibles globalmente.

## Actualizar

Volvé a correr el mismo comando de install. Es idempotente: sobrescribe los archivos con la última versión.

## Desinstalar

```bash
curl -fsSL https://raw.githubusercontent.com/pietro-narkan/consultor-meta/main/uninstall.sh | bash
```

## Uso por cliente

En la carpeta de cada cliente:

1. **Setup inicial** — corré `/meta-brief` una vez, respondé la entrevista corta. Queda guardado como `brief.md` en esa carpeta.
2. **Generar creativos** — pedí en lenguaje natural: "generá 5 conceptos", "necesito hooks de verdad contraria", "hacé un guion VSSL". La skill se autoactiva, lee el brief, y aplica el playbook.
3. **Auditar creativos** — corré `/meta-audit` y pegá el copy, guion, o descripción del creativo. La skill busca `brief.md` en la carpeta actual y devuelve auditoría estructurada.

## Mantenimiento del playbook

El playbook canónico vive en `skills/meta-ads-strategist/references/playbook.md`. Para actualizarlo:

1. Editar ese archivo en este repo.
2. Commit + push.
3. Avisar al equipo para que vuelvan a correr el comando de install (idempotente).

## Estructura

```
consultor-meta/
├── install.sh                # one-liner installer
├── uninstall.sh
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
