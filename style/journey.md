# The Journey Style (doc-series)

Documentary snippets from Brent's four builds of Tiger. True story, dated receipts, no gloss. The feel: late-night workshop, one lamp on.

## Brand

| Element | Value |
|---|---|
| Background | `#0B0A08` near-black with a faint warm vignette, like a desk lamp off-frame |
| Text | `#F2EADD` primary · `#B7A992` secondary |
| Accent | ember `#FF6B1A → #E2510A` — used ONLY on the date stamp and one key phrase |
| Date stamps | every episode opens with a monospace date chip (e.g. `APR 6, 2026`) — letterspaced, ember underline. Monospace font-family MUST be exactly `Menlo, monospace` (renderer maps Menlo to bundled JetBrains Mono; other mono names fail the check gate) |
| Font | Inter 900 for quotes, 400 for narration lines; quotes are BIG (fill 65%+ frame width) |
| Receipts | quotes rendered as typed/terminal-style cards when they came from session logs; keep file-name captions small and real (e.g. `wispr_flow/2026-04-06.md`) |
| No logo until the outro | the story is the brand |

## Creative Laws

1. **15–25 seconds.** One moment per episode. One date, one quote, one turn of the knife.
2. **Hook = the rawest fragment of the quote in the first 2s**, alone on black. ("I threw the code away.")
3. **Pattern:** date chip → the moment builds (quote assembles line by line) → HOLD → one narration line of context → episode tag + series mark.
4. **Verbatim only.** Quotes are Brent's real words from the vault — never paraphrase, never soften the profanity (bleep-style ▓ redaction on screen is allowed and reads honest).
5. **The failure is told with respect, not pity.** No sad-violin cliches. The tone is a builder reading his own logbook.
6. **Honesty rail:** v4 is winning, not won. Never claim finished victory. The series tagline may appear in outros: "The journey is alive."
7. **No company names** from Brent's past industry on screen or in captions.
8. **Readable above all:** long holds on every quote; this audience reads.
9. **Beat-sync:** date chip lands on a strong cue; the key phrase's ember accent lands on a beat.
10. **Episode tag:** small "THE JOURNEY · EP {N}" lockup at the end + brentbryson.ai end-card.
11. **Render-safety:** after every exit fade that ends on a clip boundary, add a matching `tl.set(target, { autoAlpha: 0 }, boundaryTime)` hard kill — the check gate blocks the video without it.

## Voice

Logbook voice. Short declarative narration ("Build two. An AI split the code in half. Both halves died."). Zero hype. The scars carry it.

## Formats

- vertical 1080×1920 default · landscape for YouTube compilations

## Audio

**Series theme (locked by Brent 2026-07-23): `assets/music/journey-theme.mp3`** — gritty blues-rock stomp, 51s. This IS the Journey's sonic brand; never substitute the happy-beats stock track in this style.
Play it at 0.35 baseline and let it swell under the final card (to 0.5). Fade in 1.0s, fade out 2s. Lock the date chip and the ember accent phrase to the stomp's downbeats. SFX: a single soft keyboard/typewriter tick under quote assembly, sparingly.
