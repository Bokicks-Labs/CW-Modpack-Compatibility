# ZombieBuddy 42.21 Windows fix for Project Viewpoint

This is a manual client-side install. Enabling a Workshop mod cannot replace
ZombieBuddy's native loader in the game installation.

1. Install the original ZombieBuddy Windows agent, subscribe to ZombieBuddy and
   Project Viewpoint, and use Project Zomboid 42.21. Close the game completely.
2. Extract this ZIP. Run `Run-ZombieBuddy-ViewpointFix.cmd` from the extracted
   folder. If Steam's game installation is not found, open PowerShell in this
   folder and run:

   ```powershell
   .\Install-ZombieBuddy-ViewpointFix.ps1 -Action Install -ProjectZomboidPath 'C:\path\to\ProjectZomboid'
   ```

3. Launch the game normally, approve only Viewpoint's expected Java JAR when
   ZombieBuddy asks, and test a hostname connection.

The installer checks both bundled files by SHA-256, checks that the game is
closed, backs up the existing DLL and JAR, and verifies each installed file.
It does not change saves, Steam subscriptions, launch options, or approvals.
Status and rollback commands are:

```powershell
.\Install-ZombieBuddy-ViewpointFix.ps1 -Action Status
.\Install-ZombieBuddy-ViewpointFix.ps1 -Action Restore
```

Backups are under `%USERPROFILE%\Zomboid\backups\CW-ZombieBuddy\ViewpointFix`.
Run Restore with the game closed. The 42.21 JAR is Antikristianos' temporary
compatibility package 1.2; `zbNative.dll` is a narrowly modified build of
Zed's ZombieBuddy 2.3.3 Windows loader. Both projects use the MIT license;
see `LICENSE-Temporary-Fix.txt` and `LICENSE-ZombieBuddy.txt`.

Expected hashes:

- `ZombieBuddy.jar`: `909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102`
- `zbNative.dll`: `49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE`

The patch removes ZombieBuddy's ambiguous `LoadLibraryA("instrument.dll")`
lookup and loads the bundled JRE's `instrument.dll` by full path instead.
One client has connected via hostname and used Viewpoint with this build; a
fresh restart and friend-machine tests are still required before treating it
as broadly validated. No server install is needed solely for the client's
Viewpoint or hostname connection. If a Windows dedicated server independently
uses ZombieBuddy to load Java mods, assess and test its own agent installation
separately rather than copying this client package blindly.
