/**
 * Wolfpack Intelligence — Google A2A (Agent-to-Agent) Example
 *
 * Send tasks to Wolfpack using the A2A JSON-RPC 2.0 protocol.
 * No SDK needed — just standard HTTP with JSON-RPC payload.
 */

const WOLFPACK_A2A_URL = "https://api.wolfpack.roklabs.dev/api/v1/a2a";

interface A2ATask {
  id: string;
  status: { state: string; message?: { parts: { text: string }[] } };
}

async function sendA2ATask(skill: string, message: string): Promise<A2ATask> {
  const response = await fetch(WOLFPACK_A2A_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      jsonrpc: "2.0",
      id: Date.now(),
      method: "tasks/send",
      params: {
        id: `task-${Date.now()}`,
        message: {
          role: "user",
          parts: [{ text: message }],
        },
        // Optional: specify which skill to use
        metadata: { skill },
      },
    }),
  });

  const { result, error } = await response.json();
  if (error) throw new Error(`A2A error: ${error.message}`);
  return result;
}

// Example: Request a security check via A2A
async function main() {
  const task = await sendA2ATask(
    "security_check",
    "Check token security for 0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed on Base"
  );

  console.log(`Task ID: ${task.id}`);
  console.log(`Status: ${task.status.state}`);
  if (task.status.message) {
    console.log("Response:", task.status.message.parts.map(p => p.text).join("\n"));
  }
}

main().catch(console.error);
