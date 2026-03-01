# Wolfpack Intelligence SDK

On-chain security and market intelligence for trading agents on Base.

Wolfpack provides 7 intelligence services via multiple protocols. Use this SDK to integrate pre-trade security checks, token risk analysis, narrative scoring, and more into your agent or application.

## Services

| Service | Description | Price | Latency |
|---------|-------------|-------|---------|
| `security_check` | GoPlus honeypot detection, contract verification, ownership analysis | $0.01 | <1s |
| `token_risk_analysis` | 360° risk audit: honeypot, liquidity, holders, smart money, social | $0.05 | 3-5s |
| `narrative_momentum` | Social signal scoring: Twitter/X velocity, engagement quality, KOL ratio | $0.10 | 2-4s |
| `agent_trust_score` | Composite agent reliability rating (ACP performance, wallet health) | $0.05 | 2-3s |
| `smart_money_signals` | Real-time smart money wallet activity on Base via Dune | $0.01 | 2-3s |
| `token_market_snapshot` | DexScreener market data: price, volume, liquidity, buy/sell ratio | $0.02 | <1s |
| `agent_audit_standard` | LLM-driven agent stress test (10 jobs, scored report) | $15.00 | ~5min |

## Quick Start: Add Pre-Trade Security in 5 Lines

```typescript
// TypeScript — x402 micropayment
import { getPaymentHeader } from "@anthropic-ai/x402";

const res = await fetch("https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check", {
  method: "POST",
  headers: { "Content-Type": "application/json", ...await getPaymentHeader() },
  body: JSON.stringify({ token_address: "0x..." }),
});
const { safe, risk_flags } = await res.json();
```

```bash
# curl — no SDK needed
curl -X POST https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check \
  -H "Content-Type: application/json" \
  -d '{"token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed"}'
```

## Integration Protocols

### 1. x402 Micropayments (Pay-per-call)

USDC payments on Base, processed automatically. See [`examples/typescript/`](./examples/typescript/) and [`examples/python/`](./examples/python/).

**Base URL:** `https://api.wolfpack.roklabs.dev`

| Endpoint | Service |
|----------|---------|
| `POST /api/v1/intelligence/security-check` | security_check |
| `POST /api/v1/intelligence/token-risk` | token_risk_analysis |
| `POST /api/v1/intelligence/narrative-score` | narrative_momentum |
| `POST /api/v1/intelligence/agent-trust` | agent_trust_score |
| `POST /api/v1/intelligence/query` | All services (route via `service_type` field) |

### 2. MCP (Model Context Protocol)

Connect any MCP-compatible client (Claude Desktop, Cursor, etc.) to Wolfpack as a tool provider.

**Drop-in config for Claude Desktop** — copy [`mcp/claude-desktop-config.json`](./mcp/claude-desktop-config.json) to your Claude Desktop settings:

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

**Server Card:** [`https://api.wolfpack.roklabs.dev/.well-known/mcp/server-card.json`](https://api.wolfpack.roklabs.dev/.well-known/mcp/server-card.json)

4 tools available: `token_risk_analysis`, `security_check`, `narrative_momentum`, `agent_trust_score`

### 3. Google A2A (Agent-to-Agent)

JSON-RPC 2.0 protocol for agent-to-agent communication.

**Endpoint:** `POST https://api.wolfpack.roklabs.dev/api/v1/a2a`
**Agent Card:** [`https://api.wolfpack.roklabs.dev/.well-known/agent.json`](https://api.wolfpack.roklabs.dev/.well-known/agent.json)

### 4. Virtuals ACP (Agent Commerce Protocol)

For agents in the Virtuals ecosystem. Wolfpack is registered as a seller with 4 active services and 150+ successful jobs.

**Services:** `security_check`, `token_risk_analysis`, `narrative_momentum`, `agent_trust_score`

## Examples

- **TypeScript:** [`examples/typescript/`](./examples/typescript/) — x402 payment, MCP client, A2A task
- **Python:** [`examples/python/`](./examples/python/) — x402 payment examples
- **curl:** [`examples/curl/`](./examples/curl/) — Raw HTTP examples for any language
- **Schemas:** [`schemas/`](./schemas/) — JSON Schema for all service inputs/outputs

## Service Details

### security_check

Fast GoPlus-powered token safety scan. Returns honeypot status, contract verification, ownership flags, holder concentration.

**Input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "chain": "base"
}
```

**Output:**
```json
{
  "safe": true,
  "honeypot": false,
  "verified_source": true,
  "hidden_owner": false,
  "holder_count": 45000,
  "top10_holder_percent": 32.5,
  "risk_flags": []
}
```

### token_risk_analysis

Multi-source risk scoring combining GoPlus, DexScreener, Dune Analytics, and Twitter social signals.

**Input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "chain": "base",
  "analysis_depth": "standard"
}
```

### narrative_momentum

Scores the social momentum of a crypto narrative or token. Analyzes Twitter/X signals with VADER sentiment, engagement quality metrics, and influencer ratio.

**Input:**
```json
{
  "query": "AI agents on Base",
  "keywords": ["autonomous", "agent", "Base chain"],
  "contracts": ["0x..."]
}
```

### agent_trust_score

Composite reliability rating for ACP/ERC-8004 agents. Scores on ACP performance (40%), network position (25%), operational health (25%), metadata compliance (10%).

**Input:**
```json
{
  "agent_address": "0x...",
  "agent_id": 16907
}
```

## Architecture

Wolfpack Intelligence is a live production system running on Base chain. Services are deterministic where possible (no LLM in security_check, smart_money_signals, token_market_snapshot) and LLM-enhanced where value requires it (narrative_momentum, agent_audit).

All data is sourced from on-chain and public APIs: GoPlus Security, DexScreener, Dune Analytics, TwitterAPI.io, CoinGecko.

## Links

- **API Base URL:** `https://api.wolfpack.roklabs.dev`
- **MCP Server Card:** `https://api.wolfpack.roklabs.dev/.well-known/mcp/server-card.json`
- **A2A Agent Card:** `https://api.wolfpack.roklabs.dev/.well-known/agent.json`
- **Health Check:** `https://api.wolfpack.roklabs.dev/api/health`

## License

MIT
