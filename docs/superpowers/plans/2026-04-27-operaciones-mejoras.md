# Mejoras Pantalla Operaciones — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implementar cancelación de operaciones vía bottom sheet, orden descendente, filtro de cantidad y disclaimer de precio medio en `prototype/index.html`.

**Architecture:** Todo en un único archivo `prototype/index.html`. Se añaden campos `status` y `cancelledWith` a las operaciones, una nueva variable de estado `opsLimit`, un nuevo modal `m-op-detalle` para el bottom sheet, y las funciones `showOpDetalle`, `calcImpactoCancel` y `cancelOp`. El disclaimer PM usa un modal informativo existente o uno nuevo inline.

**Tech Stack:** HTML + CSS + Vanilla JS. Sin framework, sin build. Chart.js ya incluido (no afectado).

---

## Archivo afectado

- Modificar: `prototype/index.html` (único archivo del prototipo)

---

## Task 1: Estado y datos — añadir campos a ops y variable opsLimit

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir `status` y `cancelledWith` a cada operación del array `ops` (línea ~1027)**

Cada operación existente en el array `ops` debe tener estos dos campos añadidos al final del objeto. Ejemplo para la operación id:1:

```js
{id:1,fecha:'2024-03-10',ticker:'AAPL',...,cartera:'c1',status:'active',cancelledWith:null},
```

Hacer lo mismo para TODAS las operaciones del array (ids 1–30). El valor es siempre `status:'active',cancelledWith:null` para las existentes.

- [ ] **Step 2: Añadir variable `opsLimit` al bloque de estado (línea ~1091)**

Buscar la línea:
```js
let notas=['...'],nextId=31,privacyOn=false,opsFilter='todas',lastBackupDate=null;
```

Cambiar a:
```js
let notas=['...'],nextId=31,privacyOn=false,opsFilter='todas',opsLimit='20',lastBackupDate=null;
```

- [ ] **Step 3: Verificar en navegador**

Abrir `prototype/index.html` en el navegador. Navegar a Operaciones. Verificar que la pantalla carga sin errores en la consola.

---

## Task 2: Orden descendente + chips de límite

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Invertir el orden en `renderOps()` (línea ~1247)**

Buscar en `renderOps()`:
```js
function renderOps(){const f=ops.filter(o=>{if(o.cartera!==activeId)return false;if(opsFilter==='todas')return true;if(opsFilter==='rendimiento')return REND.includes(o.op);return o.op===opsFilter;});
```

Reemplazar por:
```js
function renderOps(){
  let f=ops.filter(o=>{
    if(o.cartera!==activeId)return false;
    if(o.status==='cancelled')return false;
    if(opsFilter==='todas')return true;
    if(opsFilter==='rendimiento')return REND.includes(o.op);
    return o.op===opsFilter;
  }).reverse();
  const hoy=new Date();
  if(opsLimit==='20')f=f.slice(0,20);
  else if(opsLimit==='mes'){const c=new Date(hoy.getFullYear(),hoy.getMonth(),1).toISOString().slice(0,10);f=f.filter(o=>o.fecha>=c);}
  document.getElementById('tb-ops').innerHTML=f.map(o=>{const t=o.qty*o.precio+o.fee;return`<tr class="row-link" onclick="showOpDetalle(${o.id})"><td>${o.fecha.slice(5)}</td><td><strong>${o.ticker}</strong><br><span style="font-size:10px;color:var(--t1)">${o.broker}</span></td><td><span class="badge ${GC[o.grupo]||'b-gray'}">${o.op}</span></td><td class="${o.op==='Compra'?'neg':'pos'}"><span class="amt">${o.op==='Compra'?'-':'+'}{t}</span></td></tr>`.replace('{t}',fe(t));}).join('')||'<tr><td colspan="4"><div class="empty-state" style="padding:24px 12px"><span class="empty-state-icon" style="font-size:28px">🔍</span><div class="empty-state-title">Sin operaciones</div><div class="empty-state-sub">Usa + Op. para registrar tu primera compra o venta</div></div></td></tr>';
}
```

Nota: el onclick de cada fila cambia de `showDetalle('${o.ticker}')` a `showOpDetalle(${o.id})`.

- [ ] **Step 2: Añadir chips de límite en el HTML de `s-ops` (línea ~417)**

Buscar en el HTML de `s-ops`:
```html
<div class="chip-row" id="ops-chips">
  <span class="tag selected" onclick="filterOps(this,'todas')">Todas</span>
  <span class="tag" onclick="filterOps(this,'Compra')">Compras</span>
  <span class="tag" onclick="filterOps(this,'Venta')">Ventas</span>
  <span class="tag" onclick="filterOps(this,'rendimiento')">Rendimientos</span>
</div>
```

Añadir debajo (después del `</div>` de ops-chips):
```html
<div class="chip-row" id="ops-limit-chips" style="margin-top:4px">
  <span class="tag selected" onclick="filterOpsLimit(this,'20')">Últ. 20</span>
  <span class="tag" onclick="filterOpsLimit(this,'mes')">Este mes</span>
  <span class="tag" onclick="filterOpsLimit(this,'todas')">Todo</span>
</div>
```

- [ ] **Step 3: Añadir función `filterOpsLimit` junto a `filterOps` (línea ~1248)**

Buscar:
```js
function filterOps(el,tipo){document.querySelectorAll('#ops-chips .tag').forEach(t=>t.classList.remove('selected'));el.classList.add('selected');opsFilter=tipo;renderOps();}
```

Añadir a continuación:
```js
function filterOpsLimit(el,lim){document.querySelectorAll('#ops-limit-chips .tag').forEach(t=>t.classList.remove('selected'));el.classList.add('selected');opsLimit=lim;renderOps();}
```

- [ ] **Step 4: Verificar en navegador**

Navegar a Operaciones. Verificar: la operación más reciente aparece primera. Los chips "Últ. 20 / Este mes / Todo" funcionan y combinan con los chips de tipo. No hay errores en consola.

---

## Task 3: Modal bottom sheet `m-op-detalle`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir el HTML del modal**

Buscar el último modal antes de `</div>` del device (buscar `m-cambio-pwd` o similar al final de los modales). Añadir después:

```html
<div class="modal-overlay" id="m-op-detalle">
  <div class="modal">
    <div class="mhdr">
      <span class="mtitle">Detalle de operación</span>
      <button class="btn-icon" onclick="closeModal('m-op-detalle')">✕</button>
    </div>
    <div id="op-detalle-body" style="font-size:13px;color:var(--t1);line-height:1.7;margin-bottom:12px"></div>
    <div id="op-detalle-impacto" style="font-size:12px;padding:10px;background:var(--bg1);border-radius:8px;margin-bottom:14px;display:none"></div>
    <div id="op-detalle-error" style="font-size:12px;color:var(--neg);padding:8px 0;display:none"></div>
    <button id="btn-cancelar-op" class="btn-p" style="background:var(--neg);width:100%;margin-top:4px" onclick="cancelOp()">Cancelar operación</button>
  </div>
</div>
```

- [ ] **Step 2: Verificar HTML válido**

Abrir en navegador. No deben aparecer errores de parseo en consola.

---

## Task 4: Función `showOpDetalle(opId)`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir la función después de `filterOpsLimit`**

```js
function showOpDetalle(opId){
  const o=ops.find(x=>x.id===opId);
  if(!o)return;
  const t=o.qty*o.precio+o.fee;
  document.getElementById('op-detalle-body').innerHTML=
    `<div style="margin-bottom:6px"><strong>${o.ticker}</strong> · ${o.fecha} · <span class="badge ${GC[o.grupo]||'b-gray'}">${o.op}</span></div>`+
    `<div>Cantidad: <strong>${o.qty}</strong> · Precio: <strong>${fe(o.precio)}</strong> · Comisión: <strong>${fe(o.fee)}</strong></div>`+
    `<div style="margin-top:4px">Total: <strong>${fe(t)}</strong> · Broker: ${o.broker}</div>`+
    (o.nota?`<div style="margin-top:6px;font-style:italic">"${o.nota}"</div>`:'');
  const impacto=calcImpactoCancel(opId);
  const impDiv=document.getElementById('op-detalle-impacto');
  const errDiv=document.getElementById('op-detalle-error');
  const btn=document.getElementById('btn-cancelar-op');
  btn.dataset.opId=opId;
  if(!impacto.valida){
    impDiv.style.display='none';
    errDiv.style.display='block';
    errDiv.textContent=`No es posible cancelar esta operación porque generaría una posición negativa (${impacto.qtyResultante} acciones).`;
    btn.disabled=true;
    btn.style.opacity='0.4';
  } else {
    errDiv.style.display='none';
    impDiv.style.display='block';
    impDiv.innerHTML=`<strong>Impacto si se cancela:</strong><br>`+
      `Posición: ${impacto.qtyActual} → <strong>${impacto.qtyResultante}</strong> ${o.ticker}<br>`+
      (impacto.pmActual!==null?`Precio medio: ${fe(impacto.pmActual)} → <strong>${fe(impacto.pmResultante)}</strong>`:'');
    btn.disabled=false;
    btn.style.opacity='1';
  }
  openModal('m-op-detalle');
}
```

- [ ] **Step 2: Verificar en navegador**

Navegar a Operaciones, tocar una fila. Debe abrirse el bottom sheet con el detalle correcto. Tocar ✕ debe cerrarlo.

---

## Task 5: Función `calcImpactoCancel(opId)`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir la función después de `showOpDetalle`**

```js
function calcImpactoCancel(opId){
  const o=ops.find(x=>x.id===opId);
  const activo=activos.find(a=>a.ticker===o.ticker&&a.cartera===o.cartera);
  const qtyActual=activo?activo.qty:0;
  const pmActual=activo?activo.pm:null;
  // Calcular qty resultante si se excluye esta op
  const opsActivas=ops.filter(x=>x.ticker===o.ticker&&x.cartera===o.cartera&&x.status==='active'&&x.id!==opId);
  opsActivas.sort((a,b)=>a.fecha.localeCompare(b.fecha));
  let qtyRes=0,costRes=0;
  opsActivas.forEach(x=>{
    if(x.op==='Compra'){qtyRes+=x.qty;costRes+=x.qty*x.precio+x.fee;}
    else if(x.op==='Venta'){qtyRes-=x.qty;}
  });
  const pmResultante=qtyRes>0?costRes/qtyRes:0;
  return{valida:qtyRes>=0,qtyActual,qtyResultante:Math.round(qtyRes*10000)/10000,pmActual,pmResultante:Math.round(pmResultante*100)/100};
}
```

- [ ] **Step 2: Verificar casos en navegador**

Abrir el bottom sheet de una operación de Compra con posición existente → debe mostrar impacto válido con qty reducida. Abrir una operación de Compra cuya qty sea menor que las ventas posteriores → debe mostrar error de qty negativa y botón deshabilitado.

---

## Task 6: Función `cancelOp()`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir la función después de `calcImpactoCancel`**

```js
function cancelOp(){
  const opId=parseInt(document.getElementById('btn-cancelar-op').dataset.opId);
  const o=ops.find(x=>x.id===opId);
  const impacto=calcImpactoCancel(opId);
  if(!impacto.valida)return;
  const msg=`¿Cancelar esta operación?\n\nEsta acción es IRREVERSIBLE.\n`+
    `Posición: ${impacto.qtyActual} → ${impacto.qtyResultante} ${o.ticker}\n`+
    (impacto.pmActual?`Precio medio: ${fe(impacto.pmActual)} → ${fe(impacto.pmResultante)}`:'');
  if(!confirm(msg))return;
  // Marcar op original como cancelada
  o.status='cancelled';
  o.cancelledWith=nextId;
  // Generar operación inversa
  const opInversa=Object.assign({},o,{
    id:nextId++,
    op:o.op==='Compra'?'Venta':'Compra',
    fecha:new Date().toISOString().slice(0,10),
    nota:`Cancelación de op #${opId}`,
    status:'cancelled',
    cancelledWith:opId
  });
  ops.push(opInversa);
  // Actualizar activo: qty y pm
  const activo=activos.find(a=>a.ticker===o.ticker&&a.cartera===o.cartera);
  if(activo){activo.qty=impacto.qtyResultante;activo.pm=impacto.pmResultante;}
  // Cancelar movimiento de efectivo vinculado si existe
  efectivoData.forEach(e=>{if(e.opId===opId)e.status='cancelled';});
  closeModal('m-op-detalle');
  renderOps();
  renderCartera();
  showToast('Operación cancelada');
}
```

- [ ] **Step 2: Verificar flujo completo en navegador**

1. Anotar qty y PM de un activo en Cartera (ej. VWCE)
2. Ir a Operaciones, tocar una compra de VWCE
3. Verificar que el impacto calculado es correcto
4. Confirmar la cancelación
5. Verificar en Cartera que qty y PM se han actualizado
6. Verificar que la operación cancelada ya no aparece en la lista

---

## Task 7: Disclaimer ⓘ en panel-detalle + modal informativo

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir icono ⓘ junto al PM en `panel-detalle` (línea ~441)**

Buscar:
```html
<div class="metric"><div class="mlabel">Precio medio</div><div class="mvalue"><span class="amt" id="d-pm"></span></div></div>
```

Reemplazar por:
```html
<div class="metric"><div class="mlabel">Precio medio <button class="btn-icon" style="font-size:11px;color:var(--t1);vertical-align:middle;padding:0 2px" onclick="openModal('m-pm-info')">ⓘ</button></div><div class="mvalue"><span class="amt" id="d-pm"></span></div></div>
```

- [ ] **Step 2: Añadir modal `m-pm-info`**

Añadir junto a los demás modales:
```html
<div class="modal-overlay" id="m-pm-info">
  <div class="modal">
    <div class="mhdr"><span class="mtitle">Sobre el precio medio</span><button class="btn-icon" onclick="closeModal('m-pm-info')">✕</button></div>
    <p style="font-size:13px;color:var(--t1);line-height:1.65">Nuestro precio medio puede diferir ligeramente del de tu broker porque cada broker puede incluir o excluir comisiones y otros costes en su cálculo.</p>
    <p style="font-size:13px;color:var(--t1);line-height:1.65">Lo realmente importante es que la <strong>cantidad de acciones coincida</strong> con la de tu broker.</p>
    <button class="btn-p" style="width:100%;margin-top:8px" onclick="closeModal('m-pm-info');goTo('s-ayuda')">Ver FAQ completa →</button>
  </div>
</div>
```

- [ ] **Step 3: Verificar en navegador**

Ir a Operaciones → tocar un activo → ver panel detalle → tocar ⓘ junto a "Precio medio". Debe abrirse el modal informativo. El botón "Ver FAQ completa →" debe navegar a Ayuda.

---

## Task 8: Entrada FAQ en pantalla Ayuda (`s-ayuda`)

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Localizar la sección FAQ en `s-ayuda`**

Buscar en el HTML de `s-ayuda` el primer `<details>` existente para insertar antes o después según el contexto.

- [ ] **Step 2: Añadir entrada de FAQ**

Añadir al inicio del bloque de `<details>` en `s-ayuda`:
```html
<details>
  <summary>¿Por qué mi precio medio difiere del de mi broker? <span style="font-size:11px;color:var(--ac);font-weight:400">Importante</span></summary>
  <div class="det-body">
    <p>Nuestro cálculo del precio medio incluye el precio de compra y las comisiones explícitas de cada operación. Algunos brokers añaden al precio medio otros conceptos como gastos de custodia, impuestos retenidos o costes de conversión de divisa.</p>
    <p style="margin-top:8px">Esto puede provocar una diferencia pequeña entre nuestro PM y el del broker. <strong>No es un error.</strong></p>
    <p style="margin-top:8px">Lo realmente importante es verificar que la <strong>cantidad de acciones (qty) coincida exactamente</strong> con la que muestra tu broker. Si hay discrepancia en la cantidad, revisa si tienes alguna operación no registrada.</p>
  </div>
</details>
```

- [ ] **Step 3: Verificar en navegador**

Navegar a Ayuda. La nueva entrada "¿Por qué mi precio medio difiere del de mi broker?" debe aparecer con el indicador "Importante" y desplegar el texto al tocarse.

---

## Task 9: Actualizar ESTADO.md — nota FIFO y punto 3 pendiente

**Files:**
- Modify: `ESTADO.md`

- [ ] **Step 1: Añadir nota FIFO en ESTADO sec 23 (operaciones inmutables)**

Buscar en ESTADO.md la sección `## 23.` y añadir al final de la sección:

```markdown
### FIFO — Pendiente de implementación (pre-producción)

En España y el resto de países hispanohablantes la venta de acciones sigue el método FIFO (First In, First Out) a efectos fiscales. Funcionalidades previstas para pre-producción:

- Marcar visualmente qué lotes se venden según FIFO y a qué precio de compra
- Mostrar ganancia real por venta calculada sobre precio de compra FIFO (no sobre PM)
- Gestión de ventas parciales del último lote

Requiere motor de trazabilidad de lotes en backend. No implementado en el prototipo.
```

- [ ] **Step 2: Commit todo**

```bash
git add prototype/index.html ESTADO.md
git commit -m "feat: mejoras ops — cancelación, orden desc, filtro cantidad, disclaimer PM"
```

---

## Task 10: PR a dev

- [ ] **Step 1: Merge origin/main en la feature branch antes del PR**

```bash
git fetch origin
git merge origin/main --no-edit
git push
```

- [ ] **Step 2: Crear PR a dev**

```bash
gh pr create --base dev --title "feat: mejoras pantalla operaciones (cancelación, orden, filtro, disclaimer)" --body "Implementa puntos 1, 2, 4 y 5 del diseño aprobado en docs/superpowers/specs/2026-04-27-operaciones-mejoras-design.md. Punto 3 (FIFO) documentado en ESTADO sec 23 para pre-producción."
```
