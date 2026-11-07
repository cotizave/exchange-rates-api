// npm i @cotizave/sdk
import { Cotizave } from '@cotizave/sdk';

const client = new Cotizave({ apiKey: process.env.COTIZAVE_API_KEY });

const { rates } = await client.rates.list('CO');        // all rates of a country
const trm = await client.rates.get('CO', 'co-trm');     // one rate by id
const conv = await client.convert({ from: 'USD', to: 'BRL', amount: 100 });

console.log(rates.length, trm.mid, conv.to.amount);
