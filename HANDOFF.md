# HANDOFF — for any Fable instance joining this work
*Cross-instance sync file. Protocol: `git pull` this repo, read `SOTU.md` (full state) then this file (latest deltas). When you finish work, append your delta below with a date + instance tag, commit, push. The repo is the relay — no human courier needed.*

## What this project is (30 seconds)

Brent Bryson runs a daily content system built on the **Brag Machine** (`machine/` in this repo): prompt → claude-authored video → check gate → local render → Blotato queue to 6 social channels. Two systems, never mixed: **SOCIAL = this machine** · **YOUTUBE = Two Brents** (HeyGen clone; lives on Brent's Mac at ~/Desktop/YOUTUBE + assets on Higgsfield). Brand truth for anything Tiger = **tigerclaw-primitives** repo. Personal series (THE JOURNEY, AGENT LAWS) have their own locked look + the rock-stomp theme.

## Decisions log (newest first)

### 2026-07-23 (instance: Brent's Mac / terminal Fable)
- **Content live:** THE JOURNEY EP 1 "Day Zero" posted EN (5 channels) + Thai (FB/TikTok, 8AM Thailand slot). AGENT LAW #1 queued Fri 16:00Z. 30-day plan on Brent's Desktop (`POSTING-PLAN-30-DAYS.md`) — Journey Tue/Thu bilingual, Laws M/W/F, tile Sat, YouTube Sun, cross-promo triangle between all three.
- **Brand ruling (Brent, final):** tigerclaw-primitives IS Tiger brand truth (ships brentbryson.ai, tigerclaw.io, both Dashboards — visually verified with screenshots, all match, no drift). Machine HOUSE-STYLE pivoted to primitives tokens (flat #E8722A, #0A0A0A, Bebas Neue/Space Grotesk/IBM Plex Mono — woff2s bundled). The 3-bar CSS claw = personal-series mark ONLY.
- **Primitives upgraded (additive only, never change values):** tokens.json + TOKENS.md (canonical, machine-readable), assets/logo/ (tiger mark PNGs from the live site). **Standing rule: anything reusable we make gets contributed back to primitives.**
- **Consolidation done:** ai-social-system repo RETIRED + archived; its voice engine (`machine/voice/` — 6 named cadences, never-say compliance, gold examples), cadence engine (`machine/cadence/` — ramp, warm-up, no-repeat usedIdeas ledger), and Blotato REST contract (`machine/docs/`) absorbed HERE. Its youtube-autoload.sh moved to the YouTube system.
- **Skills installed** on Brent's Mac: brag-machine, brag-one, brag-two, brag-music (see ~/.claude/skills/).
- **Music:** journey-theme.mp3 locked across journey/coaching/motivational. No commercial songs/covers ever (melody copyright).
- **Pending:** Brent's ElevenLabs key (→ voice clone VO, EN + Thai); lead-magnet books being built on ANOTHER instance (3 books, email harvest — when live, `--cta` points at capture page); affiliate links for promoted tools.
- **Token law:** subagents for heavy reading/mining; stitch/template/in-place fixes over new brain runs.

### 2026-07-23 PM (instance: Brent's Mac / terminal Fable)
- **Voice solved**: Voicebox (local, free) cloned Brent from his own footage — his verdict: "best generated voice I have ever had." vo.sh narrates any render. Agent Laws now ship with his voice; Journey eps stay text-films. HeyGen = on-camera only; ElevenLabs credits parked for Thai.
- **Content bank**: Weeks 1–2 fully scheduled EN+TH (through Aug 1). Week 3 (Laws 5–7 + EP4–5 + tile) approved, VO in progress, scheduling into Aug 3–9. Receipts correction: the million-words tile now matches Brent's real Flow screenshots (1,016,656 words / 197 days / "10 complete books"), banked in machine/receipts/.
- **Machine upgrades**: gate auto-fix (self-heals check failures, no AI cost); heygen CLI grounded as the YouTube render path (no manual HeyGen Pro steps); Sunday YT script drafted at YOUTUBE/scripts/ awaiting Brent's pass; contrast law at YOUTUBE/identity/TWO-BRENTS-CONTRAST.md; production log at YOUTUBE/PRODUCTION-LOG.md.

### (append your delta above this line, newest first)

## For the browser-instance Fable specifically

- If you're building lead magnets: the funnel doctrine you should match is `machine/voice/cta-and-funnel.md`; Brent's voice rules are `machine/voice/voice.md` + `never-say.md` (FTC-tight: biography, never earnings).
- YouTube assets (clone videos, little clips) live on **Higgsfield** — MCP-accessible from Claude instances; check `show_generations`/`show_medias` there before re-making anything.
- The show bible + production queue + 30-day plan are Desktop files on Brent's Mac; ask him for copies or have him drop them in this repo if you need them.
