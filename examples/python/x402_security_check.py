"""
Wolfpack Intelligence — Python Security Check Example

Pre-trade security scan. No SDK needed — just requests.

pip install requests
"""

import requests
import json

WOLFPACK_API = "https://api.wolfpack.roklabs.dev"


def security_check(token_address: str, chain: str = "base") -> dict:
    """Run a GoPlus-powered security scan on a token."""
    response = requests.post(
        f"{WOLFPACK_API}/api/v1/intelligence/security-check",
        json={"token_address": token_address, "chain": chain},
    )
    response.raise_for_status()
    return response.json()


def token_risk_analysis(
    token_address: str, chain: str = "base", depth: str = "standard"
) -> dict:
    """Run a comprehensive 360° token risk analysis."""
    response = requests.post(
        f"{WOLFPACK_API}/api/v1/intelligence/token-risk",
        json={
            "token_address": token_address,
            "chain": chain,
            "analysis_depth": depth,
        },
    )
    response.raise_for_status()
    return response.json()


def narrative_momentum(
    query: str, keywords: list[str] | None = None
) -> dict:
    """Score the social momentum of a crypto narrative."""
    response = requests.post(
        f"{WOLFPACK_API}/api/v1/intelligence/narrative-score",
        json={"query": query, "keywords": keywords or []},
    )
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    # Example: Check DEGEN token on Base
    DEGEN = "0x4ed4E862860BeD51a9570b96d89aF5E1B0Efefed"

    print(f"Security check for {DEGEN}...")
    result = security_check(DEGEN)
    print(json.dumps(result, indent=2))

    if result.get("safe"):
        print("\nToken passed security check — safe to trade")
    else:
        print("\nTOKEN FAILED SECURITY CHECK — do not trade")
