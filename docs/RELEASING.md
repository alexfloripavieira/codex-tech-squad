# Releasing

This project publishes releases from Git tags.

## Pipelines

### CI

`.github/workflows/ci.yml` runs on pull requests and pushes to `main`.

It validates:

- plugin structure
- JSON manifests
- skill frontmatter
- version consistency
- changelog entry
- release package build

### Release

`.github/workflows/release.yml` runs on tags matching `v*`.

It validates:

- tag matches `VERSION`
- plugin layout
- changelog entry

Then it builds:

```text
dist/codex-tech-squad-vX.Y.Z.tar.gz
dist/codex-tech-squad-vX.Y.Z.sha256
```

and uploads both to a GitHub Release.

## Release Steps

1. Update `VERSION`.
2. Update `plugins/codex-tech-squad/.codex-plugin/plugin.json`.
3. Update `CHANGELOG.md`.
4. Validate locally:

```bash
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
./plugins/codex-tech-squad/scripts/package-release.sh
```

5. Commit:

```bash
git add .
git commit -m "chore: release vX.Y.Z"
```

6. Tag:

```bash
git tag -a vX.Y.Z -m "codex-tech-squad vX.Y.Z"
```

7. Push:

```bash
git push origin main
git push origin vX.Y.Z
```

The `release` workflow creates the GitHub Release artifact.

## Changelog

Every released version must have an entry:

```text
## [X.Y.Z] - YYYY-MM-DD
```

CI checks that `CHANGELOG.md` includes the current `VERSION`.
