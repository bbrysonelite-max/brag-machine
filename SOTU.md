# SOTU — Brag Machine + Content System
*State of the Union. Read this first in any new session. Keep it current: update after every session that changes state. Last updated: 2026-07-23.*

## What this is

The Brag Machine (`claw`) turns a prompt into a branded, beat-synced, gate-checked video and queues it to social. It now powers a three-rotation content system: **THE JOURNEY** (doc series), **AGENT LAWS** (daily micro-tips), **TWO BRENTS YouTube** (weekly longform).

## Where everything lives

| Thing | Location |
|---|---|
| The machine (live copy) | `~/Desktop/The Brag-Machine/machine` — root-level `claw`/`composeprompt.md` in the parent folder are STRAY copies, never edit |
| Canonical repo | github.com/bbrysonelite-max/brag-machine (private) — push all machine changes |
| Show bible | `~/Desktop/THE-JOURNEY-SHOW-BIBLE.md` — episodes, quotes, honesty rails, operator corrections, receipts |
| Production queue | `~/Desktop/JOURNEY-PRODUCTION-QUEUE.md` — 32 batch-ready `./claw` briefs |
| 30-day posting plan | `~/Desktop/POSTING-PLAN-30-DAYS.md` — calendar, slots, cross-promo triangle |
| Research report | claude.ai artifact "Demand Report · AI & Direct Selling · July 2026" + raw files in `~/Documents/Last30Days/` |
| Secrets | `~/Desktop/GitSync copy/` — kloop.env, BRENT_CREDENTIALS.md, blotato.env. NEVER echo values; keys can contain `/` and `=` (extract with `cut -d= -f2-`, never alnum-only regex) |
| Vault (story source) | github bbrysonelite-max/vault-personal; richest seams: 03_The_Stream/Wispr_Flow + 04_The_Synthesizer/Atomic_Notes |

## Machine state (all working, verified 2026-07-23)

- `./claw` flags: `--style` (HOUSE-STYLE default · journey · coaching · motivational · business-promo · positive-post), `--stitch run1,run2` (free chaining, same-format guard), `--cta <url>` (end-card + caption link), `--format`, `--channels`, `--at`, `--dry`, `--template`, `--via`
- **Journey theme music locked** (Brent, 2026-07-23): `templates/tigerclaw-launch/composition/assets/music/journey-theme.mp3` (rock stomp). Journey style must use it; other styles keep happy-beats.
- Blotato wired, all 6 channels: X 12730 · IG 53674 · TikTok 52331 · FB 37125 (page 53954221244) · YT 27755 · LI 29900. Key: `~/Desktop/GitSync copy/blotato.env`. Drafts schedule +6h (no true drafts — delete in dashboard).
- YouTube title = caption first line. Node 22 pinned via machine.env PATH line.
- Gate lessons baked into journey style: mono font must be `Menlo, monospace`; every exit fade at a clip boundary needs a `tl.set(..., {autoAlpha:0}, boundary)` hard kill.
- **Thai pipeline proven**: copy composition → translate (use `.th` class: letter-spacing 0, line-height 1.35; `@font-face Thonburi src: local()`; typing effects reveal whole Thai syllable chunks, never per-char) → check → render. EP1 TH shipped.
- **Voiceover pipeline proven**: free local TTS via `npx hyperframes tts` (needs `HYPERFRAMES_PYTHON` pointing at a uv venv with kokoro-onnx + soundfile — rebuild in scratchpad if gone); mix under rendered mp4 with ffmpeg (VO delayed, music ducked to 0.35). Brent's ElevenLabs key PENDING — when it lands in GitSync copy, switch English VO to his clone (ElevenLabs multilingual can also do Thai in his voice).
- Music sourcing: media-use skill resolve.mjs, candidates in `machine/.media/audio/bgm/`, ledger kept by the skill.

## Posted so far (also see machine/ledger.jsonl — source of truth)

- 2026-07-22: brentbryson.ai promo → all 6 channels (drafts went live 07:40Z Jul 23)
- 2026-07-23: **THE JOURNEY EP 1 "Day Zero"** EN → X/IG/TikTok/FB/YT at 23:10Z; TH → FB/TikTok at 01:00Z Jul 24 (8 AM Thailand)
- Personal (never posted): Becca video (`~/Desktop/for-becca.mp4`)

## The plan (see POSTING-PLAN-30-DAYS.md for full calendar)

Daily drumbeat Jul 23–Aug 21. Journey Tue/Thu (EN 9AM Phoenix + TH 6PM Phoenix), Laws Mon/Wed/Fri, tile Sat, YouTube Sun. Monday = batch day. Cross-promo triangle: episodes tease Sunday YT; laws cite episode scars; YT recaps the law + links the shorts; one theme per week.

## Immediate next actions

1. **Agent Law #1** rendered (check runs/ for latest) — review, then queue for Fri Jul 24 16:00Z (9 AM Phoenix) to x,instagram,tiktok,facebook,youtube
2. Sat Jul 25: quote tile "million words / nine books" (square, motivational style)
3. Sun Jul 26: Two Brents YouTube "I Built It Four Times" (existing YT system + clone)
4. Mon Jul 27: first batch day — render Week 2 from JOURNEY-PRODUCTION-QUEUE.md
5. When ElevenLabs key lands: wire voice clone, add VO to English lane
6. Aug 4-ish: check Blotato analytics, bend plan to whichever rotation pulls follows

## Standing laws (Brent's)

- Draft-by-default; personal videos NEVER queue; no company names from his past industry on screen; age never the headline; v4 story told as winning-not-won ("the journey is alive"); one step at a time in conversation (one eye); no secrets in chat — file handoff only.
