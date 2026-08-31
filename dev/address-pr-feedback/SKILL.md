---
name: address-pr-feedback
description: Address unresolved GitHub pull request review threads, make focused local commits, and publish approved fixes, replies, and resolutions.
argument-hint: "[pr-number-or-url]"
disable-model-invocation: true
---

# Address PR feedback

Address unresolved review threads on one non-stacked PR. Do not include PR-level comments or submitted review summaries.

## Prepare

1. **Resolve the PR.** From the current branch, run `gh pr view --json url,number,headRefName,headRefOid,baseRefName` and use its canonical `url`. If the user supplied a PR URL or number, pass it to `gh pr view` as an escape hatch. Record the local branch and confirm it represents the PR head. Stop if the PR is ambiguous or the branch cannot safely represent its head.
2. **Reject stacked branches.** If `gh stack` is installed, inspect the active stack with `gh stack view --json`. If the current branch belongs to a stack, stop before implementation and direct the user to `$address-stack-feedback`. Do not rebase, edit, commit, push, reply, or resolve through this skill.
3. **Require `rcache`.** Stop with installation guidance if `rcache` is unavailable. Do not fall back to broader GitHub reads.
4. **Load unresolved threads.** Run:

   ```bash
   rcache show <canonical-pr-url> --refresh --view review --json
   ```

   Work only from unresolved review threads in this result. Preserve each thread node ID, full conversation, path and line context.

## Implement locally

1. Classify each thread as `address`, `reply`, `clarify`, `defer`, or `no-action`. Identify duplicates and conflicts.
2. Inspect the dirty-worktree baseline. Preserve unrelated changes and stop when they overlap required edits.
3. Make the selected changes, run relevant checks, and create focused local commits. No plan artifact or pre-implementation approval is required.
4. Draft one reply per thread that needs a response. Read [`references/PR_WRITING.md`](references/PR_WRITING.md). Usually use one or two sentences. Use bullets only for three or more distinct points.
5. Render each complete reply with `scripts/render-review-reply.sh`. Pass the exact model ID, control name, and value supplied by the host. The script formats metadata but does not discover it. If the host does not expose exact metadata, stop before publishing replies rather than guessing.

## Confirm the remote phase

Immediately before any remote write, show the user:

- Exact remote and branch ref that will be pushed, plus the local commit and expected remote head
- Each thread ID with its complete proposed reply
- Which threads will be resolved and which will remain open
- Checks run and their results

Ask once for explicit confirmation of the combined push, reply, and resolution phase. Confirmation covers only those listed writes. Refresh and ask again if the push target, reply text, resolution decision, or relevant local commits change. Leave feedback that arrives after confirmation untouched.

## Publish

After confirmation:

1. Push the confirmed branch and commits. Verify the remote head equals the confirmed local head. Stop before GitHub mutations if the push or verification fails.
2. Read [`references/GH_WRITES.md`](references/GH_WRITES.md). Reply with its canonical review-thread helper and verify the returned comment. Stop that thread on failure.
3. Resolve a confirmed thread only after its reply succeeds. Use the canonical resolution helper and verify `isResolved` is `true`. A reply-only or intentionally open thread stays open.
4. Run the same `rcache show <canonical-pr-url> --refresh --view review --json` command. Report unresolved threads, including any new or intentionally untouched feedback. Do not act on it without a new confirmation cycle.

## Completion

Complete when the pushed head is verified, every confirmed reply and resolution is verified, and the final refreshed unresolved-thread list is reported. Summarize commits, checks, replies, resolutions, and intentionally open or newly arrived threads.
