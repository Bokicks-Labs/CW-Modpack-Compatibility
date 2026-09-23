[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$modName = 'CWModOptionsSearch'
$junctionPath = Join-Path $env:USERPROFILE "Zomboid\mods\$modName"
$sourcePath = Join-Path $repoRoot "Contents\mods\$modName"

if (Test-Path -LiteralPath $junctionPath) {
    $item = Get-Item -LiteralPath $junctionPath -Force
    if ($item.LinkType -ne 'Junction') {
        throw "'$junctionPath' exists but is not a junction. Refusing to delete it."
    }
    Remove-Item -LiteralPath $junctionPath
    Write-Output 'DEV OFF: CW Mod Options Search junction removed.'
    return
}

if (-not (Test-Path -LiteralPath (Join-Path $sourcePath '42\mod.info') -PathType Leaf)) {
    throw "Mod Options Search source is missing: '$sourcePath'"
}

New-Item -ItemType Junction -Path $junctionPath -Target $sourcePath | Out-Null
Write-Output "DEV ON: CW Mod Options Search junction created: $junctionPath -> $sourcePath"
