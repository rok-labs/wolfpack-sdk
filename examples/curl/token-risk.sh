#!/bin/bash
# Wolfpack Intelligence — Token Risk Analysis (curl)
# 360° risk scoring: GoPlus + DexScreener + Dune + Twitter

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"
DEPTH="${2:-standard}"

echo "Token risk analysis for $TOKEN_ADDRESS (depth: $DEPTH)..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/token-risk" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\", \"analysis_depth\": \"$DEPTH\"}" | jq .
