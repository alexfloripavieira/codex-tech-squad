#!/usr/bin/env python3
"""Validate the codex-tech-squad package layout."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


REQUIRED_TOP_LEVEL = [
    "README.md",
    "MANUAL.md",
    "CHANGELOG.md",
    "VERSION",
    "LICENSE",
    ".agents/plugins/marketplace.json",
    "plugins/codex-tech-squad/.codex-plugin/plugin.json",
]

REQUIRED_PLUGIN_DIRS = [
    "agents",
    "references",
    "scripts",
    "skills",
]

FRONTMATTER_RE = re.compile(r"^---\n(.*?)\n---\n", re.DOTALL)


def fail(message: str) -> None:
    print(f"ERROR: {message}", file=sys.stderr)
    raise SystemExit(1)


def read_json(path: Path) -> dict:
    try:
        with path.open("r", encoding="utf-8") as handle:
            return json.load(handle)
    except Exception as exc:  # noqa: BLE001 - validation script should report all parse errors plainly
        fail(f"invalid JSON in {path}: {exc}")


def validate_skill(path: Path) -> None:
    content = path.read_text(encoding="utf-8")
    match = FRONTMATTER_RE.match(content)
    if not match:
        fail(f"missing YAML frontmatter in {path}")
    frontmatter = match.group(1)
    if not re.search(r"^name:\s*\S+", frontmatter, re.MULTILINE):
        fail(f"missing name in {path}")
    if not re.search(r"^description:\s*.+", frontmatter, re.MULTILINE):
        fail(f"missing description in {path}")
    if len(content.splitlines()) > 220:
        print(f"WARNING: {path} is long; consider moving details to references/")


def main() -> int:
    root = Path(sys.argv[1]).resolve() if len(sys.argv) > 1 else Path.cwd()
    plugin_root = root / "plugins" / "codex-tech-squad"

    for rel in REQUIRED_TOP_LEVEL:
        path = root / rel
        if not path.exists():
            fail(f"missing required file: {rel}")

    manifest = read_json(root / "plugins/codex-tech-squad/.codex-plugin/plugin.json")
    if manifest.get("name") != "codex-tech-squad":
        fail("plugin manifest name must be codex-tech-squad")
    if manifest.get("skills") != "./skills/":
        fail("plugin manifest skills must be ./skills/")

    marketplace = read_json(root / ".agents/plugins/marketplace.json")
    plugins = marketplace.get("plugins") or []
    if not any(item.get("name") == "codex-tech-squad" for item in plugins):
        fail("marketplace must include codex-tech-squad")

    for dirname in REQUIRED_PLUGIN_DIRS:
        path = plugin_root / dirname
        if not path.is_dir():
            fail(f"missing plugin directory: {path}")

    skill_files = sorted((plugin_root / "skills").glob("*/SKILL.md"))
    if not skill_files:
        fail("no skills found")
    for skill in skill_files:
        validate_skill(skill)

    agents = sorted((plugin_root / "agents").glob("*.md"))
    if len(agents) < 8:
        fail("expected at least 8 specialist agent prompt files")

    references = sorted((plugin_root / "references").glob("*.md"))
    if len(references) < 3:
        fail("expected at least 3 reference files")

    version = (root / "VERSION").read_text(encoding="utf-8").strip()
    if manifest.get("version") != version:
        fail(f"manifest version {manifest.get('version')} does not match VERSION {version}")

    print(f"OK: codex-tech-squad {version}")
    print(f"OK: {len(skill_files)} skills, {len(agents)} agents, {len(references)} references")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
