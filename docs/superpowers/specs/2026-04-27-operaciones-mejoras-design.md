# Diseño: Mejoras en pantalla de Operaciones

**Fecha:** 2026-04-27
**Estado:** Aprobado

---

## Alcance

Cuatro mejoras a la pantalla `s-ops` del prototipo (`prototype/index.html`). El punto 3 (FIFO) queda documentado pero no implementado — se aborda en pre-producción.

---

## Punto 1 — Cancelación de operaciones vía bottom sheet

### Flujo
1. El usuario toca una fila de la tabla de operaciones
2. Se abre un bottom sheet (modal) con el detalle de la operación: fecha, ticker, tipo, importe total
3. El sheet calcula en tiempo real el impacto de la cancelación sobre la posición actual:
   - Nueva qty del activo tras cancelar
   - Nuevo PM del activo tras cancelar (recálculo completo del historial)
4. Se evalúa si la cancelación es válida:
   - **Inválida** (qty resultante < 0): botón deshabilitado, mensaje "No es posible cancelar esta operación porque generaría una posición negativa de X acciones."
   - **Válida**: botón rojo "Cancelar operación" activo
5. Al confirmar, se muestra un warning final antes de ejecutar: "Esta acción es irreversible. Reducirá tu posición de X a Y acciones y ajustará el precio medio de €A a €B."
6. Confirmación (`confirm()` del navegador en el prototipo) → se ejecuta la cancelación

### Lógica interna al cancelar
- Se genera una operación inversa con los mismos valores (qty, precio, fee) y tipo opuesto
- Ambas operaciones (original + inversa) se marcan con `status: 'cancelled'` y se vinculan entre sí via `cancelledWith: id`
- Se recalcula `pm` y `qty` del activo reproduciendo todas las operaciones activas en orden cronológico
- El movimiento de efectivo vinculado (si existe) también se marca como cancelado
- `renderOps()` y `renderCartera()` se llaman tras la cancelación para reflejar el estado actualizado

### Nota pre-producción
En producción, el recálculo de PM por cancelación de operaciones antiguas debe implementarse con el motor histórico completo en backend (PostgreSQL). En el prototipo el recálculo se hace en memoria sobre el array `ops` — válido para validación pero no para producción con datos persistidos.

### Visualización de operaciones canceladas
- Las operaciones con `status: 'cancelled'` se muestran con estilo tachado y color gris
- Toggle "Mostrar canceladas" (ya documentado en ESTADO sec 23) para ocultarlas/mostrarlas

---

## Punto 2 — Orden descendente por fecha

`renderOps()` invierte el array filtrado antes de renderizar:

```js
const f = ops.filter(...).reverse();
```

La más reciente aparece primera. Es el estándar del sector (Degiro, IBKR, Revolut).

---

## Punto 3 — FIFO (no implementado en prototipo)

**Documentado para pre-producción.**

En España y el resto de países hispanohablantes, la venta de acciones sigue el método FIFO (First In, First Out) a efectos fiscales. Funcionalidades previstas:

- Marcar visualmente qué lotes se venden según FIFO y a qué precio de compra
- Mostrar la ganancia real de cada venta calculada sobre el precio de compra FIFO (no sobre el PM)
- Gestión de ventas parciales del último lote

Requiere un motor de trazabilidad de lotes en backend. Se diseñará e implementará en pre-producción.

---

## Punto 4 — Filtro de cantidad de operaciones mostradas

Se añaden chips de paginación junto a los filtros de tipo existentes:

- **Chips:** `Últimas 20 · Último mes · Todo`
- **Por defecto:** `Últimas 20`
- Se combina con el filtro de tipo (Todas / Compras / Ventas / Rendimientos): primero se filtra por tipo, luego se aplica el límite de cantidad

Variable de estado: `opsLimit` (valores: `20`, `mes`, `todas`). Por defecto `20`.

Lógica en `renderOps()`:
1. Filtrar por tipo (`opsFilter`)
2. Ordenar descendente
3. Aplicar límite según `opsLimit`

---

## Punto 5 — Disclaimer precio medio

### Icono ⓘ en detalle de activo
- Junto al valor del PM en el panel de detalle (`panel-detalle`) se añade un icono ⓘ
- Al tocar: abre un modal o tooltip con texto:
  > "Nuestro precio medio puede diferir ligeramente del de tu broker porque cada broker puede incluir o excluir comisiones y otros costes en su cálculo. Lo realmente importante es que la **cantidad de acciones coincida** con la de tu broker. Consulta la sección de Ayuda para más detalle."

### Sección en pantalla Ayuda (`s-ayuda`)
- Añadir entrada destacada en la FAQ con título "¿Por qué mi precio medio difiere del del broker?"
- Explicación completa: qué incluye nuestro cálculo, qué puede incluir el broker, y por qué la qty es la métrica crítica a verificar

---

## Archivos a modificar

- `prototype/index.html` — único archivo del prototipo

## Funciones afectadas

- `renderOps()` — orden descendente + límite
- Nueva función `showOpDetalle(opId)` — bottom sheet de detalle/cancelación
- Nueva función `cancelOp(opId)` — lógica de cancelación + recálculo
- Nueva función `calcPMtrasCancel(ticker, opIdExcluida)` — recálculo de PM
- `renderCartera()` — se llama tras cancelación para actualizar posiciones
- HTML de `s-ops` — chips de límite
- HTML de `panel-detalle` — icono ⓘ junto al PM
- HTML de `s-ayuda` — nueva entrada FAQ
