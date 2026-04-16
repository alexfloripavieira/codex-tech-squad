# Architecture

## Plugin Shape

```text
plugins/codex-tech-squad/
  .codex-plugin/plugin.json
  skills/
  agents/
  references/
  scripts/
```

## Responsibilities

- `skills/`: trigger metadata and workflow steps
- `agents/`: specialist prompt contracts
- `references/`: shared policies, role maps, orchestration rules
- `scripts/`: deterministic install and validation helpers

## Runtime Model

Codex loads skill metadata into the session. When a user request matches a
skill description, Codex loads that skill body. The skill then tells Codex
which references or specialist prompts to read.

When the user explicitly asks for a team, the main Codex agent can spawn native
subagents:

- `explorer`
- `worker`
- `default`

Specialists are assigned as prompt roles, not native agent types.

## Design Constraint

The plugin must not assume Claude Code primitives. It should remain portable
across Codex sessions by relying on Codex skills and native subagents only.
