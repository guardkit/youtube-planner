# YouTube Planner — Specialist Agent Template Strategy

## Date: 11 April 2026
## Status: Future exploration — document for reference, not active build
## Context: Decision made during unified harness ideation (specialist-agent Phase 1B)

---

## The Question

The youtube-planner uses the same `langchain-deepagents-weighted-evaluation` template as the Architect Agent and Product Owner Agent. The specialist-agent repo (formerly architect-agent) is being refactored into a unified harness where multiple roles share the same Player-Coach loop, scoring engine, and session lifecycle, differentiated by role config (prompts, criteria) and role-specific code (output types, formatters).

Should the youtube-planner become a `--role youtube-planner` inside the specialist-agent harness, or remain a standalone repo?

## Decision: Standalone repo, instantiated from the specialist-agent template

The youtube-planner should remain its own repo but be **instantiated from the `langchain-specialist-agent` template** once that template is extracted from the specialist-agent harness (after Phase 1B validates the two-role pattern).

## Rationale

### Why not a role inside specialist-agent

The architect and product owner are tightly coupled in a pipeline — product owner output feeds directly into architect input, both operate on the same product docs (e.g. FinProxy), and cross-role evaluation is a real use case (architect Coach evaluates product owner output for feasibility). They're different lenses on the same material.

The youtube-planner operates on completely different input material (channel strategy, transcript maps, competitor analysis, trend data), serves a different consumer (Rich as creator, not James as product owner), and has no pipeline relationship with the other specialist roles. There is no scenario where the architect's Coach evaluates a video plan, or where a video plan feeds into `/system-arch`.

The litmus test: **would you ever run two roles from the same `--docs` directory?**
- Architect + product owner: yes (same FinProxy docs). They're pipeline-coupled.
- Architect + youtube-planner: never. They're domain-isolated.

The youtube-planner also has capabilities the specialist harness doesn't need: transcript analysis, YouTube API integration, trend research, thumbnail generation prompts. These are youtube-planner-specific tools that don't benefit the shared harness.

### Why the template approach works

When Phase 1B validates the specialist-agent with two roles (architect + product owner), the next step is `/template-create` → `langchain-specialist-agent` template. The youtube-planner can then be instantiated from this template, getting the battle-tested harness code (Player-Coach loop, weighted evaluation, scoring engine, session lifecycle, progress display, session logging) without being coupled to the FinProxy pipeline.

The youtube-planner gets its own:
- `roles/youtube-planner/role.yaml` — criteria, thresholds, prompt paths
- `roles/youtube-planner/prompts/player.md` — content planning generation instructions
- `roles/youtube-planner/prompts/coach.md` — content quality evaluation rubric
- `roles/youtube-planner/criteria/definitions.yaml` — weighted criteria for video plans
- `src/.../roles/youtube_planner/types.py` — `VideoPlan`, `VideoHook`, `NarrativeArc`, etc.
- `src/.../roles/youtube_planner/formatter.py` — renders video plans
- YouTube-specific tools (transcript analysis, trend research, etc.)
- Its own repo, CI, versioning, and evolution path

### The creative dimension is not a blocker

Weighted evaluation works perfectly for creative output. The scoring guides make subjective judgment gradable — the same way architectural "simplicity" is subjective but scorable with a rubric. Tom Gregory's "browse algorithm content with emotional hooks" translates directly to weighted criteria.

## Illustrative Criteria (for future reference)

If the youtube-planner were implemented via the specialist-agent template, its criteria might look like:

```yaml
criteria:
  - id: hook_strength
    weight: 0.25
    description: "Opening hook creates curiosity within 5 seconds — emotional, surprising, or contrarian"
  - id: narrative_coherence
    weight: 0.20
    description: "Clear narrative arc with Act 1 (setup), Act 2A (journey), Act 2B (mistakes/lessons), Act 3 (transformation)"
  - id: browse_algorithm_fit
    weight: 0.20
    description: "Title + thumbnail + opening optimised for YouTube browse algorithm — 70% browse / 30% search strategy"
  - id: authenticity
    weight: 0.15
    description: "Content reflects genuine experience and war stories, not generic AI/tech commentary"
  - id: production_feasibility
    weight: 0.10
    description: "Plan is achievable with current equipment and editing skills — not overscoped"
  - id: seo_coverage
    weight: 0.10
    description: "Tags, description, and title target discoverable search terms for the 30% search content"

detection_patterns:
  - id: CLICKBAIT_WITHOUT_SUBSTANCE
    description: "Hook promises something the content doesn't deliver"
    severity: critical
    penalty: 0.10
  - id: MISSING_HOOK
    description: "No clear hook in first 15 seconds — starts with preamble or intro"
    severity: critical
    penalty: 0.10
  - id: GENERIC_ADVICE
    description: "Content could be from any AI/tech channel — no personal experience or unique angle"
    severity: major
    penalty: 0.05
  - id: WRONG_AUDIENCE
    description: "Content targets beginners when channel is for mid-career engineers, or vice versa"
    severity: major
    penalty: 0.05
```

## What This Proves for the DDD Talk

If executed, this becomes a third proof point in the software factory narrative:

1. "I built two specialist agents from the same codebase" (architect + product owner)
2. "I extracted a template from that harness" (`/template-create` → `langchain-specialist-agent`)
3. "I manufactured a third agent for a completely different domain from that template" (youtube-planner)

**The factory makes factories.** The harness is the first factory (produces specialist agents). The template is the second factory (produces harnesses). The flywheel compounds — each new specialist validates the template, and template improvements flow back to all specialists.

## Timeline

This is not active work. The sequence is:

1. ✅ Phase 0 — architect agent works
2. ▶ Phase 1 — output quality hardening
3. ◻ Phase 1B — unified harness (architect + product owner prove the pattern)
4. ◻ `/template-create` → `langchain-specialist-agent` template
5. ◻ YouTube planner instantiated from template (this document's scope)

Step 5 is months away. This document exists so the decision and rationale are captured now while the reasoning is fresh.

---

## Related Documents

- `specialist-agent/docs/research/ideas/unified-agent-harness-conversation-starter.md` — the original exploration
- `specialist-agent/docs/research/ideas/FEAT-008-unified-agent-harness-v2.md` — feature spec for Phase 1B
- `specialist-agent/docs/architecture/decisions/ADR-ARCH-008-unified-harness.md` — unified harness ADR
- `specialist-agent/docs/architecture/decisions/ADR-ARCH-009-role-config-pattern.md` — config vs code split

---

*Decision documented: 11 April 2026*
*"The factory makes factories. The flywheel compounds."*
