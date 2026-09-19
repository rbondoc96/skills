---
name: html-communication
description: Use when the user asks to communicate through an HTML document, wants UI mocks or design variants to review, or if they mention "HTML" with no additional context.
---

# HTML communication

Present a plan, spec, write-up, findings, summary, report, comparison, or a set of UI mocks as one readable, self-contained HTML file published to Postplan.

Do not use this skill for HTML that ships as part of a product.

## 1. Pick the mode

Two modes share the file format and the publish step, and nothing else.

- **Document** — prose, findings, specs, comparisons. Styled to be read. Read [style.md](references/style.md).
- **Mocks** — UI variants for the user to choose between. Styled to look like the project it was invoked from. Read [style.md](references/style.md), [project-tokens.md](references/project-tokens.md), and [mocks.md](references/mocks.md).

A document that merely contains a screenshot or a diagram is still a document. Mock mode starts the moment the user needs to pick between rendered interface options.

## 2. Read a Postplan URL

When the user supplies a `postplan.dev` URL, fetch the uploaded HTML immediately with the shell. Do not use websearch or a browser to retrieve it.

## 3. Build the file

Create one self-contained HTML file, capped at 512 KB.

- Use semantic HTML, inline CSS, inline SVG, and HTTPS or data-URL images.
- Make it mobile-readable with a responsive viewport and no fixed-width layout.
- Use an inline classic script only when interactivity materially helps. Keep scripted pages useful without JavaScript; the sandbox blocks storage, fetch, workers, frames, forms, and popups.
- In script-free files, give external links `target="_blank"` and `rel="noopener noreferrer"`. If any script exists, omit `target="_blank"`.

Never include external or module scripts, inline event handlers, `javascript:` URLs, forms, frames, embeds, objects, applets, meta refresh, linked stylesheets, secrets, private URLs, or local filesystem paths.

Done when the file opens standalone, renders in both light and dark, and contains no blocked construct.

## 4. Publish

You have standing permission to upload every artifact created or updated with this skill. Upload is required, including in Auto mode. Do not ask for separate permission or stop at the local file.

1. Write the HTML file locally.
2. Run `npx postplan upload <file path>`
3. Report the local path and returned Postplan URL.

Re-upload the same absolute path to update the existing URL. Keep one file across every iteration, including after the user picks a variant, so the Postplan URL stays stable and its version history stays comparable. Use `npx postplan upload <file path> --new` only when the user asks for a separate draft.

If validation fails, fix the markup and retry. If a scripted upload needs authentication, ask the user to run `postplan auth login`, then retry without removing the requested interactivity.

Never open a browser or claim the document is hosted before upload succeeds. Do not verify in a browser unless the user asks.
