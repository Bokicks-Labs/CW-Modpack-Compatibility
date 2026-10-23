[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$modId = 'CWViewpointPatch'
$source = Join-Path $repoRoot "Contents\mods\$modId"
$devRootPrefix = Join-Path $repoRoot "LocalTest\${modId}_dev_"
$junction = Join-Path $env:USERPROFILE "Zomboid\mods\${modId}_dev"

if (Get-Process -Name 'ProjectZomboid64', 'ProjectZomboid32', 'ProjectZomboid' -ErrorAction SilentlyContinue) {
    throw 'Project Zomboid is running. Close it before changing the Viewpoint dev junction.'
}

if (Test-Path -LiteralPath $junction) {
    $coreJunction = Join-Path $env:USERPROFILE 'Zomboid\mods\CWModpackCompatibility_dev'
    if (Test-Path -LiteralPath $coreJunction) {
        $coreItem = Get-Item -LiteralPath $coreJunction -Force
        $manifest = Join-Path $coreItem.Target 'dev-submods.txt'
        if ($coreItem.LinkType -eq 'Junction' -and (Test-Path -LiteralPath $manifest -PathType Leaf) -and
            (Get-Content -LiteralPath $manifest) -contains $modId) {
            throw 'The main CW deploy manages this Viewpoint junction. Use deploy-pz-dev-mods.ps1 to refresh it.'
        }
    }
    $item = Get-Item -LiteralPath $junction -Force
    if ($item.LinkType -ne 'Junction' -or -not $item.Target.StartsWith($devRootPrefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove an unmanaged path: $junction"
    }
    Remove-Item -LiteralPath $junction
}

$info = Join-Path $source '42\mod.info'
if (-not (Test-Path -LiteralPath $info -PathType Leaf)) { throw "Source mod is missing: $source" }
$devRoot = $devRootPrefix + (Get-Date -Format 'yyyyMMdd-HHmmss-fffffff')
Copy-Item -LiteralPath $source -Destination $devRoot -Recurse
$devInfo = Join-Path $devRoot '42\mod.info'
$content = [IO.File]::ReadAllText($devInfo)
if (([regex]::Matches($content, '(?m)^id=CWViewpointPatch\r?$')).Count -ne 1) {
    throw "Expected one release mod ID in $devInfo"
}
$content = [regex]::Replace($content, '(?m)^id=CWViewpointPatch\r?$', 'id=CWViewpointPatch_dev')
$content = [regex]::Replace($content, '(?m)^name=(.+)\r?$', 'name=$1 (Dev)')
$content += "`nincompatible=$modId`n"
[IO.File]::WriteAllText($devInfo, $content, [Text.UTF8Encoding]::new($false))
New-Item -ItemType Junction -Path $junction -Target $devRoot | Out-Null
Write-Output "DEPLOYED: $junction -> $devRoot"
