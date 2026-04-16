#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.codex-tech-squad"
REMOVE_CHECKOUT=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Uninstall codex-tech-squad from local Codex plugin registration.

Usage:
  uninstall.sh [options]

Options:
  --dir <path>          Repository checkout path. Default: ~/.codex-tech-squad
  --remove-checkout     Also remove the repository checkout directory.
  --dry-run             Print actions without changing files.
  -h, --help            Show this help.
EOF
}

run() {
  if [ "${DRY_RUN}" = "1" ]; then
    printf '[dry-run] %q' "$1"
    shift || true
    for arg in "$@"; do
      printf ' %q' "${arg}"
    done
    printf '\n'
  else
    "$@"
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dir)
      INSTALL_DIR="${2:-}"
      if [ -z "${INSTALL_DIR}" ]; then
        echo "ERROR: --dir requires a value" >&2
        exit 1
      fi
      shift 2
      ;;
    --remove-checkout)
      REMOVE_CHECKOUT=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

INSTALL_DIR="${INSTALL_DIR/#\~/${HOME}}"
PLUGIN_LINK="${HOME}/plugins/codex-tech-squad"
MARKETPLACE_FILE="${HOME}/.agents/plugins/marketplace.json"

if [ -L "${PLUGIN_LINK}" ] || [ -e "${PLUGIN_LINK}" ]; then
  run rm "${PLUGIN_LINK}"
fi

if [ -f "${MARKETPLACE_FILE}" ]; then
  if [ "${DRY_RUN}" = "1" ]; then
    echo "[dry-run] remove codex-tech-squad from ${MARKETPLACE_FILE}"
  else
    cp "${MARKETPLACE_FILE}" "${MARKETPLACE_FILE}.bak.$(date +%Y%m%d%H%M%S)"
    python3 - "${MARKETPLACE_FILE}" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
data = json.loads(path.read_text(encoding="utf-8"))
plugins = data.get("plugins", [])
data["plugins"] = [plugin for plugin in plugins if plugin.get("name") != "codex-tech-squad"]
path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")
PY
  fi
fi

if [ "${REMOVE_CHECKOUT}" = "1" ] && [ -d "${INSTALL_DIR}" ]; then
  run rm -rf "${INSTALL_DIR}"
fi

echo "codex-tech-squad uninstalled. Restart Codex."
