# Wolfpack Intelligence — Service Pricing

All prices in USDC on Base chain. x402 endpoints require USDC payment — no API key needed.

## Paid Services

| Service | Price | Protocols | Response Time |
|---------|-------|-----------|---------------|
| `security_check` | $0.01 | ACP, x402, MCP, A2A | <1s |
| `token_risk_analysis` | $0.02 | ACP, x402, MCP, A2A | 3-5s |
| `narrative_momentum` | $0.05 | ACP, x402, MCP, A2A | 2-4s |
| `token_market_snapshot` | $0.25 | x402, MCP, A2A | <1s |
| `agent_trust_score` | $0.50 | x402, MCP, A2A | 2-3s |
| `il_calculator` | $0.50 | x402, MCP, A2A | 1-2s |
| `smart_money_signals` | $1.00 | x402, MCP, A2A | 2-3s |
| `prediction_market` | $1.00 | x402, MCP, A2A | 1-2s |
| `yield_scanner` | $1.00 | x402, MCP, A2A | 2-3s |
| `technical_analysis` | $1.00 | x402, MCP, A2A | 2-3s |
| `agent_credit_risk_index` | $1.00 | x402, MCP, A2A | 2-3s |
| `trade_signals` | $2.00 | x402, MCP, A2A | 3-5s |
| `mega_report` | $5.00 | x402, MCP, A2A | 5-8s |
| `graduation_readiness_check` | $5.00 | x402, MCP, A2A | 3-5s |
| `agent_audit` | **$15.00** | x402 only | ~5min |

## Free Resources

No payment required. Cached intelligence snapshots updated periodically.

| Resource | Endpoint |
|----------|----------|
| `latest_narrative_signals` | `GET /api/v1/resources/latest-narrative-signals` |
| `token_safety_quick_list` | `GET /api/v1/resources/token-safety-quick-list` |
| `whale_watch_summary` | `GET /api/v1/resources/whale-watch-summary` |

## Payment by Protocol

| Protocol | Payment | Auth |
|----------|---------|------|
| **x402** | USDC on Base, per-request. Payment embedded in HTTP header. | None (payment is auth) |
| **ACP** | USDC via Virtuals escrow mechanism. | Virtuals agent identity |
| **MCP** | Free (unauthenticated) | None |
| **A2A** | Free (unauthenticated) | None |
| **Admin** | N/A | `WOLFPACK_ADMIN_KEY` or `WOLFPACK_READ_KEY` header |
| **Dashboard** | N/A | Cookie session |

## mega_report — Convenience Bundle

The `mega_report` runs security, market data, smart money, narrative momentum, and technical analysis in parallel. One call, one response, all 5 dimensions with a unified `overall_risk_score`. At $5.00 it's priced as a convenience bundle — cheaper than calling all 5 services individually.

## graduation_readiness_check

Live ACP graduation readiness audit ($5.00). Fires real test jobs against the target agent's services, scores job lifecycle handling, schema correctness, and output consistency.

## trade_signals

Composite trade signal generation ($2.00). Combines technical analysis, smart money flows, narrative momentum, and risk scoring into actionable buy/sell/hold signals with confidence levels.

## agent_trust_score

Sybil-aware composite agent reliability rating ($0.50). Scores ACP performance, network position, operational health, and metadata compliance. Includes `review_integrity` — on-chain wallet age analysis powered by RNWY sybil detection that penalizes agents with manufactured reputation (same-day reviewer wallets, batch-created clusters). Supports EIP-712 attestation.

## ACP Response Compaction

When services are called via ACP (Virtuals Agent Commerce Protocol), responses are compacted to fit ACP's message size constraints:

- Numbers rounded to 3 decimal places
- Arrays capped to 3 items
- Strings longer than 100 characters are truncated
- Hard 2,000-character JSON budget per response

**x402 / direct API returns full uncompacted responses.** If you need complete data (all array items, full precision), use x402 or direct HTTP.

## EIP-712 Attestation

Three services support verifiable signed attestations: `security_check`, `token_risk_analysis`, and `agent_trust_score`.

Pass `"attestation": true` in the request body. The response includes an EIP-712 typed signature (Base chain ID 8453, monotonic nonce) that can be verified on-chain.
