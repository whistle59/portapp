# portapp — Documento de negocio para inversores

> Versión 1.1 · Abril 2026 · Confidencial

---

## Resumen ejecutivo

**portapp** es una aplicación móvil y web de gestión de carteras de inversión personal, diseñada para el inversor minorista hispanohablante que gestiona su patrimonio de forma autónoma. El mercado objetivo es España y Latinoamérica — un universo de más de **500 millones de hispanohablantes** donde la oferta de herramientas de inversión en español es prácticamente inexistente y la comunidad DIY (Do It Yourself) crece de forma acelerada.

A diferencia de los competidores existentes, portapp adopta una arquitectura **local-first** que garantiza que los datos financieros del usuario nunca abandonan su dispositivo sin su consentimiento explícito — el único producto del mercado hispanohablante que combina privacidad real, funcionamiento offline completo y sincronización multi-dispositivo opcional.

El mercado latinoamericano de fintech alcanzó **71.360 millones de dólares en 2024**, con más de 415 millones de usuarios de servicios financieros digitales y un crecimiento del 27% anual en financiación. En España, el número de carteras de inversores minoristas alcanzó las **551.000 en 2024**, con una rentabilidad media del 16,3% ese año, reflejo de una comunidad inversora madura y activa.

portapp opera un modelo de monetización híbrido — pago único por la app base + suscripción anual por servicios con coste recurrente real + licencias B2B para asesores financieros — que combina bajas barreras de adquisición con ingresos recurrentes predecibles.

El equipo busca una inversión inicial para completar el desarrollo del producto y ejecutar el lanzamiento en España, con expansión natural al mercado hispanohablante latinoamericano.

---

## 1. El problema

El inversor minorista hispanohablante que gestiona su propio patrimonio se enfrenta a tres problemas no resueltos:

**1.1 Fragmentación de carteras**
El inversor medio opera en 2-3 brokers distintos (DEGIRO, Interactive Brokers, Coinbase, banca tradicional) sin ninguna herramienta que consolide su visión patrimonial en un único lugar. Las hojas de Excel siguen siendo la solución más utilizada — con todos sus problemas de mantenimiento, error humano y falta de análisis.

**1.2 Privacidad comprometida**
Las aplicaciones existentes almacenan datos financieros detallados en servidores de terceros — carteras completas, operaciones históricas, dividendos cobrados, IBANs. Ceder información tan sensible sin control real sobre dónde viven los datos es una barrera de adopción creciente, especialmente en un contexto post-RGPD en España y con el auge de la conciencia sobre privacidad digital en Latinoamérica.

**1.3 Ninguna solución en español de calidad**
Los líderes del mercado (Sharesight, Snowball Analytics, Portfolio Performance) están diseñados para mercados anglosajones y disponibles solo en inglés. Las pocas alternativas en español son superficiales, sin análisis real de rentabilidad, sin soporte para múltiples carteras ni múltiples brokers. La comunidad hispanohablante de inversores DIY — enorme y en rápido crecimiento — carece de una herramienta profesional en su idioma.

---

## 2. La solución

portapp es una aplicación iOS, Android y web que permite al inversor minorista:

- **Consolidar** todas sus carteras en una sola vista — acciones, ETFs, criptomonedas, efectivo
- **Analizar** su rentabilidad real con el método TWR (Time-Weighted Return), el estándar profesional
- **Planificar** su estrategia de aportaciones con el simulador DCA integrado
- **Controlar** su liquidez con el módulo de gestión de efectivo por broker y cuenta bancaria
- **Compartir** carteras de forma segura con asesores o familiares con permisos granulares

**El diferenciador clave: privacidad por diseño**

Los datos financieros del usuario viven en el dispositivo (SQLite local). La sincronización con la nube es opcional y reversible. El argumento de venta — *"tus datos de inversión nunca salen de tu dispositivo"* — es único en el mercado hispanohablante y directamente relevante en el contexto regulatorio y cultural actual.

**En español, desde el primer día**

La app está diseñada y desarrollada en español. No es una traducción — es un producto pensado para el inversor hispanohablante, con la terminología financiera correcta en español y adaptado a la fiscalidad y los instrumentos de inversión más comunes en España y Latinoamérica.

---

## 3. Mercado

### Mercado principal: España

| Dato | Valor |
|---|---|
| Carteras de inversores minoristas (2024) | 551.000 |
| Rentabilidad media del inversor minorista (2024) | +16,3% |
| Crecimiento inversión pasiva / ETFs | Tendencia estructural al alza |
| Ecosistema fintech España | Regulación favorable (Ley Startup 2022, sandbox regulatorio) |

España es un punto de entrada estratégico: mercado maduro, regulación favorable, comunidad inversora DIY consolidada (blogs, podcasts, canales de YouTube en español con cientos de miles de seguidores) y cultura financiera creciente impulsada por el movimiento FIRE y la inversión en índices.

### Mercado de expansión: Latinoamérica

| Dato | Valor |
|---|---|
| Mercado fintech LatAm (2024) | $71.360M |
| Proyección mercado fintech LatAm (2033) | $125.880M (CAGR ~6,5%) |
| Usuarios fintech en la región (2022) | +415 millones |
| Startups fintech activas | +3.000 en 26 países |
| Financiación fintech LatAm (2025) | $4.100M (+13,8% vs 2024) |
| Fintech como % del VC en México (2024) | 74% |

México, Argentina y Colombia son los mercados más maduros de la región. El inversor DIY hispanohablante en Latinoamérica crece aceleradamente, impulsado por el acceso a brokers internacionales (Interactive Brokers, eToro) y una oferta de contenido educativo en español cada vez mayor — sin herramientas profesionales de seguimiento acordes.

### Oportunidad específica

La comunidad hispanohablante ha sido históricamente desatendida en el espacio de inversión. No existe ninguna aplicación de gestión de carteras en español con las capacidades de portapp. El mercado potencial total (TAM) en el segmento hispanohablante supera los 500 millones de personas, con un núcleo de inversores activos estimado en varios millones creciendo año a año.

---

## 4. Competencia

### Análisis competitivo

| Competidor | Fortalezas | Debilidades vs. portapp |
|---|---|---|
| **Sharesight** | 500.000+ usuarios globales, informes fiscales, marca consolidada | Solo en inglés, datos en servidores cloud, sin offline, $7-23/mes, sin soporte mercado español |
| **Snowball Analytics** | Perspectiva europea, herramientas de optimización | Solo en inglés, datos en servidor, $12-15/mes |
| **Portfolio Performance** | Gratuito, potente, privado (local) | Solo desktop, sin móvil, sin sync, curva de aprendizaje alta, sin español |
| **Portseido** | Soporte para inversores españoles | Sin offline, datos en servidor, funcionalidades limitadas |
| **Hoja de Excel** | Flexible, privada | Sin automatización, sin cotizaciones, mantenimiento manual |
| **Apps de broker** | Integración directa | Solo muestra activos de ese broker, sin visión consolidada |

### Ventaja competitiva sostenible

portapp ocupa un espacio no disputado: **privacidad real + experiencia móvil fluida + español nativo**. Portfolio Performance es la única solución verdaderamente privada comparable, pero es exclusivamente desktop, no tiene versión móvil y requiere conocimientos técnicos avanzados. Ningún competidor actual combina los tres atributos simultáneamente para el mercado hispanohablante.

---

## 5. Modelo de negocio

### Estructura de ingresos

**Tier 1 — Plan gratuito** *(adquisición)*
1 cartera, hasta 20 operaciones, funcionalidades básicas. Sin límite de tiempo. Objetivo: eliminar fricción de entrada y demostrar valor.

**Tier 2 — Plan Personal: pago único 29-49€**
Carteras ilimitadas, operaciones ilimitadas, exportación CSV/Excel, importación PDF de broker, alertas configurables, compartir cartera. Actualizaciones durante 1 año.

**Tier 2+ — Suscripción anual de servicios: 12-24€/año**
Solo para funciones con coste de infraestructura real y valor tangible:
- Cotizaciones en tiempo real (API de mercados)
- Sincronización multi-dispositivo en la nube
- Backup automático
- Actualizaciones pasado el primer año

**Tier 3 — Plan Profesional B2B: 50-150€/mes por usuario**
Asesores financieros independientes, family offices. Acceso de lectura a carteras de clientes, informes PDF exportables, panel de gestión multi-cliente.

### Proyección de ingresos (escenario conservador)

| Año | Usuarios gratuitos | Conversión Plan Personal | ARR estimado |
|---|---|---|---|
| Año 1 | 2.000 | 8% (160 usuarios) | ~7.000€ |
| Año 2 | 12.000 | 10% (1.200 usuarios) | ~75.000€ |
| Año 3 | 40.000 | 12% (4.800 usuarios) | ~320.000€ |

*Proyección basada en métricas de conversión de apps fintech similares. No incluye ingresos B2B ni suscripciones de servicios, que pueden representar un multiplicador significativo.*

---

## 6. Producto

### Estado actual

El **Prototipo v6** está completo y en pruebas con usuarios reales. Es un prototipo HTML autocontenido que valida flujos y experiencia de usuario, sin backend. Incluye 16 pantallas funcionales: global, resumen, cartera, efectivo, operaciones, rentabilidad TWR, proyección DCA, índices, guía de uso integrada y preguntas frecuentes.

### Roadmap

| Fase | Entregable | Plazo estimado |
|---|---|---|
| **Prototipo 2** | Validación arquitectura local-first: React Native + Expo SQLite + PowerSync + Supabase | 3-4 meses |
| **Beta cerrada** | App iOS + Android con funcionalidades core, 100 usuarios beta | 6-8 meses |
| **Lanzamiento v1** | App Store + Google Play + Web, Plan Personal disponible | 10-12 meses |
| **v1.1** | Plan Profesional B2B, importación PDF de broker con IA | 14-16 meses |
| **v2** | Expansión Latinoamérica, fiscalidad local por país | 18-24 meses |

### Stack tecnológico

- **Frontend:** React Native + Expo (iOS, Android y Web desde una base de código)
- **Base de datos local:** Expo SQLite
- **Sincronización:** PowerSync / Electric SQL
- **Backend:** Supabase (PostgreSQL, Auth, Storage, Edge Functions, RLS)
- **Pagos:** Paddle (Merchant of Record — gestiona IVA y facturación)
- **Cotizaciones:** Yahoo Finance API / Alpha Vantage

---

## 7. Análisis DAFO

### Fortalezas

- **Único producto profesional en español** — no existe ningún competidor con las capacidades de portapp en español. Es el primer entrante en un mercado desatendido.
- **Privacidad como diferenciador estructural** — arquitectura local-first que ningún competidor principal ofrece. No es marketing: los datos no pueden ser vendidos, hackeados del servidor ni cedidos a terceros.
- **Funcionamiento offline completo** — el usuario consulta y registra operaciones sin conexión. Relevante en mercados latinoamericanos con conectividad variable.
- **Comunidad hispanohablante ya educada** — existe un ecosistema maduro de blogs, podcasts y canales de YouTube sobre inversión en español (El Inversor Inteligente, Indexa Capital, Finect…) que genera demanda orgánica y facilita la distribución.
- **Coste de infraestructura mínimo** — la arquitectura local-first desplaza el coste computacional al dispositivo. El backend gestiona solo sync, auth y licencias.
- **Prototipo validado con usuarios reales** — 16 pantallas funcionales en pruebas con inversores reales.
- **Modelo de monetización sin publicidad** — los datos financieros del usuario nunca se monetizan, lo que refuerza el argumento de privacidad.
- **Escalabilidad geográfica natural** — España como mercado de validación, con expansión natural a México, Argentina, Colombia y Chile sin cambio de idioma ni de producto.

### Debilidades

- **Equipo pequeño en fase inicial** — el desarrollo requiere incorporar desarrolladores React Native y expertise en sync de datos distribuidos.
- **Sin cotizaciones automáticas aún** — la integración con APIs de datos de mercado está pendiente. Sin cotizaciones en tiempo real el cálculo de rentabilidad depende de actualizaciones manuales.
- **Reconocimiento de marca cero** — la adquisición de los primeros usuarios requerirá inversión en contenido, comunidad y marketing.
- **Complejidad técnica del sync** — sincronizar SQLite local con PostgreSQL de forma transparente es un problema técnico no trivial. PowerSync y Electric SQL mitigan este riesgo pero añaden dependencia de terceros.
- **Mercado sensible a la confianza** — los usuarios son reacios a probar apps nuevas con sus datos financieros. La curva de adopción puede ser más lenta que en otras categorías.
- **Fragmentación fiscal en Latinoamérica** — cada país tiene su propia fiscalidad de inversiones. El soporte fiscal localizado por país es un desarrollo considerable para la v2.

### Oportunidades

- **Mercado hispanohablante sin competidor directo** — el espacio está prácticamente vacío. El primer producto de calidad en capturarlo tiene ventaja de pionero significativa.
- **Crecimiento estructural de la inversión DIY en España** — el número de carteras minoristas crece año a año, impulsado por la cultura de inversión pasiva y los ETFs de bajo coste.
- **Explosión fintech en Latinoamérica** — $4.100M de inversión en 2025 (+13,8%), con México, Colombia y Argentina como mercados principales. El inversor DIY latinoamericano crece en paralelo al acceso a brokers internacionales.
- **Comunidad de contenido en español como canal de distribución** — youtubers, podcasters y bloggers de inversión en español tienen audiencias de cientos de miles de seguidores. Son canales de distribución naturales y alineados con el producto.
- **Privacidad como argumento regulatorio en España/UE** — el RGPD ha educado al usuario español sobre sus derechos. Una app que garantiza estructuralmente la privacidad tiene un argumento diferencial que resuena de forma natural.
- **Segmento B2B asesor financiero** — los asesores financieros independientes en España (EAFIs) y Latinoamérica carecen de herramientas asequibles de seguimiento multi-cliente. El Plan Profesional puede generar ingresos recurrentes significativos.
- **Movimiento FIRE en español** — la comunidad de independencia financiera en español crece aceleradamente, con perfiles de alta intención de uso de herramientas de gestión patrimonial.

### Amenazas

- **Entrada de brokers con funcionalidades consolidadas** — brokers como DEGIRO, Interactive Brokers o Revolut podrían desarrollar vistas consolidadas. Sin embargo, tienen conflicto de interés estructural (no quieren mostrar activos de la competencia) y sus arquitecturas cloud no pueden replicar el argumento de privacidad.
- **Competidores anglosajones que añaden español** — Sharesight o Snowball Analytics podrían lanzar versión en español. Sería un competidor serio, aunque sin el diferencial de privacidad local-first.
- **Resistencia al pago en mercados latinoamericanos** — en algunos mercados de Latinoamérica la predisposición al pago por software es menor. El modelo freemium y el precio de entrada bajo (29-49€ pago único) mitigan este riesgo.
- **Dependencia de APIs de datos de mercado** — las APIs de cotizaciones pueden cambiar condiciones en cualquier momento. Requiere estrategia multi-fuente.
- **Retención a largo plazo** — las apps de portfolio tracker tienen un problema conocido de retención. La estrategia de contenido educativo (canales curados, formación) y las notificaciones activas son mitigantes parciales.
- **Volatilidad del contexto macroeconómico** — en entornos de mercados bajistas, la actividad inversora DIY cae. El producto debe aportar valor también en escenarios de pérdidas, no solo de ganancias.

---

## 8. Uso de los fondos

*(Indicativo — a detallar con el inversor)*

| Partida | % orientativo |
|---|---|
| Desarrollo Prototipo 2 y Beta (React Native + sync) | 50% |
| Diseño UX/UI profesional | 10% |
| Infraestructura y licencias (Supabase, APIs, Paddle) | 10% |
| Marketing, comunidad y adquisición primeros usuarios | 20% |
| Legal (constitución, propiedad intelectual, RGPD) | 10% |

---

## 9. Por qué ahora

Tres tendencias convergen en este momento:

**1. El inversor DIY hispanohablante existe y carece de herramientas**
La comunidad de inversión en español lleva años creciendo — canales de YouTube con 500.000+ seguidores, podcasts con decenas de miles de oyentes, foros activos. Todos ellos usan hojas de Excel o apps en inglés. La demanda está creada; el producto no existe.

**2. Madurez tecnológica del local-first**
Hace tres años, construir una app local-first con sync transparente requería implementar CRDTs desde cero. Hoy, PowerSync y Electric SQL abstraen esa complejidad. El momento técnico para construir portapp es ahora, con un coste de desarrollo significativamente menor que hace dos años.

**3. LatAm fintech en el mejor momento inversor de su historia**
$4.100M invertidos en 2025, un 13,8% más que en 2024. El ecosistema latinoamericano de fintech está maduro, los inversores están activos y el mercado de usuarios fintech supera los 415 millones. Entrar ahora en España con visión de expansión latinoamericana es posicionarse en el momento de máximo crecimiento.

---

*Documento preparado en abril de 2026. Información financiera proyectada con carácter orientativo.*

---

**Fuentes de referencia:**
- [CNMV — Análisis del comportamiento de inversores minoristas](https://www.cnmv.es/DocPortal/Publicaciones/MONOGRAFIAS/DT_78_Comp_minoristas_COVID_ENen.pdf)
- [Funds Society — Más inversores minoristas y crecimiento de ETFs](https://www.fundssociety.com/es/noticias/negocio/mas-inversores-minoristas-crecimiento-de-los-etfs-y-menores-margenes-asi-es-la-foto-del-negocio-europeo-de-fondos/)
- [TechCrunch — Latin America fintech 2025](https://techcrunch.com/2024/11/24/latin-america-fintech-will-be-a-market-to-watch-in-2025/)
- [Virtue Market Research — Latin America Fintech Market 2023-2030](https://virtuemarketresearch.com/report/latin-america-fintech-market)
- [Crunchbase — LatAm Startup Funding 2025](https://news.crunchbase.com/venture/vcs-bullish-latam-startup-funding-rebounds-2025/)
- [AllInvestView — Best Portfolio Trackers for Spanish Investors](https://www.allinvestview.com/best-portfolio-tracker-spain/)
- [Capitally — Best Portfolio Tracker 2025](https://www.mycapitally.com/blog/best-portfolio-tracker-for-the-modern-diy-investor)
- [Finance Magnates — GDPR as Competitive Advantage](https://www.financemagnates.com/fintech/how-fintech-companies-can-use-gdpr-as-a-competitive-advantage/)
