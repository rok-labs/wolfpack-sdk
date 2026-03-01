# Integration Guide: Add Pre-Trade Security to Your Agent

## The 5-Line Integration

The fastest way to add Wolfpack security checks to any trading agent:

```typescript
const res = await fetch("https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ token_address: tokenToTrade }),
});
const { safe } = await res.json();
if (!safe) throw new Error("Token failed security check");
```

That's it. Before any trade execution, call the security check endpoint. If `safe` is false, abort the trade.

## Deeper Integration: Full Risk Analysis

For agents that need more context before trading:

```typescript
// 1. Quick safety gate (< 1 second)
const security = await fetch(".../security-check", { ... }).then(r => r.json());
if (!security.safe) return { action: "abort", reason: security.risk_flags };

// 2. Full risk scoring (3-5 seconds)
const risk = await fetch(".../token-risk", { ... }).then(r => r.json());
if (risk.risk_score > 70) return { action: "abort", reason: "high risk score" };

// 3. Narrative momentum check (2-4 seconds)
const narrative = await fetch(".../narrative-score", { ... }).then(r => r.json());
if (narrative.momentum_score < 20) return { action: "wait", reason: "low social momentum" };

// 4. All checks passed — execute trade
return { action: "trade", confidence: Math.max(0, 100 - risk.risk_score) };
```

## MCP Integration for AI Agents

If your agent uses the Model Context Protocol, add Wolfpack as a tool provider:

```json
{
  "mcpServers": {
    "wolfpack-intelligence": {
      "transport": "streamable-http",
      "url": "https://api.wolfpack.roklabs.dev/api/v1/mcp"
    }
  }
}
```

Your agent can then call `security_check`, `token_risk_analysis`, `narrative_momentum`, and `agent_trust_score` as native tools.

## Error Handling

All endpoints return standard HTTP status codes:
- `200` — Success
- `400` — Invalid input (missing token_address, malformed address)
- `404` — Token not found on Base
- `429` — Rate limited
- `500` — Internal error

Error responses include a JSON body with `error` and `message` fields.
