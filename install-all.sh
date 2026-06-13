#!/usr/bin/env bash
# fan-get-money multi-platform installer
# Installs for Codex, Claude Code, Cursor, Gemini, Copilot, Windsurf, and more.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTRUCTIONS="$SCRIPT_DIR/platforms/universal/INSTRUCTIONS.md"

echo "=== fan-get-money Multi-Platform Installer ==="

# ---- Codex ----
install_codex() {
  echo "[Codex]"
  local target="${CODEX_HOME:-$HOME/.codex}/skills"
  local skills=(fan-money-init fan-money-find fan-money-verify fan-money-plan fan-money-retro fan-money-status)
  local shared=(shared-references templates examples adapters)
  for skill in "${skills[@]}"; do
    mkdir -p "$target/$skill"
    cp "$SCRIPT_DIR/$skill/SKILL.md" "$target/$skill/"
    for dir in "${shared[@]}"; do
      rm -rf "$target/$skill/$dir" 2>/dev/null || true
      cp -r "$SCRIPT_DIR/$dir" "$target/$skill/$dir"
    done
  done
  echo "  -> Codex skills installed to $target"
}

# ---- Claude Code ----
install_claude() {
  echo "[Claude Code]"
  local target="${CLAUDE_CODE_HOME:-$HOME/.claude}"
  mkdir -p "$target"
  cp "$SCRIPT_DIR/platforms/claude-code/CLAUDE.md" "$target/CLAUDE.md"
  # Also copy to project root for project-level usage
  cp "$SCRIPT_DIR/platforms/claude-code/CLAUDE.md" "$SCRIPT_DIR/../CLAUDE.md" 2>/dev/null || true
  echo "  -> CLAUDE.md installed to $target"
}

# ---- Cursor ----
install_cursor() {
  echo "[Cursor]"
  local target="$SCRIPT_DIR/../.cursor/rules"
  mkdir -p "$target"
  cp "$SCRIPT_DIR/platforms/cursor/fan-get-money.mdc" "$target/fan-get-money.mdc"
  echo "  -> Cursor rule installed to $target"
}

# ---- Gemini CLI ----
install_gemini() {
  echo "[Gemini CLI]"
  local target="${GEMINI_HOME:-$HOME/.gemini}"
  mkdir -p "$target"
  cp "$SCRIPT_DIR/platforms/gemini/instructions.md" "$target/instructions.md"
  echo "  -> Gemini instructions installed to $target"
}

# ---- GitHub Copilot ----
install_copilot() {
  echo "[GitHub Copilot]"
  local target="$SCRIPT_DIR/../.github"
  mkdir -p "$target"
  cp "$SCRIPT_DIR/platforms/copilot/copilot-instructions.md" "$target/copilot-instructions.md"
  echo "  -> Copilot instructions installed to $target"
}

# ---- Windsurf ----
install_windsurf() {
  echo "[Windsurf]"
  cp "$INSTRUCTIONS" "$SCRIPT_DIR/../.windsurfrules"
  echo "  -> .windsurfrules installed"
}

# ---- Hermes / WordBuddy / Í¨ÓÃ ----
install_generic() {
  local name="$1"
  local file="$2"
  local target="$3"
  echo "[$name]"
  mkdir -p "$(dirname "$target")"
  cp "$SCRIPT_DIR/platforms/universal/INSTRUCTIONS.md" "$target"
  echo "  -> Instructions installed to $target"
}

# Parse args
PLATFORMS="${*:-all}"
for p in $PLATFORMS; do
  case "$p" in
    all)       install_codex; install_claude; install_cursor; install_gemini; install_copilot; install_windsurf ;;
    codex)     install_codex ;;
    claude)    install_claude ;;
    cursor)    install_cursor ;;
    gemini)    install_gemini ;;
    copilot)   install_copilot ;;
    windsurf)  install_windsurf ;;
    hermes)    install_generic "Hermes" "HERMES.md" "${HERMES_HOME:-$HOME/.hermes}/instructions.md" ;;
    wordbuddy) install_generic "WordBuddy" "WORDBUDDY.md" "${WORDBUDDY_HOME:-$HOME/.wordbuddy}/instructions.md" ;;
    *)         echo "Unknown platform: $p (valid: codex, claude, cursor, gemini, copilot, windsurf, hermes, wordbuddy, all)" ;;
  esac
done

echo ""
echo "Done! For Hermes/WordBuddy, open the app and paste the content of:"
echo "  $INSTRUCTIONS"
echo "into the Custom Instructions / System Prompt field."
