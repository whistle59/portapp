# Portgrow — Decision Log (ADR)

Registro de decisiones de arquitectura y producto. Cada entrada explica **qué** se decidió, **por qué** y **qué alternativas se descartaron**. Las decisiones son inmutables: si una decisión cambia, se añade una nueva entrada que la supersede.

---

## ADR-001 · Prototipo como fichero HTML único

**Fecha:** 2026-04 (inicio del proyecto)
**Estado:** Vigente

**Decisión:** Todo el prototipo vive en un único fichero autocontenido (`prototype/index.html`) sin build, sin dependencias npm y sin servidor.

**Por qué:** Máxima portabilidad para compartir con testers (abrir en navegador sin instalar nada). Netlify Drop permite despliegue en segundos. Facilita iterar sobre diseño y flujos sin fricción de entorno.

**Alternativas descartadas:**
- React/Vite: overhead de entorno innecesario en fase de prototipo
- Varios ficheros HTML: complica el despliegue one-file

**Consecuencias:** El fichero crece (~184 KB). No se separa en módulos hasta la fase de desarrollo real en React Native.

---

## ADR-002 · Arquitectura híbrida local-first + servidor

**Fecha:** 2026-04-24
**Estado:** Vigente

**Decisión:** Los datos del usuario (carteras, operaciones, efectivo) viven localmente en el dispositivo (SQLite vía WatermelonDB). El servidor gestiona cotizaciones, auth, pagos y analytics.

**Por qué:** La app debe funcionar sin conexión. Los datos financieros son sensibles — el usuario no quiere depender de que nuestro servidor esté operativo para ver su cartera. La latencia percibida es cero para lecturas.

**Alternativas descartadas:**
- Todo en servidor (API-first): requiere conexión constante, mayor latencia, mayor coste de infraestructura
- Todo local (sin servidor): imposible ofrecer cotizaciones en tiempo real, sync multi-dispositivo ni auth centralizada

---

## ADR-003 · React Native + Expo como plataforma de producción

**Fecha:** 2026-04-24
**Estado:** Vigente

**Decisión:** La app de producción se desarrollará con React Native + Expo, apuntando a iOS, Android y Web desde una única base de código.

**Por qué:** El público objetivo usa mayoritariamente móvil. Expo reduce la fricción de build y OTA updates. Una sola base de código evita duplicar lógica de negocio.

**Alternativas descartadas:**
- Flutter: ecosistema JS/TS más familiar, mejor integración con Supabase SDK
- Capacitor/Ionic: rendimiento inferior en listas largas (cartera con muchos activos)
- Apps nativas separadas (Swift + Kotlin): coste de desarrollo x2, inviable para un equipo pequeño

---

## ADR-004 · Supabase como backend

**Fecha:** 2026-04-24
**Estado:** Vigente

**Decisión:** Supabase (PostgreSQL + Auth + Edge Functions + RLS + Storage) como backend principal.

**Por qué:** Ofrece auth, base de datos relacional, RLS por fila y Edge Functions en un solo servicio gestionado. El tier gratuito permite arrancar sin coste. SDK oficial para React Native.

**Alternativas descartadas:**
- Firebase: modelo de datos NoSQL menos adecuado para datos financieros relacionales; vendor lock-in más agresivo
- Backend propio (Node + Postgres): tiempo de desarrollo y mantenimiento mucho mayor para un equipo pequeño
- PlanetScale: no incluye auth ni storage nativos

---

## ADR-005 · WatermelonDB para sincronización local-servidor

**Fecha:** 2026-04-27
**Estado:** Vigente — supersede evaluación previa de PowerSync y Electric SQL

**Decisión:** WatermelonDB (MIT) como capa de persistencia local y sincronización con Supabase.

**Por qué:** Licencia MIT sin dependencia de terceros para el sync. Rendimiento probado en apps con miles de registros. API bien documentada para React Native. El protocolo de sync es implementable sobre cualquier backend REST/GraphQL, incluyendo Supabase Edge Functions.

**Alternativas descartadas:**
- PowerSync: servicio de pago con dependencia del proveedor para la capa de sync
- Electric SQL: en fase alpha en el momento de la evaluación, riesgo de cambios de API
- SQLite + sync manual: viable pero requiere implementar resolución de conflictos desde cero

---

## ADR-006 · Paddle como Merchant of Record

**Fecha:** 2026-04-24
**Estado:** Vigente

**Decisión:** Paddle gestiona pagos, facturación, IVA internacional y cumplimiento fiscal como Merchant of Record.

**Por qué:** Portgrow vende a usuarios de múltiples países. Gestionar IVA europeo, impuestos de ventas de EE.UU. y otros localmente es inviable para un equipo pequeño. Paddle asume esa responsabilidad legal.

**Alternativas descartadas:**
- Stripe: requiere gestionar el cumplimiento fiscal por países manualmente (complejidad y riesgo legal)
- RevenueCat: especializado en in-app purchases de App Store/Play Store, no en web

---

## ADR-007 · Modelo de datos: Kimball (analytics) + 3NF (operacional)

**Fecha:** 2026-04-24
**Estado:** Vigente

**Decisión:** Base de datos operacional en tercera forma normal (3NF) en el schema `public` de Supabase. DWH analítico en schema `analytics` con modelo dimensional Kimball (tablas de hechos + dimensiones).

**Por qué:** 3NF garantiza integridad referencial y facilita las operaciones CRUD del día a día. Kimball permite queries analíticas eficientes (rentabilidad histórica, distribución por grupos, evolución de cartera) sin afectar al rendimiento operacional.

**Alternativas descartadas:**
- Todo en 3NF: queries analíticas complejas y lentas a medida que crecen los datos
- Todo en modelo dimensional: actualizaciones e inserciones operacionales incómodas

---

## ADR-008 · Nombre comercial: Portgrow / portgrow.app

**Fecha:** 2026-04-28
**Estado:** Vigente

**Decisión:** El nombre comercial del producto es **Portgrow**. Dominio registrado: `portgrow.app` en IONOS.

**Por qué:** Combina "portfolio" y "grow" de forma clara para el público hispanohablante e internacional. `portgrow.app` disponible y sin conflictos de marca evidentes en los registros consultados. `portgrow.com` era un dominio premium (€2.500).

**Alternativas descartadas:**
- Portrak: empresa existente de seguimiento de mercados en portrak.com (conflicto de marca)
- Fintrack: dominio .com no disponible
- Cartrack: connotaciones de rastreo de automóviles ("car")
- Portrack / Porttrack: variantes evaluadas, Portgrow resultó más evocador del crecimiento

**Pendiente:** Búsqueda y registro de marca en EUIPO — clases 9, 36 y 42 (ver ESTADO.md sec. 32).

---

## ADR-009 · Dos entornos Supabase: dev y prod

**Fecha:** 2026-04-30
**Estado:** Vigente

**Decisión:** Dos proyectos Supabase independientes: `portgrow-dev` y `portgrow-prod`. Los cambios de schema solo llegan a prod mediante migraciones versionadas con Supabase CLI, nunca manualmente.

**Por qué:** Protege los datos reales de usuarios de experimentos y migraciones erróneas. Obliga a formalizar todos los cambios de schema desde el primer día, evitando la deuda técnica de "ya lo igualaré después".

**Alternativas descartadas:**
- Un solo proyecto con schemas separados (dev/prod): un error de migración puede afectar a datos reales
- Entorno dev local únicamente: no detecta problemas de permisos RLS ni de configuración Supabase real

---

## ADR-010 · Tabla central `user_consents` para todos los consentimientos

**Fecha:** 2026-04-30
**Estado:** Vigente

**Decisión:** Todos los consentimientos del usuario (GDPR, términos, backup, marketing) se almacenan en una única tabla `user_consents` con `consent_type`, `version`, timestamps de aceptación/revocación y trazabilidad de IP/user-agent.

**Por qué:** Punto único de auditoría para cumplimiento GDPR. Facilita gestionar versiones de políticas (al actualizar los términos, basta con comprobar si el usuario aceptó la versión actual). Evita campos dispersos en la tabla de usuarios que se vuelven difíciles de mantener.

**Alternativas descartadas:**
- Campos booleanos en la tabla `users` (`gdpr_accepted`, `backup_consent`…): no guarda historial ni versiones; incumple requisitos de trazabilidad GDPR
