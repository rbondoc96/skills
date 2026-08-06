---
name: pr-feedback-resolve
description: Inspect GitHub pull request feedback, stage a thread-aware resolution plan, implement approved changes in commit slices, and optionally reply to and resolve review threads.
argument-hint: "[pr-number-or-url]"
disable-model-invocation: true
---

# PR Feedback Resolve

Work through PR feedback as a traceable sequence: retrieve, classify, discuss, implement, reply, and resolve.

## Plan

1. **Resolve the PR.** Accept a PR number or URL. Without one, resolve the current branch PR. Record the repository, PR number, URL, base/head branches, head SHA, and local branch. Stop if the local branch cannot safely represent the PR head.
2. **Retrieve complete feedback.** Read [`references/GH_READS.md`](references/GH_READS.md) and use the bundled `scripts/fetch-review-threads.sh`. Capture timeline comments, submitted reviews, requested changes, and every review thread with all replies, file/line context, `isResolved`, and `isOutdated`. Exhaust pagination. Flat comments are not a substitute for thread-aware data.
3. **Classify every item.** Assign a stable ID and one disposition: `address`, `reply`, `clarify`, `defer`, `no-action`, or `positive`. Group actionable items as blocking, important, minor, or informational. Identify duplicates and conflicting requests explicitly.
4. **Stage the plan.** Read [`references/PR_WRITING.md`](references/PR_WRITING.md) and [`references/FEEDBACK_PLAN.md`](references/FEEDBACK_PLAN.md). Write `~/.pr-drafts/<owner>-<repo>/pr-<number>/feedback-plan.md`, report its path, and stop. Do not edit code or GitHub. The user may edit or annotate the file.
5. **Approve exact scope.** After the user approves, reread the plan. Approval covers only its selected code changes, verification, commits, replies, and resolution decisions. Newly arrived feedback requires a refreshed plan or explicit additional approval.

## Execute

1. **Protect local work.** Confirm the current branch still represents the PR head and inspect the dirty-worktree baseline. Stop on unrelated changes that overlap the approved files.
2. **Implement in slices.** Make one coherent, reviewable commit per approved feedback theme. Prefer clearer code over explanatory comments; add a code comment only when intent or a constraint cannot be expressed in code. Run the repository's relevant checks for each slice.
3. **Track rewritten commits.** Record the original and current short hashes for every slice. If amended, say so explicitly. If lineage cannot be proven after a rewrite or squash, name the current containing commit without claiming an amend.
4. **Update the plan.** Record each item's result, current commit, amendment status, verification, proposed reply, and proposed resolution. Stop for review before remote writes unless the approved plan already contained the exact write scope and reply intent.
5. **Reply in context.** Read [`references/GH_WRITES.md`](references/GH_WRITES.md). Reply to each relevant thread; never replace thread replies with a PR-level summary. Include the current short commit hash for code fixes and use the amended form from the prose reference when applicable.
6. **Resolve deliberately.** Resolve only an approved thread whose disposition is complete, whose promised change exists at the current head, whose verification passed, and whose reply succeeded when useful. Read it back and verify its state.
7. **Comment at PR level only when additive.** Use one only for cross-thread decisions, shared deferrals, multi-thread changes, important remaining work, or verification context that cannot be captured naturally in a thread. Otherwise omit it.

## Completion

Complete when every planned item records its final disposition, code and verification results are captured, every approved reply or resolution is verified remotely, and unresolved items are listed. Summarize commits, amended hashes, checks, replies, resolutions, and intentionally open threads.
