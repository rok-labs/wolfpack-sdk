#!/bin/bash
# Wolfpack Intelligence — Token Market Snapshot (curl)
# DexScreener market data: price, volume, liquidity, buy/sell ratio

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Market snapshot for $TOKEN_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/token-market-snapshot" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\"}" | jq .
