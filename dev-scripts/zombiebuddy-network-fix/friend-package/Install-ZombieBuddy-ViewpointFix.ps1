[CmdletBinding()]
param(
    [ValidateSet('Install', 'Status', 'Restore')]
    [string]$Action = 'Install',
    [string]$ProjectZomboidPath
)

$ErrorActionPreference = 'Stop'
$expectedDll = '49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE'
$expectedJar = '909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102'
$packageDll = Join-Path $PSScriptRoot 'zbNative.dll'
$packageJar = Join-Path $PSScriptRoot 'ZombieBuddy.jar'
$backupRoot = Join-Path $env:USERPROFILE 'Zomboid\backups\CW-ZombieBuddy\ViewpointFix'

function Get-Hash([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $null }
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash
}

function Assert-Hash([string]$Path, [string]$Expected) {
    $actual = Get-Hash $Path
    if ($actual -ne $Expected) { throw "Unexpected SHA-256 for $Path. Expected $Expected; found $actual" }
}

function Test-GameRoot([string]$Path) {
    return (Test-Path -LiteralPath (Join-Path $Path 'ProjectZomboid64.exe') -PathType Leaf) -and
        (Test-Path -LiteralPath (Join-Path $Path 'projectzomboid.jar') -PathType Leaf) -and
        (Test-Path -LiteralPath (Join-Path $Path 'jre64\bin\instrument.dll') -PathType Leaf)
}

function Resolve-GameRoot {
    if ($ProjectZomboidPath) {
        $path = [IO.Path]::GetFullPath($ProjectZomboidPath).TrimEnd('\')
        if (-not (Test-GameRoot $path)) { throw "Not a supported PZ 42 Windows game root: $path" }
        return $path
    }

    $steamPath = $null
    try { $steamPath = (Get-ItemProperty 'HKCU:\Software\Valve\Steam' -ErrorAction Stop).SteamPath } catch {}
    $libraries = [Collections.Generic.List[string]]::new()
    if ($steamPath) {
        $libraries.Add($steamPath)
        $libraryFile = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $libraryFile -PathType Leaf) {
            $text = Get-Content -Raw -LiteralPath $libraryFile
            foreach ($match in [regex]::Matches($text, '(?m)^\s*"path"\s+"(?<path>[^"]+)"')) {
                $libraries.Add(($match.Groups['path'].Value -replace '\\\\', '\'))
            }
        }
    }
    $found = [Collections.Generic.List[string]]::new()
    foreach ($library in @($libraries | Select-Object -Unique)) {
        $manifest = Join-Path $library 'steamapps\appmanifest_108600.acf'
        if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) { continue }
        $match = [regex]::Match((Get-Content -Raw -LiteralPath $manifest), '(?m)^\s*"installdir"\s+"(?<name>[^"]+)"')
        if (-not $match.Success) { continue }
        $candidate = [IO.Path]::GetFullPath((Join-Path $library ('steamapps\common\' + $match.Groups['name'].Value)))
        if (Test-GameRoot $candidate) { $found.Add($candidate) }
    }
    $found = @($found | Select-Object -Unique)
    if ($found.Count -ne 1) {
        throw "Found $($found.Count) PZ installations. Rerun with -ProjectZomboidPath 'C:\path\to\ProjectZomboid'."
    }
    return $found[0]
}

function Assert-GameStopped([string]$Root) {
    $prefix = [IO.Path]::GetFullPath($Root).TrimEnd('\') + '\'
    $running = Get-CimInstance Win32_Process | Where-Object {
        $_.Name -match '^ProjectZomboid' -and $_.ExecutablePath -and
        [IO.Path]::GetFullPath($_.ExecutablePath).StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)
    }
    if ($running) { throw 'Close Project Zomboid before installing or restoring this fix.' }
}

if ($env:OS -ne 'Windows_NT') { throw 'This package supports Windows only.' }
$root = Resolve-GameRoot
$liveDll = Join-Path $root 'zbNative.dll'
$liveJar = Join-Path $root 'ZombieBuddy.jar'
$dllHash = Get-Hash $liveDll
$jarHash = Get-Hash $liveJar

if ($Action -eq 'Status') {
    "Game: $root"
    "zbNative.dll: $dllHash"
    "ZombieBuddy.jar: $jarHash"
    "Native DNS fix installed: $($dllHash -eq $expectedDll)"
    "42.21 compatibility JAR installed: $($jarHash -eq $expectedJar)"
    return
}

Assert-GameStopped $root
if ($Action -eq 'Restore') {
    $manifests = @(Get-ChildItem -LiteralPath $backupRoot -Filter 'manifest.json' -Recurse -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending)
    $manifestFile = $manifests | Where-Object {
        try { ([IO.Path]::GetFullPath((Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json).gameRoot)) -eq $root } catch { $false }
    } | Select-Object -First 1
    if (-not $manifestFile) { throw "No backup found for $root under $backupRoot" }
    $manifest = Get-Content -Raw -LiteralPath $manifestFile.FullName | ConvertFrom-Json
    foreach ($name in @('zbNative.dll', 'ZombieBuddy.jar')) {
        $entry = $manifest.files.$name
        $source = Join-Path $manifestFile.DirectoryName $name
        $target = Join-Path $root $name
        Assert-Hash $source $entry.originalHash
        Copy-Item -LiteralPath $source -Destination $target -Force
        Assert-Hash $target $entry.originalHash
        "Restored $name"
    }
    return
}

Assert-Hash $packageDll $expectedDll
Assert-Hash $packageJar $expectedJar
if (-not $dllHash -or -not $jarHash) {
    throw 'ZombieBuddy is not installed. Install the official ZombieBuddy Windows agent first, then rerun this package.'
}
if (Test-Path -LiteralPath (Join-Path $root 'ZombieBuddy.jar.new') -PathType Leaf) {
    throw 'A ZombieBuddy.jar.new update is pending and would replace the installed JAR at startup. Resolve that update before installing this package.'
}
if ($dllHash -eq $expectedDll -and $jarHash -eq $expectedJar) {
    'The native DNS fix and Build 42.21 compatibility JAR are already installed.'
    return
}

$backupDir = Join-Path $backupRoot ((Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
$files = [ordered]@{}
foreach ($name in @('zbNative.dll', 'ZombieBuddy.jar')) {
    $live = Join-Path $root $name
    $original = Get-Hash $live
    Copy-Item -LiteralPath $live -Destination (Join-Path $backupDir $name)
    Assert-Hash (Join-Path $backupDir $name) $original
    $files[$name] = [ordered]@{ originalHash = $original }
}
[ordered]@{ gameRoot = $root; created = (Get-Date).ToString('o'); files = $files } |
    ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $backupDir 'manifest.json') -Encoding UTF8

try {
    foreach ($item in @(@('zbNative.dll', $packageDll, $expectedDll), @('ZombieBuddy.jar', $packageJar, $expectedJar))) {
        $target = Join-Path $root $item[0]
        if ((Get-Hash $target) -eq $item[2]) { continue }
        $stage = Join-Path $root ('.' + $item[0] + '.cw-stage-' + [guid]::NewGuid().ToString('N'))
        try {
            Copy-Item -LiteralPath $item[1] -Destination $stage
            Assert-Hash $stage $item[2]
            Move-Item -LiteralPath $stage -Destination $target -Force
            Assert-Hash $target $item[2]
        } finally {
            if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Force }
        }
        "Installed $($item[0])"
    }
} catch {
    $failure = $_
    foreach ($name in @('zbNative.dll', 'ZombieBuddy.jar')) {
        Copy-Item -LiteralPath (Join-Path $backupDir $name) -Destination (Join-Path $root $name) -Force
    }
    throw "Install failed and originals were restored from $backupDir. $failure"
}
"Backup: $backupDir"
'Start the game, approve only the expected Viewpoint Java JAR, and test a hostname connection.'
