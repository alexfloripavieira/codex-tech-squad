#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${PLUGIN_DIR}/../.." && pwd)"
VERSION="$(cat "${REPO_ROOT}/VERSION")"
TAG="v${VERSION}"
DIST_DIR="${REPO_ROOT}/dist"
PACKAGE_NAME="codex-tech-squad-${TAG}"
PACKAGE_PATH="${DIST_DIR}/${PACKAGE_NAME}.tar.gz"
CHECKSUM_PATH="${DIST_DIR}/${PACKAGE_NAME}.sha256"
NOTES_PATH="${DIST_DIR}/release-notes.md"

rm -rf "${DIST_DIR}"
mkdir -p "${DIST_DIR}"

python3 "${PLUGIN_DIR}/scripts/validate-plugin.py" "${REPO_ROOT}"

tar \
  --exclude=".git" \
  --exclude="dist" \
  --exclude=".squad-state" \
  -czf "${PACKAGE_PATH}" \
  -C "$(dirname "${REPO_ROOT}")" \
  "$(basename "${REPO_ROOT}")"

(
  cd "${DIST_DIR}"
  sha256sum "$(basename "${PACKAGE_PATH}")" > "$(basename "${CHECKSUM_PATH}")"
)

cat > "${NOTES_PATH}" <<EOF
# codex-tech-squad ${TAG}

Codex-native plugin for assembling bounded software delivery squads with Codex subagents.

## Install

\`\`\`bash
git clone <repo-url> codex-tech-squad
cd codex-tech-squad
./plugins/codex-tech-squad/scripts/install-local.sh
\`\`\`

Restart Codex after installation.

## Validate

\`\`\`bash
python3 plugins/codex-tech-squad/scripts/validate-plugin.py .
\`\`\`

See \`CHANGELOG.md\` for details.
EOF

echo "Built ${PACKAGE_PATH}"
echo "Wrote ${CHECKSUM_PATH}"
