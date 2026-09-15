# Review records

The parent owns all artifact writes. Default to `~/.code-reviews/<repo-name>/<UTC-timestamp>-<random-suffix>/`, outside the reviewed worktree. Honor a user-specified location. Create a unique run directory without overwriting an earlier run. If that location is unavailable, request an accessible location and disclose any unsaved output; never claim persistence without it.

## Files

- `context.md`: target, baseline/head IDs, intended behavior and its source, scope inclusions/exclusions, changed files, and relevant project constraints.
- `run.json`: machine-readable execution metadata described below.
- `reviewers/<execution-id>.md`: each child's returned report, including partial results. Preserve original reports after consolidation. A retry gets a new execution ID.
- `decisions.json`: one entry per candidate finding, including unresolved candidates.
- `report.md`: combined findings, suggestions, unresolved concerns, coverage, and links to original reports.

Save the review context, not credentials or full environment dumps. Reference source files instead of copying entire repositories or raw traces. Reviewer findings should avoid reproducing secrets.

## Snapshot identity

Record the repository path, target type, resolved baseline/head IDs, and any PR identifier. For immutable targets, reviewers must read content from those revisions. For working changes, record a fingerprint of the relevant staged/unstaged diff, selected file contents, and included untracked files. Include any out-of-diff files a finding relies on in the final consistency check. A staged review must read index content when the working file differs.

Use content hashes and explicit scope, not timestamps alone. Capture hashes when additional supporting files are first read, then verify them and the original fingerprint after review. Record `snapshot_status` as `unchanged`, `changed`, or `unverified`; only unchanged coverage can support a complete result. If a snapshot or comparison is incomplete, state the missing material.

## Run metadata

Write `run.json` with `schema_version: 1` and these fields:

- `run_id`: the unique run directory name. `started_at` and `finished_at`: UTC ISO 8601 times; unfinished time is null.
- `repo`, `scope`: repository path and the target/baseline/head/fingerprint information above.
- `snapshot_status`, `status`: run status is `running`, `completed`, `partial`, or `failed`.
- `roster_authorization`: `named`, `confirmed-proposal`, or `unconfirmed-proposal` for a non-interactive run, with the selected reviewer IDs and the user's approving instruction summarized. Record additions separately when authorization differs.
- `executions`: array with `execution_id`, `reviewer_id`, `attempt`, `status`, `host`, `executor`, `model`, `effort`, `provider`, `native_agent_id`, `context_mode`, `permission_controls`, `started_at`, `finished_at`, `report_path`, `error`, and `telemetry`.

Execution status is `queued`, `running`, `completed`, `partial`, `failed`, `skipped`, or `stale`. `executor` is `native` or the CLI name used for a requested route. `context_mode` is `fresh`, `inherited`, or `parent-sequential`. Use null for unavailable metadata; record observed model/provider identity rather than inferring it from a product name. Store paths relative to the run directory.

`telemetry` is null when unavailable. When the runtime supplies it, preserve reported duration, token usage, and cost together with units and the source of each metric. Keep missing values null, not zero. These records support later observability; they do not imply that every host exposes traces or cost.

## Finding decisions

Each `decisions.json` array entry contains `finding_id` qualified by execution ID, `disposition`, `reason`, `evidence`, and `combined_finding_id` or null. Disposition is `accepted`, `merged`, `dismissed`, or `unresolved`. Merged findings point to the same combined finding. State why a candidate was dismissed, including a disproven assumption or existing protection. Unresolved concerns remain in the combined report.

## Final report

Lead with verified defects by impact. Follow with suggestions, unresolved concerns, and a concise coverage statement naming completed, missing, partial, or stale reviewers. Include exact scope/version and links to individual reports and decision records. Distinguish no verified defects from complete coverage. Evidence-supported findings survive even when another reviewer fails, but overall status remains partial.

A run is completed only when every selected reviewer completed against unchanged scope and every candidate has a disposition. Use failed when no usable review completed and partial for mixed, incomplete, or stale coverage. This is execution status, not a judgment that the change is safe.
