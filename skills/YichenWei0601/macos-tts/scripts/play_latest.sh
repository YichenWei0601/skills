#!/bin/bash
# Replay the latest TTS output
# Usage: play_latest.sh

set -e

LATEST_FILE="/tmp/clawdbot_voice_latest.aiff"

if [ ! -f "$LATEST_FILE" ]; then
    echo "Error: No latest audio file found at $LATEST_FILE" >&2
    echo "Run say.sh first to generate audio." >&2
    exit 1
fi

if ! command -v afplay &> /dev/null; then
    echo "Error: 'afplay' command not found. This script requires macOS." >&2
    exit 1
fi

echo "🔊 Replaying: $LATEST_FILE"
afplay "$LATEST_FILE"
echo "✅ Done!"
