# CW Modpack Compatibility

Private source repository for the Chaosworld Project Zomboid Build 42 compatibility mod.

The Workshop payloads are kept under `Contents/mods`. The core `CWModpackCompatibility` mod contains targeted compatibility fixes for the Chaosworld modpack, including the Lifestyle hidden-skill display bridge and automatic feature ownership for Nature's Call and Brush Your Damn Teeth.

It also contains optional client-only submods. `CWAudioMixer` provides discovered-sound group and per-sound volume controls; `CWModOptionsSearch` adds search-and-jump navigation to the Build 42 Mod Options page. `CWViewpointPatch` currently provides isolated interaction diagnostics for Viewpoint and requires Viewpoint only when enabled. See [CW Audio Mixer](docs/audio-mixer.md), [CW Mod Options Search](docs/mod-options-search.md), and [Viewpoint patch work](docs/viewpoint-patch.md).

## Workshop copy

- [Current Workshop description](docs/workshop-description.md)
- [Steam-formatted version 1.1.15 changelog](docs/steam-changelog-1.1.15.txt)
- [Version 1.1.15 changelog](docs/workshop-changelog-1.1.15.md)
- [Steam-formatted version 1.1.14 changelog](docs/steam-changelog-1.1.14.txt)
- [Version 1.1.14 changelog](docs/workshop-changelog-1.1.14.md)
- [Version 1.1.13 changelog](docs/workshop-changelog-1.1.13.md)
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

The copied payload has ID `CWModpackCompatibility_dev` and a `(Dev)` name; release source and Workshop staging keep `CWModpackCompatibility`. The command discovers submods under `Contents/mods` whose `42/mod.info` lists `CWModpackCompatibility` in `require=`. It creates a `_dev` copy of each and changes that dependency to `CWModpackCompatibility_dev`; newly added submods need no toggle-script edit. Enable the dev core and whichever dev submods you want in the test mod list; disable their release IDs for that test. Each activation builds fresh copies, so rerun the command to remove the junctions before testing new edits. Old copies under `LocalTest` may be removed after testing. The script refuses to replace real folders or unmanaged junctions. If the older `CWModpackCompatibility` junction is installed, remove that junction before activating this one.

To test only the optional audio submod without changing the core compatibility junction, run:

```powershell
.\Scripts\toggle-pz-audio-mixer-junction.ps1
```

To test only the optional Mod Options Search submod, run:

```powershell
.\Scripts\toggle-pz-mod-options-search-junction.ps1
```

To test only the optional Viewpoint diagnostics without changing the CW core, run:

```powershell
.\Scripts\toggle-pz-viewpoint-patch-junction.ps1
```

## Workshop staging

After testing a commit, update the local PZ Workshop staging folder with:

```powershell
.\Scripts\publish-to-pz-workshop.ps1
```

This mirrors the core compatibility mod, both optional client submods, and Workshop metadata to `%UserProfile%\Zomboid\Workshop\CW-Modpack-Compatibility`, removes destination-only files inside each managed staging mod, and verifies each staged file set and SHA-256 hashes. It does not edit the Steam installation, base-game media, launchers, DLLs, saves, or the live Steam Workshop cache.

## Repository boundaries

Every new submod under `Contents/mods` must ship its own `42/poster.png` and `42/icon.png` image files, with matching `poster=poster.png` and `icon=icon.png` entries in its `42/mod.info`, so its artwork appears in the in-game mod list. Reusing the Chaosworld artwork is fine when a submod has no separate design.

- `Contents/mods/CWModpackCompatibility` is the authoritative mod source.
- `Scripts` contains local-only development, regression, and staging helpers.
- The Steam Workshop item remains separate from this private source repository.
