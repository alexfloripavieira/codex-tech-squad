---
name: implement
description: Use when the user asks to implement a known plan or feature with a Codex development team, subagents, or parallel workers. Coordinates bounded implementation, tests, review, and verification.
---

# Implement

Implement a known plan with focused Codex workers.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`
- `../../references/workflow-contracts.md`

## Workflow

1. Confirm the plan, acceptance criteria, and constraints.
2. Inspect the repo enough to identify patterns and tests.
3. Split work into independent slices.
4. Spawn workers only for disjoint ownership areas.
5. Keep integration and verification with the main Codex agent.
6. Run focused checks.
7. Use a reviewer only after a concrete diff exists.

## Common Team

- `explorer` as `tech-lead` for sequencing and risk
- `worker` as `backend-engineer`, `frontend-engineer`, or `fullstack-engineer`
- `worker` as `qa-engineer` or `tdd-specialist`
- `default` as `reviewer`

## Final Answer

Mention implementation, files changed, verification, and any known gaps.
