/**
 * Wolfpack Intelligence — x402 Security Check Example
 *
 * Pre-trade security scan using x402 micropayments (USDC on Base).
 * Returns honeypot status, contract verification, ownership flags.
 *
 * Install: npm install @anthropic-ai/x402
 */

const WOLFPACK_API = "https://api.wolfpack.roklabs.dev";

async function securityCheck(tokenAddress: string): Promise<{
  safe: boolean;
  honeypot: boolean;
  verified_source: boolean;
  hidden_owner: boolean;
  holder_count: number;
  top10_holder_percent: number;
  risk_flags: string[];
}> {
  const response = await fetch(`${WOLFPACK_API}/api/v1/intelligence/security-check`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      token_address: tokenAddress,
      chain: "base",
    }),
  });

  if (!response.ok) {
    throw new Error(`Security check failed: ${response.status} ${response.statusText}`);
  }

  return response.json();
}

// Example: Check DEGEN token on Base
async function main() {
  const DEGEN = "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed";

  console.log(`Checking ${DEGEN}...`);
  const result = await securityCheck(DEGEN);

  console.log(`Safe: ${result.safe}`);
  console.log(`Honeypot: ${result.honeypot}`);
  console.log(`Verified: ${result.verified_source}`);
  console.log(`Holders: ${result.holder_count}`);
  console.log(`Top 10 concentration: ${result.top10_holder_percent}%`);

  if (result.risk_flags.length > 0) {
    console.log(`Risk flags: ${result.risk_flags.join(", ")}`);
  }

  // Gate your trade on the result
  if (result.safe) {
    console.log("Token passed security check — safe to trade");
  } else {
    console.log("TOKEN FAILED SECURITY CHECK — do not trade");
  }
}

main().catch(console.error);
