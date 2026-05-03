# Portgrow — Análisis de negocio

> Versión 2.0 · Mayo 2026 · Documento de trabajo interno

---

## Resumen ejecutivo

**Portgrow** es una aplicación móvil de gestión de carteras de inversión personal para el inversor minorista español que opera con múltiples brokers. El mercado objetivo es España — sin expansión geográfica planificada a corto o medio plazo.

El diferenciador principal es la arquitectura **local-first**: los datos financieros del usuario se almacenan en su dispositivo y la sincronización con la nube es opcional y reversible. Este posicionamiento es técnicamente verificable y difícil de replicar por competidores con arquitecturas cloud ya establecidas.

La competencia en español existe y ha crecido: Capitally, OnePortfolio y AllInvestView operan en español con funcionalidades similares. El espacio no está vacío. La ventaja competitiva real de Portgrow no es la ausencia de competidores sino una combinación concreta de atributos que ningún competidor actual ofrece simultáneamente: **privacidad estructural + experiencia móvil completa + idioma español + sin dependencia de nube**. Hasta qué punto ese diferenciador es suficiente para captar usuarios de pago en un mercado español con baja disposición a pagar por software es la pregunta central sin respuesta definitiva todavía.

El modelo de negocio planteado es una suscripción anual con un nivel gratuito de captación, operado por un único desarrollador sin equipo ni financiación externa.

---

## 1. El problema

El inversor minorista español que gestiona su propio patrimonio en múltiples brokers enfrenta tres problemas reales:

**1.1 Fragmentación de carteras**
El inversor medio en España opera en 2-3 brokers (DEGIRO, Interactive Brokers, Trade Republic, su banco tradicional) sin ninguna herramienta que consolide toda su exposición en un punto. Las hojas de Excel siguen siendo la solución más usada, con todos sus problemas de mantenimiento y error manual.

**1.2 Privacidad de datos financieros**
Las aplicaciones disponibles almacenan carteras completas — operaciones históricas, dividendos, posiciones detalladas — en servidores de terceros. Para un número creciente de inversores, ceder información financiera sensible a una plataforma cloud sin control real sobre dónde viven esos datos es un problema genuino.

**1.3 Métricas de rentabilidad fiables**
Los brokers ofrecen rentabilidades calculadas solo sobre los activos que custodian, no sobre el conjunto del patrimonio. Calcular TWR real sobre carteras multi-broker es actualmente imposible sin una herramienta externa o trabajo manual en Excel.

---

## 2. La solución

Portgrow es una aplicación iOS, Android y web que permite al inversor:

- **Consolidar** todas sus posiciones y carteras en una vista única
- **Calcular** rentabilidad real con el método TWR (Time-Weighted Return)
- **Planificar** aportaciones con el simulador DCA integrado
- **Controlar** liquidez por broker y cuenta bancaria
- **Operar offline**: la app funciona sin conexión; la sincronización es opcional

**El diferenciador estructural: privacidad por arquitectura**

Los datos viven en el dispositivo del usuario. La sincronización con la nube requiere activación explícita y es reversible. Esto no es una promesa de política de privacidad — es una propiedad del diseño técnico que los competidores cloud no pueden adoptar sin rediseñar su producto desde cero.

**Limitación importante:** los datos de telemetría de uso del producto (pantallas visitadas, flujos completados) solo se capturarán de forma agregada y con consentimiento explícito del usuario, o no se capturarán. Es incompatible con el posicionamiento de privacidad recoger datos de comportamiento detallados por usuario. La estrategia de producto se apoya en feedback directo y NPS, no en telemetría masiva.

---

## 3. Mercado

### Mercado objetivo: España

| Dato | Valor | Fuente |
|---|---|---|
| Carteras de inversores minoristas activas en RV española (2024) | 551.084 | CNMV 2024 |
| % con un solo valor en cartera | 60,4% | CNMV 2024 |
| Valor mediano de cartera | 5.629 € | CNMV 2024 |
| Valor medio de cartera | 5.112 € | CNMV 2024 |
| Usuarios plataforma Finect (inversor DIY activo) | >1.000.000 | Finect 2025 |
| Inversión en fondos de inversión en España (2025) | 49.732 M€ | Récord histórico |

**Interpretación honesta del mercado:**

La cifra de 551.084 carteras es el universo total de inversores minoristas con actividad en renta variable española según la CNMV. No es el mercado objetivo de Portgrow. El 60,4% tiene un único valor en cartera y una mediana de ~5.600€ — eso describe un inversor ocasional, no un usuario que necesita consolidación multi-broker ni cálculo de TWR.

El segmento real al que Portgrow se dirige es más estrecho: inversor con al menos dos brokers, cartera superior a 20.000€, que realiza aportaciones periódicas y hace seguimiento activo de su rentabilidad. No existe un dato público que cuantifique exactamente ese segmento. La estimación de trabajo, basada en los datos de la CNMV y el tamaño de la comunidad Finect, sitúa ese universo entre **30.000 y 100.000 personas en España**. Es un mercado de nicho.

**Implicación directa para el modelo de negocio:** incluso capturando el 5% del segmento objetivo (1.500–5.000 usuarios de pago), los ingresos son modestos. Portgrow no es un negocio de venture capital. Es un negocio de nicho que puede funcionar de forma sostenible como proyecto indie.

---

## 4. Competencia

### Análisis actualizado (mayo 2026)

| Competidor | Español | Móvil | Privacidad | Spain tax | Precio | Debilidad vs. Portgrow |
|---|---|---|---|---|---|---|
| **AllInvestView** | Sí (UI completa) | No (web responsive) | Cloud | Sí — Modelo 720, AEAT, tramos IRPF | ~6-17€/mes | Sin app móvil nativa; cloud-only; sin offline |
| **Capitally** | Sí | Sí (nativo) | E2E encrypt + offline | No | ~7-11€/mes (estimado) | Offline parcial (no confirmado SQLite real); sin Spain tax features |
| **OnePortfolio** | Sí (parcial) | No (web) | Cloud | No | 8-11 $/mes | Sin app móvil; lanzado 2025, aún inmaduro; cloud-only |
| **Portseido** | No (solo inglés) | Sí (iOS/Android) | Cloud | No | 8-12 $/mes | Sin español; cloud-only; sin Spain tax features |
| **Portfolio Performance** | No | Solo lectura | Local (desktop) | No | Gratis | Sin español; entrada de datos solo en desktop; sin móvil funcional |
| **Sharesight** | No | Sí | Cloud | No | 7-23 $/mes | Sin español; sin Spain tax features; cloud-only |
| **Wealthfolio** | No | Parcial | Local (desktop+) | No | Freemium | Sin español; orientado a desktop; sin Spain tax features |

### Observaciones relevantes

**AllInvestView es el competidor que más se pasa por alto y que más daño puede hacer.** Es el único tracker con soporte completo del Modelo 720, integración con AEAT y tramos del IRPF español. Tiene versión en español, cubre el BME y soporta sincronización con DEGIRO e Interactive Brokers. Si el usuario español necesita gestionar su declaración fiscal, AllInvestView resuelve algo que Portgrow no resuelve en v1. La ausencia de app móvil nativa es su principal debilidad.

**Capitally es el competidor arquitectónicamente más parecido a Portgrow.** Tiene cifrado extremo a extremo, afirma soporte offline, app móvil nativa y versión en español. Si su "offline" es SQLite real y no un PWA installable, su propuesta de privacidad es comparable. Diferencia actual: no tiene features de fiscalidad española y su pricing no es público (señal de que no tiene una propuesta clara todavía).

**Portfolio Performance** tiene app móvil desde 2025, pero es solo de lectura. Para introducir operaciones, el usuario necesita el software de escritorio. Es una limitación estructural para usuarios que quieren registrar operaciones desde el móvil en el momento de la compra.

**Portseido no tiene interfaz en español.** A diferencia de lo que se asumía antes, esto lo excluye automáticamente del segmento de usuarios no angloparlantes.

### Ventaja competitiva real de Portgrow

La combinación **privacidad estructural (local-first) + app móvil completa + español nativo** no la ofrece actualmente ningún competidor. Capitally se acerca más, pero sin confirmación de su arquitectura real y sin features de fiscalidad española.

**Riesgo competitivo principal:** Capitally o OnePortfolio pueden añadir la capa de fiscalidad española en cualquier momento. El moat es estrecho y requiere ejecución rápida.

---

## 5. Modelo de negocio

### Propuesta de valor por segmento

**Plan gratuito** *(adquisición)*
1 cartera, hasta 30 operaciones, funcionalidades básicas. Sin límite de tiempo. Objetivo: demostrar valor antes de pedir dinero.

**Plan Personal — suscripción anual: 24-36€/año**
Carteras ilimitadas, operaciones ilimitadas, exportación CSV/Excel, sincronización multi-dispositivo opcional, backup automático, actualizaciones continuas.

La sincronización y el backup son los únicos componentes con coste de infraestructura real para el desarrollador. Son también las únicas funcionalidades que justifican una suscripción recurrente. El modelo de pago único (que aparecía en versiones anteriores de este documento) se descarta: complica la comunicación de valor, mezcla ingresos recurrentes y no recurrentes, y no encaja con un producto que se mejora continuamente.

### Proyección de ingresos (España, escenario conservador-realista)

| Año | Usuarios gratuitos | Conversión | Usuarios de pago | Ingresos anuales |
|---|---|---|---|---|
| Año 1 (post-lanzamiento) | 500 | 12% | 60 | ~1.800 € |
| Año 2 | 2.000 | 15% | 300 | ~9.000 € |
| Año 3 | 6.000 | 18% | 1.080 | ~32.400 € |

*Precio medio asumido: 30€/año. Sin ingresos B2B incluidos.*

**Nota sobre estas cifras:** son modestas porque el mercado objetivo es pequeño y la distribución sin presupuesto de marketing es lenta. No son ingresos que reemplacen un sueldo. Son ingresos consistentes con un proyecto personal bien ejecutado en un nicho real. Si en el año 3 el producto tiene 1.000 suscriptores activos, eso es validación suficiente para considerar si escalar o mantener.

**Lo que no está incluido y podría cambiar el escenario:**
- Plan para asesores financieros (EAFIs) si se añade Modelo 720 y AEAT — segmento pequeño pero con alto LTV
- Si algún competidor abandona el mercado o sube precios significativamente

---

## 6. Producto

### Estado actual

El **Prototipo v6** está completo — dos rondas de testers cerradas, feedback recogido e implementado. Es un prototipo HTML autocontenido (sin backend) que valida flujos de usuario. Incluye 18 pantallas funcionales con modo básico/avanzado.

### Roadmap

| Fase | Entregable | Estimación |
|---|---|---|
| **Prototipo 2** | React Native + WatermelonDB + Supabase: validación de la arquitectura local-first con datos reales y sync | 4-6 meses |
| **Beta cerrada** | App iOS + Android funcional con 50-100 usuarios beta reales | 8-12 meses |
| **v1.0** | App Store + Google Play, Plan Personal disponible, sin cotizaciones automáticas | 12-18 meses |
| **v1.5** | Cotizaciones en tiempo real, Modelo 720 / AEAT (si se confirma demanda) | 18-24 meses |
| **v2.0** | Comparativo de escenarios DCA, proyección sobre cartera real | 24-30 meses |

### Stack tecnológico

- **Frontend:** React Native + Expo (iOS, Android, Web)
- **Base de datos local:** WatermelonDB (SQLite)
- **Sincronización:** PowerSync (sobre Supabase) — dependencia de tercero, coste recurrente (~49 $/mes en producción en plan base). Alternativa: Electric SQL. Decisión pendiente de comparativa técnica.
- **Backend:** Supabase (PostgreSQL, Auth, Storage, Edge Functions, RLS)
- **Pagos:** Paddle (Merchant of Record)
- **Analytics operacional:** BigQuery + dbt Core + Looker Studio (separado del stack de app para no afectar rendimiento)

### Estrategia de datos de mercado (cotizaciones)

**yfinance no es una opción para producción.** La librería usa endpoints no oficiales de Yahoo Finance, viola explícitamente los Términos de Servicio de Yahoo para uso comercial y no ofrece ningún SLA. Yahoo puede cortar el acceso en cualquier momento. Usarla en un producto de pago es un riesgo legal y operacional.

Opciones reales para cotizaciones en producción, con cobertura del BME (Bolsa de Madrid):

| Proveedor | Cobertura BME | Precio orientativo | Notas |
|---|---|---|---|
| **EODHD** | Sí (código MC) | ~20-100€/mes (personal); commercial requiere contacto | Opción más económica para datos EOD europeos |
| **Twelve Data** | Sí (XMAD) | Business tier, precio por contacto | Requiere plan Pro ($229/mes) o Business para XMAD |
| **Alpha Vantage** | A confirmar | Commercial license, precio por contacto | NASDAQ-licenciado; bajo riesgo legal |

**Conclusión:** el coste de datos de mercado en producción es entre 20 y 200€/mes dependiendo del proveedor y el volumen. No es trivial y no está amortizado hasta tener cientos de usuarios de pago. En v1.0 (sin cotizaciones automáticas), este coste no existe.

---

## 7. Análisis DAFO

### Fortalezas

- **Privacidad estructural (local-first):** el único tracker en español con datos que viven en el dispositivo del usuario. No es una promesa de política — es una propiedad arquitectónica que los competidores cloud no pueden copiar sin rediseñar su producto.
- **App móvil completa:** a diferencia de Portfolio Performance (solo lectura en móvil) o OnePortfolio (web responsive), Portgrow permitirá registrar operaciones desde el móvil.
- **Español nativo:** diseñado y desarrollado en español desde el inicio, no traducido.
- **Sin anuncios ni monetización de datos:** refuerza el argumento de privacidad con hechos, no solo con promesas.
- **Prototipo con dos rondas de feedback:** validación real de flujos y UX antes de construir la app nativa.
- **Coste de infraestructura bajo en v1.0:** sin cotizaciones automáticas, el coste de servidor es mínimo (Supabase free tier hasta cierta escala).

### Debilidades

- **Sin fiscalidad española en v1:** AllInvestView ya resuelve Modelo 720 y AEAT. Para el inversor que necesita esas funcionalidades, Portgrow no es suficiente hasta v1.5 como mínimo.
- **Un solo desarrollador:** toda la velocidad de desarrollo y mantenimiento depende de una única persona. Cualquier interrupción (salud, motivación, prioridades) detiene el proyecto.
- **Sin presupuesto de marketing:** la adquisición depende exclusivamente de contenido orgánico, comunidades de inversión y boca a boca. Es lenta.
- **Stack complejo:** React Native + WatermelonDB + sync es una arquitectura no trivial. El riesgo de que la capa de sync (PowerSync/Electric SQL) introduzca problemas difíciles de depurar es real.
- **Sin cotizaciones en v1.0:** el usuario tiene que introducir cotizaciones manualmente. Para algunos usuarios esto es un bloqueante; para otros (que confían más en sus propios datos) es aceptable.

### Oportunidades

- **Segmento DIY español en crecimiento:** la comunidad inversora en español (blogs, podcasts, canales de YouTube) tiene audiencias de cientos de miles de seguidores. Son canales de distribución naturales si el producto tiene calidad suficiente para generar recomendaciones orgánicas.
- **Modelo 720 y fiscalidad española como expansión:** si se añaden estas funcionalidades, Portgrow se convierte en el único tracker que combina privacidad real con cumplimiento fiscal español — diferenciador muy difícil de replicar rápido por la competencia.
- **Asesores financieros independientes (EAFIs):** pequeño segmento pero con disposición a pagar más alta si el producto ofrece informes AEAT. Solo planteable después de que la versión de consumo funcione.
- **Portfolio Performance como referencia de migración:** sus usuarios buscan activamente alternativas con móvil. Son usuarios técnicamente sofisticados y con alta disposición a pagar.

### Amenazas

- **Capitally o AllInvestView añaden la pieza que les falta:** Capitally sin fiscalidad española y AllInvestView sin app móvil — si cualquiera de los dos cierra esa brecha, el espacio de Portgrow se comprime significativamente.
- **Disposición a pagar en España:** el mercado español tiene históricamente baja disposición a pagar por software. El argumento de privacidad puede justificar el precio para un segmento, pero no para la mayoría.
- **Abandono del proyecto:** el mayor riesgo operacional es que el desarrollador pierda el interés o el tiempo antes de llegar a v1.0. No hay colchón de equipo ni financiación que lo mitigue.
- **Dependencia de terceros en el stack:** PowerSync/Electric SQL, Supabase, Paddle, EODHD/Twelve Data son todos proveedores externos que pueden cambiar condiciones o precios. La arquitectura local-first mitiga parcialmente este riesgo (si Supabase desaparece, los datos del usuario siguen en su dispositivo), pero la sync se pierde.

---

## 8. Barreras de entrada (Moat)

Evaluación honesta de las barreras reales, no de las aspiracionales:

**Switching costs — el más sólido, condicionado a retención**
Si un usuario registra 12-24 meses de operaciones en Portgrow, migrar ese historial es costoso. Esta barrera solo existe si el usuario usa el producto activamente. Sin retención real, no hay switching cost.

**Moat arquitectónico — real pero estrecho**
La arquitectura local-first es técnicamente difícil de copiar para competidores cloud establecidos. Es una barrera real. Capitally tiene una propuesta similar; si su implementación es equivalente, la ventaja se diluye.

**Contenido y comunidad — débil a corto plazo**
Un blog, webinars y YouTube son valiosos para adquisición, pero no son barreras duraderas. Cualquier competidor con más recursos los puede replicar. Su valor real está en la distribución, no en la defensibilidad.

**Network effects — prácticamente inexistentes**
Un portfolio tracker es una utilidad individual. Compartir carteras con permisos granulares añade un elemento social marginal, pero no hay efectos de red significativos en este tipo de producto.

**Data moat — incompatible con el posicionamiento de privacidad**
Capturar datos de comportamiento detallados por usuario (pantallas visitadas, activos registrados, flujos completados) contradice directamente el argumento de "tus datos nunca salen de tu dispositivo." No es posible tener los dos a la vez de forma creíble. La estrategia de producto se apoya en telemetría opt-in mínima (datos agregados sin identificación de usuario) o en feedback directo, no en un data moat.

**Conclusión:** el moat real de Portgrow en el horizonte de 3-5 años es switching costs + arquitectura. Los demás son más débiles de lo que parecen sobre el papel.

---

## 9. Financiación pública disponible

> Esta sección es orientativa. Ninguna de las ayudas mencionadas está confirmada como accesible para este proyecto. Cada convocatoria tiene requisitos propios que deben contrastarse en el momento de la solicitud.

**ACCIÓ Startup Capital (Cataluña)**
Subvención a fondo perdido de hasta 99.000€ al 75% del coste del proyecto (no al 100% como figuraba en versiones anteriores de este documento). La convocatoria puede estar cerrada en el momento de lectura de este documento — verificar en la web de ACCIÓ antes de planificar sobre esta base. Requiere startup tecnológica con innovación propia, lo que exige argumentar qué parte del stack es tecnología diferencial propia y no solo ensamblaje de herramientas de terceros.

**NEOTEC (CDTI)**
Subvención a fondo perdido de hasta 250.000€. Requiere que la ventaja competitiva esté basada en tecnología propia, no en servicios de terceros. Para Portgrow, el argumento debe centrarse en la capa de sync local-first y la arquitectura de privacidad, no en el uso de Supabase o React Native (que son herramientas estándar). Es la convocatoria más exigente y competitiva del ecosistema español de financiación pública para startups.

**ENISA (préstamos participativos)**
25.000€–75.000€ sin garantías personales, hasta 9 años de devolución. Más accesible que NEOTEC pero sigue requiriendo una empresa constituida con un mínimo de tracción.

**Ley Startup 2022**
Marco fiscal favorable que aplica automáticamente a startups certificadas: IS al 15% durante los primeros 4 años rentables, aplazamiento de impuestos, stock options exentas hasta 50.000€/año. No es una subvención sino una reducción de carga fiscal futura.

---

## 10. Por qué ahora

**El problema existe y crece.** La comunidad inversora DIY en España lleva años creciendo — Finect tiene más de un millón de usuarios, los canales de YouTube sobre inversión en español tienen cientos de miles de seguidores. Todos ellos usan Excel o apps en inglés. La necesidad está creada; el producto que la resuelve bien aún no existe.

**La tecnología local-first es ahora madura.** Hace tres años, construir sync offline-first requería implementar CRDTs desde cero. Hoy, WatermelonDB + PowerSync o Electric SQL lo abstraen con documentación pública y comunidades activas. El momento técnico es el correcto.

**El perfil del desarrollador es el adecuado para este proyecto.** Un ingeniero con 30 años de experiencia, que es él mismo el cliente objetivo, que tiene tiempo sin presión financiera para construirlo bien y sin atajos. Eso no elimina los riesgos de un mercado pequeño, pero es la combinación más favorable para un producto de nicho.

**Lo que no se sabe todavía:** si el segmento objetivo pagará. El prototipo valida flujos de usuario, no disposición a pagar. La primera validación real del negocio ocurrirá cuando la app nativa esté en producción y se pida dinero real a usuarios reales.

---

*Documento preparado en mayo de 2026. Las proyecciones financieras son estimaciones de trabajo, no previsiones contables. Los datos de competencia corresponden a mayo de 2026 y pueden haber cambiado.*

---

**Fuentes contrastadas:**
- CNMV — Participación minorista en mercados de valores españoles 2024
- Finect — Datos de comunidad 2025
- Portseido — Pricing y features (portseido.com, mayo 2026)
- OnePortfolio — Pricing y features (oneportfolio.io, mayo 2026)
- Portfolio Performance — App móvil (portfolio-performance.app, mayo 2026)
- AllInvestView — Features y pricing (allinvestview.com, mayo 2026)
- Capitally — Features (mycapitally.com, mayo 2026)
- yfinance — GitHub README y Yahoo ToS
- EODHD — Pricing y cobertura de exchanges (eodhd.com, mayo 2026)
- Twelve Data — Pricing y exchanges (twelvedata.com, mayo 2026)
