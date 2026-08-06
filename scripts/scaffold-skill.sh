#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
skills_root="${SKILLS_ROOT:-$repo_root}"

if [[ ! -d "$skills_root" ]]; then
  echo "Skills root does not exist: $skills_root" >&2
  exit 1
fi

yaml_quote() {
  local value="$1"
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  value="${value//$'\n'/\\n}"
  printf '"%s"' "$value"
}

read -r -p "Skill name (lowercase, numbers, hyphens): " skill_name

if [[ ! "$skill_name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] || ((${#skill_name} > 64)); then
  echo "Skill name must be 1-64 lowercase letters, numbers, or single hyphen-separated words." >&2
  exit 2
fi

skill_dir="$skills_root/$skill_name"
if [[ -e "$skill_dir" ]]; then
  echo "Skill already exists: $skill_dir" >&2
  exit 1
fi

read -r -p "Description (optional): " description
if [[ -z "$description" ]]; then
  description="TODO: Describe what this skill does and when to use it."
  description_is_placeholder=1
else
  description_is_placeholder=0
fi
if ((${#description} > 1024)); then
  echo "Description must be at most 1024 characters." >&2
  exit 2
fi

printf '%s\n' \
  "Invocation policy:" \
  "  1) Implicit and explicit (default)" \
  "  2) Explicit only" \
  "  3) Model only; restrict user invocation where supported"
read -r -p "Choose 1-3 [1]: " invocation_choice
invocation_choice="${invocation_choice:-1}"

case "$invocation_choice" in
  1)
    invocation_frontmatter=""
    allow_implicit="true"
    invocation_label="implicit and explicit"
    ;;
  2)
    invocation_frontmatter="disable-model-invocation: true"
    allow_implicit="false"
    invocation_label="explicit only"
    ;;
  3)
    invocation_frontmatter="user-invocable: false"
    allow_implicit="true"
    invocation_label="model only where supported"
    ;;
  *)
    echo "Invocation policy must be 1, 2, or 3." >&2
    exit 2
    ;;
esac

display_name="$(printf '%s' "$skill_name" | awk -F- '{ for (i = 1; i <= NF; i++) { $i = toupper(substr($i, 1, 1)) substr($i, 2) } OFS=" "; print }')"
if ((description_is_placeholder)); then
  short_description="Run $display_name with clear steps"
else
  short_description="$description"
fi
if ((${#short_description} < 25)); then
  short_description="Run $display_name with clear steps"
fi
if ((${#short_description} > 64)); then
  short_description="${short_description:0:61}..."
fi

printf '\n%s\n' "Skill scaffold:"
printf '  Name: %s\n' "$skill_name"
printf '  Description: %s\n' "$description"
printf '  Invocation: %s\n' "$invocation_label"
printf '  Destination: %s\n' "$skill_dir"
read -r -p "Create this skill? [y/N]: " confirmation

case "$confirmation" in
  y|Y|[yY][eE][sS])
    ;;
  *)
    echo "Cancelled. No files created."
    exit 0
    ;;
esac

temp_dir="$(mktemp -d "$skills_root/.skill-scaffold.XXXXXX")"
trap 'rm -rf "$temp_dir"' EXIT
mkdir -p "$temp_dir/agents"

{
  printf '%s\n' '---'
  printf 'name: %s\n' "$skill_name"
  printf 'description: %s\n' "$(yaml_quote "$description")"
  printf '%s\n' '# license: MIT'
  printf '%s\n' '# compatibility: "Requires a specific CLI, package, network access, or host. Omit when unrestricted."'
  printf '%s\n' '# metadata:'
  printf '%s\n' '#   author: your-name'
  printf '%s\n' '#   version: "0.1"'
  printf '%s\n' '# allowed-tools: "Read Grep"'
  printf '%s\n' '# argument-hint: "[target]"'
  printf '%s\n' '# arguments: "target"'
  if [[ -n "$invocation_frontmatter" ]]; then
    printf '%s\n' "$invocation_frontmatter"
  fi
  printf '%s\n' '---' '' "# $display_name" ''
  printf '%s\n' '<!--'
  printf '%s\n' 'Authoring hints:'
  printf '%s\n' '- Replace the TODO description with what the skill does and when it should trigger.'
  printf '%s\n' '- Uncomment optional frontmatter only when it changes behavior or records useful compatibility metadata.'
  printf '%s\n' '- `allowed-tools`, invocation fields, and other host extensions are not portable across every agent.'
  printf '%s\n' '- Uncomment `argument-hint` and `arguments` only when the workflow accepts positional input.'
  printf '%s\n' '- Named arguments map in order and can be referenced as `$target`; `$ARGUMENTS` contains all input.'
  printf '%s\n' '- Keep this file focused on the workflow. Put detailed reference material in `references/`.'
  printf '%s\n' '- Add deterministic or repeatedly rewritten operations under `scripts/`, and test every script.'
  printf '%s\n' '- Remove this comment after replacing the scaffold.'
  printf '%s\n' '-->' ''
  printf '%s\n' 'Complete one focused job with explicit inputs, ordered steps, and a checkable result.' ''
  printf '%s\n' '## Workflow' ''
  printf '%s\n' '1. Resolve the request and its required inputs.'
  printf '%s\n' '2. Read only the supporting resources needed for this branch of the workflow.'
  printf '%s\n' '3. Perform the work within the requested scope.'
  printf '%s\n' '4. Verify the result with a concrete check.' ''
  printf '%s\n' '## Completion' ''
  printf '%s\n' 'Complete when the requested output exists, verification is recorded, and unresolved constraints are reported.'
} > "$temp_dir/SKILL.md"

{
  printf '%s\n' 'interface:'
  printf '  display_name: %s\n' "$(yaml_quote "$display_name")"
  printf '  short_description: %s\n' "$(yaml_quote "$short_description")"
  printf '  default_prompt: %s\n' "$(yaml_quote "Use \$$skill_name to complete the requested workflow.")"
  printf '%s\n' 'policy:'
  printf '  allow_implicit_invocation: %s\n' "$allow_implicit"
} > "$temp_dir/agents/openai.yml"

mv "$temp_dir" "$skill_dir"
trap - EXIT

printf '%s\n' \
  "Created $skill_dir" \
  "Invocation: $invocation_label" \
  "Next: replace the scaffold hints, then validate SKILL.md and agents/openai.yml."
