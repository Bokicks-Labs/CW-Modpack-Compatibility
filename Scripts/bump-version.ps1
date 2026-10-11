[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)]
    [ValidateSet('patch', 'minor', 'major')]
    [string]$Bump,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Summary,
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string[]]$Notes
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$utf8 = [Text.UTF8Encoding]::new($false)

function Read-Source([string]$relativePath) {
    $path = Join-Path $repoRoot $relativePath
    if (-not [IO.File]::Exists($path)) { throw "Missing release file: $path" }
    return [IO.File]::ReadAllText($path)
}

function Replace-Once([string]$content, [string]$pattern, [string]$replacement, [string]$label) {
    $matches = [regex]::Matches($content, $pattern, [Text.RegularExpressions.RegexOptions]::Multiline)
    if ($matches.Count -ne 1) { throw "Expected one $label marker; found $($matches.Count)." }
    return [regex]::Replace($content, $pattern, { param($match) $replacement }, [Text.RegularExpressions.RegexOptions]::Multiline)
}

$info = Read-Source 'Contents/mods/CWModpackCompatibility/42/mod.info'
$versionMatches = [regex]::Matches($info, '^modversion=(\d+)\.(\d+)\.(\d+)$', [Text.RegularExpressions.RegexOptions]::Multiline)
if ($versionMatches.Count -ne 1) { throw 'Expected exactly one numeric modversion in core mod.info.' }
$current = $versionMatches[0].Groups[0].Value.Substring('modversion='.Length)
$parts = @([int]$versionMatches[0].Groups[1].Value, [int]$versionMatches[0].Groups[2].Value, [int]$versionMatches[0].Groups[3].Value)
switch ($Bump) {
    'major' { $parts[0]++; $parts[1] = 0; $parts[2] = 0 }
    'minor' { $parts[1]++; $parts[2] = 0 }
    'patch' { $parts[2]++ }
}
$next = $parts -join '.'
$summaryLine = ($Summary -replace '\s+', ' ').Trim()
if (-not $summaryLine -or $summaryLine.Contains('[') -or $summaryLine.Contains(']')) {
    throw 'Summary must be nonempty plain text without BBCode brackets.'
}
$noteLines = @($Notes | ForEach-Object { ($_ -replace '\s+', ' ').Trim() })
if (@($noteLines | Where-Object { -not $_ -or $_ -match '[\[\]]' }).Count -gt 0) {
    throw 'Notes must be nonempty plain text without BBCode brackets.'
}

$sharedPath = 'Contents/mods/CWModpackCompatibility/42/media/lua/shared/CWModpackCompatibility.lua'
$descriptionPath = 'docs/workshop-description.md'
$workshopPath = 'workshop.txt'
$readmePath = 'README.md'
$shared = Read-Source $sharedPath
$description = Read-Source $descriptionPath
$workshop = Read-Source $workshopPath
$readme = Read-Source $readmePath
$markdownPath = "docs/workshop-changelog-$next.md"
$steamPath = "docs/steam-changelog-$next.txt"
foreach ($relativePath in @($markdownPath, $steamPath)) {
    if ([IO.File]::Exists((Join-Path $repoRoot $relativePath))) { throw "Release notes already exist: $relativePath" }
}

$updates = [ordered]@{}
$updates['Contents/mods/CWModpackCompatibility/42/mod.info'] = Replace-Once $info "^modversion=$([regex]::Escape($current))$" "modversion=$next" 'mod.info version'
$updates[$sharedPath] = Replace-Once $shared "^Compat\.version = `"$([regex]::Escape($current))`"$" "Compat.version = `"$next`"" 'runtime version'
$updates[$descriptionPath] = Replace-Once $description "^CW $([regex]::Escape($current)) .+$" "CW $next $summaryLine" 'Workshop summary'
$updates[$descriptionPath] = Replace-Once $updates[$descriptionPath] "Current compatibility release: $([regex]::Escape($current))\." "Current compatibility release: $next." 'Workshop version footer'
$updates[$workshopPath] = Replace-Once $workshop "^description=CW $([regex]::Escape($current)) .+$" "description=CW $next $summaryLine" 'Workshop metadata summary'
$updates[$workshopPath] = Replace-Once $updates[$workshopPath] "Current compatibility release: $([regex]::Escape($current))\." "Current compatibility release: $next." 'Workshop metadata footer'
$newLinks = "- [Steam-formatted version $next changelog]($steamPath)`n- [Version $next changelog]($markdownPath)`n"
$updates[$readmePath] = Replace-Once $readme '(?m)^- \[Current Workshop description\]\(docs/workshop-description\.md\)\r?\n' "- [Current Workshop description](docs/workshop-description.md)`n$newLinks" 'README Workshop links'
$updates[$markdownPath] = "# Version $next`n`n$summaryLine`n`n" + (($noteLines | ForEach-Object { "- $_" }) -join "`n") + "`n"
$updates[$steamPath] = "[h1]Version $next[/h1]`n`n$summaryLine`n`n[list]`n" + (($noteLines | ForEach-Object { "[*]$_" }) -join "`n") + "`n[/list]`n"

$workshopLines = $updates[$workshopPath] -split '\r?\n'
$submitDescription = @($workshopLines | Where-Object { $_ -like 'description=*' } | ForEach-Object { $_.Substring(12) }) -join "`n"
$workshopId = @($workshopLines | Where-Object { $_ -like 'id=*' } | Select-Object -First 1) -replace '^id=', ''
$modIds = foreach ($modName in @('CWModpackCompatibility', 'CWAudioMixer', 'CWModOptionsSearch', 'CWViewpointPatch')) {
    $modInfo = Read-Source "Contents/mods/$modName/42/mod.info"
    $modId = @($modInfo -split '\r?\n' | Where-Object { $_ -like 'id=*' } | Select-Object -First 1) -replace '^id=', ''
    if (-not $modId) { throw "Missing mod ID for $modName." }
    $modId
}
$submitDescription += "`n`nWorkshop ID: $workshopId" + (($modIds | ForEach-Object { "`nMod ID: $_" }) -join '')
$submitBytes = [Text.Encoding]::UTF8.GetByteCount($submitDescription)
if ($submitBytes -gt 7900) { throw "Workshop description would be $submitBytes UTF-8 bytes; limit is 7900. Shorten Summary." }

if ($PSCmdlet.ShouldProcess($repoRoot, "Bump CW Modpack Compatibility $current to $next")) {
    foreach ($relativePath in $updates.Keys) {
        [IO.File]::WriteAllText((Join-Path $repoRoot $relativePath), $updates[$relativePath], $utf8)
    }
    Write-Output "CW Modpack Compatibility: $current -> $next"
}
