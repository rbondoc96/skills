---
name: html-communication
description: Create and publish HTML reports, visual explainers, and UI mock variants. Use when the user requests an HTML communication artifact, a visual report or explainer, or interface options to review.
---

# HTML communication

Present a plan, spec, write-up, findings, summary, report, comparison, or a set of UI mocks as one readable, self-contained HTML file delivered to the selected destination.

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

## 2. Choose the destination

Honor the requested destination: Postplan, an available artifact host, or a local file. Standing permission covers Postplan uploads of content without confidential or client data; use it as the default for that content. Before an external upload, inspect the content for client information, customer identifiers, internal hostnames, and other sensitive material. Reuse existing authorization that covers the content and destination; otherwise prepare the local file and ask before uploading, naming what would be shared and where.

When using Postplan or reading a supplied `postplan.dev` URL, read [Postplan delivery](references/postplan.md). For another host, verify its current limits and available delivery tools before building. If the destination is unavailable, report the limitation and provide the local file; changing hosts requires authorization.

Done when the destination and its build constraints are known. An unresolved sharing decision blocks upload, not local preparation.

## 3. Build the file

Create one self-contained HTML file within the selected destination's limits.

- Use semantic HTML, inline CSS, inline SVG, and HTTPS or data-URL images.
- Make it mobile-readable with a responsive viewport and no fixed-width layout.
- Use scripts only when interactivity materially helps and the destination supports them. Keep pages useful without JavaScript.

Keep secrets, private URLs, and local filesystem paths out of the delivered file. Inline styles and local dependencies for portability; apply additional restrictions from the destination's delivery guidance.

Before publishing, check:

- Every finding, number, status, and qualification agrees with its source. Missing evidence is visible; illustrative data is labeled.
- Supporting notes sit beside the relevant content on wide screens and immediately after it on narrow screens. Essential warnings remain in the main flow.
- IDs are unique, anchors and SVG references resolve, and all local markup and CSS dependencies are embedded.
- The layout supports light and dark themes, narrow screens, keyboard navigation, and readable diagrams without page-wide overflow.
- The file contains no blocked construct and is within the size limit.

Inspect markup and styles by default. If browser verification was requested, inspect wide and narrow layouts in both themes. Report unverified visual behavior rather than claiming a browser check.

## 4. Deliver

Write the file locally, then deliver it using the destination and authorization established in step 2.

For local delivery, report the file path. For hosted delivery, report the local path and the returned public URL only after delivery succeeds. Keep the same file and stable public URL across revisions where the host supports updates. Share section links from that public URL, checking that anchors work on the host.

Done when the requested delivery succeeds, or the local file and a specific authorization or delivery blocker are reported. Open or verify in a browser only when the user asks.
