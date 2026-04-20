# portapp — CLAUDE.md

> Lee también **ESTADO.md** antes de tocar código. Tiene el estado actualizado,
> las decisiones de arquitectura y todo el backlog.

---

## Qué es este proyecto

Prototipo de app móvil de gestión de carteras de inversión personal.
Tecnología: **un único archivo HTML autocontenido** (`prototype/index.html`).
Sin servidor, sin build, sin dependencias de npm. Se abre directamente en el navegador.

---

## Estructura del repositorio

```
portapp/
├── prototype/
│   └── index.html     ← TODO el prototipo vive aquí (HTML + CSS + JS)
├── src/
│   └── data/
│       └── sampleData.js  ← estructuras de datos de referencia (no se usa en el HTML)
├── docs/
│   └── SPEC.md        ← especificación técnica completa
├── ESTADO.md          ← estado actual, pantallas implementadas, backlog
├── CLAUDE.md          ← este archivo
└── .gitignore
```

---

## Arquitectura del prototipo (`index.html`)

### CSS
- Variables de tema en `:root` (`--bg0`, `--t0`, `--ac`, `--pos`, `--neg`…)
- Modo oscuro: clase `.dark` en `<html>`, que redefine las mismas variables
- Tamaño de fuente: clases `html.fs-sm / fs-md / fs-lg / fs-xl`
- Sin frameworks CSS — todo vanilla con variables CSS

### HTML
- `.auth-wrap` — pantallas de autenticación (login, 2FA, OTP, bloqueo)
- `.app-shell` — shell de la app (topbar + screens-wrap + nav-bar)
- `.screens-wrap` — contenedor de todas las pantallas
- Cada pantalla: `<div class="screen" id="s-NOMBRE">`
- Cada modal: `<div class="modal-overlay" id="m-NOMBRE">`

### Pantallas (IDs con prefijo `s-`)
| ID | Nombre visible | Función de render |
|---|---|---|
| `s-global` | Global | `renderGlobal()` |
| `s-resumen` | Resumen | `renderResumen()`, `renderCR()`, `renderHistorial()` |
| `s-cartera` | Cartera | `renderCartera()` |
| `s-efectivo` | Efectivo | `renderEfectivo()` |
| `s-ops` | Operaciones | `renderOps()` |
| `s-proyeccion` | Proyección DCA | `calcProy()` |
| `s-indices` | Índices | `renderIndices()` |
| `s-notif` | Avisos | `renderNotif()` |
| `s-plataformas` | Links externos | `renderPlats()` |
| `s-settings` | Ajustes | `renderCuentas()` + `renderGruposDnd()` |
| `s-rentabilidad` | Rentabilidad TWR | `renderRentabilidad()` |
| `s-grupos` | Capital por grupos | `renderGruposCapital()` |
| `s-perfil` | Perfil | — |
| `s-rent-efectivo` | Rent. efectivo | `renderRentEfectivo()` |
| `s-anotaciones` | Anotaciones | `renderAnotaciones()` |

### Navegación
- `goTo(screenId)` — activa una pantalla, desactiva las demás, llama al render
- `SCREENS` — array con todos los IDs de pantalla
- `SL` — mapa ID → etiqueta corta (para quick nav y nav bar)
- `NM` — mapa ID → ID del botón de la nav bar inferior (solo las 8 pestañas)

### Modales (IDs con prefijo `m-`)
`openModal(id)` / `closeModal(id)` / `closeAllModals()`

Modales existentes: `m-portfolios`, `m-nueva-cartera`, `m-op`, `m-ef`,
`m-nota`, `m-broker`, `m-grupo`, `m-nota-global`, `m-plataforma`, `m-cambio-pwd`

### Datos (variables globales JS)
```js
carteras      // array de carteras del usuario
activeId      // ID de la cartera activa
activos       // array de posiciones (ticker, broker, grupo, qty, pm, cot…)
ops           // array de operaciones
efectivoData  // array de movimientos de efectivo
notifs        // array de notificaciones
plats         // array de plataformas externas
cuentas       // array de brokers y cuentas bancarias (F9)
grupos        // array de grupos de activos (F10)
anotaciones   // array de anotaciones globales (F3)
notas         // array de notas de detalle de activo (legacy)
```

### Funciones de utilidad
```js
fe(n)         // formatea como €12.345
fp(n)         // formatea como +12,3%
cA(cid)       // activos de una cartera
cV(cid)       // valor total de una cartera
cI(cid)       // invertido total de una cartera
pb(pct,col,lbl) // genera HTML de barra de progreso
CC()          // devuelve paleta de colores según modo claro/oscuro
```

### Gráficos
Chart.js 4.4.1 (CDN). Variables globales: `chG`, `chR`, `chH`, `chP`, `chRent`, `chGrupos`.
Siempre destruir antes de re-renderizar: `if(chX) chX.destroy();`
Al cambiar modo oscuro, llamar `reCharts()` para re-renderizar los activos.

---

## Convenciones de código

- **Minimalismo**: una línea por función cuando sea posible (es un prototipo)
- **Sin TypeScript, sin módulos ES**: JS vanilla en un `<script>` al final del body
- **Template literals** para HTML dinámico
- **Clases CSS con guión**: `.card-title`, `.nota-card`, `.grupo-row`
- **IDs con guión**: `#s-global`, `#m-broker`, `#cuentas-list`
- **Badges de color**: `.b-blue`, `.b-teal`, `.b-amber`, `.b-purple`, `.b-coral`, `.b-gray`, `.b-green`
- Los `confirm()` del navegador son aceptables para confirmaciones destructivas en el prototipo

---

## Lo que NO hacer

- **No separar en múltiples archivos** — es un monolito por diseño (facilita compartir y desplegar en Netlify Drop)
- **No añadir dependencias** salvo Chart.js (ya incluido por CDN)
- **No usar `localStorage`** — los datos viven en memoria durante la sesión
- **No tocar el bloque de autenticación** (login, 2FA, OTP, lock screen) sin leer todo ese bloque primero
- **No duplicar funciones** — buscar si ya existe antes de crear una nueva
- **No romper el modo oscuro** — toda variable de color debe usar `var(--nombre)`, nunca valores fijos como `#fff` o `#000` en elementos visibles

---

## Cómo añadir una pantalla nueva

1. Añadir `<div class="screen" id="s-nueva">` en `.screens-wrap`
2. Añadir `'s-nueva'` al array `SCREENS`
3. Añadir `'s-nueva': 'Etiqueta'` al objeto `SL`
4. Añadir el caso en `goTo()`: `if(sid==='s-nueva') renderNueva();`
5. Añadir `'nueva'` al array de `renderQN()` si debe aparecer en el quick nav
6. Crear la función `renderNueva()`
7. Si necesita botón en la nav bar inferior: añadir `<button>` y su entrada en `NM`

---

## Cómo añadir un modal nuevo

1. Añadir `<div class="modal-overlay" id="m-nuevo">` justo antes de `</div>` del device
2. Estructurarlo con `.mhdr` + `.modal` + campos `.fg` + botón `.btn-p`
3. Abrir con `openModal('m-nuevo')`, cerrar con `closeModal('m-nuevo')`

---

## Credenciales del prototipo

- Email: `usuario@portapp.com`
- Contraseña: `demo1234`
- Código OTP: `123456`
