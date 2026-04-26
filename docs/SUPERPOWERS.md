# superpowers — Guía para portapp

> Documento preparado el 2026-04-26  
> Referencia: https://github.com/obra/superpowers

---

## Qué es superpowers

superpowers es una metodología de desarrollo disciplinada que se instala como plugin en Claude Code. No es un equipo de roles especializados (eso es gstack) — es un conjunto de hábitos y procesos que hacen que el agente trabaje con más rigor y menos improvisación.

**En una frase:** superpowers evita que el agente (o el desarrollador) construya lo equivocado, se salte tests, o pierda el hilo en proyectos complejos.

---

## Lo que NO hace

- No toca el código del proyecto
- No cambia el flujo de ramas ni los PRs
- No modifica ESTADO.md, TODO.md ni ningún archivo existente
- No obliga a nada — es opcional en cada momento

---

## Lo que SÍ hace

Añade comportamientos automáticos al agente:
- Pregunta antes de implementar (evita construir lo equivocado)
- Descompone el trabajo en tareas de 2-5 minutos con especificaciones exactas
- Aplica TDD (test primero, código después) cuando corresponde
- Permite agentes autónomos trabajando horas sin desviarse del plan

---

## Instalación

```
/plugin install superpowers@claude-plugins-official
```

Se ejecuta directamente en el prompt de Claude Code. Compatible con Cursor, OpenAI Codex y GitHub Copilot también.

---

## Skills disponibles

### Desarrollo y calidad

| Skill | Cuándo usarlo |
|---|---|
| `test-driven-development` | Ciclo RED-GREEN-REFACTOR. Usar en todo el código del Prototipo 2 |
| `systematic-debugging` | Análisis de causa raíz en 4 fases cuando algo no funciona y no sabes por qué |
| `verification-before-completion` | Valida que los fixes funcionan realmente antes de cerrar una tarea |

### Flujo de trabajo

| Skill | Cuándo usarlo |
|---|---|
| `brainstorming` | Antes de cualquier feature importante — refina requisitos con preguntas antes de escribir código |
| `writing-plans` | Genera un plan detallado con tareas de 2-5 minutos y especificaciones exactas |
| `executing-plans` | Ejecuta el plan en batch con checkpoints humanos |
| `subagent-driven-development` | Agentes autónomos por tarea con revisión en dos fases (spec + calidad de código) |
| `using-git-worktrees` | Ramas de desarrollo aisladas con baselines de test limpios |

### Colaboración

| Skill | Cuándo usarlo |
|---|---|
| `requesting-code-review` | Checklists pre-revisión contra las especificaciones |
| `receiving-code-review` | Responde feedback de forma sistemática |
| `dispatching-parallel-agents` | Varios agentes trabajando en paralelo |
| `finishing-a-development-branch` | Flujo de decisión merge/PR al cerrar una rama |

### Meta

| Skill | Cuándo usarlo |
|---|---|
| `writing-skills` | Crear skills propios siguiendo las mejores prácticas |
| `using-superpowers` | Introducción al sistema |

---

## Cómo usarlo — guía rápida

### Opción A — Uso automático
Una vez instalado, superpowers se activa automáticamente cuando el agente detecta que corresponde. No hay que hacer nada especial.

### Opción B — Activación manual
Puedes pedir un skill concreto en cualquier momento:

```
"Usa brainstorming para definir la feature de sync"
"Escribe un plan para implementar la autenticación con Supabase"
"Aplica TDD para este componente"
```

### Opción C — Ignorarlo completamente
Si prefieres hablar directamente con el agente sin estructura formal, simplemente hazlo. superpowers no interfiere.

---

## Flujo recomendado para el Prototipo 2

Para cada feature nueva:

```
1. brainstorming     → refinar requisitos antes de tocar código
2. writing-plans     → plan detallado con tareas de 2-5 min
3. executing-plans   → implementación con checkpoints
4. test-driven-dev   → tests primero, código después
5. requesting-review → checklist antes de abrir PR
```

---

## Relación con gstack

superpowers y gstack son **complementarios**:

| | superpowers | gstack |
|---|---|---|
| **Qué es** | Metodología de proceso | Equipo de roles especializados |
| **Cuándo** | Instalar ahora | Instalar antes del Prototipo 2 |
| **Activa** | Automáticamente | Con slash commands explícitos |
| **Foco** | Cómo trabajar bien | Qué perspectivas cubrir |

> Ver también: `docs/GSTACK.md`
