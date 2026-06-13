#!/usr/bin/env bash
# Launch Chrome with remote debugging and isolated profile for fan-get-money adapters.
# Works on macOS, Linux, and Windows (Git Bash / WSL).
set -euo pipefail
PORT="${1:-9222}"
PROFILE="$HOME/.money-chrome-profile"

# Platform detection
case "$(uname -s)" in
  Darwin)  CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ;;
  Linux)   CHROME="$(command -v google-chrome || command -v google-chrome-stable || command -v chromium-browser || command -v chromium || echo "")" ;;
  MINGW*|MSYS*|CYGWIN*)
    CHROME="$(find "/c/Program Files/Google/Chrome/Application" -name chrome.exe 2>/dev/null | head -1 || find "/c/Program Files (x86)/Google/Chrome/Application" -name chrome.exe 2>/dev/null | head -1 || echo "")"
    ;;
  *) echo "Unsupported OS"; exit 1 ;;
esac

if [ -z "$CHROME" ] || [ ! -f "$CHROME" ]; then
  echo "Chrome not found. Set CHROME env var to the Chrome executable path."
  exit 1
fi

mkdir -p "$PROFILE"
echo "Starting Chrome (debug port $PORT, profile=$PROFILE)"
echo "¡ú In the opened window, scan QR to log in to the target site (required)."
echo "¡ú Keep the window open. If a captcha/slider appears, solve it manually."
echo "¡ú Then run: node read-xianyu.mjs 'keyword' $PORT  OR  node read-boss.mjs 'keyword' 100010000 $PORT"
exec "$CHROME" --remote-debugging-port="$PORT" --user-data-dir="$PROFILE" --no-first-run --no-default-browser-check
