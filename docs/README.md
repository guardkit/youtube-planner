# YouTube Planner — Documentation

## docs/research/ideas/

| Document | Purpose | Feeds Into |
|----------|---------|-----------|
| `youtube-planner-vision.md` | Consolidated vision: 3 sub-systems, stage-specific weighted criteria, updated runtime architecture (NemoClaw → DeepAgents SDK + NATS) | `/system-arch "YouTube Content Pipeline"` |

## docs/research/conversation-starters/

Detailed conversation starters transferred from `~/Projects/YouTube Channel/`.
These contain deep specifications for each sub-system.

| Document | Sub-System | Notes |
|----------|-----------|-------|
| `01-youtube-research-intelligence-starter.md` | Research & Intelligence | NemoClaw refs in "Orchestration" row — use DeepAgents SDK |
| `02-video-planning-pipeline-starter.md` | Video Planning Pipeline | Minimal NemoClaw refs |
| `03-youtube-transcript-map-starter.md` | Transcript Map (foundation) | NemoClaw refs in "Orchestration (future)" row — use DeepAgents SDK |
| `README.md` | Transfer index | Lists all files, notes which refs need updating, paste order for `/system-arch` |

**If starters aren't present yet**, run: `bash transfer-starters.sh` from repo root.

## Additional Reference Files (in ~/Projects/YouTube Channel/)

- `system-arch-youtube-pipeline.md` — Previous full system arch (heavy NemoClaw refs, needs rewrite)
- `feature-01` through `feature-05` — Individual feature specifications
- `youtube-channel-project-briefing.md` — Channel strategy
- `insights/` directory — 13 structured insight files from creator strategy videos

## How to Use

1. Open a new Claude Desktop conversation
2. Paste `youtube-planner-vision.md` first (authoritative architecture)
3. Then paste the relevant conversation starter(s) for detail
4. Run: `/system-arch "YouTube Content Pipeline"`
5. Continue: `/system-design` → `/system-plan` → `/feature-spec` → `/feature-plan` → `autobuild`

## Build Order (Sub-Systems)

1. Transcript Map (foundation — powers everything else)
2. Research Intelligence (competitive monitoring)
3. Planning Pipeline (idea → script)
