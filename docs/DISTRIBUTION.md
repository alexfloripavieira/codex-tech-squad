# Distribution

## Package Contents

Distribute the whole repository or at least:

```text
plugins/codex-tech-squad/
.agents/plugins/marketplace.json
README.md
MANUAL.md
CHANGELOG.md
VERSION
LICENSE
docs/
```

## Git Distribution

Users can clone the repository and either run Codex from the repo root or run
the home-local installer:

```bash
git clone <repo-url> codex-tech-squad
cd codex-tech-squad
./plugins/codex-tech-squad/scripts/install-local.sh
```

Restart Codex after installation.

## One-Line Distribution

Recommended install for other developers:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash
```

Pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash -s -- --version v0.1.0
```

Auditable path:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh -o install.sh
less install.sh
bash install.sh
```

The installer clones or updates the repository in `~/.codex-tech-squad`, then
registers the plugin in the local Codex marketplace.

## Release Artifacts

A release should include:

- repository tag
- changelog entry
- validated plugin manifest
- validation command output
- generated package `codex-tech-squad-vX.Y.Z.tar.gz`
- generated checksum `codex-tech-squad-vX.Y.Z.sha256`

Build locally with:

```bash
./plugins/codex-tech-squad/scripts/package-release.sh
```

On GitHub, pushing a `v*` tag runs `.github/workflows/release.yml` and uploads
the package plus checksum to the GitHub Release.

## Compatibility

This package targets Codex plugin and skill loading. It is not a Claude Code
plugin and intentionally does not include `.claude-plugin` metadata.
