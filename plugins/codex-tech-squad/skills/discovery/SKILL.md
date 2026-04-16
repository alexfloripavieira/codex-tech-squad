---
name: discovery
description: Use when the user asks for discovery, blueprint, architecture analysis, implementation planning, or wants a Codex team to map a repository before code changes.
---

# Discovery

Produce a concise blueprint grounded in the repository.

## Load First

- `../../references/agent-orchestration.md`
- `../../references/role-library.md`
- `../../references/safety-contract.md`

## Agent Use

If the user asked for a team or invoked `codex-tech-squad:discovery`, a small
discovery team is authorized. Prefer read-only `explorer` agents:

- `architect`: system map and boundaries
- `qa-engineer`: test surface and verification strategy
- optional `product-planner`: scope and acceptance criteria

## Workflow

1. Inspect repo structure and key files.
2. Identify stack, entry points, test commands, and conventions.
3. Map relevant modules and ownership boundaries.
4. Identify risks, unknowns, and constraints.
5. Produce an implementation blueprint.

## Output

- goal and assumptions
- relevant files/modules
- architecture notes
- implementation plan
- test strategy
- open questions and risks
