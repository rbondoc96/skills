---
name: address-stack-feedback
description: Address unresolved review threads for one pull request in a gh-stack, rebase affected descendants, and publish approved stack updates, replies, and resolutions.
argument-hint: "[pr-number-or-url]"
disable-model-invocation: true
---

# Address Stack Feedback

Address unresolved review threads on one target PR in a locally tracked linear `gh-stack`. Do not include PR-level comments or submitted review summaries. Do not create, restructure, submit, sync, merge, or unstack a stack.

## Prepare

1. **Require a safe Git state.** Require `git`, authenticated `gh`, the official `gh stack` extension, `jq`, and `rcache`. Stop if the worktree is dirty, a Git or `gh stack` operation is in progress, or the push remote is ambiguous. Choose the remote explicitly and record the starting branch.
2. **Resolve the target PR.** From the current branch, run `gh pr view --json url,number,state,headRefName,headRefOid,baseRefName` and use its canonical `url`. If the user supplied a PR URL or number, pass it to `gh pr view` only as an escape hatch. Require the target PR to be open and its head branch to be the current branch.
3. **Capture the stack baseline.** Run `gh stack view --json`. Require the current branch to belong to exactly one linear stack. Record the trunk and every branch's name, base, local head, PR, merge state, queue state, and `needsRebase` value. Record each active branch's remote head with `git ls-remote`.
4. **Reject unsafe starting states.** Treat the target through the stack tip as the affected segment. Stop if an affected branch already needs rebase, an active branch is queued, an expected remote head is missing, or a remote head differs from its local baseline. Require the target PR's `headRefOid` to match both local and remote heads. Do not repair pre-existing stack drift through this skill.
5. **Load unresolved threads.** Run:

   ```bash
   rcache show <canonical-pr-url> --refresh --view review --json
   ```

   Work only from unresolved review threads in this result. Preserve each thread node ID, full conversation, path, and line context.

Read [`references/STACK_OPERATIONS.md`](references/STACK_OPERATIONS.md) before changing the stack.

## Implement locally

1. Classify each target-PR thread as `address`, `reply`, `clarify`, `defer`, or `no-action`. Identify duplicates and conflicts.
2. Change only the target branch's layer. If a fix belongs in an ancestor branch or requires moving commits or restructuring the stack, stop and ask the user to handle that owning PR separately.
3. Run relevant checks and create focused commits on the target branch.
4. If the target gained commits, rebase its affected descendants with the canonical upstack command in `STACK_OPERATIONS.md`. Resolve only clear conflicts. If conflict ownership or intent is ambiguous, abort the whole stack rebase and report the blocker. Skip rebase and push for a reply-only run.
5. Re-run `gh stack view --json`. Require a clean worktree, the expected branch order, and no `needsRebase` value in the affected segment. When a rebase occurred, run relevant checks on the rebased stack tip if the target is not the tip. Record every active branch's before and after commit.
6. Draft one reply per thread that needs a response. Read [`references/PR_WRITING.md`](references/PR_WRITING.md). Usually use one or two sentences. Use bullets only for three or more distinct points.
7. Render each complete reply with `scripts/render-review-reply.sh`. Pass the exact model ID, control name, and value supplied by the host. The script formats metadata but does not discover it. If the host does not expose exact metadata, stop before publishing replies rather than guessing.

## Confirm the remote phase

Immediately before any remote write, refresh the target PR with `rcache` and re-check the stack plus every remote head. Rebuild the preview if feedback, stack membership, local commits, remote heads, reply text, or resolution decisions changed.

Show the user:

- The target PR and explicit remote
- When a push is needed, every active branch `gh stack push` will attempt, including unchanged branches
- Each rewritten branch's old and new commit, plus the expected remote head
- Each thread ID with its complete proposed reply
- Which target-PR threads will be resolved and which will remain open
- Checks run and their results
- A warning that stack push is non-atomic, so some branches may update before another push fails

Ask once for explicit confirmation of the listed remote writes. When a push is needed, this is the combined stack push, reply, and resolution phase. Confirmation covers only the listed writes.

## Publish

After confirmation:

1. If the target gained commits, push with the canonical `gh stack push` command in `STACK_OPERATIONS.md`.
2. After a push, verify every active branch's remote head equals its confirmed local head. If any push or verification fails, stop before all GitHub replies and resolutions. Report every branch's local and remote head. A retry requires a fresh preview and confirmation, including when some branches were already updated.
3. Read [`references/GH_WRITES.md`](references/GH_WRITES.md). Reply only to confirmed target-PR threads with its canonical review-thread helper and verify the returned comment. Stop that thread on failure.
4. Resolve a confirmed target-PR thread only after its reply succeeds. Use the canonical resolution helper and verify `isResolved` is `true`. A reply-only or intentionally open thread stays open.
5. Run the same `rcache show <canonical-pr-url> --refresh --view review --json` command. Report unresolved threads, including any new or intentionally untouched feedback. Do not act on it without a new confirmation cycle.
6. Return to the recorded starting branch if the workflow moved away from it.

## Completion

Complete when every pushed branch head is verified remotely, every confirmed target-PR reply and resolution is verified, and the final refreshed unresolved-thread list is reported. Summarize rewritten branches, commits, checks, replies, resolutions, and intentionally open or newly arrived threads.
