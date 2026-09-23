---
name: html-communication
description: Create and publish HTML reports, visual explainers, and UI mock variants. Use when the user requests an HTML communication artifact, a visual report or explainer, or interface options to review.
---

# HTML communication

Present a plan, spec, write-up, findings, summary, report, comparison, or a set of UI mocks as one readable, self-contained HTML file published to Postplan.

Do not use this skill for HTML that ships as part of a product.

## 1. Choose the reader's task

Identify the audience, source material, and what the reader should understand or decide. Infer these from the request when clear.

Read [style.md](references/style.md) for the shared presentation baseline, then select the branch:

| Reader's task | Read |
|---|---|
| Assess findings, evidence, or a proposal | [Reports](references/reports.md) |
| Understand a mechanism, sequence, or change | [Explainers](references/explainers.md) |
| Choose between rendered interface options | [Mocks](references/mocks.md) and [project tokens](references/project-tokens.md) |

A report can contain an explainer; load both references when the explanation needs its own progression. A screenshot or diagram alone does not make a document a mock.

This skill owns presentation and information placement. Use `writing-for-humans` for audience, wording, terminology, and voice when available. Apply explicit artifact instructions; do not infer artifact styling rules from preferences about chat replies. Project UI conventions govern the rendered mocks, not the surrounding communication layout.

For reports and explainers, read [components.md](references/components.md) to choose reusable markup from the approved example and stylesheet. These are starting points, not mandatory sections. When changing the visual language or adding patterns, read [inspiration.md](references/inspiration.md) for the design references and how to use them.

Done when the branch, source material, and reader's intended outcome are clear.

## 2. Read a Postplan URL

When the user supplies a `postplan.dev` URL, fetch the uploaded HTML immediately with the shell. Do not use websearch or a browser to retrieve it.

## 3. Build the file

Create one self-contained HTML file, capped at 512 KB.

- Use semantic HTML, inline CSS, inline SVG, and HTTPS or data-URL images.
- Make it mobile-readable with a responsive viewport and no fixed-width layout.
- Use an inline classic script only when interactivity materially helps. Keep scripted pages useful without JavaScript; the sandbox blocks storage, fetch, workers, frames, forms, and popups.
- In script-free files, give external links `target="_blank"` and `rel="noopener noreferrer"`. If any script exists, omit `target="_blank"`.

Never include external or module scripts, inline event handlers, `javascript:` URLs, forms, frames, embeds, objects, applets, meta refresh, linked stylesheets, secrets, private URLs, or local filesystem paths.

Before publishing, check:

- Every finding, number, status, and qualification agrees with its source. Missing evidence is visible; illustrative data is labeled.
- Supporting notes sit beside the relevant content on wide screens and immediately after it on narrow screens. Essential warnings remain in the main flow.
- IDs are unique, anchors and SVG references resolve, and all local markup and CSS dependencies are embedded.
- The layout supports light and dark themes, narrow screens, keyboard navigation, and readable diagrams without page-wide overflow.
- The file contains no blocked construct and is within the size limit.

Inspect markup and styles by default. If browser verification was requested, inspect wide and narrow layouts in both themes. Report unverified visual behavior rather than claiming a browser check.

## 4. Publish

You have standing permission to upload every artifact created or updated with this skill. Upload is required, including in Auto mode. Do not ask for separate permission or stop at the local file.

1. Write the HTML file locally.
2. Run `npx postplan upload <file path>`
3. Report the local path and returned Postplan URL.

Re-upload the same absolute path to update the existing URL. Keep one file across every iteration, including after the user picks a variant, so the Postplan URL stays stable and its version history stays comparable. Use `npx postplan upload <file path> --new` only when the user asks for a separate draft.

If validation fails, fix the markup and retry. If a scripted upload needs authentication, ask the user to run `postplan auth login`, then retry without removing the requested interactivity.

Never open a browser or claim the document is hosted before upload succeeds. Do not verify in a browser unless the user asks.
