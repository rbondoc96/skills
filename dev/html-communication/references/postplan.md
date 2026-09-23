# Postplan delivery

Read when Postplan is the selected destination or the user supplies a `postplan.dev` URL. Content-sharing authorization belongs to step 2 of `SKILL.md`.

## Read an existing artifact

Fetch a supplied Postplan URL with the shell. Use the uploaded HTML as the source rather than web search or a browser.

## Build for Postplan

Use this skill's Postplan delivery profile:

- Cap the self-contained file at 512 KB. Inline CSS; use inline SVG and HTTPS or data-URL images.
- Use inline classic scripts only. Keep the page useful without storage, fetch, workers, frames, forms, or popups.
- In script-free files, give external links `target="_blank"` and `rel="noopener noreferrer"`. If any script exists, omit `target="_blank"`.
- Exclude external or module scripts, inline event handlers, `javascript:` URLs, forms, frames, embeds, objects, applets, meta refresh, and linked stylesheets.

These constraints apply to Postplan delivery, not to other hosts. If upload validation contradicts this profile, check current Postplan documentation before adapting the file.

## Upload and update

Run `npx postplan upload <file path>` after the artifact passes the checks in `SKILL.md`.

Re-upload the same absolute path to update the existing URL and preserve comparable version history. Use `--new` only when the user requests a separate draft; it creates another artifact rather than updating the existing one.

If validation fails, fix the markup and retry. If a scripted upload needs authentication, ask the user to run `postplan auth login`, then retry without removing the requested interactivity.

Report the returned URL after upload succeeds. If cleanup is requested, verify the currently supported deletion method before acting; do not assume a CLI deletion command exists.
