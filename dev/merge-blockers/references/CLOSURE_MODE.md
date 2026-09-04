# Closure mode

Read this when a PR is heading to merge or review rounds are accumulating. Its purpose is to stop the review loop from running forever once no finding meets the merge-blocker bar.

## Count reviewed heads

Count independent reviews of distinct head SHAs from fresh GitHub data:

```bash
scripts/count-reviewed-heads.sh <owner> <repo> <pr-number>
```

The script lives in `$gh-pr`. It reports the number of unique head commits reviewed by someone other than the PR author, the latest reviewed head, and whether the current head has been reviewed. Automated reviewers count. Author comments, thread replies, pending reviews, and repeated reviews of the same commit do not.

Never infer the count from thread totals, comment volume, elapsed time, or local history.

## Enter closure mode

Default threshold: three reviewed head SHAs. Enter closure mode at the threshold, or whenever the user says to draw the line, close review, or prepare to merge.

The threshold is a default, not a fixed rule. State it when you apply it and accept a different number from the user for the project at hand.

## Rules in closure mode

1. Recommend no further general full-PR review.
2. Address only findings that meet the merge-blocker bar.
3. Defer every non-blocker to a named follow-up scope. Implement one during stabilization only when the user explicitly chooses to.
4. Review only the unreviewed delta after the latest blocker fix.
5. A narrow fix with direct regression coverage and passing required checks may merge without another independent review.
6. A non-blocking finding or fix does not reset the review count.
7. Exit closure mode when a new concrete blocker appears.

## Recommending another review

Outside closure mode, recommend a focused re-review only when the unreviewed change materially affects behavior and existing tests do not cover the risk.

In closure mode, default to no further review. Recommend one blocking delta review only when all three hold:

- the fix crosses a high-cost boundary: durable data, migrations, security boundaries, concurrency, irreversible actions, or a public contract;
- focused regression coverage and direct tracing cannot adequately validate the behavior;
- another reviewer has a specific risk to evaluate.

Crossing a high-cost boundary alone does not require another review. Never recommend one solely because the head SHA changed.

## Merge-ready

A PR is merge-ready when:

- no known finding meets the merge-blocker bar;
- unresolved threads are zero or intentionally open with an approved disposition;
- required checks pass;
- local and remote heads match;
- no approved write remains unfinished.

Report the reviewed-head count, whether the current head was reviewed, whether closure mode applies, and whether the PR is merge-ready.
