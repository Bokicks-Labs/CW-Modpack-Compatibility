[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [ValidateSet('Install', 'Status', 'Restore')]
    [string]$Action = 'Install',
    [string]$ProjectZomboidPath,
    [switch]$LaunchOfficialInstaller,
    [string]$BackupPath
)

$ErrorActionPreference = 'Stop'

$expectedInstallerHash = '2A52466AFE804FECE5E88868EEF75A70E8964D3E4E01A3629B57CF6FF19E24B3'
$expectedPatchHash = '909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102'
$installerPath = Join-Path $PSScriptRoot 'ZombieBuddyInstaller_v4.2.exe'
$patchPath = Join-Path $PSScriptRoot 'ZombieBuddy-2.3.3-B42.21-Fix.jar'
$backupRoot = Join-Path $env:USERPROFILE 'Zomboid\backups\CW-ZombieBuddy'

function Get-Sha256([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $null
    }
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash
}

function Assert-BundledFile([string]$Path, [string]$ExpectedHash, [string]$Label) {
    $actualHash = Get-Sha256 $Path
    if (-not $actualHash) {
        throw "$Label is missing: $Path"
    }
    if ($actualHash -ne $ExpectedHash) {
        throw "$Label failed SHA-256 verification. Expected $ExpectedHash; found $actualHash"
    }
}

function Test-GameRoot([string]$Path) {
    if (-not $Path) {
        return $false
    }
    return (
        (Test-Path -LiteralPath (Join-Path $Path 'ProjectZomboid64.exe') -PathType Leaf) -and
        (Test-Path -LiteralPath (Join-Path $Path 'projectzomboid.jar') -PathType Leaf)
    )
}

function Get-SteamLibraries {
    $result = [Collections.Generic.List[string]]::new()
    $steamPath = $null
    try {
        $steamPath = (Get-ItemProperty -LiteralPath 'HKCU:\Software\Valve\Steam' -ErrorAction Stop).SteamPath
    } catch {
        # Steam may be installed for another Windows account or omitted on a server.
    }

    if ($steamPath) {
        $result.Add([IO.Path]::GetFullPath($steamPath))
        $libraryFile = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
        if (Test-Path -LiteralPath $libraryFile -PathType Leaf) {
            $libraryText = Get-Content -Raw -LiteralPath $libraryFile
            foreach ($match in [regex]::Matches($libraryText, '(?m)^\s*"path"\s+"(?<path>[^"]+)"')) {
                $library = $match.Groups['path'].Value -replace '\\\\', '\'
                $result.Add([IO.Path]::GetFullPath($library))
            }
        }
    }

    return @($result | Select-Object -Unique)
}

function Resolve-GameRoot([string]$ExplicitPath) {
    if ($ExplicitPath) {
        $resolved = [IO.Path]::GetFullPath($ExplicitPath).TrimEnd('\')
        if (-not (Test-GameRoot $resolved)) {
            throw "The supplied Project Zomboid path is not a game installation: $resolved"
        }
        return $resolved
    }

    $candidates = [Collections.Generic.List[string]]::new()
    $setupPath = [IO.Path]::GetFullPath($PSScriptRoot)
    $workshopMarker = '\steamapps\workshop\content\108600\'
    $markerIndex = $setupPath.IndexOf($workshopMarker, [StringComparison]::OrdinalIgnoreCase)
    if ($markerIndex -ge 0) {
        $libraryRoot = $setupPath.Substring(0, $markerIndex)
        $candidates.Add((Join-Path $libraryRoot 'steamapps\common\ProjectZomboid'))
    }

    foreach ($library in Get-SteamLibraries) {
        $manifest = Join-Path $library 'steamapps\appmanifest_108600.acf'
        if (-not (Test-Path -LiteralPath $manifest -PathType Leaf)) {
            continue
        }
        $manifestText = Get-Content -Raw -LiteralPath $manifest
        $installDirMatch = [regex]::Match($manifestText, '(?m)^\s*"installdir"\s+"(?<name>[^"]+)"')
        if ($installDirMatch.Success) {
            $candidates.Add((Join-Path $library ('steamapps\common\' + $installDirMatch.Groups['name'].Value)))
        }
    }

    foreach ($candidate in @($candidates | Select-Object -Unique)) {
        $resolved = [IO.Path]::GetFullPath($candidate).TrimEnd('\')
        if (Test-GameRoot $resolved) {
            return $resolved
        }
    }

    throw 'Could not locate Project Zomboid. Rerun with -ProjectZomboidPath pointing at the installation root.'
}

function Get-AgentState([string]$GameRoot) {
    $liveJar = Join-Path $GameRoot 'ZombieBuddy.jar'
    $nativeDll = Join-Path $GameRoot 'zbNative.dll'
    $normalLauncher = Join-Path $GameRoot 'ProjectZomboid64.json'
    $alternateLauncher = Join-Path $GameRoot 'ProjectZomboid64.bat'
    $launcherConfigured = $false

    foreach ($launcher in @($normalLauncher, $alternateLauncher)) {
        if ((Test-Path -LiteralPath $launcher -PathType Leaf) -and
            (Get-Content -Raw -LiteralPath $launcher) -match '-agentlib:zbNative') {
            $launcherConfigured = $true
        }
    }

    $liveHash = Get-Sha256 $liveJar
    return [pscustomobject]@{
        GameRoot = $GameRoot
        LiveJar = $liveJar
        LiveJarExists = Test-Path -LiteralPath $liveJar -PathType Leaf
        LiveJarHash = $liveHash
        NativeDllExists = Test-Path -LiteralPath $nativeDll -PathType Leaf
        LauncherFileConfigured = $launcherConfigured
        IsPatched = $liveHash -eq $expectedPatchHash
    }
}

function Assert-GameStopped([string]$GameRoot) {
    $rootPrefix = [IO.Path]::GetFullPath($GameRoot).TrimEnd('\') + '\'
    $running = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
        Where-Object {
            $_.Name -match '^ProjectZomboid' -and
            $_.ExecutablePath -and
            [IO.Path]::GetFullPath($_.ExecutablePath).StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)
        }
    if ($running) {
        throw "Project Zomboid is running from $GameRoot. Close it before installing or restoring ZombieBuddy."
    }
}

function Show-State($State) {
    Write-Output "Project Zomboid: $($State.GameRoot)"
    Write-Output "ZombieBuddy.jar present: $($State.LiveJarExists)"
    Write-Output "ZombieBuddy.jar SHA-256: $($State.LiveJarHash)"
    Write-Output "zbNative.dll present: $($State.NativeDllExists)"
    Write-Output "Launcher file contains -agentlib:zbNative: $($State.LauncherFileConfigured)"
    Write-Output "42.21 compatibility JAR installed: $($State.IsPatched)"
    if (-not $State.LauncherFileConfigured) {
        Write-Warning 'The launcher files do not contain -agentlib:zbNative. Steam launch options may still provide it; verify them manually.'
    }
}

function Invoke-OfficialInstaller {
    Assert-BundledFile $installerPath $expectedInstallerHash 'Bundled ZombieBuddy installer'
    if (-not $PSCmdlet.ShouldProcess($installerPath, 'Run Zed''s official ZombieBuddy installer v4.2')) {
        return
    }
    Write-Output 'Starting the official interactive ZombieBuddy installer. Review its preview before accepting changes.'
    $process = Start-Process -FilePath $installerPath -Wait -PassThru
    if ($process.ExitCode -ne 0) {
        throw "ZombieBuddy installer exited with code $($process.ExitCode)."
    }
}

function Install-Patch([string]$GameRoot) {
    Assert-BundledFile $patchPath $expectedPatchHash 'Bundled ZombieBuddy 42.21 compatibility JAR'
    Assert-GameStopped $GameRoot
    $state = Get-AgentState $GameRoot

    if ($state.IsPatched) {
        Write-Output 'The expected 42.21 compatibility JAR is already installed.'
        return
    }
    if (-not $state.LiveJarExists -or -not $state.NativeDllExists) {
        throw 'The base ZombieBuddy installation is incomplete. Rerun with -LaunchOfficialInstaller, then retry.'
    }

    if (-not $PSCmdlet.ShouldProcess($state.LiveJar, 'Back up and install the pinned ZombieBuddy 42.21 compatibility JAR')) {
        return
    }

    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
    $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backupJar = Join-Path $backupRoot "ZombieBuddy-$timestamp-$($state.LiveJarHash).jar"
    $manifestPath = "$backupJar.json"
    Copy-Item -LiteralPath $state.LiveJar -Destination $backupJar
    if ((Get-Sha256 $backupJar) -ne $state.LiveJarHash) {
        throw 'Backup hash verification failed. The live JAR was not changed.'
    }

    [ordered]@{
        formatVersion = 1
        created = (Get-Date).ToString('o')
        gameRoot = $GameRoot
        livePath = $state.LiveJar
        backupPath = $backupJar
        originalHash = $state.LiveJarHash
        installedHash = $expectedPatchHash
    } | ConvertTo-Json | Set-Content -LiteralPath $manifestPath -Encoding UTF8

    $stagedJar = Join-Path $GameRoot ('.ZombieBuddy.jar.cw-stage-' + [guid]::NewGuid().ToString('N'))
    try {
        Copy-Item -LiteralPath $patchPath -Destination $stagedJar
        if ((Get-Sha256 $stagedJar) -ne $expectedPatchHash) {
            throw 'Staged compatibility JAR failed hash verification.'
        }
        Move-Item -LiteralPath $stagedJar -Destination $state.LiveJar -Force
    } finally {
        if (Test-Path -LiteralPath $stagedJar) {
            Remove-Item -LiteralPath $stagedJar -Force
        }
    }

    if ((Get-Sha256 $state.LiveJar) -ne $expectedPatchHash) {
        throw "Installed JAR failed final verification. Restore from: $backupJar"
    }
    Write-Output "Installed ZombieBuddy 42.21 compatibility JAR: $($state.LiveJar)"
    Write-Output "Backup: $backupJar"
}

function Restore-Backup([string]$GameRoot, [string]$RequestedBackup) {
    Assert-GameStopped $GameRoot
    if ($RequestedBackup) {
        $candidate = [IO.Path]::GetFullPath($RequestedBackup)
        $manifestCandidate = if ($candidate.EndsWith('.json')) { $candidate } else { "$candidate.json" }
        if (-not (Test-Path -LiteralPath $manifestCandidate -PathType Leaf)) {
            throw "Backup manifest not found: $manifestCandidate"
        }
        $manifest = Get-Content -Raw -LiteralPath $manifestCandidate | ConvertFrom-Json
    } else {
        $latest = Get-ChildItem -LiteralPath $backupRoot -File -Filter '*.jar.json' -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTime -Descending |
            Select-Object -First 1
        if (-not $latest) {
            throw "No CW ZombieBuddy backup manifest was found under $backupRoot"
        }
        $manifest = Get-Content -Raw -LiteralPath $latest.FullName | ConvertFrom-Json
    }

    $resolvedBackup = [IO.Path]::GetFullPath([string]$manifest.backupPath)
    $resolvedTarget = [IO.Path]::GetFullPath((Join-Path $GameRoot 'ZombieBuddy.jar'))
    if (-not (Test-Path -LiteralPath $resolvedBackup -PathType Leaf)) {
        throw "Backup JAR is missing: $resolvedBackup"
    }
    if ((Get-Sha256 $resolvedBackup) -ne [string]$manifest.originalHash) {
        throw 'Backup JAR does not match its recorded SHA-256.'
    }
    if (-not $PSCmdlet.ShouldProcess($resolvedTarget, "Restore ZombieBuddy backup $resolvedBackup")) {
        return
    }
    Copy-Item -LiteralPath $resolvedBackup -Destination $resolvedTarget -Force
    if ((Get-Sha256 $resolvedTarget) -ne [string]$manifest.originalHash) {
        throw 'Restored JAR failed final hash verification.'
    }
    Write-Output "Restored ZombieBuddy JAR: $resolvedTarget"
}

if ($env:OS -ne 'Windows_NT') {
    throw 'This bundled helper supports Windows clients and Windows dedicated servers only.'
}

Assert-BundledFile $installerPath $expectedInstallerHash 'Bundled ZombieBuddy installer'
Assert-BundledFile $patchPath $expectedPatchHash 'Bundled ZombieBuddy 42.21 compatibility JAR'
$gameRoot = Resolve-GameRoot $ProjectZomboidPath

switch ($Action) {
    'Status' {
        Show-State (Get-AgentState $gameRoot)
    }
    'Install' {
        $state = Get-AgentState $gameRoot
        if ((-not $state.LiveJarExists -or -not $state.NativeDllExists) -and $LaunchOfficialInstaller) {
            Invoke-OfficialInstaller
            $gameRoot = Resolve-GameRoot $ProjectZomboidPath
        }
        Install-Patch $gameRoot
        Show-State (Get-AgentState $gameRoot)
    }
    'Restore' {
        Restore-Backup $gameRoot $BackupPath
        Show-State (Get-AgentState $gameRoot)
    }
}
