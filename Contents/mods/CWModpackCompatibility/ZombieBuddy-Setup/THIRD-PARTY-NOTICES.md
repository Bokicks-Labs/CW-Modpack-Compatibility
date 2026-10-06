# Third-party notices

CW Modpack Compatibility is not affiliated with or endorsed by ZombieBuddy,
Project Viewpoint, their authors, The Indie Stone, Valve, or Steam.

The `Run-ZombieBuddy-Viewpoint-Setup.cmd` launcher downloads the latest
ZombieBuddy Friends release from
https://github.com/Bokicks-Labs/ZombieBuddy-Friends/releases/latest and checks
its ZIP against the published SHA-256 before running its installer. That
installer fetches the newest stable official ZombieBuddy 2.x JAR and matching
Build 42 source. The older `Setup-ZombieBuddyForViewpoint.ps1` remains for
status, restore, and existing installations; its official EXE download still
requires the original Workshop item for a fresh installation.

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

The bundled JAR is Antikristianos' unchanged temporary-fix package 1.2, based
on ZombieBuddy 2.3.3. An earlier CW Java-only candidate failed the hostname
test and is no longer bundled.

## Windows native loader fix

- Based on: ZombieBuddy 2.3.3 Windows `zbNative.dll` by Zed
- Release: https://github.com/Bokicks-Labs/ZombieBuddy-Windows-Native-Fix/releases/tag/v2.3.3-pz42.21-native1
- SHA-256: `49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE`
- License: ZombieBuddy MIT; see `LICENSE-ZombieBuddy.txt`

This 5 KB DLL changes only how the loader finds the bundled JRE's
`instrument.dll`. The public release repository contains only a README,
license, and DLL release asset—no Chaosworld or Viewpoint source or artwork.
The Workshop helper downloads the DLL only when explicitly run, verifies its
hash, and backs up the previously installed native loader.

If either upstream author asks for bundled material to be removed, CW will
remove it. When official ZombieBuddy includes both the required 42.21 loader
compatibility and native DLL repair, this temporary helper should be retired.
