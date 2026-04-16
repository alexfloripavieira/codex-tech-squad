---
name: squad
description: Use when the user explicitly asks Codex to form a development squad, team, subagents, parallel agents, or delegated end-to-end software delivery workflow. Orchestrates discovery, implementation, tests, review, docs, and release preparation with bounded Codex native subagents.
---

# Squad

Run an end-to-end software delivery workflow with a small Codex-native team.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`
- `../../references/workflow-contracts.md`

## Trigger Requirement

This skill is explicit authorization to use subagents because the user invoked
`codex-tech-squad:squad` or asked for a squad/team/subagents.

## Workflow

1. Inspect the repository enough to identify stack, test commands, and likely
   ownership boundaries.
2. Define the critical path the main Codex agent will handle locally.
3. Select a small team. Prefer:
   - `explorer` as `architect` or `tech-lead`
   - `worker` as one or more implementation specialists
   - `worker` or `default` as `qa-engineer`
   - `default` as `reviewer`
4. Give workers disjoint ownership.
5. Continue local work while subagents run.
6. Integrate outputs and inspect every changed file.
7. Run the most relevant verification.
8. Summarize team, files changed, checks, and remaining risks.

## Team Guidance

Default team:

- `tech-lead` for plan and ownership
- implementation worker based on stack
- `qa-engineer` for focused tests
- `reviewer` for final diff review

Add `security-reviewer`, `performance-reviewer`, or `accessibility-reviewer`
only when the changed files justify that specialty.

## Final Answer

Include:

- team used
- implementation summary
- changed files
- verification
- unresolved risks
