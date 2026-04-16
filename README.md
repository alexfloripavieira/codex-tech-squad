# codex-tech-squad

Codex-native plugin for assembling a bounded software delivery squad with
Codex subagents.

This project is inspired by squad-style Claude Code workflows, but it is not a
Claude plugin port. It uses Codex concepts directly:

- plugin manifest: `.codex-plugin/plugin.json`
- skills: `skills/*/SKILL.md`
- role prompts: `agents/*.md`
- shared references: `references/*.md`
- deterministic helpers: `scripts/*`

## What It Provides

- `codex-tech-squad:squad` for end-to-end delivery with a small team
- `codex-tech-squad:discovery` for discovery and blueprint work
- `codex-tech-squad:implement` for implementation from a known plan
- `codex-tech-squad:bug-fix` for focused bug resolution
- `codex-tech-squad:hotfix` for urgent minimal fixes
- `codex-tech-squad:pr-review` for specialist PR review
- `codex-tech-squad:security-audit` for targeted security assessment
- `codex-tech-squad:refactor` for controlled refactoring
- `codex-tech-squad:release` for release preparation

## How Teams Work In Codex

Codex does not register custom native agent types such as `django-backend` or
`qa-tester`. A skill can instruct the main Codex agent to spawn native Codex
subagents:

- `explorer` for read-only codebase investigation
- `worker` for bounded implementation, tests, docs, or scripts
- `default` for synthesis, review, and mixed analysis

Specialists live in `plugins/codex-tech-squad/agents/*.md`. They are prompt
roles assigned to one of the native Codex subagent types.

## Install

Fast install on any machine:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash
```

Install a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash -s -- --version v0.1.0
```

Auditable install:

```bash
curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh -o install.sh
less install.sh
bash install.sh
```

For repo-local development:

```bash
cd /home/alex/codex-tech-squad
codex
```

For home-local use in any project:

```bash
./plugins/codex-tech-squad/scripts/install-local.sh
```

Then restart Codex so plugin and skill metadata are reloaded.

See `docs/INSTALLATION.md` for the full installation manual, including
verification, update, uninstall, and troubleshooting steps.

## Example Prompts

```text
Use codex-tech-squad:squad to form the necessary Codex team and implement this feature with tests.
```

```text
Use codex-tech-squad:bug-fix with subagents to investigate, patch, test, and verify this bug.
```

```text
Use codex-tech-squad:pr-review to review PR 123 with relevant specialist reviewers.
```

## Repository Layout

```text
.agents/plugins/marketplace.json
plugins/codex-tech-squad/
  .codex-plugin/plugin.json
  agents/
  references/
  scripts/
  skills/
docs/
```

## Validation

```bash
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
```

## CI, Release, And Changelog

The repository includes GitHub Actions workflows:

- `.github/workflows/ci.yml` validates plugin structure, skills, changelog, and release packaging on PRs and pushes to `main`.
- `.github/workflows/release.yml` builds and uploads a `.tar.gz` package when a `v*` tag is pushed.

Release artifacts are produced with:

```bash
./plugins/codex-tech-squad/scripts/package-release.sh
```

See `docs/RELEASING.md` for the release manual.

## Versioning

This project uses semantic versioning. See `docs/VERSIONING.md` and
`CHANGELOG.md`.
