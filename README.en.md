# Papyrus

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

A **spaced-repetition** learning tool built around flashcards, with an optional AI study assistant.

Design philosophy: **minimal, keyboard-driven, flow-state first**.

---

## What it is

| Capability | Description |
|------------|-------------|
| **Learning engine** | SM-2 based scientific review scheduling |
| **Knowledge base** | Create cards manually or import in bulk |
| **AI co-pilot** | Hints, explanations, expansions, practice generation — and optional card mutations |

## Design principles

1. **Keyboard-first** — the core study loop is fully usable without a mouse
2. **Local-first** — user data stays on device by default; nothing is uploaded to the cloud
3. **Graceful degradation** — AI is optional; study works without it
4. **Privacy** — API keys are masked in the UI; configs are validated before save

## Features

- **Card management**: add, bulk import (`===` separator), search, delete
- **SM-2 review**: due-card scheduling, three-grade scoring (Forgot / Vague / Mastered), debounce against mis-taps
- **AI assistant**: OpenAI-compatible / Anthropic / Ollama / custom providers; Agent and Chat modes
- **MCP server**: local HTTP API for external tools (optional)
- **Backup & logging**: SQLite database backups; leveled logs with sensitive-field masking

## Tech stack

| Item | Choice |
|------|--------|
| Flutter SDK | 3.41.x |
| Dart SDK | 3.11.x |
| UI | fluent_ui 4.15.x |
| State | Provider + ChangeNotifier |
| Persistence | Drift (SQLite), including Web via WASM |
| Platforms | Android / iOS / Windows / macOS / Linux / Web |

## Quick start

```bash
# Install dependencies
flutter pub get

# Desktop (primary for development)
flutter run -d macos
flutter run -d windows
flutter run -d linux

# Mobile / Web
flutter run -d ios
flutter run -d android
flutter run -d chrome

# Tests
flutter test
```

After database schema changes, regenerate Drift code:

```bash
dart run build_runner build
```

## Keyboard shortcuts (study)

| Key | Action |
|-----|--------|
| `Space` | Show answer |
| `1` | Grade: Forgot |
| `2` | Grade: Vague |
| `3` | Grade: Mastered |

## Project layout

```
lib/
├── core/           # Constants, extensions, platform helpers
├── data/           # Models, repositories, Drift database
├── domain/         # SM-2, services, use cases (pure Dart)
├── presentation/   # UI, providers, screens, widgets
├── ai/             # AI module (optional, degradable)
├── mcp/            # MCP HTTP server (Isolate-isolated)
└── logging/        # Logging system
```

See [`STRUCTURE.md`](STRUCTURE.md) for architecture details, [`PRD.md`](PRD.md) for product requirements, and [`AGENTS.md`](AGENTS.md) for agent/contributor conventions.

## Bulk import format

UTF-8 text; blank-line separated blocks; `===` splits question and answer:

```
Question A === Answer A

Question B === Answer B
```

## License

[MIT](LICENSE) © 2026 CloverIris
