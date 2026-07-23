#!/bin/bash
# gate-autofix — deterministic repairs for known check-gate failures. No AI, no cost.
# Fixes: (1) gsap_exit_missing_hard_kill — check prints the exact tl.set line; inject it.
#        (2) font_family_without_font_face on mono stacks — pin to Menlo, monospace.
# Anything else stays a LOUD FAIL for a human/brain to judge.
set -uo pipefail
C="${1:?composition dir}"
F="$C/index.html"
[ -f "$F" ] || { echo "autofix: no index.html"; exit 1; }

OUT=$(cd "$C" && npx hyperframes check 2>&1 || true)
CHANGED=0

# --- 1. missing hard kills: parse the check's own "Fix: Add `tl.set(...)`" lines
while IFS= read -r line; do
  FIXCODE=$(printf '%s' "$line" | sed -E 's/.*Add `(tl\.set\([^`]+\))`.*/\1/')
  case "$FIXCODE" in tl.set*) ;; *) continue;; esac
  grep -qF "$FIXCODE" "$F" && continue
  python3 - "$F" "$FIXCODE" <<'PYEOF'
import sys
p, fix = sys.argv[1], sys.argv[2]
s = open(p, encoding="utf-8").read()
anchor = 'window.__timelines["main"] = tl;'
if anchor in s and fix not in s:
    s = s.replace(anchor, "  " + fix + ";\n  " + anchor, 1)
    open(p, "w", encoding="utf-8").write(s)
PYEOF
  grep -qF "$FIXCODE" "$F" && { echo "autofix: injected $FIXCODE"; CHANGED=1; }
done < <(printf '%s\n' "$OUT" | grep 'Fix: Add `tl.set')

# --- 2. undeclared mono fonts: pin the stack to the renderer-mapped Menlo
if printf '%s' "$OUT" | grep -q 'font_family_without_font_face'; then
  if grep -qE 'ui-monospace|SFMono|sfmono|DejaVu Sans Mono' "$F"; then
    sed -i '' -E 's/font-family:[^;}]*(ui-monospace|SFMono-Regular|DejaVu Sans Mono)[^;}]*/font-family: Menlo, monospace/g' "$F"
    echo "autofix: pinned mono font stack to Menlo, monospace"
    CHANGED=1
  fi
fi

[ "$CHANGED" -eq 1 ] && exit 0 || { echo "autofix: nothing auto-fixable"; exit 1; }
