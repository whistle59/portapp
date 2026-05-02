# Supabase — Setup y referencia operacional

> Documento vivo. Actualizar cuando se ejecuten migraciones, se añadan proyectos o cambie la configuración.

---

## 1. Qué es Supabase y cómo encaja en Portgrow

Supabase es el backend de Portgrow. Proporciona:

| Servicio | Uso en Portgrow |
|---|---|
| **PostgreSQL** | Base de datos principal (modelo Kimball + 3NF) |
| **Auth** | Autenticación de usuarios (email/password + 2FA) |
| **RLS** (Row Level Security) | Cada usuario solo ve sus propios datos — se configura a nivel de BD |
| **Edge Functions** | Lógica de servidor (Deno/TypeScript) sin backend propio |
| **Realtime** | Subscripciones en tiempo real (para futuras notificaciones) |
| **Storage** | Almacenamiento de archivos (backups, avatares) |

**Local-first**: la app (React Native + WatermelonDB) trabaja offline y sincroniza contra Supabase cuando hay conexión.

---

## 2. Estructura de proyectos (entornos)

| Proyecto | Referencia | Uso |
|---|---|---|
| `portapp` (renombrar a `portgrow-dev`) | `fteanipvydeaflfegldn` | Desarrollo e integración |
| `portgrow-prod` (pendiente crear) | — | Producción |

**Organización**: `portapp` en Supabase (org ID: `mximnbarzokxksvdwqyh`).

El tier gratuito permite **2 proyectos por organización** — suficiente para dev + prod.

> **Pendiente**: Crear el proyecto `portgrow-prod` en el dashboard cuando estemos listos para producción. URL: https://supabase.com/dashboard/org/mximnbarzokxksvdwqyh/projects

---

## 3. Setup realizado (paso a paso)

### 3.1. Instalación de Scoop (gestor de paquetes Windows)

Scoop es el equivalente a `brew` en macOS. Se instaló para poder instalar la CLI de Supabase sin necesitar permisos de administrador.

```powershell
# Ejecutado en PowerShell como usuario normal (no admin)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Scoop se instala en `C:\Users\Admin\scoop\`.

**Nota**: En sesiones nuevas de PowerShell/bash, Scoop no siempre está en el PATH. Si un comando `scoop` o `supabase` no se encuentra, añadir manualmente:
```powershell
$env:PATH += ';' + $env:USERPROFILE + '\scoop\shims'
```

### 3.2. Instalación de Supabase CLI

```powershell
scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
scoop install supabase
```

Versión instalada: **v2.95.4**. Para actualizar en el futuro: `scoop update supabase`.

Verificar instalación:
```powershell
supabase --version
```

### 3.3. Autenticación

```powershell
supabase login --token <SUPABASE_ACCESS_TOKEN>
```

El token se genera en: https://supabase.com/dashboard/account/tokens

**Importante**: 
- Nunca pasar el token por `bash !` (el `$` se escapa mal). Usar siempre el PowerShell tool o el terminal directo.
- Si el token se expone accidentalmente, revocarlo inmediatamente en el dashboard y generar uno nuevo.
- El token se guarda en `C:\Users\Admin\.supabase\access-token` (archivo local, no en el repo).

### 3.4. Inicialización del repositorio

```powershell
cd C:\Users\Admin\Documents\portapp
supabase init
```

Crea:
- `supabase/config.toml` — configuración del proyecto local
- `supabase/.gitignore` — excluye `.temp/` del repo (contiene tokens y metadata local)

### 3.5. Linking al proyecto remoto

```powershell
supabase link --project-ref fteanipvydeaflfegldn
```

Esto conecta el directorio local con el proyecto `portapp` en Supabase Cloud. Los datos de la conexión se guardan en `supabase/.temp/` (que está en `.gitignore`).

---

## 4. Archivos importantes

### `supabase/config.toml`

Configuración del entorno local de desarrollo. Los valores relevantes:

```toml
project_id = "portapp"          # identificador local

[db]
major_version = 17              # PostgreSQL 17 (igual que el proyecto remoto)

[auth]
site_url = "http://127.0.0.1:3000"   # cambiar a URL real en producción
jwt_expiry = 3600               # tokens caducan en 1 hora
enable_signup = true
enable_anonymous_sign_ins = false

[auth.email]
enable_confirmations = false    # en dev no obliga a confirmar email
```

### `supabase/.gitignore`

Excluye `.temp/` — que contiene el project-ref, tokens temporales y versiones de servicios. **No commitear esto nunca**.

### `supabase/migrations/` (pendiente crear)

Aquí irán los archivos `.sql` de migración numerados:
```
supabase/migrations/
  20260502000000_initial_schema.sql
  20260510000000_add_user_consents.sql
  ...
```

---

## 5. Comandos de referencia

### Desarrollo local (requiere Docker — no disponible en este entorno)

```powershell
supabase start          # levanta Postgres + Auth + Studio localmente
supabase stop           # para el entorno local
supabase status         # URLs y claves del entorno local
```

> **Nota**: Docker Desktop no pudo instalarse en este equipo por restricciones de seguridad (el instalador exige que la carpeta de Docker Desktop sea propiedad de una cuenta elevada). **Decisión tomada**: trabajar directamente contra Supabase Cloud (portapp/portgrow-dev) en lugar de desarrollo local. Revisar si esto cambia cuando se migre a hardware distinto.

### Gestión de migraciones

```powershell
# Crear nueva migración (genera archivo vacío con timestamp)
supabase migration new nombre_de_la_migracion

# Aplicar migraciones al proyecto remoto (linked)
supabase db push

# Ver estado de migraciones
supabase migration list

# Generar migración desde diff entre local y remoto
supabase db diff --schema public
```

### Gestión de proyectos

```powershell
supabase projects list              # lista proyectos de la cuenta
supabase link --project-ref <REF>   # cambia el proyecto linked

# Para cambiar entre dev y prod:
supabase link --project-ref fteanipvydeaflfegldn   # dev
supabase link --project-ref <PROD_REF>              # prod (cuando exista)
```

### Edge Functions

```powershell
supabase functions new nombre-funcion     # crea nueva función
supabase functions deploy nombre-funcion  # despliega al proyecto linked
supabase functions list                   # lista funciones deployadas
```

### Auth y usuarios

```powershell
supabase auth export-users   # exporta usuarios (útil para migraciones)
```

---

## 6. Conceptos clave

### Row Level Security (RLS)

RLS está **activado por defecto** en el proyecto. Significa que aunque la API esté expuesta públicamente, ningún usuario puede leer datos de otro usuario. Las políticas se definen en SQL:

```sql
-- Ejemplo: usuario solo ve sus propias carteras
CREATE POLICY "users_own_carteras"
ON public.carteras
FOR ALL
USING (auth.uid() = user_id);
```

Sin políticas, **con RLS activado, nadie puede leer nada** (tabla bloqueada por defecto). Crear siempre las políticas junto con las tablas.

### Migraciones

Supabase usa migraciones SQL ordenadas por timestamp. El flujo es:
1. `supabase migration new <nombre>` — crea archivo vacío
2. Escribir el SQL en el archivo
3. `supabase db push` — aplica al remoto
4. El historial queda en `supabase/migrations/` y se commitea al repo

### Variables de entorno

Las claves de Supabase **nunca van en el código**. En React Native (Expo), irán en `.env`:
```
EXPO_PUBLIC_SUPABASE_URL=https://fteanipvydeaflfegldn.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJ...
```

La `anon key` es pública (puede estar en cliente). La `service_role key` es secreta y solo en servidor/Edge Functions.

Ambas claves están en: https://supabase.com/dashboard/project/fteanipvydeaflfegldn/settings/api

---

## 7. Próximos pasos (pendiente feedback de testers avanzados)

1. **Crear migración inicial** desde `docs/DATA_MODEL.md` — todas las tablas del modelo operacional + Kimball
2. **Crear proyecto `portgrow-prod`** en el dashboard cuando el schema esté estable
3. **Configurar RLS** — una política por tabla para `auth.uid() = user_id`
4. **Tabla `user_consents`** — consentimientos GDPR (consent_type, version, timestamps)
5. **Auth settings en prod**: activar confirmación de email, configurar SMTP (Resend/SendGrid)
6. **Edge Functions**: primera función (p.ej. recálculo de métricas TWR)

---

## 8. Dashboard

- Org: https://supabase.com/dashboard/org/mximnbarzokxksvdwqyh
- Proyecto dev: https://supabase.com/dashboard/project/fteanipvydeaflfegldn
- Table editor (dev): https://supabase.com/dashboard/project/fteanipvydeaflfegldn/editor
- Auth (dev): https://supabase.com/dashboard/project/fteanipvydeaflfegldn/auth/users
- SQL editor (dev): https://supabase.com/dashboard/project/fteanipvydeaflfegldn/sql
