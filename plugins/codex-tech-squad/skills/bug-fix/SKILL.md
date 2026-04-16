---
name: bug-fix
description: Use when the user asks to fix, debug, investigate, reproduce, or resolve a bug with a Codex team or subagents. Runs root cause analysis, minimal patch, regression tests, and review.
---

# Bug Fix

Resolve a contained bug with root cause, patch, tests, and verification.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`

## Intake

Collect or infer:

- symptom
- expected behavior
- reproduction steps
- affected environment
- recent related changes

Do not block on missing fields if the repository can answer them safely.

## Workflow

1. Reproduce or narrow the bug locally.
2. Spawn `explorer` as `tech-lead` for root cause when useful.
3. Add or identify a failing regression test when feasible.
4. Spawn one implementation `worker` with narrow ownership.
5. Use `qa-engineer` for focused verification if independent.
6. Review the diff and run checks.

## Escalation

Escalate to `squad` when the bug needs architectural changes or broad
cross-module work.

## Final Answer

Include root cause, fix summary, tests, and residual risk.
