#!/usr/bin/env bash
set -euo pipefail

DEFAULT_REPO="https://github.com/alexfloripavieira/codex-tech-squad.git"
DEFAULT_DIR="${HOME}/.codex-tech-squad"

REPO="${DEFAULT_REPO}"
INSTALL_DIR="${DEFAULT_DIR}"
VERSION=""
DRY_RUN=0

usage() {
  cat <<'EOF'
Install codex-tech-squad for local Codex use.

Usage:
  install.sh [options]

Options:
  --version <tag>   Checkout a specific version tag, for example v0.1.0.
  --dir <path>      Install repository checkout at this path. Default: ~/.codex-tech-squad
  --repo <url>      Git repository URL. Default: https://github.com/alexfloripavieira/codex-tech-squad.git
  --dry-run         Print actions without changing files.
  -h, --help        Show this help.

Examples:
  curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash
  curl -fsSL https://raw.githubusercontent.com/alexfloripavieira/codex-tech-squad/main/install.sh | bash -s -- --version v0.1.0
EOF
}

log() {
  printf '%s\n' "$*"
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

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "ERROR: required command not found: $1" >&2
    exit 1
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --version)
      VERSION="${2:-}"
      if [ -z "${VERSION}" ]; then
        echo "ERROR: --version requires a value" >&2
        exit 1
      fi
      shift 2
      ;;
    --dir)
      INSTALL_DIR="${2:-}"
      if [ -z "${INSTALL_DIR}" ]; then
        echo "ERROR: --dir requires a value" >&2
        exit 1
      fi
      shift 2
      ;;
    --repo)
      REPO="${2:-}"
      if [ -z "${REPO}" ]; then
        echo "ERROR: --repo requires a value" >&2
        exit 1
      fi
      shift 2
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

require_cmd git
require_cmd python3

INSTALL_DIR="${INSTALL_DIR/#\~/${HOME}}"

log "Installing codex-tech-squad"
log "Repository: ${REPO}"
log "Directory:  ${INSTALL_DIR}"
if [ -n "${VERSION}" ]; then
  log "Version:    ${VERSION}"
else
  log "Version:    latest main"
fi

if [ -e "${INSTALL_DIR}" ] && [ ! -d "${INSTALL_DIR}/.git" ]; then
  echo "ERROR: ${INSTALL_DIR} exists but is not a git checkout" >&2
  exit 1
fi

if [ ! -d "${INSTALL_DIR}/.git" ]; then
  run git clone "${REPO}" "${INSTALL_DIR}"
else
  run git -C "${INSTALL_DIR}" remote set-url origin "${REPO}"
  run git -C "${INSTALL_DIR}" fetch --tags origin
fi

if [ -n "${VERSION}" ]; then
  run git -C "${INSTALL_DIR}" checkout "${VERSION}"
else
  run git -C "${INSTALL_DIR}" checkout main
  run git -C "${INSTALL_DIR}" pull --ff-only origin main
fi

run bash "${INSTALL_DIR}/plugins/codex-tech-squad/scripts/install-local.sh"

log ""
log "codex-tech-squad installed."
log "Restart Codex to load the plugin."
log ""
log "Smoke test prompt:"
log "Use codex-tech-squad:discovery to map this repository. Use subagents only if useful."
