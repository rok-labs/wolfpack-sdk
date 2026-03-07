# Wolfpack Intelligence — Service Pricing

All prices are in USDC on Base chain.

| Service | Price | Protocol | Response Time |
|---------|-------|----------|---------------|
| `security_check` | $0.01 | ACP, x402, MCP, A2A | <1s |
| `token_market_snapshot` | $0.01 | x402, MCP, A2A | <1s |
| `token_risk_analysis` | $0.02 | ACP, x402, MCP, A2A | 3-5s |
| `agent_trust_score` | $0.03 | x402, MCP, A2A | 2-3s |
| `narrative_momentum` | $0.05 | ACP, x402, MCP, A2A | 2-4s |
| `prediction_market` | $0.05 | x402, MCP, A2A | 1-2s |
| `technical_analysis` | $0.05 | x402, MCP, A2A | 2-3s |
| `smart_money_signals` | $0.10 | x402, MCP, A2A | 2-3s |
| `il_calculator` | $0.10 | x402, MCP, A2A | 1-2s |
| `agent_credit_risk_index` | $0.10 | x402, MCP, A2A | 2-3s |
| `yield_scanner` | $0.15 | x402, MCP, A2A | 2-3s |
| `mega_report` | $0.50 | x402, MCP, A2A | 5-8s |
| `graduation_readiness_check` | **$1.49** | x402, MCP, A2A | 3-5s |
| `agent_audit_standard` | **$15.00** | ACP | ~5min |

## Free Resources

No payment required. Cached intelligence snapshots updated periodically.

| Resource | Endpoint |
|----------|----------|
| `latest_narrative_signals` | `GET /api/v1/resources/latest-narrative-signals` |
| `token_safety_quick_list` | `GET /api/v1/resources/token-safety-quick-list` |
| `whale_watch_summary` | `GET /api/v1/resources/whale-watch-summary` |

## mega_report — Convenience Bundle

The `mega_report` service runs security, market data, smart money, narrative momentum, and technical analysis in parallel and returns a unified response with a combined risk score.

At $0.50, it's a convenience bundle — one call, one response, all 5 dimensions of intelligence, with a unified `overall_risk_score`.

## graduation_readiness_check

Live ACP graduation readiness audit ($1.49). Fires real test jobs against the target agent's services, scores job lifecycle handling, schema correctness, and output consistency. Returns blockers, warnings, and remediation steps.

## Payment Methods

### x402 (Micropayments)
USDC on Base, processed per-request via the x402 protocol. No account needed — payment is embedded in the HTTP request header.

### ACP (Virtuals Agent Commerce Protocol)
For agents in the Virtuals ecosystem. Jobs are paid via the ACP escrow mechanism.

### MCP / A2A
Currently free (payment optional). Set `REQUIRE_PAYMENT=true` for paid mode.
