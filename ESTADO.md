# portapp — Estado del proyecto

> Última actualización: prototipo v6 — Bloques 3–8 completados · Arquitectura local-first en evaluación  
> Credenciales demo: `usuario@portapp.com` / `demo1234` / 2FA: `123456`

---

## 1. Decisiones de arquitectura

| Decisión | Valor | Notas |
|---|---|---|
| Fase actual | Prototipo HTML v6 | Sin servidor, un solo archivo. Ver sección 2. |
| Stack producción | **Híbrido local-first + Supabase** — ver sección 20 | Datos del usuario en local con sync; cotizaciones, auth y pagos en servidor |
| Auth | Email + contraseña + 2FA (email o SMS) | Biometría WebAuthn en v2 — gestionado por Supabase Auth |
| Divisas | Multi-divisa (EUR, USD y otras) | Tipos de cambio manuales en prototipo, automáticos en producción |
| Offline / cloud | **Híbrido** — ver sección 20 | Datos operacionales local-first + sync; resto en Supabase |
| Plataforma | **React Native + Expo + web** | iOS + Android + web — las tres plataformas desde una base de código |
| Nombre comercial | **Portgrow** | Dominio: portgrow.app (registrado 2026-04-28) |
| Repo | GitHub privado (whistle59/portapp) | Branches: `main` (estable) + `dev` (integración) + `feature/*` (trabajo) |
| CI/CD | GitHub Actions | Validación HTML en cada push a `dev` y PR a `main` |

---

## 2. Pantallas implementadas en el prototipo

### Auth (v1)
- Login con email + contraseña
- Selección de método 2FA (email o SMS)
- Pantalla OTP con 6 campos, cuenta atrás, reenvío
- Bloqueo automático tras 3 intentos fallidos (contador de desbloqueo)
- Recuperación de contraseña por email
- Lock screen al pasar la app a segundo plano (`visibilitychange`)

### Navegación (v1)
- Barra inferior con 8 pestañas
- Selector de cartera activa siempre visible en la barra superior
- Botón "Global" acceso directo a vista consolidada
- Quick nav contextual en cada pantalla

### Global (v1)
- Vista consolidada de todas las carteras con valor, rentabilidad y barra de progreso
- Gráfico donut de distribución por grupo (todas las carteras)
- Exposición por divisa global

### Resumen (v1)
- Métricas de la cartera activa (valor, invertido, P/L, nº activos)
- Actividad reciente

### Resumen — Historial (v3)
- Gráfico de línea con evolución histórica del valor de la cartera
- Selector de período funcional: 1S / 1M / 3M / 6M / 1A / Todo

### Resumen — Gráfico por grupo (v1)
- Gráfico donut con distribución de la cartera activa por grupo

### Cartera (v1)
- Tabla de activos con filtros funcionales: Todos / Acciones / ETFs / Cripto
- Exposición por Región (barras de progreso)
- Exposición por Divisa (barras de progreso)
- Clic en activo navega al detalle

### Efectivo (v1)
- Saldo total y métricas del mes
- Saldos discriminados por broker / cuenta
- Tabla de movimientos con campo "Origen" (cuenta vs operación)
- Formulario de nuevo movimiento con integridad referencial

### Operaciones (v2)
- Tabla con filtros funcionales: Todas / Compras / Ventas / Rendimientos
- Formulario de nueva operación (cartera, fecha, ticker, tipo, broker, qty, precio, comisión, divisa, grupo, nota)
- Botón + Op. accesible desde la barra superior

### Detalle de activo (v2)
- Accesible desde Cartera y desde Operaciones
- Métricas: valor actual, P/L, precio medio, cotización
- Ficha completa (ISIN, tipo, mercado, divisa, índice, broker, grupo)
- Historial de operaciones del activo
- Anotaciones con formulario para añadir notas
- Breadcrumb para volver

### Proyección DCA (v1)
- Calculadora con aportación, frecuencia (semanal/quincenal/mensual), revalorización y horizonte
- Gráfico de línea y tabla anual

### Índices (v2)
- Generados dinámicamente desde los activos de la cartera activa que tienen índice asignado
- Datos: YTD, 12 meses, PER, dividendo, nº valores

### Notificaciones (v3)
- Lista de avisos con tipos: alerta / dca / info
- Indicador rojo en el botón 🔔 si hay no leídas
- Configuración de alertas por tipo y umbral de variación (%)

### Plataformas externas (v2)
- Accesos directos configurables a: ProRealTime, IBKR, TradingView, Binance, Coinbase
- Formulario para añadir nuevas plataformas

### Ajustes (v1)
- Divisas activas
- Brokers y cuentas (con formulario: broker o cuenta bancaria, IBAN/BIC)
- Grupos de activos (chips editables)
- Seguridad: bloqueo por segundo plano, tiempo de gracia, agitar para enmascarar
- Interfaz: modo oscuro, decimales, formato fecha
- Datos: exportar Excel/CSV, importar PDF, backup
- Cerrar sesión (funcional, vuelve al login)

### Privacidad (v1)
- Botón 👁 enmascara todas las cifras con `•••••`
- Barra superior visible cuando el modo privado está activo
- Toque en la barra para desactivar

### Modo oscuro (v3)
- Toggle funcional en Ajustes > Interfaz
- CSS variables redefinidas con clase `.dark` en `<html>`
- Gráficos se rerrenderizan con paleta oscura al cambiar

### Rentabilidad TWR (v6)
- Pantalla `s-rentabilidad` con cálculo TWR real desde operaciones
- Filtros por período: 1M / 3M / 6M / 1A / Todo
- Tabla por activo con rentabilidad individual

### Capital por grupos (v6)
- Pantalla `s-grupos` con distribución porcentual por grupo y gráfico donut

### Perfil de usuario (v6)
- Pantalla `s-perfil` con datos del usuario y botón de cierre de sesión funcional

### Rentabilidad del efectivo (v6)
- Pantalla `s-rent-efectivo` con cálculo de rendimiento sobre saldos de efectivo

### Anotaciones globales (v5)
- Pantalla `s-anotaciones` con lista de notas libres y formulario para añadir/borrar

### Aprende — Canales YouTube (v6)
- Pantalla `s-canales` con canales curados por categoría y marcado de favoritos ⭐

### Ayuda (v6)
- Pantalla `s-ayuda` accesible desde topbar (❓) y Ajustes > Soporte y ayuda
- Guía de uso por pantalla (acordeón), FAQ y guía backup/restore paso a paso

> **Nota sobre datos del prototipo:** cotizaciones, tipos de cambio y parte del historial de efectivo son datos hardcodeados en variables JS. No hay integración con APIs externas. El código OTP `123456` es simulado — no valida contra un backend real.

> **Modo básico/avanzado:** las pantallas `s-rentabilidad`, `s-grupos`, `s-rent-efectivo`, `s-indices`, `s-anotaciones` y `s-canales` están ocultas en modo básico. El usuario puede activar el modo avanzado desde Ajustes → Modo de uso. Switch gratuito, sin restricción de plan. Decisión: reducir fricción de onboarding para inversores nuevos sin penalizar a los avanzados. El modo persiste entre sesiones (localStorage).

---

## 3. Iteraciones de pulido — estado

| # | Descripción | Estado |
|---|---|---|
| P1 | Modo oscuro: aumentar contraste de textos secundarios (`--t1`, `--t2`) | ✅ v6 |
| P2 | Tamaño de fuente configurable en Ajustes | ✅ v6 |
| P3 | Nueva operación: desplegable con activos de la cartera + opción "nuevo activo" | ✅ v6 |
| P4 | Notificaciones: botón borrar + marcar como favorita ⭐ | ✅ v6 |
| P5 | Exposición por Región/Divisa: recalcular al usar filtros de tipo de activo | ✅ v6 |
| P6 | Toggle mostrar/ocultar contraseña en login, lock screen y cambio de contraseña | ✅ v6 |
| P7 | Reemplazar acrónimo "TWR" por "RPT" (Rentabilidad Ponderada por Tiempo) — público hispanohablante | 🔄 Pendiente |

---

## 4. Funcionalidades nuevas — estado

| # | Descripción | Estado |
|---|---|---|
| F1 | Pantalla de rentabilidad real por activo y por período | ✅ v6 — TWR real desde ops |
| F2 | Cuadro de capital por grupos con porcentajes sobre el total | ✅ v6 |
| F3 | Módulo de anotaciones global | ✅ v5 |
| F4 | Perfil de usuario y gestión de sesión | ✅ v6 — renderPerfil() dinámico |
| F5 | Rentabilidad del efectivo en período determinado | ✅ v6 — base real desde efectivoData |
| F6 | Proyección DCA con arrastre automático de saldos anuales | ✅ v6 — tabla detallada con toggle |
| F7 | Conexión con broker: lanzar sesión desde la app | 🔄 Pendiente |
| F8 | Upload de PDF del broker: importación automática | 🔄 Pendiente (requiere backend + IA) |
| F9 | Gestión de cuentas bancarias y cuentas broker en Ajustes | ✅ v5 |
| F10 | Grupos de activos: CRUD completo + drag & drop | ✅ v5 |
| F11 | Compartir cartera: enlace público (permanente/3h/24h), solo porcentajes | ✅ v6 |
| F12 | Pantalla "Aprende": canales YouTube curados con filtros y favoritos | ✅ v6 |
| F13 | Glosario de términos financieros en "Aprende" (~40-50 términos: ETFs, acciones, macro) | 🔄 Prototipo pendiente |
| F14 | IA conversacional en "Aprende": responde preguntas contextualizadas sobre términos y cartera | 🔄 Producción |
| F15 | Toggle "Vista detalle / Vista rendimiento" en s-cartera (solo modo avanzado) | 🔄 Prototipo pendiente |

---

## 5. Pendientes — producción

| # | Descripción |
|---|---|
| PR1 | API cotizaciones tiempo real (Yahoo Finance / Alpha Vantage / ProRealTime) |
| PR2 | Autenticación biométrica WebAuthn (gratuita) |
| PR3 | Backend con base de datos persistente |
| PR4 | Exportación real Excel — spec parcial, ver sección 31 |
| PR5 | Importación CSV desde brokers |
| PR6 | Tipos de cambio automáticos (ECB API / Fixer.io) |
| PR7 | SMS 2FA (Twilio ~0,05€/SMS) |
| PR8 | Email 2FA (Resend/SendGrid, gratuito hasta 100/día) |
| PR9 | Bot de asistencia al usuario (API de Claude) |

---

## 6. Backlog v2+

| # | Descripción |
|---|---|
| B1 | Comparativa de rentabilidad vs índice de referencia benchmark |
| B2 | Soporte para splits y dividendos en especie con recálculo de precio medio |

---

## 7. Estructura del repositorio

```
portapp/
├── prototype/
│   └── index.html        ← prototipo autocontenido (abrir en navegador)
├── src/
│   └── data/
│       └── sampleData.js ← estructuras de datos y datos de ejemplo
├── docs/
│   └── SPEC.md           ← especificación técnica detallada
├── ESTADO.md             ← este archivo
└── .gitignore
```

---

## 8. Cómo probar el prototipo

1. Abrir `prototype/index.html` en cualquier navegador (sin servidor)
2. Para móvil: publicar en [netlify.com/drop](https://netlify.com/drop) arrastrando el HTML → URL pública en 30 segundos


---

## 9. Arquitectura de seguridad (análisis por capas)

> Análisis completo para la versión de producción. El prototipo actual no implementa estas medidas.

---

### Capa 1 — Transporte (HTTPS / TLS)

**Objetivo:** impedir que nadie intercepte el tráfico entre el dispositivo y el servidor.

| Medida | Descripción | Prioridad |
|---|---|---|
| TLS 1.3 obligatorio | Todo el tráfico cifrado. Redirigir HTTP → HTTPS automáticamente | 🔴 Crítica |
| HSTS | Cabecera `Strict-Transport-Security` para forzar HTTPS en el navegador | 🔴 Crítica |
| Certificate pinning | En las apps nativas (iOS/Android), validar que el certificado del servidor es el esperado | 🟡 Alta |
| Sin mixed content | Todos los recursos (imágenes, scripts, fuentes) deben cargarse por HTTPS | 🔴 Crítica |

---

### Capa 2 — Autenticación y sesión

**Objetivo:** garantizar que solo el usuario legítimo accede a sus datos.

| Medida | Descripción | Prioridad |
|---|---|---|
| Hashing de contraseñas | Usar `bcrypt` o `argon2` con salt. Nunca almacenar en claro | 🔴 Crítica |
| 2FA obligatorio | Ya prototipado. En producción: TOTP (Google Authenticator) como opción adicional a email/SMS | 🔴 Crítica |
| Tokens JWT con expiración corta | Access token: 15 min. Refresh token: 7-30 días, rotado en cada uso | 🔴 Crítica |
| Refresh token en HttpOnly cookie | No accesible desde JavaScript. Protege contra XSS | 🔴 Crítica |
| Invalidación de sesiones | Al cerrar sesión, revocar el refresh token en el servidor | 🔴 Crítica |
| Bloqueo por intentos fallidos | Ya prototipado. En producción: bloqueo progresivo + notificación al usuario | 🔴 Crítica |
| Rate limiting en login | Máx. 5 intentos por IP en 15 min | 🔴 Crítica |
| Detección de sesiones simultáneas | Avisar si se detecta login desde otro dispositivo/IP | 🟡 Alta |
| Biometría (v2) | WebAuthn / FIDO2, gratuito, sin almacenar datos biométricos en el servidor | 🟡 Alta |

---

### Capa 3 — API y backend

**Objetivo:** impedir acceso no autorizado a datos y ejecución de operaciones no permitidas.

| Medida | Descripción | Prioridad |
|---|---|---|
| Autorización por recurso | Cada endpoint verifica que el usuario autenticado es propietario del recurso solicitado | 🔴 Crítica |
| Validación de inputs en servidor | Nunca confiar en datos del cliente. Validar tipo, formato y rango de todos los campos | 🔴 Crítica |
| Protección contra inyección SQL | Usar ORM (Prisma, Drizzle) o queries parametrizadas. Nunca concatenar strings en queries | 🔴 Crítica |
| Protección contra inyección NoSQL | Si se usa MongoDB u otra NoSQL, sanitizar todos los operadores (`$where`, `$gt`, etc.) | 🟡 Alta |
| Rate limiting por endpoint | Límites distintos según criticidad: login, operaciones, exportaciones | 🔴 Crítica |
| CORS restrictivo | Solo permitir orígenes conocidos (dominio de la app). Nunca `Access-Control-Allow-Origin: *` en producción | 🔴 Crítica |
| Cabeceras de seguridad HTTP | `Content-Security-Policy`, `X-Frame-Options`, `X-Content-Type-Options`, `Referrer-Policy` | 🔴 Crítica |
| Logs de auditoría | Registrar todas las operaciones sensibles: login, cambio de contraseña, operaciones financieras | 🟡 Alta |
| Secrets en variables de entorno | API keys, credenciales de BD, claves JWT nunca en el código fuente ni en el repo | 🔴 Crítica |

---

### Capa 4 — Base de datos

**Objetivo:** proteger los datos en reposo y limitar el impacto de una brecha.

| Medida | Descripción | Prioridad |
|---|---|---|
| Cifrado en reposo | Activar cifrado nativo del motor de BD (PostgreSQL con `pgcrypto`, o cifrado a nivel de disco) | 🔴 Crítica |
| Cifrado de campos sensibles | Campos como IBAN, número de cuenta broker cifrados en la BD con clave de aplicación (AES-256) | 🔴 Crítica |
| Usuario de BD con mínimos privilegios | La app solo tiene permisos SELECT/INSERT/UPDATE/DELETE sobre sus tablas. Nunca acceso DDL en producción | 🔴 Crítica |
| Backups cifrados | Copias de seguridad cifradas y almacenadas en ubicación separada | 🔴 Crítica |
| Sin datos personales en logs | Asegurar que los logs del servidor no registran contraseñas, tokens ni datos financieros | 🔴 Crítica |
| Auditoría de accesos a la BD | Registrar qué usuario de aplicación accedió a qué datos y cuándo | 🟡 Alta |

---

### Capa 5 — Frontend / cliente

**Objetivo:** impedir ataques desde el navegador o la app.

| Medida | Descripción | Prioridad |
|---|---|---|
| Protección XSS | Nunca usar `innerHTML` con datos del servidor. Usar librerías que escapan HTML por defecto (React lo hace) | 🔴 Crítica |
| Content Security Policy (CSP) | Restringir qué scripts, estilos y recursos externos puede cargar la página | 🔴 Crítica |
| Protección CSRF | Tokens CSRF en formularios, o usar `SameSite=Strict` en cookies | 🔴 Crítica |
| Sin datos sensibles en localStorage | Nunca almacenar tokens, contraseñas ni datos financieros en `localStorage` o `sessionStorage` | 🔴 Crítica |
| Timeout de sesión por inactividad | Ya prototipado (bloqueo por segundo plano). En producción: expiración configurable | 🟡 Alta |
| Modo privado | Ya prototipado. Enmascarar cifras en pantalla | 🟢 Media |
| Ofuscación del bundle | En producción, el código JS minificado y ofuscado dificulta la ingeniería inversa | 🟢 Media |

---

### Capa 6 — Infraestructura y despliegue

**Objetivo:** reducir la superficie de ataque del servidor y el entorno.

| Medida | Descripción | Prioridad |
|---|---|---|
| WAF (Web Application Firewall) | Filtrar tráfico malicioso antes de que llegue a la app (Cloudflare, AWS WAF) | 🟡 Alta |
| DDoS protection | Cloudflare o proveedor cloud con protección incluida | 🟡 Alta |
| Actualizaciones de dependencias | Auditoría periódica con `npm audit` / `dependabot`. Sin dependencias con vulnerabilidades conocidas | 🔴 Crítica |
| Escaneo de secretos en el repo | Herramienta tipo `truffleHog` o `git-secrets` para evitar subir API keys accidentalmente | 🔴 Crítica |
| CI/CD con checks de seguridad | Pipeline que ejecuta tests de seguridad antes de cada despliegue | 🟡 Alta |
| Acceso SSH solo por clave | Sin acceso por contraseña al servidor. Claves SSH con passphrase | 🟡 Alta |
| Variables de entorno seguras | Usar gestor de secretos (AWS Secrets Manager, Vault, Doppler) en lugar de archivos `.env` en servidor | 🟡 Alta |

---

### Capa 7 — Datos financieros (específico de portapp)

**Objetivo:** proteger la integridad y confidencialidad de los datos de inversión del usuario.

| Medida | Descripción | Prioridad |
|---|---|---|
| Aislamiento total entre usuarios | Un usuario nunca puede ver ni modificar datos de otro, aunque manipule IDs en la URL | 🔴 Crítica |
| Inmutabilidad del historial de operaciones | Las operaciones registradas no se pueden editar, solo anular con contrapartida | 🟡 Alta |
| Cifrado de credenciales de broker | Si se almacenan credenciales de acceso a brokers externos, cifrarlas con clave derivada de la contraseña del usuario | 🔴 Crítica |
| Sin almacenamiento de contraseñas de broker en claro | Considerar OAuth2 con los brokers que lo soporten en lugar de usuario/contraseña | 🟡 Alta |
| Auditoría de exportaciones | Registrar cada vez que un usuario exporta sus datos | 🟢 Media |
| Enlace de compartir con caducidad | Ya previsto en el prototipo. En producción: tokens de un solo uso o con TTL | 🟡 Alta |

---

### Resumen de prioridades

| Prioridad | Descripción | Implementar |
|---|---|---|
| 🔴 Crítica | Sin esto la app no debería salir a producción | Antes del lanzamiento |
| 🟡 Alta | Importante, puede implementarse en las primeras semanas post-lanzamiento | Sprint 1-2 post-launch |
| 🟢 Media | Mejora la seguridad pero el riesgo sin ella es bajo | Backlog |



---

## 10. Pendientes — multiplataforma

| # | Descripción | Prioridad |
|---|---|---|
| M1 | Definir estrategia: React Native (una base de código para iOS + Android) vs PWA vs web responsive | 🔴 Decidir primero |
| M2 | Viewport y safe areas en iOS (notch, Dynamic Island, home indicator) | 🔴 Crítica |
| M3 | Viewport en Android (barra de navegación, teclado que empuja el contenido) | 🔴 Crítica |
| M4 | Tamaños de pantalla: iPhone SE (375px) → iPad Pro (1024px) → escritorio | 🔴 Crítica |
| M5 | Navegación adaptativa: barra inferior en móvil, sidebar en tablet/escritorio | 🟡 Alta |
| M6 | Tipografía escalable con `clamp()` o unidades `rem` relativas al viewport | 🟡 Alta |
| M7 | Touch targets mínimos de 44×44px en todos los elementos interactivos (guía Apple HIG) | 🔴 Crítica |
| M8 | Soporte para gestos nativos: swipe para volver, pull-to-refresh | 🟡 Alta |
| M9 | Testing en dispositivos reales: iPhone SE, iPhone 15, iPad, Android gama media | 🟡 Alta |
| M10 | Publicación en App Store (Apple) y Google Play si se elige app nativa | 🟡 Alta |
| M11 | PWA: manifest.json, service worker, instalable desde el navegador (alternativa sin tiendas) | 🟢 Media |
| M13 | **GitHub Pro** — Activar cuando haya tracción validada. Desbloquea: branch protection completa para `main` y `dev` (require PR, require CI pass, prevent direct push), reglas de merge por rama. Coste: 4$/mes. Actualmente solo están activas `restrict deletions` y `block force pushes` en `main` (disponibles en plan gratuito). | 🟡 Cuando haya tracción |
| M12 | **Protección de pantalla en multitarea** — implementar `FLAG_SECURE` (Android) y `UIWindow.isSecure` (iOS) en la app nativa para impedir que el OS capture contenido financiero en el app switcher y en screenshots. En el prototipo web se enmascaran los valores `.amt` como solución provisional, pero no es posible bloquear la captura del OS desde un navegador. | 🔴 Crítica |

---

## 11. Pendientes — panel de administración (backoffice)

> Panel web separado, accesible solo desde IPs autorizadas o VPN.

| # | Descripción | Prioridad |
|---|---|---|
| A1 | Autenticación independiente: usuario admin con contraseña propia + 2FA obligatorio | 🔴 Crítica |
| A2 | Gestión de usuarios: listar, buscar, activar/desactivar, eliminar cuentas | 🔴 Crítica |
| A3 | Visor de base de datos: consultas de solo lectura sobre cualquier tabla | 🟡 Alta |
| A4 | Logs de auditoría: ver todas las operaciones sensibles de todos los usuarios | 🟡 Alta |
| A5 | Gestión de sesiones activas: ver y revocar sesiones de cualquier usuario | 🟡 Alta |
| A6 | Estadísticas globales: nº usuarios, nº carteras, nº operaciones, activos más usados | 🟢 Media |
| A7 | Gestión de notificaciones: enviar avisos a usuarios o grupos de usuarios | 🟢 Media |
| A8 | Herramientas de debugging: ver errores, logs de la app, estado de colas | 🟡 Alta |
| A9 | Gestión de configuración global: parámetros de la app sin necesidad de redesplegar | 🟢 Media |
| A10 | Acceso restringido por IP o VPN: el panel no debe ser accesible desde internet abierto | 🔴 Crítica |
| A11 | Roles de admin: superadmin (acceso total) y admin (acceso limitado, sin BD directa) | 🟡 Alta |



---

## Notas de seguridad adicionales

- Todos los campos de contraseña usan `type="password"` por defecto con toggle 👁 para revelar
- Nunca usar `autocomplete="new-password"` en formularios de cambio de contraseña
- Panel admin (A12): gestión de canales YouTube con CRUD, estadísticas de clics y badge "Destacado" (ver sección 11)



---

## 12. Modelo de monetización

### Estrategia revisada: Híbrido pago único + suscripción por servicios + B2B

> **Por qué no solo pago único:** el pago único genera ingresos lineales con la adquisición de clientes. Cuando el mercado se satura, los ingresos caen. No es un modelo sostenible a largo plazo por sí solo.
>
> **Por qué no solo suscripción:** los usuarios están hartos de suscripciones. La tasa de conversión es menor y genera fricción en la adquisición.
>
> **La solución:** pago único como gancho de entrada + suscripción anual opcional solo para servicios que tienen **coste recurrente real y valor tangible** (APIs de datos, almacenamiento en nube) + B2B como pilar de ingresos recurrentes estables.

---

### Tier 1 — Plan gratuito (adquisición)
Objetivo: eliminar fricción de entrada, generar base de usuarios y demostrar valor.

| Funcionalidad | Incluida |
|---|---|
| 1 cartera | ✅ |
| Hasta 20 operaciones | ✅ |
| Resumen y gráficos básicos | ✅ |
| Proyección DCA | ✅ |
| Acceso a canales de YouTube curados | ✅ |
| Cotizaciones con retraso (15 min) | ✅ |
| Exportación de datos | ❌ |
| Carteras ilimitadas | ❌ |
| Historial completo | ❌ |
| Alertas avanzadas | ❌ |
| Compartir cartera | ❌ |
| Cotizaciones en tiempo real | ❌ |
| Sincronización en la nube / multi-dispositivo | ❌ |

---

### Tier 2 — Plan personal (pago único)
Objetivo: conversión sin fricción de suscripción. Precio orientativo: **29–49€** pago único.

Incluye todo lo del plan gratuito, más:

| Funcionalidad adicional | Notas |
|---|---|
| Carteras ilimitadas | — |
| Operaciones ilimitadas | — |
| Historial completo con todos los períodos | — |
| Exportación Excel / CSV | — |
| Importación PDF de broker | — |
| Alertas configurables | — |
| Compartir cartera (enlace público) | — |
| Actualizaciones durante 1 año | Pasado el año, la app sigue funcionando; las nuevas funciones requieren renovar |

---

### Tier 2+ — Suscripción anual por servicios con coste real
Opcional para usuarios del Plan personal. Precio orientativo: **12–24€/año**.

> Solo se cobra por servicios que tienen un coste de infraestructura recurrente real. Esto lo hace justificable y no se percibe como "pagar por lo que ya tengo".

| Servicio | Por qué tiene coste recurrente |
|---|---|
| Cotizaciones en tiempo real | API de datos de mercado (Yahoo Finance, Alpha Vantage, etc.) |
| Tipos de cambio automáticos | API de divisas (ECB, Fixer.io) |
| Sincronización en la nube | Almacenamiento y backend |
| Backup automático | Almacenamiento |
| Actualizaciones pasado el primer año | Mantenimiento continuo |

---

### Tier 3 — Plan profesional B2B
Objetivo: asesores financieros, family offices, gestores de patrimonios. Precio orientativo: **50–150€/mes por usuario profesional**.

> El ticket B2B es 10–20x mayor que el individual. La retención es muy alta porque cambiar de herramienta de gestión tiene un coste operativo elevado. Con 20–30 asesores la app ya es rentable de forma sostenible.

Incluye todo lo anterior, más:

| Funcionalidad B2B | Notas |
|---|---|
| Gestión de múltiples clientes | Panel dedicado, vista consolidada |
| Informes personalizados exportables | PDF / Excel con marca del asesor |
| Acceso API para integración con otras herramientas | CRM, hojas de cálculo, etc. |
| Soporte prioritario (SLA 24h) | — |
| Interface desktop optimizada | Ver sección 15 |
| White label (marca blanca) | 🔜 v2 — suplemento mensual |

---

### Marketplace de contenido (ingresos transversales, todos los tiers)

| Canal de ingreso | Descripción |
|---|---|
| Canales YouTube destacados | Acuerdo directo con creadores: fee fijo mensual o por clics verificados con estadísticas |
| Badge "Patrocinado" | Mayor visibilidad, precio premium |
| Cursos y formación | Links a cursos del creador con comisión de afiliado |
| Brokers y herramientas destacadas | Integración preferente de brokers o robo-advisors con acuerdo comercial |

---

### Hoja de ruta de monetización

| Fase | Acción | Objetivo |
|---|---|---|
| Lanzamiento | Plan gratuito + pago único personal | Adquisición y validación |
| 3–6 meses | Activar suscripción anual por servicios (cotizaciones, nube) | Ingresos recurrentes iniciales |
| 3–6 meses | Primeros acuerdos marketplace (1–2 canales YouTube) | Ingresos complementarios |
| 6–12 meses | Lanzar plan B2B con primeros asesores beta (5–10) | Validar modelo profesional |
| 12+ meses | White label, API pública, expansión marketplace | Escala y diversificación |

---

### Por qué el B2B protege frente a la saturación del mercado individual

El mercado de inversores particulares hispanohablantes es finito. Cuando se satura, los ingresos por pago único caen. El B2B resuelve esto porque:

1. El mercado de asesores y gestores es más pequeño pero más estable
2. La churn (tasa de abandono) es mínima — nadie migra de herramienta de gestión fácilmente
3. El ticket mensual recurrente compensa la menor base de clientes
4. El white label abre un tercer mercado: empresas que quieren ofrecer la herramienta con su propia marca



---

## 13. White label — Personalización de marca

Aplicable al **Plan profesional B2B** y como producto independiente para empresas que quieran ofrecer la app con su propia identidad visual.

---

### Elementos personalizables

| Elemento | Descripción |
|---|---|
| Logo | Reemplaza el logo de portapp en la pantalla de login, topbar y splash screen |
| Nombre de la app | Nombre personalizado en toda la interfaz y en las tiendas (App Store / Google Play) |
| Colores principales | Color de acento, botones primarios, barra de navegación |
| Paleta completa | Colores de fondo, textos, badges, gráficos |
| Tipografía | Fuente corporativa del cliente |
| Imágenes y fondos | Pantalla de login, pantalla de bienvenida, ilustraciones |
| Favicon e iconos de app | Icono en iOS, Android y navegador |
| Dominio propio | La app web accesible desde el dominio del cliente (ej. `inversiones.miempresa.com`) |
| Email de soporte | Dirección de contacto y soporte con la marca del cliente |
| Canales YouTube | Lista de canales curados propia del cliente (independiente de la lista global) |
| Textos legales | Términos de uso y política de privacidad propios del cliente |

---

### Lo que NO cambia en white label

| Elemento | Motivo |
|---|---|
| Motor de la app (código base) | Es el mismo para todos — las actualizaciones llegan a todos los clientes |
| Seguridad y cifrado | No negociable, mismo estándar para todos |
| Aislamiento de datos | Cada cliente tiene sus datos completamente separados |

---

### Modelo de entrega white label

| Opción | Descripción | Precio orientativo |
|---|---|---|
| White label estándar | Colores + logo + nombre. Configurado desde el panel admin | Incluido en B2B Pro |
| White label completo | Tipografía + imágenes + dominio propio + canales propios | Suplemento mensual |
| App publicada con su marca | Publicación en App Store y Google Play con la cuenta del cliente | Fee único de setup |

---

### Pendientes técnicos (white label)

| # | Descripción |
|---|---|
| WL1 | Sistema de temas en el panel admin: editor visual de colores y upload de logo |
| WL2 | CSS variables globales ya preparadas en el prototipo — base técnica lista |
| WL3 | Configuración por tenant almacenada en BD y aplicada al cargar la app |
| WL4 | Pipeline de publicación automatizado para generar builds con marca personalizada |
| WL5 | Preview en tiempo real del tema antes de publicarlo |

---

## 14. Análisis de mercado y competencia

### Competencia directa

| App | Fortalezas | Debilidades |
|---|---|---|
| **Sharesight** | La más completa del mercado, TWR real, informes fiscales | Cara (€25–50/mes), solo en inglés, UI compleja |
| **Portfolio Performance** | Muy potente, gratuita | Solo escritorio, curva de aprendizaje alta, no móvil |
| **Seeking Alpha** | Análisis de mercado, seguimiento de precios | No es gestión de cartera real, orientada a EE.UU. |
| **Morningstar / Yahoo Finance** | Datos de mercado excelentes | Solo seguimiento de precios, sin gestión de operaciones |
| **Fintonic / Wallet** | Buena UX, mercado español | Finanzas generales, no especializadas en inversión |
| **Trade Republic / Revolut** | App del broker integrada | Solo gestiona activos de su propia plataforma |

### El hueco de mercado

El espacio no cubierto es específico: **inversor particular hispanohablante que opera en múltiples brokers y quiere una app móvil bien diseñada para gestionar toda su cartera en un solo lugar.**

- Las apps potentes (Sharesight, Portfolio Performance) son para usuarios avanzados o angloparlantes
- Las apps en español (Fintonic, etc.) no cubren inversión multi-broker
- Ninguna combina de forma sencilla: multi-cartera + efectivo + DCA + TWR + UI móvil cuidada

### Diferenciadores clave de portapp

| Diferenciador | Por qué importa |
|---|---|
| **Mercado hispanohablante** | Casi sin competencia directa en español con buena UX |
| **Móvil-first** | La mayoría de competidores son web o escritorio |
| **Multi-broker** | El inversor típico opera en 2–3 plataformas distintas |
| **Pago único (vs suscripción)** | Tendencia creciente — usuarios hartos de suscripciones |
| **UX accesible** | Cubre al inversor medio, no solo al avanzado |
| **White label B2B** | Abre un canal de ingresos 10–20x mayor que el individual |

### Riesgo principal

Que Revolut, Trade Republic o un banco grande lance una funcionalidad similar integrada en su app de broker. La protección frente a esto es la independencia multi-broker (portapp agrega datos de cualquier plataforma, algo que un broker nunca hará con sus competidores).

---

## 15. Estrategia de plataformas (móvil / web / desktop)

### Por qué desktop es necesario

Los segmentos de usuario usan dispositivos distintos:

| Segmento | Dispositivo principal | Uso típico |
|---|---|---|
| Inversor particular | Móvil | Consulta rápida, registrar operaciones, revisar rentabilidad |
| Asesor financiero / B2B | Desktop | Gestión de múltiples clientes, informes, análisis en profundidad |

**Desktop no es opcional si se quiere el mercado B2B.** Un asesor no va a gestionar 30 carteras de clientes desde el móvil. La interfaz desktop para B2B requiere funcionalidades específicas que no existen en la versión móvil (ver abajo).

---

### Estrategia recomendada: Web responsive + PWA (sin app nativa inicialmente)

| Opción | Pros | Contras | Recomendación |
|---|---|---|---|
| **Web responsive** | Una base de código, cubre móvil + tablet + desktop, sin tiendas | Sin acceso a APIs nativas (biometría, notificaciones push avanzadas) | ✅ Primera fase |
| **PWA** (Progressive Web App) | Instalable desde el navegador, funciona offline, notificaciones push, sin pasar por App Store | Limitaciones en iOS (Apple restringe PWAs), no aparece en tiendas | ✅ Añadir sobre la web responsive |
| **React Native** | App nativa real, acceso completo a APIs del dispositivo, presencia en tiendas | Base de código separada (aunque compartida), coste de mantenimiento mayor | 🔜 v2 si la tracción lo justifica |
| **Flutter** | Similar a React Native, excelente rendimiento | Menos ecosistema JS, curva de aprendizaje | ❌ No recomendado dado el stack actual |

**Conclusión:** empezar con **web responsive + PWA** cubre el 80% de los casos de uso con un solo codebase. La app nativa (React Native) solo tiene sentido cuando hay tracción demostrada y los usuarios piden funcionalidades que la web no puede ofrecer (biometría real, widgets en pantalla de inicio, etc.).

---

### Layout adaptativo según dispositivo

| Breakpoint | Layout | Navegación |
|---|---|---|
| < 480px (móvil) | Una columna, pantalla completa | Barra inferior (8 pestañas) |
| 480–768px (tablet vertical) | Una columna ampliada | Barra inferior o sidebar colapsado |
| 768–1024px (tablet horizontal) | Dos columnas | Sidebar fijo izquierdo |
| > 1024px (desktop) | Dos o tres columnas | Sidebar fijo izquierdo expandido |

El prototipo actual (CSS variables + flexbox) ya tiene la base técnica lista. El trabajo principal es añadir media queries y el componente de sidebar.

---

### Funcionalidades exclusivas de desktop (B2B)

Estas pantallas no tienen sentido en móvil y deben diseñarse específicamente para desktop:

| Funcionalidad | Descripción |
|---|---|
| Panel multi-cliente | Tabla resumen de todos los clientes del asesor con valor, rentabilidad y alertas |
| Vista comparativa | Comparar carteras de distintos clientes lado a lado |
| Generador de informes | Configurar y exportar informes en PDF con el logo del asesor |
| Dashboard de actividad | Resumen de operaciones recientes de todos los clientes |
| Gestión de permisos | Qué clientes puede ver cada usuario del equipo |

---

### Hoja de ruta de plataformas

| Fase | Acción |
|---|---|
| Ahora (prototipo) | HTML/CSS single-file — validar concepto y flujos |
| Producción v1 | React + Tailwind, web responsive móvil-first + PWA básica |
| v1.5 | Layout desktop completo + sidebar + vistas B2B |
| v2 | React Native si la tracción lo justifica (App Store + Google Play) |
| v2+ | White label con builds personalizados por cliente |

---

### Decisión pendiente más importante (M1)

Antes de empezar producción hay que decidir si el stack de producción será:

- **Next.js** (React, SSR, buena SEO, fácil despliegue en Vercel/Netlify) — recomendado
- **React SPA** (más simple, sin SSR, suficiente para una app autenticada)
- **Vue / Svelte** (alternativas válidas pero menor ecosistema para este tipo de app)

La recomendación es **Next.js** porque permite tener tanto la app autenticada (React SPA dentro) como la landing page pública (con SEO) en el mismo proyecto.

> **Nota:** Esta recomendación aplica si se adopta la arquitectura cliente-servidor clásica. Si se adopta local-first (ver sección 20), el stack cambia a React Native + Expo. La decisión está pendiente del Prototipo 2.

---

### Arquitectura de archivos: prototipo vs. producción

#### Por qué el monolito HTML es correcto para el prototipo

El prototipo vive en un único archivo `prototype/index.html` por diseño deliberado:

- Se comparte con un solo link (Netlify Drop — URL pública en 30 segundos)
- No requiere servidor, build ni dependencias
- Cualquiera lo abre directamente en el navegador
- Facilita iterar rápido sin configuración ni pipeline
- Perfecto para validar concepto, flujos y UX antes de invertir en infraestructura

#### Por qué el monolito NO escala a producción

A medida que crece la app, un único archivo HTML se convierte en un problema serio:

| Problema | Consecuencia en producción |
|---|---|
| Sin caché por recurso | El navegador no puede cachear CSS/JS por separado — descarga todo en cada visita aunque nada haya cambiado |
| Bundle enorme | Con más funcionalidades el archivo crece linealmente; el tiempo de carga inicial sube |
| Sin code splitting | Se carga todo el código aunque el usuario solo use el 20% de la app |
| Imposible trabajar en equipo | Múltiples desarrolladores editando el mismo archivo genera conflictos constantes en git |
| Sin tests unitarios | No se puede testear lógica de negocio separada del DOM |
| Sin tipado estático | Sin módulos ES no hay TypeScript real, lo que aumenta los bugs en bases de código grandes |
| Sin lazy loading | Imágenes, gráficos y pantallas secundarias se cargan aunque el usuario no las visite |

#### Cómo cambia la arquitectura en producción (Next.js)

El build de producción genera automáticamente lo que el monolito no puede ofrecer:

| Característica | Monolito HTML | Next.js producción |
|---|---|---|
| CSS | Un bloque inline | Archivos separados, minificados, con hash para caché perfecta |
| JavaScript | Un bloque al final del body | Dividido por ruta — solo se carga el código de la página activa |
| Imágenes | Sin optimización | Compresión automática, WebP, lazy loading, tamaños adaptativos |
| Caché | Ninguna | Cada recurso tiene hash único — caché máxima sin romper actualizaciones |
| Carga inicial | Todo de golpe | Solo el shell + la ruta activa (~10x más rápido) |
| Trabajo en equipo | Un archivo, conflictos constantes | Componentes independientes, cada desarrollador trabaja en su área |
| Tests | Imposibles sin refactorizar | Cada función/componente es testeable de forma aislada |

#### Rol del prototipo en producción

El archivo `prototype/index.html` **no se migra ni se adapta** para producción — se usa como:

- **Referencia de diseño**: todos los estilos, colores, componentes y animaciones ya están definidos
- **Referencia de flujos**: todos los flujos de usuario (auth, navegación, modales) están validados
- **Fuente de verdad visual**: el equipo de frontend lo usa como spec viva durante la construcción en React

Todo el CSS de `index.html` se traduce a componentes Tailwind/CSS Modules en React. Todo el JS se convierte en hooks, contextos y componentes React tipados con TypeScript.

---

## 16. Publicación en App Store y Google Play

### Decisión previa obligatoria: ¿PWA o app nativa?

Como se documenta en la sección 15, la recomendación es comenzar con **web responsive + PWA** y solo desarrollar app nativa (React Native) si la tracción lo justifica. Una PWA evita el proceso de revisión, las comisiones y el coste anual de las cuentas de desarrollador en la fase inicial.

Si en algún momento se decide publicar en tiendas:

| Cuenta de desarrollador | Coste | Notas |
|---|---|---|
| Apple Developer Program | 99$/año | Obligatorio para publicar en App Store (iOS + macOS) |
| Google Play Console | 25$ pago único | Obligatorio para publicar en Google Play |

---

### App Store (Apple) — el más restrictivo

Apple tiene el proceso de revisión más exigente. Cada actualización pasa por revisión humana (1–7 días). Un rechazo puede retrasar semanas una corrección crítica.

#### Regla crítica: pagos In-App Purchase

Si la app permite compras dentro de la app (el pago único de 29–49€ o la suscripción anual), Apple **obliga** a usar su sistema de pagos In-App Purchase y se queda:
- **30%** de cada transacción (regla general)
- **15%** si la facturación anual es inferior a 1M$ (Small Business Program)

Esto significa que si el producto cuesta 39€, el usuario paga 39€ pero portapp recibe ~27€.

**No se puede enlazar a una web de pago externa desde dentro de la app** (Apple lo detecta y rechaza la app o la expulsa de la tienda).

#### Solución estándar del sector (Spotify, Netflix, Notion, Linear)

- La app en las tiendas es **gratuita** — sin ningún pago dentro
- El pago se realiza **exclusivamente desde la web** (`portapp.com/pricing`)
- La app detecta si el usuario tiene cuenta activa y desbloquea las funciones premium
- Es perfectamente legal, Apple lo permite siempre que la app no mencione ni enlace al pago externo

**Esta debe ser la estrategia de portapp desde el primer día.** Diseñar el sistema de autenticación y licencias pensando en esto desde el inicio evita una refactorización costosa después.

#### Privacidad — App Privacy Label (obligatorio)

Apple obliga a declarar en la ficha de la App Store exactamente qué datos recoge la app, con qué finalidad y si se vinculan a la identidad del usuario. Es el "nutrition label" de privacidad.

Datos que portapp recogerá y que hay que declarar:

| Dato | Categoría Apple | Vinculado a identidad |
|---|---|---|
| Email | Datos de contacto | Sí |
| Nombre | Datos de contacto | Sí |
| Datos financieros (carteras, operaciones) | Información financiera | Sí |
| Historial de uso de la app | Datos de uso | Sí |

Mentir o ser impreciso en esta declaración es causa de rechazo y puede derivar en expulsión de la tienda.

#### Contenido financiero

Apple puede solicitar aclaración de que la app **no da asesoramiento de inversión** — exactamente la línea CNMV documentada en la sección 17. Conviene incluir un disclaimer visible en la app y en la descripción de la tienda: *"portapp es una herramienta de registro y seguimiento de inversiones personales. No constituye asesoramiento financiero."*

---

### Google Play — más flexible pero con sus reglas

- Proceso de revisión más rápido (horas en lugar de días)
- Misma política de comisiones (15–30%) con las mismas alternativas
- Desde 2023 exige **política de privacidad** accesible desde la ficha — ya en la hoja de ruta legal
- Para apps de categoría Finanzas puede solicitar verificación adicional según funcionalidad
- Permite actualizaciones más frecuentes sin el riesgo de bloqueo prolongado de Apple

---

### Lo que hay que diseñar desde ya (coste alto si se arregla después)

Estos elementos son baratos de hacer bien desde el principio y muy caros de corregir cuando la app ya está en producción:

| Elemento | Qué hacer | Estado actual |
|---|---|---|
| **Safe areas** | Respetar notch, Dynamic Island (iPhone) y barra de navegación (Android) con `env(safe-area-inset-*)` | Pendiente (M2, M3) |
| **Touch targets** | Todos los elementos interactivos mínimo 44×44px (Apple HIG) / 48×48dp (Material Design) | Pendiente (M7) |
| **Fuentes relativas** | Usar `rem` en lugar de `px` para respetar la configuración de accesibilidad del sistema operativo | Pendiente (M6) |
| **Modo oscuro del sistema** | La app ya respeta `prefers-color-scheme` | ✅ Hecho |
| **Sin dependencias de hover** | En móvil no existe hover — ninguna funcionalidad crítica puede depender solo de él | Revisar en producción |
| **Teclado virtual** | El teclado empuja el contenido — los formularios deben permanecer accesibles cuando el teclado está visible | Pendiente |
| **Sin `position: fixed` problemático** | En iOS Safari, `position: fixed` dentro de un scroll container da comportamiento inesperado conocido | Revisar en producción |
| **Iconos y splash screen** | Necesitas iconos en múltiples resoluciones: 1024×1024 para App Store, múltiples densidades para Android (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi) | Pendiente de diseño |
| **Descripción de tienda** | Texto de la ficha en App Store / Google Play, capturas de pantalla (mínimo 3, máximo 10), vídeo preview opcional | Pendiente de redacción |

---

### Impacto en el modelo de negocio — resumen ejecutivo

| Escenario | Comisión | Recomendación |
|---|---|---|
| Cobro dentro de la app (In-App Purchase) | 15–30% a Apple/Google | ❌ Evitar |
| Cobro solo desde la web, app gratuita en tiendas | 0% | ✅ Estrategia recomendada |
| Suscripción gestionada externamente (Stripe, etc.) | Solo comisión de pasarela (~1,5%) | ✅ Óptimo |

**Acción concreta:** desde el primer día de producción, el sistema de licencias debe estar desacoplado de las tiendas. El usuario se registra y paga en `portapp.com`, la app solo verifica si la cuenta tiene licencia activa consultando el backend.

---

## 17. Estrategia de contenidos y blog

### Por qué el blog es obligatorio

El blog es la principal fuente de tráfico orgánico sin coste de adquisición. Un usuario que llega buscando "cómo calcular la rentabilidad TWR de mi cartera" y encuentra un artículo bien escrito en portapp.com tiene una probabilidad de conversión muy alta — ya tiene el problema que portapp resuelve.

Sin blog, la única forma de crecer es pagando publicidad. Con blog, Google trabaja para ti de forma compuesta: cada artículo nuevo suma, y los artículos antiguos siguen trayendo tráfico años después.

---

### Blog público vs. contenido premium — decisión

**El blog debe ser 100% público y gratuito.** No tiene sentido diferenciar:

- El objetivo del blog es **atraer** usuarios, no monetizarlos. Un muro de pago elimina su función principal.
- El SEO solo funciona con contenido indexable. El contenido de pago no se indexa en Google.
- Ya existen mecanismos de monetización más naturales (pago único, suscripción, B2B). El blog no debe ser uno más.

Lo que sí tiene sentido diferenciar es el **formato**, no el acceso:

| Tipo de contenido | Canal | Objetivo |
|---|---|---|
| Artículos educativos (ETFs, DCA, TWR, fiscalidad) | Blog público | Tráfico orgánico SEO |
| Tutoriales de uso de portapp | Blog público | Reducir soporte, onboarding |
| Análisis de mercado periódicos | Blog público | Fidelización y recurrencia |
| Guías avanzadas descargables (PDF) | Lead magnet — gratis a cambio de email | Captura de leads |
| Webinars / sesiones en vivo | Solo usuarios registrados (gratuito o de pago) | Comunidad y conversión |
| Vídeos con expertos invitados | App (sección Aprende) + blog + YouTube | Autoridad y alcance |

---

### Estrategia de vídeos con personas relevantes

Una de las acciones de mayor impacto a medio plazo es **invitar a personas relevantes del mundo de las finanzas e inversión** para grabar vídeos con consejos útiles para los usuarios de portapp.

**Por qué funciona:**
- El invitado trae su propia audiencia — cada vídeo es también una acción de marketing hacia sus seguidores
- Genera contenido de autoridad sin que portapp tenga que ser el experto
- Crea relaciones con los creadores que luego pueden derivar en acuerdos para la sección "Aprende" (canales YouTube curados)
- El contenido de vídeo tiene mucha más retención y viralidad que el texto

**Perfiles a invitar:**

| Perfil | Por qué es relevante |
|---|---|
| Creadores de YouTube de finanzas en español | Audiencia masiva ya formada, alineación natural con la app |
| Asesores financieros independientes (EAFIs) | Credibilidad institucional, puerta de entrada al B2B |
| Bloggers e influencers de inversión en redes | Alcance en Instagram, Twitter/X, TikTok |
| Gestores de fondos o analistas conocidos | Autoridad máxima, contenido de alto valor percibido |
| Usuarios power-user de portapp (cuando los haya) | Testimonios reales, máxima credibilidad para conversión |

**Formato sugerido para los vídeos:**
- Duración: 5–10 minutos (consumible, no un webinar largo)
- Enfoque práctico: "3 errores que cometen los inversores al calcular su rentabilidad", "Cómo estructurar una cartera DCA desde cero"
- Grabados remotamente (Riverside, Zencastr) o presencialmente si hay presupuesto
- Publicados en la sección "Aprende" de la app + canal YouTube propio de portapp + blog

**Primeros pasos concretos:**
1. Identificar 5–10 creadores hispanohablantes con audiencia afín (inversión indexada, finanzas personales)
2. Preparar un pitch corto explicando qué es portapp y qué se les ofrece (visibilidad, link en la app, posible acuerdo económico futuro)
3. Empezar por perfiles medianos (50k–200k seguidores) — más accesibles y con audiencia más comprometida que los megainfluencers
4. Establecer si el acuerdo es gratuito (visibilidad mutua) o remunerado desde el inicio

---

### Integración blog ↔ app

El blog no debe ser un elemento separado — debe estar conectado con la app:

- La sección **"Aprende"** de la app puede mostrar los últimos artículos del blog y los vídeos más recientes
- Los artículos sobre funcionalidades de portapp pueden incluir CTAs directos a la app
- El mismo dominio (`portapp.com/blog`) es clave — un subdominio externo (`blog.portapp.com`) no transfiere autoridad SEO al dominio principal

---

### Stack técnico recomendado para el blog

| Opción | Pros | Contras | Recomendación |
|---|---|---|---|
| **Blog en Next.js** (mismo proyecto) | Mismo dominio, mismo diseño, máximo SEO | Requiere desarrollo | ✅ Ideal a largo plazo |
| **Ghost** (headless) | CMS potente, buen SEO, fácil de escribir | Subdominio o configuración extra para mismo dominio | ✅ Buena opción inicial |
| **Substack** | Gratis, fácil, newsletter integrada | Dominio propio limitado, diseño muy rígido | 🟡 Solo para empezar muy rápido |
| **WordPress** | Flexible, miles de plugins | Pesado, mantenimiento, seguridad | ❌ No recomendado para este stack |

**Recomendación:** empezar con **Ghost** en `portapp.com/blog` para publicar rápido, y migrar a Next.js cuando el equipo técnico tenga capacidad.

---

### Hoja de ruta de contenidos

| Fase | Acción |
|---|---|
| Pre-lanzamiento | Publicar 5–10 artículos SEO antes de lanzar (da autoridad desde el día 1) |
| Lanzamiento | Blog activo + primer vídeo con invitado relevante como acción de PR |
| 1–3 meses | Ritmo de 2–4 artículos/mes + 1 vídeo/mes con invitado |
| 3–6 meses | Activar newsletter semanal con resumen de mercado |
| 6–12 meses | Canal YouTube propio de portapp con contenido regular |
| 12+ meses | Comunidad (Discord o similar) para usuarios avanzados |

---

## 17. Certificaciones y cumplimiento legal

### Obligatorio antes de lanzar con usuarios reales

| Requisito | Descripción | Coste orientativo |
|---|---|---|
| **RGPD / GDPR** | Reglamento europeo de protección de datos. No es una certificación sino una obligación legal. Requiere: política de privacidad, consentimiento explícito, derecho al olvido, registro de actividades de tratamiento de datos, DPO si procesa datos a gran escala. Multa por incumplimiento: hasta el 4% de la facturación anual o 20M€. | Asesoría legal: 1.000–3.000€ |
| **Términos y condiciones** | Documento legal que regula la relación con el usuario. Debe cubrir: limitación de responsabilidad, uso aceptable, propiedad intelectual, resolución de disputas. Redactado por abogado especializado en software. | 500–1.500€ |
| **Política de privacidad** | Documento separado de los T&C, obligatorio por RGPD. Debe especificar qué datos se recogen, con qué finalidad, durante cuánto tiempo y con quién se comparten. | Incluido en el punto anterior |
| **Aviso de cookies** | Si se usan cookies de analítica o publicidad, es obligatorio el banner de consentimiento y la opción de rechazarlas. | Soluciones gratuitas disponibles (Cookiebot, etc.) |

---

### Muy recomendable para credibilidad B2B

| Certificación | Descripción | Cuándo obtenerla |
|---|---|---|
| **ISO 27001** | Estándar internacional de seguridad de la información. Es lo que los clientes B2B (asesores financieros, family offices, empresas) van a exigir antes de confiar datos de sus clientes. Cubre: gestión de riesgos, control de accesos, cifrado, continuidad de negocio. | Con los primeros clientes B2B serios |
| **ENS (Esquema Nacional de Seguridad)** | Equivalente español a ISO 27001 para organismos públicos. Relevante si se vende a Administración Pública. | Solo si se apunta al sector público |
| **SOC 2 Type II** | Estándar anglosajón equivalente a ISO 27001. Más orientado a mercado USA/UK. | Si se expande internacionalmente |

> **Coste de ISO 27001:** el proceso completo (consultoría + auditoría + certificación) cuesta entre 15.000€ y 30.000€ dependiendo del tamaño de la empresa. Existe un camino intermedio: contratar una **auditoría de seguridad externa** (pentest + informe) por 3.000–8.000€, que da credibilidad sin el coste de la certificación formal.

---

### Línea regulatoria a no cruzar (CNMV)

Si portapp en algún momento **ejecuta operaciones, da recomendaciones de inversión personalizadas o gestiona dinero de clientes**, necesita registro como proveedor de servicios de inversión ante la CNMV.

**Registrar operaciones manualmente introducidas por el propio usuario NO requiere licencia CNMV.** Hay que mantener esta distinción clara en el producto y en la comunicación.

| Acción | ¿Requiere CNMV? |
|---|---|
| El usuario registra sus propias operaciones | ❌ No |
| Mostrar cotizaciones de mercado | ❌ No |
| Mostrar rentabilidad histórica del usuario | ❌ No |
| Recomendar qué comprar o vender | ✅ Sí |
| Ejecutar órdenes en el broker | ✅ Sí |
| Gestionar dinero de clientes | ✅ Sí |

---

### Hoja de ruta legal

| Fase | Acción |
|---|---|
| Antes del lanzamiento | RGPD + T&C + Política de privacidad (abogado) + Aviso cookies |
| Primeros clientes B2B | Auditoría de seguridad externa (pentest) + NDA con clientes |
| Crecimiento B2B | ISO 27001 o equivalente |
| Expansión internacional | SOC 2 Type II |
| Si se añaden recomendaciones automáticas | Consultar CNMV antes de implementar |

---

## 17. Protección del código y la propiedad intelectual

### Protección legal

| Medida | Descripción | Coste / Esfuerzo |
|---|---|---|
| **Copyright automático** | Todo código creado está protegido por copyright desde su escritura sin necesidad de registro. Añadir `© 2025 portapp. Todos los derechos reservados.` en el código fuente y en la app. | Gratuito |
| **Registro de obra intelectual** | Registro en el Registro de la Propiedad Intelectual de España. Da fecha fehaciente probatoria: si alguien copia el código, puedes demostrar ante un juez que eras el autor original. | ~15€ por obra |
| **NDA con colaboradores** | Cualquier persona que acceda al código (desarrolladores, diseñadores, inversores técnicos) debe firmar un acuerdo de confidencialidad + cesión de derechos de autor. Sin esto, un colaborador podría reclamar coautoría. | Plantilla legal: 200–500€ |
| **Repositorio privado** | El código fuente nunca debe ser público. ✅ Ya aplicado — repositorio GitHub en privado. | Hecho |

---

### Protección técnica (producción)

| Medida | Descripción |
|---|---|
| **Minificación y ofuscación** | El bundle JS compilado con webpack/Vite + terser es prácticamente ilegible. No impide la copia pero eleva enormemente el coste de ingeniería inversa. |
| **Lógica crítica en el backend** | Los algoritmos de negocio más valiosos (cálculo TWR real, motor de informes B2B, reglas de precios) deben vivir en el servidor y nunca llegar al cliente. Lo que no se descarga no se puede copiar. |
| **Ofuscación adicional** | Herramientas como JavaScript Obfuscator añaden una capa extra sobre la minificación estándar. |
| **Rate limiting en API** | Impide que alguien automatice la extracción masiva de datos o funcionalidades desde el cliente. |

---

### Lo que realmente protege el negocio

La realidad es que **el código en sí tiene poco valor estratégico** — lo verdaderamente difícil de copiar es:

| Activo intangible | Por qué es difícil de copiar |
|---|---|
| **Base de usuarios fidelizada** | El usuario ya tiene su historial de operaciones en portapp. Migrar a otra app implica reintroducir todo desde cero. |
| **Datos históricos del usuario** | Con el tiempo, el usuario acumula años de operaciones, anotaciones y rentabilidades. Ese historial es suyo pero vive en portapp. |
| **Reputación y marca** | Construida con tiempo y ejecución consistente. No se puede copiar de un día para otro. |
| **Red de asesores B2B** | Un asesor que lleva 2 años con portapp y tiene 50 clientes configurados no va a migrar fácilmente. |
| **Velocidad de ejecución** | Llegar primero al mercado hispanohablante y ejecutar bien es la ventaja más difícil de replicar. |

> Dropbox, Notion, Linear y cientos de apps exitosas tienen competidores con código casi idéntico. La ventaja competitiva real nunca es el código — es la ejecución, la comunidad y los datos acumulados.

---

## 18. Equipo, roles y modelo de trabajo

### Perfil del fundador

| Área | Nivel |
|---|---|
| SQL, BigQuery, dbt | Experto (30+ años) |
| Looker y herramientas de BI/analytics | Experto |
| Dirección de proyectos | Experto |
| Arquitectura de datos y modelado | Experto |
| Programación general | Experto |
| Frontend React/Next.js | Curva de aprendizaje |
| DevOps / CI/CD / cloud | Curva de aprendizaje |
| Seguridad web (JWT, OAuth, XSS) | Conoce conceptos, implementación a aprender |

---

### Rol de Claude Code en el proyecto

Claude Code actúa como co-desarrollador técnico full-stack. La división de trabajo es:

| Tarea | Quién |
|---|---|
| Decisiones de producto y negocio | Fundador |
| Arquitectura de datos y esquema BD | Fundador (con revisión de Claude) |
| Revisión y aprobación de código via PR | Fundador |
| Testing con usuarios reales | Fundador |
| Componentes React/Next.js | Claude Code |
| Backend API routes | Claude Code |
| Integraciones con terceros (Stripe, Resend, Anthropic) | Claude Code |
| CI/CD y configuración DevOps | Claude Code |
| Implementación de seguridad (JWT, rate limiting, sanitización) | Claude Code |
| Documentación técnica | Claude Code |

**El modelo de trabajo es el mismo que se ha usado para el prototipo:** el fundador dirige y aprueba, Claude implementa y explica. Cada cambio pasa por PR en GitHub antes de llegar a `main`.

---

### ¿Se necesita contratar a alguien para la v1?

**No.** Con esta división de trabajo la v1 puede construirse sin contratar a nadie externo.

Lo que Claude Code puede hacer por el fundador en las áreas de curva de aprendizaje:

**Frontend React/Next.js**
Generación completa de componentes, hooks, layouts y páginas. El fundador revisa, aprueba y aprende en el proceso sin necesidad de dominar React de antemano.

**DevOps / CI/CD**
Escritura de workflows de GitHub Actions, configuración de Vercel, gestión de variables de entorno y scripts de migración de BD. El fundador ejecuta los comandos, Claude proporciona exactamente qué ejecutar y por qué.

**Seguridad web**
Implementación correcta de JWT, refresh tokens, rate limiting, sanitización de inputs y cabeceras de seguridad HTTP. Código generado y explicado, no algo que el fundador tenga que memorizar.

**Integraciones con terceros**
Stripe/Paddle (pagos), Resend (email), Anthropic SDK (IA), Supabase SDK (BD y auth), Alpha Vantage (cotizaciones). Claude escribe las integraciones completas.

**Lo que Claude Code NO puede hacer:**
- Ejecutar comandos directamente en la máquina — el fundador los ejecuta
- Tomar decisiones de negocio — esas son del fundador
- Probar visualmente la UI en un navegador real
- Garantizar que algo funciona sin pruebas reales con usuarios

---

### Cuándo sí tendría sentido contratar

| Situación | Perfil a contratar |
|---|---|
| La app tiene tracción y hay que acelerar el desarrollo | Frontend developer senior React/Next.js (freelance, 3–6 meses) |
| Se lanza el plan B2B y hay clientes enterprise | Backend developer para APIs avanzadas y SLAs |
| El blog y el contenido requieren dedicación continua | Content manager / redactor de finanzas |
| Se necesita presencia en redes sociales activa | Community manager |

**Ninguno de estos perfiles es necesario para llegar al lanzamiento v1.**

---

## 19. Infraestructura de producción

### Visión general

portapp en producción es una aplicación web full-stack con las siguientes capas:

```
Usuario (móvil/web)
        ↓ HTTPS
CDN + Frontend (Next.js) ── Vercel
        ↓ API calls
Backend / API (Next.js API routes o Node.js)
        ↓
Base de datos (PostgreSQL) ── Supabase / Railway
        ↓
Servicios externos:
  - Auth (email + 2FA)
  - Pagos (Stripe)
  - Email transaccional (Resend)
  - Cotizaciones (API de mercado)
  - Almacenamiento ficheros (Cloudflare R2)
  - IA (Anthropic API)
```

---

### Componente 1 — Frontend y hosting web

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Vercel** ⭐ | Deploy automático desde GitHub, edge network global, ideal para Next.js (mismo equipo), SSL automático, previews por PR | Vendor lock-in con Next.js | Gratis hasta 100GB bandwidth/mes; Pro 20$/mes para equipos |
| **Netlify** | Similar a Vercel, agnóstico de framework | Menos optimizado para Next.js | Gratis con límites; Pro 19$/mes |
| **Cloudflare Pages** | Muy rápido, red global, gratis generoso | Menos maduro para SSR | Gratis; Workers 5$/mes |

**Recomendación: Vercel** — deploy automático desde `main`, previews de cada PR en `dev`, SSL automático, optimizado para Next.js. El plan gratuito cubre el lanzamiento inicial.

---

### Componente 2 — Base de datos

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Supabase** ⭐ | PostgreSQL gestionado, auth incluida, SDK JS nativo, dashboard visual, backups automáticos, realtime | Vendor lock-in en auth y realtime | Gratis hasta 500MB; Pro 25$/mes (8GB) |
| **Railway** | Fácil de usar, PostgreSQL estándar, buen DX | Sin auth incluida | ~5–15$/mes según uso |
| **PlanetScale** | MySQL serverless, muy escalable | No es PostgreSQL | Gratis con límites; Pro 39$/mes |
| **AWS RDS** | Máximo control y escalabilidad | Complejidad operativa alta, caro | ~50–200$/mes |
| **Neon** | PostgreSQL serverless, branching de BD | Más nuevo, menos maduro | Gratis; Pro 19$/mes |

**Recomendación: Supabase** — PostgreSQL estándar, auth de calidad incluida, backups automáticos, SDK oficial para JS/TS, excelente dashboard para gestionar datos. El plan gratuito cubre la fase de validación. Migrar es fácil si crece la necesidad porque es PostgreSQL estándar.

**Esquema de base de datos (tablas principales):**
```sql
users          -- id, email, nombre, plan, created_at
carteras       -- id, user_id, nombre, desc, divisa, color
activos        -- id, cartera_id, ticker, nombre, tipo, broker, grupo...
operaciones    -- id, cartera_id, ticker, fecha, tipo, qty, precio, fee...
efectivo       -- id, cartera_id, tipo, fecha, importe, broker...
anotaciones    -- id, user_id, texto, tag, ctx, fecha
grupos         -- id, user_id, nombre, color, orden
cuentas        -- id, user_id, tipo, nombre, iban, bic...
licencias      -- id, user_id, plan, estado, fecha_inicio, fecha_fin
```

---

### Componente 3 — Autenticación y sesiones

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Supabase Auth** ⭐ | Incluida con Supabase, email+password, OTP email, OAuth (Google, Apple), JWT automático | Limitado si se necesita lógica muy custom | Incluida en Supabase |
| **NextAuth.js** | Open source, flexible, integra con cualquier BD, muchos providers | Más configuración inicial | Gratis (open source) |
| **Clerk** | UI de auth preconstruida y muy pulida, gestión de sesiones avanzada | Caro a escala | Gratis hasta 10k MAU; Pro 25$/mes |
| **Auth0** | Muy completo, enterprise-ready | Complejo, caro a escala | Gratis hasta 7.5k MAU; ~23$/mes |

**Recomendación: Supabase Auth** — si ya usamos Supabase para la BD, usar su auth es lo más coherente. Cubre email+password, OTP por email (ya prototipado), OAuth social y JWT. El 2FA por SMS (PR7) se añade con Twilio sobre esta base.

---

### Componente 4 — Pagos

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Stripe** ⭐ | Estándar del sector, pago único + suscripciones + licencias, SDK excelente, cumplimiento PCI automático, dashboard potente | Comisión 1,4%+0,25€ (tarjetas europeas) | 0$ fijo + comisión por transacción |
| **Paddle** | Gestiona el IVA europeo automáticamente (Merchant of Record), ideal para productos digitales | Comisión algo mayor (~5%) | 0$ fijo + comisión |
| **LemonSqueezy** | Similar a Paddle, más moderno | Menos maduro | 0$ fijo + 5% + 0,50$ |

**Recomendación: Paddle** para el lanzamiento europeo — actúa como "Merchant of Record", lo que significa que Paddle gestiona el IVA de cada país de la UE automáticamente. Con Stripe tendrías que registrarte en el OSS (One Stop Shop) de la AEAT para declarar el IVA digital. Para un producto SaaS B2C en Europa, Paddle elimina una complejidad fiscal importante.

**Flujo de pago (sin comisión de tiendas):**
1. Usuario se registra gratis en portapp.com
2. Decide comprar → se redirige a Paddle checkout
3. Paddle procesa el pago y notifica al backend via webhook
4. Backend actualiza `licencias` tabla → usuario desbloqueado
5. App detecta licencia activa → funcionalidades premium disponibles

---

### Componente 5 — Email transaccional

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Resend** ⭐ | API moderna, SDK TS oficial, plantillas React Email, fácil de usar | Más nuevo | Gratis 3.000 emails/mes; Pro 20$/mes |
| **SendGrid** | Muy establecido, muchas funciones | API más verbosa, UI anticuada | Gratis 100/día; Pro 19,95$/mes |
| **Postmark** | Excelente entregabilidad, especializado en transaccional | Solo transaccional, sin marketing | 15$/mes (10k emails) |

**Recomendación: Resend** — API limpia, SDK TypeScript oficial, integración con React Email para crear plantillas HTML con componentes React. El plan gratuito cubre el lanzamiento.

**Emails que necesita portapp:**
- Verificación de cuenta
- OTP para 2FA
- Recuperación de contraseña
- Confirmación de pago
- Bienvenida al comprar plan personal
- Alertas de inversión (cuando se implementen)
- Newsletter/blog (esto con una herramienta separada: Loops, Mailchimp)

---

### Componente 6 — Cotizaciones de mercado (PR1)

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Yahoo Finance (yfinance)** | Gratis, amplia cobertura global | No oficial, puede romperse, sin SLA | Gratis (no oficial) |
| **Alpha Vantage** ⭐ | API oficial, acciones + cripto + forex, bien documentada | Límite 25 req/día en gratis | Gratis (25 req/día); Premium 50$/mes (sin límite) |
| **Polygon.io** | Datos de alta calidad, tiempo real, websocket | Caro para tiempo real | Gratis (datos retrasados); Starter 29$/mes |
| **Twelve Data** | Buena cobertura global, precios razonables | Menos conocido | Gratis 800 req/día; Pro 29$/mes |
| **ProRealTime API** | Ya en la app como plataforma, datos profesionales | Solo para clientes PRT | Acuerdo comercial |

**Recomendación para lanzamiento: Alpha Vantage** (plan gratuito para empezar, Premium cuando haya usuarios de pago). Implementar caché agresiva en el backend — las cotizaciones no necesitan actualizarse más de 1 vez cada 15 minutos para la mayoría de usuarios.

**Estrategia de caché:**
```
Request de usuario → caché Redis (15 min TTL) → API externa solo si caché expirada
```
Esto multiplica por 100 la eficiencia y reduce el coste de la API de cotizaciones.

---

### Componente 7 — Almacenamiento de ficheros

Para el upload de PDFs de broker (F8) y potencialmente avatares de usuario y exportaciones.

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Cloudflare R2** ⭐ | Sin coste de egress (diferencial enorme vs S3), S3-compatible, muy barato | Más nuevo | 0,015$/GB almacenamiento; 0$ egress |
| **AWS S3** | Estándar del sector, muy maduro | Coste de egress elevado (0,09$/GB) | 0,023$/GB + egress |
| **Supabase Storage** | Integrado con Supabase, fácil de usar | Límites en plan gratuito | Incluido en Supabase (1GB gratis) |

**Recomendación: Cloudflare R2** para ficheros grandes (PDFs, exportaciones). Supabase Storage para ficheros pequeños (avatares) aprovechando la integración.

---

### Componente 8 — Caché y rendimiento

| Opción | Pros | Contras | Coste |
|---|---|---|---|
| **Upstash Redis** ⭐ | Redis serverless, pago por uso, SDK JS oficial, integra bien con Vercel | Latencia algo mayor que Redis dedicado | Gratis 10k req/día; Pay-as-you-go después |
| **Redis Cloud** | Redis estándar, muy rápido | Requiere gestión | Gratis 30MB; Flex ~7$/mes |
| **Vercel KV** | Integrado con Vercel, Redis bajo el capó | Solo funciona bien con Vercel | Gratis con límites; Pro incluido |

**Recomendación: Upstash Redis** — serverless, pago por uso real, sin gestionar instancias. Usar para: caché de cotizaciones, rate limiting de API, sesiones temporales.

---

### Componente 9 — Monitorización y errores

| Herramienta | Función | Coste |
|---|---|---|
| **Sentry** ⭐ | Captura de errores JS/backend en tiempo real, stack traces, alertas | Gratis hasta 5k errores/mes |
| **Posthog** ⭐ | Analítica de producto (eventos, funnels, session replay), open source | Gratis hasta 1M eventos/mes |
| **Vercel Analytics** | Métricas de rendimiento web (Core Web Vitals) | Incluido en Vercel |
| **Uptime Robot** | Monitorización de disponibilidad, alertas si cae | Gratis (50 monitores) |

**Recomendación:** Sentry + Posthog + Uptime Robot desde el día 1. Son gratuitos en los volúmenes iniciales y esenciales para entender qué falla y cómo se usa la app.

---

### Componente 10 — CI/CD

**GitHub Actions** (ya tenemos el repo en GitHub) — gratis para repos privados hasta 2.000 minutos/mes.

Pipeline recomendado:
```yaml
Push a dev:
  → Tests automáticos
  → Build de verificación
  → Preview deploy en Vercel

PR dev → main:
  → Tests automáticos
  → Revisión manual (tú)
  → Merge → deploy automático a producción
```

---

### Componente 11 — Dominio y DNS

- **Registro de dominio:** Cloudflare Registrar (precio de coste, sin margen) o Namecheap (~10–15€/año para .com)
- **DNS:** Cloudflare (gratis, rapidísimo, protección DDoS incluida)
- **SSL:** automático via Vercel o Cloudflare

**Dominios a registrar:**
- `portapp.com` — dominio principal ⭐
- `portapp.es` — para el mercado español
- `portapp.app` — extensión de app (opcional)

---

### Componente 12 — IA (Anthropic API)

Para el bot de asistencia (PR9) e importación de PDFs (F8).

| Modelo | Uso | Coste orientativo |
|---|---|---|
| `claude-sonnet-4-6` | Bot de asistencia (respuestas de calidad) | ~0,003$/pregunta con caching |
| `claude-haiku-4-5` | Extracción de datos de PDFs (tarea estructurada) | ~0,0005$/PDF |

**Implementación con prompt caching:**
- El system prompt y las definiciones de herramientas se cachean → reducción de coste ~90% en conversaciones largas
- Coste estimado para 1.000 preguntas/mes por usuario activo: ~3$/mes

---

### Resumen de costes mensuales estimados

#### Fase de lanzamiento (0–500 usuarios)

| Servicio | Plan | Coste/mes |
|---|---|---|
| Vercel | Hobby (gratis) | 0$ |
| Supabase | Free tier | 0$ |
| Resend | Free (3k emails) | 0$ |
| Alpha Vantage | Free (25 req/día) | 0$ |
| Upstash Redis | Free tier | 0$ |
| Sentry | Free tier | 0$ |
| Posthog | Free tier | 0$ |
| Dominio .com | Anual | ~1$/mes |
| Anthropic API | Pay-as-you-go | ~5–20$/mes |
| **Total** | | **~6–21$/mes** |

#### Fase de crecimiento (500–5.000 usuarios)

| Servicio | Plan | Coste/mes |
|---|---|---|
| Vercel | Pro | 20$ |
| Supabase | Pro (8GB) | 25$ |
| Resend | Pro | 20$ |
| Alpha Vantage | Premium | 50$ |
| Upstash Redis | Pay-as-you-go | ~10$ |
| Cloudflare R2 | Pay-as-you-go | ~5$ |
| Sentry | Team | 26$ |
| Dominio(s) | Anual | ~3$/mes |
| Anthropic API | Pay-as-you-go | ~50–100$/mes |
| **Total** | | **~209–259$/mes** |

> Con 500 usuarios en plan personal (39€ pago único) = 19.500€ de ingresos. Los costes de infraestructura son marginales frente a los ingresos.

---

### Hoja de ruta de infraestructura

| Fase | Acción |
|---|---|
| **Antes de producción** | Registrar dominio · Configurar Supabase (BD + auth) · Configurar Vercel · Configurar Resend · Configurar Stripe/Paddle · Configurar Sentry + Posthog |
| **Lanzamiento v1** | Todo en plan gratuito · GitHub Actions básico · Cotizaciones con caché |
| **Post-lanzamiento** | Upgrade Supabase Pro · Alpha Vantage Premium · Cloudflare R2 para PDFs |
| **Crecimiento** | Redis dedicado · CDN para assets estáticos · Separar backend de frontend si escala |

---

## 19. Estrategia de agentes IA en portapp

### Cuándo tiene sentido usar agentes y cuándo no

No toda la IA es un agente. En portapp hay que distinguir tres niveles:

| Nivel | Descripción | Ejemplo en portapp |
|---|---|---|
| **Código determinista** | Lógica fija, resultado predecible | Cálculo TWR, proyección DCA, exposición por divisa |
| **IA generativa puntual** | Una llamada a un LLM para generar texto o extraer datos | Importación de PDF de broker |
| **Agente** | LLM con acceso a herramientas, capaz de razonar en múltiples pasos y tomar decisiones | Bot de asistencia con acceso a los datos del usuario |

**Regla general:** usar código determinista siempre que sea posible para cálculos financieros — es más fiable, auditable y predecible. Los agentes aportan valor donde la lógica es difusa, el input es lenguaje natural o el problema requiere razonamiento multi-paso.

---

### Caso 1 — Bot de asistencia al usuario (PR9) ⭐ Prioritario

**Qué hace:** el usuario hace preguntas en lenguaje natural sobre sus propios datos de inversión y recibe respuestas calculadas y personalizadas.

**Ejemplos de preguntas reales:**
- *"¿Cuándo fue mi mejor mes de rentabilidad?"*
- *"¿Qué activo me ha dado más rentabilidad este año?"*
- *"¿Cuánto necesito aportar mensualmente para llegar a 100.000€ en 10 años con un 7% anual?"*
- *"¿Cuál es mi exposición total a renta variable americana?"*
- *"¿He batido al S&P 500 este año?"*
- *"Resume mi actividad inversora de los últimos 6 meses"*

**Por qué tiene valor:**
- El usuario no tiene que navegar por la app — pregunta y obtiene la respuesta directamente
- Las preguntas financieras personales son difíciles de responder con filtros fijos
- Diferenciador claro frente a competidores que no tienen esto
- Alta percepción de valor — el usuario siente que la app "le entiende"

**Arquitectura técnica:**

```
Usuario escribe pregunta
        ↓
Claude API (claude-sonnet-4-6)
        ↓ tool_use
Herramientas con acceso a datos del usuario:
  - get_carteras() → lista de carteras y valores
  - get_activos(cartera_id) → posiciones actuales
  - get_ops(cartera_id, desde, hasta) → historial de operaciones
  - get_rentabilidad(cartera_id, periodo) → TWR calculado
  - get_efectivo(cartera_id) → movimientos de efectivo
  - calc_proyeccion(aportacion, años, tasa) → proyección DCA
        ↓
Claude sintetiza la respuesta en lenguaje natural
        ↓
Respuesta mostrada al usuario en la app
```

**Implementación con Anthropic SDK:**
```python
# Ejemplo simplificado con Python SDK
import anthropic

client = anthropic.Anthropic()

tools = [
    {
        "name": "get_rentabilidad",
        "description": "Obtiene la rentabilidad de una cartera en un período",
        "input_schema": {
            "type": "object",
            "properties": {
                "cartera_id": {"type": "string"},
                "periodo": {"type": "string", "enum": ["1M","3M","6M","1A","Todo"]}
            },
            "required": ["cartera_id", "periodo"]
        }
    }
    # ... más herramientas
]

response = client.messages.create(
    model="claude-sonnet-4-6",
    max_tokens=1024,
    system="Eres el asistente financiero personal de portapp. Tienes acceso a los datos de inversión del usuario. Responde de forma concisa y en español. Nunca des recomendaciones de inversión — solo analiza los datos existentes.",
    tools=tools,
    messages=[{"role": "user", "content": pregunta_usuario}]
)
```

**Consideraciones importantes:**
- El sistema siempre debe aclarar que **no es asesoramiento financiero** (línea CNMV)
- Los datos del usuario nunca salen del backend — Claude solo recibe los resultados de las herramientas, no acceso directo a la BD
- Añadir **prompt caching** para el system prompt y las herramientas (reduce coste ~90% en conversaciones largas)
- Limitar el historial de conversación a los últimos 10 turnos para controlar tokens

**Coste estimado:**
- claude-sonnet-4-6: ~0,003$ por pregunta media (con caching)
- Para 1.000 preguntas/mes: ~3$/mes por usuario activo
- Incluible en la suscripción anual sin impacto significativo en margen

**Dónde integrarlo en la app:**
- Botón flotante en todas las pantallas (similar al botón de anotaciones)
- O sección dedicada "Pregúntame" en el menú de navegación

---

### Caso 2 — Importación automática de PDF de broker (F8)

**Qué hace:** el usuario sube el PDF de extracto de su broker (DEGIRO, IBKR, Coinbase, etc.) y el sistema extrae automáticamente las operaciones e importa al historial.

**Por qué es un caso de IA y no de código determinista:**
Cada broker tiene un formato de PDF diferente, y esos formatos cambian con el tiempo. Mantener parsers específicos por broker es inviable a escala. Un LLM es mucho más robusto ante variaciones de formato.

**Arquitectura técnica:**
```
Usuario sube PDF
        ↓
Backend extrae texto del PDF (pdfplumber / PyMuPDF)
        ↓
Claude API con el texto extraído
        ↓
Prompt: "Extrae todas las operaciones de este extracto de broker.
         Devuelve JSON con: fecha, ticker, tipo_op, cantidad, precio, comisión, divisa"
        ↓
Validación del JSON resultante
        ↓
Preview al usuario: "Se encontraron 12 operaciones. ¿Importar?"
        ↓
Importación confirmada por el usuario
```

**Consideraciones:**
- Siempre mostrar preview antes de importar — el usuario debe revisar y confirmar
- Marcar las operaciones importadas como "importadas" para distinguirlas de las manuales
- Gestionar errores: PDFs escaneados (sin texto), formatos no reconocidos
- Usar `claude-haiku-4-5` para esta tarea (más barato, suficiente para extracción estructurada)

---

### Caso 3 — Alertas inteligentes contextuales

**Qué hace:** en lugar de alertas por umbral fijo ("NVDA bajó 5%"), el agente analiza el contexto del mercado y personaliza la alerta.

**Ejemplo:**
- Alerta básica: *"NVDA bajó 8% hoy"*
- Alerta inteligente: *"NVDA bajó 8% hoy, pero el sector semiconductores bajó 11%. Tu posición lo está haciendo mejor que el sector. El S&P 500 bajó 2% en el mismo período."*

**Implementación:** job nocturno que procesa alertas pendientes con acceso a datos de mercado y genera el texto contextualizado con Claude.

**Prioridad:** baja — las alertas básicas cubren el 80% del valor. Implementar como mejora v2.

---

### Lo que NO debe hacerse con agentes

| Tarea | Por qué NO usar agente |
|---|---|
| Cálculo TWR | Debe ser determinista y auditable. Un LLM puede cometer errores aritméticos. |
| Proyección DCA | Mismo motivo — el usuario confía en el número exacto |
| Gestión de datos (CRUD) | Una BD con validaciones es más segura y fiable |
| Navegación de la app | Ya está resuelta con código |
| Autenticación y seguridad | Nunca delegar decisiones de seguridad a un LLM |

---

### Hoja de ruta de agentes

| Fase | Agente | Prioridad |
|---|---|---|
| Producción v1 | Bot de asistencia (PR9) — preguntas en lenguaje natural | ⭐ Alta |
| Producción v1 | Importación PDF de broker (F8) | 🟡 Media |
| Producción v2 | Alertas inteligentes contextuales | 🟢 Baja |
| Producción v2 | Resumen semanal automático por email | 🟢 Baja |

---

## 20. Arquitectura híbrida — DECISIÓN TOMADA (2026-04-24)

> **Decisión final:** arquitectura híbrida — local-first para datos del usuario + Supabase para servicios de sistema. La app estará disponible en **iOS, Android y web** desde una única base de código (React Native + Expo).

### Modelo híbrido adoptado

| Capa | Dónde vive | Motivo |
|---|---|---|
| Datos operacionales (carteras, activos, ops, efectivo) | SQLite local + sync Supabase | Offline total, respuesta instantánea, privacidad |
| Cotizaciones | Solo Supabase | Se actualizan desde APIs externas — no aplica local |
| Auth y sesiones | Supabase Auth | No hay ventaja en tenerlo local |
| Pagos y suscripciones | Supabase + Paddle | Requieren servidor obligatoriamente |
| Analytics / app_usage | Solo Supabase | Datos del sistema, no del usuario |

**Argumento de venta:** "Tus datos financieros nunca salen de tu dispositivo — la app funciona sin conexión y se sincroniza cuando quieres."

### Plataformas objetivo
- **iOS** — App Store (React Native + Expo)
- **Android** — Google Play (React Native + Expo)
- **Web** — PWA o web app (Expo Web / React Native Web)

Las tres plataformas comparten la misma base de código. El sync entre dispositivos (móvil ↔ web ↔ otro móvil) funciona via WatermelonDB + Supabase Edge Function.

---

### Contexto — por qué se evaluó local-first puro

Local-first es un modelo donde los datos del usuario viven primariamente en su dispositivo (SQLite local) y se sincronizan opcionalmente con la nube.

Apps consolidadas con este modelo: **Linear**, **Obsidian**, **Bear**, **Anytype**. Es una tendencia creciente por la privacidad y la fiabilidad offline. El modelo híbrido adoptado toma lo mejor de este enfoque sin sacrificar la viabilidad de servicios que requieren servidor (cotizaciones, pagos, analytics).

---

### Comparativa de arquitecturas

| Dimensión | Cliente-servidor clásico | Local-first |
|---|---|---|
| **Latencia** | Red + servidor (~100-500ms) | Instantánea (local, <1ms) |
| **Offline** | No funciona | Funciona siempre |
| **Privacidad** | Datos en servidor del proveedor | Datos en dispositivo del usuario |
| **Coste infraestructura** | Alto y constante | Mínimo (solo sync + auth) |
| **Multi-dispositivo** | Sí siempre | Sí con sync activado (opcional) |
| **Complejidad backend** | Alta (lógica, BD, APIs, auth) | Baja (sync + auth + licencias) |
| **Backup** | Automático en servidor | Manual o automático con sync |
| **B2B web desktop** | Sí | Sí via PWA + sync |
| **IA / bot asistente** | Sí (API externa) | Sí (API externa, igual) |
| **App Store / Google Play** | App nativa o PWA | App nativa (React Native) |
| **Argumento de venta** | "Tus datos siempre accesibles" | "Tus datos nunca salen de tu dispositivo" |
| **Coste mensual estimado (v1)** | ~20-50$/mes | ~3-8$/mes |
| **Riesgo técnico** | Bajo (tecnología madura) | Medio (sync es complejo) |

---

### Stack técnico local-first para portapp

| Capa | Tecnología | Por qué |
|---|---|---|
| App | React Native + Expo | Una base de código iOS + Android + web |
| BD local | Expo SQLite / WatermelonDB | SQLite en el dispositivo, muy rápido, offline total |
| Sync | WatermelonDB | Sincroniza SQLite local ↔ PostgreSQL — MIT, sin dependencia de terceros |
| BD nube (opcional) | PostgreSQL (Supabase) | Solo para sync, no como fuente de verdad |
| Auth | Supabase Auth | Solo necesaria para sync y licencias |
| Pagos | Paddle | Sin cambios vs. arquitectura clásica |
| IA | Anthropic API | Sin cambios — llamada externa |

---

### Cómo funciona el sync

```
Dispositivo A                    Nube (opcional)              Dispositivo B
SQLite local  ←→  Electric SQL  ←→  PostgreSQL  ←→  Electric SQL  ←→  SQLite local
```

- Sin conexión: todo funciona en local perfectamente
- Con conexión: sync automático en segundo plano, transparente al usuario
- Conflictos: resueltos automáticamente mediante CRDTs (Conflict-free Replicated Data Types)
- El usuario elige: modo "solo local" (máxima privacidad) o "sincronizar entre dispositivos"

---

### Ventajas específicas para portapp

1. **Privacidad como argumento de venta** — "Tus datos de inversión nunca salen de tu dispositivo" es un diferenciador muy potente en el mercado financiero
2. **Sin dependencia de conexión** — el usuario puede registrar operaciones en el metro, en el avión, en cualquier lugar
3. **Costes operativos mínimos** — el backend solo gestiona sync, auth y licencias. No hay lógica de negocio en el servidor
4. **RGPD simplificado** — si los datos están en el dispositivo, la superficie de exposición de datos personales se reduce drásticamente
5. **Velocidad percibida** — la app responde instantáneamente, sin esperas de red

---

### Limitaciones y cómo abordarlas

| Limitación | Solución |
|---|---|
| Backup si se pierde el teléfono | Sync con nube activable por el usuario + export manual a CSV/JSON |
| Multi-dispositivo | Sync opcional — el usuario lo activa si lo necesita |
| B2B desktop | PWA + sync cubre el caso de uso del asesor en desktop |
| Migraciones de esquema SQLite | Expo SQLite + sistema de migraciones versionadas (igual que en BD clásica) |
| Complejidad del sync | WatermelonDB abstrae la complejidad — no hay que implementar CRDTs a mano |

---

### Análisis de dependencia de la capa de sync (2026-04-27)

La elección de la librería de sync es la decisión técnica con mayor impacto en la independencia del proyecto a largo plazo.

#### Opciones evaluadas

| Opción | Licencia | Dependencia | Complejidad | Veredicto |
|---|---|---|---|---|
| **PowerSync** | Propietaria (free tier) | Alta — si cierran o cambian precios, hay que migrar | Baja (abstrae todo) | ❌ Riesgo de dependencia |
| **Electric SQL** | Apache 2.0 | Media — open source pero tercero en infraestructura | Baja-Media | ⚠️ Mejor que PowerSync pero aún dependencia |
| **WatermelonDB** | MIT | **Nula** — open source, tú controlas el sync endpoint | Media | ✅ Recomendado |
| **Sync propio** | — | Nula — control total | Alta | ⚠️ Solo si el equipo tiene experiencia en sync distribuido |

#### Por qué WatermelonDB es la elección correcta para portapp

**1. Sin dependencia de terceros en la capa crítica**
WatermelonDB es una librería MIT. El protocolo de sync lo implementas tú en una Supabase Edge Function — código que posees completamente. Si WatermelonDB dejara de mantenerse, el código ya está en tu repo y puedes seguir usándolo o migrarlo.

**2. El modelo de datos de portapp simplifica el sync**
Los datos de portapp son casi todos **append-only** (las operaciones son inmutables, nunca se editan). Esto elimina prácticamente todos los conflictos de sync — el problema más difícil del sync distribuido. No necesitas CRDTs completos: basta con una cola de inserciones pendientes.

**3. Madurez probada**
WatermelonDB tiene +10.000 estrellas en GitHub, es usado en producción por Nozbe y Hey.com, y lleva activo desde 2018.

**4. Integración natural con Supabase**
El endpoint de sync de WatermelonDB es una función HTTP estándar — una Supabase Edge Function con ~100 líneas de código lo cubre.

#### Patrón de sync para portapp

```
Dispositivo (React Native)          Backend (Supabase)
WatermelonDB (SQLite local)
    │
    ├─ pull: GET /sync?lastPulledAt=...  ──→  Edge Function
    │                                          lee cambios en PostgreSQL
    │                                    ←──  devuelve registros nuevos/modificados
    │
    └─ push: POST /sync                 ──→  Edge Function
                                               aplica cambios locales en PostgreSQL
```

Dado que las operaciones son inmutables, la estrategia de conflictos es trivial: **last-write-wins en inserciones**. No hay ediciones que resolver.

---

### Pantalla de onboarding — transparencia sobre privacidad y datos

Durante el registro, antes de que el usuario cree su primera cartera, se muestra una pantalla dedicada que explica honestamente cómo funcionan sus datos. El objetivo es generar confianza desde el primer momento y convertir la arquitectura local-first en un argumento de venta emocional.

#### Por qué esta pantalla es importante

- El usuario que viene de competidores cloud asume que sus datos están en un servidor. Hay que romper esa expectativa explícitamente.
- Ser transparente sobre el riesgo de pérdida de datos (si pierde el móvil) antes de que ocurra genera mucha más confianza que descubrirlo después.
- El backup opcional presentado como un servicio de valor añadido, no como obligación, refuerza el mensaje de control total.

#### Diseño propuesto

Pantalla de onboarding de paso único, tras el registro y antes de crear la primera cartera. Tono: claro, directo, sin jerga técnica.

**Título:**
> Tus datos son solo tuyos

**Cuerpo:**
> portapp guarda tus carteras e inversiones únicamente en este dispositivo. Nadie más puede verlos — ni nosotros.
>
> Esto significa que si pierdes el móvil o lo cambias sin hacer una copia, perderías tus datos. Te lo decimos ahora para que lo tengas claro desde el principio.
>
> La app tiene un **modo básico** ideal para empezar y un **modo avanzado** con herramientas analíticas más potentes (rentabilidad TWR, análisis por grupos, índices…). Puedes cambiar entre ellos cuando quieras, gratis, desde Ajustes.
>
> Si quieres, podemos guardar una copia de seguridad cifrada en nuestra nube — solo tú tendrás la clave para descifrarla. Nosotros no podemos leerla. Puedes activarlo ahora o más adelante desde Ajustes.

**Acciones:**
- Botón principal: `Activar backup seguro` → lleva al flujo de configuración de backup
- Botón secundario: `Ahora no, solo guardar en mi móvil` → continúa al onboarding

#### Notas de implementación (Prototipo 2)

- La pantalla aparece **una sola vez**, justo después del primer login exitoso
- Se registra en `user_demographics` o `app_usage` si el usuario activó el backup o lo rechazó
- Si rechaza el backup, la app recuerda no volver a preguntar hasta que el usuario entre en Ajustes → Backup
- El evento `onboarding_step_completed` con `step_name: 'privacy_screen'` captura si el usuario llegó a esta pantalla y qué opción eligió (`activated_backup` | `skipped`)

---

### Plan: Prototipo 2 — validación técnica local-first

El prototipo HTML actual (v6) validó **flujos y UX**. El Prototipo 2 no rehace lo mismo — valida **la arquitectura de datos local y el sync**.

**Objetivo:** demostrar que los datos se guardan en SQLite local, funcionan offline y se sincronizan entre dos dispositivos.

**Alcance mínimo (3-4 pantallas):**
- Login con Supabase Auth
- Crear cartera y añadir activo (guardado en SQLite local)
- Ver activos offline (sin conexión)
- Sync entre dos dispositivos con la misma cuenta

**Stack:**
```
React Native + Expo
WatermelonDB (bd local + sync)
Supabase Edge Function (endpoint de sync)
Supabase Auth + PostgreSQL
```

**Criterio de éxito:** si el sync funciona de forma transparente y los datos persisten offline, la arquitectura está validada y se adopta para producción. Si hay demasiada complejidad operativa, se vuelve al cliente-servidor clásico.

---

### Decisión pendiente

Antes de empezar producción hay que elegir entre las dos arquitecturas. El Prototipo 2 resuelve esta incógnita. **Recomendación: construir el Prototipo 2 en paralelo mientras se recopila feedback del Prototipo 1 con los testers.**

| Arquitectura | Cuándo elegirla |
|---|---|
| **Local-first** (recomendada) | Si el Prototipo 2 demuestra que el sync es manejable y el argumento de privacidad resuena con los testers |
| **Cliente-servidor (Next.js)** | Si el sync resulta demasiado complejo o si el B2B desktop es prioritario desde el inicio |

---

### Requisitos de UX para backup y restore (local-first)

#### Backup

- Antes de ejecutar el backup, mostrar aviso explícito: **"Esto sobreescribirá tu backup anterior. Los datos del backup existente se perderán. ¿Continuar?"** — pedir confirmación obligatoria.
- El backup debe incluir fecha y hora en el nombre del archivo para que el usuario sepa cuándo se hizo.

#### Restore

El restore es la operación más delicada — sobreescribe datos locales que pueden ser **más recientes que el backup**. El usuario no técnico no intuye este riesgo.

**Flujo obligatorio:**
1. **Aviso inicial:** "Vas a restaurar un backup del [fecha]. Todos los datos actuales de la app serán reemplazados por los del backup. Las operaciones registradas desde esa fecha se perderán."
2. **Backup automático de seguridad:** antes de ejecutar el restore, la app hace automáticamente un backup del estado actual. Mensaje: "Hemos guardado una copia de tu estado actual por si necesitas recuperarlo."
3. **Confirmación final:** "¿Confirmas que quieres restaurar el backup del [fecha]? Esta acción no se puede deshacer."
4. **Resultado:** mostrar resumen de lo restaurado (nº de carteras, operaciones, activos).

**Por qué el backup automático previo al restore es crítico:** convierte una operación irreversible en reversible — el usuario siempre tiene un punto de retorno aunque se equivoque.

---

#### Asistente guiado paso a paso (wizard)

El flujo de backup y especialmente el de restore deben implementarse como un **asistente paso a paso** (wizard), no como una pantalla única con un botón. El usuario no técnico necesita ser guiado, no informado.

**Principios del wizard:**
- Una sola acción por pantalla — nunca mostrar todo el proceso a la vez.
- Botones claros: **"Siguiente →"** y **"← Atrás"** (excepto en el último paso).
- El usuario no puede avanzar sin haber leído y confirmado el paso actual.
- En pasos destructivos o irreversibles, el botón de avance cambia de estilo (rojo / destructivo) para reforzar la gravedad de la acción.

**Estructura propuesta para el wizard de Restore:**

| Paso | Contenido |
|---|---|
| 1 — Selección | "¿Qué archivo de backup quieres restaurar?" — selector de archivo con fecha visible |
| 2 — Aviso de riesgo | Explicar en lenguaje llano qué datos se perderán y desde cuándo |
| 3 — Backup de seguridad | "Vamos a guardar una copia de tu estado actual antes de continuar" — ejecutar y confirmar |
| 4 — Confirmación final | Botón rojo "Sí, restaurar backup" — último punto de retorno |
| 5 — Resultado | Resumen: nº carteras, activos y operaciones restauradas. Botón "Ir a inicio" |

**Por qué wizard y no pantalla única:** en una pantalla única el usuario escanea en diagonal y pulsa el botón sin leer. El wizard obliga a procesar cada paso de forma consciente, reduce errores y genera confianza en usuarios no técnicos.

---

## 21. Requisitos funcionales — Compra de valores (producción)

### Validación de ticker

Antes de registrar una compra, la app debe verificar que el ticker introducido existe realmente, conectando con una plataforma de datos (Yahoo Finance, Alpha Vantage, ProRealTime u otra).

### Selección de bolsa

Si el ticker cotiza en más de una bolsa (p. ej. MSFT en NASDAQ y en bolsas europeas), se mostrará al usuario una lista para que elija en cuál desea ejecutar la compra. No se puede asumir la bolsa por defecto.

### Selección de divisa

Si en la bolsa elegida el valor cotiza en más de una divisa, se mostrará al usuario una lista para que elija la divisa de la operación. Relevante en bolsas europeas donde el mismo valor puede cotizar en EUR y GBP, por ejemplo.

### Verificación de fondos

Antes de confirmar la compra, la app debe comprobar que el broker seleccionado tiene saldo de efectivo suficiente para cubrir el importe de la operación (precio × cantidad + comisión estimada). Si no hay fondos suficientes, mostrar aviso claro y bloquear la confirmación.

### Flujo completo propuesto

```
Introducir ticker
  → Verificar existencia (API)
    → Si cotiza en varias bolsas → elegir bolsa
      → Si cotiza en varias divisas en esa bolsa → elegir divisa
        → Verificar fondos en broker seleccionado
          → Confirmar compra
```

---

## 22. Modelo de datos — Decisiones pendientes (producción)

### Integridad referencial

Cualquier operación de borrado (cartera, broker, grupo, activo) debe verificar si existen registros dependientes antes de ejecutarse. Se requiere:

- Definir el modelo de entidades y sus relaciones con claves foráneas explícitas.
- Establecer reglas de cascada o bloqueo por entidad: p. ej. no se puede borrar un broker si tiene operaciones asociadas; no se puede borrar una cartera si tiene activos.
- Validar estas restricciones tanto en el cliente (UX: avisos antes del borrado) como en la capa de datos (SQLite con `PRAGMA foreign_keys = ON` en local-first, o constraints en PostgreSQL en cliente-servidor).
- Definir el comportamiento ante borrados en cascada vs. borrados bloqueados para cada relación.

### Modelo dimensional — Kimball vs. otros enfoques

Decisión pendiente sobre el enfoque de modelado de datos para las métricas y el historial:

| Opción | Descripción | Adecuado para portapp |
|---|---|---|
| **Kimball (estrella/copo de nieve)** | Tablas de hechos + dimensiones. Optimizado para consultas analíticas. | Sí, si se prevén consultas complejas de rentabilidad, comparativas y reporting |
| **Modelo normalizado (3FN)** | Tablas relacionales estándar. Más sencillo de mantener. | Sí para el modelo operacional (operaciones, carteras, activos) |
| **Híbrido** | Modelo 3FN para datos operacionales + tablas de agregados para métricas históricas | Recomendado: separa escritura (operaciones) de lectura (dashboards) |

**Decisión tomada (2026-04-23):** se usará **modelo Kimball** para el esquema de producción. Ver sección 23 para el detalle del modelo de datos en progreso.

---

## 23. Modelo de datos — Kimball (CERRADO 2026-04-24)

> Modelo cerrado el 2026-04-24. Todas las tablas están acordadas. Pendiente: diagrama Mermaid en `docs/DATA_MODEL.md`.

### Enfoque

- **Kimball** para métricas, historial y analytics (fact tables + dimensiones SCD)
- **3FN** para datos operacionales transaccionales
- Plataforma: **PostgreSQL en Supabase** (ver sección 24)
- Pagos: **Paddle** como Merchant of Record — nunca se guardan datos de tarjeta en BD

---

### Tablas acordadas

#### `users`
| Campo | Tipo | Notas |
|---|---|---|
| user_id | uuid PK | |
| user_first_name | string | |
| user_last_name | string | |
| user_alias | string | |
| user_main_email | string | |
| user_secondary_email | string | Recuperación de cuenta |
| user_mobile_number | string | SMS 2FA |
| user_pwd | string | Hash bcrypt/argon2 — nunca en claro |
| email_verified | boolean | |
| 2fa_method | string | email\|sms\|totp |
| plan | string | free\|personal\|pro |
| open_account_date | timestamp | |
| close_account_date | timestamp | Soft delete |
| paddle_customer_id | string | ID del cliente en Paddle |

#### `subscription_plan` *(SCD2)*
| Campo | Tipo | Notas |
|---|---|---|
| subscription_plan_id | uuid PK | |
| subscription_plan_name | string | |
| subscription_plan_type | string | one_time\|recurring_annual\|recurring_monthly |
| subscription_price | decimal(10,2) | |
| valid_from | timestamp | SCD2 |
| valid_to | timestamp | null = registro activo |
| is_current | boolean | SCD2 |

#### `user_subscription` *(N planes activos por usuario)*
| Campo | Tipo | Notas |
|---|---|---|
| user_subscription_id | uuid PK | |
| user_id | uuid FK → users | |
| subscription_plan_id | uuid FK → subscription_plan | |
| start_date | timestamp | |
| end_date | timestamp | null = activo |
| status | string | active\|cancelled\|expired |
| payment_ref | string | Referencia externa Paddle |
| paddle_subscription_id | string | ID suscripción recurrente en Paddle |

#### `payments` *(fact table — inmutable)*
| Campo | Tipo | Notas |
|---|---|---|
| payment_id | uuid PK | |
| user_id | uuid FK → users | |
| user_subscription_id | uuid FK → user_subscription | |
| amount | decimal(10,2) | |
| currency | string | |
| payment_method | string | card\|transfer\|paypal… |
| payment_status | string | completed\|failed\|refunded |
| payment_date | timestamp | |
| payment_ref | string | Referencia procesador (Paddle) |

#### `app_usage` *(snapshot diaria — fact table)*
| Campo | Tipo | Notas |
|---|---|---|
| usage_id | uuid PK | |
| user_id | uuid FK → users | |
| usage_date | date | |
| platform | string | ios\|android\|web |
| total_sessions | int | |
| total_duration_min | int | |
| screens_visited | int | |
| operations_added | int | |
| last_active_at | timestamp | |
| | | UNIQUE (user_id, usage_date, platform) |

#### `portfolio`
| Campo | Tipo | Notas |
|---|---|---|
| portfolio_id | uuid PK | |
| portfolio_name | string | |
| portfolio_description | string | |
| portfolio_main_currency | string | EUR\|USD\|GBP… |
| portfolio_colour | string | Hex color |
| portfolio_created_at | timestamp | |
| portfolio_deleted_at | timestamp | Soft delete — bloquear si tiene activos activos |

#### `portfolio_members` *(N:M usuarios-carteras con permisos)*
| Campo | Tipo | Notas |
|---|---|---|
| id | uuid PK | |
| portfolio_id | uuid FK → portfolio | |
| user_id | uuid FK → users | |
| role | string | owner\|editor\|viewer |
| invited_by | uuid FK → users | |
| joined_at | timestamp | |
| status | string | active\|pending\|revoked |

#### `groups` *(globales por usuario)*
| Campo | Tipo | Notas |
|---|---|---|
| group_id | uuid PK | |
| user_id | uuid FK → users | |
| group_name | string | |
| group_colour | string | Hex color |
| group_order | int | Para drag & drop |
| group_created_at | timestamp | |

#### `accounts` *(brokers, bancos y exchanges)*
| Campo | Tipo | Notas |
|---|---|---|
| account_id | uuid PK | |
| user_id | uuid FK → users | |
| account_name | string | |
| account_type | string | broker\|bank\|crypto_exchange\|other |
| account_iban | string | nullable |
| account_bic | string | nullable |
| account_created_at | timestamp | |
| account_deleted_at | timestamp | Soft delete — bloquear si tiene operaciones o efectivo |

#### `assets` *(posiciones — estado actual cacheado)*
| Campo | Tipo | Notas |
|---|---|---|
| asset_id | uuid PK | |
| portfolio_id | uuid FK → portfolio | |
| group_id | uuid FK → groups | nullable — SET NULL si se borra el grupo |
| account_id | uuid FK → accounts | Broker principal |
| asset_ticker | string | Verificado vía API antes de insertar |
| asset_name | string | |
| asset_isin | string | nullable |
| asset_type | string | stock\|etf\|crypto\|fund\|other |
| asset_market | string | NASDAQ\|XETRA\|Crypto… |
| asset_exchange | string | Código de bolsa elegido por el usuario |
| asset_currency | string | Divisa elegida por el usuario |
| asset_region_json | json | Distribución geográfica |
| asset_index | string | nullable |
| asset_qty | decimal | Cache — recalculado desde operations |
| asset_avg_price | decimal | Cache — recalculado desde operations |
| asset_last_price | decimal | Cotización actual |
| asset_prev_price | decimal | Cotización día anterior — para variación diaria |
| asset_price_date | timestamp | Fecha de la última cotización |
| asset_created_at | timestamp | |
| asset_deleted_at | timestamp | Soft delete — bloquear si tiene operaciones |

#### `operations` *(fact table — inmutable, nunca se edita)*
| Campo | Tipo | Notas |
|---|---|---|
| operation_id | uuid PK | |
| portfolio_id | uuid FK → portfolio | |
| asset_id | uuid FK → assets | |
| asset_ticker | string | Denormalizado — integridad histórica |
| account_id | uuid FK → accounts | |
| operation_type | string | buy\|sell\|dividend\|staking\|split\|other |
| operation_date | date | |
| operation_qty | decimal | |
| operation_price | decimal | |
| operation_fee | decimal | |
| operation_currency | string | |
| operation_note | string | nullable |
| operation_status | string | active\|cancelled — nunca se borra físicamente |
| cancelled_by_id | uuid FK → operations | nullable — apunta a la operación inversa |
| cancelled_at | timestamp | nullable |
| operation_created_at | timestamp | |

**Patrón de inmutabilidad — cómo funciona el "borrado":**

Las operaciones nunca se eliminan de la base de datos. Cuando el usuario quiere anular una operación, la app genera automáticamente una **operación inversa** con los mismos valores (precio, tipo de cambio, qty) y marca ambas como canceladas entre sí. El impacto neto en qty y precio medio es cero, y el historial financiero queda íntegro.

```
Operación original:   buy  · 10 AAPL · 170 USD · 2024-03-10 · status: cancelled
Operación inversa:    sell · 10 AAPL · 170 USD · 2026-04-26 · status: cancelled
                      cancelled_by_id → [original] ↔ [inversa]
```

**Por qué el mismo precio:** usar el precio original garantiza que el impacto en precio medio y P/L es exactamente cero. No se distorsiona ninguna métrica histórica.

**UX — qué ve el usuario:**
- **Vista normal:** solo operaciones con `status = 'active'`. Las anuladas están ocultas por defecto.
- **Vista de auditoría:** toggle "Mostrar anuladas" revela ambas operaciones (original + inversa) con estilo tachado/gris y fecha de anulación visible.

**Impacto en cascada al anular:**
- `assets.qty` y `assets.avg_price` — se recalculan desde operaciones activas
- `cash` — los movimientos de efectivo vinculados también se marcan como cancelados
- `portfolio_snapshots` — los snapshots pasados **no se modifican** (son inmutables por diseño); el impacto solo afecta a snapshots futuros

#### `cash` *(movimientos de efectivo)*
| Campo | Tipo | Notas |
|---|---|---|
| cash_id | uuid PK | |
| portfolio_id | uuid FK → portfolio | |
| account_id | uuid FK → accounts | |
| operation_id | uuid FK → operations | nullable |
| cash_type | string | deposit\|withdrawal\|dividend\|staking\|fee\|interest\|other |
| cash_amount | decimal | |
| cash_currency | string | |
| cash_date | date | |
| cash_origin | string | manual\|operation |
| cash_note | string | nullable |
| cash_created_at | timestamp | |

#### `stock_prices` *(histórico de cotizaciones)*
| Campo | Tipo | Notas |
|---|---|---|
| price_id | uuid PK | |
| asset_id | uuid FK → assets | nullable — permite precargar precios antes de tener el activo |
| price_ticker | string | Denormalizado — integridad histórica |
| price_exchange | string | Diferencia mismo ticker en distintos mercados |
| price_currency | string | |
| price_open | decimal | nullable |
| price_close | decimal | |
| price_high | decimal | nullable |
| price_low | decimal | nullable |
| price_volume | int | nullable |
| price_date | date | |
| price_source | string | manual\|yahoo\|alphavantage\|other |
| price_created_at | timestamp | |
| | | UNIQUE (price_ticker, price_exchange, price_date) |

#### `portfolio_snapshots` *(snapshot diaria — fact table)*
| Campo | Tipo | Notas |
|---|---|---|
| snapshot_id | uuid PK | |
| portfolio_id | uuid FK → portfolio | |
| snapshot_date | date | |
| snapshot_total_value | decimal | Valor total de la cartera |
| snapshot_total_invested | decimal | Capital invertido acumulado |
| snapshot_cash_balance | decimal | Saldo de efectivo |
| snapshot_currency | string | De portfolio_main_currency |
| snapshot_created_at | timestamp | |
| | | UNIQUE (portfolio_id, snapshot_date) |

#### `annotations` *(anotaciones globales del usuario)*
| Campo | Tipo | Notas |
|---|---|---|
| annotation_id | uuid PK | |
| user_id | uuid FK → users | |
| annotation_text | text | |
| annotation_created_at | timestamp | |
| annotation_updated_at | timestamp | |

#### `asset_notes` *(notas específicas de un activo)*
| Campo | Tipo | Notas |
|---|---|---|
| asset_note_id | uuid PK | |
| asset_id | uuid FK → assets | |
| user_id | uuid FK → users | |
| asset_note_text | text | |
| asset_note_created_at | timestamp | |
| asset_note_updated_at | timestamp | |

#### `notifications`
| Campo | Tipo | Notas |
|---|---|---|
| notification_id | uuid PK | |
| user_id | uuid FK → users | |
| notification_type | string | alert\|dca\|info |
| notification_title | string | |
| notification_body | text | |
| notification_read | boolean | |
| notification_favourite | boolean | |
| notification_created_at | timestamp | |

#### `platforms` *(accesos directos externos)*
| Campo | Tipo | Notas |
|---|---|---|
| platform_id | uuid PK | |
| user_id | uuid FK → users | |
| platform_name | string | |
| platform_url | string | |
| platform_icon | string | |
| platform_order | int | |
| platform_created_at | timestamp | |

#### `exchange_rates` *(tipos de cambio)*
| Campo | Tipo | Notas |
|---|---|---|
| rate_id | uuid PK | |
| rate_currency_from | string | |
| rate_currency_to | string | |
| rate_value | decimal(10,6) | |
| rate_date | date | |
| rate_source | string | manual\|ecb\|fixer |
| rate_created_at | timestamp | |

---

### Reglas de integridad referencial (borrado)

| Entidad | Regla |
|---|---|
| portfolio | Soft delete — bloquear si tiene assets u operations |
| assets | Soft delete — bloquear si tiene operations |
| accounts | Soft delete — bloquear si tiene operations o cash |
| groups | SET NULL en assets.group_id al borrar — no bloquear |
| operations | Nunca se borra — solo se anula con operación inversa |
| annotations / asset_notes | Borrado físico — sin implicaciones de integridad |

---

### Pendiente

- Diagrama Mermaid completo → `docs/DATA_MODEL.md`
- Exports y reports en PDF → pendiente de diseñar contenido y formato (ver sección 26)

### FIFO — Pendiente de implementación (pre-producción)

En España y el resto de países hispanohablantes la venta de acciones sigue el método FIFO (First In, First Out) a efectos fiscales. Funcionalidades previstas para pre-producción:

- Marcar visualmente qué lotes se venden según FIFO y a qué precio de compra
- Mostrar ganancia real por venta calculada sobre precio de compra FIFO (no sobre PM)
- Gestión de ventas parciales del último lote

Requiere motor de trazabilidad de lotes en backend. No implementado en el prototipo.

---

## 24. Supabase como backend de portapp

**Decisión (2026-04-23):** usar Supabase como plataforma de backend para portapp, tanto en arquitectura local-first (sync) como en cliente-servidor si se descarta local-first.

### Usos previstos

| Servicio Supabase | Uso en portapp |
|---|---|
| **PostgreSQL** | Base de datos principal — esquema Kimball (sec 23) |
| **Auth** | Login, registro, sesiones, JWT, OAuth (Google/Apple), WebAuthn/biométrico — elimina gestión propia de auth |
| **Realtime / Sync** | Integración con PowerSync o Electric SQL para sincronizar SQLite local ↔ PostgreSQL |
| **Storage** | Archivos de backup del usuario, exports CSV/Excel, PDFs de broker para importación |
| **Edge Functions** | Llamadas a APIs de cotizaciones, procesado de PDFs, envío de emails/SMS, notificaciones push |
| **Row Level Security** | Garantía a nivel de BD de que cada usuario solo accede a sus datos — crítico para RGPD |

### Administración
- Dashboard web en `app.supabase.com` — editor SQL, visor de tablas, gestión de usuarios, logs
- Connection string estándar PostgreSQL — compatible con DBeaver, TablePlus, pgAdmin
- CLI para migraciones y despliegues

### Plan gratuito
Suficiente para Prototipo 2 y primeros meses de producción (500 MB BD, 5 GB egress, 50k usuarios auth). Limitación principal: proyectos se pausan tras 7 días sin actividad — acceptable en desarrollo, no en producción.

---

## 25. Requisitos funcionales — Actualización de cotizaciones

- Botón manual para actualizar la cotización de todos los valores de todas las carteras — el usuario decide cuándo.
- Cotización en tiempo real → **función premium**. Sin premium, el usuario actualiza manualmente.
- Mostrar junto a cada valor la **fecha de la cotización**, o si no hay espacio, **hace cuántos días** no se actualiza.
- La cotización es crítica para calcular el rendimiento de los activos — sin datos frescos el P&L no es fiable.

---

## 26. Exports y reports — Pendiente de diseñar

### Exports de datos (CSV / Excel)
Pendiente de decidir qué información incluyen los exports: qué tablas, qué campos, qué filtros disponibles (por cartera, por período, por tipo de activo, por broker…).

### Reports en PDF
Pendiente de diseñar tanto el contenido como el formato visual. Posibles reports de alto valor para el usuario:

| Report | Contenido |
|---|---|
| Resumen anual de cartera | Valor, rentabilidad, dividendos cobrados, capital aportado en el año |
| Informe de operaciones por período | Lista de compras/ventas/dividendos con totales |
| Ganancias y pérdidas | P&L realizado y no realizado — útil para la declaración de la renta |
| Informe por broker | Posiciones y operaciones agrupadas por broker |
| Informe de rentabilidad TWR | Rentabilidad real por cartera y por activo con gráfico |

> Pendiente: definir campos exactos, filtros, aspecto visual y formato de cada report antes de implementar.

---

## 27. Seguridad — Perfil de usuario y gestión de cuenta

### Confirmación por email para cambios críticos

Los cambios en datos sensibles del perfil no se aplican de forma inmediata — requieren confirmación por email para proteger al usuario ante accesos no autorizados.

**Requieren confirmación por email:**
- Cambio de email principal — podría bloquear el acceso a la cuenta
- Cambio de contraseña
- Cambio de método 2FA
- Desactivación del 2FA

**No requieren confirmación:**
- Nombre, apellidos, alias
- Teléfono secundario (salvo que sea el método 2FA activo)
- Preferencias de idioma o zona horaria

**Flujo:** usuario solicita cambio → aviso en app → email con enlace/código (caduca en 15–30 min) → usuario confirma → cambio efectivo.

**Nota técnica:** Supabase Auth gestiona este flujo de forma nativa para cambio de email y contraseña — no hay que implementarlo desde cero.

---

### Eliminación de cuenta

- Solo puede ejecutarla el **owner** de la cuenta. Ningún editor ni viewer de carteras compartidas puede eliminar la cuenta del propietario.
- Requiere confirmación por email — igual que los cambios críticos de perfil.

**Flujo:**
1. Usuario solicita eliminar cuenta
2. Aviso explícito de consecuencias: datos eliminados, carteras compartidas huérfanas, suscripción cancelada
3. Email de confirmación con enlace (caduca en 15–30 min)
4. Confirmación final en app
5. Eliminación efectiva

**Período de gracia:** marcar la cuenta como "pendiente de eliminar" durante X días antes del borrado físico — permite recuperación si fue un error o un acceso no autorizado.

**Pendiente de decidir:** qué ocurre con las carteras compartidas cuando se elimina la cuenta del owner — tres opciones: (a) se eliminan todas, (b) se transfiere la propiedad al miembro más antiguo, (c) se bloquean hasta que otro miembro reclame la propiedad.

---

### Cierre de sesión automático por inactividad

Dos niveles diferenciados:

**Nivel 1 — Bloqueo de pantalla** *(ya prototipado)*
La app se bloquea y pide PIN/biométrico al volver al primer plano tras el tiempo de gracia. El usuario sigue autenticado — solo hay que desbloquear la pantalla.

**Nivel 2 — Cierre de sesión completo** *(producción)*

| Evento | Acción |
|---|---|
| Sin actividad > 30 días | Cierre de sesión completo — requiere login + 2FA |
| Sesión web sin actividad > 24h | Cierre de sesión completo |
| Token JWT caducado sin actividad | Cierre de sesión — no se renueva automáticamente |
| Token JWT caducado con actividad reciente | Refresh automático transparente |

El tiempo de inactividad para cierre completo será configurable por el usuario en **Ajustes > Seguridad**. Supabase Auth gestiona la caducidad de tokens de forma nativa.

---

## 28. Backup gestionado — Tier 2+

El modelo de backup de portapp ofrece dos opciones coexistentes, dirigidas a perfiles de usuario distintos:

| Opción | Para quién | Cómo funciona |
|---|---|---|
| **Backup manual** | Usuario técnico que quiere control total | El usuario descarga el archivo y lo guarda donde prefiera |
| **Backup gestionado** *(Tier 2+)* | Usuario no técnico que prefiere delegar | Con un botón, portapp guarda una copia cifrada en nuestros servidores |

**Mensaje clave para el usuario:** *"Ambas opciones son seguras. El backup manual te da el control total de tus datos. El backup gestionado añade comodidad y un nivel extra de respaldo técnico — nosotros nos encargamos de que tu copia esté siempre disponible."*

El backup gestionado forma parte del **Tier 2+ (suscripción anual de servicios)** junto con cotizaciones en tiempo real y sync multi-dispositivo — todos servicios con coste de infraestructura real que justifican el cobro recurrente.

---

## 29. Product Analytics — Stack de métricas y DWH

### Objetivo

Capturar métricas de uso de la app para alimentar decisiones de producto y marketing. Inspirado en el modelo de analytics de juegos móviles — los dispositivos móviles generan una cantidad enorme de información de comportamiento que bien estructurada es una ventaja competitiva.

### Arquitectura del stack

```
App (React Native)
  → eventos en SQLite local (offline-safe)
    → PowerSync sync
      → Supabase PostgreSQL
        → Edge Function (cron)
          → BigQuery
            → dbt Core
              → Looker Studio
```

> **Nota clave:** BigQuery tiene conexión **nativa** con Looker — Google adquirió Looker en 2020. Looker Studio es gratuito y conecta nativamente. Esta integración elimina pipelines adicionales para visualización.

---

### Captura de eventos — estrategia por fases

#### Fase 1 — Prototipo 2: PostHog

Para el Prototipo 2 se usará **PostHog** como solución de event tracking. Razones:

- SDK oficial para React Native — integración en horas
- Buffering offline incluido — guarda eventos localmente y los envía cuando hay conexión
- Plan gratuito hasta **1 millón de eventos/mes**
- Exportación nativa a BigQuery con un clic
- Dashboard propio inmediato — sin necesidad de configurar dbt desde el primer día
- Open source — se puede auto-hostear si la privacidad lo requiere en el futuro

**Instalación en React Native:**
```bash
npm install posthog-react-native
```

**Uso en la app:**
```typescript
import PostHog from 'posthog-react-native'

// Inicializar una vez al arrancar la app
const posthog = new PostHog('API_KEY', { host: 'https://eu.posthog.com' })

// Capturar evento
posthog.capture('screen_view', { screen: 'global', plan: 'personal' })
posthog.capture('operation_added', { type: 'buy', asset_type: 'etf' })
```

> **Nota de privacidad:** PostHog tiene servidores en la UE (`eu.posthog.com`) — compatible con RGPD. Los datos de comportamiento van a PostHog, no a nuestros servidores. Esto es aceptable para el Prototipo 2 (validación), pero en producción se evaluará migrar a la Opción C (DIY).

#### Fase 2 — Producción: DIY con Supabase (cuando el volumen lo justifique)

En producción, si el argumento de privacidad es central, se migra a un pipeline propio que reutiliza toda la infraestructura ya planificada:

```
App (React Native)
  → tabla events[] en SQLite local   ← mismo patrón que datos operacionales
    → PowerSync sync automático
      → Supabase PostgreSQL (tabla events)
        → Edge Function Supabase (cron cada hora)
          → BigQuery API
```

**Ventajas de la migración:**
- Cero terceros adicionales — los eventos viajan por la misma infraestructura que los datos del usuario
- Offline garantizado — PowerSync ya gestiona el sync
- Control total del esquema de eventos
- El argumento "tus datos nunca salen de tu dispositivo" se extiende también a los metadatos de comportamiento

**Cuándo migrar:** cuando PostHog acerque al límite de 1M eventos/mes o cuando el equipo tenga capacidad de mantener el pipeline DIY.

#### Instrumentación — cómo capturar eventos en React Native

La instrumentación se hace en dos niveles:

**1. Navegación (automático):**
React Navigation tiene un listener de eventos que captura cada cambio de pantalla sin código extra por pantalla:

```typescript
<NavigationContainer
  onStateChange={() => posthog.capture('screen_view', {
    screen: navigationRef.current?.getCurrentRoute()?.name
  })}
>
```

**2. Acciones específicas (manual):**
Se añade `posthog.capture()` en los handlers de las acciones relevantes:

```typescript
// Al registrar una operación
const handleAddOperation = (op) => {
  posthog.capture('operation_added', {
    type: op.type,           // buy | sell | dividend
    asset_type: op.assetType // stock | etf | crypto
  })
  saveOperation(op)
}
```

**Regla de oro:** capturar el **qué** y el **contexto mínimo necesario**, nunca datos financieros del usuario (importes, tickers, cantidades).

### Separación operacional / analítico

| Capa | Sistema | Contenido |
|---|---|---|
| Operacional | Supabase PostgreSQL | Datos del usuario: carteras, activos, operaciones, efectivo |
| Analítico | BigQuery | Eventos de comportamiento, métricas agregadas, KPIs |

Los dos sistemas son independientes — el DWH no interfiere con el rendimiento de la app.

### Métricas previstas

#### Usuarios
- DAU / WAU / MAU (activos diarios, semanales, mensuales)
- Retención por cohorte: día 1, día 7, día 30 — indicador clave de si el producto engancha
- Churn rate por plan
- Tiempo medio hasta conversión free → pago
- LTV (lifetime value) por segmento y región

#### Producto
- Funnel de onboarding — dónde abandona el usuario nuevo
- Pantallas más visitadas y tiempo medio por pantalla
- Features más usadas por tipo de plan
- Tasa de uso de backup manual vs gestionado
- Activos más registrados (acciones vs ETFs vs cripto) por región

#### Negocio
- MRR / ARR por plan y región geográfica
- Conversión free → Personal → Tier 2+
- Tipo de suscripción por país
- CAC por canal de adquisición (cuando haya campañas activas)
- NPS implícito: usuarios que comparten cartera = señal de satisfacción

#### Geográfico
- Distribución España vs LatAm vs otros
- Activos más populares por región (útil para marketing localizado)
- Tipo de suscripción por país

### Esquema de eventos

#### Estructura base

Todos los eventos comparten estos campos. No se repiten en `properties`.

```json
{
  "event_name":   "string",
  "user_id":      "uuid",
  "session_id":   "uuid",
  "timestamp":    "ISO8601",
  "platform":     "ios | android | web",
  "device_type":  "iphone | ipad | android_phone | android_tablet | desktop",
  "plan":         "free | personal | pro",
  "user_role":    "owner_only | shared_owner | shared_member",
  "country":      "ES | MX | AR | ...",
  "locale":       "es-ES | es-MX | es-AR | ...",
  "age_range":    "18-24 | 25-34 | 35-44 | 45-54 | 55+ | null",
  "gender":       "male | female | other | prefer_not_to_say | null",
  "properties":   { ... }
}
```

- `device_type` — tipo de dispositivo dentro de cada plataforma. Permite segmentar iPhone vs iPad, móvil vs tablet Android, escritorio vs móvil web.
- `user_role` — `owner_only`: usa la app en solitario · `shared_owner`: tiene carteras compartidas con otros · `shared_member`: accede a carteras de otro usuario.
- `country` — inferido de IP en PostHog (Fase 1) o de Supabase en Fase 2. Clave para segmentación geográfica y estrategia de expansión LatAm.
- `locale` — idioma del dispositivo. Útil para adaptar marketing por variante de español.
- `age_range` / `gender` — datos demográficos opcionales recogidos con consentimiento explícito. `null` si el usuario no los proporcionó. Almacenados en el operacional (`user_demographics`) y propagados a los eventos para segmentación. **Nunca se vinculan a la identidad del usuario en el DWH** — se tratan como atributos estadísticos anónimos. Sujetos a RGPD: el usuario puede modificarlos o eliminarlos en cualquier momento desde Ajustes.

> **Regla de oro:** ningún evento incluye tickers, importes ni cantidades. Solo el *qué* y el *contexto mínimo necesario*.

> **Nota legal — datos demográficos:** `age_range` y `gender` son datos personales bajo RGPD aunque estén anonimizados. Su recogida requiere consentimiento explícito, informado y revocable. El texto de consentimiento debe especificar: finalidad estadística, anonimización, ausencia de vinculación con la cuenta, y derecho de supresión.

#### Estrategia de solicitud de datos demográficos (progressive profiling)

No se piden en el onboarding — el usuario aún no conoce ni aprecia la app y la tasa de rechazo sería alta. Se solicitan después de una señal clara de valor percibido:

- Tras registrar la 5ª operación
- Tras la primera semana activa con al menos 3 sesiones
- Tras visualizar su primera rentabilidad calculada

**Lógica de reintento:**

| Respuesta del usuario | Acción |
|---|---|
| Completa el formulario | No volver a preguntar |
| Cierra sin responder | Reintentar a los 90 días |
| Responde "prefiero no decirlo" en algún campo | No volver a preguntar nunca — es un no definitivo |

El estado de la solicitud (`demographics_asked_at`, `demographics_declined_permanently`) se almacena en `user_demographics` para controlar cuándo y si se vuelve a mostrar.

---

#### Catálogo de eventos

##### Sesión y navegación

| Evento | Properties | Descripción |
|---|---|---|
| `session_start` | `first_time: bool`, `push_source: string\|null` | Apertura de la app. `push_source` indica si viene de una notificación push. |
| `session_end` | `duration_seconds: int` | Cierre de sesión. |
| `screen_view` | `screen: string`, `previous_screen: string\|null`, `time_on_prev_ms: int\|null` | Cada cambio de pantalla. Permite calcular tiempo medio por pantalla y flujos de navegación. |

##### Onboarding

| Evento | Properties | Descripción |
|---|---|---|
| `onboarding_step_completed` | `step_name: string`, `step_index: int` | Paso del onboarding completado. Permite construir el funnel de activación. |
| `first_portfolio_created` | `currency: string` | Primera cartera creada — señal de activación. |

##### Operaciones y efectivo

| Evento | Properties | Descripción |
|---|---|---|
| `operation_added` | `operation_type: buy\|sell\|dividend\|staking`, `asset_type: stock\|etf\|crypto\|other`, `is_first_for_type: bool` | Nueva operación registrada. `is_first_for_type` indica si es la primera vez que el usuario registra ese tipo de activo. |
| `operation_cancelled` | `operation_type: string`, `days_since_original: int` | Operación cancelada. `days_since_original` indica si fue una corrección inmediata o tardía. |
| `cash_movement_added` | `cash_type: deposit\|withdrawal` | Movimiento de efectivo registrado. |

##### Carteras y colaboración

| Evento | Properties | Descripción |
|---|---|---|
| `portfolio_created` | `portfolio_index: int` | Nueva cartera creada (1ª, 2ª, 3ª…). |
| `portfolio_shared` | `role_granted: editor\|viewer` | Cartera compartida con otro usuario. Señal de satisfacción y uso colaborativo. |

##### Backup y suscripción

| Evento | Properties | Descripción |
|---|---|---|
| `backup_triggered` | `type: manual\|automatic` | Backup ejecutado. |
| `subscription_changed` | `from_plan: string`, `to_plan: string`, `direction: upgrade\|downgrade` | Cambio de plan. |

##### Engagement

| Evento | Properties | Descripción |
|---|---|---|
| `annotation_created` | — | Anotación global creada. Señal de usuario comprometido. |
| `privacy_mode_toggled` | `enabled: bool` | Modo privacidad activado/desactivado. |
| `projection_viewed` | `dca_frequency: monthly\|biweekly\|weekly` | Herramienta de proyección DCA usada. |
| `content_shared` | — | El usuario comparte contenido de la app (captura de cartera, rentabilidad…). |
| `referral_shared` | — | El usuario comparte un enlace de referido. |

##### Plataformas externas y canales

| Evento | Properties | Descripción |
|---|---|---|
| `external_platform_opened` | `platform_name: string` | Enlace a plataforma externa abierto (broker, banco…). Clave para detectar qué brokers son más populares entre nuestros usuarios — insumo para negociar acuerdos comerciales. |
| `channel_opened` | `channel_name: string`, `channel_type: youtube\|blog\|podcast` | Canal de aprendizaje abierto. Útil para partnerships con creadores de contenido. |
| `channel_category_viewed` | `category: string` | Categoría de contenido visitada (value investing, análisis técnico, cripto…). |

##### Notificaciones y valoración

| Evento | Properties | Descripción |
|---|---|---|
| `notification_action_taken` | `notification_type: string` | El usuario interactúa con una notificación. Permite medir efectividad de notificaciones promocionales. |
| `app_rated` | `rating: int (1-5)`, `platform: app_store\|google_play`, `triggered_by: manual\|prompt` | El usuario valora la app. |

##### Errores

| Evento | Properties | Descripción |
|---|---|---|
| `error_shown` | `error_type: string`, `screen: string` | Error mostrado al usuario. Útil para detectar fricciones en el flujo. |

---

#### Solicitud de valoración en la app

La valoración nativa (diálogo del sistema dentro de la app, sin salir a la tienda) se implementa en el Prototipo 2 con:
- **iOS:** `SKStoreReviewController.requestReview()` (StoreKit)
- **Android:** `In-App Review API` (Google Play)

**Cuándo lanzar el prompt:**
- Tras registrar la 5ª operación (usuario activo)
- Tras visualizar rentabilidad positiva por primera vez
- Tras 7 días de uso con al menos 3 sesiones
- Nunca más de una vez cada 90 días (límite del sistema iOS)

El evento `app_rated` se dispara siempre que el usuario completa la valoración, independientemente de si usó el prompt o fue a la tienda manualmente.

---

#### Modelos dbt previstos

| Modelo | Capa | Descripción |
|---|---|---|
| `stg_events` | staging | Limpieza y tipado de todos los eventos raw. Base para todos los marts. |
| `dau` | marts | DAU / WAU / MAU calculados desde `session_start`. |
| `screen_engagement` | marts | Tiempo medio por pantalla desde `screen_view`. Identifica pantallas con mayor retención. |
| `onboarding_funnel` | marts | Conversión paso a paso desde `onboarding_step_completed`. Detecta dónde abandona el usuario nuevo. |
| `feature_adoption` | marts | Uso de features por plan y `user_role`. Informa decisiones de producto y pricing. |
| `subscription_funnel` | marts | Conversión free → personal → pro desde `subscription_changed`. |
| `platform_popularity` | marts | Ranking de plataformas externas desde `external_platform_opened`. Insumo para negociar acuerdos con brokers. |
| `content_engagement` | marts | Canales y categorías más consumidos desde `channel_opened` y `channel_category_viewed`. Insumo para partnerships con creadores. |
| `geo_distribution` | marts | Distribución de usuarios por `country` y `locale`. Informa estrategia de expansión LatAm. |

### Tratamiento de operaciones canceladas en el DWH

Las operaciones canceladas tienen un tratamiento específico en cada capa del stack analítico:

**Capa raw (BigQuery — tabla de hechos):**
Todas las operaciones se replican en BigQuery, incluyendo las canceladas. La tabla raw contiene el historial completo sin filtros — es la fuente de verdad para auditoría.

**Capa staging (dbt):**
Los modelos de staging exponen todas las operaciones con su `operation_status`. Nunca filtran — solo limpian y tipan los datos.

**Capa marts (dbt — modelos analíticos):**
Aquí es donde se aplica el filtro. Todos los modelos analíticos de negocio (volumen operado, activos más populares, retención por comportamiento de trading) filtran por `operation_status = 'active'`.

```sql
-- Ejemplo en dbt: model marts/operations_active.sql
select * from {{ ref('stg_operations') }}
where operation_status = 'active'
```

**Modelo de rentabilidad TWR:**
Usa exclusivamente `operation_status = 'active'`. Las operaciones canceladas no afectan al cálculo de rentabilidad — el par original+inversa se anula exactamente y nunca debería llegar al modelo TWR, pero el filtro por status es la salvaguarda.

**Métricas de producto afectadas:**
- `operations_added` en `app_usage` cuenta inserciones brutas (incluye cancelaciones) — refleja actividad real del usuario
- Las métricas de negocio (volumen, diversificación) solo cuentan operaciones activas

---

### Stack tecnológico

| Componente | Tecnología | Coste inicial |
|---|---|---|
| DWH | BigQuery (Google Cloud) | Gratis hasta 10GB + 1TB queries/mes |
| Transformaciones | dbt Core (open source) | Gratis |
| Ingesta | Supabase Edge Functions → BigQuery API | Incluido en Supabase |
| Visualización | Looker Studio (conexión nativa BigQuery) | Gratis |
| Visualización avanzada | Looker (cuando haya escala) | De pago |

---

## 30. Agentes de IA — Estrategia de integración

### Principio general

Los agentes de IA son herramientas que ejecutan tareas específicas definidas por el equipo. El código sigue siendo nuestro, en nuestro repositorio, auditable en todo momento. Un agente no "toma el control" — ejecuta instrucciones acotadas en respuesta a eventos o peticiones del usuario.

El riesgo real no es pérdida de control sino **complejidad añadida**: más superficie de error, más dependencias externas. Para una app financiera, cada caso de uso debe justificar ese coste.

**Regla fundamental:** ningún agente modifica datos financieros del usuario sin confirmación explícita previa. Los agentes leen, analizan y sugieren — el usuario decide y confirma.

---

### Casos de uso por fase

#### Casos aprobados — lectura y análisis (bajo riesgo)

| Caso de uso | Descripción | Fase |
|---|---|---|
| Actualización de cotizaciones | Agente que consulta APIs de mercado y actualiza precios periódicamente | Prototipo 2 |
| Generación de alertas inteligentes | Analiza datos de cartera y redacta avisos contextualizados (ej. "VWCE ha caído un 5% esta semana") | Prototipo 2 |
| Asistente de análisis de cartera | Responde preguntas en lenguaje natural sobre los datos del usuario ("¿cuál es mi activo más rentable?") | Producción |
| Resumen de rendimiento periódico | Genera un informe semanal/mensual en texto natural con los movimientos del período | Producción |

#### Casos aprobados — escritura con confirmación explícita (riesgo medio)

| Caso de uso | Descripción | Fase |
|---|---|---|
| Importación de PDF de broker | Extrae operaciones de un extracto PDF y las presenta al usuario para que confirme antes de guardar | Producción |
| Sugerencias de DCA | Calcula y sugiere la próxima aportación según el plan del usuario — el usuario confirma | Producción |

#### Casos excluidos permanentemente

| Caso de uso | Motivo |
|---|---|
| Gestión autónoma de operaciones o datos financieros | Nunca sin confirmación explícita del usuario |
| Decisiones o recomendaciones de inversión | Fuera del alcance legal (CNMV) y ético de la app |
| Acceso a datos financieros de terceros sin consentimiento | Incompatible con el argumento de privacidad de portapp |

---

### Arquitectura técnica

Los agentes se construyen sobre la **Claude API con tool use** (Anthropic SDK). Es el enfoque más fiable para Claude y mantiene el stack homogéneo.

**Patrón básico:**
```
Evento / petición del usuario
    → Agente (Claude API + tools definidas)
        → Tool: consulta BD / API externa / análisis
            → Resultado → Claude genera respuesta
                → App muestra resultado al usuario
```

**Frameworks evaluados:**

| Framework | Valoración para portapp |
|---|---|
| **Claude API + tool use** (Anthropic) | ✅ Recomendado — nativo, fiable, auditable |
| **CrewAI** | Interesante para multi-agente (ej. agente de datos + agente de redacción de alertas), evaluar en producción |
| **LangGraph** | Más control del flujo, útil si los workflows se complican |
| **AutoGen** (Microsoft) | Descartado — stack distinto, sin ventaja clara |

---

### Control y auditoría

Para mantener el control total:

- Todo el código de los agentes vive en el repositorio de portapp — no en plataformas externas
- Cada tool que puede modificar datos requiere un paso de confirmación en la UI
- Los agentes se ejecutan en Supabase Edge Functions (infraestructura ya planificada) — no en servidores de terceros
- Logs de todas las acciones de agentes en BigQuery para auditoría
- Posibilidad de desactivar cualquier agente desde Ajustes sin afectar al resto de la app

---

## 31. Especificación — Exportación Excel

> Spec en construcción. Se irá ampliando export a export.

### Export 1: Cartera

**Estructura del archivo:**
- **Tab 1 — Global:** tabla resumen con una fila por cartera (valoración, invertido, P/L, % rentabilidad)
- **Tab 2..N — [Nombre cartera]:** detalle de activos de cada cartera
- Orden: Global primero, carteras a continuación

**Cabecera de cada tab de cartera:**
- Nombre de la cartera + fecha de generación del report

**Columnas de la tabla de activos:**
`Bolsa | Proveedor | Nombre | ISIN | Ticker | WKN | Divisa | Cantidad | Precio medio | Valoración actual`

- **Proveedor:** vacío para acciones; emisor del producto para ETFs/fondos (ej. iShares, Vanguard, Amundi)
- **WKN:** incluir si el activo lo tiene registrado; vacío en caso contrario

**Gráficos por tab de cartera:**
- Donut de distribución por grupos (imagen PNG generada desde Chart.js via `toBase64Image()`)
- Donut/barras de exposición por región y divisa (imagen PNG)
- Layout: tabla de activos a la izquierda, gráficos a la derecha; tabla de datos del gráfico debajo de cada imagen

**Implementación:**
- Librería: SheetJS (xlsx) para estructura + imágenes incrustadas
- Gráficos como PNG (no gráficos nativos Excel) — editables en producción futura

---

### Export 2: Diario de operaciones

**Filtro de fechas:**
- Modal previo a la descarga con fecha_desde y fecha_hasta
- Rango por defecto: 1 del mes en curso → hoy

**Una sola hoja.** Todas las carteras mezcladas, columna "Cartera" para distinguir.

**Columnas:**
`Fecha | Fecha original | Cartera | Ticker | Nombre | ISIN | Tipo | Cantidad | Precio | Importe bruto | Comisión | Importe neto | Divisa | Broker | Grupo | Estado | Nota`

**Reglas:**
- Ordenado cronológicamente por **Fecha** (ascendente)
- Operaciones activas: **Fecha** = fecha de la operación; **Fecha original** = vacío; **Estado** = Activa
- Operaciones canceladas: **Fecha** = fecha de cancelación; **Fecha original** = fecha de la operación inicial; **Estado** = Cancelada
- El filtro de fechas aplica sobre **Fecha** en ambos casos

---

### Export 3: Resumen de posiciones

**Foto del estado actual** de cada posición — sin filtro de fechas (siempre es snapshot del momento de descarga).

**Una sola hoja.** Una fila por ticker por cartera.

**Columnas:**
`Cartera | Ticker | Invertido | % sobre cartera | Valor actual | PyG | % PyG | % real de cartera`

- **% sobre cartera:** peso del ticker sobre el capital invertido total de la cartera
- **% real de cartera:** peso del ticker sobre el valor actual total de la cartera
- La diferencia entre ambos refleja el drift respecto a la asignación original

**Nota:** estos mismos datos serán visibles en la app mediante toggle "Vista rendimiento" en s-cartera (F15), solo en modo avanzado.

---

### Export 4: Datos de interés fiscal (PDF)

**Formato:** PDF — no Excel. Los certificados fiscales de brokers siempre son PDF; el formato refuerza el carácter formal y no editable del documento.

**Cuándo:** generado bajo demanda con selector de año fiscal (no limitado al año en curso).

**Contenido:**
- Plusvalías y minusvalías realizadas (posiciones vendidas en el año)
- Dividendos y rendimientos cobrados
- Retenciones aplicadas

**Columnas — Plusvalías/Minusvalías:**
`Ticker | Nombre | ISIN | Fecha compra | Precio compra | Fecha venta | Precio venta | Cantidad | Resultado`

**Columnas — Dividendos y retenciones:**
`Fecha | Ticker | Nombre | ISIN | Importe bruto | Retención | Importe neto`

**Disclaimer obligatorio** (primera página, texto destacado):
> *"AVISO IMPORTANTE: La información contenida en este documento tiene carácter meramente orientativo y ha sido generada exclusivamente a partir de los datos introducidos por el usuario en la aplicación. Portgrow no garantiza la exactitud, integridad o adecuación fiscal de los datos aquí reflejados. Este informe no sustituye en ningún caso la documentación oficial emitida por su entidad financiera o broker, la cual prevalecerá a todos los efectos ante la Agencia Tributaria. El usuario es el único responsable de contrastar esta información con los certificados fiscales oficiales antes de presentar su declaración del Impuesto sobre la Renta de las Personas Físicas (IRPF) u otras obligaciones tributarias aplicables."*

**Implementación:** jsPDF o `window.print()` con CSS `@media print`.

---

### Export 5: Movimientos de efectivo (Excel)

**Equivalente al diario de operaciones pero para efectivo.** Filtro de fechas con rango por defecto: 1 del mes en curso → hoy.

**Una sola hoja.** Una fila por movimiento.

**Columnas:**
`Fecha | Cartera | Broker / Cuenta | Tipo | Importe | Saldo acumulado | Nota`

- **Tipo:** Ingreso / Retirada / Dividendo / Comisión / Otro

---

### Export 6: Dividendos y rendimientos (Excel)

**Seguimiento de renta pasiva** por ticker y año. Sin filtro de fechas — selector de año.

**Una sola hoja**, ordenada por fecha.

**Columnas:**
`Fecha | Año | Cartera | Ticker | Nombre | ISIN | Tipo | Importe bruto | Retención | Importe neto | Divisa`

- **Tipo:** Dividendo / Cupón / Staking / Otro rendimiento
