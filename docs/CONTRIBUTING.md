# Portgrow — Guía de contribución

---

> **STOP — antes de abrir cualquier PR:**
> `gh pr create` SIEMPRE con `--base dev`. Nunca `--base main`.
> Si el PR ya existe contra `main`, cerrarlo y recrearlo contra `dev`.
> Esta regla se ha violado en los PRs #149 y #267 — ambas veces con impacto en el historial de ramas.

---

## Ramas y flujo de trabajo

```
main          ← rama estable, solo recibe merges desde dev
dev           ← rama de integración
feature/*     ← una rama por funcionalidad o fix
```

**Regla cardinal:** ningún commit va directamente a `main` ni a `dev`. Todo pasa por una rama `feature/*` y un PR.

```
feature/mi-cambio → PR a dev → (revisión) → merge → sync automático a main → merge a main
```

El workflow `.github/workflows/sync-dev.yml` abre y mergea automáticamente el PR `main → dev` cada vez que se mergea algo a `main`, para mantener ambas ramas alineadas.

---

## Crear una rama de trabajo

```bash
git checkout dev && git pull origin dev
git checkout -b feature/descripcion-corta
```

Prefijos de nombre de rama:

| Prefijo | Uso |
|---|---|
| `feature/` | Nueva funcionalidad |
| `fix/` | Corrección de bug |
| `docs/` | Solo documentación |
| `refactor/` | Refactorización sin cambio de comportamiento |

---

## Commits

Formato: `tipo: descripción en imperativo, en español`

```
feat: añadir modal de consentimiento de backup
fix: separador de miles en pantalla Efectivo
docs: sección 35 — estrategia de entornos
refactor: extraer cartaHead() y cartaRows() de renderCartera
```

Tipos: `feat` · `fix` · `docs` · `refactor` · `test` · `chore`

Una línea. Sin punto final. Sin "he añadido" ni "añadimos" — imperativo directo.

---

## Pull Requests

- **Base siempre `dev`**, nunca `main`
- Título = mensaje del commit principal
- Descripción: qué cambia, pantallas afectadas, cómo probar
- Antes de abrir el PR: comprobar que el prototipo abre sin errores en el navegador
- Miguel revisa y mergea — no se hace auto-merge en feature → dev

---

## Trabajar con el prototipo (`prototype/index.html`)

El prototipo es un único fichero HTML + CSS + JS. Antes de editar:

```bash
# Localizar la sección exacta, nunca leer el fichero entero
grep -n "renderEfectivo\|función que busco" prototype/index.html
```

Convenciones del código (ver `CLAUDE.md` para el detalle completo):

- JS vanilla, sin módulos, sin TypeScript
- Template literals para HTML dinámico
- Variables CSS (`var(--nombre)`) para todos los colores — nunca valores fijos
- `fe(n)` para formatear importes monetarios (`€12.345`)
- `fp(n)` para porcentajes (`+12,3%`)
- Destruir el chart antes de re-renderizar: `if(chX) chX.destroy()`

---

## Archivos clave

| Archivo | Contenido |
|---|---|
| `prototype/index.html` | Todo el prototipo (~184 KB) |
| `ESTADO.md` | Estado actual, backlog, decisiones de producto |
| `docs/DECISIONS.md` | ADR — decisiones de arquitectura |
| `docs/SPEC.md` | Especificación técnica |
| `docs/DATA_MODEL.md` | Modelo de datos v1.x |
| `docs/BUSINESS_PLAN.md` | Plan de negocio |
| `CLAUDE.md` | Instrucciones para el agente de IA |

> **ESTADO.md** e `index.html` son ficheros grandes. Usar siempre `grep` o `Read` con `offset/limit` — nunca leerlos completos.

---

## Entornos y base de datos

Ver `docs/DECISIONS.md` ADR-009 y `ESTADO.md` sección 35 para la estrategia completa.

En resumen:
- `portgrow-dev` — desarrollo y pruebas
- `portgrow-prod` — usuarios reales
- Los cambios de schema van en `supabase/migrations/` y se aplican vía CI/CD, nunca manualmente

---

## Lo que NO hacer

- No mergear directamente a `main`
- No leer `index.html` ni `ESTADO.md` completos (error de contexto irrecuperable)
- No añadir dependencias npm al prototipo (solo Chart.js vía CDN)
- No usar `localStorage` en el prototipo (los datos viven en memoria)
- No tocar el bloque de autenticación sin leer ese bloque completo primero
- No cambiar el modelo de IA (Haiku/Opus/Sonnet) sin autorización explícita de Miguel
