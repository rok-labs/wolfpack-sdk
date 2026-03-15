# Wolfpack Intelligence SDK

On-chain security and market intelligence for trading agents on Base.

Wolfpack provides 14 intelligence services, 1 premium audit service, and 3 free resources via x402, MCP, A2A, and ACP. Over 3,000 queries served across 13+ unique agent buyers. 3 services graduated on Virtuals ACP, 11 pending graduation.

## Services

All prices in USDC on Base. x402 endpoints require USDC payment. MCP and A2A are free.

| Service | Description | Price | Latency |
|---------|-------------|-------|---------|
| `security_check` | GoPlus 13-point security scan (nested `checks` object) | $0.01 | <1s |
| `token_risk_analysis` | 360° risk audit with nested `checks` sub-objects | $0.02 | 3-5s |
| `narrative_momentum` | Social signal scoring: Twitter/X velocity, engagement, KOL ratio | $0.05 | 2-4s |
| `token_market_snapshot` | DexScreener market data: price, volume, liquidity, buy/sell ratio | $0.25 | <1s |
| `agent_trust_score` | Sybil-aware agent reliability rating (ACP performance, wallet health, review integrity) | $0.50 | 2-3s |
| `il_calculator` | Impermanent loss for standard AMM and Uni V3 concentrated liquidity | $0.50 | 1-2s |
| `smart_money_signals` | Real-time smart money wallet activity on Base via Dune | $1.00 | 2-3s |
| `prediction_market` | Polymarket crypto prediction market odds, volume, and liquidity | $1.00 | 1-2s |
| `yield_scanner` | IL-aware yield opportunities on Base via DefiLlama | $1.00 | 2-3s |
| `technical_analysis` | RSI, SMA, Bollinger Bands, support/resistance from GeckoTerminal OHLCV | $1.00 | 2-3s |
| `agent_credit_risk_index` | Financial credit risk scoring for ACP agents (liquidity, reliability, maturity) | $1.00 | 2-3s |
| `trade_signals` | Composite buy/sell/hold signals from TA + smart money + narrative + risk | $2.00 | 3-5s |
| `mega_report` | Aggregated: security + market + smart money + narrative + TA in one call | $5.00 | 5-8s |
| `graduation_readiness_check` | Live ACP graduation readiness audit with real test fires | $5.00 | 3-5s |

**Premium:** `agent_audit` — LLM-driven agent stress test (10 jobs, scored report) — **$15.00** / ~5min (not on Virtuals)

## Free Resources

Cached intelligence snapshots, no payment required.

| Resource | Endpoint |
|----------|----------|
| `latest_narrative_signals` | `GET /api/v1/resources/latest-narrative-signals` |
| `token_safety_quick_list` | `GET /api/v1/resources/token-safety-quick-list` |
| `whale_watch_summary` | `GET /api/v1/resources/whale-watch-summary` |

## Authentication

| Protocol | Auth | Notes |
|----------|------|-------|
| **x402** | USDC payment (no API key) | Payment embedded in HTTP header. All x402 endpoints require payment. |
| **MCP** | None | Unauthenticated, free |
| **A2A** | None | Unauthenticated, free |
| **ACP** | Virtuals agent identity | USDC via Virtuals escrow |
| **Admin** | `WOLFPACK_ADMIN_KEY` or `WOLFPACK_READ_KEY` | Header-based key auth |
| **Dashboard** | Cookie session | Browser sessions for dashboard UI |

## Quick Start: Security Check

```bash
curl -X POST https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check \
  -H "Content-Type: application/json" \
  -d '{"token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed"}'
```

Response (nested `checks` object with 13 fields):
```json
{
  "safe": true,
  "checks": {
    "is_honeypot": false,
    "verified_source": true,
    "hidden_owner": false,
    "can_take_back_ownership": false,
    "is_proxy": false,
    "is_mintable": false,
    "selfdestruct": false,
    "owner_change_balance": false,
    "is_blacklisted": false,
    "is_open_source": true,
    "external_call": false,
    "transfer_pausable": false,
    "trading_cooldown": false
  },
  "holder_count": 45000,
  "top10_holder_percent": 32.5,
  "creator_percent": 0.0,
  "risk_flags": []
}
```

## Quick Start: Mega Report

```bash
# Submit
curl -X POST https://api.wolfpack.roklabs.dev/api/v1/intelligence/mega-report \
  -H "Content-Type: application/json" \
  -d '{"token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed", "chain": "base"}'

# Retrieve full report
curl https://api.wolfpack.roklabs.dev/api/mega-reports/<report_id>
```

## x402 Endpoints (All 18)

All endpoints require USDC payment on Base via x402 protocol.

**Base URL:** `https://api.wolfpack.roklabs.dev`

| Endpoint | Service | Price |
|----------|---------|-------|
| `POST /api/v1/intelligence/security-check` | security_check | $0.01 |
| `POST /api/v1/intelligence/token-risk` | token_risk_analysis | $0.02 |
| `POST /api/v1/intelligence/narrative-score` | narrative_momentum | $0.05 |
| `POST /api/v1/intelligence/token-market-snapshot` | token_market_snapshot | $0.25 |
| `POST /api/v1/intelligence/agent-trust` | agent_trust_score | $0.50 |
| `POST /api/v1/intelligence/il-calculator` | il_calculator | $0.50 |
| `POST /api/v1/intelligence/smart-money-signals` | smart_money_signals | $1.00 |
| `POST /api/v1/intelligence/prediction-market` | prediction_market | $1.00 |
| `POST /api/v1/intelligence/yield-scanner` | yield_scanner | $1.00 |
| `POST /api/v1/intelligence/technical-analysis` | technical_analysis | $1.00 |
| `POST /api/v1/intelligence/agent-credit-risk-index` | agent_credit_risk_index | $1.00 |
| `POST /api/v1/intelligence/trade-signals` | trade_signals | $2.00 |
| `POST /api/v1/intelligence/mega-report` | mega_report | $5.00 |
| `GET  /api/mega-reports/:id` | mega_report (retrieve) | — |
| `POST /api/v1/intelligence/graduation-readiness-check` | graduation_readiness_check | $5.00 |
| `POST /api/v1/intelligence/query` | Unified query (route via `service_type`) | varies |
| `POST /api/v1/intelligence/query` | agent_audit (via `service_type`) | $15.00 |
| `GET  /api/v1/resources/*` | Free resources (3 endpoints) | free |

## MCP (Model Context Protocol)

Connect any MCP-compatible client (Claude Desktop, Cursor, etc.) to Wolfpack as a tool provider.

**Config for Claude Desktop** — copy [`mcp/claude-desktop-config.json`](./mcp/claude-desktop-config.json):

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

**10 MCP tools available:**

1. `security_check` — GoPlus token security scan
2. `token_risk_analysis` — Multi-source risk scoring
3. `narrative_momentum` — Social momentum scoring
4. `token_market_snapshot` — DexScreener market data
5. `smart_money_signals` — Dune smart money activity
6. `technical_analysis` — RSI, SMA, Bollinger Bands
7. `mega_report` — Aggregated intelligence report
8. `prediction_market` — Polymarket prediction data
9. `il_calculator` — Impermanent loss calculator
10. `yield_scanner` — IL-aware yield opportunities

## Google A2A (Agent-to-Agent)

JSON-RPC 2.0 protocol for agent-to-agent communication.

**Endpoint:** `POST https://api.wolfpack.roklabs.dev/api/v1/a2a`
**Agent Card:** [`https://api.wolfpack.roklabs.dev/.well-known/agent.json`](https://api.wolfpack.roklabs.dev/.well-known/agent.json)

## Virtuals ACP (Agent Commerce Protocol)

For agents in the Virtuals ecosystem. 3 graduated services, 11 pending graduation, 3,000+ queries across 13+ unique agent buyers.

**Graduated:** `token_risk_analysis`, `security_check`, `narrative_momentum`
**Pending:** `agent_trust_score`, `smart_money_signals`, `token_market_snapshot`, `mega_report`, `prediction_market`, `il_calculator`, `yield_scanner`, `technical_analysis`, `graduation_readiness_check`, `agent_credit_risk_index`, `trade_signals`

**Portal name mapping** — Virtuals ACP portal uses different names for some services:

| Internal Name | Virtuals Portal Name |
|---------------|---------------------|
| `security_check` | `quicksecuritycheck` |
| `narrative_momentum` | `narrativemomentumscore` |
| All others | Same as internal name |

## EIP-712 Attestation

Three services support verifiable signed attestations: `security_check`, `token_risk_analysis`, and `agent_trust_score`.

Pass `"attestation": true` in the request body:

```bash
curl -X POST https://api.wolfpack.roklabs.dev/api/v1/intelligence/security-check \
  -H "Content-Type: application/json" \
  -d '{"token_address": "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed", "attestation": true}'
```

The response includes an EIP-712 typed signature that can be verified on-chain:

```json
{
  "safe": true,
  "checks": { "..." : "..." },
  "attestation": {
    "signature": "0xabc123...",
    "nonce": 42,
    "chain_id": 8453,
    "timestamp": "2026-03-13T12:00:00Z"
  }
}
```

- **Chain ID:** 8453 (Base)
- **Nonce:** Monotonic (prevents replay)
- **Supported services:** `security_check`, `token_risk_analysis`, `agent_trust_score`

## ACP Response Compaction

When services are called via ACP (Virtuals Agent Commerce Protocol), responses are compacted to fit ACP's message size constraints:

| Rule | Detail |
|------|--------|
| Numbers | Rounded to 3 decimal places |
| Arrays | Capped to 3 items |
| Strings | Truncated at 100 characters |
| Total | Hard 2,000-character JSON budget |

**x402 / direct API returns full uncompacted responses.** If you need complete data (all array items, full precision, full strings), use x402 or direct HTTP instead of ACP.

Example: `narrative_momentum` via ACP returns `top_tweets` capped to 3 items with `.text` field removed. The same call via x402 returns all tweets with full text.

## Service Details

### security_check

GoPlus-powered token security scan. Response uses a nested `checks` object (not flat top-level fields). 13 boolean checks covering honeypot, ownership, proxy, minting, blacklisting, self-destruct, and more. Supports EIP-712 attestation.

**Input:** `{ "token_address": "0x...", "chain": "base", "attestation": false }`

### token_risk_analysis

Multi-source 360° risk scoring. Response uses nested `checks` with sub-objects: each check has `{ passed, details, locked_pct }` fields. Includes `recommendation` and `analysis_timestamp` fields. Supports EIP-712 attestation.

**Input:** `{ "token_address": "0x...", "chain": "base", "analysis_depth": "standard", "attestation": false }`

### narrative_momentum

Social momentum scoring. **Field names differ from older versions:** `score` (not `momentum_score`), `mention_count` (not `tweet_count`), `sentiment` is a number from -1 to +1 (not an enum string). `top_tweets` capped to 3, `.text` field removed by compaction.

**Input:** `{ "query": "AI agents on Base", "keywords": ["autonomous"], "contracts": ["0x..."] }`

### agent_trust_score

Sybil-aware composite agent reliability rating. Scores ACP performance (40%), network position (25%), operational health (25%), and metadata compliance (10%). Now includes `review_integrity` — on-chain wallet age analysis that penalizes agents with manufactured reputation (same-day reviewer wallets, batch-created clusters). The `review_integrity.modifier` (0.3/0.6/1.0/1.1) is applied to the composite score. Field is absent when agent has <10 reviews. Supports EIP-712 attestation.

**Input:** `{ "agent_address": "0x...", "agent_id": 16907, "attestation": false }`

### trade_signals

Composite trade signal generation. Combines technical analysis, smart money flows, narrative momentum, and risk scoring into actionable buy/sell/hold signals with confidence levels, entry/stop-loss/take-profit suggestions.

**Input:** `{ "token_address": "0x...", "chain": "base", "timeframe": "4h" }`

### mega_report

Aggregated intelligence: security + market data + smart money + narrative + TA. Submit via POST, retrieve via GET using the returned `report_id`.

**Input:** `{ "token_address": "0x...", "chain": "base" }`

### graduation_readiness_check

Live ACP graduation readiness audit ($5.00). Fires real test jobs against agent services, scores job lifecycle handling, schema correctness, and output consistency.

**Input:** `{ "target_agent_address": "0x...", "offering_name": "token_risk_analysis" }`

### agent_credit_risk_index

Financial credit risk scoring. Three pillars: realized liquidity (40%), execution reliability (40%), wallet maturity (20%). Returns 0-100 score with letter rating.

**Input:** `{ "agent_id": 16907 }`

### agent_audit

LLM-driven agent stress test ($15.00, not on Virtuals). Fires 10 adversarial test jobs, scores response quality, latency, error handling, schema compliance.

**Input:** `{ "agent_address": "0x...", "service_type": "token_risk_analysis" }`

## Examples

- **TypeScript:** [`examples/typescript/`](./examples/typescript/) — x402 payment, MCP client, A2A task
- **Python:** [`examples/python/`](./examples/python/) — x402 payment examples
- **curl:** [`examples/curl/`](./examples/curl/) — Raw HTTP examples for all services
- **Schemas:** [`schemas/`](./schemas/) — JSON Schema for all service inputs/outputs

## Architecture

Wolfpack Intelligence runs on Base chain. Services are deterministic where possible (no LLM in security_check, smart_money_signals, token_market_snapshot) and LLM-enhanced where needed (narrative_momentum, agent_audit).

Data sources: GoPlus Security, DexScreener, Dune Analytics, TwitterAPI.io, CoinGecko, GeckoTerminal, DefiLlama, Polymarket.

## Links

- **API Base URL:** `https://api.wolfpack.roklabs.dev`
- **MCP Server Card:** `https://api.wolfpack.roklabs.dev/.well-known/mcp/server-card.json`
- **A2A Agent Card:** `https://api.wolfpack.roklabs.dev/.well-known/agent.json`
- **Health Check:** `https://api.wolfpack.roklabs.dev/api/health`

## License

MIT
