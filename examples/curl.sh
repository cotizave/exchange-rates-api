#!/usr/bin/env bash
# No SDK needed — just HTTP + your API key (keep it server-side).
# Get a free key at https://app.cotizave.com
export COTIZAVE_API_KEY="your_key"

# Colombia's official TRM
curl -s -H "X-API-Key: $COTIZAVE_API_KEY" \
  "https://api.cotizave.com/v2/fx/co/rates/co-trm"

# Convert 100 USD to BRL
curl -s -H "X-API-Key: $COTIZAVE_API_KEY" \
  "https://api.cotizave.com/v2/fx/convert?from=USD&to=BRL&amount=100"

# All published countries' official rates in one call
curl -s -H "X-API-Key: $COTIZAVE_API_KEY" \
  "https://api.cotizave.com/v2/fx/rates"
