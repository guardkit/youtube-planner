# YouTube Planner — AI-Powered Content Pipeline

An AI-powered content creation pipeline that takes a raw video idea from capture
through to a filmable bullet-point script, with competitive intelligence and
weighted evaluation at each stage.

## Status: Pre-Architecture

Currently in ideation phase. Previous architecture drafts and conversation starters
exist (see Docs below). Next step: run `/system-arch` using the vision document
which consolidates and updates all previous thinking.

## What It Does

Three interconnected sub-systems:

1. **Transcript Map** (foundation) — scrapes YouTube channels, extracts transcripts,
   analyses for topics/hooks/structures/performance
2. **Research Intelligence** — continuous competitive monitoring, outlier detection,
   content gap identification
3. **Planning Pipeline** — 5-stage workflow: Idea Capture → Validation → Hook/Title →
   3-Act Structure → Bullet-Point Script

Uses weighted evaluation at each stage with criteria tuned for browse (story-driven,
70% of content) vs search (tutorial, 30% of content) video types.

## Docs

- `docs/research/ideas/youtube-planner-vision.md` — Consolidated vision & architecture

### Previous Documents (in ~/Projects/YouTube Channel/)
- `01-youtube-research-intelligence-starter.md` — Research system design
- `02-video-planning-pipeline-starter.md` — Planning workflow detail
- `03-youtube-transcript-map-starter.md` — Channel analysis design
- `system-arch-youtube-pipeline.md` — Previous arch draft (NemoClaw refs need updating)
- `feature-01` through `feature-05` — Individual feature specifications
- `youtube-channel-project-briefing.md` — Channel strategy and context

## Part of the Jarvis Fleet

Dispatched by the Jarvis intent router when requests match content planning patterns.
Uses `langchain-deepagents-weighted-evaluation` template. Communicates via NATS JetStream.

## Existing Foundation

The `yt-insights-mcp` tool (MCP server) is already built and working — fetches YouTube
transcripts and extracts structured insights. This is a core dependency for the
Transcript Map sub-system.

## Build Command

```bash
# When ready to start architecture:
# 1. Paste youtube-planner-vision.md into a new Claude Desktop conversation
# 2. Include relevant previous docs as additional context
# 3. Run: /system-arch "YouTube Content Pipeline"
# 4. Then: /system-design, /system-plan, /feature-spec, /feature-plan, autobuild
```
