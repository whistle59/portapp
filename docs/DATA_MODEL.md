# portapp — Modelo de datos

> Versión 1.0 · Cerrado 2026-04-24  
> Enfoque: Kimball para analytics + 3FN para datos operacionales  
> Plataforma: PostgreSQL en Supabase
> **Este documento es la especificación del modelo de datos de producción — no describe el estado actual del prototipo HTML v6, que usa datos hardcodeados en variables JS.**

---

## Diagrama entidad-relación

```mermaid
erDiagram

    users {
        uuid user_id PK
        string user_first_name
        string user_last_name
        string user_alias
        string user_main_email
        string user_secondary_email
        string user_mobile_number
        string user_pwd
        boolean email_verified
        string two_fa_method
        string plan
        string paddle_customer_id
        timestamp open_account_date
        timestamp close_account_date
    }

    subscription_plan {
        uuid subscription_plan_id PK
        string subscription_plan_name
        string subscription_plan_type
        decimal subscription_price
        timestamp valid_from
        timestamp valid_to
        boolean is_current
    }

    user_subscription {
        uuid user_subscription_id PK
        uuid user_id FK
        uuid subscription_plan_id FK
        timestamp start_date
        timestamp end_date
        string status
        string payment_ref
        string paddle_subscription_id
    }

    payments {
        uuid payment_id PK
        uuid user_id FK
        uuid user_subscription_id FK
        decimal amount
        string currency
        string payment_method
        string payment_status
        timestamp payment_date
        string payment_ref
    }

    app_usage {
        uuid usage_id PK
        uuid user_id FK
        date usage_date
        string platform
        int total_sessions
        int total_duration_min
        int screens_visited
        int operations_added
        timestamp last_active_at
    }

    portfolio {
        uuid portfolio_id PK
        string portfolio_name
        string portfolio_description
        string portfolio_main_currency
        string portfolio_colour
        timestamp portfolio_created_at
        timestamp portfolio_deleted_at
    }

    portfolio_members {
        uuid id PK
        uuid portfolio_id FK
        uuid user_id FK
        string role
        uuid invited_by FK
        timestamp joined_at
        string status
    }

    groups {
        uuid group_id PK
        uuid user_id FK
        string group_name
        string group_colour
        int group_order
        timestamp group_created_at
    }

    accounts {
        uuid account_id PK
        uuid user_id FK
        string account_name
        string account_type
        string account_iban
        string account_bic
        timestamp account_created_at
        timestamp account_deleted_at
    }

    assets {
        uuid asset_id PK
        uuid portfolio_id FK
        uuid group_id FK
        uuid account_id FK
        string asset_ticker
        string asset_name
        string asset_isin
        string asset_type
        string asset_exchange
        string asset_currency
        json asset_region_json
        decimal asset_qty
        decimal asset_avg_price
        decimal asset_last_price
        decimal asset_prev_price
        timestamp asset_price_date
        timestamp asset_created_at
        timestamp asset_deleted_at
    }

    operations {
        uuid operation_id PK
        uuid portfolio_id FK
        uuid asset_id FK
        uuid account_id FK
        string asset_ticker
        string operation_type
        date operation_date
        decimal operation_qty
        decimal operation_price
        decimal operation_fee
        string operation_currency
        string operation_note
        timestamp operation_created_at
    }

    cash {
        uuid cash_id PK
        uuid portfolio_id FK
        uuid account_id FK
        uuid operation_id FK
        string cash_type
        decimal cash_amount
        string cash_currency
        date cash_date
        string cash_origin
        string cash_note
        timestamp cash_created_at
    }

    stock_prices {
        uuid price_id PK
        uuid asset_id FK
        string price_ticker
        string price_exchange
        string price_currency
        decimal price_open
        decimal price_close
        decimal price_high
        decimal price_low
        int price_volume
        date price_date
        string price_source
        timestamp price_created_at
    }

    portfolio_snapshots {
        uuid snapshot_id PK
        uuid portfolio_id FK
        date snapshot_date
        decimal snapshot_total_value
        decimal snapshot_total_invested
        decimal snapshot_cash_balance
        string snapshot_currency
        timestamp snapshot_created_at
    }

    annotations {
        uuid annotation_id PK
        uuid user_id FK
        text annotation_text
        timestamp annotation_created_at
        timestamp annotation_updated_at
    }

    asset_notes {
        uuid asset_note_id PK
        uuid asset_id FK
        uuid user_id FK
        text asset_note_text
        timestamp asset_note_created_at
        timestamp asset_note_updated_at
    }

    notifications {
        uuid notification_id PK
        uuid user_id FK
        string notification_type
        string notification_title
        text notification_body
        boolean notification_read
        boolean notification_favourite
        timestamp notification_created_at
    }

    platforms {
        uuid platform_id PK
        uuid user_id FK
        string platform_name
        string platform_url
        string platform_icon
        int platform_order
        timestamp platform_created_at
    }

    exchange_rates {
        uuid rate_id PK
        string rate_currency_from
        string rate_currency_to
        decimal rate_value
        date rate_date
        string rate_source
        timestamp rate_created_at
    }

    %% Sistema
    users ||--o{ user_subscription : "contrata"
    users ||--o{ payments : "realiza"
    users ||--o{ app_usage : "genera"
    subscription_plan ||--o{ user_subscription : "define"
    user_subscription ||--o{ payments : "origina"

    %% Carteras y acceso
    users ||--o{ portfolio_members : "pertenece a"
    portfolio ||--o{ portfolio_members : "tiene"
    users ||--o{ groups : "define"
    users ||--o{ accounts : "tiene"

    %% Datos financieros
    portfolio ||--o{ assets : "contiene"
    portfolio ||--o{ operations : "registra"
    portfolio ||--o{ cash : "controla"
    portfolio ||--o{ portfolio_snapshots : "acumula"
    groups ||--o{ assets : "categoriza"
    accounts ||--o{ assets : "custodia"
    accounts ||--o{ operations : "ejecuta"
    accounts ||--o{ cash : "gestiona"
    assets ||--o{ operations : "tiene"
    assets ||--o{ stock_prices : "tiene"
    assets ||--o{ asset_notes : "tiene"
    operations ||--o{ cash : "genera"

    %% Usuario
    users ||--o{ annotations : "escribe"
    users ||--o{ notifications : "recibe"
    users ||--o{ platforms : "configura"
```

---

## Resumen de tablas

| Tabla | Tipo | Descripción |
|---|---|---|
| `users` | Dimensión | Usuarios de la app |
| `subscription_plan` | Dimensión SCD2 | Planes con historial de precios |
| `user_subscription` | Dimensión | Suscripciones activas por usuario |
| `payments` | Fact | Historial inmutable de pagos |
| `app_usage` | Fact (snapshot diaria) | Uso de la app por usuario y día |
| `portfolio` | Dimensión | Carteras de inversión |
| `portfolio_members` | Relación N:M | Usuarios con acceso a cada cartera (owner/editor/viewer) |
| `groups` | Dimensión | Grupos de activos definidos por el usuario |
| `accounts` | Dimensión | Brokers y cuentas bancarias |
| `assets` | Dimensión | Posiciones abiertas (estado cacheado) |
| `operations` | Fact (inmutable) | Log de compras, ventas, dividendos, staking |
| `cash` | Fact | Movimientos de efectivo |
| `stock_prices` | Fact (histórico) | Precios históricos de cotización |
| `portfolio_snapshots` | Fact (snapshot diaria) | Valor diario de cartera para TWR y gráficos |
| `annotations` | Entidad | Anotaciones globales del usuario |
| `asset_notes` | Entidad | Notas por activo |
| `notifications` | Entidad | Alertas y avisos |
| `platforms` | Entidad | Accesos directos a plataformas externas |
| `exchange_rates` | Fact (histórico) | Tipos de cambio |

---

## Reglas de integridad referencial

| Entidad | Regla ante borrado |
|---|---|
| `portfolio` | Soft delete — bloquear si tiene assets u operations |
| `assets` | Soft delete — bloquear si tiene operations |
| `accounts` | Soft delete — bloquear si tiene operations o cash |
| `groups` | SET NULL en assets.group_id — no bloquear |
| `operations` | Nunca se borra — solo se anula con operación inversa |
| `annotations` / `asset_notes` | Borrado físico |

---

## Notas de diseño

- **`operations` es inmutable** — no hay UPDATE. Los errores se corrigen con una operación inversa.
- **`assets.asset_qty` y `assets.asset_avg_price` son caches** — se recalculan desde `operations`. La fuente de verdad es siempre `operations`.
- **`assets.asset_last_price` y `assets.asset_prev_price`** son caches de `stock_prices` para evitar joins en cada render.
- **`stock_prices.asset_id` es nullable** — permite precargar precios históricos antes de que el usuario añada el activo a su cartera.
- **`portfolio_members`** gestiona la propiedad y permisos. Siempre existe exactamente un `owner` por cartera.
- **Nunca se guardan datos de tarjeta** — Paddle actúa como Merchant of Record. Solo se almacena `paddle_customer_id` y `paddle_subscription_id`.
