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
| **Brand truth (RULED by Brent 2026-07-23)** | **tigerclaw-primitives IS the Tiger brand truth** — it ships brentbryson.ai, tigerclaw.io, the Dashboard, and the Admin Dashboard. Machine PIVOTED: HOUSE-STYLE now carries primitives tokens verbatim (flat `#E8722A`, `#0A0A0A` base, `#4ADE80` signal green, Bebas Neue/Space Grotesk/IBM Plex Mono — woff2s bundled in template assets). Local clone beside machine; git pull before Tiger-brand work. **Exemption (Brent):** personal-series styles (journey/coaching/motivational) keep their own locked look incl. the 3-bar CSS claw — that mark is personal-series only now. Additive cleanup of the repo (tokens.json + TOKENS.md, no value changes) dispatched 2026-07-23. |

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

## Consolidation (DONE 2026-07-23)

Two systems only, per Brent: **SOCIAL = this machine** · **YOUTUBE = Two Brents (~/Desktop/YOUTUBE)**. ai-social-system repo RETIRED + archived; absorbed here: `voice/` (6 named cadences, never-say compliance, gold examples — use for ALL captions), `cadence/` (volume ramp, warm-up doctrine, no-repeat usedIdeas ledger in cadence-state.json), `docs/blotato-rest.md`. Its youtube-autoload.sh + HeyGen private-first handoff moved to ~/Desktop/YOUTUBE/scripts/.
**Skills (installed ~/.claude/skills/):** `brag-machine` (operator master), `brag-one` (single video end-to-end incl. Thai + VO), `brag-two` (stitch), `brag-music` (themes). Token law: subagents for all mining/reading; stitch/template/in-place-fixes over new brain runs.
Coming from Brent's other instance: 3 lead-magnet books (email harvest) — when live, `--cta` points at the capture page; check affiliate programs (Blotato/HeyGen/ElevenLabs) for promoted tools.
**Brand note:** Brent LOVES the claw logo as rendered in Agent Law #1 (run 20260723-101531) — keep that treatment.

## YouTube cadence (Brent's call 2026-07-23): TWO longform/week
Wed = practical lane (tools/laws) · Sun = story lane (Journey arc). Every longform → `heygen ai-clipping` → captioned Shorts top up the daily queue free. Scripts awaiting Brent's pass: 2026-07-26-i-built-it-four-times.md + 2026-07-29-the-seven-agent-laws.md (YOUTUBE/scripts/). Weekly rhythm table lives in POSTING-PLAN-30-DAYS.md — Brent's time ≈ 3 hrs/wk (Mon review, Tue scripts, Fri retro line).

## Immediate next actions

1. ~~Agent Law #1~~ QUEUED (approved "absolutely perfect"): Fri Jul 24 16:00Z to x,instagram,tiktok,facebook,youtube, with journey theme; music law extended — the stomp now covers journey + coaching + motivational styles
2. Sat Jul 25: quote tile "million words / nine books" (square, motivational style)
3. Sun Jul 26: Two Brents YouTube "I Built It Four Times" (existing YT system + clone)
4. Mon Jul 27: first batch day — render Week 2 from JOURNEY-PRODUCTION-QUEUE.md
5. When ElevenLabs key lands: wire voice clone, add VO to English lane
6. Aug 4-ish: check Blotato analytics, bend plan to whichever rotation pulls follows

## Voice stack (RULED by Brent 2026-07-23: "best generated voice I have ever had")

- **Voicebox** (jamiepine/voicebox, local app, API 127.0.0.1:17493) = THE English VO voice. Profile "Brent Bryson" id 18836009-0527-4b9f-9837-3d58c2a0dc76, cloned from 28s of FINISHED_v3 footage. `machine/scripts/vo.sh <run-dir> "<text>" [delay-ms]` = generate + duck-mix under any render. MCP registered (machine project). Gotchas: /history wraps in .items; /generate/{id}/status is SSE; single-lane server (vo.sh waits); sample max 30s + exact reference_text; librosa error = relaunch app.
- HeyGen = on-camera avatars only (CLI-driven, `heygen video create`; two Brents + contrast law at YOUTUBE/identity/TWO-BRENTS-CONTRAST.md). ElevenLabs 1.5M credits parked for Thai-in-Brent's-voice.
- **Gate auto-fix** in claw (`scripts/gate-autofix.sh`): heals missing hard-kills + mono-font errors deterministically, one retry, proven 5→0 on re-broken EP1.
- Format ruling: AGENT LAWS ship with Brent VO; JOURNEY episodes stay text-films (style law).

## Latest decisions (2026-07-23, post-consolidation)

- Brand visually VERIFIED via /browse screenshots: primitives gallery, brentbryson.ai, tigerclaw.io all match — no drift. Tiger mark PNGs grabbed from live site → primitives `assets/logo/` + machine template assets (`tigerclaw-mark.png`).
- **Standing rule (Brent): anything reusable we make gets contributed back to the primitives repo** (additive, never change values).
- **Cross-instance sync: `HANDOFF.md` in this repo is the relay** — other Fable instances pull, read SOTU + HANDOFF, append their delta, push. No human courier.
- YouTube-system assets (clone clips, little videos) also live on **Higgsfield** (MCP: show_generations / show_medias) — check there before re-making anything.

## Standing laws (Brent's)

- Draft-by-default; personal videos NEVER queue; no company names from his past industry on screen; age never the headline; v4 story told as winning-not-won ("the journey is alive"); one step at a time in conversation (one eye); no secrets in chat — file handoff only.
