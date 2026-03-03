#!/bin/bash
# Wolfpack Intelligence — Agent Trust Score (curl)
# Composite reliability rating for ACP/ERC-8004 agents

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
AGENT_ID="${1:-16907}"

echo "Agent trust score for agent #$AGENT_ID..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/agent-trust" \
  -H "Content-Type: application/json" \
  -d "{\"agent_id\": $AGENT_ID}" | jq .
