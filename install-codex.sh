#!/usr/bin/env bash
# Install cheat-on-money skills for Codex without changing the Claude Code installer.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CODEX_SKILLS_DIR:-$HOME/.codex/skills}"

mkdir -p "$DEST"

for d in "$ROOT"/skills/*/; do
  name="$(basename "$d")"
  target="$DEST/$name"

  if [ -L "$target" ]; then
    rm "$target"
  fi
  if [ -e "$target" ] && [ ! -d "$target" ]; then
    echo "skip: $target exists and is not a directory" >&2
    continue
  fi

  mkdir -p "$target"
  rm -f "$target/SKILL.md"
  cp "$d/SKILL.md" "$target/SKILL.md"
  ln -sfn "$ROOT/shared-references" "$target/references"
  ln -sfn "$ROOT/templates" "$target/templates"
  ln -sfn "$ROOT/examples" "$target/examples"
  ln -sfn "$ROOT/adapters" "$target/adapters"
  echo "linked for Codex: $name"
done

echo "完成。重启 Codex 或开启新会话后，可以说「我想搞钱」触发 money-init。"
