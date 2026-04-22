# portapp — Estado del proyecto

> Última actualización: prototipo v6 — Bloques 3–8 completados · Arquitectura local-first en evaluación  
> Credenciales demo: `usuario@portapp.com` / `demo1234` / 2FA: `123456`

---

## 1. Decisiones de arquitectura

| Decisión | Valor | Notas |
|---|---|---|
| Fase actual | Prototipo HTML v6 | Sin servidor, un solo archivo. Ver sección 2. |
| Stack producción | **En evaluación** — ver sección 20 | Dos opciones: cliente-servidor (Next.js) vs local-first (React Native + SQLite) |
| Auth | Email + contraseña + 2FA (email o SMS) | Biometría WebAuthn en v2 |
| Divisas | Multi-divisa (EUR, USD y otras) | Tipos de cambio manuales en prototipo, automáticos en producción |
| Offline / cloud | **Local-first preferido** — ver sección 20 | Datos en dispositivo + sync opcional en nube |
| Plataforma | **React Native + Expo** si se confirma local-first | iOS + Android + web desde una base de código |
| Nombre comercial | Pendiente de decidir | Nombre interno: portapp |
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

---

## 5. Pendientes — producción

| # | Descripción |
|---|---|
| PR1 | API cotizaciones tiempo real (Yahoo Finance / Alpha Vantage / ProRealTime) |
| PR2 | Autenticación biométrica WebAuthn (gratuita) |
| PR3 | Backend con base de datos persistente |
| PR4 | Exportación real Excel/CSV |
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

## 20. Arquitectura local-first — evaluación y plan

### Qué es local-first

Local-first es un modelo de arquitectura donde los datos del usuario viven primariamente en su dispositivo (SQLite local) y se sincronizan opcionalmente con la nube. La fuente de verdad es el dispositivo, no el servidor.

Apps consolidadas con este modelo: **Linear**, **Obsidian**, **Bear**, **Anytype**, **Capacitor**. Es una tendencia creciente precisamente por la privacidad y la fiabilidad offline.

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
| Sync | Electric SQL o PowerSync | Sincroniza SQLite local ↔ PostgreSQL en nube |
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
| Complejidad del sync | Electric SQL / PowerSync abstraen la complejidad — no hay que implementar CRDTs a mano |

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
Expo SQLite (bd local)
PowerSync o Electric SQL (sync)
Supabase (auth + PostgreSQL para sync)
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
