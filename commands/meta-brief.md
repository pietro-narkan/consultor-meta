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
