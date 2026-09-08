# Generation footer

Render every review reply with `scripts/render-review-reply.py`. The renderer always appends a footer and chooses model information in this order:

1. Pass metadata exposed for the current session or turn with `--session-info`.
2. Otherwise, pass a model or effort label explicitly supplied by the user with `--user-provided-info`. The renderer marks it `user-provided`.
3. Otherwise, omit both options. The renderer uses `Codex`.

Build one concise, human-readable label from the fields that are available. Omit unavailable fields. Never infer model details or stop publication because metadata is unavailable.

```sh
scripts/render-review-reply.py \
  --body-file /tmp/reply.md \
  --session-info "GPT-6 Astra · reasoning effort: high"
```
