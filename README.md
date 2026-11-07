<div align="center">

**English** · [Español](./README.es.md)

# Cotizave Exchange Rates API

### Real-time & historical currency exchange rates for 22 countries — one API

A fast, typed REST API for official (central-bank) and market exchange rates,
currency conversion, historical series, bank rates and calendars across **Latin
America, North America and Europe** — behind a single API key. Includes Colombia's
**TRM**, official rates for Argentina, Brazil, Mexico, Peru and Chile, and
Venezuela's **BCV** — across 22 countries.

[![npm](https://img.shields.io/npm/v/@cotizave/sdk?label=%40cotizave%2Fsdk&color=cb3837&logo=npm)](https://www.npmjs.com/package/@cotizave/sdk)
[![CI](https://github.com/cotizave/cotizave-typescript/actions/workflows/ci.yml/badge.svg)](https://github.com/cotizave/cotizave-typescript/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

[Documentation](https://docs.cotizave.com) · [API reference](https://docs.cotizave.com/api/v2/introduction) · [Get an API key](https://app.cotizave.com) · [Website](https://cotizave.com)

</div>

---

## Features

- **Multi-country** — official (central-bank) and market rates per country, by canonical rate id (e.g. `co-trm`, `ve-bcv`).
- **Currency conversion** — single and bulk conversions, resolved on Cotizave, never computed client-side.
- **History & statistics** — point-in-time, daily series, raw captures and period aggregates.
- **Markets & banks** — rate catalogs, spreads, best-route lookups and bank-published rates.
- **Calendars** — holidays and business-day math per country.
- **Reference data** — country, currency and issuer catalogs.
- **Typed SDK** — a fully-typed TypeScript/JavaScript client generated from the OpenAPI contract.

> Coverage and available features vary by country and by plan.

## Popular rates

Rates are identified by a stable, canonical id. A few widely-used ones:

| Country | Rate | Rate id |
| --- | --- | --- |
| Colombia | TRM | `co-trm` |
| Argentina | Official (USD) | `ar-official` |
| Brazil | Official (USD) | `br-official` |
| Mexico | Official (USD) | `mx-official` |
| Peru | Official (USD) | `pe-official` |
| Chile | Official (USD) | `cl-official` |
| Venezuela | BCV official (USD) | `ve-bcv` |

Official and market rates are available across **22 countries** in the Americas and
Europe. Get the live, complete list from `GET /v2/countries`, and a country's full
catalog from `GET /v2/fx/{cc}/markets`.

## Quick start — no SDK

Authenticate with the `X-API-Key` header. Keep your key server-side.

```bash
curl -H "X-API-Key: $COTIZAVE_API_KEY" \
  "https://api.cotizave.com/v2/fx/co/rates/co-trm"
```

More in [`examples/curl.sh`](./examples/curl.sh).

## Quick start — SDK (JavaScript & TypeScript)

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

The SDK runs in plain JavaScript too (ESM and CommonJS) — see [`examples/node.mjs`](./examples/node.mjs).

## Official tools

| Tool | Description | Install |
| --- | --- | --- |
| [**TypeScript / JavaScript SDK**](https://github.com/cotizave/cotizave-typescript) | Fully-typed client for the API v2. ESM + CommonJS, Node.js 22+. | `npm i @cotizave/sdk` |
| [**Agent Skill**](https://github.com/cotizave/agent-skills) | Teaches AI coding agents (Claude, Cursor, Codex) to integrate Cotizave correctly. | `npx skills add cotizave/agent-skills` |

Additional language SDKs are planned; this list shows what is available today.

## API endpoints

Base URL: `https://api.cotizave.com`. All endpoints require the `X-API-Key` header.

| Method | Endpoint | Description |
| --- | --- | --- |
| `GET` | `/v2/fx/{cc}/rates` | All rates of a country |
| `GET` | `/v2/fx/{cc}/rates/{id}` | A single rate by canonical id |
| `GET` | `/v2/fx/{cc}/rates/{id}/history` | History of a rate (point, daily, raw, stats) |
| `GET` | `/v2/fx/rates` | The official rate of every published country |
| `GET` | `/v2/fx/convert` | Convert one amount |
| `POST` | `/v2/fx/convert` | Convert up to 50 amounts |
| `GET` | `/v2/fx/{cc}/markets` | Rate catalog of a country |
| `GET` | `/v2/fx/{cc}/spread` | Spread between two rates |
| `GET` | `/v2/fx/{cc}/route` | Best executable rate for an amount |
| `GET` | `/v2/fx/{cc}/bank-rates` | Bank-published rates |
| `GET` | `/v2/countries`, `/v2/currencies` | Country and currency catalogs |
| `GET` | `/v2/banks/{cc}`, `/v2/issuers` | Banks and official-rate issuers |
| `GET` | `/v2/holidays/{cc}` | Holidays and business days |
| `GET` | `/v2/crypto` | Stablecoin references priced in USD |

The full contract is in [`openapi/cotizave-v2.yaml`](./openapi/cotizave-v2.yaml), and a
[Postman collection](./postman/cotizave.postman_collection.json) is included.

## Error handling

Errors return JSON — `{ code, message, field?, details? }` — with a matching HTTP status.

| Status | Meaning |
| --- | --- |
| `400` | Invalid parameters or format |
| `401` | Missing, invalid or revoked API key |
| `402` | Feature not included in your plan |
| `403` | Account restriction or out-of-retention access |
| `404` | Resource or rate not found |
| `406` | Format cannot represent the response |
| `422` | No usable reference right now |
| `429` | Rate limited — monthly quota or per-minute velocity |
| `5xx` | Server-side error |

## Coverage & plans

- The set of published countries grows over time — get the live list from
  `GET /v2/countries`, not from a hard-coded list.
- Formats (CSV/XML), historical retention, and some endpoints depend on your plan.
- The SDK is free and MIT-licensed; API usage counts against your plan's quota and
  rate limits. No SLA is implied.

## Resources

- **[Documentation](https://docs.cotizave.com)** — guides and quick start
- **[API v2 reference](https://docs.cotizave.com/api/v2/introduction)** — endpoints and responses
- **[OpenAPI spec](./openapi/cotizave-v2.yaml)** — generate a client in any language
- **[Postman collection](./postman/cotizave.postman_collection.json)** — try every endpoint
- **[Dashboard](https://app.cotizave.com)** — manage API keys and usage

## License

[MIT](./LICENSE)
