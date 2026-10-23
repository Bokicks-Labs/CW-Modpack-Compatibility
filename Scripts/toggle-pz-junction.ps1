[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repoRoot 'Contents\mods\CWModpackCompatibility'
$junction = Join-Path $env:USERPROFILE 'Zomboid\mods\CWModpackCompatibility_dev'
$devRoot = Join-Path $repoRoot ('LocalTest\CWModpackCompatibility_dev_' + (Get-Date -Format 'yyyyMMdd-HHmmss-fffffff'))
$devId = 'CWModpackCompatibility_dev'
$coreId = 'CWModpackCompatibility'
$manifestName = 'dev-submods.txt'
$independentSubmodIds = @('CWViewpointPatch', 'CWModdedUILayout')

if (Get-Process -Name 'ProjectZomboid64', 'ProjectZomboid32', 'ProjectZomboid' -ErrorAction SilentlyContinue) {
    throw 'Project Zomboid is running. Close it before changing dev junctions.'
}

function Get-ManagedSubmods {
    foreach ($directory in Get-ChildItem -LiteralPath (Join-Path $repoRoot 'Contents\mods') -Directory) {
        if ($directory.Name -eq $coreId) { continue }
        $modInfo = Join-Path $directory.FullName '42\mod.info'
        if (-not (Test-Path -LiteralPath $modInfo -PathType Leaf)) { continue }
        $content = [IO.File]::ReadAllText($modInfo)
        $idMatch = [regex]::Match($content, '(?m)^id=([^\r\n]+)\r?$')
        $requireMatch = [regex]::Match($content, '(?m)^require=([^\r\n]+)\r?$')
        if (-not $idMatch.Success -or -not $requireMatch.Success) { continue }
        $requirements = @($requireMatch.Groups[1].Value -split ',' | ForEach-Object { $_.Trim().TrimStart('\') })
        $id = $idMatch.Groups[1].Value.Trim()
        if ($id -notmatch '^[A-Za-z0-9_]+$') { throw "Unsafe submod ID in $modInfo`: $id" }
        if ($requirements -notcontains $coreId -and $independentSubmodIds -notcontains $id) { continue }
        [pscustomobject]@{ Id = $id; Source = $directory.FullName }
    }
}

$submods = @(Get-ManagedSubmods)

function Remove-ManagedDevJunction([string]$path, [string]$name) {
    if (-not (Test-Path -LiteralPath $path)) { return }
    $item = Get-Item -LiteralPath $path -Force
    $allowedRoot = Join-Path $repoRoot "LocalTest\${name}_dev_"
    if ($item.LinkType -ne 'Junction' -or -not $item.Target.StartsWith($allowedRoot, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove an unmanaged path: $path"
    }
    Remove-Item -LiteralPath $path
}

if (Test-Path -LiteralPath $junction) {
    $item = Get-Item -LiteralPath $junction -Force
    $allowedRoot = (Join-Path $repoRoot 'LocalTest\CWModpackCompatibility_dev_')
    if ($item.LinkType -ne 'Junction' -or -not $item.Target.StartsWith($allowedRoot, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove an unmanaged path: $junction"
    }
    $manifest = Join-Path $item.Target $manifestName
    $installedSubmods = if (Test-Path -LiteralPath $manifest -PathType Leaf) {
        @(Get-Content -LiteralPath $manifest | Where-Object { $_ -match '^[A-Za-z0-9_]+$' })
    } else {
        @('CWAudioMixer', 'CWModOptionsSearch') # Copies created before the manifest existed.
    }
    foreach ($submodId in $installedSubmods) {
        Remove-ManagedDevJunction (Join-Path $env:USERPROFILE "Zomboid\mods\${submodId}_dev") $submodId
    }
    Remove-Item -LiteralPath $junction
    Write-Output "DEV OFF: $junction and managed dev submods"
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
foreach ($submod in $submods) {
    $submodJunction = Join-Path $env:USERPROFILE "Zomboid\mods\$($submod.Id)_dev"
    if (Test-Path -LiteralPath $submodJunction) {
        throw "Refusing to replace an existing path: $submodJunction"
    }
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
[IO.File]::WriteAllLines((Join-Path $devRoot $manifestName), [string[]]@($submods | ForEach-Object Id), [Text.UTF8Encoding]::new($false))
foreach ($submod in $submods) {
    $submodRoot = Join-Path $repoRoot ('LocalTest\' + $submod.Id + '_dev_' + (Get-Date -Format 'yyyyMMdd-HHmmss-fffffff'))
    Copy-Item -LiteralPath $submod.Source -Destination $submodRoot -Recurse
    $submodInfo = Join-Path $submodRoot '42\mod.info'
    $submodContent = [IO.File]::ReadAllText($submodInfo)
    $escapedId = [regex]::Escape($submod.Id)
    $submodContent = [regex]::Replace($submodContent, "(?m)^id=$escapedId\r?$", "id=$($submod.Id)_dev")
    $submodContent = [regex]::Replace($submodContent, '(?m)^require=([^\r\n]+)\r?$', {
        param($match)
        $parts = @($match.Groups[1].Value -split ',')
        for ($i = 0; $i -lt $parts.Count; $i++) {
            if ($parts[$i].Trim().TrimStart('\') -eq $coreId) { $parts[$i] = $devId }
        }
        'require=' + ($parts -join ',')
    })
    $submodContent = [regex]::Replace($submodContent, '(?m)^name=(.+)\r?$', 'name=$1 (Dev)')
    [IO.File]::WriteAllText($submodInfo, $submodContent, [Text.UTF8Encoding]::new($false))
    $submodJunction = Join-Path $env:USERPROFILE "Zomboid\mods\$($submod.Id)_dev"
    New-Item -ItemType Junction -Path $submodJunction -Target $submodRoot | Out-Null
    Write-Output "DEV ON: $submodJunction -> $submodRoot (ID $($submod.Id)_dev)"
}
