# gstack — Evaluación para portapp

> Documento preparado el 2026-04-26  
> Referencia: https://github.com/garrytan/gstack

---

## Qué es gstack

gstack es una colección de 23 herramientas especializadas de IA creadas por **Garry Tan** (presidente de Y Combinator) que convierten Claude Code en un equipo de ingeniería virtual. Está diseñado para que un solo desarrollador pueda operar al ritmo de un equipo completo.

**Entorno:** funciona exactamente igual que Claude Code — líneas de texto en el terminal, sin interfaz gráfica. Los resultados se guardan como archivos Markdown en el repositorio (compatible con nuestra estructura actual de docs/).

---

## Qué problema resuelve para portapp

portapp es un proyecto de un único desarrollador. gstack actúa como el equipo que no existe:

- **Roles especializados** — un agente para seguridad, otro para arquitectura, otro para QA. Perspectivas independientes que de otro modo recaen en una sola persona.
- **Sprint planning estructurado** — flujo formal Think → Plan → Build → Review → Ship con entregables claros en cada fase.
- **Testing automatizado con Playwright** — abre un navegador Chromium real, prueba la app, encuentra bugs, los corrige y genera tests de regresión automáticamente.
- **Paralelización** — múltiples agentes trabajando en diferentes partes del proyecto simultáneamente.

---

## Skills más relevantes para portapp

### Para el Prototipo 2 (React Native + Supabase + sync)

| Skill | Cuándo usarlo |
|---|---|
| `/office-hours` | Antes de arrancar cualquier feature importante — hace 6 preguntas que cuestionan tus premisas y genera un design doc |
| `/plan-ceo-review` | Validar decisiones estratégicas de producto (4 modos: Expansion, Selective Expansion, Hold Scope, Reduction) |
| `/plan-eng-review` | Bloquear arquitectura con diagramas, flujo de datos, edge cases y plan de tests |
| `/plan-design-review` | Auditoría de diseño puntuando cada dimensión de 0 a 10 con feedback interactivo |
| `/qa` | QA Lead que prueba la app en Chromium real, corrige bugs con commits atómicos y genera tests de regresión |
| `/qa-only` | QA Reporter — misma metodología pero solo reporta, no modifica código |
| `/cso` | Security review cubriendo OWASP Top 10 y STRIDE threat modeling — crítico para una app financiera |
| `/ship` | Release engineer: sync, tests, coverage audit y apertura de PR automatizada |
| `/retro` | Retrospectiva semanal con análisis de tendencias |

### Otras skills útiles

| Skill | Descripción |
|---|---|
| `/review` | Code review de staff engineer con auto-fixes |
| `/investigate` | Debugging sistemático con hipótesis |
| `/design-html` | HTML/CSS production-ready desde diseños aprobados |
| `/benchmark` | Baseline de rendimiento: page load, Core Web Vitals, tamaño de recursos |
| `/canary` | Monitorización post-deploy: errores de consola y regresiones de rendimiento |
| `/autoplan` | Pipeline automático que ejecuta CEO + design + engineering reviews en secuencia |
| `/learn` | Gestión de memoria entre sesiones con aprendizaje de patrones |
| `/careful` | Avisos de seguridad antes de comandos destructivos |
| `/guard` | `/careful` + `/freeze` combinados para máxima seguridad |

---

## Cuándo instalarlo

**No ahora** — el Prototipo 1 (HTML v6) está en fase de testing con usuarios y los cambios son de bajo riesgo.

**Antes del Prototipo 2** — cuando arranque el desarrollo en React Native + Expo + Supabase + PowerSync, la complejidad se multiplica y gstack aporta valor real:
- `/plan-eng-review` para bloquear la arquitectura de sync antes de escribir código
- `/office-hours` para validar cada decisión de producto importante
- `/qa` para automatizar el testing en dispositivos reales
- `/cso` para la security review antes del lanzamiento

---

## Compatibilidad con nuestro flujo actual

gstack es 100% compatible con el flujo de trabajo actual de portapp:

- Mismo entorno (Claude Code CLI)
- Los outputs van a archivos Markdown en el repo
- Compatible con el flujo de ramas `feature/* → dev → main`
- Complementa (no reemplaza) las conversaciones de diseño y arquitectura

---

## Instalación (cuando llegue el momento)

```bash
# Desde el directorio del proyecto
gh repo clone garrytan/gstack
# Seguir instrucciones del README de gstack
```

> Ver README completo en https://github.com/garrytan/gstack
