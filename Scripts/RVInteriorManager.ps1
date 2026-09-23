[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('export', 'import')]
    [string] $Action,

    [Parameter(Mandatory = $true)]
    [string] $Template,

    [Parameter(Mandatory = $true)]
    [string] $SavePath,

    [string] $TemplateRoot = (Join-Path ([Environment]::GetFolderPath('UserProfile')) 'Zomboid\RVInteriorTemplates'),

    [string] $WorkshopRoot = 'S:\SteamLibrary\steamapps\workshop\content\108600',

    [int] $X = [int]::MinValue,
    [int] $Y = [int]::MinValue,
    [int] $Z = [int]::MinValue,

    [switch] $ConfirmOverwrite
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-FullPath {
    param([Parameter(Mandatory)][string] $Path)
    return [System.IO.Path]::GetFullPath($Path)
}

function Get-ProjectRVInstall {
    param([Parameter(Mandatory)][string] $WorkshopContentRoot)
    $profile = [Environment]::GetFolderPath('UserProfile')
    $searchRoots = [System.Collections.Generic.List[string]]::new()
    $localMods = Join-Path $profile 'Zomboid\mods'

    if (Test-Path -LiteralPath $localMods -PathType Container) {
        $searchRoots.Add($localMods)
    }
    if (Test-Path -LiteralPath $WorkshopContentRoot -PathType Container) {
        $searchRoots.Add($WorkshopContentRoot)
    }

    $candidates = foreach ($root in $searchRoots) {
        Get-ChildItem -LiteralPath $root -Filter 'mod.info' -File -Recurse -ErrorAction SilentlyContinue |
            ForEach-Object {
                $info = Get-Content -LiteralPath $_.FullName -Raw -ErrorAction SilentlyContinue
                if ($info -match '(?im)^\s*id\s*=\s*PROJECTRVInterior42\s*$') {
                    $lua = Get-ChildItem -LiteralPath $_.Directory.FullName -Filter 'RVVehicleTypes.lua' -File -Recurse -ErrorAction SilentlyContinue |
                        Select-Object -First 1
                    if ($lua) {
                        [pscustomobject]@{
                            ModInfoPath = $_.FullName
                            ModInfo = $info
                            LuaPath = $lua.FullName
                            LuaHash = (Get-FileHash -LiteralPath $lua.FullName -Algorithm SHA256).Hash
                        }
                    }
                }
            }
    }

    if (-not $candidates) {
        throw 'Could not find an installed Build 42 Project RV Interior mod with id PROJECTRVInterior42.'
    }

    $hashes = @($candidates | Select-Object -ExpandProperty LuaHash -Unique)
    if ($hashes.Count -gt 1) {
        $paths = ($candidates | ForEach-Object ModInfoPath) -join [Environment]::NewLine
        throw "Found multiple Project RV Interior versions with different RVVehicleTypes.lua files. Resolve the duplicate installation first:`n$paths"
    }

    $chosen = $candidates | Select-Object -First 1
    $version = [regex]::Match($chosen.ModInfo, '(?im)^\s*modversion\s*=\s*(?<value>[^\r\n]+)').Groups['value'].Value.Trim()
    $workshopId = [regex]::Match($chosen.ModInfoPath, '[\\/]workshop[\\/]content[\\/]108600[\\/](?<id>\d+)[\\/]', 'IgnoreCase').Groups['id'].Value

    [pscustomobject]@{
        ModInfoPath = $chosen.ModInfoPath
        ModVersion = $version
        WorkshopId = $workshopId
        LuaPath = $chosen.LuaPath
        LuaHash = $chosen.LuaHash
        LuaSource = Get-Content -LiteralPath $chosen.LuaPath -Raw
    }
}

function Get-BusRoomLayout {
    param([Parameter(Mandatory)][string] $LuaSource)

    $pattern = '(?s)\["bus"\]\s*=\s*\{.*?rooms\s*=\s*\(function\(\)\s*local\s+\w+\s*=\s*\{\}\s*for\s+\w+\s*=\s*(?<first>\d+)\s*,\s*(?<last>\d+)\s*do\s*table\.insert\(\w+\s*,\s*\{\s*x\s*=\s*\w+\s*\*\s*(?<step>\d+)\s*\+\s*(?<baseX>\d+)\s*,\s*y\s*=\s*(?<baseY>-?\d+)\s*,\s*z\s*=\s*(?<baseZ>-?\d+)\s*\}\)\s*end.*?roomWidth\s*=\s*(?<width>\d+).*?roomHeight\s*=\s*(?<height>\d+)'
    $match = [regex]::Match($LuaSource, $pattern)
    if (-not $match.Success) {
        throw 'This Project RV version does not use the recognized fixed bus-room layout. No save files were changed.'
    }

    [pscustomobject]@{
        FirstSlot = [int] $match.Groups['first'].Value
        LastSlot = [int] $match.Groups['last'].Value
        StepX = [int] $match.Groups['step'].Value
        BaseX = [int] $match.Groups['baseX'].Value
        BaseY = [int] $match.Groups['baseY'].Value
        BaseZ = [int] $match.Groups['baseZ'].Value
        Width = [int] $match.Groups['width'].Value
        Height = [int] $match.Groups['height'].Value
    }
}

function Get-RoomFromPlayerCoordinates {
    param(
        [Parameter(Mandatory)] $Layout,
        [Parameter(Mandatory)][int] $PlayerX,
        [Parameter(Mandatory)][int] $PlayerY,
        [Parameter(Mandatory)][int] $PlayerZ
    )

    for ($slot = $Layout.FirstSlot; $slot -le $Layout.LastSlot; $slot++) {
        $roomX = $Layout.BaseX + ($slot * $Layout.StepX)
        $roomY = $Layout.BaseY
        $roomZ = $Layout.BaseZ
        if ($PlayerX -ge $roomX -and $PlayerX -lt ($roomX + $Layout.Width) -and
            $PlayerY -ge $roomY -and $PlayerY -lt ($roomY + $Layout.Height) -and
            $PlayerZ -eq $roomZ) {
            return [pscustomobject]@{
                SlotIndex = $slot
                RoomNumber = ($slot + 1)
                X = $roomX
                Y = $roomY
                Z = $roomZ
                Width = $Layout.Width
                Height = $Layout.Height
            }
        }
    }

    throw "Player coordinates ($PlayerX,$PlayerY,$PlayerZ) are not inside a Project RV bus room in the installed mod version."
}

function Get-MapChunkPath {
    param([Parameter(Mandatory)] $Room)
    # Build 42 IsoChunk stores an 8-by-8 tile chunk under map/<chunkX>/<chunkY>.bin.
    $chunkX = [int][Math]::Floor($Room.X / 8.0)
    $chunkY = [int][Math]::Floor($Room.Y / 8.0)
    $lastChunkX = [int][Math]::Floor(($Room.X + $Room.Width - 1) / 8.0)
    $lastChunkY = [int][Math]::Floor(($Room.Y + $Room.Height - 1) / 8.0)
    if ($lastChunkX -ne $chunkX -or $lastChunkY -ne $chunkY) {
        throw 'This Project RV room spans multiple Build 42 chunks. No files were changed because multi-chunk templates require a separate layout audit.'
    }
    [pscustomobject]@{
        X = $chunkX
        Y = $chunkY
        RelativePath = Join-Path (Join-Path 'map' $chunkX) ("$chunkY.bin")
    }
}

function Get-SaveModList {
    param([Parameter(Mandatory)][string] $ResolvedSavePath)
    $modsFile = Join-Path $ResolvedSavePath 'mods.txt'
    if (-not (Test-Path -LiteralPath $modsFile -PathType Leaf)) {
        throw "Save does not contain mods.txt: $ResolvedSavePath"
    }
    return Get-Content -LiteralPath $modsFile -Raw
}

function Get-SaveMapSignature {
    param([Parameter(Mandatory)][string] $ResolvedSavePath)
    $path = Join-Path $ResolvedSavePath 'map_ver.bin'
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Save is missing map_ver.bin: $ResolvedSavePath"
    }
    $bytes = [System.IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 8) {
        throw "map_ver.bin is too short to identify its map format: $path"
    }
    $version = (($bytes[0] -shl 24) -bor ($bytes[1] -shl 16) -bor ($bytes[2] -shl 8) -bor $bytes[3])
    $length = (($bytes[4] -shl 24) -bor ($bytes[5] -shl 16) -bor ($bytes[6] -shl 8) -bor $bytes[7])
    if ($length -lt 0 -or (8 + ($length * 2)) -gt $bytes.Length) {
        throw "map_ver.bin has an invalid map-name length: $path"
    }
    $name = [System.Text.StringBuilder]::new($length)
    for ($index = 0; $index -lt $length; $index++) {
        $codePoint = ($bytes[8 + ($index * 2)] -shl 8) -bor $bytes[9 + ($index * 2)]
        [void]$name.Append([char]$codePoint)
    }
    [pscustomobject]@{ Version = $version; MapName = $name.ToString() }
}

function Assert-SaveHasProjectRV {
    param([Parameter(Mandatory)][string] $ResolvedSavePath)
    $mods = Get-SaveModList -ResolvedSavePath $ResolvedSavePath
    if ($mods -notmatch '(?im)^\s*mod\s*=\s*PROJECTRVInterior42\s*,?\s*$') {
        throw "Save '$ResolvedSavePath' was not created with PROJECTRVInterior42 enabled. Import stopped."
    }
}

function Assert-ProjectZomboidClosed {
    $process = Get-Process -ErrorAction SilentlyContinue |
        Where-Object { $_.ProcessName -like 'ProjectZomboid*' } |
        Select-Object -First 1
    if ($process) {
        throw 'Close Project Zomboid before importing. The manager will not edit a save while the game process is running.'
    }
}

function Get-TemplateDirectory {
    param([Parameter(Mandatory)][string] $ResolvedTemplateRoot, [Parameter(Mandatory)][string] $TemplateName)
    if ($TemplateName -notmatch '^[A-Za-z0-9][A-Za-z0-9._ -]{0,79}$' -or $TemplateName -in '.', '..') {
        throw 'Template name may contain only letters, numbers, spaces, dots, underscores, and hyphens.'
    }
    return Join-Path $ResolvedTemplateRoot $TemplateName
}

function Export-RVInterior {
    param(
        [Parameter(Mandatory)][string] $ResolvedSavePath,
        [Parameter(Mandatory)][string] $ResolvedTemplateRoot,
        [Parameter(Mandatory)][string] $TemplateName,
        [Parameter(Mandatory)] $Install
    )

    if ($X -eq [int]::MinValue -or $Y -eq [int]::MinValue -or $Z -eq [int]::MinValue) {
        throw 'Export requires -X, -Y, and -Z from the player standing inside the customized bus.'
    }
    Assert-SaveHasProjectRV -ResolvedSavePath $ResolvedSavePath
    $mapSignature = Get-SaveMapSignature -ResolvedSavePath $ResolvedSavePath
    if ($mapSignature.MapName -notmatch '(?i)(^|;)map_distanciado(;|$)') {
        throw 'The source save map list does not include Project RV Interior map_distanciado.'
    }
    $layout = Get-BusRoomLayout -LuaSource $Install.LuaSource
    $room = Get-RoomFromPlayerCoordinates -Layout $layout -PlayerX $X -PlayerY $Y -PlayerZ $Z
    $chunk = Get-MapChunkPath -Room $room
    $sourceChunk = Join-Path $ResolvedSavePath $chunk.RelativePath
    if (-not (Test-Path -LiteralPath $sourceChunk -PathType Leaf)) {
        throw "The save does not contain the expected room chunk: $sourceChunk"
    }

    $templatePath = Get-TemplateDirectory -ResolvedTemplateRoot $ResolvedTemplateRoot -TemplateName $TemplateName
    if (Test-Path -LiteralPath $templatePath) {
        throw "Template already exists and will not be overwritten: $templatePath"
    }

    $sourceHashBefore = (Get-FileHash -LiteralPath $sourceChunk -Algorithm SHA256).Hash
    $sourceItem = Get-Item -LiteralPath $sourceChunk
    $stagePath = Join-Path $ResolvedTemplateRoot ('.staging-' + [guid]::NewGuid().ToString('N'))
    try {
        New-Item -ItemType Directory -Path $stagePath -Force | Out-Null
        $payloadPath = Join-Path $stagePath $chunk.RelativePath
        New-Item -ItemType Directory -Path (Split-Path -Parent $payloadPath) -Force | Out-Null
        Copy-Item -LiteralPath $sourceChunk -Destination $payloadPath

        $sourceHashAfter = (Get-FileHash -LiteralPath $sourceChunk -Algorithm SHA256).Hash
        $payloadHash = (Get-FileHash -LiteralPath $payloadPath -Algorithm SHA256).Hash
        if ($sourceHashBefore -ne $sourceHashAfter -or $sourceHashBefore -ne $payloadHash) {
            throw 'The source chunk changed during export. The incomplete staging copy will be removed; retry with a stable save.'
        }

        $manifest = [ordered]@{
            schemaVersion = 1
            exportedAt = (Get-Date).ToUniversalTime().ToString('o')
            sourceSaveName = Split-Path -Leaf $ResolvedSavePath
            map = [ordered]@{ formatVersion = $mapSignature.Version; mapName = $mapSignature.MapName }
            roomType = 'bus'
            roomNumber = $room.RoomNumber
            roomSlotIndex = $room.SlotIndex
            room = [ordered]@{ x = $room.X; y = $room.Y; z = $room.Z; width = $room.Width; height = $room.Height }
            chunk = [ordered]@{ x = $chunk.X; y = $chunk.Y; relativePath = $chunk.RelativePath; sha256 = $payloadHash; length = $sourceItem.Length }
            projectRV = [ordered]@{ modId = 'PROJECTRVInterior42'; workshopId = $Install.WorkshopId; modVersion = $Install.ModVersion; vehicleTypesSha256 = $Install.LuaHash }
            notes = 'Contains one Build 42 saved map chunk. Vehicle-to-room assignment must be made in each destination save.'
        }
        $manifestPath = Join-Path $stagePath 'manifest.json'
        $manifest | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $manifestPath -Encoding utf8NoBOM
        Move-Item -LiteralPath $stagePath -Destination $templatePath
    }
    catch {
        if (Test-Path -LiteralPath $stagePath) {
            Remove-Item -LiteralPath $stagePath -Recurse -Force
        }
        throw
    }

    Write-Host "Exported bus room $($room.RoomNumber) (mod slot index $($room.SlotIndex)) from '$ResolvedSavePath'."
    Write-Host "Room origin: X=$($room.X), Y=$($room.Y), Z=$($room.Z); size $($room.Width)x$($room.Height)."
    Write-Host "Payload: $(Join-Path $templatePath $chunk.RelativePath)"
    Write-Host "Manifest: $(Join-Path $templatePath 'manifest.json')"
}

function New-AssignmentSnippet {
    param([Parameter(Mandatory)] $Room)

    return @"
local p=getPlayer(); local v=p and (p:getVehicle() or p:getUseableVehicle()); assert(v,'Be seated in or stand next to the target bus.'); local d=v:getModData(); if not d.projectRV_uniqueId then d.projectRV_uniqueId=tostring(ZombRand(1,99999999)) end; d.projectRV_type='bus'; local id=tostring(d.projectRV_uniqueId); local md=ModData.getOrCreate('modPROJECTRVInterior'); local a=md.AssignedRoomsbus or {}; for k,r in pairs(a) do if k~=id and r and r.x==$($Room.X) and r.y==$($Room.Y) and r.z==$($Room.Z) then error('Room slot is already assigned to another bus ID: '..tostring(k)) end end; a[id]={x=$($Room.X),y=$($Room.Y),z=$($Room.Z)}; md.AssignedRoomsbus=a; if ModData.transmit then ModData.transmit('modPROJECTRVInterior') end; print('Project RV bus '..id..' assigned to template room at $($Room.X),$($Room.Y),$($Room.Z)')
"@
}

function Import-RVInterior {
    param(
        [Parameter(Mandatory)][string] $ResolvedSavePath,
        [Parameter(Mandatory)][string] $ResolvedTemplateRoot,
        [Parameter(Mandatory)][string] $TemplateName,
        [Parameter(Mandatory)] $Install,
        [Parameter(Mandatory)][bool] $AllowOverwrite
    )

    Assert-ProjectZomboidClosed
    Assert-SaveHasProjectRV -ResolvedSavePath $ResolvedSavePath
    $mapSignature = Get-SaveMapSignature -ResolvedSavePath $ResolvedSavePath
    $templatePath = Get-TemplateDirectory -ResolvedTemplateRoot $ResolvedTemplateRoot -TemplateName $TemplateName
    $manifestPath = Join-Path $templatePath 'manifest.json'
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        throw "Template manifest was not found: $manifestPath"
    }

    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    if ($manifest.schemaVersion -ne 1 -or $manifest.roomType -ne 'bus' -or $manifest.projectRV.modId -ne 'PROJECTRVInterior42') {
        throw 'The template manifest is not a supported Project RV bus template.'
    }
    if ($manifest.projectRV.vehicleTypesSha256 -ne $Install.LuaHash) {
        throw 'The template was exported with a different Project RV room layout. Import stopped to avoid placing its chunk at incompatible coordinates.'
    }
    if ([int]$manifest.map.formatVersion -ne $mapSignature.Version -or
        $manifest.map.mapName -notmatch '(?i)(^|;)map_distanciado(;|$)' -or
        $mapSignature.MapName -notmatch '(?i)(^|;)map_distanciado(;|$)') {
        throw 'Source and destination use a different Build 42 map format or the destination does not include map_distanciado.'
    }

    $room = [pscustomobject]@{
        RoomNumber = [int] $manifest.roomNumber
        SlotIndex = [int] $manifest.roomSlotIndex
        X = [int] $manifest.room.x
        Y = [int] $manifest.room.y
        Z = [int] $manifest.room.z
        Width = [int] $manifest.room.width
        Height = [int] $manifest.room.height
    }
    $chunk = Get-MapChunkPath -Room $room
    if ([int]$manifest.chunk.x -ne $chunk.X -or [int]$manifest.chunk.y -ne $chunk.Y -or $manifest.chunk.relativePath -ne $chunk.RelativePath) {
        throw 'The template manifest chunk coordinates do not match its room coordinates.'
    }

    $payloadPath = Join-Path $templatePath $chunk.RelativePath
    if (-not (Test-Path -LiteralPath $payloadPath -PathType Leaf)) {
        throw "Template map chunk is missing: $payloadPath"
    }
    $payloadHash = (Get-FileHash -LiteralPath $payloadPath -Algorithm SHA256).Hash
    if ($payloadHash -ne $manifest.chunk.sha256) {
        throw 'Template chunk hash does not match manifest. Import stopped.'
    }

    $destinationChunk = Join-Path $ResolvedSavePath $chunk.RelativePath
    $destinationExists = Test-Path -LiteralPath $destinationChunk -PathType Leaf
    if ($destinationExists) {
        $destinationHash = (Get-FileHash -LiteralPath $destinationChunk -Algorithm SHA256).Hash
        if ($destinationHash -eq $payloadHash) {
            Write-Host 'Destination already contains this exact room chunk; no map file was changed.'
        }
        elseif (-not $AllowOverwrite) {
            throw "Destination chunk already exists. Review it, then rerun with -ConfirmOverwrite to create a backup and replace it: $destinationChunk"
        }
    }

    $backupRoot = Join-Path $ResolvedTemplateRoot '_Backups'
    $backupPath = Join-Path $backupRoot ((Split-Path -Leaf $ResolvedSavePath) + '-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    foreach ($relative in @('global_mod_data.bin', 'vehicles.db')) {
        $source = Join-Path $ResolvedSavePath $relative
        if (Test-Path -LiteralPath $source -PathType Leaf) {
            $backupFile = Join-Path $backupPath $relative
            Copy-Item -LiteralPath $source -Destination $backupFile
            if ((Get-FileHash -LiteralPath $backupFile -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash) {
                throw "Backup verification failed for $relative. The save was not modified."
            }
        }
    }
    if ($destinationExists -and $destinationHash -ne $payloadHash) {
        $backupChunk = Join-Path $backupPath $chunk.RelativePath
        New-Item -ItemType Directory -Path (Split-Path -Parent $backupChunk) -Force | Out-Null
        Copy-Item -LiteralPath $destinationChunk -Destination $backupChunk
        if ((Get-FileHash -LiteralPath $backupChunk -Algorithm SHA256).Hash -ne $destinationHash) {
            throw 'The destination chunk backup did not verify. The save was not modified.'
        }
    }

    if (-not ($destinationExists -and $destinationHash -eq $payloadHash)) {
        $destinationDirectory = Split-Path -Parent $destinationChunk
        New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
        $temporaryChunk = Join-Path $destinationDirectory ('.' + [guid]::NewGuid().ToString('N') + '.rvinterior.tmp')
        try {
            Copy-Item -LiteralPath $payloadPath -Destination $temporaryChunk
            if ((Get-FileHash -LiteralPath $temporaryChunk -Algorithm SHA256).Hash -ne $payloadHash) {
                throw 'Temporary imported chunk failed hash verification.'
            }
            if ($destinationExists) {
                Move-Item -LiteralPath $temporaryChunk -Destination $destinationChunk -Force
            }
            else {
                Move-Item -LiteralPath $temporaryChunk -Destination $destinationChunk
            }
        }
        catch {
            if (Test-Path -LiteralPath $temporaryChunk) {
                Remove-Item -LiteralPath $temporaryChunk -Force
            }
            throw
        }
    }

    Write-Host "Imported bus room $($room.RoomNumber) into '$ResolvedSavePath'."
    Write-Host "Backup folder: $backupPath"
    Write-Host 'The copied map chunk is at the original Project RV room coordinates.'
    Write-Host 'After starting the destination save, run this one-line Lua snippet in the debug Lua console while seated in or standing beside the target bus:'
    Write-Host (New-AssignmentSnippet -Room $room)
}

try {
    $resolvedSavePath = Resolve-FullPath -Path $SavePath
    $resolvedTemplateRoot = Resolve-FullPath -Path $TemplateRoot
    if (-not (Test-Path -LiteralPath $resolvedSavePath -PathType Container)) {
        throw "Save directory does not exist: $resolvedSavePath"
    }
    if (-not (Test-Path -LiteralPath $resolvedTemplateRoot -PathType Container)) {
        New-Item -ItemType Directory -Path $resolvedTemplateRoot -Force | Out-Null
    }

    $install = Get-ProjectRVInstall -WorkshopContentRoot (Resolve-FullPath -Path $WorkshopRoot)
    if ($Action -eq 'export') {
        Export-RVInterior -ResolvedSavePath $resolvedSavePath -ResolvedTemplateRoot $resolvedTemplateRoot -TemplateName $Template -Install $install
    }
    else {
        Import-RVInterior -ResolvedSavePath $resolvedSavePath -ResolvedTemplateRoot $resolvedTemplateRoot -TemplateName $Template -Install $install -AllowOverwrite ([bool]$ConfirmOverwrite)
    }
}
catch {
    Write-Error -ErrorRecord $_
    exit 1
}
