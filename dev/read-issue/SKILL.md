---
name: read-issue
description: "Read an issue in Linear or Jira. Use when the user asks to read, fetch, or review an issue in Linear or Jira."
---

# Read Issue

For Linear issues, use the Linear CLI (`linear`). For Jira issues, use the Atlassian CLI (`acli`) or Atlassian MCP. If none of those tools are not installed or available, stop and state that.

Delegate the read to a subagent set to a cheaper model. By default, use Sonnet on Low effort if you're Claude or GPT 5.6 Luna on Low if you're GPT.

Have the subagent return:

- Issue ID/link and a one-line summary
- The issue's goal, desired outcomes, and why it matters
- Acceptance criteria
- Requirements and constraints
- Affected areas (files, packages, services, etc)
- Questions and ambiguities
- Useful sources and references (issue comments, linked issues, pull requests, etc)
