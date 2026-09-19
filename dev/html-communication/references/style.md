# Visual contract

Read this for every file this skill produces. It sets the baseline both modes start from.

## Respect the reader's color scheme

Never hardcode a dark page. The user reviews in whatever mode their OS is in, and a forced black background is unreadable in daylight.

```css
:root {
  color-scheme: light dark;
  --surface: light-dark(#ffffff, #0d0d0d);
  --text: light-dark(#18181b, #ededed);
  --text-muted: light-dark(#52525b, #a1a1aa);
  --rule: light-dark(#e4e4e7, #2a2a2e);
  --accent: light-dark(#1d4ed8, #7aa2f7);
}
body { background: var(--surface); color: var(--text); }
```

`light-dark()` requires `color-scheme` on the same or an ancestor element. Both are widely supported; no media query needed. Verify contrast holds in both schemes before publishing, especially for `--text-muted` on `--surface`.

## Typography

- System stack: `ui-sans-serif, system-ui, -apple-system, "Segoe UI", sans-serif`. Monospace for code and identifiers only.
- Base size 15-16px, line height ~1.55.
- Cap prose at ~78ch. Tables, code blocks, and mocks may use the full width.
- The sandbox blocks linked stylesheets, so webfonts cannot load. Name the real font first in the stack with a system fallback, and tell the user which font is being substituted so they do not judge the typography as-rendered.

## Density

Write it like a spec, not a landing page.

- No hero, no marketing voice, no em dashes, no filler copy.
- Information-dense. Lead each section with the conclusion.
- Structure with rules, spacing, and headings. Not shadows, gradients, or rounded panels.
- No decorative card or pill chrome, and no light-gray subtitle line above a section heading.

The chrome ban governs the document's own presentation. Inside a mock, chrome comes from the project's real design tokens and component idiom; see [project-tokens.md](project-tokens.md).
