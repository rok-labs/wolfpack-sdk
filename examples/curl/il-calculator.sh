#!/bin/bash
# Wolfpack Intelligence — Impermanent Loss Calculator (curl)
# Calculate IL for standard AMM or Uni V3 concentrated liquidity positions

WOLFPACK_API="https://api.wolfpack.roklabs.dev"

echo "=== Standard AMM position ==="
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/il-calculator" \
  -H "Content-Type: application/json" \
  -d '{
    "entry_price": 3200.0,
    "current_price": 3500.0,
    "position_size_usd": 10000
  }' | jq .

echo ""
echo "=== Concentrated liquidity position (Uni V3) ==="
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/il-calculator" \
  -H "Content-Type: application/json" \
  -d '{
    "entry_price": 3200.0,
    "current_price": 3500.0,
    "position_size_usd": 10000,
    "pool_type": "concentrated",
    "price_lower": 3000.0,
    "price_upper": 4000.0
  }' | jq .
