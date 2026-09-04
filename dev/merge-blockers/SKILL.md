---
name: merge-blockers
description: Triage review findings against the merge-blocker bar and report what blocks merge.
argument-hint: "[pr-number-or-url]"
disable-model-invocation: true
---

# Merge blockers

Assess review findings on one change and report which of them block merge. Use this when no feedback workflow is already running; `$address-pr-feedback` and `$address-stack-feedback` load the same triage rules themselves.

1. **Resolve the target.** Use the findings the user names. For a PR, run `gh pr view --json url,number,headRefName,headRefOid,baseRefName` from the current branch, or pass a supplied number or URL as an escape hatch. Read `$gh-pr` when complete thread-aware data is needed.
2. **Triage.** Read [`references/TRIAGE.md`](references/TRIAGE.md) and apply it to every finding.
3. **Judge the round.** Read [`references/CLOSURE_MODE.md`](references/CLOSURE_MODE.md) when the change is heading to merge, review rounds are accumulating, or the user says to draw the line.
4. **Report and stop.** Present the per-finding blocks from `TRIAGE.md`. Change no code and write nothing to GitHub through this skill. Direct approved fixes to the matching feedback workflow.

## Completion

Complete when every finding carries an evidence-backed disposition, the report states which findings meet the bar and which are deferred with a revisit condition, and nothing has been written locally or remotely.
