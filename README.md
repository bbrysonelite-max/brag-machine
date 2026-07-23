# The Brag Machine

**Type a prompt → branded, beat-synced Tiger Claw video → posting queue.**
Generation is free (Hyperframes, local render). Posting goes through a one-file adapter (Blotato today, Postiz when self-hosted). Drafts by default — nothing goes live without Brent.

## Install (once)

```bash
cd Brag-machine/machine
./setup.sh
```

Then fill `machine.env`:
```bash
adapters/blotato.sh accounts   # prints your account IDs
open machine.env               # paste them in
```

## Use

```bash
# Fully automatic: brain writes the video from your prompt
./claw "hook: silence kills more deals than no ever did" --format vertical --channels x,tiktok

# Render only (no posting)
./claw "..." --dry

# Reuse a proven template (no brain, no tokens)
./claw --template tigerclaw-launch --channels x

# Schedule
./claw "..." --at "2026-07-24T16:00:00Z"

# Fast iteration render
./claw "..." --dry --draft-quality
```

Every run lands in `runs/<timestamp>/` (composition + out.mp4 + caption). Every video is logged in `ledger.jsonl`.

## The parts

| Path | What |
|---|---|
| `claw` | The machine. Prompt → brain → check gate → render → queue → ledger |
| `brain/compose-prompt.md` | Instructions the local `claude` CLI follows to author each composition |
| `style/HOUSE-STYLE.md` | LOCKED brand + creative laws. Every video obeys it |
| `adapters/` | `blotato.sh` (default) · `postiz.sh` (true drafts, self-hosted) |
| `templates/tigerclaw-launch/` | The proven 19.5s launch video — reference + reusable |
| `hooks.md` | Hook bank. Burn one per video |
| `docker/postiz-compose.yml` | Self-hosted Postiz, when ready to go $0/mo |

## Safety rails

- `hyperframes check` gates every render (0 errors or no video)
- Draft-by-default; `--live` is opt-in per run
- Keys stay in files (`machine.env`, kloop.env) — never in chats or logs
- LOUD errors — the machine never silently skips a step

## Switching to self-hosted Postiz ($0/mo, true drafts)

```bash
cd docker && docker compose -f postiz-compose.yml up -d
# open http://localhost:4200, connect channels, create API key
# machine.env: QUEUE_ADAPTER=postiz, POSTIZ_API_KEY=...
```
