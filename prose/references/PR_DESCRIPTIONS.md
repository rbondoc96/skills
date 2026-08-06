# PR descriptions

Write for a technical reviewer using simple, concise language. Retain established technical terms when they are more precise than a plain-language substitute. Explain only unfamiliar terms needed to understand the change, using a short footnote when an inline definition would interrupt the summary.

## Voice

- Lead with user-visible or system-visible outcomes.
- Use short sentences and one idea per bullet.
- Use precise repository terminology consistently.
- Keep identifiers, filenames, commands, branches, and values in backticks.
- Avoid vague claims such as "enhanced" or "improved" without naming the change.
- Summarize intent and behavior, not the diff file by file.
- Preserve the repository's PR template and useful user-authored context.

## Footnotes

- Define a term only when it is necessary and unfamiliar to the likely reviewer.
- Use GitHub Markdown footnotes such as `[^retry-budget]` at first use.
- Keep each definition to one sentence and collect definitions after the final section.
- Use no more than three unless the change genuinely introduces a vocabulary-heavy domain.
- Link project documentation when a useful explanation needs more than one sentence.
- Do not define standard engineering terms or terms already explained in linked project documentation.

## Final pass

- Remove every em dash.
- Remove empty sections and repeated claims.
- Confirm every factual claim is supported by the diff, issue, docs, or recorded verification.
- Cut one more time without changing meaning.
