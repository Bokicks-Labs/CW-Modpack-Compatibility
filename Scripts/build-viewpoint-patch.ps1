[CmdletBinding()]
param([string]$WorkshopRoot = 'S:\SteamLibrary\steamapps\workshop\content\108600')

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repo 'dev-scripts\viewpoint-patch\src'
$output = Join-Path $repo 'Contents\mods\CWViewpointPatch\42\media\java\client\CWViewpointPatch.jar'
$buddyJar = Join-Path $WorkshopRoot '3619862853\mods\ZombieBuddy\libs\ZombieBuddy.jar'
$stub = Join-Path $repo 'dev-scripts\viewpoint-patch\compile-stubs\se\krka\kahlua\integration\annotations\LuaMethod.java'
foreach ($path in @($source, $stub, $buddyJar)) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing build input: $path" }
}
$temp = Join-Path ([IO.Path]::GetTempPath()) ('cw-viewpoint-build-' + [guid]::NewGuid().ToString('N'))
try {
    New-Item -ItemType Directory -Path $temp | Out-Null
    $sources = @(Get-ChildItem -LiteralPath $source -Recurse -Filter '*.java' -File | ForEach-Object FullName)
    if ($sources.Count -eq 0) { throw "No Java sources under $source" }
    & javac -encoding UTF-8 -source 21 -target 21 -cp $buddyJar -d $temp $stub @sources
    if ($LASTEXITCODE -ne 0) { throw 'javac failed' }
    New-Item -ItemType Directory -Path (Split-Path -Parent $output) -Force | Out-Null
    $stream = [IO.File]::Open($output, [IO.FileMode]::Create)
    try {
        $zip = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create)
        try {
            $stamp = [DateTimeOffset]::new(2026, 1, 1, 0, 0, 0, [TimeSpan]::Zero)
            $manifest = $zip.CreateEntry('META-INF/MANIFEST.MF')
            $manifest.LastWriteTime = $stamp
            $writer = [IO.StreamWriter]::new($manifest.Open(), [Text.Encoding]::ASCII)
            try { $writer.Write("Manifest-Version: 1.0`r`n`r`n") } finally { $writer.Dispose() }
            Get-ChildItem -LiteralPath (Join-Path $temp 'cwviewpointpatch') -Recurse -File |
                Sort-Object FullName | ForEach-Object {
                    $entry = $zip.CreateEntry($_.FullName.Substring($temp.Length + 1).Replace('\', '/'))
                    $entry.LastWriteTime = $stamp
                    $inputStream = [IO.File]::OpenRead($_.FullName)
                    $outputStream = $entry.Open()
                    try { $inputStream.CopyTo($outputStream) } finally { $outputStream.Dispose(); $inputStream.Dispose() }
                }
        } finally { $zip.Dispose() }
    } finally { $stream.Dispose() }
    Get-FileHash -Algorithm SHA256 -LiteralPath $output
} finally {
    if (Test-Path -LiteralPath $temp) { Remove-Item -LiteralPath $temp -Recurse -Force }
}
