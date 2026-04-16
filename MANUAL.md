# Codex Tech Squad Manual

## Purpose

Codex Tech Squad is a Codex plugin that teaches Codex how to assemble a small,
task-specific software delivery team. It is designed for coding work where
parallel investigation, implementation, testing, review, or release planning
can improve quality or speed.

## Key Concepts

### Main Codex Agent

The main Codex agent is always the orchestrator. It owns:

- user communication
- critical-path planning
- deciding when subagents are useful
- integrating outputs
- resolving conflicts
- final verification
- final response

### Native Subagent Roles

Codex subagents use native roles:

- `explorer`: read-only codebase questions and analysis
- `worker`: concrete implementation or artifact changes
- `default`: synthesis, review, or mixed non-editing analysis

### Specialists

Specialists are prompt contracts in `plugins/codex-tech-squad/agents`.

They do not become new Codex `agent_type` values. A `backend-engineer`
specialist usually runs as a `worker`; an `architect` usually runs as an
`explorer`; a `reviewer` usually runs as `default`.

## When Teams Are Used

Codex should spawn subagents only when the user explicitly asks for:

- squad
- team
- subagents
- parallel agents
- delegation
- one of this plugin's team workflows

Examples:

```text
Use codex-tech-squad:squad for this feature.
```

```text
Use codex-tech-squad:bug-fix with a small team.
```

Without explicit team language, Codex should run locally and use this plugin's
skills as checklists.

## Recommended Workflow

1. User invokes a skill.
2. Codex loads the matching `SKILL.md`.
3. Codex reads only the references and specialist files needed for the task.
4. Codex inspects enough repo context to avoid blind delegation.
5. Codex forms a small team, usually 2-4 subagents.
6. Workers receive disjoint ownership.
7. Main Codex agent keeps working locally while subagents run.
8. Main Codex agent integrates results.
9. Verification runs.
10. Codex reports concise outcome, changed files, checks, and remaining risks.

## Example Team

For a Django backend bug:

- Main Codex agent: reproduce, integrate, verify
- `explorer` as `tech-lead`: root cause and affected files
- `worker` as `backend-engineer`: minimal patch
- `worker` as `qa-engineer`: focused regression test
- `default` as `reviewer`: final diff review

## Safety

The safety contract is in
`plugins/codex-tech-squad/references/safety-contract.md`. It applies to every
skill and every spawned agent.
