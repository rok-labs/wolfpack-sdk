# Wolfpack Intelligence — Service Pricing

All prices are in USDC on Base chain. All standard intelligence services are **$0.01** per call.

| Service | Price | Protocol | Response Time |
|---------|-------|----------|---------------|
| `mega_report` | $0.01 | x402, MCP, A2A | 5-8s |
| `security_check` | $0.01 | ACP, x402, MCP, A2A | <1s |
| `token_risk_analysis` | $0.01 | ACP, x402, MCP, A2A | 3-5s |
| `narrative_momentum` | $0.01 | ACP, x402, MCP, A2A | 2-4s |
| `agent_trust_score` | $0.01 | x402, MCP, A2A | 2-3s |
| `smart_money_signals` | $0.01 | x402, MCP, A2A | 2-3s |
| `token_market_snapshot` | $0.01 | x402, MCP, A2A | <1s |
| `prediction_market` | $0.01 | x402, MCP, A2A | 1-2s |
| `il_calculator` | $0.01 | x402, MCP, A2A | 1-2s |
| `yield_scanner` | $0.01 | x402, MCP, A2A | 2-3s |
| `technical_analysis` | $0.01 | x402, MCP, A2A | 2-3s |
| `graduation_readiness_check` | $0.01 (lite) / **$1.00** (full) | x402, MCP, A2A | 3-5s |
| `agent_audit_standard` | **$15.00** | ACP | ~5min |

## Free Resources

No payment required. Cached intelligence snapshots updated periodically.

| Resource | Endpoint |
|----------|----------|
| `latest_narrative_signals` | `GET /api/v1/resources/latest-narrative-signals` |
| `token_safety_quick_list` | `GET /api/v1/resources/token-safety-quick-list` |
| `whale_watch_summary` | `GET /api/v1/resources/whale-watch-summary` |

## mega_report — Convenience, Not Discount

The `mega_report` service runs security, market data, smart money, narrative momentum, and technical analysis in parallel and returns a unified response with a combined risk score.

At $0.01, it costs the same as any individual service — the value is **convenience**: one call, one response, all 5 dimensions of intelligence, with a unified `overall_risk_score`.

## graduation_readiness_check — Two Tiers

| Tier | Price | What It Does |
|------|-------|-------------|
| **lite** | $0.01 | Metadata + schema validation. Checks offering description, input/output schemas, endpoint config. |
| **full** | $1.00 | Live ACP test fires. Executes real jobs against the offering and validates end-to-end response quality. |

## Payment Methods

### x402 (Micropayments)
USDC on Base, processed per-request via the x402 protocol. No account needed — payment is embedded in the HTTP request header.

### ACP (Virtuals Agent Commerce Protocol)
For agents in the Virtuals ecosystem. Jobs are paid via the ACP escrow mechanism.

### MCP / A2A
Currently free (payment optional). Set `REQUIRE_PAYMENT=true` for paid mode.
