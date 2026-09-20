# CW Modpack Compatibility

Private source repository for the Chaosworld Project Zomboid Build 42 compatibility mod.

The Workshop payload is kept under `Contents/mods/CWModpackCompatibility`. The repository currently contains targeted compatibility fixes for the Chaosworld modpack, including the Lifestyle hidden-skill display bridge.

## Workshop copy

- [Current Workshop description](docs/workshop-description.md)
- [Version 1.1.11 changelog](docs/workshop-changelog-1.1.11.md)

## Local testing

Run PowerShell from the repository root:

```powershell
.\Scripts\toggle-pz-junction.ps1
```

This creates:

```text
%UserProfile%\Zomboid\mods\CWModpackCompatibility
    -> <repository>\Contents\mods\CWModpackCompatibility
```

This is the same toggle-style junction workflow used by PZ Pulse Expanded. It refuses to replace a real folder. Run the same command again to remove only the junction after testing.

## Workshop staging

After testing a commit, update the local PZ Workshop staging folder with:

```powershell
.\Scripts\publish-to-pz-workshop.ps1
```

This mirrors the repository mod and Workshop metadata to `%UserProfile%\Zomboid\Workshop\CW-Modpack-Compatibility`, removes destination-only files inside that staging mod, and verifies the staged file set and SHA-256 hashes. It does not edit the Steam installation, base-game media, launchers, DLLs, saves, or the live Steam Workshop cache.

## Repository boundaries

- `Contents/mods/CWModpackCompatibility` is the authoritative mod source.
- `Scripts` contains local-only development, regression, and staging helpers.
- The Steam Workshop item remains separate from this private source repository.
