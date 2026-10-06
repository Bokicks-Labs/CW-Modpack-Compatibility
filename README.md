# CW Modpack Compatibility

Private source repository for the Chaosworld Project Zomboid Build 42 compatibility mod.

The Workshop payloads are kept under `Contents/mods`. The core `CWModpackCompatibility` mod contains targeted compatibility fixes for the Chaosworld modpack, including the Lifestyle hidden-skill display bridge and automatic feature ownership for Nature's Call and Brush Your Damn Teeth.

It also contains two optional client-only submods. `CWAudioMixer` provides discovered-sound group and per-sound volume controls; `CWModOptionsSearch` adds search-and-jump navigation to the Build 42 Mod Options page. See [CW Audio Mixer](docs/audio-mixer.md) and [CW Mod Options Search](docs/mod-options-search.md).

## Workshop copy

- [Current Workshop description](docs/workshop-description.md)
- [Steam-formatted version 1.1.14 changelog](docs/steam-changelog-1.1.14.txt)
- [Version 1.1.14 changelog](docs/workshop-changelog-1.1.14.md)
- [Version 1.1.13 changelog](docs/workshop-changelog-1.1.13.md)
- [Lifestyle feature ownership](docs/lifestyle-feature-ownership.md)

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

The copied payload has ID `CWModpackCompatibility_dev` and a `(Dev)` name; release source and Workshop staging keep `CWModpackCompatibility`. Each activation builds a fresh copy, so rerun the command to remove the junction before testing new edits. Old copies under `LocalTest` may be removed after testing. The script refuses to replace a real folder. If the older `CWModpackCompatibility` junction is installed, remove that junction before activating this one. Enable only the dev ID in the test mod list.

To test only the optional audio submod without changing the core compatibility junction, run:

```powershell
.\Scripts\toggle-pz-audio-mixer-junction.ps1
```

To test only the optional Mod Options Search submod, run:

```powershell
.\Scripts\toggle-pz-mod-options-search-junction.ps1
```

## Workshop staging

After testing a commit, update the local PZ Workshop staging folder with:

```powershell
.\Scripts\publish-to-pz-workshop.ps1
```

This mirrors the core compatibility mod, both optional client submods, and Workshop metadata to `%UserProfile%\Zomboid\Workshop\CW-Modpack-Compatibility`, removes destination-only files inside each managed staging mod, and verifies each staged file set and SHA-256 hashes. It does not edit the Steam installation, base-game media, launchers, DLLs, saves, or the live Steam Workshop cache.

## Repository boundaries

- `Contents/mods/CWModpackCompatibility` is the authoritative mod source.
- `Scripts` contains local-only development, regression, and staging helpers.
- The Steam Workshop item remains separate from this private source repository.
