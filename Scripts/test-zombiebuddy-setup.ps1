[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$setupScript = (Resolve-Path (Join-Path $PSScriptRoot '..\Contents\mods\CWModpackCompatibility\ZombieBuddy-Setup\Setup-ZombieBuddyForViewpoint.ps1')).Path
$expectedPatchHash = '909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102'
$testRoot = Join-Path ([IO.Path]::GetTempPath()) ('cw-zb-test-' + [guid]::NewGuid().ToString('N'))
$gameRoot = Join-Path $testRoot 'ProjectZomboid'
$testProfile = Join-Path $testRoot 'profile'

New-Item -ItemType Directory -Path $gameRoot, $testProfile -Force | Out-Null
[IO.File]::WriteAllBytes((Join-Path $gameRoot 'ProjectZomboid64.exe'), [byte[]](1, 2, 3))
[IO.File]::WriteAllBytes((Join-Path $gameRoot 'projectzomboid.jar'), [byte[]](4, 5, 6))
[IO.File]::WriteAllBytes((Join-Path $gameRoot 'zbNative.dll'), [byte[]](7, 8, 9))
[IO.File]::WriteAllText((Join-Path $gameRoot 'ProjectZomboid64.json'), '{"vmArgs":["-agentlib:zbNative"]}')
[IO.File]::WriteAllText((Join-Path $gameRoot 'ZombieBuddy.jar'), 'fixture-original-zombiebuddy')
$originalHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
$previousUserProfile = $env:USERPROFILE

try {
    $env:USERPROFILE = $testProfile

    & $setupScript -Action Status -ProjectZomboidPath $gameRoot | Out-Host

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot | Out-Host
    $installedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($installedHash -ne $expectedPatchHash) {
        throw "Unexpected installed hash: $installedHash"
    }

    $backupRoot = Join-Path $testProfile 'Zomboid\backups\CW-ZombieBuddy'
    $manifests = @(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.jar.json')
    if ($manifests.Count -ne 1) {
        throw "Expected one backup manifest; found $($manifests.Count)."
    }

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot | Out-Host
    if (@(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.jar.json').Count -ne 1) {
        throw 'An idempotent install created an extra backup.'
    }

    & $setupScript -Action Restore -ProjectZomboidPath $gameRoot | Out-Host
    $restoredHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($restoredHash -ne $originalHash) {
        throw "Restore mismatch: $restoredHash != $originalHash"
    }

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot -WhatIf | Out-Host
    $afterWhatIfHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($afterWhatIfHash -ne $restoredHash) {
        throw 'The WhatIf installation changed the live JAR.'
    }

    Write-Output 'ZombieBuddy setup fixture tests passed.'
} finally {
    $env:USERPROFILE = $previousUserProfile
    $resolvedTestRoot = [IO.Path]::GetFullPath($testRoot)
    $tempPrefix = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
    if (-not $resolvedTestRoot.StartsWith($tempPrefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing cleanup outside the temporary directory: $resolvedTestRoot"
    }
    Remove-Item -LiteralPath $resolvedTestRoot -Recurse -Force
}
