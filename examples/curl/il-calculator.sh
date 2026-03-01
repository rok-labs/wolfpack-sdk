#!/bin/bash
# Wolfpack Intelligence — Impermanent Loss Calculator (curl)
# Calculate IL for standard AMM or Uni V3 concentrated liquidity positions

WOLFPACK_API="https://api.wolfpack.roklabs.dev"

echo "Calculating impermanent loss for WETH/USDC concentrated position..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/il-calculator" \
  -H "Content-Type: application/json" \
  -d '{
    "token_a": "0x4200000000000000000000000000000000000006",
    "token_b": "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    "entry_price_ratio": 3200.0,
    "current_price_ratio": 3500.0,
    "position_type": "concentrated",
    "range_lower": 3000.0,
    "range_upper": 4000.0
  }' | jq .
