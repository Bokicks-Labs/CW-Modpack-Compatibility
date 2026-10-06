[CmdletBinding()]
param([string]$ProjectZomboidPath)

$ErrorActionPreference = 'Stop'
$api = 'https://api.github.com/repos/Bokicks-Labs/ZombieBuddy-Friends/releases/latest'
$release = Invoke-RestMethod -Uri $api -Headers @{
    'User-Agent' = 'CW-ZombieBuddy-Setup'
    'Accept' = 'application/vnd.github+json'
}
$archive = @($release.assets | Where-Object { $_.name -eq 'ZombieBuddy-Friends.zip' })
$checksums = @($release.assets | Where-Object { $_.name -eq 'SHA256SUMS.txt' })
if ($archive.Count -ne 1 -or $checksums.Count -ne 1) {
    throw 'The latest ZombieBuddy Friends release is missing its ZIP or checksum asset.'
}

$temporary = Join-Path ([IO.Path]::GetTempPath()) ('CW-ZombieBuddy-Friends-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temporary | Out-Null
try {
    $zip = Join-Path $temporary 'ZombieBuddy-Friends.zip'
    $sum = Join-Path $temporary 'SHA256SUMS.txt'
    Invoke-WebRequest -Uri $archive[0].browser_download_url -OutFile $zip
    Invoke-WebRequest -Uri $checksums[0].browser_download_url -OutFile $sum
    $line = @(Get-Content -LiteralPath $sum | Where-Object { $_ -match '^[A-Fa-f0-9]{64}  ZombieBuddy-Friends\.zip$' })
    if ($line.Count -ne 1) { throw 'The release checksum file is invalid.' }
    $expected = ($line[0] -split ' ')[0]
    if ((Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash -ne $expected) {
        throw 'The downloaded ZombieBuddy Friends ZIP failed SHA-256 verification.'
    }

    $unpacked = Join-Path $temporary 'package'
    Expand-Archive -LiteralPath $zip -DestinationPath $unpacked
    $installer = Join-Path $unpacked 'Install-ZombieBuddy.ps1'
    if (-not (Test-Path -LiteralPath $installer -PathType Leaf)) {
        throw 'The verified release ZIP has no installer.'
    }
    Write-Output "Starting verified ZombieBuddy Friends release $($release.tag_name)."
    if ($ProjectZomboidPath) {
        & $installer -ProjectZomboidPath $ProjectZomboidPath
    } else {
        & $installer
    }
    if (-not $?) { throw 'ZombieBuddy Friends installation failed.' }
} finally {
    Remove-Item -LiteralPath $temporary -Recurse -Force -ErrorAction SilentlyContinue
}
