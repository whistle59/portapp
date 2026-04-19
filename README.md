# portapp

Gestor personal de carteras de activos financieros. Prototipo interactivo construido con Claude.

## Estado actual
> **Fase: Prototipo UI** — diseño y flujos validados, pendiente de conectar backend y APIs reales.

## Funcionalidades prototipadas

### Autenticación
- Login con email + contraseña
- Verificación en dos pasos (2FA) por email o SMS
- Recuperación de contraseña
- Bloqueo automático tras 3 intentos fallidos

### Multicartera
- Vista global consolidada de todas las carteras
- Creación y gestión de múltiples carteras independientes
- Selector de cartera activa accesible desde cualquier pantalla

### Cartera
- Registro de activos: acciones, ETFs, criptomonedas, bonos, fondos
- Ficha completa por activo: ticker, ISIN, nombre, índice, divisa, mercado
- Exposición porcentual por región y por divisa
- Agrupación por categorías personalizables (Core, Cripto, AI/Tech, Renta fija, etc.)

### Efectivo
- Registro de ingresos: transferencia, Bizum, dividendo, staking, interés, saveback
- Registro de egresos: compra de activos, comisiones, transferencias salida
- Saldo por broker con soporte multi-divisa

### Operaciones
- Registro completo: compra, venta, dividendo, staking, interés, saveback
- Detalle completo por activo con historial de operaciones
- Anotaciones a nivel de activo, broker, grupo o cartera

### Proyección DCA
- Calculadora con aportación periódica (semanal / quincenal / mensual)
- Revalorización anual estimada configurable
- Gráfico y tabla de evolución anual con arrastre de saldos

### Índices
- Listado de índices seguidos por los activos de la cartera
- Métricas principales: YTD, 12m, PER, dividendo, número de valores

### Ajustes
- Divisas activas y divisa base
- Brokers conectados (Interactive Brokers, DEGIRO, Coinbase, ProRealTime)
- Grupos de activos personalizables
- Exportación a Excel / CSV, importación, backup
- Preferencias de interfaz

## Stack previsto para producción

| Capa | Tecnología sugerida |
|------|-------------------|
| Frontend | React + Tailwind CSS |
| Backend | Node.js + Express o Next.js API routes |
| Base de datos | PostgreSQL o SQLite (local-first) |
| Autenticación | Auth.js / Supabase Auth |
| 2FA SMS | Twilio (~0,05€/SMS) |
| 2FA Email | Resend o SendGrid (gratuito hasta 100/día) |
| Cotizaciones | Yahoo Finance API / Alpha Vantage / ProRealTime |
| Biometría (futuro) | WebAuthn — Face ID / Android Biometrics (gratuito) |

## Estructura del proyecto

```
portapp/
├── src/
│   ├── screens/         # Pantallas principales de la app
│   ├── components/      # Componentes reutilizables
│   ├── data/            # Datos de ejemplo y estructuras
│   └── auth/            # Flujo de autenticación y 2FA
├── prototype/           # Prototipos HTML interactivos (generados con Claude)
└── docs/                # Documentación y especificaciones
```

## Cómo usar el prototipo

Abre cualquier archivo `.html` de la carpeta `prototype/` directamente en el navegador. No requiere servidor ni dependencias.

## Roadmap

- [x] Prototipo UI multicartera
- [x] Flujo de autenticación con 2FA
- [ ] Conectar APIs de cotizaciones en tiempo real
- [ ] Backend con base de datos persistente
- [ ] Autenticación biométrica (WebAuthn)
- [ ] App móvil nativa (React Native)
- [ ] Exportación fiscal automática

## Licencia
Privado — todos los derechos reservados.
