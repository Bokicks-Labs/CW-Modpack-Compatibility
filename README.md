# CW Modpack Compatibility

Source repository for the Chaosworld Project Zomboid Build 42 compatibility mod.

The Workshop payloads are kept under `Contents/mods`. The core `CWModpackCompatibility` mod contains targeted compatibility fixes for the Chaosworld modpack, including the Lifestyle hidden-skill display bridge and automatic feature ownership for Nature's Call and Brush Your Damn Teeth.

It also contains optional client-only submods. `CWAudioMixer` provides discovered-sound group and per-sound volume controls; `CWModOptionsSearch` adds search-and-jump navigation to the Build 42 Mod Options page. `CWViewpointPatch` contains optional Viewpoint menu-width and world right-click patches, and requires Viewpoint and ZombieBuddy only when enabled. Viewpoint x A-LIFE owns A-Life NPC interactions. See [CW Audio Mixer](docs/audio-mixer.md), [CW Mod Options Search](docs/mod-options-search.md), and [Viewpoint patch work](docs/viewpoint-patch.md).

## Player guide and server mod sync

- [Main mod list for SP-to-MP server sync](docs/active-server-mods.csv). This undated CSV is the main copy for synchronizing mods from the local `CWViewpointMP` single-player saved profile to multiplayer servers and clients. Refresh it whenever that profile changes. It currently contains **373 distinct in-game mod IDs**. See [mod list sync instructions](docs/mod-list-sync.md) for the source, mapping rules, and limits.
- "Yeah, It's Water, Bitch" remains excluded from the active CSV because it is currently malfunctioning.

## Workshop copy

- [Current Workshop description](docs/workshop-description.md)
- [Steam-formatted version 1.2.1 changelog](docs/steam-changelog-1.2.1.txt)
- [Version 1.2.1 changelog](docs/workshop-changelog-1.2.1.md)
- [Steam-formatted version 1.2.0 changelog](docs/steam-changelog-1.2.0.txt)
- [Version 1.2.0 changelog](docs/workshop-changelog-1.2.0.md)

Steam Workshop descriptions may use Steam BBCode such as `[b]`, `[h2]`,
`[list]`, and `[url]`. The CW Steam changelog `.txt` inputs are plain text:
avoid Markdown and BBCode in those entries. Keep readable Markdown release
notes separately.
- [Lifestyle feature ownership](docs/lifestyle-feature-ownership.md)

## Version bumps

Choose the release impact yourself: `patch` for a compatible fix, `minor` for a
compatible feature, or `major` for a breaking change. From this repo, run:

```powershell
.\Scripts\bump-version.ps1 -Bump patch -Summary 'Keep vanilla moodles hidden after UI repositioning.' -Notes @('Keep the vanilla Moodle UI off screen while Moodles in Lua is active.', 'Remove the temporary UI trace.') -WhatIf
```

Remove `-WhatIf` to write the next version. The script updates the core
`mod.info`, Lua runtime version, Workshop description and metadata, README
links, and new Markdown/Steam changelog files. It refuses mismatched version
markers or existing release-note files. Review and edit the generated notes
before publishing. CW Audio Mixer and CW Mod Options Search have independent
versions; this command does not change them.

## Local testing

For a separate Project RV bus-interior backup/import helper, see [Project RV Interior Manager](docs/rv-interior-manager.md). It stores templates and backups under the user Zomboid folder and does not alter Workshop content.

Run PowerShell from the repository root:

```powershell
.\Scripts\toggle-pz-junction.ps1
```

This creates:

```text
%UserProfile%\Zomboid\mods\CWModpackCompatibility_dev
    -> <repository>\LocalTest\CWModpackCompatibility_dev_<timestamp>
```

The copied payload has ID `CWModpackCompatibility_dev` and a `(Dev)` name; release source and Workshop staging keep `CWModpackCompatibility`. The command discovers submods under `Contents/mods` whose `42/mod.info` lists `CWModpackCompatibility` in `require=`, plus the independent `CWViewpointPatch` submod. It creates a `_dev` copy of each, changing only dependencies on `CWModpackCompatibility` to `CWModpackCompatibility_dev`; the Viewpoint patch retains its Viewpoint and ZombieBuddy requirements. Enable the dev core and whichever dev submods you want in the test mod list; disable their release IDs for that test. Each activation builds fresh copies, so rerun the command to remove the junctions before testing new edits. Old copies under `LocalTest` may be removed after testing. The script refuses to replace real folders or unmanaged junctions. If the older `CWModpackCompatibility` junction is installed, remove that junction before activating this one.

The main dev-junction command above can stage all supported dev submods, including Audio Mixer, Mod Options Search and Viewpoint Patch. To toggle only Viewpoint Patch, use `Scripts/toggle-pz-viewpoint-patch-junction.ps1`.

## Workshop staging

After testing a commit, update the local PZ Workshop staging folder with:

```powershell
.\Scripts\publish-to-pz-workshop.ps1
```

This mirrors the core compatibility mod, all three optional client submods, and Workshop metadata to `%UserProfile%\Zomboid\Workshop\CW-Modpack-Compatibility`, removes destination-only files inside each managed staging mod, and verifies each staged file set and SHA-256 hashes. It does not edit the Steam installation, base-game media, launchers, DLLs, saves, or the live Steam Workshop cache.

## Repository boundaries

Every new submod under `Contents/mods` must ship unique `42/poster.png` and `42/icon.png` images that identify that submod, with matching `poster=poster.png` and `icon=icon.png` entries in its `42/mod.info`, so its artwork appears in the in-game mod list. Do not reuse the core mod's artwork or another submod's artwork.

- `Contents/mods/CWModpackCompatibility` is the authoritative mod source.
- `Scripts` contains local-only development, regression, and staging helpers.
- The Steam Workshop item remains separate from this source repository.
