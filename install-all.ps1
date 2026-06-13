# fan-get-money multi-platform installer (Windows)
param([string[]]$Platforms = @("all"))

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Instructions = "$ScriptDir\platforms\universal\INSTRUCTIONS.md"
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { "$env:USERPROFILE\.codex" }
$Skills = @("fan-money-init", "fan-money-find", "fan-money-verify", "fan-money-plan", "fan-money-retro", "fan-money-status")
$Shared = @("shared-references", "templates", "examples", "adapters")

Write-Host "=== fan-get-money Multi-Platform Installer ==="

function Install-Codex {
  Write-Host "[Codex]"
  $target = "$CodexHome\skills"
  foreach ($skill in $Skills) {
    $st = "$target\$skill"
    New-Item -ItemType Directory -Force -Path $st | Out-Null
    Copy-Item "$ScriptDir\$skill\SKILL.md" -Destination "$st\" -Force
    foreach ($dir in $Shared) {
      $dp = "$st\$dir"
      if (Test-Path $dp) { Remove-Item -Recurse -Force $dp }
      Copy-Item -Recurse "$ScriptDir\$dir" -Destination $dp
    }
  }
  Write-Host "  -> Codex skills installed to $target"
}

function Install-Claude {
  Write-Host "[Claude Code]"
  $target = if ($env:CLAUDE_CODE_HOME) { $env:CLAUDE_CODE_HOME } else { "$env:USERPROFILE\.claude" }
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item "$ScriptDir\platforms\claude-code\CLAUDE.md" -Destination "$target\CLAUDE.md" -Force
  Write-Host "  -> CLAUDE.md installed to $target"
}

function Install-Cursor {
  Write-Host "[Cursor]"
  $target = "$ScriptDir\..\.cursor\rules"
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item "$ScriptDir\platforms\cursor\fan-get-money.mdc" -Destination "$target\fan-get-money.mdc" -Force
  Write-Host "  -> Cursor rule installed to $target"
}

function Install-Gemini {
  Write-Host "[Gemini CLI]"
  $target = if ($env:GEMINI_HOME) { $env:GEMINI_HOME } else { "$env:USERPROFILE\.gemini" }
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item "$ScriptDir\platforms\gemini\instructions.md" -Destination "$target\instructions.md" -Force
  Write-Host "  -> Gemini instructions installed to $target"
}

function Install-Copilot {
  Write-Host "[GitHub Copilot]"
  $target = "$ScriptDir\..\.github"
  New-Item -ItemType Directory -Force -Path $target | Out-Null
  Copy-Item "$ScriptDir\platforms\copilot\copilot-instructions.md" -Destination "$target\copilot-instructions.md" -Force
  Write-Host "  -> Copilot instructions installed to $target"
}

function Install-Windsurf {
  Write-Host "[Windsurf]"
  Copy-Item $Instructions -Destination "$ScriptDir\..\.windsurfrules" -Force
  Write-Host "  -> .windsurfrules installed"
}

function Install-Generic {
  param($Name, $Target)
  Write-Host "[$Name]"
  $dir = Split-Path -Parent $Target
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  Copy-Item $Instructions -Destination $Target -Force
  Write-Host "  -> Instructions installed to $Target"
}

foreach ($p in $Platforms) {
  switch ($p) {
    "all"       { Install-Codex; Install-Claude; Install-Cursor; Install-Gemini; Install-Copilot; Install-Windsurf }
    "codex"     { Install-Codex }
    "claude"    { Install-Claude }
    "cursor"    { Install-Cursor }
    "gemini"    { Install-Gemini }
    "copilot"   { Install-Copilot }
    "windsurf"  { Install-Windsurf }
    "hermes"    { $h = if ($env:HERMES_HOME) { $env:HERMES_HOME } else { "$env:USERPROFILE\.hermes" }; Install-Generic "Hermes" "$h\instructions.md" }
    "wordbuddy" { $w = if ($env:WORDBUDDY_HOME) { $env:WORDBUDDY_HOME } else { "$env:USERPROFILE\.wordbuddy" }; Install-Generic "WordBuddy" "$w\instructions.md" }
    default     { Write-Host "Unknown platform: $p" }
  }
}

Write-Host ""
Write-Host "Done! For Hermes/WordBuddy, paste this file into Custom Instructions:"
Write-Host "  $Instructions"
