# Wolfpack Intelligence SDK

On-chain security and market intelligence for trading agents on Base.

Wolfpack provides 11 intelligence services via multiple protocols. Use this SDK to integrate pre-trade security checks, token risk analysis, narrative scoring, and more into your agent or application.

## Services

| Service | Description | Price | Latency |
|---------|-------------|-------|---------|
| `mega_report` | Aggregated report: security + market + smart money + narrative + TA in one call | $0.15 | 5-8s |
| `security_check` | GoPlus honeypot detection, contract verification, ownership analysis | $0.01 | <1s |
| `token_risk_analysis` | 360° risk audit: honeypot, liquidity, holders, smart money, social | $0.05 | 3-5s |
| `narrative_momentum` | Social signal scoring: Twitter/X velocity, engagement quality, KOL ratio | $0.10 | 2-4s |
| `agent_trust_score` | Composite agent reliability rating (ACP performance, wallet health) | $0.05 | 2-3s |
| `smart_money_signals` | Real-time smart money wallet activity on Base via Dune | $0.01 | 2-3s |
| `token_market_snapshot` | DexScreener market data: price, volume, liquidity, buy/sell ratio | $0.02 | <1s |
| `prediction_market` | Polymarket crypto prediction market odds, volume, and liquidity | $0.03 | 1-2s |
| `il_calculator` | Impermanent loss calculator for standard AMM and Uni V3 concentrated liquidity | $0.03 | 1-2s |
| `yield_analysis` | IL-aware yield opportunities on Base via DefiLlama | $0.05 | 2-3s |
| `technical_analysis` | RSI, SMA, Bollinger Bands, support/resistance from GeckoTerminal OHLCV | $0.05 | 2-3s |
| `agent_audit_standard` | LLM-driven agent stress test (10 jobs, scored report) | $15.00 | ~5min |

## Quick Start: One Call Gets Everything

The `mega_report` bundles security, market data, smart money, narrative, and technical analysis into a single request — cheaper than calling each service individually ($0.15 vs ~$0.26).

```bash
# Start a mega report
curl -X POST https://api.wolfpack.roklabs.dev/api/v1/intelligence/mega-report \
  -H "Content-Type: application/json" \
  -d '{"token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed", "chain": "base"}'

# Response includes a report_id — retrieve the full report:
curl https://api.wolfpack.roklabs.dev/api/mega-reports/abc123-report-id
```

**mega_report input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "chain": "base"
}
```

**mega_report output:**
```json
{
  "report_id": "abc123-report-id",
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "security": {
    "safe": true,
    "honeypot": false,
    "verified_source": true,
    "risk_flags": []
  },
  "market": {
    "price_usd": 0.0123,
    "volume_24h": 5200000,
    "liquidity_usd": 3100000,
    "price_change_24h": 12.5
  },
  "smart_money": {
    "net_flow_24h": 150000,
    "active_wallets": 12,
    "trend": "accumulating"
  },
  "narrative": {
    "momentum_score": 72,
    "sentiment": "bullish",
    "tweet_count": 340
  },
  "technical_analysis": {
    "rsi_14": 58.3,
    "sma_20": 0.0118,
    "bollinger_position": "middle",
    "support": 0.0105,
    "resistance": 0.0140
  },
  "overall_risk_score": 35,
  "risk_level": "medium"
}
```

## Quick Start: Simple Security Check

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
| `POST /api/v1/intelligence/mega-report` | mega_report |
| `POST /api/v1/intelligence/security-check` | security_check |
| `POST /api/v1/intelligence/token-risk` | token_risk_analysis |
| `POST /api/v1/intelligence/narrative-score` | narrative_momentum |
| `POST /api/v1/intelligence/agent-trust` | agent_trust_score |
| `POST /api/v1/intelligence/prediction-market` | prediction_market |
| `POST /api/v1/intelligence/il-calculator` | il_calculator |
| `POST /api/v1/intelligence/yield-scanner` | yield_analysis |
| `POST /api/v1/intelligence/technical-analysis` | technical_analysis |
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

11 tools available: `mega_report`, `security_check`, `token_risk_analysis`, `narrative_momentum`, `agent_trust_score`, `smart_money_signals`, `token_market_snapshot`, `prediction_market`, `il_calculator`, `yield_scanner`, `technical_analysis`

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

### mega_report

Aggregated intelligence report combining security, market data, smart money, narrative, and technical analysis in one call. Submit via POST, retrieve the full report via GET using the returned `report_id`.

**Input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "chain": "base"
}
```

**Output:** See [mega_report output example above](#quick-start-one-call-gets-everything).

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

### prediction_market

Polymarket crypto prediction market data — odds, volume, liquidity, and outcome probabilities.

**Input:**
```json
{
  "query": "Bitcoin above 100k",
  "category": "crypto"
}
```

**Output:**
```json
{
  "markets": [
    {
      "title": "Will Bitcoin be above $100k on June 30?",
      "outcome_yes": 0.72,
      "outcome_no": 0.28,
      "volume_usd": 4500000,
      "liquidity_usd": 890000,
      "end_date": "2026-06-30T00:00:00Z"
    }
  ],
  "total_markets": 1
}
```

### il_calculator

Impermanent loss calculator supporting standard constant-product AMM and Uniswap V3 concentrated liquidity positions.

**Input (standard):**
```json
{
  "entry_price": 3200.0,
  "current_price": 3500.0,
  "position_size_usd": 10000
}
```

**Input (concentrated — Uni V3):**
```json
{
  "entry_price": 3200.0,
  "current_price": 3500.0,
  "position_size_usd": 10000,
  "pool_type": "concentrated",
  "price_lower": 3000.0,
  "price_upper": 4000.0
}
```

**Output:**
```json
{
  "pool_type": "concentrated",
  "il": {
    "il_percent": 0.95,
    "il_usd": 99.06,
    "lp_value_usd": 10567.81,
    "hodl_value_usd": 10468.75,
    "price_ratio": 1.09,
    "in_range": true,
    "price_lower": 3000,
    "price_upper": 4000,
    "amplification_factor": 9.43
  },
  "summary": "V3 Concentrated IL Analysis..."
}
```

### yield_analysis

IL-aware yield opportunities on Base sourced from DefiLlama. Factors in impermanent loss estimates so agents can compare real returns.

**Input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "min_tvl_usd": 100000,
  "min_apy": 5.0
}
```

### technical_analysis

RSI, SMA, Bollinger Bands, support/resistance levels computed from GeckoTerminal OHLCV data.

**Input:**
```json
{
  "token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed",
  "chain": "base",
  "timeframe": "1h",
  "periods": 50
}
```

## Architecture

Wolfpack Intelligence is a live production system running on Base chain. Services are deterministic where possible (no LLM in security_check, smart_money_signals, token_market_snapshot) and LLM-enhanced where value requires it (narrative_momentum, agent_audit).

All data is sourced from on-chain and public APIs: GoPlus Security, DexScreener, Dune Analytics, TwitterAPI.io, CoinGecko, GeckoTerminal, DefiLlama, Polymarket.

## Links

- **API Base URL:** `https://api.wolfpack.roklabs.dev`
- **MCP Server Card:** `https://api.wolfpack.roklabs.dev/.well-known/mcp/server-card.json`
- **A2A Agent Card:** `https://api.wolfpack.roklabs.dev/.well-known/agent.json`
- **Health Check:** `https://api.wolfpack.roklabs.dev/api/health`

## License

MIT
