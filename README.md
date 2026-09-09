# CW Modpack Compatibility

Private source repository for the Chaosworld Project Zomboid Build 42 compatibility mod.

The Workshop payload is kept under `Contents/mods/CWModpackCompatibility`. The repository currently contains targeted compatibility fixes for the Chaosworld modpack, including Lifestyle animation and hidden-skill display support.

## Local testing

Run PowerShell from the repository root:

```powershell
.\dev-scripts\toggle-pz-junction.ps1
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
.\dev-scripts\publish-to-pz-workshop.ps1
```

This copies the repository mod and Workshop metadata to `%UserProfile%\Zomboid\Workshop\CW-Modpack-Compatibility` and verifies the staged mod by SHA-256. It does not edit the Steam installation, base-game media, launchers, DLLs, saves, or the live Steam Workshop cache.

## Repository boundaries

- `Contents/mods/CWModpackCompatibility` is the authoritative mod source.
- `dev-scripts` contains local-only development and staging helpers.
- The Steam Workshop item remains separate from this private source repository.
