# Modo básico/avanzado + Proyecciones DCA guardadas — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Añadir un switch básico/avanzado gratuito que oculta pantallas analíticas complejas, y convertir la calculadora DCA en una herramienta que guarda múltiples proyecciones por cartera.

**Architecture:** Todo en `prototype/index.html`. El modo se persiste en `localStorage`. Las pantallas avanzadas se ocultan del nav y del quick nav mediante CSS y filtrado JS. Las proyecciones son un array en memoria por cartera.

**Tech Stack:** HTML + CSS + Vanilla JS. Sin framework, sin build.

---

## Archivo afectado

- Modificar: `prototype/index.html`
- Modificar: `ESTADO.md`

---

## Observaciones críticas del codebase

- El nav bar inferior tiene 8 botones: `nav-global`, `nav-resumen`, `nav-cartera`, `nav-efectivo`, `nav-ops`, `nav-proyeccion`, `nav-indices`, `nav-settings`. **Solo `nav-indices` es una pantalla avanzada en el nav bar**. Los demás (rentabilidad, grupos, etc.) no están en el nav bar — solo en el quick nav.
- `renderQN()` (línea ~1230) genera el quick nav dinámicamente desde `SL`. Hay que filtrar las pantallas avanzadas cuando `appMode === 'basic'`.
- `goTo()` (línea ~1211) no tiene guard de modo — hay que añadirlo.
- Settings empieza en línea ~525 con la sección "Interfaz".

---

## Task 1: Variables de estado y constante ADVANCED_SCREENS

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir `appMode` al bloque de estado (línea ~1128)**

Buscar:
```js
let notas=['Tesis: largo plazo DCA sobre índices globales.'],nextId=31,privacyOn=false,opsFilter='todas',opsLimit='20',lastBackupDate=null;
```

Cambiar a:
```js
let notas=['Tesis: largo plazo DCA sobre índices globales.'],nextId=31,privacyOn=false,opsFilter='todas',opsLimit='20',lastBackupDate=null,appMode=localStorage.getItem('appMode')||'basic';
```

- [ ] **Step 2: Añadir constante `ADVANCED_SCREENS` junto a `SCREENS` y `SL` (línea ~1208)**

Buscar:
```js
const SCREENS=['s-global','s-resumen',...];
```

Añadir ANTES de esa línea:
```js
const ADVANCED_SCREENS=['s-rentabilidad','s-grupos','s-rent-efectivo','s-indices','s-anotaciones','s-canales'];
```

- [ ] **Step 3: Verificar**

Abrir en navegador, no debe haber errores en consola.

---

## Task 2: Función `applyAppMode()` + clase `nav-advanced` en nav bar

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir clase `nav-advanced` al botón `nav-indices` (línea ~781)**

Buscar:
```html
<button class="nav-item" id="nav-indices" onclick="goTo('s-indices',this)">
```

Cambiar a:
```html
<button class="nav-item nav-advanced" id="nav-indices" onclick="goTo('s-indices',this)">
```

- [ ] **Step 2: Añadir función `applyAppMode()` después de `toggleDark()` (línea ~1204)**

Buscar:
```js
function toggleDark(){document.documentElement.classList.toggle('dark');document.getElementById('dark-chk').checked=document.documentElement.classList.contains('dark');reCharts();}
```

Añadir a continuación:
```js
function applyAppMode(){
  const adv=appMode==='advanced';
  document.querySelectorAll('.nav-advanced').forEach(el=>el.style.display=adv?'':'none');
  const chk=document.getElementById('advanced-chk');
  if(chk)chk.checked=adv;
}
```

- [ ] **Step 3: Verificar**

Abrir en navegador. `applyAppMode()` debe poder llamarse desde consola sin errores.

---

## Task 3: Toggle en Settings + función `toggleAppMode()`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir sección "Modo de uso" al inicio de `s-settings` (línea ~526)**

Buscar:
```html
<div class="screen" id="s-settings">
      <div class="screen-title">Ajustes</div>
      <div class="slabel" style="margin-bottom:7px">Interfaz</div>
```

Cambiar a:
```html
<div class="screen" id="s-settings">
      <div class="screen-title">Ajustes</div>
      <div class="slabel" style="margin-bottom:7px">Modo de uso</div>
      <div class="card">
        <div class="dr">
          <div><div class="dk">Modo avanzado</div><div style="font-size:11px;color:var(--t1)">Rentabilidad TWR, grupos, índices y más</div></div>
          <input type="checkbox" id="advanced-chk" style="width:auto" onchange="toggleAppMode(this.checked)">
        </div>
      </div>
      <div class="slabel" style="margin-top:12px;margin-bottom:7px">Interfaz</div>
```

- [ ] **Step 2: Añadir función `toggleAppMode()` junto a `applyAppMode()` (línea ~1205)**

Añadir después de `applyAppMode()`:
```js
function toggleAppMode(adv){appMode=adv?'advanced':'basic';localStorage.setItem('appMode',appMode);applyAppMode();}
```

- [ ] **Step 3: Llamar `applyAppMode()` en la inicialización**

Buscar el bloque de inicialización — buscar `goTo('s-global')` en el arranque de la app (línea ~1170 aproximadamente) o el evento `DOMContentLoaded`. Añadir `applyAppMode();` justo antes de la primera llamada a `goTo`.

Si no hay un punto de inicialización claro, añadir al final del `<script>`, justo antes del cierre `</script>`:
```js
applyAppMode();
```

- [ ] **Step 4: Verificar**

Abrir en navegador → ir a Ajustes → activar "Modo avanzado" → verificar que `nav-indices` aparece en el nav bar. Desactivar → verificar que desaparece. Recargar página → verificar que el estado persiste.

---

## Task 4: Filtrar pantallas avanzadas en `renderQN()`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Modificar `renderQN()` para filtrar según `appMode` (línea ~1230)**

Buscar:
```js
function renderQN(cur){['resumen','cartera','efectivo','ops','proyeccion','indices','notif','plataformas','rentabilidad','grupos','rent-efectivo','anotaciones','canales'].forEach(k=>{const el=document.getElementById('qn-'+k);if(!el)return;el.innerHTML=Object.entries(SL).filter(([id])=>id!==cur&&id!=='s-global'&&id!=='s-settings'&&id!=='s-perfil'&&id!=='s-ayuda'&&id!=='s-anotaciones').map(([id,l])=>`<button class="qbtn" onclick="goTo('${id}')">${l}</button>`).join('');});}
```

Cambiar a:
```js
function renderQN(cur){['resumen','cartera','efectivo','ops','proyeccion','indices','notif','plataformas','rentabilidad','grupos','rent-efectivo','anotaciones','canales'].forEach(k=>{const el=document.getElementById('qn-'+k);if(!el)return;el.innerHTML=Object.entries(SL).filter(([id])=>id!==cur&&id!=='s-global'&&id!=='s-settings'&&id!=='s-perfil'&&id!=='s-ayuda'&&id!=='s-anotaciones'&&(appMode==='advanced'||!ADVANCED_SCREENS.includes(id))).map(([id,l])=>`<button class="qbtn" onclick="goTo('${id}')">${l}</button>`).join('');});}
```

- [ ] **Step 2: Verificar**

En modo básico, navegar a Resumen → el quick nav no debe mostrar Rentabilidad, Grupos, Índices, etc. En modo avanzado, deben aparecer.

---

## Task 5: Guard en `goTo()` para pantallas avanzadas

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir guard al inicio de `goTo()` (línea ~1211)**

Buscar el inicio de `goTo`:
```js
function goTo(sid,btn){SCREENS.forEach(s=>document.getElementById(s).classList.remove('active'));
```

Cambiar a:
```js
function goTo(sid,btn){if(appMode==='basic'&&ADVANCED_SCREENS.includes(sid)){sid='s-global';btn=null;}SCREENS.forEach(s=>document.getElementById(s).classList.remove('active'));
```

- [ ] **Step 2: Verificar**

Con modo básico activo, intentar `goTo('s-rentabilidad')` desde la consola del navegador → debe navegar a `s-global`.

- [ ] **Step 3: Commit de todo lo anterior (Tasks 1-5)**

```bash
git add prototype/index.html
git commit -m "feat: modo básico/avanzado con switch en ajustes y persistencia localStorage"
```

---

## Task 6: Estado y datos para proyecciones DCA

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir variables `proyecciones` y `proyId` al bloque de estado (línea ~1128)**

Buscar la línea de estado ya modificada en Task 1:
```js
let notas=[...],nextId=31,privacyOn=false,opsFilter='todas',opsLimit='20',lastBackupDate=null,appMode=localStorage.getItem('appMode')||'basic';
```

Cambiar a:
```js
let notas=[...],nextId=31,privacyOn=false,opsFilter='todas',opsLimit='20',lastBackupDate=null,appMode=localStorage.getItem('appMode')||'basic',proyecciones=[],proyId=1;
```

- [ ] **Step 2: Verificar**

Abrir en navegador, no debe haber errores en consola.

---

## Task 7: HTML de la pantalla `s-proyeccion`

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Reemplazar el título estático y añadir contenedor de lista (línea ~464)**

Buscar:
```html
<div class="screen" id="s-proyeccion">
      <div class="qnav" id="qn-proyeccion"></div>
      <div class="screen-title">Proyección DCA</div>
      <div class="card">
```

Cambiar a:
```html
<div class="screen" id="s-proyeccion">
      <div class="qnav" id="qn-proyeccion"></div>
      <div class="screen-title" id="proy-titulo">Proyección DCA</div>
      <div id="proy-list" style="display:none;margin-bottom:10px"></div>
      <div class="card">
```

- [ ] **Step 2: Añadir botón "Guardar proyección" después del botón Calcular (línea ~477)**

Buscar:
```html
<button class="btn btn-p" onclick="calcProy()">Calcular</button>
```

Cambiar a:
```html
<button class="btn btn-p" onclick="calcProy()">Calcular</button>
        <button class="btn" style="margin-top:8px;width:100%" onclick="saveProy()">Guardar proyección</button>
```

- [ ] **Step 3: Verificar HTML**

Abrir en navegador. La pantalla DCA debe mostrar el título y el botón sin errores visuales.

---

## Task 8: Funciones de proyecciones DCA

**Files:**
- Modify: `prototype/index.html`

- [ ] **Step 1: Añadir las cuatro funciones después de `calcProy()` (buscar `function calcProy`)**

Añadir después de la función `calcProy` completa:

```js
function renderProyList(){
  const lista=proyecciones.filter(p=>p.cartera===activeId);
  const el=document.getElementById('proy-list');
  const tit=document.getElementById('proy-titulo');
  const cart=carteras.find(c=>c.id===activeId);
  if(tit)tit.textContent=lista.length?`Proyecciones — ${cart?.nombre||''}`: 'Proyección DCA';
  if(!el)return;
  el.style.display=lista.length?'block':'none';
  el.innerHTML=lista.length?`<div class="card" style="padding:10px"><div class="card-title" style="margin-bottom:8px">Proyecciones guardadas</div>`+
    lista.map(p=>`<div class="dr" style="gap:8px;padding:4px 0"><span class="tag" onclick="loadProy(${p.id})" style="cursor:pointer;flex:1">${p.nombre}</span><button class="btn-icon" onclick="deleteProy(${p.id})" style="color:var(--neg);font-size:14px">🗑</button></div>`).join('')+
    `</div>`:'';
}
function saveProy(){
  const nombre=prompt('Nombre de esta proyección:');
  if(!nombre||!nombre.trim())return;
  proyecciones.push({id:proyId++,cartera:activeId,nombre:nombre.trim(),
    amt:parseFloat(document.getElementById('dca-amt').value)||300,
    freq:document.getElementById('dca-freq').value,
    rate:parseFloat(document.getElementById('dca-rate').value)||8,
    years:parseInt(document.getElementById('dca-years').value)||10});
  renderProyList();
  showToast('Proyección guardada ✓');
}
function loadProy(id){
  const p=proyecciones.find(x=>x.id===id);
  if(!p)return;
  document.getElementById('dca-amt').value=p.amt;
  document.getElementById('dca-freq').value=p.freq;
  document.getElementById('dca-rate').value=p.rate;
  document.getElementById('dca-years').value=p.years;
  calcProy();
}
function deleteProy(id){
  if(!confirm('¿Eliminar esta proyección?'))return;
  proyecciones=proyecciones.filter(x=>x.id!==id);
  renderProyList();
}
```

- [ ] **Step 2: Llamar `renderProyList()` en `goTo('s-proyeccion')`**

Buscar en `goTo()` el bloque que maneja `s-proyeccion`:
```js
else if(sid==='s-proyeccion')
```

Añadir `renderProyList();` en ese bloque (junto a cualquier otra función de render que haya allí, o añadir el caso si no existe):
```js
else if(sid==='s-proyeccion'){calcProy();renderProyList();}
```

Verificar primero qué hace el caso actual de `s-proyeccion` en `goTo` antes de modificarlo — puede tener ya un `calcProy()`.

- [ ] **Step 3: Verificar flujo completo**

1. Ir a pantalla DCA
2. Calcular una proyección con valores por defecto
3. Pulsar "Guardar proyección" → introducir nombre "Escenario conservador"
4. Verificar que aparece la tarjeta con el nombre
5. Cambiar valores y guardar otra → "Escenario optimista"
6. Pulsar "Escenario conservador" → verificar que carga esos valores y recalcula
7. Eliminar "Escenario optimista" → verificar que desaparece
8. Cambiar de cartera → verificar que las proyecciones son distintas por cartera

- [ ] **Step 4: Commit**

```bash
git add prototype/index.html
git commit -m "feat: proyecciones DCA guardadas por cartera"
```

---

## Task 9: Actualizar ESTADO.md

**Files:**
- Modify: `ESTADO.md`

- [ ] **Step 1: Añadir nota sobre modo básico/avanzado en sec 2 (pantallas implementadas)**

Buscar la sección `## 2. Pantallas implementadas en el prototipo` en ESTADO.md y añadir al final de la tabla o después de ella:

```markdown
> **Modo básico/avanzado:** las pantallas `s-rentabilidad`, `s-grupos`, `s-rent-efectivo`, `s-indices`, `s-anotaciones` y `s-canales` están ocultas en modo básico. El usuario puede activar el modo avanzado desde Ajustes. Switch gratuito, sin restricción de plan. Decisión: reducir fricción de onboarding para inversores nuevos sin penalizar a los avanzados.
```

- [ ] **Step 2: Actualizar pantalla onboarding en sec 20**

Buscar en sec 20 el texto de la pantalla de onboarding. En el **Cuerpo**, añadir un párrafo entre el de pérdida de datos y el de backup:

```
> La app tiene un **modo básico** ideal para empezar y un **modo avanzado** con herramientas analíticas más potentes (rentabilidad TWR, análisis por grupos, índices…). Puedes cambiar entre ellos cuando quieras, gratis, desde Ajustes.
```

- [ ] **Step 3: Commit todo**

```bash
git add prototype/index.html ESTADO.md
git commit -m "docs: modo básico/avanzado documentado en ESTADO secs 2 y 20"
```

---

## Task 10: PR a dev

- [ ] **Step 1: Merge origin/main antes del PR**

```bash
git fetch origin
git merge origin/main --no-edit
git push
```

- [ ] **Step 2: Crear PR a dev**

```bash
gh pr create --base dev --title "feat: modo básico/avanzado + proyecciones DCA guardadas" --body "Implementa spec aprobado en docs/superpowers/specs/2026-04-27-modo-basico-avanzado-proyecciones-design.md

- Switch modo básico/avanzado en Ajustes, persistido en localStorage. Modo básico por defecto.
- Pantallas avanzadas (rentabilidad, grupos, índices, anotaciones, canales) ocultas en nav y quick nav en modo básico.
- Guard en goTo() redirige a Global si se intenta navegar a pantalla avanzada en modo básico.
- Proyecciones DCA: guardar, cargar y eliminar escenarios por cartera activa.
- ESTADO.md actualizado con nota en sec 2 y texto de onboarding en sec 20."
```
