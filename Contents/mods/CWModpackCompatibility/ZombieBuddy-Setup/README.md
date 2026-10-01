# Chaosworld ZombieBuddy and Viewpoint setup

This optional Windows helper installs the prerequisites needed for Project
Viewpoint on Project Zomboid 42.21. It is never executed by Project Zomboid or
by enabling CW Modpack Compatibility. A user must run it explicitly.

## Quick setup

1. Subscribe to and download the original ZombieBuddy and Project Viewpoint.
2. Close Project Zomboid and local Coop/server processes.
3. Run `Run-ZombieBuddy-Viewpoint-Setup.cmd` from this folder.
4. If the base agent is missing, the helper downloads Zed's pinned official
   ZombieBuddy installer from GitHub. Review its preview and select the launch
   modes you use. The CW helper continues only after it exits.
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

The installer cannot be included in a Project Zomboid Workshop item because
the uploader forbids `.exe` files. The helper downloads it only when explicitly
requested, verifies the pinned SHA-256 before execution, and deletes the
temporary download afterward. The installer is not Authenticode-signed. Users
should decide whether they trust the upstream project before running it; Java
mods loaded by ZombieBuddy have unrestricted process access.

## Bundled versions and hashes

| File | Source/version | SHA-256 |
| --- | --- | --- |
| `ZombieBuddyInstaller_v4.2.exe` (downloaded on demand; not included) | Zed's official GitHub release `windows_installer_4.2` | `2A52466AFE804FECE5E88868EEF75A70E8964D3E4E01A3629B57CF6FF19E24B3` |
| `ZombieBuddy-2.3.3-B42.21-Fix.jar` | CW network-fix revision 1, based on Antikristianos temporary-fix release 1.2 and ZombieBuddy 2.3.3 | `6A986C9E4CA962D184D7B87B9F0976DBD8C7399551A61736F0079DD84C9EE572` |

## Java 25 multiplayer network fix

The affected Windows client's log shows
`java.lang.InternalError: platform encoding not initialized` during
ZombieBuddy's authors-list request, followed by the same error in the server
browser and direct connect. One plausible trigger is early initialization of
ZombieBuddy's two static Java `HttpClient` instances. This patch addresses that
specific initialization path; the full game join test is still needed to prove
it resolves the incident.

CW network-fix revision 1 moves both clients into lazy holder classes. They are
created only when ZombieBuddy actually performs the authors-list or Steam
Workshop request during mod loading. The fix does not disable those requests,
change Java-mod approval policy, bypass signature verification, or alter the
42.20.4/42.21 loader compatibility work.

The patched agent passed a Java 25 premain probe using PZ's bundled runtime.
The original JAR also passes that minimal probe, so it does not reproduce the
reported PZ failure. A full client/server join remains the acceptance test.

See `THIRD-PARTY-NOTICES.md` and the included license files for provenance,
credit, and upstream links.
