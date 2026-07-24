---
name: brag-voice
description: Brent's voice for any video or audio - local Voicebox clone (his ruling - "best generated voice I have ever had"). Use when adding narration/voiceover to a render, making a talking version of a video, generating Brent speech from text, or when Brent says "put my voice on it", "narrate it", "make it talk". Free, local, unlimited. HeyGen is for ON-CAMERA avatars only (separate YouTube system); this skill is voice-only.
---

# brag-voice — Brent's voice, locally, free

**The voice:** Voicebox app (jamiepine/voicebox) on this Mac, API `http://127.0.0.1:17493`. Profile **"Brent Bryson"** `18836009-0527-4b9f-9837-3d58c2a0dc76` — cloned from his own footage, approved with chills.

## The one-command lane (narrate a render)

```bash
cd ~/Desktop/The\ Brag-Machine/machine
./scripts/vo.sh runs/<run-id> "<narration text>" [delay-ms]   # → runs/<run-id>/out-vo.mp4
```
Generates the speech in Brent's voice, ducks the music to 0.35, mixes, never re-renders video. Copy result to Desktop under a UNIQUE name and `open` for his review.

## Raw speech (no video)

```bash
curl -s -X POST http://127.0.0.1:17493/generate -H "Content-Type: application/json" \
  -d '{"text":"...","profile_id":"18836009-0527-4b9f-9837-3d58c2a0dc76","language":"en"}'   # returns {id}
# poll: curl -s "http://127.0.0.1:17493/history?limit=10" | jq '.items[] | select(.id=="<id>") | .status'
# fetch: curl -s "http://127.0.0.1:17493/audio/<id>" -o out.wav
```

## Gotchas (all hit and solved 2026-07-23 — do not rediscover)

- App must be running: `open -a Voicebox`; wait for API 200 on /profiles.
- `/history` wraps results in `.items[]`. `/generate/{id}/status` is an SSE stream — do NOT curl it with a timeout and parse as JSON; poll /history.
- Server is single-lane: wait for no `generating`/`loading_model` items before POSTing (vo.sh does this).
- "librosa stub" error = stale server bundle → quit + relaunch the app.
- New voice samples: max 30s audio + exact `reference_text` transcript (transcribe with `npx hyperframes transcribe`; its JSON is an ARRAY of {start,end,text}).
- First generation after app start loads Qwen 1.7B — slow on this Intel Mac; later ones are fine. Batch VO accordingly.
- Voicebox MCP is registered for the machine project (`claude mcp` → voicebox).

## Timing law (Brent, 2026-07-23 — Law #5 v1 was a "timing mess")

- **The voice lives inside the visual arc.** Narration must END at least 1.5s before the video ends (vo.sh now enforces this and prints the word budget on failure).
- **Word budget:** (video_seconds − delay_seconds − 1.5) × 2.3 words. A 22s video with a 2.5s start ≈ 40 words MAX — the law + one punch, never the whole caption.
- **Start late:** delay past the hook (2000–2500ms for coaching style), never 800ms.
- Voice v1 of anything gets Brent's ears before the format ships.

## Format rulings (Brent)

- **AGENT LAWS ship with his voice.** JOURNEY episodes stay text-films (style law) — narrated versions are a YouTube/compilation flavor, not the Shorts default.
- English VO = Voicebox. Thai-in-Brent's-voice = ElevenLabs multilingual (1.5M credits parked) if/when wanted — key must arrive via file in ~/Desktop/GitSync copy/, never chat.
- Personal/family videos never get queued anywhere, voiced or not.
