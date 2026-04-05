# Conversation Starter: YouTube Transcript Map & Content Knowledge Base

## Instructions for This Session

I'm using Claude Desktop with extended thinking (or Claude Code) to design and build the YouTube Transcript Map — a tool that scrapes, analyses, and indexes YouTube channel content into a searchable knowledge base. This tool powers both the Research & Intelligence System (Conversation Starter 01) and the Video Planning Pipeline (Conversation Starter 02).

Please use extended thinking to deeply reason about each section before responding. I value thorough analysis over quick answers.

---

## Context

### What This Tool Does
Takes a YouTube channel URL (or list of channels) and produces:
1. **Channel content map** — every video catalogued by topic, date, views, engagement
2. **Transcript corpus** — full text of every video, cleaned and indexed
3. **Topic analysis** — what topics the channel covers, how often, with what success
4. **Structural analysis** — how videos are structured (hook patterns, pacing, CTAs)
5. **Gap analysis** — topics NOT covered, or covered poorly, that represent opportunities
6. **NEW: One-of-one analysis** — where does a creator share something only they could share? Where is content generic/replaceable?
7. **NEW: Format performance tracking** — do raw/authentic videos outperform polished ones? Walk-and-talk vs studio? Correlation between format and engagement.
8. **NEW: "How you think" vs "what you do" classification** — what proportion of a channel's content is perspective/framework-driven vs tutorial/information-driven?

### Why It Matters
- Feeds the Research & Intelligence System with competitive data
- Feeds the Video Planning Pipeline with proven patterns and underserved topics
- Potentially valuable as YouTube content in itself ("I built an AI tool that analyses YouTube channels")
- Could be shared as open-source tooling (portfolio value, community building)
- **NEW: Identifies where competitors are making replaceable content** — those are Rich's one-of-one opportunities

### Connection to Previous Work
- **GuardKit AutoBuild pattern:** This tool could be built USING the GuardKit research-to-implementation workflow — research here in Claude Desktop, implement via AutoBuild on DGX Spark
- **Graphiti knowledge graph:** Transcript data and analysis could be stored in Graphiti for temporal querying ("what were popular topics in this niche 6 months ago vs now?")
- **Brandon transcript map concept:** Originally explored for competitive intelligence — now repurposed as a core component of the YouTube content engine
- **yt-insights-mcp:** Already built and working via AutoBuild. Extracts transcripts + structured insights from individual YouTube videos. This is the proven foundation — the transcript map extends it to channel-scale batch processing.

### Key Strategic Context (March 2026)

The analysis pipeline should be informed by these validated insights from 13 creator/strategy videos:

**Sutherland's insight:** The most valuable content sells how you think, not what you do. Analysis should classify content as "perspective" vs "information" — the gap in perspective content is where Rich's channel competes.

**One-of-one principle:** Content only the creator could make beats content anyone could make. Analysis should score videos for replaceability — high-replaceability content is a competitive vulnerability.

**Outlier study method (1.3M Subscribers):** Find videos performing 10x-100x above channel average. Study the *click psychology* behind them. The transcript map should surface these outliers automatically.

**Idea is 80% of the result:** Title + thumbnail + idea = 80%. The transcript map's hook extraction and title pattern analysis are the highest-value outputs.

---

## Technical Architecture to Investigate

### Data Acquisition Layer

```
YouTube Channel URL
       │
       ▼
┌──────────────────┐
│ YouTube Data API  │ → Video IDs, titles, descriptions, tags,
│ v3               │   view counts, like counts, publish dates,
│                  │   duration, thumbnail URLs
└──────────────────┘
       │
       ▼
┌──────────────────┐
│ youtube-transcript│ → Full transcript text per video
│ -api             │   (with timestamps if available)
│                  │   Falls back to auto-generated captions
└──────────────────┘
       │
       ▼
┌──────────────────┐
│ yt-dlp           │ → Additional metadata, chapter markers,
│ (metadata only)  │   description links, hashtags
└──────────────────┘
       │
       ▼
┌──────────────────────────────────┐
│ Raw Data Store (SQLite/JSON)     │
│ - video_metadata table           │
│ - transcripts table              │
│ - channel_info table             │
└──────────────────────────────────┘
```

**Note:** The **yt-insights-mcp** tool (already built) handles individual video transcript + insight extraction. The Data Acquisition Layer extends this to batch channel-scale processing. Reuse the transcript extraction logic where possible.

### Analysis Layer

```
Raw Data Store
       │
       ▼
┌──────────────────────────────────┐
│ Claude API (Sonnet for batch)    │
│                                  │
│ Per-video analysis:              │
│ - Topic classification           │
│ - Hook extraction (first 30s)    │
│ - Structure mapping (3-act?)     │
│ - Key quotes / insights          │
│ - Sentiment / tone               │
│ - Target audience signals        │
│ - NEW: Replaceability score      │
│   (1-10: could 100 creators      │
│    have made this?)              │
│ - NEW: "How you think" vs        │
│   "what you do" classification   │
│ - NEW: Format classification     │
│   (raw/authentic, polished,      │
│    walk-and-talk, screen          │
│    recording, studio)            │
│ - NEW: "Paint" extraction        │
│   (analogies, metaphors,         │
│    stories used to illustrate)   │
│ - NEW: Emotional register        │
│   (what emotion does this        │
│    video target?)                │
│                                  │
│ Cross-video analysis:            │
│ - Topic clustering               │
│ - Performance correlation        │
│ - Temporal trends                │
│ - Content gap identification     │
│ - NEW: Format × performance      │
│   correlation (do raw videos     │
│   outperform polished ones?)     │
│ - NEW: Replaceability × views    │
│   correlation (do one-of-one     │
│   videos get more views?)        │
│ - NEW: Outlier detection         │
│   (10x-100x channel average)     │
└──────────────────────────────────┘
       │
       ▼
┌──────────────────────────────────┐
│ Knowledge Base                   │
│ Option A: SQLite + FTS5          │
│ Option B: Graphiti (Neo4j)       │
│ Option C: Both (SQLite for       │
│   queries, Graphiti for          │
│   relationships)                 │
└──────────────────────────────────┘
```

### Output Layer

```
Knowledge Base
       │
       ├──► Channel Content Map (visual/interactive)
       │    - Topic × Time heatmap
       │    - View performance by topic
       │    - Publishing cadence patterns
       │    - NEW: Format × performance overlay
       │
       ├──► Gap Analysis Report
       │    - Topics with search demand but low competition
       │    - Topics competitors cover poorly
       │    - Emerging topics not yet covered
       │    - NEW: Perspective gaps (where nobody is sharing
       │      unique thinking — just information)
       │    - NEW: One-of-one opportunities (high
       │      replaceability scores across competitors)
       │
       ├──► Hook Pattern Library
       │    - Categorised opening patterns
       │    - Correlation with retention/views
       │    - Templates for each pattern type
       │    - NEW: Pain/prize/news classification
       │    - NEW: "Paint" technique examples
       │      (best analogies, metaphors, stories
       │       from high-performing videos)
       │
       ├──► Outlier Report (NEW)
       │    - Videos performing 10x-100x channel average
       │    - Click psychology analysis for each outlier
       │    - Title/thumbnail pattern extraction
       │    - What made this one different?
       │
       └──► Video Planning Input
            - Pre-populated competitive context
            - Suggested angles based on gaps
            - Proven title/hook patterns
            - NEW: Content opportunity scores
              (using the 6-criterion rubric from
               Conversation Starter 01)
```

---

## Investigation Areas

### API & Scraping
1. **YouTube Data API v3 quotas** — daily quota is 10,000 units. How many videos can we process per day? What costs what?
2. **Transcript availability** — what % of tech YouTube videos have transcripts? Auto-generated vs manual? Quality differences?
3. **Rate limiting** — youtube-transcript-api rate limits? Best practices for batch extraction? (Note: AutoBuild integration tests previously triggered IP blocking — use the `--real` flag discipline + few-second delay between calls. Hotshield VPN as escape hatch.)
4. **Legal considerations** — YouTube ToS around data scraping? API usage terms? (Similar to our GCSE training data legal research)
5. **Alternative approaches** — Vercel Agent Browser for scraping? Chrome Claude extension? Apify actors?

### Analysis Pipeline
1. **Batch processing** — how to efficiently analyse 500+ transcripts? Claude API batch mode? Local models on DGX Spark?
2. **Topic classification** — supervised (predefined categories) vs unsupervised (let clusters emerge)? Probably both.
3. **Hook extraction** — can we reliably identify the "hook" from transcript text alone, or do we need timestamps + first 30 seconds?
4. **Structure detection** — can Claude identify 3-act structure, transitions, retention points from transcript text?
5. **Cost estimation** — if processing 500 videos through Claude Sonnet, what's the approximate API cost?
6. **NEW: Replaceability scoring** — can Claude reliably score how replaceable/unique a video's content is? Needs a clear rubric.
7. **NEW: Format classification** — can we detect format (walk-and-talk, studio, screen recording) from transcript + metadata alone, or do we need thumbnail/video analysis?

### Storage & Querying
1. **SQLite with FTS5** — simple, portable, good for text search. But can it handle relationship queries?
2. **Graphiti integration** — could this be a Graphiti entity type? Videos as nodes, topics as relationships, channels as parent nodes?
3. **Incremental updates** — how to efficiently update when channels publish new videos?
4. **Cross-channel querying** — "show me all videos about DGX Spark across all tracked channels"

### Tool Design
1. **CLI tool** (Claude Code command) — `yt-map analyse @StefanMischook --depth full`
2. **Python package** — importable, composable, testable
3. **Cowork integration** — natural language queries against the knowledge base
4. **Output formats** — Markdown reports? Interactive HTML? JSON for programmatic access?
5. **Scheduling** — weekly automated runs to track changes?

---

## Questions to Explore

1. What's the fastest path to a working prototype that analyses one channel and produces a useful report?
2. Should we process transcripts through Claude API or local models (Qwen/Llama on DGX Spark)?
3. How do we handle channels with 2,000+ videos (like Stefan Mischook) — full analysis or sample?
4. Can we detect browse vs search traffic from available API data? (Probably not directly, but can we infer from view velocity patterns?)
5. What metadata signals correlate with browse algorithm performance? (High views relative to subscriber count, rapid early view growth?)
6. Should this tool be open-sourced? It could itself be content for the channel ("I built an AI tool that analyses any YouTube channel — here's what I learned about mine")
7. **NEW:** How do we incorporate the outlier study method — automatically surfacing 10x-100x videos with click psychology analysis?
8. **NEW:** Can the replaceability score be validated? (e.g., compare Claude's replaceability scores against actual view performance — do one-of-one videos perform better?)

---

## Desired Output from This Session

1. **Technical specification** — complete architecture with API details, data models, analysis prompts
2. **MVP scope** — minimum viable tool that processes one channel end-to-end
3. **GuardKit feature spec** — structured as a research-to-implementation handoff (using our established template) so it can be built via AutoBuild on DGX Spark
4. **Sample analysis** — run a manual version against Stefan Mischook's channel (or a subset) to validate the approach
5. **Integration points** — exactly how this feeds into the Video Planning Pipeline

---

## MVP Definition

### Phase 1: Single Channel Scraper (Week 1)
- YouTube Data API setup
- Fetch all video metadata from one channel
- Extract transcripts for all videos with available captions
- Store in SQLite
- Basic stats output (video count, topic word cloud, publish frequency)
- **NEW: Outlier detection** — flag videos performing 10x+ above channel average

### Phase 2: AI Analysis (Week 2)
- Claude API batch analysis of transcripts
- Topic classification and clustering
- Hook extraction (first 30 seconds of each transcript)
- Performance correlation (which topics get most views?)
- **NEW: Replaceability scoring per video**
- **NEW: "How you think" vs "what you do" classification**
- **NEW: Format classification (raw/polished/walk-and-talk/screen)**
- Output: Markdown channel analysis report

### Phase 3: Multi-Channel & Gap Analysis (Week 3)
- Add support for multiple channels
- Cross-channel topic comparison
- Gap identification (topics with search demand but low coverage)
- **NEW: Perspective gap identification** (where no channel is offering unique thinking)
- **NEW: One-of-one opportunity report** (where all competitors score high on replaceability)
- Output: Content opportunity report with scores

### Phase 4: Integration (Week 4)
- Connect to Video Planning Pipeline (auto-populate competitive context in Stage 2)
- **NEW: Auto-populate outlier patterns in Stage 3** (hook/title patterns from top performers)
- Optional: Graphiti storage for temporal analysis
- Optional: Interactive HTML dashboard

---

## Technology Decisions (Pre-made)

These decisions are settled (following the GuardKit pattern of front-loading decisions):

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Primary language | Python 3.12+ | Ecosystem, Claude API SDK, youtube libraries |
| API client | google-api-python-client | Official, well-maintained |
| Transcript extraction | youtube-transcript-api (batch) + yt-insights-mcp (individual) | Batch for channel scraping; yt-insights-mcp for on-demand single videos (already built) |
| Metadata supplement | yt-dlp | Chapter markers, extra metadata |
| Storage | SQLite with FTS5 | Simple, portable, good text search |
| Analysis LLM | Claude Sonnet (API) initially | Quality + cost balance for batch work |
| Output format | Markdown + JSON | Human-readable + machine-parseable |
| Package structure | Single Python package | `youtube_content_map/` |
| Testing | pytest | Standard |
| Orchestration (future) | NemoClaw/OpenClaw on DGX Spark | Announced GTC 2026; aligns with GuardKit architecture |
| Rate limiting | Configurable per-request delay + Hotshield VPN fallback | Learned from yt-insights-mcp integration test IP blocking |

---

## Related Documents
- `01-youtube-research-intelligence-starter.md` — The broader research system this tool powers (updated March 2026 with insights library)
- `02-video-planning-pipeline-starter.md` — The planning pipeline this tool feeds into (updated March 2026 with proven proof of concept)
- `video-plans/001-twin-ai-paradoxes.md` — First completed video plan, proof of concept for the pipeline
- `feature-01-channel-intelligence.md` — Channel intelligence feature spec (YouTube API outlier scoring)
- `feature-02-video-planning-pipeline.md` — Pipeline feature spec
- `feature-03-thumbnail-generator.md` — ComfyUI + FLUX thumbnail generation
- `system-arch-youtube-pipeline.md` — Overall system architecture
- GuardKit Research-to-Implementation Template — Pattern for structuring the build handoff
- `/insights/` directory — 13 structured insight files from creator/strategy videos, informing analysis dimensions

---

## Insights Library Reference

The analysis pipeline's prompts and scoring rubrics should be informed by patterns identified in these insight files (stored in `/insights/`):

| Analysis Dimension | Informed By |
|-------------------|-------------|
| Hook pattern extraction | How to Actually Talk on YouTube; Give Me 7 Minutes Speaking Skills |
| Replaceability scoring | One-of-One Creator (25K subs) |
| "How you think" classification | Rory Sutherland — Doorman Fallacy |
| Format classification | Why Raw Authentic Videos Are Blowing Up; YouTube Is Broken — Walk and Talk |
| Outlier detection method | How to Build to 1.3M Subscribers |
| Emotional register classification | How to Actually Talk on YouTube (target feeling); Personal Brand Window (pain/prize/news) |
| "Paint" technique extraction | Give Me 7 Minutes Speaking Skills (analogy, metaphor, story, example) |
| Content opportunity scoring | Rory Sutherland + One-of-One Creator + Raw Authentic research (combined into 6-criterion rubric in Starter 01) |
