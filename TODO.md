# portapp — TODO & Tracking

> Última actualización: 2026-04-21 · Prototipo v6

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
- **P1** — Contraste modo oscuro (`--t1`, `--t2`) (#3)
- **P2** — Tamaño de fuente configurable en Ajustes (#4)
- **P3** — Dropdown de activos en nueva operación (#5)
- **P4** — Notificaciones: borrar + favorita (#6)
- **P5** — Exposición Región/Divisa recalcula al filtrar (#7)
- **P6** — Toggle mostrar/ocultar contraseña (#8)
- **F1** — Rentabilidad TWR real (sin Math.random) (#9)
- **F2** — Capital por grupos con porcentajes (#10)
- **F5** — Rentabilidad del efectivo real (sin saldo hardcodeado) (#13)

### Bloque 4 — Perfil + Canales
- **F4** — Perfil de usuario dinámico (renderPerfil, savePerfil, sesiones) (#12)
- **F12** — Pantalla "Aprende": canales YouTube curados con filtros y favoritos (#20)

### Bloque 5 — Datos reales + DCA mejorado
- **S1** — Datos de muestra enriquecidos: +4 activos, +11 ops (cubre 1M/3M/6M), +13 movimientos efectivo en 3 carteras
- **F6** — Proyección DCA con arrastre anual explícito, métricas de capitalización y toggle simple/detallado (#14)

---

## 🔄 Prototipo — Pendiente

| # | Issue | Descripción | Prioridad |
|---|---|---|---|
| ~~F6~~ | ~~#14~~ | ~~Proyección DCA con arrastre automático de saldos anuales~~ | ✅ |
| F11 | #19 | Compartir cartera: enlace público (permanente o 3h) | Alta |
| F7 | #15 | Conexión con broker: lanzar sesión desde la app | Media |
| F8 | #16 | Upload PDF broker: importación automática de movimientos | Media |

---

## 💡 Sugerencias (no en backlog todavía)

Estas son mejoras que surgen al revisar el código actual y que aportarían valor antes de pasar a producción:

| # | Descripción | Por qué |
|---|---|---|
| ~~S1~~ | ~~**Datos de muestra más ricos**~~ | ✅ Hecho en bloque 5 |
| S2 | **Estado vacío en pantalla Global** — mensaje si no hay carteras | Robustez básica |
| S3 | **Validación en formularios** — nueva op, nuevo movimiento, nueva cartera | Actualmente aceptan campos vacíos sin aviso |
| S4 | **Búsqueda/filtro en Operaciones** — filtrar por ticker o fecha además del tipo | Usabilidad cuando hay muchas ops |
| S5 | **Pantalla de bienvenida (onboarding)** — primera vez que se entra sin carteras | Necesario antes del lanzamiento |
| S6 | **ESTADO.md actualizado** — refleja v5 pero no los cambios del bloque 3 y 4 | Mantener documentación sincronizada |

---

## 🏭 Producción — Pendiente

| # | Issue | Descripción |
|---|---|---|
| PR1 | #21 | API de cotizaciones en tiempo real |
| PR2 | #22 | Autenticación biométrica WebAuthn |
| PR3 | #23 | Backend con base de datos persistente |
| PR4 | #24 | Exportación real Excel/CSV |
| PR5 | #25 | Importación CSV desde brokers |
| PR6 | #26 | Tipos de cambio automáticos (ECB/Fixer) |
| PR7 | #27 | SMS 2FA con Twilio |
| PR8 | #28 | Email 2FA con Resend/SendGrid |
| PR9 | #29 | Bot de asistencia (API de Claude) |

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

---

## 📱 Multiplataforma — Pendiente

| # | Issue | Descripción |
|---|---|---|
| M1 | #37 | Definir estrategia: React Native vs PWA vs web |
| M2 | #38 | Safe areas iOS y Android (notch, home indicator) |
| M3 | #39 | Touch targets mínimos 44×44px |
| M4 | #40 | Navegación adaptativa móvil/tablet/escritorio |

---

## 🏢 Panel de administración — Pendiente

| # | Issue | Descripción |
|---|---|---|
| A1 | #41 | Panel completo de backoffice (auth, usuarios, logs, stats) |

---

## 📚 Backlog v2+

| # | Issue | Descripción |
|---|---|---|
| B1 | #42 | Comparativa rentabilidad vs índice benchmark |
| B2 | #43 | Splits y dividendos en especie con recálculo de precio medio |
