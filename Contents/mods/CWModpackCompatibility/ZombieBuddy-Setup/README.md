# Chaosworld ZombieBuddy and Viewpoint setup

This optional Windows helper installs the prerequisites needed for Project
Viewpoint on Project Zomboid 42.21. It is never executed by Project Zomboid or
by enabling CW Modpack Compatibility. A user must run it explicitly.

The CMD launcher downloads the latest verified
[ZombieBuddy Friends](https://github.com/Bokicks-Labs/ZombieBuddy-Friends/releases/latest)
package. That package installs the newest stable official ZombieBuddy 2.x JAR,
the matching Build 42 Lua/media files, and the pinned Windows native-loader
fix. It does not need the removed original ZombieBuddy Workshop item.
Enabling this CW mod alone never installs anything.

## Quick setup

1. Subscribe to and download CW Modpack Compatibility and Project Viewpoint.
2. Close Project Zomboid and local Coop/server processes.
3. Run `Run-ZombieBuddy-Viewpoint-Setup.cmd` from this folder.
4. The helper checks the package SHA-256 and runs its installer. It backs up
   replaced files and enables normal and alternate Windows launch modes.
5. Start Project Zomboid and approve the specific Viewpoint JAR when
   ZombieBuddy prompts. Do not approve unexpected Java mods.

The CMD launcher uses an execution-policy override for that PowerShell process
only. It does not change the machine or user execution policy.

## Direct PowerShell use

```powershell
# Install or update from the latest ZombieBuddy Friends release
.\Install-ZombieBuddy-Friends.ps1

# Set an explicit game path if Steam library discovery fails
.\Install-ZombieBuddy-Friends.ps1 -ProjectZomboidPath 'D:\SteamLibrary\steamapps\common\ProjectZomboid'

# Inspect the older CW helper without changing anything
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Status

# Restore the newest DLL and JAR backups made by the older CW helper
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Restore
```

The Friends installer stores local mod backups under
`%USERPROFILE%\Zomboid\backups\ZombieBuddy-Friends` and agent/launcher backups
under `%USERPROFILE%\Zomboid\backups\CW-ZombieBuddy`. It does not edit saves,
Workshop subscriptions, or ZombieBuddy approvals. Viewpoint's Java JAR is
client-side; the dedicated server does not need this native change solely for
Viewpoint.

The native DLL cannot be carried as a Workshop payload. The Friends package
downloads and verifies it when needed. The older official Windows installer
requires the removed ZombieBuddy Workshop item, so this launcher does not use
it. Java mods loaded by ZombieBuddy have unrestricted process access.

## Bundled versions and hashes

| File | Source/version | SHA-256 |
| --- | --- | --- |
| `ZombieBuddyInstaller_v4.2.exe` (downloaded on demand; not included) | Zed's official GitHub release `windows_installer_4.2` | `2A52466AFE804FECE5E88868EEF75A70E8964D3E4E01A3629B57CF6FF19E24B3` |
| `ZombieBuddy-2.3.3-B42.21-Fix.jar` | Antikristianos' unchanged temporary-fix release 1.2 based on ZombieBuddy 2.3.3; bundled with MIT license | `909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102` |
| `zbNative.dll` (downloaded on demand; not included) | [Minimal public native-loader release](https://github.com/Bokicks-Labs/ZombieBuddy-Windows-Native-Fix/releases/tag/v2.3.3-pz42.21-native1) | `49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE` |

## Windows hostname repair

The affected Windows client's log shows
`java.lang.InternalError: platform encoding not initialized` during
ZombieBuddy's authors-list request, followed by the same error in the server
browser and direct connect. A Java-only patch failed the full-game test.
The successful client test changed ZombieBuddy's native Windows loader to load
`jre64\bin\instrument.dll` by full path. The process then mapped only the
bundled-JRE Java DLLs, hostname connection worked, and Viewpoint ran. The
download URL and hash are fixed in the setup script; an upstream update will
not silently change the file it installs. Fresh-restart and other-PC tests
are still recommended.

See `THIRD-PARTY-NOTICES.md` and the included license files for provenance,
credit, and upstream links.
