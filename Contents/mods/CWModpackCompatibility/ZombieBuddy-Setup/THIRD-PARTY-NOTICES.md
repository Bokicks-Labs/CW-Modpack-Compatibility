# Third-party notices

CW Modpack Compatibility is not affiliated with or endorsed by ZombieBuddy,
Project Viewpoint, their authors, The Indie Stone, Valve, or Steam.

## ZombieBuddy

- Author: Andrey "Zed" Zaikin (`zed-0xff`)
- Project: https://github.com/zed-0xff/ZombieBuddy
- Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3619862853
- Bundled installer release: `windows_installer_4.2`
- Release page: https://github.com/zed-0xff/ZombieBuddy/releases/tag/windows_installer_4.2
- License: MIT; see `LICENSE-ZombieBuddy.txt`

The bundled installer is the unmodified GitHub release asset
`ZombieBuddyInstaller_v4.2.exe`. It is not Authenticode-signed. CW verifies its
bundled SHA-256 before launching it.

## Temporary Project Zomboid 42.21 compatibility fix

- Maintainer: Antikristianos
- Workshop: https://steamcommunity.com/sharedfiles/filedetails/?id=3807686870
- Bundled release: package 1.2, agent version 2.3.3
- Compatibility marker: `b42.20.4-b42.21-list-loader-3`
- License: MIT; see `LICENSE-Temporary-Fix.txt`

The replacement JAR is based on ZombieBuddy 2.3.3 by Zed. It changes the loader
boundary needed by Project Zomboid 42.21 and is redistributed here unchanged
from temporary-fix package 1.2 for the private Chaosworld friend group.

If either upstream author asks for bundled material to be removed, CW will
remove it. When official ZombieBuddy includes the required 42.21 loader repair,
this temporary JAR and helper should be retired rather than reapplied.
