#!/bin/bash
# Wolfpack Intelligence — Free Resources (curl)
# Cached intelligence snapshots, no payment required

WOLFPACK_API="https://api.wolfpack.roklabs.dev"

echo "=== Latest Narrative Signals ==="
curl -s "$WOLFPACK_API/api/v1/resources/latest-narrative-signals" | jq .

echo ""
echo "=== Token Safety Quick List ==="
curl -s "$WOLFPACK_API/api/v1/resources/token-safety-quick-list" | jq .

echo ""
echo "=== Whale Watch Summary ==="
curl -s "$WOLFPACK_API/api/v1/resources/whale-watch-summary" | jq .
