---
name: hotfix
description: Use when the user asks for urgent production or staging repair, emergency fix, hotfix, patch emergencial, or minimal high-priority correction with a small Codex team.
---

# Hotfix

Apply the smallest safe fix for an urgent issue.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/safety-contract.md`

## Workflow

1. Confirm symptom, scope, target environment, and base branch if relevant.
2. Keep the team minimal:
   - `explorer` as `tech-lead` for root cause
   - one `worker` for the minimal patch
   - optional `default` reviewer or `qa-engineer`
3. Avoid broad refactors.
4. Run the fastest meaningful verification.
5. Document rollback or mitigation notes.

## Safety

Do not deploy, tag, or merge unless explicitly requested. Do not bypass auth,
disable checks, or use destructive commands as a workaround.

## Final Answer

Include patch summary, verification, rollout risk, and rollback note.
