# Meta Ads Strategist — Diseño

**Fecha:** 2026-05-13
**Autor:** Pietro (agencia.narkan@gmail.com)
**Estado:** Aprobado — listo para plan de implementación

## Objetivo

Crear una herramienta de Claude Code, reutilizable entre clientes, que aplique el "Playbook de Estrategia Creativa para Meta Ads (2026-2027) — Dominando el Algoritmo Andromeda" para dos tareas:

1. **Generar creativos nuevos** (conceptos completos, guiones de video, copy para statics, lotes de hooks).
2. **Auditar y mejorar creativos existentes** según los principios del playbook.

La herramienta debe servir a múltiples clientes/marcas desde cualquier carpeta del sistema, sin depender de APIs de Meta (decisión explícita por riesgo de baneo de cuentas).

## Restricciones

- **Sin MCP de Meta Ads.** No conectar a la API de Meta por riesgo de baneo. La herramienta opera 100% sobre texto local.
- **Multi-cliente.** Pietro trabaja con varios clientes. La herramienta debe ser global (no atada a un proyecto).
- **Playbook como única fuente de verdad estratégica.** Toda generación y auditoría se justifica contra los principios del playbook.
- **Idioma:** español por defecto; respeta el idioma del brief si difiere.

## Arquitectura

### Componentes

**1. Skill global — `meta-ads-strategist`**

Ubicación: `~/.claude/skills/meta-ads-strategist/`

```
meta-ads-strategist/
├── SKILL.md
└── references/
    ├── playbook.md
    ├── brief-template.md
    ├── output-formats.md
    └── audit-checklist.md
```

- **`SKILL.md`** — Orquestador. Define el `description:` para auto-activación (triggers: "creativos para Meta Ads", "anuncios de Facebook/Instagram", "guion UGC", "hook publicitario", "auditar anuncio", "VSSL", "advertorial"). Detecta intención (generar vs auditar), busca `brief.md` en cwd y hasta 2 niveles arriba, y enruta al flujo correspondiente.
- **`references/playbook.md`** — Copia íntegra del playbook Andromeda. Fuente de verdad estratégica embebida en la skill.
- **`references/brief-template.md`** — Plantilla del schema de `brief.md` usada por `/meta-brief` y por el flujo de bootstrap conversacional.
- **`references/output-formats.md`** — Formato esperado de cada entregable (concepto, guion UGC, guion VSSL, copy static, lote de hooks).
- **`references/audit-checklist.md`** — Criterios de auditoría derivados del playbook (hook en 3s, bridge, persona implícita, ángulo, similarity score con creativos del cliente, calidad 7/10, formato vs etapa de conciencia, riesgo de DPA death spiral, regla 70/20/10).

**2. Slash commands globales**

Ubicación: `~/.claude/commands/`

- **`meta-brief.md`** — Entrevista corta (5-7 preguntas guiadas por el schema) y escribe `brief.md` en cwd. Si ya existe `brief.md`, ofrece actualizar campos en lugar de sobrescribir.
- **`meta-audit.md`** — Toma copy/guion/descripción pegada por el usuario y devuelve auditoría estructurada (diagnóstico breve → 3 issues priorizados → versión reescrita).

**3. Artefactos por cliente** (en la carpeta de cada cliente)

```
~/ruta/al/cliente/
├── brief.md            # creado por /meta-brief, leído por la skill
└── creativos/          # opcional, donde Claude guarda outputs si el usuario lo pide
    └── YYYY-MM-DD-<tipo>-<slug>.md
```

### Schema de `brief.md`

```markdown
# Brief: [Nombre del cliente]

## Producto
- Qué es / categoría / precio / formato (suscripción, one-shot, etc.)
- Diferencial real (medible o concreto; no "el mejor")

## Persona(s)
- Arquetipo (no demográfico): dolor, contexto de vida, qué consume
- Nivel de conciencia dominante (no-conciencia / problema / solución / producto)

## Oferta actual
- Promo vigente, mecánica, descuento, garantía

## Ángulos ya probados
- Lista de ángulos usados + estado (ganador / fatigado / sin testear)

## Restricciones
- Compliance, claims prohibidos, tono de marca, idioma, mercado

## Histórico (opcional)
- Hooks que funcionaron / fallaron, formatos preferidos
```

## Flujos

### Flujo A — Generar creativos (auto-detectado por la skill)

1. Usuario pide algo como "genera 5 conceptos para [cliente]" o "necesito hooks para el cliente X" desde una carpeta.
2. Skill busca `brief.md` en cwd; si no encuentra, sube hasta 2 niveles.
3. Si no hay `brief.md` → ofrece dos caminos: (a) correr `/meta-brief` para crear uno, o (b) entrevistar al vuelo (sin guardar).
4. Si hay `brief.md` → lo lee y, si el usuario no fue explícito sobre el entregable, pregunta cuál: conceptos completos / guion UGC / guion VSSL / copy static / lote de hooks.
5. Genera siguiendo `output-formats.md` y los principios del playbook:
   - Persona-ángulo-oferta explícitos.
   - Tipo de hook elegido del playbook (verdad contraria, prueba específica, brecha de curiosidad, bomba de verdad, confrontación psicológica).
   - Bridge fluido (no introducir producto demasiado rápido).
   - Diversidad de ángulos en el lote (evitar similarity score alto).
   - Calidad 7/10 como umbral; volumen sobre perfección.
6. Pregunta si guardar en `creativos/YYYY-MM-DD-<tipo>-<slug>.md`.

### Flujo B — Auditar creativo (vía `/meta-audit` o conversacional)

1. Usuario pega copy, guion o descripción de un creativo (puede invocar `/meta-audit` o pedirlo en lenguaje natural).
2. Skill aplica `audit-checklist.md`:
   - Hook: ¿promete relevancia en los primeros 3 segundos?
   - Bridge: ¿lleva de no-conciencia a conciencia del problema antes del producto?
   - Persona implícita: ¿queda clara para Visión Computacional / transcripción de audio?
   - Ángulo: ¿usa una de las palancas del playbook?
   - Similarity: si hay otros creativos del mismo cliente en `creativos/`, ¿se parece demasiado?
   - Calidad 7/10: ¿supera el umbral?
   - Formato vs etapa de conciencia: ¿el formato encaja con dónde está el usuario?
3. Devuelve estructura fija:
   - **Diagnóstico** (2-3 frases)
   - **Issues priorizados** (top 3 con referencia al playbook)
   - **Versión reescrita** (aplicando los fixes)

### Flujo C — Bootstrap de cliente nuevo (vía `/meta-brief`)

1. Usuario corre `/meta-brief` en la carpeta del cliente.
2. Comando hace una entrevista corta de 5-7 preguntas siguiendo el schema (Producto → Persona → Oferta → Ángulos previos → Restricciones → Histórico opcional).
3. Si ya existe `brief.md`, ofrece actualizar campos en lugar de sobrescribir (preserva trabajo previo).
4. Escribe `brief.md` y confirma con el usuario.

## Decisiones de diseño

- **Playbook embebido en la skill, no enlazado al proyecto `consultor-meta`.** Razón: portabilidad y aislamiento. El proyecto `consultor-meta` queda como fuente origen; la skill es independiente. Para mantener sincronía cuando se actualice el playbook, documentar el comando de copia.
- **Búsqueda de `brief.md` hasta 2 niveles arriba del cwd.** Permite trabajar dentro de subcarpetas del cliente (ej. `cliente-x/creativos/`) sin perder el contexto.
- **Auto-activación por descripción de la skill.** El `description:` debe ser específico para evitar disparos espurios y suficientemente amplio para capturar variantes naturales (anuncios, creativos, hooks, ganchos, guion, VSSL, advertorial, etc.).
- **Dos slash commands separados, no uno solo.** `/meta-brief` y `/meta-audit` cubren las dos acciones de mayor fricción/uso. El resto del flujo conversacional vive en la skill.
- **Outputs como markdown con frontmatter mínimo.** Fechados y nombrados consistentemente para poder usarse después como input de auditorías comparativas.

## Manejo de casos límite

- **Sin `brief.md` en ningún nivel:** la skill no inventa contexto. Pregunta al usuario qué hacer (crear brief / entrevistar / abortar).
- **Brief incompleto:** si faltan campos críticos (persona, oferta), la skill pregunta antes de generar en lugar de rellenar con suposiciones.
- **Pedido ambiguo de entregable:** si el usuario dice "creativos" sin especificar tipo, preguntar antes de generar.
- **Conflictos con restricciones:** si una mejora propuesta en una auditoría viola una restricción del brief (claim prohibido, etc.), la skill debe priorizar la restricción y explicarlo.

## Fuera de alcance (explícito)

- **Integración con la API de Meta Ads.** Excluido por riesgo de baneo.
- **Análisis de métricas reales de cuenta.** Excluido (requeriría MCP).
- **Generación de assets visuales** (imágenes, videos). La skill produce texto y guiones; la producción audiovisual es manual / con otras herramientas.
- **Multi-idioma automático más allá de español/inglés.** Si un cliente requiere otro idioma, lo gestiona el brief manualmente.

## Criterios de éxito

1. Pietro puede ir a la carpeta de cualquier cliente, correr `/meta-brief` una vez, y desde ese momento generar conceptos/guiones/hooks pidiéndoselos en lenguaje natural.
2. Los outputs reflejan los principios del playbook de forma verificable (persona-ángulo-oferta visibles, hook clasificado, bridge identificable, ángulos diversos en lotes).
3. La auditoría devuelve críticas accionables, no genéricas, con referencias al playbook.
4. La herramienta funciona idénticamente desde cualquier carpeta del sistema.
