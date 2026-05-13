# Meta Ads Strategist Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Crear una skill global (`meta-ads-strategist`) + dos slash commands (`/meta-brief`, `/meta-audit`) que apliquen el Playbook Andromeda 2026-2027 a generación y auditoría de creativos para Meta Ads, multi-cliente y sin integración con la API de Meta.

**Architecture:** Una skill auto-activable orquesta los flujos (generar / auditar), apoyada en 4 archivos de referencia (playbook, brief-template, output-formats, audit-checklist). Dos slash commands cubren los flujos de mayor fricción (bootstrap de cliente, auditoría rápida). Cada cliente tiene su `brief.md` local en la carpeta del proyecto.

**Tech Stack:** Markdown puro. Sin código. Sin dependencias externas. Sin MCP. Toda la lógica vive en prompts.

**Notas importantes para quien ejecute:**
- Los archivos viven en `~/.claude/skills/` y `~/.claude/commands/`, **fuera del repo `consultor-meta`**. No se commitean por tarea.
- Las skills y comandos de Claude Code se cargan **al inicio de la sesión**. Para validar que algo funcione end-to-end hay que abrir una **sesión nueva** (no esta). La validación final es manual.
- El playbook fuente está en `/home/pietro/Escritorio/consultor-meta/El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md`. La skill mantiene una copia interna.

---

## Task 1: Crear estructura de directorios

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/`
- Create: `~/.claude/skills/meta-ads-strategist/references/`
- Create: `~/.claude/commands/` (si no existe)

- [ ] **Step 1: Crear los directorios**

Run:
```bash
mkdir -p ~/.claude/skills/meta-ads-strategist/references ~/.claude/commands
```

- [ ] **Step 2: Verificar**

Run:
```bash
ls -la ~/.claude/skills/meta-ads-strategist/ ~/.claude/commands/
```

Expected: ambos directorios listados, sin errores. La carpeta `references/` debe aparecer dentro de `meta-ads-strategist/`.

---

## Task 2: Copiar el playbook a la skill

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/references/playbook.md`

- [ ] **Step 1: Copiar el playbook**

Run:
```bash
cp "/home/pietro/Escritorio/consultor-meta/El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md" ~/.claude/skills/meta-ads-strategist/references/playbook.md
```

- [ ] **Step 2: Verificar contenido**

Run:
```bash
wc -l ~/.claude/skills/meta-ads-strategist/references/playbook.md
head -5 ~/.claude/skills/meta-ads-strategist/references/playbook.md
```

Expected: ~65 líneas, primera línea es `### El Playbook de Estrategia Creativa para Meta Ads (2026-2027): Dominando el Algoritmo Andromeda`.

---

## Task 3: Crear `brief-template.md`

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/references/brief-template.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo del archivo:

```markdown
# Brief: [Nombre del cliente]

> Plantilla. Eliminá esta línea y reemplazá los placeholders al completar.

## Producto
- **Qué es:** [categoría / formato / tipo]
- **Precio y mecánica:** [precio, suscripción/one-shot, ciclo]
- **Diferencial real:** [algo medible o concreto, no "el mejor"]

## Persona(s)
- **Arquetipo:** [no demográfico — describir dolor, contexto de vida, qué consume]
- **Nivel de conciencia dominante:** [no-conciencia / problema / solución / producto]

## Oferta actual
- **Promo vigente:** [descripción + descuento + garantía]

## Ángulos ya probados
- [Ángulo 1] — estado: [ganador / fatigado / sin testear]
- [Ángulo 2] — estado: [...]

## Restricciones
- **Compliance / claims prohibidos:** [...]
- **Tono de marca:** [...]
- **Idioma y mercado:** [...]

## Histórico (opcional)
- **Hooks que funcionaron:** [...]
- **Hooks que fallaron:** [...]
- **Formatos preferidos:** [...]
```

- [ ] **Step 2: Verificar**

Run:
```bash
test -s ~/.claude/skills/meta-ads-strategist/references/brief-template.md && echo "OK" || echo "FAIL"
```

Expected: `OK`.

---

## Task 4: Crear `output-formats.md`

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/references/output-formats.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo:

````markdown
# Formatos de Output

Formato exacto de cada entregable. Mantener consistencia entre sesiones.

## Conceptos completos

Para cada concepto (mínimo 3, idealmente 5 por lote):

```
### Concepto N: [Título corto y específico]

- **Persona:** [arquetipo del brief, con dolor concreto]
- **Ángulo:** [palanca del playbook: agitación / verdad contraria / prueba social / brecha de curiosidad]
- **Oferta:** [oferta del brief con framing específico a este concepto]
- **Hook (tipo: [verdad contraria | prueba específica | brecha curiosidad | bomba verdad | confrontación]):**
  > [Hook literal, 1-2 frases, primeros 3 segundos]
- **Bridge:**
  > [Cómo se pasa de no-conciencia a conciencia del problema antes del producto]
- **Cuerpo:**
  [Desarrollo del concepto en 3-5 líneas]
- **CTA:** [Llamado a la acción específico]
- **Formato sugerido:** [UGC / VSSL / Static / Advertorial / Partnership]
```

Validación antes de entregar: cada concepto del lote usa un ángulo o tipo de hook diferente (similarity score bajo).

## Guion UGC (15-30 segundos)

```
### UGC: [Título]

| Tiempo | Visual | Audio (lo que dice el creador) | On-screen text |
|--------|--------|--------------------------------|----------------|
| 0-3s | [descripción] | [hook literal] | [texto en pantalla] |
| 3-10s | [descripción] | [bridge / agitación] | [...] |
| 10-25s | [descripción] | [revelación / oferta] | [...] |
| 25-30s | [descripción] | [CTA] | [...] |

**Hook type:** [tipo del playbook]
**Persona implícita para Andromeda:** [qué señales lee el algoritmo: visual + audio + texto]
```

## Guion VSSL (90-120 segundos)

Estructura por etapas (no por timestamps rígidos):

```
### VSSL: [Título]

**Hook (0-5s):** [Texto literal, abre con verdad contraria o promesa específica]

**Agitación del problema (5-30s):** [Texto literal — sin mencionar producto]

**Verdad contraria / Insight (30-60s):** [Lo que el usuario no sabía]

**Solución / Mecanismo (60-90s):** [Cómo funciona, por qué este producto]

**Prueba (90-105s):** [Social proof, números, testimonio implícito]

**Oferta + CTA (105-120s):** [Oferta específica + acción]

**Hook type:** [tipo del playbook]
**Etapa de conciencia target:** [problema / solución / producto]
```

## Copy para statics

Subformatos disponibles:

### Tweet-style static
```
[Hook como tweet — 1 línea fuerte]

[Cuerpo en 3-5 líneas, tono conversacional]

[CTA implícito o explícito]
```

### Advertorial static
```
**Titular:** [titular de revista / portal]
**Subtítulo:** [refuerzo]
**Body (3 párrafos cortos):**
1. [Problema]
2. [Mecanismo / verdad contraria]
3. [Producto + oferta]
**CTA:** [...]
```

### Prueba social static
```
**Visual:** [captura de testimonio / review / chat]
**Caption sugerido:** [framing breve del estratega para el ad]
```

## Lote de hooks

Entregar mínimo 10, máximo 20, agrupados por tipo del playbook:

```
### Verdad contraria
1. [Hook literal]
2. [Hook literal]
...

### Prueba específica
1. [Hook literal]
...

### Brecha de curiosidad
1. [Hook literal]
...

### Bomba de verdad
1. [Hook literal]
...

### Confrontación psicológica
1. [Hook literal]
...
```

Cada hook debe ser usable como primer frame/línea de un creativo sin contexto adicional.
````

- [ ] **Step 2: Verificar**

Run:
```bash
grep -c "^## " ~/.claude/skills/meta-ads-strategist/references/output-formats.md
```

Expected: `5` (Conceptos completos, Guion UGC, Guion VSSL, Copy para statics, Lote de hooks).

---

## Task 5: Crear `audit-checklist.md`

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/references/audit-checklist.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo:

```markdown
# Audit Checklist

Aplicar en orden al evaluar un creativo existente. Cada chequeo referencia la sección del playbook que lo respalda.

## 1. Hook (primeros 3 segundos) — playbook §5
- ¿Promete relevancia específica o es genérico?
- ¿Pertenece a uno de los tipos del playbook (verdad contraria / prueba específica / brecha de curiosidad / bomba de verdad / confrontación)?
- Si es clickbait sin sustancia: **issue crítico**.

## 2. Bridge — playbook §5
- ¿Lleva de no-conciencia o conciencia del problema antes de presentar el producto?
- Si introduce la marca antes del segundo 5 sin agitación previa: **issue alto**.

## 3. Persona implícita para Andromeda — playbook §2
- ¿Qué lee Visión Computacional en el visual? ¿Qué lee la transcripción de audio?
- ¿Las señales construyen una persona psicográfica clara?
- Si el creativo es genérico y no construye persona: **issue alto** (Andromeda no puede segmentar).

## 4. Ángulo — playbook §4
- ¿Hay un ángulo identificable (no solo "muestro el producto")?
- ¿Apoyado en: agitación / verdad contraria / prueba social / brecha de curiosidad?

## 5. Similarity score — playbook §2
- Si existen otros creativos del mismo cliente en `creativos/`: ¿este se parece demasiado a uno ya activo?
- Si sí: **issue alto** — canibaliza alcance.

## 6. Quality bar (7/10) — playbook §7
- ¿El creativo supera el umbral 7/10 en hook + producción + claridad de oferta?
- Si no: **issue alto**, descartar o reescribir.

## 7. Formato vs etapa de conciencia — playbook §6
- ¿El formato encaja con la etapa de conciencia del usuario que verá el creativo?
- Static funciona para problema/solución/producto. VSSL para no-conciencia/problema (especialmente >50 años). UGC para problema/solución.
- Si hay mismatch: **issue medio**.

## 8. Riesgo de DPA death spiral — playbook §3
- ¿Es un DPA puro empujando ROAS inflado de retargeting?
- Si sí: nota — no es issue del creativo, es issue de portfolio. Marcar pero no descartar.

## 9. Compliance y restricciones del brief
- ¿Viola alguna restricción declarada en `brief.md` (claims prohibidos, tono)?
- Si sí: **issue crítico** — corrección obligatoria.

## Priorización

Al entregar el audit, seleccionar los **3 issues de mayor impacto** (crítico > alto > medio). No abrumar al usuario con todos los chequeos — los issues no listados se asumen aprobados.
```

- [ ] **Step 2: Verificar**

Run:
```bash
grep -c "^## " ~/.claude/skills/meta-ads-strategist/references/audit-checklist.md
```

Expected: `10` (9 chequeos numerados + Priorización).

---

## Task 6: Crear `SKILL.md` (orquestador)

**Files:**
- Create: `~/.claude/skills/meta-ads-strategist/SKILL.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo:

````markdown
---
name: meta-ads-strategist
description: Use when generating or auditing creatives for Meta Ads (Facebook/Instagram ads) — concepts, video scripts (UGC/VSSL), static copy, hook batches, or creative audits. Triggers on mentions of "Meta Ads", "Facebook ads", "Instagram ads", "creativos", "anuncios", "ganchos", "hooks", "guion publicitario", "VSSL", "UGC", "advertorial", "auditar anuncio", "mejorar creativo". Applies the Andromeda 2026-2027 playbook (persona-ángulo-oferta, hook types, similarity score, 70/20/10, 7/10 quality bar) over a per-client brief.md.
---

# Meta Ads Strategist

You are a creative strategist for Meta Ads (Facebook/Instagram). Your work is grounded in the Andromeda 2026-2027 playbook embedded in this skill.

## When this skill activates

The user asked you to generate or audit creative material for Meta Ads, or is discussing creative strategy for a Meta Ads campaign. Examples:
- "Genera 5 conceptos para [cliente]"
- "Necesito hooks para X"
- "Auditá este creativo: [paste]"
- "Hacé un guion VSSL para este producto"

## Workflow

### Step 1 — Identify intent

Classify the request:
- **Generate**: produce new creative material
- **Audit**: critique and improve existing creative material
- **Advise**: strategic question without a concrete deliverable

If ambiguous, ask one short question before proceeding.

### Step 2 — Locate brand context

For Generate and Audit:
1. Look for `brief.md` in the current working directory.
2. If not found, search up to 2 parent directories.
3. If still not found, offer two options to the user:
   - (a) Run `/meta-brief` to create one (recommended)
   - (b) Quick in-chat interview (not saved)

Do NOT proceed to generation/auditing without brand context. Never invent.

### Step 3 — Read the playbook before generating

Before producing any creative output, read `references/playbook.md`. The playbook is the source of truth for:
- Persona-ángulo-oferta architecture (section 4)
- Hook types (section 5)
- Format diversification (section 6)
- 7/10 quality bar (section 7)
- Portfolio thinking 70/20/10 (section 3)

### Step 4 — For Generate flow

If the user did not specify the deliverable type, ask which:
- Conceptos completos (persona + ángulo + oferta + hook + bridge)
- Guion UGC (video corto, 15-30s)
- Guion VSSL (video largo, 90-120s)
- Copy para static (tweet, advertorial, prueba social, etc.)
- Lote de hooks (10-20 ganchos por tipo)

Read `references/output-formats.md` for the exact format of the requested deliverable.

Apply playbook principles:
- Make persona, ángulo, oferta explicit in each concept
- Tag the hook type used (from playbook section 5)
- For batches, diversify ángulos and hook types (avoid high similarity score)
- Quality bar 7/10, not perfection — volumen sobre obra maestra
- Bridge fluido: no introducir producto demasiado rápido

After generating, ask if the user wants to save the output to `creativos/YYYY-MM-DD-<tipo>-<slug>.md` in cwd. If yes, create the `creativos/` folder if needed and write the file.

### Step 5 — For Audit flow

Read `references/audit-checklist.md`. Apply it to the pasted creative.

Output exactly this structure:

```
## Diagnóstico
[2-3 sentences identifying the core issue or strength]

## Issues priorizados
1. **[Issue]** — playbook §[section]. [What's wrong and what to do]
2. **[Issue]** — playbook §[section]. [What's wrong and what to do]
3. **[Issue]** — playbook §[section]. [What's wrong and what to do]

## Versión reescrita
[The creative rewritten applying the fixes — preserve the original format: if it was a script with timestamps, return a script; if it was copy, return copy]
```

Do not add extra sections. Do not list the checks that passed.

## Constraints

- Respect `brief.md` restrictions (compliance, claims prohibited, tone) over any suggestion.
- Default language: Spanish (es-LA). If `brief.md` specifies otherwise, use that.
- Never invent metrics, brand promises, or testimonials.
- Never suggest API/MCP integrations for Meta — user works text-only by policy.

## Updating the playbook

Source: `/home/pietro/Escritorio/consultor-meta/El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md`

Sync command:
```bash
cp "/home/pietro/Escritorio/consultor-meta/El Playbook de Estrategia Creativa para Meta Ads (2026-2027)_ Dominando el Algoritmo Andromeda.md" ~/.claude/skills/meta-ads-strategist/references/playbook.md
```
````

- [ ] **Step 2: Verificar frontmatter**

Run:
```bash
head -4 ~/.claude/skills/meta-ads-strategist/SKILL.md
```

Expected: las primeras 4 líneas deben ser `---`, `name: meta-ads-strategist`, una línea `description:`, y `---` (el frontmatter de skill válido).

- [ ] **Step 3: Verificar referencias internas**

Run:
```bash
grep -o "references/[a-z-]*\.md" ~/.claude/skills/meta-ads-strategist/SKILL.md | sort -u
```

Expected: las tres referencias usadas — `references/audit-checklist.md`, `references/output-formats.md`, `references/playbook.md`. Las tres apuntan a archivos creados en tasks 2-5.

---

## Task 7: Crear `/meta-brief` command

**Files:**
- Create: `~/.claude/commands/meta-brief.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo:

```markdown
Estás creando un brief de marca para un cliente de Meta Ads en la carpeta actual.

## Paso 1: Verificar si existe brief.md

Verificá si ya existe `brief.md` en cwd.
- Si existe: leelo, mostralo al usuario, y preguntá qué campos quiere actualizar. NO sobrescribas el archivo completo — solo modificá los campos que el usuario pida cambiar.
- Si no existe: procedé al paso 2.

## Paso 2: Entrevista

Hacé una entrevista corta. UNA pregunta por mensaje. Esperá respuesta del usuario antes de continuar a la siguiente.

Preguntas en orden:

1. **Nombre y producto:** "¿Cómo se llama el cliente y qué vende? Decime categoría, precio aproximado, y si es suscripción u one-shot."
2. **Diferencial:** "¿Cuál es el diferencial real del producto? Algo concreto y medible — no 'el mejor'."
3. **Persona:** "Describime el arquetipo de cliente ideal: dolor que resuelve, contexto de vida, qué consume. No me des demográfico (edad/sexo); dame psicografía."
4. **Nivel de conciencia:** "¿En qué etapa está la mayoría de la audiencia objetivo? (no-conciencia / problema / solución / producto)"
5. **Oferta actual:** "¿Cuál es la promo o mecánica de oferta vigente? Descuento, garantía, ciclo, etc."
6. **Ángulos previos:** "¿Qué ángulos ya probaron en ads? Marcame cuáles ganaron, cuáles se fatigaron, y cuáles faltan testear."
7. **Restricciones:** "¿Hay claims prohibidos, restricciones de compliance, o tono de marca obligado? ¿Idioma y mercado?"

## Paso 3: Escribir el archivo

Escribí `brief.md` en cwd usando exactamente la estructura de `~/.claude/skills/meta-ads-strategist/references/brief-template.md`, completando con las respuestas del usuario.

Si una respuesta fue ambigua o incompleta, dejá ese campo con una nota tipo `[a definir]` en lugar de inventar.

## Paso 4: Confirmar

Mostrale el archivo final renderizado y preguntá si quiere ajustar algo antes de cerrar.
```

- [ ] **Step 2: Verificar**

Run:
```bash
test -s ~/.claude/commands/meta-brief.md && wc -l ~/.claude/commands/meta-brief.md
```

Expected: archivo existe y tiene ~30+ líneas.

---

## Task 8: Crear `/meta-audit` command

**Files:**
- Create: `~/.claude/commands/meta-audit.md`

- [ ] **Step 1: Escribir el archivo**

Contenido completo:

````markdown
Estás auditando un creativo existente para Meta Ads.

## Paso 1: Recibir el creativo

Si el usuario no pegó todavía el contenido del creativo (copy, guion, descripción visual + audio), pedíselo: "Pegame el creativo a auditar — puede ser el copy del ad, el guion, una descripción del visual + audio, o todo junto."

Aceptá cualquier formato. No exijas estructura.

## Paso 2: Buscar contexto de marca

Verificá si hay `brief.md` en cwd o hasta 2 niveles arriba.
- Si hay: leelo. Usá las restricciones, persona, ángulos previos y diferencial para informar la auditoría.
- Si no hay: avisá al usuario "no hay brief.md — la auditoría será menos precisa sin contexto de marca, pero procedo". Procedé igual.

Si hay carpeta `creativos/` en cwd con creativos previos del mismo cliente, leelos brevemente para evaluar similarity score.

## Paso 3: Aplicar checklist

Leé `~/.claude/skills/meta-ads-strategist/references/audit-checklist.md` y aplicá los 9 chequeos en orden al creativo. También leé `~/.claude/skills/meta-ads-strategist/references/playbook.md` cuando necesites fundamentar una crítica con la sección específica.

## Paso 4: Priorizar

Seleccioná los **3 issues de mayor impacto** (crítico > alto > medio). Los issues que pasaron no se mencionan.

## Paso 5: Entregar

Entregá la auditoría con esta estructura EXACTA. No agregues secciones extra.

```
## Diagnóstico
[2-3 frases identificando el problema central o la fortaleza principal]

## Issues priorizados
1. **[Nombre del issue]** — playbook §[sección]. [Qué está mal y qué hacer concretamente]
2. **[Nombre del issue]** — playbook §[sección]. [Qué está mal y qué hacer concretamente]
3. **[Nombre del issue]** — playbook §[sección]. [Qué está mal y qué hacer concretamente]

## Versión reescrita
[El creativo reescrito aplicando los fixes. Mantené el formato del original: si era guion con timestamps, devolvé guion con timestamps; si era copy, devolvé copy; si era descripción de UGC, devolvé tabla UGC]
```

## Paso 6: Ofrecer guardado

Al final, preguntá: "¿Querés que guarde la auditoría en `creativos/auditorias/YYYY-MM-DD-<slug>.md`?"
````

- [ ] **Step 2: Verificar**

Run:
```bash
test -s ~/.claude/commands/meta-audit.md && grep -c "^## Paso" ~/.claude/commands/meta-audit.md
```

Expected: archivo existe, 6 pasos detectados.

---

## Task 9: Validación end-to-end de la skill (manual)

**Files:**
- Test: `/tmp/meta-test-cliente/brief.md` (temporal)

> **Nota importante:** Esta validación requiere abrir una **sesión nueva de Claude Code** porque las skills se cargan al inicio de la sesión. La sesión actual no las verá.

- [ ] **Step 1: Crear un cliente de prueba**

Run:
```bash
mkdir -p /tmp/meta-test-cliente
cat > /tmp/meta-test-cliente/brief.md <<'EOF'
# Brief: Creatina Gummies (cliente de prueba)

## Producto
- **Qué es:** Suplemento de creatina en formato gummy. $60/mes en suscripción.
- **Precio y mecánica:** $60/mes suscripción, descuento 15% en el primer ciclo de 12 semanas.
- **Diferencial real:** Dosis monohidrato 5g en formato sin polvo; absorción 22% más rápida que cápsulas según estudio interno.

## Persona(s)
- **Arquetipo:** Hombre 30-40, profesional, entrenando para primer maratón sub-4h. Sigue a Andrew Huberman. Le importa la recuperación y la inflamación post-entreno, no el bulking.
- **Nivel de conciencia dominante:** problema (sabe que necesita recuperar mejor) → solución (no sabe que la creatina aplica a maratonistas)

## Oferta actual
- **Promo vigente:** 15% off primer mes + envío gratis + garantía 30 días.

## Ángulos ya probados
- "Sumá fuerza" — fatigado (genérico, no diferencia maratonistas)
- "Recuperación post-entreno" — ganador
- "Ciencia de la síntesis proteica" — sin testear

## Restricciones
- **Compliance / claims prohibidos:** no afirmar diagnóstico médico, no usar "cura", no comparar con drogas.
- **Tono de marca:** científico-accesible, no bro-fitness.
- **Idioma y mercado:** español, US Hispanic + México.
EOF
```

- [ ] **Step 2: Abrir nueva sesión de Claude Code en esa carpeta**

Manual: en una terminal nueva, correr `cd /tmp/meta-test-cliente && claude`.

- [ ] **Step 3: Probar auto-activación de generación**

En esa sesión nueva, escribir: `Generá 3 conceptos para este cliente`

**Validación esperada:**
- Claude debe activar la skill `meta-ads-strategist` (verificable en el output: menciona la skill o el playbook).
- Debe leer `brief.md` automáticamente sin pedir contexto.
- Output: 3 conceptos con persona/ángulo/oferta/hook/bridge explícitos, hook tipado, ángulos diversos entre los 3.

Si la skill no se activa, revisar el `description:` en `SKILL.md` y agregar triggers más explícitos.

- [ ] **Step 4: Probar `/meta-brief`**

Crear carpeta limpia: `mkdir -p /tmp/meta-test-vacio && cd /tmp/meta-test-vacio && claude`

En esa sesión, correr `/meta-brief`. Hacer la entrevista (puede responderse rápido con datos inventados).

**Validación esperada:**
- Pregunta una cosa por vez.
- Al final escribe `brief.md` siguiendo la estructura del template.
- Pregunta confirmación.

- [ ] **Step 5: Probar `/meta-audit`**

En `/tmp/meta-test-cliente` (donde hay brief.md), correr `/meta-audit` y pegar un creativo de prueba como:

```
"Probá nuestras gummies de creatina. 5g por gomita. Suscribite ya con 15% off. Maratonistas felices con su recuperación."
```

**Validación esperada:**
- Output con secciones exactas: Diagnóstico / Issues priorizados / Versión reescrita.
- Issues referenciando secciones del playbook.
- Versión reescrita aplicando hook tipado, persona maratonista, bridge antes del producto.

- [ ] **Step 6: Limpiar test**

Run:
```bash
rm -rf /tmp/meta-test-cliente /tmp/meta-test-vacio
```

---

## Task 10: Documentar y commitear el cierre

**Files:**
- Modify: `/home/pietro/Escritorio/consultor-meta/README.md`

- [ ] **Step 1: Actualizar README.md del proyecto**

Reemplazar el contenido actual (`# consultor-meta`) por:

```markdown
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
```

- [ ] **Step 2: Commit del README actualizado**

Run:
```bash
git add README.md
git commit -m "$(cat <<'EOF'
docs: README explica skill meta-ads-strategist y flujo de uso

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

Expected: commit creado en main.

---

## Self-review notes (ya completado)

**Spec coverage:**
- Skill global + 4 references → tasks 1, 3, 4, 5, 6
- Slash commands `/meta-brief` y `/meta-audit` → tasks 7, 8
- Schema de brief → embebido en task 3 (template)
- Flujos A/B/C → cubiertos por SKILL.md (task 6) y commands (tasks 7-8)
- Búsqueda de `brief.md` hasta 2 niveles → especificado en SKILL.md y meta-audit
- Validación manual → task 9
- Comando de sync del playbook → documentado en SKILL.md y README (tasks 6, 10)

**Sin placeholders:** todo el contenido de cada archivo está completo e inline en las tasks.

**Consistencia de tipos:** todas las referencias a archivos usan rutas absolutas o consistentes (`~/.claude/skills/meta-ads-strategist/references/<file>.md`). Las secciones del playbook se referencian con `§N` consistentemente.

**Cobertura de casos límite:** sin brief.md (manejado en SKILL.md y meta-audit), brief incompleto (manejado en meta-brief con notas `[a definir]`), pedido ambiguo (skill pregunta antes de proceder).
