# Agent Orchestration

Use this reference from every codex-tech-squad skill.

## Hard Rule

Spawn subagents only when the user explicitly asks for a team, squad,
subagents, delegation, parallel agents, or invokes a team workflow such as:

- `codex-tech-squad:squad`
- `codex-tech-squad:implement`
- `codex-tech-squad:bug-fix`
- `codex-tech-squad:hotfix`
- `codex-tech-squad:pr-review`

If the user did not authorize agents, execute locally and use the specialists
as checklists.

## Native Codex Roles

- `explorer`: read-only repository investigation, architecture, risk, root cause
- `worker`: implementation, tests, docs, or bounded file edits
- `default`: synthesis, review, QA analysis, release analysis

Specialist names are prompt roles. They are not native `agent_type` values.

## Main-Agent Responsibilities

The main Codex agent must:

1. Inspect enough context before delegating.
2. Identify the immediate critical-path task to do locally.
3. Spawn only sidecar tasks that can run in parallel.
4. Give each worker disjoint ownership.
5. Continue meaningful local work while subagents run.
6. Integrate results and resolve conflicts.
7. Run verification.
8. Produce the final user-facing summary.

## Spawn Prompt Template

```text
You are acting as the codex-tech-squad <specialist> specialist.
Use the role contract from plugins/codex-tech-squad/agents/<specialist>.md.

Mission:
<bounded task>

Scope:
<owned files/modules or read-only area>

Coordination:
- You are not alone in the codebase.
- Do not revert edits made by others.
- If you edit files, list every changed path in your final answer.
- If this is read-only, do not edit files.

Expected output:
<specific artifact needed by the orchestrator>
```

## Team Sizing

Default to 2-4 subagents. Use more only when workstreams are independent and
the extra result will materially improve speed or risk control.

## Common Team Shapes

Discovery:

- `explorer` as `architect`
- `explorer` as `qa-engineer`
- optional `default` as `product-planner`

Implementation:

- `explorer` as `tech-lead`
- one or more `worker` implementation slices
- optional `worker` as `qa-engineer`
- optional `default` as `reviewer`

Bug fix:

- `explorer` as `tech-lead`
- `worker` as implementation specialist
- `worker` or `default` as `qa-engineer`

PR review:

- `default` as `reviewer`
- optional `explorer` reviewers for security, performance, accessibility, API,
  privacy, or database concerns

## Coordination Rules

- Do not delegate the next blocking step if the main agent needs it now.
- Do not duplicate delegated work locally.
- Wait for subagents only when their result is needed.
- Review and integrate every returned patch before final verification.
- If a subagent edits files outside its scope, inspect carefully before using.
