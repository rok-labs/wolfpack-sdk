#!/bin/bash
# Wolfpack Intelligence — Graduation Readiness Check (curl)
# Live ACP graduation readiness audit ($1.49)
# Fires real test jobs, scores lifecycle handling, schema correctness, output consistency

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
AGENT_ADDRESS="${1:-0xbaC206A51E126DD97DC8046CB9a17fF4F4D9d7f2}"
OFFERING="${2:-}"

PAYLOAD="{\"target_agent_address\": \"$AGENT_ADDRESS\""
if [ -n "$OFFERING" ]; then
  PAYLOAD="$PAYLOAD, \"offering_name\": \"$OFFERING\""
fi
PAYLOAD="$PAYLOAD}"

echo "Graduation readiness check for agent $AGENT_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/graduation-readiness-check" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" | jq .
