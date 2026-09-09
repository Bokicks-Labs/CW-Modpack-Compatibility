[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$modSource = Join-Path $repoRoot 'Contents\mods\CWModpackCompatibility'
$workshopRoot = Join-Path $env:USERPROFILE 'Zomboid\Workshop\CW-Modpack-Compatibility'
$workshopContents = Join-Path $workshopRoot 'Contents\mods\CWModpackCompatibility'

$running = Get-Process -Name 'ProjectZomboid64', 'ProjectZomboid32', 'ProjectZomboid' -ErrorAction SilentlyContinue
if ($running) {
    throw 'Project Zomboid is running. Close it before publishing Workshop staging files.'
}
if (-not (Test-Path -LiteralPath (Join-Path $modSource '42\mod.info') -PathType Leaf)) {
    throw "Repository mod source is missing: $modSource"
}

New-Item -ItemType Directory -Path $workshopContents -Force | Out-Null
Copy-Item -Path (Join-Path $modSource '*') -Destination $workshopContents -Recurse -Force

foreach ($metadata in @('workshop.txt', 'preview.png')) {
    $source = Join-Path $repoRoot $metadata
    if (Test-Path -LiteralPath $source -PathType Leaf) {
        Copy-Item -LiteralPath $source -Destination (Join-Path $workshopRoot $metadata) -Force
    }
}

function Get-Hashes([string]$root) {
    $result = @{}
    Get-ChildItem -LiteralPath $root -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($root.Length).TrimStart('\').ToLowerInvariant()
        $result[$relative] = (Get-FileHash -Algorithm SHA256 -LiteralPath $_.FullName).Hash
    }
    return $result
}

$sourceHashes = Get-Hashes $modSource
$stagedHashes = Get-Hashes $workshopContents
$missing = @($sourceHashes.Keys | Where-Object { -not $stagedHashes.ContainsKey($_) })
$different = @($sourceHashes.Keys | Where-Object { $stagedHashes.ContainsKey($_) -and $sourceHashes[$_] -ne $stagedHashes[$_] })
if ($missing.Count -or $different.Count) {
    throw "Workshop staging verification failed. Missing=$($missing.Count); Different=$($different.Count)"
}

Write-Output "Published repository mod to: $workshopContents"
Write-Output "Verified files: $($sourceHashes.Count)"
