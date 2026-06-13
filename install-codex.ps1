# Install fan-get-money skills into Codex (Windows).
# Run from the repo root: .\install-codex.ps1
param()

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$CodexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { "$env:USERPROFILE\.codex" }
$CodexSkills = "$CodexHome\skills"

Write-Host "=== fan-get-money Codex Installer ==="
Write-Host "Repo:     $ScriptDir"
Write-Host "Target:   $CodexSkills"
Write-Host ""

$Skills = @("fan-money-init", "fan-money-find", "fan-money-verify", "fan-money-plan", "fan-money-retro", "fan-money-status")
$Shared = @("shared-references", "templates", "examples", "adapters")

foreach ($skill in $Skills) {
  $Target = "$CodexSkills\$skill"
  Write-Host "[$skill]"
  New-Item -ItemType Directory -Force -Path $Target | Out-Null

  # Copy SKILL.md
  Copy-Item "$ScriptDir\$skill\SKILL.md" -Destination "$Target\" -Force

  # Copy shared dirs into the skill dir
  foreach ($dir in $Shared) {
    $srcPath = "$ScriptDir\$dir"
    if (Test-Path $srcPath) {
      $dstPath = "$Target\$dir"
      if (Test-Path $dstPath) { Remove-Item -Recurse -Force $dstPath }
      Copy-Item -Recurse $srcPath -Destination $dstPath
      Write-Host "  + $dir"
    }
  }

  Write-Host "  -> installed"
}

Write-Host ""
Write-Host "Done! Skills installed to $CodexSkills"
Write-Host "Run /fan-money-init in Codex to start."
