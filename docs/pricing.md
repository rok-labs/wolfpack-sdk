# Wolfpack Intelligence — Service Pricing

All prices are in USDC on Base chain.

| Service | Price | Protocol | Response Time |
|---------|-------|----------|---------------|
| `mega_report` | **$0.15** | x402, MCP, A2A | 5-8s |
| `security_check` | $0.01 | ACP, x402, MCP, A2A | <1s |
| `token_risk_analysis` | $0.05 (standard) / $0.50 (deep) | ACP, x402, MCP, A2A | 3-5s / 8-12s |
| `narrative_momentum` | $0.10 | ACP, x402, MCP, A2A | 2-4s |
| `agent_trust_score` | $0.05 | ACP, x402, MCP, A2A | 2-3s |
| `smart_money_signals` | $0.03 | x402, MCP, A2A | 2-3s |
| `token_market_snapshot` | $0.02 | x402, MCP, A2A | <1s |
| `prediction_market` | $0.03 | x402, MCP, A2A | 1-2s |
| `il_calculator` | $0.03 | x402, MCP, A2A | 1-2s |
| `yield_scanner` | $0.05 | x402, MCP, A2A | 2-3s |
| `technical_analysis` | $0.05 | x402, MCP, A2A | 2-3s |
| `agent_audit_standard` | $15.00 (standard) | ACP | ~5min |

## mega_report Bundle Discount

The `mega_report` service combines security, market data, smart money, narrative momentum, and technical analysis into a single call for **$0.15**.

Calling each component individually would cost approximately **$0.26**:
- `security_check` — $0.01
- `token_market_snapshot` — $0.02
- `smart_money_signals` — $0.03
- `token_risk_analysis` — $0.05
- `narrative_momentum` — $0.10
- `technical_analysis` — $0.05
- **Total: $0.26 – $0.28**

The mega report saves ~42% and returns all data in a single request with a unified risk score.

## Payment Methods

### x402 (Micropayments)
USDC on Base, processed per-request via the x402 protocol. No account needed — payment is embedded in the HTTP request header.

### ACP (Virtuals Agent Commerce Protocol)
For agents in the Virtuals ecosystem. Jobs are paid via the ACP escrow mechanism.

### MCP / A2A
Currently free (payment optional). Set `REQUIRE_PAYMENT=true` for paid mode.
