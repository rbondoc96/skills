# Reusable presentation components

Read this when building a report or explainer. Start with the approved composition, then select the pieces that carry this document's meaning.

## Source assets

- [components.html](../assets/components.html): a complete, fictional retry readout with copyable semantic HTML and inline SVG. Read the relevant section before reusing its markup. It demonstrates progression, adjacent notes, explicit statuses, compact evidence, responsive contents navigation, and optional guided links together.
- [document.css](../assets/document.css): authoritative styles for that example, including light/dark tokens and responsive layout. Read before adapting the layout or theme.

These are authoring assets. The example links its sibling CSS so the source remains maintainable. For delivery, copy the selected markup into the artifact and inline the stylesheet in `<style>` in place of the linked stylesheet. Replace the title, example content, labels, and identifiers. Publish only the resulting standalone file, subject to `SKILL.md`.

Keep project-specific evidence and content outside the skill assets. Escape inserted text and attributes; allow intentional markup only through a controlled rendering boundary. If using a generator, keep evidence extraction separate from presentation and fail clearly when required sections are missing. Do not parse arbitrary Markdown with ad hoc regular expressions or silently substitute empty data.

## Choose the component

| Need | Example selector | Adaptation |
|---|---|---|
| Finding and its scope | `.finding` | Keep the claim and decision-changing limits together. |
| Observed, proposed, or unresolved state | `.status` | Use explicit text. Choose color by meaning; the base example is an adverse observation, not a universal default. |
| Explanation with nearby context | `.reading-row`, `.margin-note` | Pair each passage with its own note; omit the two-column wrapper when no note is needed. |
| Causal progression | `.chapter`, `.step-list` | Match the step count and grid to the actual sequence; the sample has three steps, not a required count. |
| Comparison data | `.table-wrap` | Preserve captions, header associations, units, and denominators. Align numeric columns. |
| Implementation detail | `.code-head`, `pre > code` | Keep code copyable and whitespace intact. Use text or diff markers as well as color to identify changes. |
| Interaction sequence | `figure`, `.diagram` | Adapt lane positions and arrow labels together. Keep the text explanation and caption. |
| Supporting evidence | `details > summary` | Give the summary a meaningful label. Keep decisive facts outside collapsed content. |
| Decision or next action | `.next-step` | State the action and any precondition that affects proceeding. |

For one record, use a semantic `dl` rather than a comparison table. For dense tables, first remove irrelevant columns or split by the reader's question. Use stacked labeled records when readers inspect individual entries; retain a table when cross-row comparison matters. Keep horizontal scrolling inside the data region and make it keyboard-reachable.

## Navigation

Prefer a sticky contents sidebar for substantial reports readers will revisit. The example's `.document-layout` keeps the contents on the left and the document on the right. Its single `.section-nav` becomes a wrapping top navigation on smaller screens; links and targets remain identical.

For short documents with a few peer sections, add `top-navigation` to `.document-layout` to use top navigation at every width. Remove `with-contents` from `.shell` to restore the ordinary document width when a rail is unnecessary. Top navigation stays in normal flow so wrapping labels cannot cover the heading the reader jumps to.

Use `.step-nav` after major sections when progression helps. It works with either contents pattern or on its own. Link to actual preceding and following sections, label the destination, and give the first and final sections sensible overview links. All content remains visible; these links move through the document rather than paginate or hide it.

- Copy the navigation and its corresponding section IDs together. Keep IDs stable during revisions so shared section links survive.
- Use a labeled `nav`, descriptive anchors, visible keyboard focus, and a skip link past repeated navigation. The example makes section targets programmatically focusable with `tabindex="-1"`.
- Give the reading column room before adding a third column for nearby notes. The stylesheet moves notes below their passage at intermediate widths and converts the rail to top navigation at narrow widths. Check the fit again when changing labels, note widths, or page padding.
- Keep native anchors as the foundation. Active-section highlighting is optional enhancement; set `aria-current="location"` only when it reflects the actual current section. The static example does not invent a current state.
- Omit navigation for a short artifact where it adds no useful wayfinding. Guided links are optional even when a contents map is present.

The selectors and responsive thresholds live in `document.css`; adapt them to content rather than treating them as universal device categories.

## Diagram construction

The sequence example supplies accessible markup, lanes, lifelines, arrows, and theme-aware labels. Copy those mechanics rather than rebuilding them each time.

- Give every diagram title and marker a document-unique ID and update `aria-labelledby` and `url(#...)` references together.
- Keep text inside the viewBox. Increase spacing, wrap labels with `tspan`, or divide a long sequence into phases rather than shrinking text to fit.
- Use CSS grid and semantic lists for simple step or ownership layouts. Use SVG for relationships that need connecting geometry. For larger graphs, a build-time renderer may produce inline SVG; the final artifact must satisfy the publishing contract without runtime libraries.
- Preserve a minimum readable diagram width with a labeled, focusable scroll region on narrow screens. Prefer a simpler vertical composition when scrolling would hide the relationship being explained.
- State the diagram's meaning in its accessible title and nearby explanation. Use the caption for a qualification the picture cannot convey.

## Interaction and verification

The example's disclosure sections work without JavaScript. Add scripts only when interaction materially improves understanding, following the explainer reference and publishing restrictions.

Check both the composition and the components: a nearby note should follow its related content in DOM order, status meaning should survive removal of color, and wide code or diagrams should not widen the whole page. Reusing the example does not establish that new labels or larger datasets fit. Apply the completion checks in `SKILL.md` to the final artifact.

## Design inspiration

When revising the visual language or adding patterns, read [inspiration.md](inspiration.md) for the sources behind this composition, what we borrowed, and when to revisit each.
