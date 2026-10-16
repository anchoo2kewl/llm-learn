# llm-learn

Audio Courses on this Mac: personal, never-ending, adaptive courses on any topic, taught as natural-sounding
audio with a word-by-word read-along, a mind map, quizzes and a memory of every question.

This repo is the app. The engine, player and speech sidecar are the public module
[go-learn](https://github.com/anchoo2kewl/go-learn) (design: go-learn#1).

- Text: the logged-in `claude` / `codex` CLIs (subscriptions, no API keys). Courses can let the teacher read
  `~/elastio`, `~/projects`, `~/play` and GitHub, read-only.
- Voice: Qwen3-TTS and Kokoro on MLX, speech-to-text with parakeet, in go-learn's `sidecar/`.
- Runs as the launchd agent `com.llm-learn.server` on 127.0.0.1:8790 and the Mac's Tailscale IP.

```
make install     # build, write the launchd agent, start it
make restart     # after changes (here or in ../../play/go-learn via go.work)
make logs
make bump        # pin the latest pushed go-learn
```

Data: `~/.local/share/llm-learn` (SQLite + audio). Log: `~/.local/state/llm-learn/llm-learn.log`.
For local development, `go.work` (git-ignored) points at `~/play/go-learn`:
`printf 'go 1.26.0\n\nuse (\n\t.\n\t../../play/go-learn\n)\n' > go.work`
