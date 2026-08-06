# PR summary template

Use this order. Keep required sections and omit empty conditional sections.

```markdown
<!-- pr-summary:start -->
## Summary

- <Most important outcome and why.>

## Linear

- Resolves ABC-123.
- Contributes to ABC-234.

## Acceptance Criteria

### ABC-123

- [x] <Criterion from the issue.>
  - <How this branch meets it.>
- [ ] <Unmet or out-of-scope criterion.>
  - <What remains and where it is tracked, if known.>

## Changes

### Features

- <Feature change.>

### Fixes

- <Behavioral correction.>

### Documentation

- <Documentation change.>

### Tests

- <Test change.>

## Verification

- `<command>` passed.
- Not run: <reason>.

## <Design | Request Flow | Behavior Changes>

<Small Mermaid diagram or Markdown table when materially useful.>

## Notes

- <Migration, compatibility, rollout, dependency, or reviewer context.>

[^term]: <One-sentence definition.>
<!-- pr-summary:end -->
```

## Rules

- Always include `Summary` and `Verification`.
- Include `Linear` for every confidently associated issue. Use one relationship statement per issue.
- Include `Acceptance Criteria` only when an associated issue states explicit criteria. Preserve their wording, apart from light formatting cleanup.
- Mark a criterion complete only when repository and verification evidence support it. Keep unmet or out-of-scope criteria unchecked.
- Include `Changes` when at least one subsection has content. Keep non-empty subsections in this order: Features, Fixes, Documentation, Tests.
- Use a contextual heading for an optional visual; never use `Visuals`.
- Include `Notes` only for context a reviewer needs.
- Keep footnote definitions after the final section and before the closing marker.
- When an existing managed block exists, replace it. Never create a second block.
- When there is no managed block, preserve the existing body and repository template, then place the block where it best fits.
