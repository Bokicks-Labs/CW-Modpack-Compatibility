[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$setupScript = (Resolve-Path (Join-Path $PSScriptRoot '..\Contents\mods\CWModpackCompatibility\ZombieBuddy-Setup\Setup-ZombieBuddyForViewpoint.ps1')).Path
$setupRoot = Split-Path -Parent $setupScript
$expectedInstallerUrl = 'https://github.com/zed-0xff/ZombieBuddy/releases/download/windows_installer_4.2/ZombieBuddyInstaller_v4.2.exe'
$expectedInstallerHash = '2A52466AFE804FECE5E88868EEF75A70E8964D3E4E01A3629B57CF6FF19E24B3'
$expectedPatchHash = '909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102'
$expectedNativeUrl = 'https://github.com/Bokicks-Labs/ZombieBuddy-Windows-Native-Fix/releases/download/v2.3.3-pz42.21-native1/zbNative.dll'
$expectedNativeHash = '49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE'
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
$originalNativeHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'zbNative.dll')).Hash
$previousUserProfile = $env:USERPROFILE

try {
    $blockedPayload = @(Get-ChildItem -LiteralPath $setupRoot -File | Where-Object { $_.Extension -in @('.exe', '.dll', '.bat', '.app', '.dylib', '.sh', '.so', '.zip') })
    if ($blockedPayload.Count) {
        throw "The setup payload contains Workshop-blocked files: $($blockedPayload.Name -join ', ')"
    }
    $setupSource = Get-Content -Raw -LiteralPath $setupScript
    if (-not $setupSource.Contains($expectedInstallerUrl) -or -not $setupSource.Contains($expectedInstallerHash) -or
        -not $setupSource.Contains($expectedNativeUrl) -or -not $setupSource.Contains($expectedNativeHash)) {
        throw 'The setup helper does not contain all pinned download URLs and SHA-256 hashes.'
    }

    $env:USERPROFILE = $testProfile

    & $setupScript -Action Status -ProjectZomboidPath $gameRoot | Out-Host

    $pendingUpdate = Join-Path $gameRoot 'ZombieBuddy.jar.new'
    [IO.File]::WriteAllText($pendingUpdate, 'fixture-pending-update')
    try {
        try {
            & $setupScript -Action Install -ProjectZomboidPath $gameRoot | Out-Host
            throw 'Install unexpectedly accepted a pending ZombieBuddy update.'
        } catch {
            if ($_.Exception.Message -notmatch 'pending ZombieBuddy.jar.new') { throw }
        }
        if ((Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'zbNative.dll')).Hash -ne $originalNativeHash) {
            throw 'Pending-update rejection changed the native DLL.'
        }
    } finally {
        Remove-Item -LiteralPath $pendingUpdate -Force
    }

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot | Out-Host
    $installedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($installedHash -ne $expectedPatchHash) {
        throw "Unexpected installed hash: $installedHash"
    }
    $installedNativeHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'zbNative.dll')).Hash
    if ($installedNativeHash -ne $expectedNativeHash) {
        throw "Unexpected installed native DLL hash: $installedNativeHash"
    }

    $backupRoot = Join-Path $testProfile 'Zomboid\backups\CW-ZombieBuddy'
    $manifests = @(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.jar.json')
    if ($manifests.Count -ne 1) {
        throw "Expected one backup manifest; found $($manifests.Count)."
    }
    $nativeManifests = @(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.dll.json')
    if ($nativeManifests.Count -ne 1) {
        throw "Expected one native backup manifest; found $($nativeManifests.Count)."
    }

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot | Out-Host
    if (@(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.jar.json').Count -ne 1) {
        throw 'An idempotent install created an extra backup.'
    }
    if (@(Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.dll.json').Count -ne 1) {
        throw 'An idempotent native install created an extra backup.'
    }

    & $setupScript -Action Restore -ProjectZomboidPath $gameRoot | Out-Host
    $restoredHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($restoredHash -ne $originalHash) {
        throw "Restore mismatch: $restoredHash != $originalHash"
    }
    $restoredNativeHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'zbNative.dll')).Hash
    if ($restoredNativeHash -ne $originalNativeHash) {
        throw "Native restore mismatch: $restoredNativeHash != $originalNativeHash"
    }

    & $setupScript -Action Install -ProjectZomboidPath $gameRoot -WhatIf | Out-Host
    $afterWhatIfHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'ZombieBuddy.jar')).Hash
    if ($afterWhatIfHash -ne $restoredHash) {
        throw 'The WhatIf installation changed the live JAR.'
    }
    if ((Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $gameRoot 'zbNative.dll')).Hash -ne $restoredNativeHash) {
        throw 'The WhatIf installation changed the live native DLL.'
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
