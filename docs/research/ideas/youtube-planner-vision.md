# YouTube Planner — AI-Powered Content Pipeline

## For: `/system-arch` session · guardkit/youtube-planner repo · March 2026

---

## Purpose of this document

Captures the vision for the YouTube Planner agent — an AI-powered content creation
pipeline that takes a raw video idea from capture through to a filmable bullet-point
script, with competitive intelligence and weighted evaluation at each stage.

This consolidates and updates the thinking from three previous conversation starter
documents (see References) and the existing system architecture draft. Key update:
NemoClaw/OpenShell references are replaced with the DeepAgents SDK + NATS approach
consistent with the Jarvis fleet architecture.

---

## What is the YouTube Planner?

A multi-stage content planning pipeline that:

1. **Captures ideas** — from voice memos (iPhone in the forest), text input, or
   triggers from the Research Intelligence system
2. **Classifies** — browse (story-driven, emotional) vs search (tutorial, specific query)
3. **Validates** — competitive scan, audience assessment, feasibility check
4. **Develops** — hook crafting, title candidates, thumbnail concepts
5. **Structures** — 3-act story arc, bullet-point script, call-to-action
6. **Evaluates** — weighted scoring at each stage via Coach agent

The pipeline replaces paid SaaS tools (e.g., 1of10 at ~£80/month) by building
equivalent or superior functionality using the YouTube Data API v3, AI reasoning,
and the `langchain-deepagents-weighted-evaluation` template.

---

## Architecture

### Template
`langchain-deepagents-weighted-evaluation`

### Agent Roles

**Player (Content Creator)**
- Generates title candidates, hooks, story structures, scripts
- Runs competitive research via YouTube Data API
- Applies the 70/30 browse/search strategy
- Produces creative output at each pipeline stage

**Coach (Content Evaluator)**
- Evaluates output against stage-specific weighted criteria
- Browse content: emotional hook strength, curiosity gap, relatability
- Search content: keyword relevance, answer completeness, search intent match
- Cross-stage: consistency of angle, audience alignment, production feasibility

**Orchestrator (Pipeline Manager)**
- Drives the 5-stage pipeline sequentially
- Manages human checkpoints (go/no-go at validation stage, title approval)
- Handles branching: if an idea scores well for both browse AND search,
  can fork into two parallel plans
- Stores pipeline state for resume

---

## Three Sub-Systems

The YouTube Planner is really three interconnected systems. Build order matters.

### System 1: YouTube Transcript Map (Foundation)
- Scrapes entire YouTube channels → extracts transcripts → AI-analyses for topics,
  hooks, structures, performance signals
- Powers both competitive intelligence and proven-pattern extraction
- **Tech:** YouTube Data API v3, `youtube-transcript-api`, `yt-dlp`, Claude API
  (Sonnet for batch analysis), SQLite
- **Existing tool:** `yt-insights-mcp` (MCP server, built and working) — fetches
  transcripts and extracts structured insights. Core dependency, already proven.
- **Status:** Conversation starter created (03-youtube-transcript-map-starter.md)

### System 2: Research & Intelligence
- Continuous competitive monitoring across tracked channels
- Outlier detection (videos performing >3x channel average)
- Content gap identification (topics competitors haven't covered well)
- Trend signals from browse vs search performance patterns
- **Status:** Conversation starter created (01-youtube-research-intelligence-starter.md)

### System 3: Video Planning Pipeline
- The 5-stage planning pipeline itself
- Takes validated ideas through to filmable scripts
- Weighted evaluation at each stage
- **Status:** Conversation starter created (02-video-planning-pipeline-starter.md)

**Build order:** System 1 (Transcript Map) → System 2 (Research) → System 3 (Planning).
The transcript map is the foundation that powers everything else.

---

## Weighted Evaluation Criteria (Stage-Specific)

### Idea Capture Stage
```yaml
criteria:
  - id: browse_potential
    description: "Would this get clicked on someone's homepage?"
    weight: 0.30
  - id: search_demand
    description: "Are people actively searching for this?"
    weight: 0.20
  - id: unique_angle
    description: "Do we have a fresh take that competitors lack?"
    weight: 0.25
  - id: production_feasibility
    description: "Can we film this well with current equipment and access?"
    weight: 0.15
  - id: timeliness
    description: "Is there a news hook or time-sensitive angle?"
    weight: 0.10
```

### Hook & Title Stage
```yaml
criteria:
  - id: curiosity_gap
    description: "Does the title create a gap the viewer needs to close?"
    weight: 0.30
  - id: emotional_trigger
    description: "Does this evoke an emotion (fear, excitement, recognition)?"
    weight: 0.25
  - id: clarity
    description: "Is the promise clear within 3 seconds of reading?"
    weight: 0.20
  - id: keyword_alignment
    description: "Does the title contain terms people search for?"
    weight: 0.15
  - id: thumbnail_compatibility
    description: "Can this title work visually with a compelling thumbnail?"
    weight: 0.10
```

---

## Runtime Architecture Update

**Previous design** referenced NemoClaw/OpenShell as the execution runtime. This is
updated to align with the Jarvis fleet architecture:

| Previous (NemoClaw) | Updated (Jarvis Fleet) |
|---------------------|----------------------|
| OpenShell sandbox on DGX Spark | DeepAgents SDK agent, NATS-connected |
| NemoClaw privacy router | Provider-agnostic `agent-config.yaml` |
| Nemotron + Claude via privacy router | Gemini 3.1 Pro (reasoning) + Claude API (generation) |
| OpenClaw agent framework | LangChain DeepAgents SDK |
| Standalone system | Jarvis fleet member, dispatched via intent router |

The pipeline stages, content strategy, evaluation criteria, and creative methodology
are all unchanged. Only the runtime infrastructure is updated.

---

## Integration with Jarvis

The YouTube Planner is dispatched by the Jarvis intent router when requests match
content planning patterns:

- "I have a video idea about..." → YouTube Planner
- "What should my next video be about?" → YouTube Planner (research mode)
- "Research what channels are covering about DGX Spark" → YouTube Planner (intelligence mode)
- "Plan the Jarvis video" → YouTube Planner (planning mode with specific brief)

Results flow back through NATS to whatever adapter initiated the request.

---

## Channel Context

- **Owner:** Rich — 52-year-old software engineer documenting AI transition journey
- **Target audience:** Mid-career engineers navigating the AI shift
- **Strategy:** 70% browse (story-driven, emotional) / 30% search (tutorials, reviews)
- **Content pillars:** Transition Journey, Building in Public, Hardware & Robotics,
  GCSE Tutor/Dad Tech, AI Tools for Knowledge Workers
- **Key insight (Tom Gregory):** Aim for browse algorithm. The story is the asset.
  Browse = emotional hook + curiosity + wide relatability.

---

## Existing Documents (Transfer & Reference)

These documents from `~/Projects/YouTube Channel/` contain detailed specifications
created in earlier sessions. They should be referenced as input to `/system-arch`:

| Document | Location | Content |
|----------|----------|---------|
| Research Intelligence Starter | `01-youtube-research-intelligence-starter.md` | Competitive analysis pipeline design |
| Video Planning Pipeline Starter | `02-video-planning-pipeline-starter.md` | 5-stage planning workflow detail |
| Transcript Map Starter | `03-youtube-transcript-map-starter.md` | Channel scraping and analysis design |
| System Architecture (Draft) | `system-arch-youtube-pipeline.md` | Full system arch — **NemoClaw refs need updating** |
| Feature Specs | `feature-01` through `feature-05` | Individual feature specifications |
| Channel Project Briefing | `youtube-channel-project-briefing.md` | Overall channel strategy and context |
| Adversarial Video Planning Tool | `conversation-starter-adversarial-video-planning-tool.md` | Adversarial cooperation applied to content planning |

**Note:** The `system-arch-youtube-pipeline.md` references NemoClaw/OpenShell throughout
and should be updated to reflect the DeepAgents SDK + NATS architecture when running
`/system-arch` for this repo.

---

## Open Questions for `/system-arch`

1. **Transcript Map storage** — SQLite (simple, local) or Graphiti (temporal, queryable,
   shared with other agents)? Graphiti would let the Ideation Agent query content
   landscape too.

2. **YouTube Data API quotas** — 10,000 units/day free tier. Is this enough for
   continuous competitor monitoring? May need to batch and cache aggressively.

3. **MCP tool integration** — The existing `yt-insights-mcp` extracts transcripts.
   Should each sub-system become an MCP tool, or stay as DeepAgents tools?

4. **ComfyUI for thumbnails** — Feature 03 spec references ComfyUI for AI thumbnail
   generation. This runs on GB10 GPU — contention with vLLM models?

5. **Voice memo capture** — How do iPhone voice memos get into the pipeline? Apple
   Shortcuts → Telegram → NATS adapter? Or direct file sync via NAS?
