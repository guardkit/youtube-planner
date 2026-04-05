# YouTube Planner — Conversation Starters Transfer Index

## Source Files (~/Projects/YouTube Channel/)

These conversation starters were created in earlier Claude Desktop sessions and contain
detailed specifications for each sub-system. They should be referenced as input to
`/system-arch` when building the YouTube Planner.

**Important:** Some files reference NemoClaw/OpenShell as the runtime. The updated
architecture in `docs/research/ideas/youtube-planner-vision.md` supersedes those
references — use DeepAgents SDK + NATS instead.

### Transferred Files

| File | Original Location | Purpose | NemoClaw Refs? |
|------|------------------|---------|---------------|
| `01-youtube-research-intelligence-starter.md` | `~/Projects/YouTube Channel/` | Research & Intelligence sub-system design | Yes — update "Orchestration" row |
| `02-video-planning-pipeline-starter.md` | `~/Projects/YouTube Channel/` | Video Planning Pipeline 5-stage workflow | Minimal |
| `03-youtube-transcript-map-starter.md` | `~/Projects/YouTube Channel/` | Channel scraping & analysis foundation | Yes — update "Orchestration (future)" row |

### Additional Reference Files (NOT transferred — reference in place)

| File | Location | Purpose |
|------|----------|---------|
| `system-arch-youtube-pipeline.md` | `~/Projects/YouTube Channel/` | Previous full system arch draft — **heavy NemoClaw refs, needs full rewrite** |
| `feature-01-channel-intelligence.md` | `~/Projects/YouTube Channel/` | YouTube API channel tracking feature spec |
| `feature-02-video-planning-pipeline.md` | `~/Projects/YouTube Channel/` | Pipeline feature spec |
| `feature-03-thumbnail-generator.md` | `~/Projects/YouTube Channel/` | ComfyUI + FLUX thumbnail generation |
| `feature-04-vision-board.md` | `~/Projects/YouTube Channel/` | Visual inspiration system |
| `feature-05-clip-similarity.md` | `~/Projects/YouTube Channel/` | Content similarity detection |
| `youtube-channel-project-briefing.md` | `~/Projects/YouTube Channel/` | Overall channel strategy |
| `insights/` directory | `~/Projects/YouTube Channel/insights/` | 13 structured insight files from creator strategy videos |

### When Running `/system-arch`

Paste in this order:
1. `youtube-planner-vision.md` (from this repo — the authoritative architecture vision)
2. The relevant conversation starter(s) for the sub-system being architected
3. Any relevant feature specs

The vision doc consolidates all previous thinking and updates the runtime architecture.
The conversation starters provide detailed design specifications per sub-system.
