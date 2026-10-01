# Third-party notices

CW Modpack Compatibility is not affiliated with or endorsed by ZombieBuddy,
Project Viewpoint, their authors, The Indie Stone, Valve, or Steam.

## ZombieBuddy

- Author: Andrey "Zed" Zaikin (`zed-0xff`)
- Project: https://github.com/zed-0xff/ZombieBuddy
- Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3619862853
- Installer release downloaded on demand: `windows_installer_4.2`
- Release page: https://github.com/zed-0xff/ZombieBuddy/releases/tag/windows_installer_4.2
- License: MIT; see `LICENSE-ZombieBuddy.txt`

The installer is not included because the Project Zomboid Workshop uploader
forbids `.exe` files. When explicitly requested, the helper downloads the
unmodified GitHub release asset `ZombieBuddyInstaller_v4.2.exe`, verifies its
pinned SHA-256 before launching it, and deletes the temporary download after it
exits. The upstream installer is not Authenticode-signed.

## Temporary Project Zomboid 42.21 compatibility fix

- Maintainer: Antikristianos
- Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3807686870
- Bundled release: package 1.2, agent version 2.3.3
- Compatibility marker: `b42.20.4-b42.21-list-loader-3`
- License: MIT; see `LICENSE-Temporary-Fix.txt`

The replacement JAR is based on ZombieBuddy 2.3.3 by Zed and the Build 42.21
temporary-fix package 1.2. CW network-fix revision 1 additionally changes the
two upstream HTTP clients from eager static initialization to lazy holder
initialization. It targets a suspected early initialization path associated
with the observed Java 25 hostname error. All three changes remain
covered by the upstream MIT license and are distributed for the private
Chaosworld friend group.

If either upstream author asks for bundled material to be removed, CW will
remove it. When official ZombieBuddy includes the required 42.21 loader repair,
this temporary JAR and helper should be retired rather than reapplied.
