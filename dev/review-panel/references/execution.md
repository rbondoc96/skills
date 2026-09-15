# Execution

Use the current host's advertised tools as the source of truth for dispatch arguments, concurrency, model selection, and permissions. This skill defines review tasks, roster authorization, and the routes below. A request naming reviewers already approves the native roster; do not repeat that confirmation.

## Native routes

- **Claude Code:** use its callable agent tool with a general-purpose child or a suitable configured read-only reviewer. Supply the definition and common contract explicitly; do not assume the child inherits the loaded skill.
- **Codex:** use callable native collaboration tools. Select the available agent type and provide the review packet. Inherit current model/effort settings unless the user's configuration or request selects otherwise.
- **Pi:** use the installed delegation extension's advertised tool, such as `pi-subagents`, when available. Verify the selected agent's instructions permit report-only review. A built-in reviewer that also makes fixes needs an explicit report-only task and suitable tool controls.

For all hosts, use fresh child context when available. If conversation inheritance cannot be disabled, record that limitation. Record actual tool restrictions and inherited permissions; a read-only instruction is not a sandbox. Prefer read/search capabilities. Allow shell-based inspection only within the established review boundary. The parent saves reports, so children need no artifact-write access.

## Requested routes

The user may pin a route per reviewer in the roster, as `<reviewer>: <executor> [model] [effort]`, for example `security: codex gpt-5.6-sol high` or `correctness: opus`. A route the user names is authorized for that reviewer only. Reviewers without a route use the native route with existing configuration. Ask before substituting when a requested model or executor is unavailable; never downgrade silently.

- **Same host, different model or effort:** pass the native tool's model or effort parameter. Record the observed identity in the execution entry.
- **Different harness:** run the CLI recipe below from the reviewed repository, with the full packet in a prompt file. Inline the reviewer definition and contract; a foreign process cannot be assumed to read this skill's files. Save stdout as the report and set `executor` to the CLI name, `context_mode` to `fresh`, and `permission_controls` to the flags actually used.

Cross-harness runs are provider-independent only when the model provider differs; record the provider, not the product name.

### `claude -p` read-only

```bash
args=(claude --no-session-persistence --permission-mode plan --tools "Glob,Grep,Read" --model "$MODEL" -p "Read $PROMPT and review the repository as instructed. Do not modify files.")
[[ "$EFFORT" != "default" ]] && args=(claude --effort "$EFFORT" "${args[@]:1}")
(cd "$WORKDIR" && "${args[@]}") > "$REPORT"; status=$?
```

### `codex exec review` read-only

Select exactly one target: `--base <ref>`, `--commit <sha>`, or `--uncommitted`. Translate the established scope into that target before running.

```bash
args=(codex --ask-for-approval never --cd "$WORKDIR" --sandbox read-only exec review --base "$BASE" --ephemeral --model "$MODEL" --output-last-message "$REPORT" -)
[[ "$EFFORT" != "default" ]] && args=(codex --ask-for-approval never --cd "$WORKDIR" --sandbox read-only exec review --base "$BASE" --config "model_reasoning_effort=\"$EFFORT\"" --ephemeral --model "$MODEL" --output-last-message "$REPORT" -)
"${args[@]}" < "$PROMPT"; status=$?
```

Preserve `status` in the execution entry. A non-zero exit with partial output is a `partial` or `failed` execution, never a clean review.

## Missing capabilities and failures

If delegation is unavailable, explain the limitation and propose sequential passes in the parent or one of the CLI recipes above. Wait for the user's choice before changing the execution mode. Sequential passes share context and must be labeled `parent-sequential`. Do not install extensions or launch another harness automatically.

Keep an unavailable reviewer explicit. On execution failure, preserve its output and error. Follow an already approved retry/fallback if one exists; otherwise propose the next attempt.

Use the current runtime's controls rather than reproducing CLI flags or custom-agent manifests beyond the recipes here. Harness configuration belongs in the user's configuration repo.
