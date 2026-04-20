#!/bin/bash
REPO="whistle59/portapp"

echo "Creando labels..."
gh label create "bug" --color "#d73a4a" --description "Corrección de errores" --repo $REPO 2>/dev/null
gh label create "enhancement" --color "#a2eeef" --description "Nueva funcionalidad" --repo $REPO 2>/dev/null
gh label create "security" --color "#e4e669" --description "Seguridad" --repo $REPO 2>/dev/null
gh label create "infra" --color "#0075ca" --description "Infraestructura y producción" --repo $REPO 2>/dev/null
gh label create "backlog" --color "#cfd3d7" --description "Versiones futuras" --repo $REPO 2>/dev/null
gh label create "admin" --color "#7057ff" --description "Panel de administración" --repo $REPO 2>/dev/null
gh label create "multiplatform" --color "#008672" --description "Multiplataforma" --repo $REPO 2>/dev/null
gh label create "monetization" --color "#f9d0c4" --description "Monetización" --repo $REPO 2>/dev/null

echo "Creando issues — Próxima iteración..."
gh issue create --repo $REPO --title "P1 — Modo oscuro: mayor contraste en textos secundarios" --label "bug" --body "Aumentar contraste de --t1 y --t2 en modo oscuro para mejorar legibilidad."
gh issue create --repo $REPO --title "P2 — Tamaño de fuente configurable" --label "enhancement" --body "Selector en Ajustes > Interfaz con opciones: Pequeño / Normal / Grande / Muy grande. Implementar via CSS variable --fs."
gh issue create --repo $REPO --title "P3 — Nueva operación: desplegable de activos de la cartera" --label "enhancement" --body "Al registrar una operación, mostrar desplegable con los activos existentes en la cartera seleccionada. Opción de añadir nuevo activo si no está en la lista."
gh issue create --repo $REPO --title "P4 — Notificaciones: borrar y marcar como favorita" --label "enhancement" --body "Añadir botón ✕ para borrar cada notificación y botón ⭐ para marcarla como favorita."
gh issue create --repo $REPO --title "P5 — Exposición por Región/Divisa: recalcular al filtrar" --label "bug" --body "Las barras de Exposición por Región y Exposición por Divisa en la pantalla Cartera deben recalcularse cuando se usa el filtro por tipo de activo (Acciones/ETFs/Cripto)."
gh issue create --repo $REPO --title "P6 — Toggle mostrar/ocultar contraseña en login y lock screen" --label "security" --body "Campos de contraseña siempre en type=password por defecto. Añadir botón 👁 para revelar temporalmente. Aplicar en login, lock screen y cualquier formulario con contraseña."

echo "Creando issues — Funcionalidades nuevas..."
gh issue create --repo $REPO --title "F1 — Pantalla de rentabilidad real por activo y por período (TWR)" --label "enhancement" --body "Calcular y mostrar la rentabilidad real ponderada por tiempo (Time-Weighted Return) por activo y por período seleccionable."
gh issue create --repo $REPO --title "F2 — Cuadro de capital por grupos con porcentajes" --label "enhancement" --body "Vista con el capital invertido por grupo de activos y su porcentaje sobre el total de la cartera."
gh issue create --repo $REPO --title "F3 — Módulo de anotaciones global" --label "enhancement" --body "Acceso a anotaciones desde cualquier nivel de la app (activo, broker, grupo, cartera, global) sin romper el flujo de navegación."
gh issue create --repo $REPO --title "F4 — Perfil de usuario y gestión de sesión" --label "enhancement" --body "Pantalla de perfil con datos del usuario, gestión de sesiones activas, cambio de contraseña y preferencias de notificación."
gh issue create --repo $REPO --title "F5 — Rentabilidad del efectivo en período determinado" --label "enhancement" --body "Mostrar la rentabilidad generada por el efectivo (dividendos, intereses, staking, saveback) en un período seleccionable."
gh issue create --repo $REPO --title "F6 — Proyección DCA con arrastre automático de saldos anuales" --label "enhancement" --body "En la calculadora de proyección, arrastrar automáticamente el saldo acumulado de un año al siguiente en la tabla anual."
gh issue create --repo $REPO --title "F7 — Conexión con broker: lanzar sesión desde la app" --label "enhancement" --body "Formulario de credenciales del broker que permite lanzar una sesión autenticada directamente en la URL del broker."
gh issue create --repo $REPO --title "F8 — Upload de PDF del broker: importación automática" --label "enhancement" --body "Subir el PDF de extracto del broker y que la app lea e importe automáticamente los movimientos a la cartera correspondiente."
gh issue create --repo $REPO --title "F9 — Gestión completa de cuentas bancarias y cuentas broker" --label "enhancement" --body "En Ajustes: CRUD completo de cuentas con campos IBAN, BIC, titular, número de cuenta en broker, URL de acceso, divisa principal."
gh issue create --repo $REPO --title "F10 — Grupos de activos: CRUD completo con drag & drop" --label "enhancement" --body "Crear, editar, eliminar y reordenar grupos de activos mediante drag & drop. Actualmente solo se pueden ver."
gh issue create --repo $REPO --title "F11 — Compartir cartera mediante enlace público" --label "enhancement" --body "Generar enlace público permanente o de 3h para compartir la cartera en modo solo lectura. Opción de mostrar solo porcentajes (sin importes)."
gh issue create --repo $REPO --title "F12 — Canales de YouTube curados (monetización)" --label "monetization" --body "Pantalla 'Canales' con lista de canales de YouTube de finanzas. Solo gestionables desde el panel admin. Incluye filtro por categoría, favoritos y estadísticas de clics para acuerdos comerciales."

echo "Creando issues — Producción..."
gh issue create --repo $REPO --title "PR1 — API de cotizaciones en tiempo real" --label "infra" --body "Integrar API de cotizaciones (Yahoo Finance / Alpha Vantage / ProRealTime) para actualizar precios automáticamente."
gh issue create --repo $REPO --title "PR2 — Autenticación biométrica WebAuthn" --label "security" --body "Implementar autenticación biométrica gratuita via WebAuthn / FIDO2. Sin almacenar datos biométricos en el servidor."
gh issue create --repo $REPO --title "PR3 — Backend con base de datos persistente" --label "infra" --body "Implementar backend real con base de datos (PostgreSQL recomendado). Stack sugerido: Next.js + Prisma + PostgreSQL."
gh issue create --repo $REPO --title "PR4 — Exportación real Excel/CSV" --label "infra" --body "Implementar exportación real de datos a Excel y CSV desde el backend."
gh issue create --repo $REPO --title "PR5 — Importación CSV desde brokers" --label "infra" --body "Parsear y importar archivos CSV exportados desde los principales brokers (DEGIRO, Interactive Brokers, etc.)."
gh issue create --repo $REPO --title "PR6 — Tipos de cambio automáticos" --label "infra" --body "Integrar API de tipos de cambio (ECB API gratuita o Fixer.io) para conversión automática entre divisas."
gh issue create --repo $REPO --title "PR7 — SMS 2FA con Twilio" --label "security" --body "Implementar 2FA por SMS usando Twilio (~0,05€/SMS). Alternativa al 2FA por email."
gh issue create --repo $REPO --title "PR8 — Email 2FA con Resend o SendGrid" --label "security" --body "Implementar 2FA por email usando Resend o SendGrid (gratuito hasta 100 emails/día)."
gh issue create --repo $REPO --title "PR9 — Bot de asistencia al usuario (API de Claude)" --label "enhancement" --body "Integrar chatbot de soporte usando la API de Claude para responder dudas sobre la app y conceptos de bolsa/ETFs/inversión."

echo "Creando issues — Seguridad..."
gh issue create --repo $REPO --title "SEC — TLS 1.3 y HSTS obligatorio" --label "security" --body "Todo el tráfico cifrado con TLS 1.3. Redirigir HTTP → HTTPS. Cabecera Strict-Transport-Security."
gh issue create --repo $REPO --title "SEC — Hashing de contraseñas con bcrypt/argon2" --label "security" --body "Nunca almacenar contraseñas en claro. Usar bcrypt o argon2 con salt."
gh issue create --repo $REPO --title "SEC — JWT con refresh token en HttpOnly cookie" --label "security" --body "Access token: 15 min. Refresh token: 7-30 días en cookie HttpOnly, no accesible desde JavaScript."
gh issue create --repo $REPO --title "SEC — Rate limiting en login y endpoints críticos" --label "security" --body "Máx. 5 intentos de login por IP en 15 min. Rate limiting diferenciado por endpoint según criticidad."
gh issue create --repo $REPO --title "SEC — Cifrado de campos sensibles en BD (AES-256)" --label "security" --body "Cifrar campos como IBAN, número de cuenta broker con AES-256. Cifrado en reposo para toda la base de datos."
gh issue create --repo $REPO --title "SEC — Cabeceras de seguridad HTTP (CSP, CORS, X-Frame)" --label "security" --body "Implementar Content-Security-Policy, X-Frame-Options, X-Content-Type-Options, Referrer-Policy. CORS restrictivo solo a orígenes conocidos."
gh issue create --repo $REPO --title "SEC — Aislamiento total entre usuarios" --label "security" --body "Cada endpoint verifica que el usuario autenticado es propietario del recurso. Un usuario nunca puede ver datos de otro aunque manipule IDs en la URL."

echo "Creando issues — Multiplataforma..."
gh issue create --repo $REPO --title "M1 — Definir estrategia multiplataforma" --label "multiplatform" --body "Decidir entre React Native (iOS + Android desde una base de código), PWA o web responsive pura antes de empezar el desarrollo de producción."
gh issue create --repo $REPO --title "M2 — Safe areas iOS y Android" --label "multiplatform" --body "Adaptar layout para notch, Dynamic Island, home indicator en iOS y barra de navegación en Android."
gh issue create --repo $REPO --title "M3 — Touch targets mínimos 44x44px" --label "multiplatform" --body "Todos los elementos interactivos deben cumplir el mínimo de 44x44px según Apple HIG y Material Design."
gh issue create --repo $REPO --title "M4 — Navegación adaptativa móvil/tablet/escritorio" --label "multiplatform" --body "Barra inferior en móvil, sidebar en tablet y escritorio. Layout responsivo desde iPhone SE (375px) hasta iPad Pro (1024px)."

echo "Creando issues — Panel Admin..."
gh issue create --repo $REPO --title "A1 — Panel de administración (backoffice)" --label "admin" --body "Panel web separado con autenticación independiente, 2FA obligatorio y acceso restringido por IP o VPN. Incluye: gestión de usuarios, visor de BD, logs de auditoría, gestión de sesiones, estadísticas globales, gestión de canales YouTube."

echo "Creando issues — Backlog v2+..."
gh issue create --repo $REPO --title "B1 — Comparativa rentabilidad vs índice benchmark" --label "backlog" --body "Comparar la rentabilidad de la cartera contra un índice de referencia (MSCI World, S&P 500, etc.)."
gh issue create --repo $REPO --title "B2 — Soporte para splits y dividendos en especie" --label "backlog" --body "Gestionar correctamente los splits de acciones y dividendos en especie con recálculo automático del precio medio."

echo ""
echo "✅ Todos los issues creados en $REPO"
