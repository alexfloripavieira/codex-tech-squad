# Versioning

This project uses semantic versioning:

```text
MAJOR.MINOR.PATCH
```

## Patch

Use for:

- wording fixes
- prompt clarifications
- documentation corrections
- validation script bug fixes

## Minor

Use for:

- new skills
- new specialist roles
- new scripts
- backward-compatible workflow changes

## Major

Use for:

- breaking skill semantics
- renamed skills
- changed install layout
- incompatible plugin manifest changes

## Release Steps

1. Update `VERSION`.
2. Update `plugins/codex-tech-squad/.codex-plugin/plugin.json`.
3. Update `CHANGELOG.md`.
4. Run:

```bash
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
```

5. Commit and tag:

```bash
git commit -m "chore: release vX.Y.Z"
git tag -a vX.Y.Z -m "codex-tech-squad vX.Y.Z"
```

6. Push the branch and tag:

```bash
git push origin main
git push origin vX.Y.Z
```

The release pipeline validates that the tag matches `VERSION`, checks the
changelog entry, builds the release package, and uploads it to GitHub Releases.
