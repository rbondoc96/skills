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

Reply to the top-level review comment, not to another reply:

```bash
gh api --method POST \
  repos/<owner>/<repo>/pulls/<number>/comments/<comment-database-id>/replies \
  -F body=@<path>
```

Read the returned comment or thread back and verify the body and author.

## Resolve or reopen a thread

Use the GraphQL `resolveReviewThread` or `unresolveReviewThread` mutation with the thread node ID. Verify the returned and subsequently queried `isResolved` state. Resolution never substitutes for a reply.

## Submit a review

Use one explicit state:

```bash
gh pr review <number> --repo <owner>/<repo> --comment --body-file <path>
gh pr review <number> --repo <owner>/<repo> --approve --body-file <path>
gh pr review <number> --repo <owner>/<repo> --request-changes --body-file <path>
```

Require fresh confirmation immediately before `--approve` or `--request-changes`. Verify the submitted review and its state afterward. Never approve the authenticated user's own PR or proceed when GitHub reports that the actor is ineligible.
