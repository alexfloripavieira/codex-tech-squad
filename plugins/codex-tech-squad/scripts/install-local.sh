#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${PLUGIN_DIR}/../.." && pwd)"

HOME_PLUGINS_DIR="${HOME}/plugins"
HOME_PLUGIN_LINK="${HOME_PLUGINS_DIR}/codex-tech-squad"
HOME_MARKETPLACE_DIR="${HOME}/.agents/plugins"
HOME_MARKETPLACE_FILE="${HOME_MARKETPLACE_DIR}/marketplace.json"

mkdir -p "${HOME_PLUGINS_DIR}" "${HOME_MARKETPLACE_DIR}"

if [ -L "${HOME_PLUGIN_LINK}" ] || [ -e "${HOME_PLUGIN_LINK}" ]; then
  if [ "$(readlink "${HOME_PLUGIN_LINK}" 2>/dev/null || true)" != "${PLUGIN_DIR}" ]; then
    echo "ERROR: ${HOME_PLUGIN_LINK} already exists and does not point to ${PLUGIN_DIR}" >&2
    exit 1
  fi
else
  ln -s "${PLUGIN_DIR}" "${HOME_PLUGIN_LINK}"
fi

if [ -f "${HOME_MARKETPLACE_FILE}" ]; then
  cp "${HOME_MARKETPLACE_FILE}" "${HOME_MARKETPLACE_FILE}.bak.$(date +%Y%m%d%H%M%S)"
fi

python3 - "${HOME_MARKETPLACE_FILE}" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
if path.exists():
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise SystemExit(f"ERROR: invalid marketplace JSON at {path}: {exc}") from exc
else:
    data = {
        "name": "local",
        "interface": {"displayName": "Local Plugins"},
        "plugins": [],
    }

data.setdefault("name", "local")
data.setdefault("interface", {}).setdefault("displayName", "Local Plugins")
plugins = data.setdefault("plugins", [])

entry = {
    "name": "codex-tech-squad",
    "source": {
        "source": "local",
        "path": "./plugins/codex-tech-squad",
    },
    "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_USE",
    },
    "category": "Coding",
}

for index, plugin in enumerate(plugins):
    if plugin.get("name") == "codex-tech-squad":
        plugins[index] = entry
        break
else:
    plugins.append(entry)

path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
PY

python3 "${PLUGIN_DIR}/scripts/validate-plugin.py" "${REPO_ROOT}"

echo "Installed codex-tech-squad for home-local Codex use."
echo "Restart Codex to load the plugin."
