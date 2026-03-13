#!/bin/bash
# Wolfpack Intelligence — Trade Signals (curl)
# Composite trade signal generation ($2.00)
# Combines TA, smart money, narrative, and risk scoring

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"
TIMEFRAME="${2:-4h}"

echo "Trade signals for $TOKEN ($TIMEFRAME)..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/trade-signals" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN\", \"chain\": \"base\", \"timeframe\": \"$TIMEFRAME\"}" | jq .
