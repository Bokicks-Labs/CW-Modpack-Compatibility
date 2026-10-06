[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repoRoot 'Contents\mods\CWModpackCompatibility'
$junction = Join-Path $env:USERPROFILE 'Zomboid\mods\CWModpackCompatibility_dev'
$devRoot = Join-Path $repoRoot ('LocalTest\CWModpackCompatibility_dev_' + (Get-Date -Format 'yyyyMMdd-HHmmss-fffffff'))
$devId = 'CWModpackCompatibility_dev'

if (Test-Path -LiteralPath $junction) {
    $item = Get-Item -LiteralPath $junction -Force
    $allowedRoot = (Join-Path $repoRoot 'LocalTest\CWModpackCompatibility_dev_')
    if ($item.LinkType -ne 'Junction' -or -not $item.Target.StartsWith($allowedRoot, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove an unmanaged path: $junction"
    }
    Remove-Item -LiteralPath $junction
    Write-Output "DEV OFF: $junction"
    return
}

$legacy = Join-Path $env:USERPROFILE 'Zomboid\mods\CWModpackCompatibility'
if (Test-Path -LiteralPath $legacy) {
    $item = Get-Item -LiteralPath $legacy -Force
    if ($item.LinkType -eq 'Junction' -and $item.Target -eq $source) {
        throw "Remove the old release-ID junction first: $legacy"
    }
}
if (-not (Test-Path -LiteralPath (Join-Path $source '42\mod.info') -PathType Leaf)) {
    throw "Source mod is missing: $source"
}

Copy-Item -LiteralPath $source -Destination $devRoot -Recurse
$info = Join-Path $devRoot '42\mod.info'
$content = [IO.File]::ReadAllText($info)
if (([regex]::Matches($content, '(?m)^id=CWModpackCompatibility\r?$')).Count -ne 1) {
    throw "Expected one release mod ID in $info"
}
$content = [regex]::Replace($content, '(?m)^id=CWModpackCompatibility\r?$', "id=$devId")
$content = [regex]::Replace($content, '(?m)^name=(.+)\r?$', 'name=$1 (Dev)')
[IO.File]::WriteAllText($info, $content, [Text.UTF8Encoding]::new($false))
New-Item -ItemType Junction -Path $junction -Target $devRoot | Out-Null
Write-Output "DEV ON: $junction -> $devRoot (ID $devId)"
