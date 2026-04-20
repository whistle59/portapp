# portapp — Estado del proyecto

> Última actualización: prototipo v3  
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
| F3 | Módulo de anotaciones global (accesible desde cualquier nivel) |
| F4 | Perfil de usuario y gestión de sesión |
| F5 | Rentabilidad del efectivo en período determinado |
| F6 | Proyección DCA con arrastre automático de saldos anuales entre años |
| F7 | Conexión con broker: formulario de credenciales que lanza sesión en URL del broker |
| F8 | Upload de PDF del broker: lectura e importación automática de movimientos |
| F9 | Gestión de cuentas bancarias y cuentas broker en Ajustes (IBAN, BIC, titular) |
| F10 | Grupos de activos: CRUD completo + drag & drop para reordenar |
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

### Estrategia recomendada: Pago único + Marketplace de contenido + Plan profesional B2B

---

### Tier 1 — Plan gratuito (adquisición)
Objetivo: eliminar fricción de entrada y generar base de usuarios.

| Funcionalidad | Incluida |
|---|---|
| 1 cartera | ✅ |
| Hasta 20 operaciones | ✅ |
| Resumen y gráficos básicos | ✅ |
| Proyección DCA | ✅ |
| Acceso a canales de YouTube curados | ✅ |
| Exportación de datos | ❌ |
| Carteras ilimitadas | ❌ |
| Historial completo | ❌ |
| Alertas avanzadas | ❌ |
| Compartir cartera | ❌ |

---

### Tier 2 — Plan personal (pago único)
Objetivo: ingresos sin fricción de suscripción. Precio orientativo: **29-49€** pago único.

| Funcionalidad | Incluida |
|---|---|
| Carteras ilimitadas | ✅ |
| Operaciones ilimitadas | ✅ |
| Historial completo con todos los períodos | ✅ |
| Exportación Excel / CSV | ✅ |
| Importación PDF de broker | ✅ |
| Alertas configurables | ✅ |
| Compartir cartera (enlace público) | ✅ |
| Acceso a futuras actualizaciones (1 año) | ✅ |

> Nota: el modelo de pago único está volviendo con fuerza — usuarios hartos de suscripciones lo valoran mucho y la tasa de conversión es mayor.

---

### Tier 3 — Plan profesional B2B
Objetivo: asesores financieros, family offices, gestores que necesitan gestionar carteras de varios clientes. Precio orientativo: **50-150€/mes por usuario profesional**.

| Funcionalidad | Incluida |
|---|---|
| Todo el Plan personal | ✅ |
| Gestión de múltiples clientes | ✅ |
| Vistas consolidadas entre clientes | ✅ |
| Informes personalizados exportables | ✅ |
| Acceso API para integración con otras herramientas | ✅ |
| Soporte prioritario | ✅ |
| Marca blanca (white label) opcional | 🔜 v2 |

> Nota: el ticket B2B es 10-20x mayor que el individual. Con pocos clientes profesionales la app ya es rentable.

---

### Marketplace de contenido (ingresos recurrentes transversales)
Aplicable a todos los tiers, incluyendo el gratuito.

| Canal de ingreso | Descripción |
|---|---|
| Canales YouTube destacados | Acuerdo directo con creadores (fee fijo mensual o por clics demostrados con estadísticas) |
| Canal "patrocinado" con badge | Mayor visibilidad en la lista, precio premium |
| Cursos y formación | Links a cursos de los creadores con posible comisión de afiliado |
| Herramientas de terceros | Integración destacada de brokers, robo-advisors o herramientas de análisis con acuerdo comercial |

---

### Hoja de ruta de monetización sugerida

| Fase | Acción |
|---|---|
| Lanzamiento | Solo plan gratuito + pago único personal. Sin B2B todavía. |
| 3-6 meses | Activar marketplace de contenido con primeros acuerdos de canales YouTube |
| 6-12 meses | Lanzar plan profesional B2B con primeros asesores beta |
| 12+ meses | White label, API pública, expansión de marketplace |



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

