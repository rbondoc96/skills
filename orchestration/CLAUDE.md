# Claude adapter

Claude Agent and Workflow model parameters reach only Claude models. To dispatch Codex or Pi, spawn a thin Claude wrapper.

## Wrapper

- Give the wrapper a self-contained dispatch card and the approved route.
- In workflows, use a low-effort Sonnet wrapper, a model-prefixed label, and a structured report schema when available.
- In interactive sessions, prefix the agent description with `<model>:` and have the wrapper end with one fenced report block.
- Run long Codex or Pi work in the background and poll its report when the host timeout is short.

## Isolation

Parallel Codex, Pi, or Claude implementers use worktrees. The wrapper reports the worktree path and never merges or commits unless explicitly authorized.
