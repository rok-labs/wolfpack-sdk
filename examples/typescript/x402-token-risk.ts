/**
 * Wolfpack Intelligence — x402 Token Risk Analysis Example
 *
 * Comprehensive 360° risk scoring: GoPlus honeypot detection,
 * DexScreener liquidity analysis, Dune smart money patterns,
 * and Twitter social signal monitoring.
 *
 * Install: npm install @anthropic-ai/x402
 */

const WOLFPACK_API = "https://api.wolfpack.roklabs.dev";

async function tokenRiskAnalysis(tokenAddress: string, depth: "standard" | "deep" = "standard") {
  const response = await fetch(`${WOLFPACK_API}/api/v1/intelligence/token-risk`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      token_address: tokenAddress,
      chain: "base",
      analysis_depth: depth,
    }),
  });

  if (!response.ok) {
    throw new Error(`Token risk analysis failed: ${response.status}`);
  }

  return response.json();
}

// Example: Analyze VIRTUAL token
async function main() {
  const VIRTUAL = "0x0b3e328455c4059EEb9e3f84b5543F74E24e7E1b";

  console.log("Running standard token risk analysis...");
  const result = await tokenRiskAnalysis(VIRTUAL);

  console.log(`Risk Score: ${result.risk_score}/100`);
  console.log(`Risk Level: ${result.risk_level}`);
  console.log(JSON.stringify(result, null, 2));
}

main().catch(console.error);
