# portapp — Especificación de requisitos

## Visión general
Gestor personal multicartera de activos financieros. Orientado a inversores particulares
que operan con varios brokers y necesitan una visión consolidada de todas sus posiciones,
movimientos de efectivo, proyecciones y rendimiento real.

---

## Módulos funcionales

### 1. Autenticación y seguridad
- Login con email + contraseña
- Verificación en dos pasos (2FA) por email o SMS
- Bloqueo automático tras 3 intentos fallidos (15 min)
- Recuperación de contraseña por email
- Preparado para biometría WebAuthn (Face ID / Android) en v2

### 2. Multicartera
- Creación ilimitada de carteras independientes
- Cada cartera tiene: nombre, descripción, divisa base, color identificador
- Vista global consolidada con métricas de todas las carteras
- Selector de cartera activa persistente en toda la app

### 3. Registro de activos
Campos por activo:
- Ticker, ISIN, nombre completo del producto
- Tipo: Acción | ETF | Cripto | Bono | Fondo | Otro
- Índice que sigue (si aplica) — introducido automáticamente por la app a partir del ticker/ISIN
- Divisa de negociación
- Mercado donde se negocia
- Exposición porcentual por divisa y por región/país
- Broker donde está custodiado
- Grupo de clasificación (personalizable)
- Cotización actual — integración con API externa (ProRealTime, Yahoo Finance, etc.)

### 4. Operaciones
Tipos de operación soportados:
- Compra / Venta de activos
- Dividendo
- Staking
- Interés por saldo en cuenta
- Saveback por compra con tarjeta del broker
- Otros rendimientos

Campos por operación:
- Fecha, ticker, tipo de activo, broker, tipo de operación
- Cantidad, precio unitario, comisión, divisa
- Grupo asignado
- Nota libre

### 5. Efectivo
- Registro de ingresos: transferencia, Bizum, dividendo, staking, interés, saveback
- Registro de egresos: compra activo, comisión, transferencia salida, otro
- Saldo por broker con soporte multi-divisa
- Conversión automática a divisa base

### 6. Proyección DCA
- Aportación periódica configurable: semanal / quincenal / mensual
- Revalorización anual estimada
- Horizonte temporal hasta 40 años
- Arrastre automático de saldos de un año al siguiente
- Tabla anual de evolución + gráfico de línea

### 7. Rentabilidad real
- Cálculo de rentabilidad por activo en período determinado
- Rentabilidad del efectivo (intereses, saveback, etc.)
- TWR (Time-Weighted Return) para comparar con benchmarks
- Rentabilidad consolidada por cartera y global

### 8. Cuadro de cartera por grupos
Agrupaciones predefinidas y personalizables:
- Core, Cripto, AI/Tech, Renta variable, Renta fija, Legacy, Core ampliado
- Capital invertido por grupo
- Porcentaje sobre el total

### 9. Índices seguidos
- Listado automático de índices a los que están expuestos los activos
- Métricas: YTD, 12 meses, PER, dividendo, número de valores
- Actualización online en tiempo real (v2)

### 10. Anotaciones
- Anotaciones globales del usuario (pantalla dedicada `s-anotaciones`)
- Notas por activo individual (accesibles desde el detalle del activo)
- No interfieren con el flujo ni la navegación

### 13. Rentabilidad efectivo (`s-rent-efectivo`)
- Rentabilidad calculada sobre los movimientos de efectivo

### 14. Perfil (`s-perfil`)
- Datos del usuario, gestión de cuenta

### 15. Canales / Aprende (`s-canales`)
- Canales de contenido curados para formación inversora

### 16. Ayuda / FAQ (`s-ayuda`)
- Preguntas frecuentes, guía de uso, información sobre el cálculo de precio medio

### 11. Detalle de activo
Pantalla individual por activo con:
- Broker, fecha de compra, ticker, divisa
- Cantidad comprada/vendida, comisión, coste total
- Precio medio ponderado
- Cotización actual (API)
- Historial completo de operaciones
- Anotaciones propias
- Conexión con todos los totales de la app

### 12. Ajustes
- Divisas activas y divisa base de conversión
- Conexión con brokers y plataformas externas
- Grupos de activos: crear, editar, eliminar
- Preferencias de interfaz: modo oscuro, decimales, formato de fecha
- Exportación: Excel, CSV
- Importación de datos
- Backup y restauración
- Gestión de conexiones API

---

## Navegación
- Menú inferior estilo móvil (8 secciones principales)
- Acceso rápido cross-screen desde cada pantalla
- Selector de cartera siempre visible en la barra superior
- Botón de acceso directo a vista global

---

## Requisitos técnicos (producción)

### APIs externas necesarias
| Servicio | Uso | Coste estimado |
|----------|-----|----------------|
| Yahoo Finance / Alpha Vantage | Cotizaciones en tiempo real | Gratis (limitado) / ~50€/mes |
| ProRealTime | Cotizaciones profesionales | ~30€/mes |
| Twilio | SMS para 2FA | ~0,05€/SMS |
| Resend / SendGrid | Email para 2FA y notificaciones | Gratis hasta 100/día |
| ECB / Fixer.io | Tipos de cambio | Gratis / ~10€/mes |

### Seguridad
- Contraseñas hasheadas con bcrypt (salt rounds ≥ 12)
- Tokens JWT con expiración corta + refresh token
- 2FA obligatorio en primer acceso desde dispositivo nuevo
- Cifrado de datos sensibles en base de datos
- HTTPS obligatorio
- Rate limiting en endpoints de autenticación

### Offline / local-first (recomendado)
- Datos almacenados localmente (SQLite o IndexedDB)
- Sincronización opcional con backend remoto
- La app funciona sin conexión; las cotizaciones requieren internet

---

## Versiones planificadas

| Versión | Contenido |
|---------|-----------|
| v6 (HTML) | Prototipo UI completo — 17 pantallas, modo básico/avanzado, proyecciones DCA (actual) |
| Prototipo 2 | Validación arquitectura local-first: React Native + WatermelonDB + Supabase |
| v1.0 | App funcional con datos reales, sin APIs externas |
| v1.5 | Integración cotizaciones en tiempo real |
| v2.0 | Autenticación biométrica WebAuthn, funcionalidades avanzadas |
