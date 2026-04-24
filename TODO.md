# portapp — TODO & Tracking

> Última actualización: 2026-04-22 · Prototipo v6

---

## ✅ Prototipo — Completado

### Bloque 1 — Auth + Navegación + Pantallas base
- Auth completa: login, 2FA (email/SMS), OTP, bloqueo, recuperación, lock screen
- Nav bar inferior (8 pestañas), selector de cartera, quick nav contextual
- Pantallas: Global, Resumen, Cartera, Efectivo, Operaciones, Detalle de activo
- Pantallas: Proyección DCA, Índices, Notificaciones, Plataformas externas, Ajustes
- Modo privado (enmascarar cifras), modo oscuro, tamaño de fuente configurable

### Bloque 2 — Gestión y anotaciones (v5)
- **F3** — Módulo de anotaciones global (#11)
- **F9** — Gestión de cuentas bancarias y broker en Ajustes (#17)
- **F10** — Grupos de activos: CRUD + drag & drop (#18)

### Bloque 3 — Pulido + Datos reales
- **P1–P6** — Contraste oscuro, fuente, dropdown activos, notificaciones, exposición, toggle pwd (#3–8)
- **F1** — Rentabilidad TWR real (#9)
- **F2** — Capital por grupos con porcentajes (#10)
- **F5** — Rentabilidad del efectivo real (#13)

### Bloque 4 — Perfil + Canales
- **F4** — Perfil de usuario dinámico (#12)
- **F12** — Pantalla "Aprende": canales YouTube curados (#20)

### Bloque 5 — Datos reales + DCA mejorado
- **S1** — Datos de muestra enriquecidos (3 carteras, ops 1M/3M/6M, dividendos, staking)
- **F6** — Proyección DCA con arrastre anual + métricas capitalización (#14)
- **F11** — Compartir cartera: modal perm/3h/24h, solo porcentajes (#19)

### Bloque 6 — UX y accesibilidad
- **S7** — Onboarding modal 3 pasos
- **S8** — Tooltips ⓘ en métricas técnicas
- **S9** — Validación en nueva operación + fix ticker
- **S10/S11** — Confirm al borrar + toasts de feedback
- **S12** — Estados vacíos en Cartera y Operaciones
- **S13/S14** — Labels nav bar + valor cartera en topbar

### Bloque 7 — Bugs, pulido y arquitectura
- Métricas pantalla Global hardcodeadas → calculadas desde datos reales
- Brokers selects en formularios → poblados dinámicamente desde `cuentas[]`
- Lock screen: timer → elapsed time (fiable en segundo plano móvil)
- Escudo de privacidad en multitarea (mask + shield overlay)
- `addCartera()` → auto-selecciona la nueva cartera al crearla
- Filtro "Rendimiento" en Operaciones → añadidos ops de dividendos y staking
- Nav bar fija al hacer scroll (min-height → height 100dvh)
- Ajustes reordenados por frecuencia de uso (Interfaz primero)
- Datos: 4 botones → modal único "📤 Exportar · Importar · Backup"
- Breadcrumbs: más visibles (13px, negrita) + flecha añadida donde faltaba
- Breadcrumb Rent. efectivo → apunta a Resumen (no Efectivo)
- Nav bar activo → fondo `--ac-bg` para mayor distinción
- Formulario soporte en Ajustes (email + dropdown de asunto)
- TWR y labels técnicos → lenguaje accesible para usuario no técnico
- Título versión → v6
- Copyright notice en index.html
- CI/CD GitHub Actions configurado (validación HTML en PR a main)
- Flujo de ramas: `main` ← `dev` ← `feature/*`

### Bloque 8 — Ayuda y accesibilidad
- **H1** — Pantalla `s-ayuda`: guía de uso por pantalla + FAQ (acordeón nativo)
- **H2** — Fecha y hora del último backup en Ajustes > Datos
- **H3** — Guía backup/restore paso a paso en `s-ayuda` (usuario no técnico, local-first)
- Botón ❓ en topbar → acceso directo a `s-ayuda` desde cualquier pantalla
- Enlace contextual "¿Cómo funciona el backup?" en modal de Datos

---

## 🔄 Prototipo — Pendiente

| # | Descripción | Prioridad |
|---|---|---|
| F7 | Conexión con broker: lanzar sesión desde la app | Media |
| F8 | Upload PDF broker: importación automática (requiere backend + IA) | Media |
| S2 | Estado vacío en pantalla Global si no hay carteras | Baja |
| S4 | Búsqueda/filtro en Operaciones por ticker o fecha | Baja |

---

## 📋 Próxima PR — Pendiente de implementar

*(vacío — sin items pendientes)*

---

## 🔭 Prototipo 2 — Local-first (pendiente de decidir)

| # | Descripción |
|---|---|
| LF1 | Validar arquitectura: React Native + Expo SQLite + PowerSync/Electric SQL |
| LF2 | Alcance mínimo: login, crear cartera + activo, offline, sync entre 2 dispositivos |
| LF3 | Criterio: si sync funciona bien → adoptar local-first para producción |

> Ver sección 20 de ESTADO.md para detalle completo.

---

## 🏭 Producción — Pendiente

| # | Issue | Descripción |
|---|---|---|
| PR1 | #21 | API de cotizaciones en tiempo real |
| PR2 | #22 | Autenticación biométrica WebAuthn |
| PR3 | #23 | Backend / SQLite local (según arquitectura elegida) |
| PR4 | #24 | Exportación real Excel/CSV |
| PR5 | #25 | Importación CSV desde brokers |
| PR6 | #26 | Tipos de cambio automáticos |
| PR7 | #27 | SMS 2FA con Twilio |
| PR8 | #28 | Email 2FA con Resend/SendGrid |
| PR9 | #29 | Bot de asistencia (API de Claude) |
| PR10 | — | Validación de ticker al comprar (verificar existencia vía API) — ver ESTADO.md sec 21 |
| PR11 | — | Selección de bolsa y divisa al comprar si el valor cotiza en varios mercados — ver ESTADO.md sec 21 |
| PR12 | — | Verificación de fondos suficientes antes de confirmar compra — ver ESTADO.md sec 21 |
| PR13 | — | Integridad referencial: modelo de entidades + reglas de borrado — ver ESTADO.md sec 22 |
| PR14 | — | ~~Decisión de modelado de datos~~ → **Kimball adoptado** (ver ESTADO.md sec 23) |
| PR15 | — | ~~Completar esquema Kimball~~ → **Modelo cerrado** (ver ESTADO.md sec 23) |
| PR16 | — | Botón actualización manual de cotizaciones + indicador de antigüedad — ver ESTADO.md sec 25 |
| PR17 | — | Cotización en tiempo real como función premium — ver ESTADO.md sec 25 |
| PR18 | — | Configurar Supabase como backend: Auth, Storage, RLS, Edge Functions — ver ESTADO.md sec 24 |
| PR19 | — | Diseñar contenido y formato de exports CSV/Excel — ver ESTADO.md sec 26 |
| PR20 | — | Diseñar y generar reports PDF (resumen anual, P&L, por broker, TWR) — ver ESTADO.md sec 26 |
| PR21 | — | Crear docs/DATA_MODEL.md con diagrama Mermaid del modelo completo |
| PR22 | — | Crear docs/ARCHITECTURE.md, docs/DECISIONS.md y docs/CONTRIBUTING.md |
| PR23 | — | Confirmación por email para cambios críticos de perfil (email, pwd, 2FA) — ver ESTADO.md sec 27 |
| PR24 | — | Flujo de eliminación de cuenta: solo owner, email, período de gracia — ver ESTADO.md sec 27 |
| PR25 | — | Cierre de sesión automático por inactividad (30d móvil, 24h web) — ver ESTADO.md sec 27 |
| PR26 | — | Backup gestionado en servidor como Tier 2+ — ver ESTADO.md sec 28 |

---

## 🔐 Seguridad — Pendiente (producción)

| # | Issue | Descripción |
|---|---|---|
| SEC | #30 | TLS 1.3 y HSTS obligatorio |
| SEC | #31 | Hashing contraseñas con bcrypt/argon2 |
| SEC | #32 | JWT con refresh token en HttpOnly cookie |
| SEC | #33 | Rate limiting en login y endpoints críticos |
| SEC | #34 | Cifrado de campos sensibles en BD (AES-256) |
| SEC | #35 | Cabeceras de seguridad HTTP (CSP, CORS, X-Frame) |
| SEC | #36 | Aislamiento total entre usuarios |
| M12 | — | FLAG_SECURE en app nativa (protección pantalla en multitarea) |

---

## 📱 Multiplataforma — Pendiente

| # | Issue | Descripción |
|---|---|---|
| M1 | #37 | Definir estrategia final: local-first (React Native) vs cliente-servidor (Next.js) |
| M2 | #38 | Safe areas iOS y Android |
| M3 | #39 | Touch targets mínimos 44×44px |
| M4 | #40 | Navegación adaptativa móvil/tablet/desktop |
| M13 | — | GitHub Pro: branch protection completa (cuando haya tracción) |

---

## 🏢 Panel de administración — Pendiente

| # | Issue | Descripción |
|---|---|---|
| A1 | #41 | Panel completo de backoffice (auth, usuarios, logs, stats, canales YouTube) |

---

## 📚 Backlog v2+

| # | Issue | Descripción |
|---|---|---|
| B1 | #42 | Comparativa rentabilidad vs índice benchmark |
| B2 | #43 | Splits y dividendos en especie con recálculo de precio medio |
