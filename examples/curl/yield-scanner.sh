#!/bin/bash
# Wolfpack Intelligence — Yield Scanner (curl)
# IL-aware yield opportunities on Base via DefiLlama

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Yield opportunities for $TOKEN_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/yield-scanner" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"min_tvl_usd\": 100000, \"min_apy\": 5.0}" | jq .
