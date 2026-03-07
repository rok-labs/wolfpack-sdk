#!/bin/bash
# Wolfpack Intelligence — Agent Credit Risk Index (curl)
# Financial credit risk scoring for ACP agents ($0.10)
# Three pillars: realized liquidity (40%), execution reliability (40%), wallet maturity (20%)

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
AGENT_ID="${1:-16907}"

echo "Credit risk index for agent #$AGENT_ID..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/agent-credit-risk-index" \
  -H "Content-Type: application/json" \
  -d "{\"agent_id\": $AGENT_ID}" | jq .
