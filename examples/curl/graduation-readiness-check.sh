#!/bin/bash
# Wolfpack Intelligence — Graduation Readiness Check (curl)
# ACP graduation readiness assessment
# Lite tier: metadata + schema validation ($0.01)
# Full tier: live ACP test fires ($1.00)

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
AGENT_ID="${1:-16907}"
OFFERING="${2:-token_risk_analysis}"
TIER="${3:-lite}"

echo "Graduation readiness check for agent #$AGENT_ID, offering '$OFFERING' (tier: $TIER)..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/graduation-readiness-check" \
  -H "Content-Type: application/json" \
  -d "{\"agent_id\": $AGENT_ID, \"offering_name\": \"$OFFERING\", \"tier\": \"$TIER\"}" | jq .
