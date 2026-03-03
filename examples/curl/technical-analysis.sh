#!/bin/bash
# Wolfpack Intelligence — Technical Analysis (curl)
# RSI, SMA, Bollinger Bands, support/resistance from GeckoTerminal OHLCV

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Technical analysis for $TOKEN_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/technical-analysis" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\", \"timeframe\": \"1h\"}" | jq .
