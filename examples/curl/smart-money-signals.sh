#!/bin/bash
# Wolfpack Intelligence — Smart Money Signals (curl)
# Dune-powered smart money wallet activity on Base

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Smart money signals for $TOKEN_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/smart-money-signals" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\"}" | jq .
