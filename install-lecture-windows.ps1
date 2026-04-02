$ErrorActionPreference = 'Stop'
$ClaudeCodeVersion = '1.0.112'
$BundleDir = $PSScriptRoot
$ClaudeDir = Join-Path $HOME '.claude'

function Test-Command($Name) {
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Install-WingetPackage($Id, $Name) {
    if (winget list --id $Id -e 2>$null | Select-String $Id) {
        Write-Host "[OK] $Name already installed"
        return
    }

    Write-Host "[INFO] Installing $Name..."
    winget install --id $Id -e --source winget --accept-package-agreements --accept-source-agreements
}

function Assert-PathExists($Path, $Label) {
    if (-not (Test-Path $Path)) {
        throw "$Label missing: $Path"
    }
    Write-Host "[OK] $Label"
}

# ── 1. 패키지 설치 ──────────────────────────────────────────
Write-Host ''
Write-Host '[Phase 1/5] Installing prerequisites via winget'

$packages = @(
    @{ id = 'Git.Git'; name = 'Git' },
    @{ id = 'Python.Python.3.12'; name = 'Python' },
    @{ id = 'OpenJS.NodeJS.LTS'; name = 'Node.js LTS' },
    @{ id = 'jqlang.jq'; name = 'jq' },
    @{ id = 'GitHub.cli'; name = 'GitHub CLI' }
)

foreach ($pkg in $packages) {
    Install-WingetPackage -Id $pkg.id -Name $pkg.name
}

$pathsToAdd = @(
    (Join-Path $env:ProgramFiles 'nodejs'),
    (Join-Path $env:LOCALAPPDATA 'Programs\Git\cmd'),
    (Join-Path $env:ProgramFiles 'Git\cmd'),
    (Join-Path $env:ProgramFiles 'Git\bin')
)

foreach ($candidate in $pathsToAdd) {
    if ($candidate -and (Test-Path $candidate) -and -not ($env:PATH.Split(';') -contains $candidate)) {
        $env:PATH = "$candidate;$env:PATH"
    }
}

if (-not (Test-Command 'npm')) {
    throw 'npm not found after Node.js installation. Restart PowerShell and rerun this installer.'
}

# ── 2. Claude Code 설치 ─────────────────────────────────────
Write-Host ''
Write-Host '[Phase 2/5] Installing Claude Code'

npm install -g "@anthropic-ai/claude-code@$ClaudeCodeVersion"

$npmGlobal = npm config get prefix
if ($npmGlobal) {
    foreach ($candidate in @($npmGlobal, "$npmGlobal\bin")) {
        if (-not ($env:PATH.Split(';') -contains $candidate)) {
            $env:PATH = "$candidate;$env:PATH"
        }
    }
}

if (-not (Test-Command 'claude')) {
    throw 'claude command not found after installation. Restart PowerShell and rerun this installer.'
}

# ── 3. Claude 인증 ──────────────────────────────────────────
Write-Host ''
Write-Host '[Phase 3/5] Authenticating Claude Code'

claude auth login

# ── 4. 번들 파일 설치 ───────────────────────────────────────
Write-Host ''
Write-Host '[Phase 4/5] Installing commands, skills, agents, references from bundle'

New-Item -ItemType Directory -Force -Path "$ClaudeDir\commands" | Out-Null
New-Item -ItemType Directory -Force -Path "$ClaudeDir\skills" | Out-Null
New-Item -ItemType Directory -Force -Path "$ClaudeDir\agents" | Out-Null
New-Item -ItemType Directory -Force -Path "$ClaudeDir\reference" | Out-Null

$bundleCommands = Join-Path $BundleDir '.claude\commands'
if (Test-Path $bundleCommands) {
    Copy-Item "$bundleCommands\*" "$ClaudeDir\commands\" -Force
    Write-Host "[OK] Commands copied"
}

$bundleSkills = Join-Path $BundleDir '.claude\skills'
if (Test-Path $bundleSkills) {
    Copy-Item "$bundleSkills\*" "$ClaudeDir\skills\" -Recurse -Force
    Write-Host "[OK] Skills copied"
}

$bundleAgents = Join-Path $BundleDir '.claude\agents'
if (Test-Path $bundleAgents) {
    Copy-Item "$bundleAgents\*" "$ClaudeDir\agents\" -Force
    Write-Host "[OK] Agents copied"
}

$bundleRef = Join-Path $BundleDir '.claude\reference'
if (Test-Path $bundleRef) {
    Copy-Item "$bundleRef\*" "$ClaudeDir\reference\" -Force
    Write-Host "[OK] References copied"
}


# settings.local.json (no agent teams for lecture)
$settingsLocal = Join-Path $ClaudeDir 'settings.local.json'
@'
{
  "enableAllProjectMcpServers": true
}
'@ | Set-Content -Path $settingsLocal -Encoding UTF8
Write-Host "[OK] settings.local.json created"

# settings.json (empty if not exists)
$settingsJson = Join-Path $ClaudeDir 'settings.json'
if (-not (Test-Path $settingsJson)) {
    '{}' | Set-Content -Path $settingsJson -Encoding UTF8
}

# MCP servers
Write-Host "[INFO] Setting up MCP servers..."
claude mcp add-json playwright '{"command":"npx","args":["-y","@playwright/mcp@latest"]}'
claude mcp add-json notion '{"command":"npx","args":["-y","@notionhq/notion-mcp-server"]}'
claude mcp add-json pdf-tools '{"type":"stdio","command":"uvx","args":["mcp-pdf"],"env":{"TESSERACT_PATH":"tesseract"}}'
claude mcp add-json notebooklm '{"command":"npx","args":["notebooklm-mcp@latest"]}'
Write-Host "[OK] MCP servers configured"

# ── 5. 검증 ─────────────────────────────────────────────────
Write-Host ''
Write-Host '[Phase 5/5] Verifying installation'

git --version
node --version
npm --version
gh --version
jq --version
claude --version

Assert-PathExists (Join-Path $ClaudeDir 'commands\lecture.md') 'lecture.md'
Assert-PathExists (Join-Path $ClaudeDir 'commands\start-mw4-1.md') 'start-mw4-1 command'
Assert-PathExists (Join-Path $ClaudeDir 'skills\lesson-a\SKILL.md') 'lesson-a skill'
Assert-PathExists (Join-Path $ClaudeDir 'agents\dept-mentor.md') 'dept-mentor agent'
Assert-PathExists $settingsLocal 'settings.local.json'

Write-Host ''
Write-Host '[OK] Lecture installer complete'
Write-Host "Claude Code: $ClaudeCodeVersion"
Write-Host "Commands/Skills installed to: $ClaudeDir"
Write-Host 'MCP: playwright, notion, pdf-tools, notebooklm'
Write-Host 'Next: open Claude Code and use /start-mw4-1 or /lecture'
