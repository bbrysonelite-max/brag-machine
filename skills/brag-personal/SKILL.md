---
name: brag-personal
description: Personal message videos - THE MACHINE personalized for one recipient with Brent's voice carrying his exact words. Use when Brent says "make one for <name>", "send a personal video", "do one like Chrissy's/Becca's", or gives a quoted message for a specific person. HIGH-VALUE lane (Brent - "a million uses"). NEVER queued to social - gift files only.
---

# brag-personal — one person, Brent's words, his voice

Proven prototypes: Becca (positive-post style) · Chrissy (personalized THE MACHINE). Fast path: clone a proven composition, personalize, voice, mix.

## Brent's order format (parse exactly)

1. **WHO** — recipient name and relationship. **NAME-SPELLING LAW (Brent, 2026-07-23): never render a name without confirming the exact spelling first** — dictation mangles names (Mac/Mack, Chrissy). One quick question before the build: "spell the name for me?" Applies to on-screen text; the voice only says the spoken form.
2. **QUOTED MESSAGE** — text in quotes is spoken VERBATIM. Nothing outside quotes is ever voiced. If unclear what's quote vs context, ask ONE question before generating.
3. **SIGNATURE** — on-screen ONLY (e.g. "— Uncle Brent"). The voice NEVER reads the signature (law, 2026-07-23: "that was meant to be a signature").
4. Optional **VALUE BEAT** — a quick tip/thought to include as its own scene.

## Build lane

1. Clone base: `The Brag-Machine/brag-output-*/composition` (THE MACHINE reveal, personalized like Chrissy's) or a `positive-post` render (gentle, like Becca's). Personalize: name in hook, `$ ./claw "for <Name>"` terminal line, message lines as cards, on-screen signature, closing wink line.
2. `npx hyperframes check` → render silent.mp4 (free).
3. VO via Voicebox profile 18836009-0527-4b9f-9837-3d58c2a0dc76 (see brag-voice skill): one intro line + the quoted message, CONTINUOUS sentences, no ellipses, no signature. Delay ~1500ms; timing law applies.
4. Mix: ffmpeg duck-mix (music 0.35, vo 1.5, `-movflags +faststart`).
5. **Verify playable** (ffprobe duration) BEFORE delivering. Fresh unique filename every version (`for-<name>-FINAL.mp4`) — NEVER overwrite a file QuickTime may have open.
6. Deliver to Desktop + `open`. Brent's ears approve; voice-drift = regenerate.

## Laws

- NEVER queue personal videos to any channel. They are gifts Brent sends himself.
- Voice reads only quoted words + intro. Signature on screen only.
- Iterate free: text swaps + re-render cost nothing; only his words are sacred.
