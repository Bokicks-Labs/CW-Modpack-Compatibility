# Mod list synchronization

[`active-server-mods.csv`](active-server-mods.csv) is always the main copy for synchronizing mods from the local `CWViewpointMP` single-player saved mod profile to multiplayer servers and clients. Keep this filename undated and update this same file whenever the profile changes. Do not create dated sync copies in this folder.

The source profile is the `CWViewpointMP:` entry in `%UserProfile%\Zomboid\Lua\pz_modlist_settings.cfg`. The CSV records one row per in-game mod ID, with its display name and Steam Workshop link where one can be resolved from installed Workshop `mod.info` files. Keep every profile ID, including multiple IDs supplied by one Workshop item. Do not invent a Workshop link for an unresolved or local-only ID.

When syncing a server, use the profile's ordered mod IDs for `Mods=` and the CSV's unique numeric Workshop IDs for `WorkshopItems=`. The CSV is sorted by display name, so its row order is not the server load order. Check dependencies and use the saved profile's order. Ensure clients use the same mod IDs and compatible versions.

This list reflects the saved profile; it does not prove which mods are loaded in a running session or configured in a particular `server.ini`. Compare the target server configuration separately before applying changes. Last reconciled with the local profile: **2026-10-22** (362 distinct mod IDs).
