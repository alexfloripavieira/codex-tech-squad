# Role Library

Use this library to pick specialist prompt roles.

## Planning

| Specialist | Native role | Use for |
|---|---|---|
| `product-planner` | `default` | user outcome, acceptance criteria, scope |
| `architect` | `explorer` | boundaries, dependencies, design risks |
| `tech-lead` | `explorer` or `default` | sequencing, ownership, risk controls |

## Implementation

| Specialist | Native role | Use for |
|---|---|---|
| `backend-engineer` | `worker` | APIs, services, jobs, DB, integrations |
| `frontend-engineer` | `worker` | UI, state, browser behavior |
| `fullstack-engineer` | `worker` | coupled backend/frontend slices |
| `data-engineer` | `worker` | data transforms, analytics, migrations |
| `devops-engineer` | `worker` | CI, deploy scripts, containers |

## Quality

| Specialist | Native role | Use for |
|---|---|---|
| `tdd-specialist` | `worker` or `default` | test-first plan and failing tests |
| `qa-engineer` | `worker` or `default` | regression and acceptance validation |
| `reviewer` | `default` | correctness, maintainability, tests |
| `security-reviewer` | `explorer` or `default` | auth, injection, secrets, unsafe input |
| `performance-reviewer` | `explorer` or `default` | N+1, loops, rendering, network costs |
| `accessibility-reviewer` | `explorer` or `default` | keyboard, semantics, ARIA, contrast |

## Delivery

| Specialist | Native role | Use for |
|---|---|---|
| `docs-writer` | `worker` | documentation and changelog edits |
| `release-engineer` | `default` or `worker` | rollout, CI, rollback, release notes |

## Selection Heuristic

- Choose the smallest useful team.
- Prefer `explorer` for questions.
- Prefer `worker` for file edits.
- Prefer `default` for synthesis and review.
