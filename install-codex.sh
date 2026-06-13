#!/usr/bin/env bash
# Install fan-get-money skills into Codex.
# Run from the repo root: ./install-codex.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_SKILLS="${CODEX_HOME:-$HOME/.codex}/skills"

echo "=== fan-get-money Codex Installer ==="
echo "Repo:     $SCRIPT_DIR"
echo "Target:   $CODEX_SKILLS"
echo ""

SKILLS=(fan-money-init fan-money-find fan-money-verify fan-money-plan fan-money-retro fan-money-status)
SHARED=(shared-references templates examples adapters)

for skill in "${SKILLS[@]}"; do
  TARGET="$CODEX_SKILLS/$skill"
  echo "[$skill]"
  mkdir -p "$TARGET"

  # Copy SKILL.md
  cp "$SCRIPT_DIR/$skill/SKILL.md" "$TARGET/"

  # Copy shared dirs into the skill dir for standalone use
  for dir in "${SHARED[@]}"; do
    if [ -d "$SCRIPT_DIR/$dir" ]; then
      rm -rf "$TARGET/$dir" 2>/dev/null || true
      cp -r "$SCRIPT_DIR/$dir" "$TARGET/$dir"
      echo "  + $dir"
    fi
  done

  echo "  -> installed"
done

echo ""
echo "Done! Skills installed to $CODEX_SKILLS"
echo "Run /fan-money-init in Codex to start."
