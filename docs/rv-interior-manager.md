# Project RV Interior Manager

`Scripts/RVInteriorManager.ps1` exports the saved Build 42 map chunk for one Project RV bus room and imports that chunk into another save. It uses the installed Project RV room layout, checks the save's mod list and map format, and stores templates under `%USERPROFILE%\Zomboid\RVInteriorTemplates` by default.

The current Build 42 Project RV bus rooms are fixed map locations. For the customized bus investigated here, player coordinates `23822,12122,0` identify room 22 (zero-based slot index 21), with origin `23820,12120,0`. The room is within one 8-by-8-tile save chunk: `map\2977\1515.bin`.

## Export

Close or leave the source save unchanged, then pass the save path and player coordinates recorded while inside the bus:

```powershell
& 'C:\path\to\CW-Modpack-Compatibility\Scripts\RVInteriorManager.ps1' export `
    -Template 'MyBus' `
    -SavePath (Join-Path $env:USERPROFILE 'Zomboid\Saves\Sandbox\BusTemplete') `
    -X 23822 -Y 12122 -Z 0
```

The command copies one `map/<chunkX>/<chunkY>.bin` file and writes a manifest containing the room origin, slot, installed Lua hash, Build 42 map version, and payload hash. It refuses to replace an existing template. Export checks that the chunk stays unchanged while being copied, so another world may remain open if the selected source save is a stable copy.

## Import

Close Project Zomboid before importing. The destination save must have `PROJECTRVInterior42` enabled and include `map_distanciado` in its map list. The installed `RVVehicleTypes.lua` hash and map format must match the template.

```powershell
& 'C:\path\to\CW-Modpack-Compatibility\Scripts\RVInteriorManager.ps1' import `
    -Template 'MyBus' `
    -SavePath (Join-Path $env:USERPROFILE 'Zomboid\Saves\Sandbox\NewWorld')
```

If the destination already has different data in the target map chunk, import stops. Review that chunk and rerun with `-ConfirmOverwrite` only when replacing it is intended:

```powershell
... import -Template 'MyBus' -SavePath $destination -ConfirmOverwrite
```

Before writing, import makes a unique backup folder under `RVInteriorTemplates\_Backups`, including the destination map chunk when it exists and the destination `global_mod_data.bin` and `vehicles.db` files. The chunk write is staged and hash-checked before replacement.

## Assign the destination bus

Project RV keys room assignments by a generated per-save vehicle ID. The utility therefore does not copy `global_mod_data.bin` from the source save. After importing the chunk, start the destination save and run the printed one-line Lua statement in the debug Lua console while seated in or standing beside the target bus. It binds that bus to the template room; it stops if another vehicle already owns that room slot.

The `isoregiondata` and `chunkdata` files are Build 42 derived region and collision data rather than room tile contents. The template does not transplant them: `chunkdata` covers a much larger area than this bus room, and copying it could bring unrelated world state. If the imported room has wall or floor edits that affect pathing, verify walkability in the destination save after import.

The manager does not edit Project RV Workshop files, repack mods, copy a whole save, or delete existing save data. `-WorkshopRoot` can override the default Workshop content directory if Steam is installed elsewhere.
