# Chaosworld ZombieBuddy and Viewpoint setup

This optional Windows helper installs the prerequisites needed for Project
Viewpoint on Project Zomboid 42.21. It is never executed by Project Zomboid or
by enabling CW Modpack Compatibility. A user must run it explicitly.

## Quick setup

1. Subscribe to and download the original ZombieBuddy and Project Viewpoint.
2. Close Project Zomboid and local Coop/server processes.
3. Run `Run-ZombieBuddy-Viewpoint-Setup.cmd` from this folder.
4. If the official ZombieBuddy installer opens, review its preview and select
   the launch modes you use. The CW helper continues only after it exits.
5. Start Project Zomboid and approve the specific Viewpoint JAR when
   ZombieBuddy prompts. Do not approve unexpected Java mods.

The CMD launcher uses an execution-policy override for that PowerShell process
only. It does not change the machine or user execution policy.

## Direct PowerShell use

```powershell
# Inspect without changing anything
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Status

# Install the fix; launch the bundled official installer if the base agent is missing
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install -LaunchOfficialInstaller

# Preview filesystem changes
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install -WhatIf

# Target a separate Windows dedicated-server installation
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Install `
    -ProjectZomboidPath 'C:\GameServers\ProjectZomboid'

# Restore the newest backup made by this helper
.\Setup-ZombieBuddyForViewpoint.ps1 -Action Restore
```

Backups are stored under
`%USERPROFILE%\Zomboid\backups\CW-ZombieBuddy`. The helper does not edit saves,
Workshop subscriptions, ZombieBuddy approvals, Steam launch options, security
policy, or unrelated mods. The official installer remains responsible for the
base native agent and launcher setup.

The installer is not Authenticode-signed. Its bundled SHA-256 is checked before
execution. Users should decide whether they trust the upstream project before
running it; Java mods loaded by ZombieBuddy have unrestricted process access.

## Bundled versions and hashes

| File | Source/version | SHA-256 |
| --- | --- | --- |
| `ZombieBuddyInstaller_v4.2.exe` | Zed's official GitHub release `windows_installer_4.2` | `2A52466AFE804FECE5E88868EEF75A70E8964D3E4E01A3629B57CF6FF19E24B3` |
| `ZombieBuddy-2.3.3-B42.21-Fix.jar` | Antikristianos temporary-fix release 1.2, based on ZombieBuddy 2.3.3 | `909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102` |

See `THIRD-PARTY-NOTICES.md` and the included license files for provenance,
credit, and upstream links.
