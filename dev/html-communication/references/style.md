# Presentation baseline

Use a clear reading progression, keep related context nearby, and make evidence easy to scan. The approved composition combines those three behaviors; it does not prescribe one page length or a fixed section list.

## Layout and emphasis

- Give the main explanation a readable column. Let comparisons, code, and diagrams use more width when they need it.
- Use headings, spacing, and explicit labels to reveal the structure. Use panels to group related findings, pills for meaningful status, and tables for comparisons.
- Put supporting definitions and qualifications beside their relevant passage. On narrow screens, place each note directly after that passage. Keep correctness-critical conditions and warnings in the main flow.
- Use a contents list when readers need to jump between substantial sections. Keep short explanations direct.
- Treat global chat-format preferences as conversational guidance, not a visual design system. Explicit instructions about the artifact take precedence over this baseline.

## Theme and typography

Support light and dark schemes with semantic CSS variables and an explicit body background. The reusable [document stylesheet](../assets/document.css) provides the starting palette, reading widths, and responsive behavior.

Use a system font stack for portable output. Publishing restrictions are defined in `SKILL.md`; when a project font cannot be embedded or loaded within those restrictions, use a fallback and disclose the substitution for mocks. Verify text, statuses, code, and SVG labels remain legible in both themes. Status meaning must also appear in text.

## Mocks and their surrounding artifact

The artifact supplies navigation, variant labels, commentary, and comparisons. Each rendered mock follows its project's actual tokens and component conventions. Scope mock CSS and tokens to a wrapper so they do not restyle the artifact, or let artifact typography leak into the mock.

Project styling becomes document styling only when the user requests that branding for the document itself.
