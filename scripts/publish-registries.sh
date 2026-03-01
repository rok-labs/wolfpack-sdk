#!/usr/bin/env bash
set -euo pipefail

# Publish Wolfpack Intelligence MCP server to Smithery and Official MCP Registry
#
# Prerequisites:
#   - Node.js / npx (for Smithery)
#   - mcp-publisher CLI (for Official MCP Registry)
#   - GitHub CLI auth (for MCP Registry namespace: io.github.rok-labs)

echo "=== Publishing Wolfpack Intelligence MCP Server ==="
echo ""

# --- Smithery ---
echo "--- Step 1: Publish to Smithery ---"
echo "API key when prompted: d127bebe-4777-499e-af0f-1ba5e3cf5e61"
echo ""
npx -y @smithery/cli mcp publish "https://api.wolfpack.roklabs.dev/api/v1/mcp" \
  --name "rok-labs/wolfpack-intelligence" \
  --config-schema '{"type":"object","properties":{"chain":{"type":"string","default":"base","enum":["base","ethereum"]}}}'

echo ""
echo "✅ Smithery publish complete"
echo ""

# --- Official MCP Registry ---
echo "--- Step 2: Publish to Official MCP Registry ---"
echo ""

if ! command -v mcp-publisher &> /dev/null; then
  echo "Installing mcp-publisher..."
  curl -L "https://github.com/modelcontextprotocol/registry/releases/latest/download/mcp-publisher_$(uname -s | tr '[:upper:]' '[:lower:]')_$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').tar.gz" | tar xz mcp-publisher
  sudo mv mcp-publisher /usr/local/bin/
fi

mcp-publisher login github
mcp-publisher publish

echo ""
echo "✅ Official MCP Registry publish complete"
echo ""
echo "=== All done ==="
