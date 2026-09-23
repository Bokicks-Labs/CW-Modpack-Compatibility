# CW Mod Options Search

`CWModOptionsSearch` is an optional, client-only submod for Project Zomboid
Build 42. Enable it after `CWModpackCompatibility`.

Open **Options > Mods** and select **Search Mod Options...** in the first mod
options section. Type at least two characters to search registered mod names, option
labels, descriptions, and tooltips. Double-click a result, or select it and use
**Go to setting**, to scroll the existing page to that option.

The submod does not change option values, `ModOptions.ini`, saves, networking,
or server state. It does not hide or rebuild controls; it only indexes PZAPI's
registered options and navigates the existing page.

## Compatibility boundary

Build 42.20 does not expose a public hook for extending the Mod Options screen.
The launcher is registered through `PZAPI.ModOptions`. A narrow
`MainOptions:close()` wrapper closes the separate search window with the Options
screen. Options made outside `PZAPI.ModOptions` or text drawn only by custom
controls cannot be indexed.
