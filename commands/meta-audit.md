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
