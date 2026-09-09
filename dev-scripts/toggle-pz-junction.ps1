$JunctionPath = "C:\Users\Rim28\Zomboid\mods\CWModpackCompatibility"
$RepoPath     = "C:\Users\Rim28\Projects\CW-Modpack-Compatibility\Contents\mods\CWModpackCompatibility"

if (Test-Path -LiteralPath $JunctionPath) {
    $item = Get-Item -LiteralPath $JunctionPath -Force

    if ($item.LinkType -ne "Junction") {
        Write-Error "'$JunctionPath' exists but is not a junction. Refusing to delete it."
        exit 1
    }

    Remove-Item -LiteralPath $JunctionPath
    Write-Host "DEV OFF: CW Modpack Compatibility junction removed."
}
else {
    if (-not (Test-Path -LiteralPath (Join-Path $RepoPath '42\mod.info') -PathType Leaf)) {
        Write-Error "Repository mod not found: '$RepoPath'"
        exit 1
    }

    New-Item `
        -ItemType Junction `
        -Path $JunctionPath `
        -Target $RepoPath | Out-Null

    Write-Host "DEV ON: CW Modpack Compatibility junction created."
}
