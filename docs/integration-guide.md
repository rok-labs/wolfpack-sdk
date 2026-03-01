# Integration Guide: Intelligence for Trading Agents

## One Call Gets Everything: mega_report

The fastest way to get full intelligence on any token. A single `mega_report` call returns security, market data, smart money activity, narrative momentum, and technical analysis — everything a trading agent needs to make a decision.

```typescript
// Submit a mega report request
const res = await fetch("https://api.wolfpack.roklabs.dev/api/v1/intelligence/mega-report", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ token_address: "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed", chain: "base" }),
});
const { report_id } = await res.json();

// Retrieve the full report
const report = await fetch(`https://api.wolfpack.roklabs.dev/api/mega-reports/${report_id}`).then(r => r.json());

// Make decisions from the unified report
if (!report.security.safe) return { action: "abort", reason: report.security.risk_flags };
if (report.overall_risk_score > 70) return { action: "abort", reason: "high risk" };
if (report.technical_analysis.rsi_14 > 80) return { action: "wait", reason: "overbought" };
return { action: "trade", confidence: 100 - report.overall_risk_score };
```

At **$0.15 per call** (vs ~$0.26 calling each service individually), `mega_report` is the recommended starting point for any trading agent.

## Modular Integration: Pick What You Need

If you only need specific intelligence, call individual services:

### Pre-Trade Security Gate (Fastest)

```typescript
const res = await fetch("https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ token_address: tokenToTrade }),
});
const { safe } = await res.json();
if (!safe) throw new Error("Token failed security check");
```

### Step-by-Step Risk Pipeline

```typescript
// 1. Quick safety gate (< 1 second)
const security = await fetch(".../security-check", { ... }).then(r => r.json());
if (!security.safe) return { action: "abort", reason: security.risk_flags };

// 2. Full risk scoring (3-5 seconds)
const risk = await fetch(".../token-risk", { ... }).then(r => r.json());
if (risk.risk_score > 70) return { action: "abort", reason: "high risk score" };

// 3. Technical analysis (2-3 seconds)
const ta = await fetch(".../technical-analysis", { ... }).then(r => r.json());
if (ta.rsi_14 > 80) return { action: "wait", reason: "overbought" };

// 4. Narrative momentum check (2-4 seconds)
const narrative = await fetch(".../narrative-score", { ... }).then(r => r.json());
if (narrative.momentum_score < 20) return { action: "wait", reason: "low social momentum" };

// 5. All checks passed — execute trade
return { action: "trade", confidence: Math.max(0, 100 - risk.risk_score) };
```

### DeFi-Specific: Yield + IL Analysis

```typescript
// Check yield opportunities with IL awareness
const yields = await fetch(".../yield-scanner", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ token_address: "0x...", min_tvl_usd: 100000, min_apy: 5.0 }),
}).then(r => r.json());

// Calculate IL for a specific position
const il = await fetch(".../il-calculator", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    token_a: "0x4200000000000000000000000000000000000006",
    token_b: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    entry_price_ratio: 3200.0,
    current_price_ratio: 3500.0,
    position_type: "concentrated",
    range_lower: 3000.0,
    range_upper: 4000.0,
  }),
}).then(r => r.json());
```

### Prediction Markets

```typescript
const predictions = await fetch(".../prediction-market", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ query: "Bitcoin above 100k", category: "crypto" }),
}).then(r => r.json());
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

Your agent can then call all 11 tools natively: `mega_report`, `security_check`, `token_risk_analysis`, `narrative_momentum`, `agent_trust_score`, `smart_money_signals`, `token_market_snapshot`, `prediction_market`, `il_calculator`, `yield_scanner`, `technical_analysis`.

## Error Handling

All endpoints return standard HTTP status codes:
- `200` — Success
- `400` — Invalid input (missing token_address, malformed address)
- `404` — Token not found on Base
- `429` — Rate limited
- `500` — Internal error

Error responses include a JSON body with `error` and `message` fields.
