---
name: macos-tts
description: macOS local text-to-speech using the native 'say' command. Use when you need to convert text to speech on macOS without external APIs. Supports Chinese voices (Tingting, Meijia, Sinji) and automatic playback.
homepage: https://support.apple.com/guide/mac-help/mh40584/mac
metadata: {"clawdbot":{"emoji":"🔊","requires":{"platform":["darwin"],"bins":["say","afplay"]}}}
---

# macOS TTS (say)

Use macOS built-in `say` command for local text-to-speech without any API keys.

## Quick start

```bash
# Basic usage
scripts/say.sh "你好，世界"

# Use different voice
scripts/say.sh -v Meijia "台湾口音"

# Save to custom location
scripts/say.sh -o ~/Desktop/greeting.aiff "Hello"
```

## Available voices

Chinese voices:
- `Tingting` (大陆女声，默认)
- `Meijia` (台湾女声)  
- `Sinji` (香港女声)

List all available voices:
```bash
scripts/voices.sh
# or
say -v '?'
```

## Scripts

### say.sh
Main TTS script with playback.

Usage: `say.sh [-v voice] [-o output] "text"`

Options:
- `-v voice`: Voice to use (default: Tingting)
- `-o path`: Output file path (default: /tmp/clawdbot_voice_latest.aiff)
- `-h`: Show help

Environment variables:
- `VOICE`: Default voice
- `OUTPUT_DIR`: Default output directory

### play_latest.sh
Replay the most recent TTS output.

Usage: `play_latest.sh`

### voices.sh
List available Chinese voices.

Usage: `voices.sh`

## Notes

- **No API key required** - uses macOS system TTS
- **Output format**: AIFF (Apple's audio format)
- **Auto-playback**: Generated audio plays automatically
- **Latest file**: Always saved to `/tmp/clawdbot_voice_latest.aiff` for replay
- **Platform**: macOS only (uses `say` and `afplay` system commands)

## Configuration

Set default voice via environment variable:
```bash
export VOICE=Meijia
scripts/say.sh "这段文字会用台湾口音播放"
```

Or in your shell profile (`.zshrc`, `.bashrc`):
```bash
export VOICE=Tingting
```
