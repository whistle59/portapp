# portapp — Guión de pruebas con usuarios

> Credenciales demo: `usuario@portapp.com` / `demo1234` / OTP: `123456`
> URL del prototipo: compartir via Netlify Drop

---

## Instrucciones para el entrevistador

- **No expliques la app antes** — deja que el usuario explore. Solo intervén si se queda completamente bloqueado más de 2 minutos.
- **No corrijas** cuando cometan errores — el error es información valiosa.
- **Pide que piensen en voz alta**: "Dime qué estás viendo, qué esperas que pase cuando pulses eso."
- **Toma notas** de cada punto donde el usuario duda, se para o dice algo inesperado.
- Al final, deja que el usuario hable libremente antes de hacer preguntas dirigidas.

---

## Perfil A — Usuario novato

**Descripción:** Poca o ninguna experiencia con apps de inversión. Puede que tenga algún fondo o ETF pero no lo sigue activamente.

**Objetivo de la sesión:** Detectar problemas de comprensión básica, terminología confusa y flujos que no son intuitivos.

**Duración estimada:** 30–40 minutos

---

### Fase 1 — Primera impresión (sin instrucciones, 5 min)

Muéstrale el link y dile solo esto:

> "Esto es una app para gestionar inversiones. Ábrela y explórale. No tienes que hacer nada concreto todavía, solo cuéntame qué ves."

**Qué observar:**
- ¿Entiende la pantalla de login sin ayuda?
- ¿Lee las credenciales de demo o pregunta cómo entrar?
- ¿La pantalla Global le dice algo o le resulta abrumadora?
- ¿Explora la nav bar inferior o se queda parado?

---

### Fase 2 — Tareas guiadas

Entrega las tareas de una en una. No pases a la siguiente hasta que termine o se rinda.

**Tarea 1 — Orientación básica**
> "¿Cuánto vale en total la cartera llamada 'Cartera Principal'?"

- Objetivo: verificar que entiende la pantalla Global y el selector de cartera.
- Señal de problema: no encuentra el valor o confunde carteras.

**Tarea 2 — Navegación**
> "Encuentra la lista de activos que tiene esa cartera."

- Objetivo: verificar que encuentra la pestaña Cartera.
- Señal de problema: no sabe qué es un "activo" o no encuentra la pestaña.

**Tarea 3 — Registrar una operación**
> "Imagina que acabas de comprar 5 acciones de Microsoft a 440€ cada una. Regístralo en la app."

- Objetivo: probar el flujo completo de nueva operación.
- Señal de problema: no encuentra el botón + Op., no sabe qué es un ticker, se pierde en el formulario.

**Tarea 4 — Consultar rentabilidad**
> "¿Cuánto ha ganado o perdido esta cartera desde que se creó?"

- Objetivo: verificar que encuentra la pantalla Resumen y entiende los números.
- Señal de problema: no distingue valor actual de ganancia, no entiende el porcentaje.

**Tarea 5 — Proyección DCA**
> "Quiero saber cuánto tendría si aporto 300€ al mes durante 10 años. ¿Dónde lo miro?"

- Objetivo: verificar que encuentra la pantalla DCA.
- Señal de problema: no encuentra "DCA" en la nav bar o no entiende qué es.

---

### Fase 3 — Preguntas al finalizar (5–10 min)

1. ¿Qué es lo primero que harías si esta app fuera tuya y la usaras de verdad?
2. ¿Hubo alguna palabra o término que no entendiste?
3. ¿Hay algo que esperabas encontrar y no estaba?
4. Del 1 al 10, ¿cómo puntuarías la facilidad de uso? ¿Por qué ese número y no uno más alto?
5. ¿La usarías? ¿Por qué sí o por qué no?

---

## Perfil B — Usuario intermedio / avanzado

**Descripción:** Invierte habitualmente, usa un broker o más, entiende términos como ETF, dividendo, precio medio, rentabilidad. Puede que ya use alguna herramienta de seguimiento.

**Objetivo de la sesión:** Detectar funcionalidades que faltan, flujos que no son suficientemente potentes y comparaciones con herramientas que ya usan.

**Duración estimada:** 40–50 minutos

---

### Fase 1 — Primera impresión (sin instrucciones, 5 min)

> "Esto es un prototipo de una app de gestión de carteras. Ábrela con las credenciales que te paso y explórala libremente. Cuéntame qué te llama la atención."

**Qué observar:**
- ¿Va directamente a las pantallas más técnicas (Rentabilidad, Grupos, Índices)?
- ¿Encuentra limitaciones o echa algo en falta desde el principio?
- ¿Comenta comparaciones con herramientas que ya usa?

---

### Fase 2 — Tareas guiadas

**Tarea 1 — Multi-cartera**
> "Tienes 3 carteras. Cambia a la llamada 'Especulativa' y dime qué activos tiene y cómo va."

- Objetivo: probar el selector de cartera y la pantalla Cartera.
- Señal de problema: no entiende el concepto de multi-cartera o la navegación entre carteras.

**Tarea 2 — Rentabilidad real**
> "¿Cuál es el activo que más ha rentado en la Cartera Principal? ¿Y el que menos?"

- Objetivo: probar la pantalla Rentabilidad TWR.
- Señal de problema: no encuentra la pantalla, no entiende qué es TWR o discrepa con el cálculo.

**Tarea 3 — Efectivo y movimientos**
> "Registra que has recibido un dividendo de 25€ de Interactive Brokers hoy."

- Objetivo: probar el flujo de nuevo movimiento de efectivo.
- Señal de problema: confunde operación con movimiento de efectivo, no encuentra el formulario.

**Tarea 4 — Compartir cartera**
> "Quiero compartir la Cartera Principal con un familiar para que la vea, pero solo los porcentajes, sin que vea los valores reales. ¿Cómo lo harías?"

- Objetivo: probar la funcionalidad de compartir.
- Señal de problema: no encuentra el botón, no entiende la diferencia entre "valores reales" y "solo porcentajes".

**Tarea 5 — Proyección avanzada**
> "Calcula cuánto tendrías en 20 años si aportas 500€ mensuales con una revalorización del 7%. Necesito ver el detalle año a año."

- Objetivo: probar la tabla detallada de DCA.
- Señal de problema: no encuentra el toggle "Vista detallada" o considera los números poco creíbles.

**Tarea 6 — Configuración**
> "Cambia el tiempo de gracia de bloqueo a 5 minutos y activa el modo oscuro."

- Objetivo: probar los ajustes.
- Señal de problema: no encuentra Ajustes o la configuración de seguridad.

---

### Fase 3 — Preguntas al finalizar (10–15 min)

1. ¿Qué herramienta usas ahora para seguir tus inversiones? ¿Qué tiene que portapp no tiene? ¿Y al revés?
2. ¿Hay algún cálculo o dato que esperabas ver y no estaba?
3. ¿El cálculo de rentabilidad TWR te parece correcto o hay algo que no cuadra?
4. ¿Pagarías por esta app? ¿Cuánto? ¿Pago único o suscripción?
5. ¿La recomendarías a alguien? ¿A qué perfil de persona?
6. ¿Qué es lo único que cambiarías si pudieras cambiar solo una cosa?

---

## Plantilla de recogida de notas

Usa esta plantilla para cada sesión:

```
Usuario: [Perfil A / Perfil B]
Fecha:
Dispositivo usado: [iPhone / Android / ordenador]

TAREAS
Tarea 1: [completó / no completó] — Tiempo: __ min — Notas:
Tarea 2: [completó / no completó] — Tiempo: __ min — Notas:
Tarea 3: [completó / no completó] — Tiempo: __ min — Notas:
Tarea 4: [completó / no completó] — Tiempo: __ min — Notas:
Tarea 5: [completó / no completó] — Tiempo: __ min — Notas:
Tarea 6 (solo B): [completó / no completó] — Tiempo: __ min — Notas:

MOMENTOS DE CONFUSIÓN (anotar literalmente qué dijo el usuario)
-
-
-

COSAS QUE DESTACÓ POSITIVAMENTE
-
-

COSAS QUE ECHÓ EN FALTA
-
-

PUNTUACIÓN DE USABILIDAD (1–10): __
¿Pagaría? [Sí / No / Tal vez] — Precio que mencionó: __
```

---

## Qué hacer con los resultados

Una vez tengas las 3 sesiones:

1. **Agrupa los problemas** — si 2 de 3 usuarios tuvieron el mismo problema, es prioritario. Si solo fue uno, puede ser puntual.
2. **Distingue "no lo encontró"** (problema de navegación/UX) de **"lo encontró pero no lo entendió"** (problema de terminología o diseño).
3. **No implementes todo lo que pidan** — los usuarios describen síntomas, no soluciones. "No entiendo qué es TWR" puede significar "añade un tooltip" o puede significar "renombra la pantalla".
4. Trae los resultados aquí y los priorizamos juntos antes de hacer cambios.

---

## Checklist de tamaño de fuente XL (beta)

Antes de cada release, verificar las siguientes pantallas con el tamaño de fuente configurado en **XL** (Ajustes > Interfaz > Tamaño de fuente > Muy grande):

**Elementos de riesgo a revisar:**
- [ ] Números financieros largos (ej. `€123.456,78`) — que no se partan ni desborden
- [ ] Labels de la barra de navegación inferior — que no se solapen ni corten
- [ ] Textos en celdas de tabla (Cartera, Operaciones, Efectivo) — que no se desborden
- [ ] Botones con texto — que el texto quepa dentro del botón
- [ ] Métricas en tarjetas (Resumen, Global) — que no se solapan entre sí
- [ ] Títulos de pantalla — que no se corten

**Pantallas prioritarias:**
- [ ] Global — métricas y lista de carteras
- [ ] Resumen — métrica grid y actividad reciente
- [ ] Cartera — tabla de posiciones
- [ ] Operaciones — tabla de operaciones
- [ ] Efectivo — tabla de movimientos
- [ ] Rentabilidad — tabla TWR
- [ ] Ajustes — todos los labels y controles
