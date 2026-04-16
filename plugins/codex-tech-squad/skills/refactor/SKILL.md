---
name: refactor
description: Use when the user asks for refactoring, restructuring, reducing duplication, improving architecture, or cleaning code with a Codex team while preserving behavior.
---

# Refactor

Improve structure while preserving behavior.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`

## Workflow

1. Define behavior that must remain unchanged.
2. Identify tests or add characterization tests when feasible.
3. Use `architect` or `tech-lead` to define boundaries.
4. Assign workers to disjoint modules.
5. Avoid broad unrelated cleanup.
6. Run regression checks.
7. Review diff for behavior drift.

## Output

- refactor goal
- changed files
- behavior-preservation evidence
- tests/checks
- residual risk
