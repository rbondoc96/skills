---
name: gh-pr
description: Read and mutate GitHub pull requests through the gh CLI, including metadata, diffs, checks, comments, reviews, review threads, replies, resolutions, and submitted reviews. Use when an agent needs reusable GitHub PR CLI mechanics or complete thread-aware PR data.
---

# GitHub PR CLI

Own GitHub transport mechanics, not review judgment. Prefer native `gh pr` commands; use `gh api` for thread topology and operations without a native command.

## Workflow

1. **Authenticate.** Run `gh auth status`. Stop with a precise authentication or permission error when access is unavailable.
2. **Resolve the target.** Accept a URL, number plus repository, or current-branch PR. Record `owner`, `repo`, number, URL, base/head branches, base/head SHAs, and authenticated login. Never rely on an implicit repository after resolving these values.
3. **Choose the operation.** Read [`references/READS.md`](references/READS.md) for metadata, diffs, checks, comments, reviews, or threads. Read [`references/WRITES.md`](references/WRITES.md) before any remote mutation.
4. **Exhaust the operation.** Paginate collections, preserve stable IDs and URLs, and distinguish timeline comments, submitted reviews, inline comments, and review threads. A flat comment list is never a complete thread representation.
5. **Verify writes.** Read the exact target back and compare the intended fields or state. Report partial success precisely; never imply that an unverified mutation succeeded.

## Boundaries

- Reads need no confirmation unless repository instructions require it.
- Show the exact target and intended change before writing. Obtain explicit approval for PR body edits, comments, replies, thread resolution, or review submission unless a calling workflow already has explicit approval for that exact mutation.
- Obtain fresh confirmation immediately before approving or requesting changes. General permission to "handle" a PR does not authorize either review state.
- Do not decide whether feedback is valid, code is correct, an issue is complete, or a PR deserves approval. Return evidence to the calling workflow or user.
- Treat merge, close, reopen, and destructive operations as out of scope.

Complete when every requested read is paginated and identified, or every approved write is read back and verified.
