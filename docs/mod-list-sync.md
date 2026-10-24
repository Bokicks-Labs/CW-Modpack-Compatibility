# Mod list synchronization

[`active-server-mods.csv`](active-server-mods.csv) is always the main copy for synchronizing mods from the local `CWViewpointMP` single-player saved mod profile to multiplayer servers and clients. Keep this filename undated and update this same file whenever the profile changes. Do not create dated sync copies in this folder.

The source profile is the `CWViewpointMP:` entry in `%UserProfile%\Zomboid\Lua\pz_modlist_settings.cfg`. The CSV records one row per in-game mod ID, with its display name and Steam Workshop link where one can be resolved from installed Workshop `mod.info` files. Keep every profile ID, including multiple IDs supplied by one Workshop item. Do not invent a Workshop link for an unresolved or local-only ID.

When syncing a server, use the profile's ordered mod IDs for `Mods=` and the CSV's unique numeric Workshop IDs for `WorkshopItems=`. The CSV is sorted by display name, so its row order is not the server load order. Check dependencies and use the saved profile's order. Ensure clients use the same mod IDs and compatible versions.

This list reflects the saved profile; it does not prove which mods are loaded in a running session or configured in a particular `server.ini`. Compare the target server configuration separately before applying changes. Last reconciled with the local profile: **2026-10-23** (374 distinct mod IDs).

## World sandbox settings

[`server-config/CWViewpointMP_SandboxVars.lua`](server-config/CWViewpointMP_SandboxVars.lua) is the multiplayer server format exported from the local `%UserProfile%\Zomboid\Sandbox Presets\ChaosWorldViewpoint.cfg` preset. It includes all 2,414 base-game and mod sandbox settings in that preset. This is a repository snapshot; exporting it does not change a running server or an existing save.

After changing the preset in game, refresh and verify the snapshot from the repository root:

```powershell
python Scripts/export-sandbox-preset.py
python Scripts/export-sandbox-preset.py --check
```

For a new multiplayer world, back up the target server profile and copy this file to `%UserProfile%\Zomboid\Server\<server-name>_SandboxVars.lua` before starting the server. Compare the target's existing settings first if it already has a world: some sandbox settings affect world generation or are stored in the save and may not take effect retroactively. Use the matching mod list and installed mod versions so the mod-specific settings have their intended owners.
