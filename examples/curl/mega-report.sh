#!/bin/bash
# Wolfpack Intelligence — Mega Report (curl)
# Aggregated report: security + market + smart money + narrative + TA in one call
# Two-step: POST to start, GET to retrieve full report

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Submitting mega report for $TOKEN_ADDRESS..."
RESPONSE=$(curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/mega-report" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\"}")

echo "Submit response:"
echo "$RESPONSE" | jq .

REPORT_ID=$(echo "$RESPONSE" | jq -r '.report_id // empty')
if [ -n "$REPORT_ID" ]; then
  echo ""
  echo "Retrieving full report ($REPORT_ID)..."
  sleep 2
  curl -s "$WOLFPACK_API/api/mega-reports/$REPORT_ID" | jq .
fi
