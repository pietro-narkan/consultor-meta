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
