# Stack operations

Use the official `github/gh-stack` extension. Run `gh stack <command> --help` if the installed version differs from these commands.

## Inspect

Always use `gh stack view --json`. The plain command opens an interactive interface.

The JSON baseline must include:

- Stack trunk and current branch
- Ordered branches with `name`, `head`, `base`, `isCurrent`, `isMerged`, `isQueued`, and `needsRebase`
- PR `number`, `url`, and `state` for each branch that has one

## Rebase descendants

From the target branch, align the target and its descendants without fetching or rebasing the trunk:

```bash
gh stack rebase --upstack --no-trunk --remote <remote> <target-branch>
```

If the command exits during a conflict:

1. Inspect the conflict and identify which branch owns each side.
2. Resolve only when the intended result is clear.
3. Stage the resolved files and run `gh stack rebase --continue`.
4. If intent is ambiguous, run `gh stack rebase --abort`. This restores every branch in the rebase operation.

Do not use `git rebase --continue` for a `gh stack rebase` operation.

## Push

Push the stack with an explicit remote:

```bash
gh stack push --remote <remote>
```

An active branch is a non-merged stack branch. This workflow rejects queued branches before publishing.

The push attempts every active branch with per-branch force-with-lease protection. It is non-atomic: an earlier branch can update even if a later branch is rejected. Verify every active remote branch after the command, regardless of its exit status.

Do not run `gh stack sync` as a substitute. It fetches, reconciles, rebases, pushes, and changes stack metadata, which is broader than this workflow's approved remote phase.

## Prohibited commands

Do not run `gh stack modify`, `submit`, `sync`, `merge`, `link`, or `unstack` through this skill. Those commands create or restructure stack state beyond one target PR's feedback.
