# Chaosworld ZombieBuddy and Viewpoint setup

This optional Windows helper installs the prerequisites needed for Project
Viewpoint on Project Zomboid 42.21. It is never executed by Project Zomboid or
by enabling CW Modpack Compatibility. A user must run it explicitly.

The helper installs two pinned files: Antikristianos' unchanged 42.21
compatibility JAR bundled here, and the Windows native-loader fix downloaded
from the public release linked below. Enabling the Workshop mod alone never
installs anything.

## Quick setup

1. Subscribe to and download the original ZombieBuddy and Project Viewpoint.
2. Close Project Zomboid and local Coop/server processes.
3. Run `Run-ZombieBuddy-Viewpoint-Setup.cmd` from this folder.
4. If the base agent is missing, the helper downloads Zed's pinned official
   ZombieBuddy installer from GitHub. Review its preview and select the launch
   modes you use. The CW helper continues only after it exits. It then
   downloads and verifies the native fix, backs up the existing DLL and JAR,
   and installs both fixes.
5. Start Project Zomboid and approve the specific Viewpoint JAR when
   ZombieBuddy prompts. Do not approve unexpected Java mods.

The CMD launcher uses an execution-policy override for that PowerShell process
only. It does not change the machine or user execution policy.

## Direct PowerShell use

```powershell
# Inspect without changing anything
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Status

# Install both fixes; launch the official installer if the base agent is missing
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install -LaunchOfficialInstaller

# Preview filesystem changes
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install -WhatIf

# Set an explicit game path if Steam library discovery fails
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install `
    -ProjectZomboidPath 'D:\SteamLibrary\steamapps\common\ProjectZomboid'

# Restore the newest DLL and JAR backups for this installation
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Restore
```

Backups are stored under
`%USERPROFILE%\Zomboid\backups\CW-ZombieBuddy`. The helper does not edit saves,
Workshop subscriptions, ZombieBuddy approvals, Steam launch options, security
policy, or unrelated mods. The official installer remains responsible for the
base native agent and launcher setup. Viewpoint's Java JAR is client-side;
the dedicated server does not need this native change solely for Viewpoint.

The official installer and patched native DLL cannot be carried as executable
Workshop payloads. The helper downloads the official installer only when
explicitly requested and the native DLL only during an explicit Install. Both
downloads have pinned SHA-256 checks; temporary copies are removed after use.
The installer and native DLL are not Authenticode-signed. Review their
provenance before use; Java mods loaded by ZombieBuddy have unrestricted
process access.

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
