#!/bin/bash
# Blotato queue adapter — upload video, create post per channel.
# Usage: blotato.sh <video> <caption-file> <channels-csv> <at-iso> <draft|live>
# Also:  blotato.sh accounts   -> list connected accounts (fill machine.env with IDs)
# NOTE: Blotato has no draft state. "draft" mode schedules for +6h (or --at)
#       and SHOUTS so you can delete it in the Blotato dashboard if unwanted.
set -euo pipefail
M="$(cd "$(dirname "$0")/.." && pwd)"
[ -f "$M/machine.env" ] && . "$M/machine.env"

API="https://backend.blotato.com/v2"
KEY_FILE="${BLOTATO_KEY_FILE:-$HOME/Desktop/GitSync/kloop.env}"
[ -f "$KEY_FILE" ] || { echo "LOUD FAIL: key file not found: $KEY_FILE"; exit 1; }
# Extract the key from the line mentioning blotato: take value after '=' or ':'
KEY=$(grep -i "blotato" "$KEY_FILE" | head -1 | sed -E 's/^[^=:]*[=:][[:space:]]*//' | tr -d '"' | tr -d "'" | tr -d '[:space:]')
[ -n "$KEY" ] || { echo "LOUD FAIL: no blotato key found in $KEY_FILE"; exit 1; }

if [ "${1:-}" = "accounts" ]; then
  curl -sf "$API/users/me/accounts" -H "blotato-api-key: $KEY" | (command -v jq >/dev/null && jq . || cat)
  exit 0
fi

VIDEO="${1:?video path}"; CAPTION_FILE="${2:?caption file}"; CHANNELS="${3:?channels csv}"
AT="${4:-}"; MODE="${5:-draft}"
CAPTION=$(cat "$CAPTION_FILE")

# --- upload via presigned URL ---
FNAME=$(basename "$VIDEO")
PRESIGN=$(curl -sf -X POST "$API/media/uploads" -H "blotato-api-key: $KEY" \
  -H "Content-Type: application/json" -d "{\"filename\":\"$FNAME\"}") \
  || { echo "LOUD FAIL: presign request failed"; exit 1; }
PUT_URL=$(echo "$PRESIGN" | jq -r '.presignedUrl')
PUB_URL=$(echo "$PRESIGN" | jq -r '.publicUrl')
[ "$PUT_URL" != "null" ] || { echo "LOUD FAIL: no presigned URL: $PRESIGN"; exit 1; }
curl -sf -X PUT "$PUT_URL" -H "Content-Type: video/mp4" --data-binary @"$VIDEO" \
  || { echo "LOUD FAIL: video PUT failed"; exit 1; }
echo "== uploaded: $PUB_URL"

# --- schedule time ---
if [ -z "$AT" ] && [ "$MODE" = "draft" ]; then
  AT=$(date -u -v+6H +%FT%TZ 2>/dev/null || date -u -d '+6 hours' +%FT%TZ)
  echo "== DRAFT MODE (Blotato has no drafts): scheduled +6h at $AT — delete in dashboard to cancel"
fi

# --- per-channel post ---
IFS=',' read -ra CHS <<< "$CHANNELS"
for CH in "${CHS[@]}"; do
  CH_UP=$(echo "$CH" | tr '[:lower:]' '[:upper:]' | tr -d ' ')
  ACC_VAR="BLOTATO_ACCOUNT_$CH_UP"
  ACC="${!ACC_VAR:-}"
  [ -n "$ACC" ] || { echo "LOUD FAIL: $ACC_VAR not set in machine.env (run: adapters/blotato.sh accounts)"; exit 1; }

  case "$CH" in
    x|twitter)  PLATFORM=twitter;  TARGET='{"targetType":"twitter"}';;
    instagram)  PLATFORM=instagram; TARGET='{"targetType":"instagram","mediaType":"reel"}';;
    tiktok)     PLATFORM=tiktok;   TARGET='{"targetType":"tiktok","privacyLevel":"PUBLIC_TO_EVERYONE","disabledComments":false,"disabledDuet":false,"disabledStitch":false,"isBrandedContent":false,"isYourBrand":false,"isAiGenerated":true}';;
    facebook)   PLATFORM=facebook; PAGE="${BLOTATO_FACEBOOK_PAGE_ID:-}"; TARGET="{\"targetType\":\"facebook\",\"pageId\":\"$PAGE\"}";;
    youtube)    PLATFORM=youtube;  TITLE=$(head -1 "$CAPTION_FILE" | cut -c1-95); TARGET=$(jq -n --arg t "$TITLE" '{targetType:"youtube",title:$t,privacyStatus:"public",shouldNotifySubscribers:true}');;
    linkedin)   PLATFORM=linkedin; TARGET='{"targetType":"linkedin"}';;
    *) echo "LOUD FAIL: unknown channel '$CH'"; exit 1;;
  esac

  BODY=$(jq -n --arg acc "$ACC" --arg text "$CAPTION" --arg url "$PUB_URL" \
    --arg platform "$PLATFORM" --argjson target "$TARGET" --arg at "$AT" '
    {post: {accountId: $acc, content: {text: $text, mediaUrls: [$url], platform: $platform}, target: $target}}
    + (if $at != "" then {scheduledTime: $at} else {} end)')

  RESP=$(curl -sf -X POST "$API/posts" -H "blotato-api-key: $KEY" \
    -H "Content-Type: application/json" -d "$BODY") \
    || { echo "LOUD FAIL: post to $CH failed"; exit 1; }
  echo "== queued $CH: $RESP"
done
