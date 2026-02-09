#!/bin/bash
# macOS TTS - Text to Speech with playback
# Usage: say.sh [-v voice] [-o output] "text to speak"

set -e

# Default configuration
VOICE="${VOICE:-Tingting}"
OUTPUT_DIR="${OUTPUT_DIR:-/tmp}"
LATEST_FILE="$OUTPUT_DIR/clawdbot_voice_latest.aiff"

# Show help
show_help() {
    cat << 'EOF'
Usage: say.sh [OPTIONS] "text to speak"

Options:
    -v VOICE    Voice to use (default: Tingting)
    -o PATH     Output file path (default: /tmp/clawdbot_voice_latest.aiff)
    -h          Show this help message

Environment variables:
    VOICE       Default voice
    OUTPUT_DIR  Default output directory

Examples:
    say.sh "你好，世界"
    say.sh -v Meijia "台湾口音"
    say.sh -o ~/Desktop/hello.aiff "Hello"

Available Chinese voices:
    Tingting    Mainland Chinese female (default)
    Meijia      Taiwanese female
    Sinji       Hong Kong female

List all voices: say -v '?'
EOF
}

# Check dependencies
check_deps() {
    if ! command -v say &> /dev/null; then
        echo "Error: 'say' command not found. This script requires macOS." >&2
        exit 1
    fi
    if ! command -v afplay &> /dev/null; then
        echo "Error: 'afplay' command not found. This script requires macOS." >&2
        exit 1
    fi
}

# Parse arguments
OUTPUT_FILE=""
while getopts "v:o:h" opt; do
    case $opt in
        v) VOICE="$OPTARG" ;;
        o) OUTPUT_FILE="$OPTARG" ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done
shift $((OPTIND-1))

TEXT="$*"

# Validate input
if [ -z "$TEXT" ]; then
    echo "Error: No text provided" >&2
    show_help >&2
    exit 1
fi

# Check dependencies
check_deps

# Use specified output or default location
if [ -n "$OUTPUT_FILE" ]; then
    TARGET_FILE="$OUTPUT_FILE"
else
    TARGET_FILE="$LATEST_FILE"
    # Clean up old latest file
    [ -f "$LATEST_FILE" ] && rm -f "$LATEST_FILE"
fi

# Generate speech
echo "🎙️  Generating speech with voice: $VOICE"
if ! say -v "$VOICE" -o "$TARGET_FILE" "$TEXT" 2>/dev/null; then
    echo "Error: Failed to generate speech. Voice '$VOICE' may not be available." >&2
    echo "Run 'say -v \"?\"' to list available voices." >&2
    exit 1
fi

# Play audio
echo "🔊 Playing..."
if ! afplay "$TARGET_FILE" 2>/dev/null; then
    echo "Warning: Failed to play audio automatically." >&2
    echo "File saved to: $TARGET_FILE" >&2
    exit 1
fi

echo "✅ Done! File saved to: $TARGET_FILE"
