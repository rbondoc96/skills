#!/usr/bin/env bash
set -euo pipefail

# Skills are cloned here first. Target directories get symlinks to these clones.
COMMON_SKILLS_DIR="$HOME/.agents/skills"

# Edit this list to choose which skill directories should point at COMMON_SKILLS_DIR.
TARGET_DIRS=(
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
  "$HOME/.pi/agent/skills"
)

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

usage() {
  cat <<USAGE
Usage: $(basename "$0") [--dry-run] [target-dir ...]

Copies each skill directory from this repo into:
  $COMMON_SKILLS_DIR

Then symlinks each target skill directory to the common clone.
Targets default to TARGET_DIRS at the top of this script.

Options:
  --dry-run    Print actions without writing files.
USAGE
}

DRY_RUN=0
ARGS=()

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      ARGS+=("$arg")
      ;;
  esac
done

if ((${#ARGS[@]} > 0)); then
  TARGET_DIRS=("${ARGS[@]}")
fi

SKILL_DIRS=()
while IFS= read -r skill_dir; do
  SKILL_DIRS+=("$skill_dir")
done < <(
  find "$REPO_ROOT" -mindepth 2 -maxdepth 2 -name SKILL.md -type f \
    -not -path "$REPO_ROOT/scripts/*" \
    -exec dirname {} \; | sort
)

if ((${#SKILL_DIRS[@]} == 0)); then
  echo "No skills found under $REPO_ROOT" >&2
  exit 1
fi

clone_skill() {
  local source_dir="$1"
  local skill_name
  local common_dir

  skill_name="$(basename "$source_dir")"
  common_dir="$COMMON_SKILLS_DIR/$skill_name"

  echo "clone: $source_dir -> $common_dir"

  if ((DRY_RUN)); then
    return
  fi

  mkdir -p "$COMMON_SKILLS_DIR"

  if [[ -L "$common_dir" ]]; then
    rm "$common_dir"
  fi

  if command -v rsync >/dev/null 2>&1; then
    rsync -aL --delete --exclude .git/ "$source_dir/" "$common_dir/"
  else
    rm -rf "$common_dir"
    mkdir -p "$common_dir"
    cp -R "$source_dir/." "$common_dir/"
  fi
}

link_skill() {
  local skill_name="$1"
  local target_root="$2"
  local common_dir="$COMMON_SKILLS_DIR/$skill_name"
  local target_dir="$target_root/$skill_name"

  echo "link:  $target_dir -> $common_dir"

  if ((DRY_RUN)); then
    return
  fi

  mkdir -p "$target_root"
  rm -rf "$target_dir"
  ln -s "$common_dir" "$target_dir"
}

for skill_dir in "${SKILL_DIRS[@]}"; do
  clone_skill "$skill_dir"
done

for target_root in "${TARGET_DIRS[@]}"; do
  for skill_dir in "${SKILL_DIRS[@]}"; do
    link_skill "$(basename "$skill_dir")" "$target_root"
  done
done
