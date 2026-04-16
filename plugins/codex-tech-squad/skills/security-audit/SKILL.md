---
name: security-audit
description: Use when the user asks for security review, auth review, vulnerability assessment, secret handling review, or secure coding audit using Codex specialists.
---

# Security Audit

Run a targeted security assessment.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/safety-contract.md`
- `../../references/role-library.md`

## Workflow

1. Identify scope: diff, module, endpoint, or whole repo.
2. Inspect auth, authorization, input handling, secrets, logging, unsafe shell,
   dependency usage, and data exposure.
3. Use `security-reviewer` as `explorer` or `default`.
4. Use implementation workers only when the user asks to fix findings.
5. Verify fixes with focused tests or static checks when available.

## Output

- findings by severity
- affected files
- exploitability or impact
- remediation
- residual risk
