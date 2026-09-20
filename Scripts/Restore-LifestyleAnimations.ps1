[CmdletBinding()]
param(
    [string]$RepoRoot,
    [string]$SourceCommit = '28136880d36c6e9708bb891ecd1f706ab050e90c',
    [string]$PatchPath = (Join-Path $PSScriptRoot 'restore-lifestyle-animation-regression.patch')
)

$ErrorActionPreference = 'Stop'

if (-not $RepoRoot) {
    $RepoRoot = (& git rev-parse --show-toplevel 2>$null)
    if ($LASTEXITCODE -ne 0 -or -not $RepoRoot) {
        throw 'Could not find a Git repository. Run this from inside CW-Modpack-Compatibility or pass -RepoRoot.'
    }
}

$RepoRoot = (Resolve-Path $RepoRoot).Path
$animPath = 'Contents/mods/CWModpackCompatibility/42/media/anims_X'
$testPath = 'Scripts/test-server-log-fixes.py'

Write-Host "Repository: $RepoRoot"
Write-Host "Source commit: $SourceCommit"

& git -C $RepoRoot cat-file -e "$SourceCommit^{commit}" 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Historical commit is not available locally; fetching it from origin...'
    & git -C $RepoRoot fetch origin $SourceCommit
    if ($LASTEXITCODE -ne 0) {
        throw "Could not fetch historical commit $SourceCommit"
    }
}

$targetChanges = & git -C $RepoRoot status --porcelain -- $animPath $testPath
if ($targetChanges) {
    throw "Target paths already have local changes. Commit/stash/review them first:`n$($targetChanges -join "`n")"
}

if (-not (Test-Path $PatchPath)) {
    throw "Regression patch not found: $PatchPath"
}

Write-Host '[1/3] Restoring the known-good 400-file Lifestyle animation mirror from Git history...'
& git -C $RepoRoot restore --source=$SourceCommit --worktree -- $animPath
if ($LASTEXITCODE -ne 0) {
    throw 'git restore failed.'
}

$animDir = Join-Path $RepoRoot $animPath
$count = @(Get-ChildItem $animDir -File -Filter '*.fbx').Count
if ($count -ne 400) {
    throw "Expected 400 restored FBX files; found $count"
}

Write-Host '[2/3] Checking and applying the regression-test update...'
& git -C $RepoRoot apply --check $PatchPath
if ($LASTEXITCODE -ne 0) {
    throw 'git apply --check failed for the regression patch.'
}
& git -C $RepoRoot apply $PatchPath
if ($LASTEXITCODE -ne 0) {
    throw 'git apply failed for the regression patch.'
}

Write-Host '[3/3] Showing resulting change summary...'
& git -C $RepoRoot diff --stat -- $animPath $testPath

Write-Host ''
Write-Host "Restored $count Lifestyle FBX files."
Write-Host 'The obsolete Lifestyle yoga wrapper and stale AnimSets XML overrides remain deleted.'
Write-Host 'Review with: git diff --stat && git status --short'
