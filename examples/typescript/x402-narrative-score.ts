/**
 * Wolfpack Intelligence — x402 Narrative Momentum Example
 *
 * Scores the social momentum of a crypto narrative or topic.
 * Analyzes Twitter/X signals with VADER sentiment, engagement
 * quality, and influencer ratio.
 */

const WOLFPACK_API = "https://api.wolfpack.roklabs.dev";

async function narrativeMomentum(query: string, keywords?: string[], contracts?: string[]) {
  const response = await fetch(`${WOLFPACK_API}/api/v1/intelligence/narrative-score`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ query, keywords, contracts }),
  });

  if (!response.ok) {
    throw new Error(`Narrative score failed: ${response.status}`);
  }

  return response.json();
}

// Example: Score "AI Agents on Base" narrative
async function main() {
  const result = await narrativeMomentum(
    "AI agents on Base",
    ["autonomous", "agent", "virtual"],
  );

  console.log(`Momentum Score: ${result.score}/100`);
  console.log(`Sentiment: ${result.sentiment}`);
  console.log(`Mention Count: ${result.mention_count}`);
  console.log(JSON.stringify(result, null, 2));
}

main().catch(console.error);
