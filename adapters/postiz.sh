#!/bin/bash
# Postiz queue adapter (self-hosted or cloud) — true draft support.
# Usage: postiz.sh <video> <caption-file> <channels-csv> <at-iso> <draft|live>
# Requires: npm i -g postiz ; POSTIZ_API_KEY (+ POSTIZ_API_URL for self-host) in machine.env
set -euo pipefail
M="$(cd "$(dirname "$0")/.." && pwd)"
[ -f "$M/machine.env" ] && . "$M/machine.env"
export POSTIZ_API_KEY="${POSTIZ_API_KEY:?LOUD FAIL: POSTIZ_API_KEY not set in machine.env}"
[ -n "${POSTIZ_API_URL:-}" ] && export POSTIZ_API_URL

VIDEO="${1:?video path}"; CAPTION_FILE="${2:?caption file}"; CHANNELS="${3:?channels csv}"
AT="${4:-}"; MODE="${5:-draft}"
CAPTION=$(cat "$CAPTION_FILE")
[ -n "$AT" ] || AT=$(date -u -v+6H +%FT%TZ 2>/dev/null || date -u -d '+6 hours' +%FT%TZ)

# Upload video
UP=$(postiz upload "$VIDEO") || { echo "LOUD FAIL: postiz upload failed"; exit 1; }
MEDIA=$(echo "$UP" | jq -r '.path')
[ "$MEDIA" != "null" ] || { echo "LOUD FAIL: no media path: $UP"; exit 1; }

# Map channel names -> integration ids
IDS=""
ALL=$(postiz integrations:list)
IFS=',' read -ra CHS <<< "$CHANNELS"
for CH in "${CHS[@]}"; do
  case "$CH" in x) IDENT=twitter;; ig|instagram) IDENT=instagram;; *) IDENT="$CH";; esac
  ID=$(echo "$ALL" | jq -r --arg p "$IDENT" '[.[] | select(.identifier==$p)][0].id')
  [ "$ID" != "null" ] || { echo "LOUD FAIL: no connected Postiz channel '$CH'"; exit 1; }
  IDS="$IDS,$ID"
done
IDS="${IDS#,}"

if [ "$MODE" = "live" ]; then
  postiz posts:create -c "$CAPTION" -m "$MEDIA" -s "$AT" -i "$IDS"
else
  postiz posts:create -c "$CAPTION" -m "$MEDIA" -s "$AT" -t draft -i "$IDS"
  echo "== DRAFT queued for $AT — approve in the Postiz calendar"
fi
