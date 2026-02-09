#!/bin/bash
# List available Chinese voices for macOS TTS
# Usage: voices.sh

echo "🔊 中文语音选项 (Chinese Voices)"
echo "================================"
echo ""

# Check if say command exists
if ! command -v say &> /dev/null; then
    echo "Error: 'say' command not found. This script requires macOS." >&2
    exit 1
fi

# Show Chinese voices
echo "可用中文语音 (Available Chinese voices):"
say -v '?' | grep -E "(Tingting|Meijia|Sinji)" || {
    echo "Warning: Could not find Chinese voices. Showing all voices instead:" >&2
    say -v '?'
}

echo ""
echo "================================"
echo "提示: 使用 say -v '?' 查看所有可用语音"
echo "Tip: Use 'say -v \"?\"' to see all available voices"
