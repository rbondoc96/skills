# PR writes

For every mutation, resolve the exact repository and PR, capture current state, show the proposed mutation, obtain applicable approval, execute it, and read it back.

## PR body

Write an approved file without shell interpolation:

```bash
gh pr edit <number> --repo <owner>/<repo> --body-file <path>
```

Read `body` back and compare it with the file.

## PR-level comment

Use `gh pr comment <number> --repo <owner>/<repo> --body-file <path>`. Post only when the calling workflow has decided a PR-level comment adds context that does not belong in a thread.

## Review-thread reply

Use the thread node ID and a body file. The helper uses `addPullRequestReviewThreadReply` and verifies the returned comment ID, URL, and body:

```bash
scripts/reply-review-thread.sh <thread-node-id> <body-file>
```

The calling workflow owns confirmation. This script performs the mutation immediately.

## Resolve or reopen a thread

Resolve with the thread node ID. The helper uses `resolveReviewThread` and verifies the returned thread ID and `isResolved` state:

```bash
scripts/resolve-review-thread.sh <thread-node-id>
```

The calling workflow owns confirmation and any policy requiring a successful reply first. This script performs the mutation immediately. Use GraphQL `unresolveReviewThread` directly when an approved workflow needs to reopen a thread. Resolution never substitutes for a reply.

## Submit a review

Use one explicit state:

```bash
gh pr review <number> --repo <owner>/<repo> --comment --body-file <path>
gh pr review <number> --repo <owner>/<repo> --approve --body-file <path>
gh pr review <number> --repo <owner>/<repo> --request-changes --body-file <path>
```

Require fresh confirmation immediately before `--approve` or `--request-changes`. Verify the submitted review and its state afterward. Never approve the authenticated user's own PR or proceed when GitHub reports that the actor is ineligible.
