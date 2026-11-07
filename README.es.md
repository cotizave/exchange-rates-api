<div align="center">

[English](./README.md) · **Español**

# Cotizave — API de Tipos de Cambio

### Tasas de cambio en tiempo real e históricas de 22 países — una sola API

API REST rápida y tipada para tasas de cambio **oficiales (de bancos centrales) y
de mercado**, conversión de monedas, series históricas, tasas de bancos y
calendarios — en **América Latina, Norteamérica y Europa**, con una sola API key.
Incluye la **TRM** de Colombia, el dólar oficial de Argentina, Brasil, México, Perú
y Chile, y el **dólar BCV** de Venezuela — en 22 países.

[![npm](https://img.shields.io/npm/v/@cotizave/sdk?label=%40cotizave%2Fsdk&color=cb3837&logo=npm)](https://www.npmjs.com/package/@cotizave/sdk)
[![CI](https://github.com/cotizave/cotizave-typescript/actions/workflows/ci.yml/badge.svg)](https://github.com/cotizave/cotizave-typescript/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

[Documentación](https://docs.cotizave.com) · [Referencia de la API](https://docs.cotizave.com/api/v2/introduction) · [Obtené una API key](https://app.cotizave.com) · [Web](https://cotizave.com)

</div>

---

## Características

- **Multipaís** — tasas oficiales (banco central) y de mercado por país, con id canónico (ej. `co-trm`, `ve-bcv`).
- **Conversión de monedas** — conversiones simples y masivas, resueltas en Cotizave, nunca en el cliente.
- **Histórico y estadísticas** — punto en el tiempo, serie diaria, capturas crudas y agregados del período.
- **Mercados y bancos** — catálogos de tasas, brechas (spread), mejor ruta y cotizaciones por banco.
- **Calendarios** — feriados y cálculo de días hábiles por país.
- **Datos de referencia** — catálogos de países, monedas y emisores.
- **SDK tipado** — cliente de TypeScript/JavaScript generado del contrato OpenAPI.

> La cobertura y las funciones disponibles varían por país y por plan.

## Tasas populares

Cada tasa se identifica con un id canónico estable. Algunas muy usadas:

| País | Tasa | Id |
| --- | --- | --- |
| Colombia | TRM | `co-trm` |
| Argentina | Oficial (USD) | `ar-official` |
| Brasil | Oficial (USD) | `br-official` |
| México | Oficial (USD) | `mx-official` |
| Perú | Oficial (USD) | `pe-official` |
| Chile | Oficial (USD) | `cl-official` |
| Venezuela | Dólar BCV oficial (USD) | `ve-bcv` |

Hay tasas oficiales y de mercado en **22 países** de América Latina, Norteamérica y
Europa. La lista completa y actualizada sale de `GET /v2/countries`, y el catálogo
de un país de `GET /v2/fx/{cc}/markets`.

## Inicio rápido — sin SDK

Autenticá con la cabecera `X-API-Key`. Mantené tu key del lado del servidor.

```bash
curl -H "X-API-Key: $COTIZAVE_API_KEY" \
  "https://api.cotizave.com/v2/fx/co/rates/co-trm"
```

Más en [`examples/curl.sh`](./examples/curl.sh).

## Inicio rápido — SDK (JavaScript y TypeScript)

```bash
npm i @cotizave/sdk
```

```ts
import { Cotizave } from '@cotizave/sdk';

const client = new Cotizave({ apiKey: process.env.COTIZAVE_API_KEY! });

const { rates } = await client.rates.list('CO');
const trm = await client.rates.get('CO', 'co-trm');
const conversion = await client.convert({ from: 'USD', to: 'BRL', amount: 100 });
```

El SDK corre también en JavaScript puro (ESM y CommonJS) — ver [`examples/node.mjs`](./examples/node.mjs).

## Herramientas oficiales

| Herramienta | Descripción | Instalación |
| --- | --- | --- |
| [**SDK TypeScript / JavaScript**](https://github.com/cotizave/cotizave-typescript) | Cliente tipado de la API v2. ESM + CommonJS, Node.js 22+. | `npm i @cotizave/sdk` |
| [**Agent Skill**](https://github.com/cotizave/agent-skills) | Enseña a agentes de IA (Claude, Cursor, Codex) a integrar Cotizave correctamente. | `npx skills add cotizave/agent-skills` |

Hay más SDKs en otros lenguajes planeados; esta lista muestra lo disponible hoy.

## Endpoints de la API

Base: `https://api.cotizave.com`. Todos requieren la cabecera `X-API-Key`.

| Método | Endpoint | Descripción |
| --- | --- | --- |
| `GET` | `/v2/fx/{cc}/rates` | Todas las tasas de un país |
| `GET` | `/v2/fx/{cc}/rates/{id}` | Una tasa por su id canónico |
| `GET` | `/v2/fx/{cc}/rates/{id}/history` | Histórico de una tasa (punto, diario, crudo, stats) |
| `GET` | `/v2/fx/rates` | La oficial de cada país publicado |
| `GET` | `/v2/fx/convert` | Convertir un monto |
| `POST` | `/v2/fx/convert` | Convertir hasta 50 montos |
| `GET` | `/v2/fx/{cc}/markets` | Catálogo de tasas de un país |
| `GET` | `/v2/fx/{cc}/spread` | Brecha entre dos tasas |
| `GET` | `/v2/fx/{cc}/route` | Mejor tasa ejecutable para un monto |
| `GET` | `/v2/fx/{cc}/bank-rates` | Cotizaciones por banco |
| `GET` | `/v2/countries`, `/v2/currencies` | Catálogos de países y monedas |
| `GET` | `/v2/banks/{cc}`, `/v2/issuers` | Bancos y emisores de tasas oficiales |
| `GET` | `/v2/holidays/{cc}` | Feriados y días hábiles |
| `GET` | `/v2/crypto` | Estables (USDT, USDC, EURC) en dólares |

El contrato completo está en [`openapi/cotizave-v2.yaml`](./openapi/cotizave-v2.yaml) y
se incluye una [colección de Postman](./postman/cotizave.postman_collection.json).

## Manejo de errores

Los errores devuelven JSON — `{ code, message, field?, details? }` — con su status HTTP.

| Estado | Significado |
| --- | --- |
| `400` | Parámetros o formato inválidos |
| `401` | API key ausente, inválida o revocada |
| `402` | Función no incluida en tu plan |
| `403` | Restricción de cuenta o fuera de retención |
| `404` | Recurso o tasa no encontrada |
| `406` | El formato no puede representar la respuesta |
| `422` | Sin referencia usable en este momento |
| `429` | Límite alcanzado — cuota mensual o velocidad por minuto |
| `5xx` | Error del servidor |

## Cobertura y planes

- El conjunto de países publicados crece con el tiempo — obtené la lista en vivo con
  `GET /v2/countries`, no la escribas a mano.
- Los formatos (CSV/XML), la retención de histórico y algunos endpoints dependen de tu plan.
- El SDK es gratis y con licencia MIT; el uso de la API cuenta contra la cuota y los
  límites de tu plan. No se implica ningún SLA.

## Recursos

- **[Documentación](https://docs.cotizave.com)** — guías e inicio rápido
- **[Referencia de la API v2](https://docs.cotizave.com/api/v2/introduction)** — endpoints y respuestas
- **[Especificación OpenAPI](./openapi/cotizave-v2.yaml)** — generá un cliente en cualquier lenguaje
- **[Colección de Postman](./postman/cotizave.postman_collection.json)** — probá cada endpoint
- **[Dashboard](https://app.cotizave.com)** — gestioná API keys y uso

## Licencia

[MIT](./LICENSE)
