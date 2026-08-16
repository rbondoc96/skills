---
name: file-linear-issue
description: File an issue in Linear. Use when the user asks to file, open, or create an issue in Linear.
---

# File Linear Issue

Use this skill when the user wants to file an issue in Linear.

Before filing, check whether a similar issue already exists. Use the Linear CLI (`linear`). If it's not installed, stop and state that.

Delegate creation and edits to a subagent set to a cheaper model. By default, use Sonnet on Low effort if you're Claude or GPT 5.6 Luna on High if you're GPT.

## Workflow

1. Gather the request's goal, relevant context, and any supplied sources. Infer the team, project, labels, and assignee only when the available context makes them clear. Ask for missing information only when it would materially change where or how the issue is filed.
2. Search Linear for open or recently closed issues with the same goal. If a likely duplicate exists, show it to the user instead of creating another issue unless they explicitly want a new one.
3. Draft the title and body using the rules below. Include only sections that carry useful context.
4. Review the draft for unsupported assumptions, hidden decisions, vague acceptance criteria, and unnecessary implementation detail. Resolve safe facts from the repository or linked sources; record meaningful unknowns under `Questions`.
5. Create the issue with the available Linear integration, preferring the CLI (`linear`) if available. Preserve the drafted Markdown structure and apply only metadata supported by the request or discovered context.
6. Return the issue ID, title, and link. Mention any important metadata left unset or ambiguity retained in the issue.

## Title

Write one clear, concise sentence fragment that names the desired outcome or user-visible problem. Follow the team's established title conventions when they exist.

## Body

Open with a short summary in plain language. State:

- The problem or opportunity
- Desired outcome
- Why the work matters and the value it provides

Then add `## Acceptance Criteria` with observable, testable bullets that define done. Describe required outcomes and behavior, not a checklist of implementation tasks.

Read [EXAMPLES.md](references/EXAMPLES.md) before drafting. Use its bad/good comparisons to calibrate the title, summary, acceptance criteria, scope, and level of implementation detail.

Select the closest template and read it before drafting. Adapt it to the issue and omit sections that do not add useful context.

| Issue type | Template | Use when |
| --- | --- | --- |
| Product or system change | [CHANGE.md](references/CHANGE.md) | Delivering a new feature or changing existing behavior |
| Bug | [BUG.md](references/BUG.md) | Correcting behavior that is broken or inconsistent with expectations |
| Investigation | [INVESTIGATION.md](references/INVESTIGATION.md) | Reducing uncertainty before a solution or implementation issue can be defined |

Add these sections only when applicable:

- `## Constraints` for requirements that limit valid solutions
- `## Affected Areas` for known product, service, package, or workflow scope
- `## Out of Scope` for tempting adjacent work that is intentionally excluded
- `## Questions` for unresolved decisions or ambiguities
- `## Sources` for links to supporting issues, documents, discussions, code, or external references
- `## Notes` for other concise context that does not warrant a dedicated section

For a reproducible bug, also add:

- `## Steps to Reproduce` with the shortest reliable numbered sequence
- `## Environment` with only the versions, platform, account state, configuration, or frequency relevant to the failure

## Writing rules

- Use simple, concise, and direct language and short sections. See [LANGUAGE.md](references/LANGUAGE.md) for guidance.
- Keep the issue self-contained enough to understand and verify.
- Match certainty to the evidence. Put unresolved details in `Questions` rather than inventing them.
- Keep design explorations, architecture decisions, implementation plans, and step-by-step guides in a linked Linear document. Summarize only the context needed to understand the issue.
- Use a general `Notes` section instead of several thin optional sections.
- Omit empty sections and placeholder text.
