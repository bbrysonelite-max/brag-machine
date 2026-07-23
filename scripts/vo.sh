#!/bin/bash
# vo.sh — narrate a rendered video in Brent's voice via local Voicebox, mix under the film.
# Usage: vo.sh <run-dir> "<narration text>" [delay-ms] [--profile <id-or-Brent Bryson>]
# Free, local, unlimited. Voicebox must be running (open -a Voicebox; API on 127.0.0.1:17493).
set -euo pipefail
VB="http://127.0.0.1:17493"
RUN="${1:?run dir}"; TEXT="${2:?narration text}"; DELAY="${3:-1200}"
PROFILE="${5:-18836009-0527-4b9f-9837-3d58c2a0dc76}"  # "Brent Bryson" profile

[ -s "$RUN/out.mp4" ] || { echo "LOUD FAIL: no out.mp4 in $RUN"; exit 1; }
curl -s -m 5 "$VB/profiles" >/dev/null || { echo "LOUD FAIL: Voicebox API down — open -a Voicebox"; exit 1; }

echo "== VO: generating in Brent voice"
GID=$(curl -s -X POST "$VB/generate" -H "Content-Type: application/json" \
  -d "$(jq -n --arg t "$TEXT" --arg p "$PROFILE" '{text:$t, profile_id:$p, language:"en"}')" | jq -r '.id')
[ -n "$GID" ] && [ "$GID" != "null" ] || { echo "LOUD FAIL: generate request failed"; exit 1; }

# poll history (status endpoint is SSE)
for i in $(seq 1 120); do
  ST=$(curl -s -m 8 "$VB/history?limit=10" | jq -r ".[] | select(.id==\"$GID\") | .status")
  case "$ST" in
    completed) break;;
    failed|error) echo "LOUD FAIL: VO generation $ST"; exit 1;;
  esac
  sleep 5
done
[ "$ST" = "completed" ] || { echo "LOUD FAIL: VO timed out"; exit 1; }

curl -s "$VB/audio/$GID" -o "$RUN/vo.wav"
[ -s "$RUN/vo.wav" ] || { echo "LOUD FAIL: no audio bytes"; exit 1; }

echo "== VO: mixing under film (music ducked)"
ffmpeg -v error -y -i "$RUN/out.mp4" -i "$RUN/vo.wav" -filter_complex \
  "[1:a]adelay=${DELAY}|${DELAY},volume=1.5[vo];[0:a]volume=0.35[bg];[bg][vo]amix=inputs=2:duration=first:normalize=0[a]" \
  -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k "$RUN/out-vo.mp4"
echo "== VO DONE: $RUN/out-vo.mp4"
