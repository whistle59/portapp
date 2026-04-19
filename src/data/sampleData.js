/**
 * portapp — estructuras de datos y datos de ejemplo
 * Usar como referencia para el esquema de base de datos en producción
 */

// ─── CARTERAS ────────────────────────────────────────────────────────────────

export const carteras = [
  { id: 'c1', nombre: 'Cartera Principal', desc: 'Inversión a largo plazo', divisa: 'EUR', color: '#185FA5' },
  { id: 'c2', nombre: 'Pensión 2045',      desc: 'DCA mensual índices globales', divisa: 'EUR', color: '#1D9E75' },
  { id: 'c3', nombre: 'Especulativa',      desc: 'Cripto y tech de alto riesgo', divisa: 'USD', color: '#BA7517' },
];

// ─── ACTIVOS ─────────────────────────────────────────────────────────────────

export const activos = [
  {
    ticker: 'AAPL',
    nombre: 'Apple Inc.',
    isin: 'US0378331005',
    tipo: 'Acción',          // Acción | ETF | Cripto | Bono | Fondo
    broker: 'Interactive Brokers',
    grupo: 'AI/Tech',
    divisa: 'USD',
    mercado: 'NASDAQ',
    qty: 10,
    pm: 170,                 // precio medio de compra
    cot: 185,                // cotización actual (en producción: desde API)
    cartera: 'c1',
    indice: '-',
    region: { USA: 100 },
    exposDiv: { USD: 100 },  // exposición porcentual por divisa
  },
  {
    ticker: 'VWCE',
    nombre: 'Vanguard FTSE All-World',
    isin: 'IE00BK5BQT80',
    tipo: 'ETF',
    broker: 'DEGIRO',
    grupo: 'Core',
    divisa: 'EUR',
    mercado: 'XETRA',
    qty: 20,
    pm: 105,
    cot: 112,
    cartera: 'c1',
    indice: 'FTSE All-World',
    region: { USA: 61, Europa: 15, Asia: 20, Otros: 4 },
    exposDiv: { USD: 63, EUR: 15, JPY: 6, Otros: 16 },
  },
  {
    ticker: 'BTC',
    nombre: 'Bitcoin',
    isin: '-',
    tipo: 'Cripto',
    broker: 'Coinbase',
    grupo: 'Cripto',
    divisa: 'USD',
    mercado: 'Crypto',
    qty: 0.5,
    pm: 58000,
    cot: 62000,
    cartera: 'c3',
    indice: '-',
    region: { Global: 100 },
    exposDiv: { USD: 100 },
  },
  {
    ticker: 'MSFT',
    nombre: 'Microsoft Corp.',
    isin: 'US5949181045',
    tipo: 'Acción',
    broker: 'Interactive Brokers',
    grupo: 'AI/Tech',
    divisa: 'USD',
    mercado: 'NASDAQ',
    qty: 5,
    pm: 420,
    cot: 440,
    cartera: 'c1',
    indice: '-',
    region: { USA: 100 },
    exposDiv: { USD: 100 },
  },
  {
    ticker: 'NVDA',
    nombre: 'NVIDIA Corp.',
    isin: 'US67066G1040',
    tipo: 'Acción',
    broker: 'DEGIRO',
    grupo: 'AI/Tech',
    divisa: 'USD',
    mercado: 'NASDAQ',
    qty: 8,
    pm: 135,
    cot: 128,
    cartera: 'c3',
    indice: '-',
    region: { USA: 100 },
    exposDiv: { USD: 100 },
  },
  {
    ticker: 'IWDA',
    nombre: 'iShares Core MSCI World',
    isin: 'IE00B4L5Y983',
    tipo: 'ETF',
    broker: 'DEGIRO',
    grupo: 'Core',
    divisa: 'EUR',
    mercado: 'XETRA',
    qty: 30,
    pm: 85,
    cot: 94,
    cartera: 'c2',
    indice: 'MSCI World',
    region: { USA: 68, Europa: 16, Asia: 14, Otros: 2 },
    exposDiv: { USD: 70, EUR: 14, JPY: 5, Otros: 11 },
  },
];

// ─── OPERACIONES ──────────────────────────────────────────────────────────────

export const operaciones = [
  // op: Compra | Venta | Dividendo | Staking | Interés | Saveback
  { id: 1, fecha: '2024-03-10', ticker: 'AAPL', tipo: 'Acción', broker: 'Interactive Brokers', op: 'Compra',   qty: 10,  precio: 170,   fee: 2,    divisa: 'USD', grupo: 'AI/Tech', nota: 'Primera posición en Apple', cartera: 'c1' },
  { id: 2, fecha: '2024-05-22', ticker: 'BTC',  tipo: 'Cripto', broker: 'Coinbase',            op: 'Compra',   qty: 0.5, precio: 58000, fee: 15,   divisa: 'USD', grupo: 'Cripto',  nota: '',                          cartera: 'c3' },
  { id: 3, fecha: '2024-07-01', ticker: 'MSFT', tipo: 'Acción', broker: 'Interactive Brokers', op: 'Compra',   qty: 5,   precio: 420,   fee: 2,    divisa: 'USD', grupo: 'AI/Tech', nota: '',                          cartera: 'c1' },
  { id: 4, fecha: '2024-09-15', ticker: 'VWCE', tipo: 'ETF',    broker: 'DEGIRO',              op: 'Compra',   qty: 20,  precio: 105,   fee: 0.5,  divisa: 'EUR', grupo: 'Core',    nota: 'DCA mensual',              cartera: 'c1' },
  { id: 5, fecha: '2025-01-08', ticker: 'NVDA', tipo: 'Acción', broker: 'DEGIRO',              op: 'Compra',   qty: 8,   precio: 135,   fee: 1,    divisa: 'USD', grupo: 'AI/Tech', nota: '',                          cartera: 'c3' },
  { id: 6, fecha: '2025-02-01', ticker: 'IWDA', tipo: 'ETF',    broker: 'DEGIRO',              op: 'Compra',   qty: 30,  precio: 85,    fee: 0.5,  divisa: 'EUR', grupo: 'Core',    nota: 'DCA mensual',              cartera: 'c2' },
];

// ─── EFECTIVO ─────────────────────────────────────────────────────────────────

export const movimientosEfectivo = [
  // tipo: Transferencia entrada | Bizum | Dividendo | Interés cuenta | Staking | Saveback | Compra activo | Transferencia salida | Comisión | Otro
  { id: 1, fecha: '2024-01-05', tipo: 'Transferencia entrada', broker: 'Interactive Brokers', importe: 5000,  divisa: 'EUR', nota: '',                    cartera: 'c1' },
  { id: 2, fecha: '2024-03-01', tipo: 'Bizum',                 broker: 'DEGIRO',             importe: 300,   divisa: 'EUR', nota: 'Aportación mensual',   cartera: 'c1' },
  { id: 3, fecha: '2024-04-15', tipo: 'Dividendo',             broker: 'Interactive Brokers', importe: 18.4,  divisa: 'USD', nota: 'AAPL Q1 2024',        cartera: 'c1' },
  { id: 4, fecha: '2024-04-12', tipo: 'Saveback',              broker: 'DEGIRO',             importe: 4.2,   divisa: 'EUR', nota: '',                    cartera: 'c1' },
  { id: 5, fecha: '2024-05-01', tipo: 'Staking',               broker: 'Coinbase',           importe: 12,    divisa: 'USD', nota: 'ETH staking reward',  cartera: 'c3' },
];

// ─── ÍNDICES ──────────────────────────────────────────────────────────────────

export const indices = [
  { nombre: 'FTSE All-World', ticker: 'VWCE', ytd: '+8,2%', y1: '+12,4%', pe: '18,4x', div: '1,8%', nValores: '3.700+', desc: 'Renta variable global desarrollada + emergente' },
  { nombre: 'S&P 500',        ticker: 'SPY',  ytd: '+9,1%', y1: '+14,2%', pe: '21,2x', div: '1,3%', nValores: '500',    desc: '500 mayores empresas de EE.UU.' },
  { nombre: 'MSCI World',     ticker: 'IWDA', ytd: '+8,7%', y1: '+13,1%', pe: '19,8x', div: '1,5%', nValores: '1.400+', desc: 'Renta variable mercados desarrollados globales' },
  { nombre: 'NASDAQ 100',     ticker: 'QQQ',  ytd: '+11,3%',y1: '+17,8%', pe: '28,5x', div: '0,6%', nValores: '100',    desc: '100 mayores no financieras NASDAQ' },
];

// ─── GRUPOS ───────────────────────────────────────────────────────────────────

export const grupos = [
  { id: 'g1', nombre: 'Core',           color: '#185FA5', desc: 'ETFs de índices globales' },
  { id: 'g2', nombre: 'Cripto',         color: '#BA7517', desc: 'Bitcoin, Ethereum y altcoins' },
  { id: 'g3', nombre: 'AI/Tech',        color: '#7F77DD', desc: 'Tecnología e inteligencia artificial' },
  { id: 'g4', nombre: 'Renta fija',     color: '#1D9E75', desc: 'Bonos y renta fija' },
  { id: 'g5', nombre: 'Legacy',         color: '#888780', desc: 'Posiciones heredadas o en revisión' },
  { id: 'g6', nombre: 'Core ampliado',  color: '#639922', desc: 'Satélites complementarios al core' },
];
