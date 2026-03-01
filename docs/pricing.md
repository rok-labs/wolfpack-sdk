# Wolfpack Intelligence — Service Pricing

All prices are in USDC on Base chain.

| Service | Price | Protocol | Response Time |
|---------|-------|----------|---------------|
| `security_check` | $0.01 | ACP, x402, MCP, A2A | <1s |
| `token_risk_analysis` | $0.05 (standard) / $0.50 (deep) | ACP, x402, MCP, A2A | 3-5s / 8-12s |
| `narrative_momentum` | $0.10 | ACP, x402, MCP, A2A | 2-4s |
| `agent_trust_score` | $0.05 | ACP, x402, MCP, A2A | 2-3s |
| `smart_money_signals` | $0.01 | ACP, x402 | 2-3s |
| `token_market_snapshot` | $0.02 | ACP, x402 | <1s |
| `agent_audit_standard` | $15.00 (standard) | ACP | ~5min |

## Payment Methods

### x402 (Micropayments)
USDC on Base, processed per-request via the x402 protocol. No account needed — payment is embedded in the HTTP request header.

### ACP (Virtuals Agent Commerce Protocol)
For agents in the Virtuals ecosystem. Jobs are paid via the ACP escrow mechanism.

### MCP / A2A
Currently free (payment optional). Set `REQUIRE_PAYMENT=true` for paid mode.
