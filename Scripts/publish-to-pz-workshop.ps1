[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$modNames = @('CWModpackCompatibility', 'CWAudioMixer')
$workshopRoot = Join-Path $env:USERPROFILE 'Zomboid\Workshop\CW-Modpack-Compatibility'

$running = Get-Process -Name 'ProjectZomboid64', 'ProjectZomboid32', 'ProjectZomboid' -ErrorAction SilentlyContinue
if ($running) {
    throw 'Project Zomboid is running. Close it before publishing Workshop staging files.'
}
function Sync-ModPayload([string]$modName) {
    $modSource = Join-Path $repoRoot "Contents\mods\$modName"
    $workshopContents = Join-Path $workshopRoot "Contents\mods\$modName"
    if (-not (Test-Path -LiteralPath (Join-Path $modSource '42\mod.info') -PathType Leaf)) {
        throw "Repository mod source is missing: $modSource"
    }

    New-Item -ItemType Directory -Path $workshopContents -Force | Out-Null
    Copy-Item -Path (Join-Path $modSource '*') -Destination $workshopContents -Recurse -Force

    $resolvedSource = [IO.Path]::GetFullPath($modSource).TrimEnd('\')
    $resolvedStaging = [IO.Path]::GetFullPath($workshopContents).TrimEnd('\')
    $stagingPrefix = $resolvedStaging + '\'
    $sourceFiles = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    Get-ChildItem -LiteralPath $resolvedSource -Recurse -File | ForEach-Object {
        [void]$sourceFiles.Add($_.FullName.Substring($resolvedSource.Length).TrimStart('\'))
    }

    # Copy-Item does not remove files retired from the source payload. Delete only
    # destination-only files whose normalized paths remain inside this staging mod.
    Get-ChildItem -LiteralPath $resolvedStaging -Recurse -File | ForEach-Object {
        $candidate = [IO.Path]::GetFullPath($_.FullName)
        $relative = $candidate.Substring($resolvedStaging.Length).TrimStart('\')
        if (-not $sourceFiles.Contains($relative)) {
            if (-not $candidate.StartsWith($stagingPrefix, [StringComparison]::OrdinalIgnoreCase)) {
                throw "Refusing to remove a file outside Workshop staging: $candidate"
            }
            Remove-Item -LiteralPath $candidate -Force
        }
    }

    Get-ChildItem -LiteralPath $resolvedStaging -Recurse -Directory |
        Sort-Object { $_.FullName.Length } -Descending |
        Where-Object { -not (Get-ChildItem -LiteralPath $_.FullName -Force) } |
        Remove-Item -Force

    return @{ Name = $modName; Source = $resolvedSource; Staging = $resolvedStaging }
}

$payloads = @($modNames | ForEach-Object { Sync-ModPayload $_ })

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

foreach ($payload in $payloads) {
    $sourceHashes = Get-Hashes $payload.Source
    $stagedHashes = Get-Hashes $payload.Staging
    $missing = @($sourceHashes.Keys | Where-Object { -not $stagedHashes.ContainsKey($_) })
    $different = @($sourceHashes.Keys | Where-Object { $stagedHashes.ContainsKey($_) -and $sourceHashes[$_] -ne $stagedHashes[$_] })
    $extra = @($stagedHashes.Keys | Where-Object { -not $sourceHashes.ContainsKey($_) })
    if ($missing.Count -or $different.Count -or $extra.Count) {
        throw "Workshop staging verification failed for $($payload.Name). Missing=$($missing.Count); Different=$($different.Count); Extra=$($extra.Count)"
    }
    Write-Output "Published repository mod to: $($payload.Staging)"
    Write-Output "Verified $($payload.Name) files: $($sourceHashes.Count)"
}
