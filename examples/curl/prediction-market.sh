#!/bin/bash
# Wolfpack Intelligence — Prediction Market (curl)
# Polymarket crypto prediction market odds, volume, and liquidity

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
QUERY="${1:-Bitcoin above 100k}"

echo "Querying prediction markets for: $QUERY..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/prediction-market" \
  -H "Content-Type: application/json" \
  -d "{\"query\": \"$QUERY\", \"category\": \"crypto\"}" | jq .
