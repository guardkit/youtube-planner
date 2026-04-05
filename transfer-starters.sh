#!/bin/bash
# Transfer YouTube Channel conversation starters to youtube-planner repo
# Run from anywhere — uses absolute paths

SRC="$HOME/Projects/YouTube Channel"
DST="$HOME/Projects/appmilla_github/youtube-planner/docs/research/conversation-starters"

echo "Copying conversation starters from YouTube Channel to youtube-planner repo..."

cp "$SRC/01-youtube-research-intelligence-starter.md" "$DST/"
cp "$SRC/02-video-planning-pipeline-starter.md" "$DST/"
cp "$SRC/03-youtube-transcript-map-starter.md" "$DST/"

echo "Done. Files copied to: $DST"
echo ""
echo "Note: Some files reference NemoClaw/OpenShell as runtime."
echo "The updated architecture in docs/research/ideas/youtube-planner-vision.md"
echo "supersedes those references — use DeepAgents SDK + NATS instead."
ls -la "$DST"
