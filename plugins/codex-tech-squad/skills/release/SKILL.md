---
name: release
description: Use when the user asks to prepare a release, changelog, version bump, rollout plan, rollback plan, or release readiness review with Codex.
---

# Release

Prepare release artifacts and readiness notes.

## Load First

- `../../references/safety-contract.md`
- `../../references/workflow-contracts.md`
- `../../agents/release-engineer.md`

## Workflow

1. Inspect version, changelog, and current branch state.
2. Confirm release target and scope.
3. Validate required checks where available.
4. Prepare changelog, release notes, rollout, and rollback notes.
5. Do not tag, publish, or deploy unless explicitly requested.

## Output

- release summary
- included changes
- validation status
- rollout plan
- rollback plan
- blockers
