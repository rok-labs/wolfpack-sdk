#!/bin/bash
# Wolfpack Intelligence — Narrative Momentum (curl)
# Score social momentum of a crypto narrative or topic

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
QUERY="${1:-AI agents on Base}"

echo "Narrative momentum for: $QUERY..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/narrative-score" \
  -H "Content-Type: application/json" \
  -d "{\"query\": \"$QUERY\"}" | jq .
