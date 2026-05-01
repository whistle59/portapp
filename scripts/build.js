#!/usr/bin/env node
// Obfusca prototype/index.html → dist/index.html
// Uso: node scripts/build.js

const fs = require('fs');
const path = require('path');
const { obfuscate } = require('javascript-obfuscator');

const src = path.join(__dirname, '..', 'prototype', 'index.html');
const outDir = path.join(__dirname, '..', 'dist');
const out = path.join(outDir, 'index.html');

if (!fs.existsSync(outDir)) fs.mkdirSync(outDir);

const html = fs.readFileSync(src, 'utf8');

// Extrae el bloque <script> final (el de la app, no CDNs)
const scriptRe = /<script(?![^>]*src[^>]*)>([\s\S]*?)<\/script>\s*<\/body>/;
const match = html.match(scriptRe);
if (!match) { console.error('No se encontró el bloque <script> de la app'); process.exit(1); }

const originalJs = match[1];
const result = obfuscate(originalJs, {
  compact: true,
  controlFlowFlattening: false,
  deadCodeInjection: false,
  debugProtection: false,
  disableConsoleOutput: false,
  identifierNamesGenerator: 'hexadecimal',
  renameGlobals: false,
  selfDefending: false,
  stringArray: true,
  stringArrayEncoding: ['base64'],
  stringArrayThreshold: 0.75,
  transformObjectKeys: false,
  unicodeEscapeSequence: false,
});

const obfuscatedHtml = html.replace(scriptRe, `<script>${result.getObfuscatedCode()}</script></body>`);
fs.writeFileSync(out, obfuscatedHtml, 'utf8');
console.log(`✓ dist/index.html generado (${Math.round(fs.statSync(out).size / 1024)} KB)`);

const manifestSrc = path.join(__dirname, '..', 'prototype', 'manifest.json');
if (fs.existsSync(manifestSrc)) {
  fs.copyFileSync(manifestSrc, path.join(outDir, 'manifest.json'));
  console.log('✓ dist/manifest.json copiado');
}
