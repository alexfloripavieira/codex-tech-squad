#!/usr/bin/env bash
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

find "${PLUGIN_DIR}/skills" -mindepth 2 -maxdepth 2 -name SKILL.md \
  | sort \
  | while read -r skill; do
      name="$(basename "$(dirname "${skill}")")"
      description="$(awk '/^description:/ {sub(/^description:[[:space:]]*/, ""); print; exit}' "${skill}")"
      printf '%s: %s\n' "${name}" "${description}"
    done
