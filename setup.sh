#!/bin/bash
# One-time setup + smoke test. Run from the machine folder: ./setup.sh
set -euo pipefail
M="$(cd "$(dirname "$0")" && pwd)"

echo "== 1/5 Checking prerequisites"
command -v node >/dev/null || { echo "LOUD FAIL: Node.js missing (need 22+): brew install node"; exit 1; }
NODEV=$(node -e "console.log(process.versions.node.split('.')[0])")
[ "$NODEV" -ge 22 ] || { echo "LOUD FAIL: Node $NODEV too old, need 22+"; exit 1; }
command -v ffmpeg >/dev/null || { echo "LOUD FAIL: ffmpeg missing: brew install ffmpeg"; exit 1; }
command -v jq >/dev/null || { echo "LOUD FAIL: jq missing: brew install jq"; exit 1; }
command -v claude >/dev/null || echo "WARN: claude CLI not found — the brain won't run (template mode still works)"

echo "== 2/5 Installing Hyperframes"
npm list -g hyperframes >/dev/null 2>&1 || npm install -g hyperframes
npx hyperframes browser ensure
# Give the brain the full composition manual (installs Hyperframes agent skills)
npx hyperframes skills || echo "WARN: skills install failed — brain runs on the condensed rules in brain/compose-prompt.md"

echo "== 3/5 Doctor"
npx hyperframes doctor || true

echo "== 4/5 Config"
[ -f "$M/machine.env" ] || { cp "$M/machine.env.example" "$M/machine.env"; echo "Created machine.env — fill in account IDs (run: adapters/blotato.sh accounts)"; }
chmod +x "$M/claw" "$M/adapters/"*.sh

echo "== 5/5 Smoke test (template render, draft quality, no posting)"
"$M/claw" --template tigerclaw-launch --dry --draft-quality
echo ""
echo "MACHINE READY. Try: ./claw \"hook: silence kills more deals than no ever did\" --format vertical --dry"
