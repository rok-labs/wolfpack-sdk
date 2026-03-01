#!/bin/bash
# Wolfpack Intelligence — Security Check (curl)
# Fast GoPlus-powered token safety scan

WOLFPACK_API="https://api.wolfpack.roklabs.dev"
TOKEN_ADDRESS="${1:-0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed}"

echo "Security check for $TOKEN_ADDRESS..."
curl -s -X POST "$WOLFPACK_API/api/v1/intelligence/security-check" \
  -H "Content-Type: application/json" \
  -d "{\"token_address\": \"$TOKEN_ADDRESS\", \"chain\": \"base\"}" | jq .
