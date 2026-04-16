---
name: pr-review
description: Use when the user asks to review a pull request, inspect a diff, run a specialist code review bench, or produce actionable PR findings with Codex subagents.
---

# PR Review

Review a PR or diff with only the relevant specialist reviewers.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`

## Workflow

1. Fetch or read PR metadata and diff.
2. Identify changed files and risk areas.
3. Spawn `default` as `reviewer` for correctness.
4. Add specialist reviewers only when justified:
   - `security-reviewer`
   - `performance-reviewer`
   - `accessibility-reviewer`
   - `data-engineer` or `devops-engineer`
5. Consolidate findings.
6. Present findings first, ordered by severity, with file/line references when available.

## Output

- blocking findings
- non-blocking findings
- test gaps
- open questions

If no issues are found, say so and mention residual risk.
