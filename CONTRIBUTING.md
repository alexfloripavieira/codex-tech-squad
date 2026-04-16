# Contributing

## Principles

- Keep Codex runtime semantics native.
- Do not add Claude Code-only primitives such as `TeamCreate`, custom
  `subagent_type` names, `SendMessage`, or tmux pane assumptions.
- Keep skills concise. Put reusable details in `references/`.
- Keep specialists in `agents/`.
- Use scripts for deterministic checks.

## Development Loop

1. Edit plugin files.
2. Run validation:

```bash
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
```

3. Restart Codex to load changed skill metadata.
4. Test with a small prompt before broad workflows.

## Release Checklist

1. Update `VERSION`.
2. Update `plugins/codex-tech-squad/.codex-plugin/plugin.json`.
3. Update `CHANGELOG.md`.
4. Run validation.
5. Commit with a versioned message.
6. Tag the release.
