# Launch Chrome with remote debugging for fan-get-money adapters (Windows).
param([int]$Port = 9222)

$Profile = "$env:USERPROFILE\.money-chrome-profile"
$ChromePaths = @(
  "C:\Program Files\Google\Chrome\Application\chrome.exe",
  "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$Chrome = $ChromePaths | Where-Object { Test-Path $_ } | Select-Object -First 1

if (-not $Chrome) {
  Write-Error "Chrome not found. Please set `$env:CHROME_PATH to the Chrome executable."
  exit 1
}

New-Item -ItemType Directory -Force -Path $Profile | Out-Null
Write-Host "Starting Chrome (debug port $Port, profile=$Profile)"
Write-Host "-> In the opened window, scan QR to log in to the target site (required)."
Write-Host "-> Keep the window open. If a captcha/slider appears, solve it manually."
Write-Host "-> Then run: node read-xianyu.mjs 'keyword' $Port  OR  node read-boss.mjs 'keyword' 100010000 $Port"

& $Chrome --remote-debugging-port=$Port --user-data-dir="$Profile" --no-first-run --no-default-browser-check
