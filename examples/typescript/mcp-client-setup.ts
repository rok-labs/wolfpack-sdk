/**
 * Wolfpack Intelligence — MCP Client Example
 *
 * Connect to Wolfpack as an MCP tool provider from your own agent.
 * Uses the Model Context Protocol (streamable-http transport).
 *
 * Install: npm install @modelcontextprotocol/sdk
 */

import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StreamableHTTPClientTransport } from "@modelcontextprotocol/sdk/client/streamableHttp.js";

const WOLFPACK_MCP_URL = "https://api.wolfpack.roklabs.dev/api/v1/mcp";

async function main() {
  // 1. Create MCP client
  const transport = new StreamableHTTPClientTransport(new URL(WOLFPACK_MCP_URL));
  const client = new Client({ name: "my-trading-agent", version: "1.0.0" });
  await client.connect(transport);

  // 2. List available tools
  const { tools } = await client.listTools();
  console.log("Available tools:", tools.map(t => t.name));
  // Output: ['mega_report', 'security_check', 'token_risk_analysis', 'narrative_momentum',
  //          'agent_trust_score', 'smart_money_signals', 'token_market_snapshot',
  //          'prediction_market', 'il_calculator', 'yield_scanner', 'technical_analysis',
  //          'graduation_readiness_check']

  // 3. Call a tool
  const result = await client.callTool({
    name: "security_check",
    arguments: {
      token_address: "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
      chain: "base",
    },
  });

  console.log("Security check result:", JSON.stringify(result.content, null, 2));

  // 4. Disconnect
  await client.close();
}

main().catch(console.error);
