# portapp — Estado del proyecto

> Última actualización: prototipo v6 — Bloques 3–6 completados  
> Credenciales demo: `usuario@portapp.com` / `demo1234` / 2FA: `123456`

---

## 1. Decisiones de arquitectura

| Decisión | Valor | Notas |
|---|---|---|
| Fase actual | Prototipo HTML | Sin servidor, un solo archivo |
| Stack producción (propuesto) | React + Tailwind, Next.js, PostgreSQL | Pendiente de confirmar |
| Auth | Email + contraseña + 2FA (email o SMS) | Biometría WebAuthn en v2 |
| Divisas | Multi-divisa (EUR, USD y otras) | Tipos de cambio manuales por ahora |
| Offline / cloud | Pendiente de decidir | — |
| Plataforma | Pendiente de decidir | Web, iOS, Android o las tres |
| Nombre comercial | Pendiente de decidir | Nombre interno: portapp |

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

## 3. Pendientes — próxima iteración

| # | Descripción |
|---|---|
| P1 | Modo oscuro: aumentar contraste de textos secundarios (`--t1`, `--t2`) |
| P2 | Tamaño de fuente configurable en Ajustes (Pequeño / Normal / Grande / Muy grande) |
| P3 | Nueva operación: desplegable con activos de la cartera seleccionada + opción "nuevo activo" |
| P4 | Notificaciones: botón borrar + marcar como favorita ⭐ |
| P5 | Exposición por Región/Divisa: recalcular al usar filtros de tipo de activo |

---

## 4. Pendientes — funcionalidades nuevas

| # | Descripción |
|---|---|
| F1 | Pantalla de rentabilidad real por activo y por período (TWR) |
| F2 | Cuadro de capital por grupos con porcentajes sobre el total |
| F3 | ~~Módulo de anotaciones global (accesible desde cualquier nivel)~~ ✅ v5 |
| F4 | Perfil de usuario y gestión de sesión |
| F5 | Rentabilidad del efectivo en período determinado |
| F6 | Proyección DCA con arrastre automático de saldos anuales entre años |
| F7 | Conexión con broker: formulario de credenciales que lanza sesión en URL del broker |
| F8 | Upload de PDF del broker: lectura e importación automática de movimientos |
| F9 | ~~Gestión de cuentas bancarias y cuentas broker en Ajustes (IBAN, BIC, titular)~~ ✅ v5 |
| F10 | ~~Grupos de activos: CRUD completo + drag & drop para reordenar~~ ✅ v5 |
| F11 | Compartir cartera: enlace público (permanente o 3h), solo lectura, opción solo porcentajes |

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

## Actualizaciones puntuales

### Pendientes — próxima iteración (añadidos)
- **P6** — Campos de contraseña: añadir toggle 👁 "mostrar/ocultar" en login, lock screen y cualquier formulario con contraseña. El campo siempre arranca en modo oculto (`type="password"`).

### Seguridad — Capa 5 Frontend (añadido)
- **Contraseñas nunca en texto plano** — todos los campos de contraseña usan `type="password"` por defecto. El usuario puede revelarlos explícitamente con un toggle 👁. Nunca autocompletar con `autocomplete="new-password"` en formularios de cambio de contraseña.



---

### Monetización — Links a canales de YouTube (añadido)

**Concepto:** sección de contenido curado dentro de la app con links directos a canales de YouTube de finanzas e inversión. Los canales solo pueden añadirse, editarse o eliminarse desde el panel de administración, garantizando control editorial y permitiendo acuerdos comerciales con creadores.

**Pendientes — funcionalidad (F12):**
- Pantalla "Aprende" o "Canales" en la app con lista de canales recomendados
- Cada canal muestra: nombre, avatar, descripción breve, categoría (ETFs, cripto, value investing, opciones, etc.) y link directo a YouTube
- Posibilidad de marcar canales como favoritos
- Filtro por categoría

**Pendientes — panel admin (A12):**
- CRUD completo de canales: añadir, editar, desactivar, eliminar
- Campos por canal: nombre, URL de YouTube, descripción, categoría, imagen/avatar, orden de aparición, activo/inactivo
- Estadísticas de clics por canal (para demostrar valor a los creadores en acuerdos comerciales)
- Posibilidad de marcar un canal como "destacado" (aparece primero o con badge especial)

**Modelo de monetización sugerido:**
- Acuerdo directo con el creador (fee fijo mensual o por clics)
- Canal "destacado" con mayor visibilidad como producto premium
- Posible integración futura con programa de afiliados de YouTube o cursos del creador



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
