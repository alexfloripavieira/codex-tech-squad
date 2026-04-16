# Installation Manual

This guide installs `codex-tech-squad`, a Codex-native plugin that adds squad
workflows and specialist prompt roles for Codex subagents.

## Requirements

- Codex installed and working locally.
- Python 3.10 or newer.
- Git.
- A shell compatible with `bash`.

No package manager install is required. The plugin is plain files:

```text
plugins/codex-tech-squad/
  .codex-plugin/plugin.json
  skills/
  agents/
  references/
  scripts/
```

## Install Modes

There are two supported modes:

- Repo-local: use the plugin only while Codex is running from this repository.
- Home-local: make the plugin available from any project on the machine.

Use home-local for daily work.

## Option 1: Repo-Local Installation

Use this mode while developing or testing the plugin.

```bash
cd /home/alex/codex-tech-squad
codex
```

The repository includes a local marketplace file:

```text
.agents/plugins/marketplace.json
```

That marketplace points to:

```text
./plugins/codex-tech-squad
```

Restart Codex after plugin changes so skill metadata is reloaded.

## Option 2: Home-Local Installation

Use this mode to make the plugin available from any project, for example
`/home/alex/a1`.

From the repository root:

```bash
cd /home/alex/codex-tech-squad
./plugins/codex-tech-squad/scripts/install-local.sh
```

The installer:

1. Creates `~/plugins` if missing.
2. Creates a symlink:

```text
~/plugins/codex-tech-squad -> /home/alex/codex-tech-squad/plugins/codex-tech-squad
```

3. Creates or updates:

```text
~/.agents/plugins/marketplace.json
```

4. Preserves existing marketplace entries.
5. Writes a timestamped backup before changing an existing marketplace file.
6. Runs plugin validation.

After installation, restart Codex.

## Verify The Install

Run the validator:

```bash
cd /home/alex/codex-tech-squad
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
```

Expected output:

```text
OK: codex-tech-squad 0.1.0
OK: 9 skills, 16 agents, 4 references
```

List plugin skills:

```bash
./plugins/codex-tech-squad/scripts/list-skills.sh
```

Then start Codex in another project:

```bash
cd /home/alex/a1
codex
```

Ask Codex:

```text
What codex-tech-squad skills are available?
```

Or invoke a workflow:

```text
Use codex-tech-squad:squad to form the necessary Codex team for this task.
```

## First Smoke Test

Use a read-only workflow first:

```text
Use codex-tech-squad:discovery to map this repository. Use subagents only if useful.
```

Confirm that Codex:

- loads the `codex-tech-squad:discovery` skill
- uses `explorer`, `worker`, or `default` only when subagents are authorized
- does not try to use Claude Code primitives such as `TeamCreate`
- treats specialists as prompt roles, not native `agent_type` values

## Usage Examples

Full delivery:

```text
Use codex-tech-squad:squad to form the necessary Codex team and implement this feature with tests.
```

Bug fix:

```text
Use codex-tech-squad:bug-fix with a small team to investigate, patch, test, and verify this bug.
```

PR review:

```text
Use codex-tech-squad:pr-review to review PR 123 with relevant specialist reviewers.
```

Security audit:

```text
Use codex-tech-squad:security-audit to review the authentication changes.
```

## Update

Pull the latest repository changes:

```bash
cd /home/alex/codex-tech-squad
git pull
```

Run the installer again:

```bash
./plugins/codex-tech-squad/scripts/install-local.sh
```

Restart Codex.

## Uninstall

Remove the symlink:

```bash
rm ~/plugins/codex-tech-squad
```

Then remove the `codex-tech-squad` entry from:

```text
~/.agents/plugins/marketplace.json
```

Restart Codex.

If needed, restore a backup created by the installer:

```bash
ls ~/.agents/plugins/marketplace.json.bak.*
cp ~/.agents/plugins/marketplace.json.bak.YYYYMMDDHHMMSS ~/.agents/plugins/marketplace.json
```

## Troubleshooting

### The skill does not appear

Check:

- Codex was restarted after installation.
- `~/.agents/plugins/marketplace.json` contains `codex-tech-squad`.
- `~/plugins/codex-tech-squad` points to this repository's plugin directory.
- The plugin validates successfully.

### The installer says the symlink already exists

The installer refuses to overwrite a different file or symlink at:

```text
~/plugins/codex-tech-squad
```

Inspect it:

```bash
ls -la ~/plugins/codex-tech-squad
readlink ~/plugins/codex-tech-squad
```

Remove or rename it only if you are sure it is not needed.

### Marketplace JSON is invalid

The installer stops if `~/.agents/plugins/marketplace.json` is invalid JSON.
Fix the JSON or restore a previous backup, then rerun the installer.

### Codex tries to use Claude Code commands

This plugin is Codex-native. It should not use `TeamCreate`, `SendMessage`, or
custom Claude Code `subagent_type` names. If that happens, inspect the active
skill and make sure it references:

```text
plugins/codex-tech-squad/references/agent-orchestration.md
```

## Publish Checklist

Before publishing a release:

```bash
cd /home/alex/codex-tech-squad
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
./plugins/codex-tech-squad/scripts/package-release.sh
git status --short
git tag --list 'v*'
```

The repository should be clean and the tag should match `VERSION`.
