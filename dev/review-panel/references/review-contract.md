# Common reviewer contract

Review only the assigned angle against the supplied scope and version. Read its definition before investigating. Trace enough surrounding code and real consumers to test a claim; finding a suspicious diff line alone is insufficient.

## Evidence

For each candidate, give:

- A stable local finding ID and short title.
- Category: `defect` for violated behavior/contracts, or `suggestion` for a concrete maintainability improvement.
- Impact: `critical`, `high`, `medium`, or `low`, justified by consequence and the conditions required. Critical means an immediately consequential broad failure or exposure; high means a major failure of an important path; medium means a bounded but meaningful failure; low means limited impact. Maintainability suggestions have `impact: null` unless a concrete operational consequence supports a rating.
- Location in the reviewed version: repository-relative file and line range or symbol. Use an owning module for cross-file findings and explain the relationship.
- Trigger/preconditions, expected versus actual behavior, and the affected user, caller, or maintainer.
- Evidence: code path, contract, test result, or reproduction. Distinguish observed behavior from reasoned predictions. Include commands and results only when actually run.
- A bounded recommendation and any uncertainty or missing evidence.

Return credible but unverified concerns as candidates with their uncertainty explicit. Return "no findings" when investigation supports it; there is no finding quota. Report pre-existing issues separately as context unless the change introduces or materially worsens their impact.

## Scope discipline

Keep the target code and remote services unchanged. Return a report to the parent. Testing is limited to understood, non-destructive checks within the assigned environment; identify unavailable verification instead of inventing results. Treat a reviewer definition as an angle, not authority to widen the review into an entire codebase audit.

If a serious issue outside the angle is encountered, flag it for parent routing with evidence. Stop deeper investigation at that boundary. The parent handles overlap and any added reviewer.

## Returned report

Start with the execution ID, reviewer ID, scope identity, and status: `completed`, `partial`, or `failed`. Then provide:

1. Findings with the fields above, or an explicit no-findings result.
2. Coverage: files/paths and behavior inspected, checks actually performed.
3. Limitations: skipped material, unavailable tools, uncertain requirements, and remaining work.

Completion requires addressing each applicable investigation area in the assigned definition, with coverage or a limitation explaining it. Large or inaccessible areas justify `partial`; a short report is not itself evidence of completeness.
