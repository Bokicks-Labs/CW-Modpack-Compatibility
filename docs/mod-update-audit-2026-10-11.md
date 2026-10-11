# Mod update audit — October 11, 2026

Scope: locally installed Workshop items whose Steam manifest reports an update from
October 9 through October 11, compared with the installed files and CW source.
The Steam manifest lists 33 such items. Its `timeupdated` field is a Workshop
timestamp, not evidence that every file or behavior changed. This is a static
audit; no save or game installation was modified or runtime-tested.

## Actions

- ZombieBuddy (3619862853) is public again according to Steam's live item API.
  Its official item supplies the JAR and native DLL. Remove CW's temporary
  `ZombieBuddy-Setup` distribution, bundled compatibility JAR, and setup test;
  direct players to the official item. The local game JAR matches Workshop,
  but its working native DLL SHA-256 is
  `49E5D596B54E5E4EAB535E613CDC7C3F0DE9BB7EF07239C255E2B127657104CE`,
  while the installed Workshop DLL is
  `C2AE9335E717EE24B2F4A40D1A3BF77F1519762A72A0459E766A2BBAFC077F6C`.
  Returning to Workshop does not establish that the old Windows hostname issue
  is fixed upstream. Do not overwrite the working game DLL solely for cleanup.
- Project Viewpoint (3809306528) now has `modversion=0.1.6`; the old CW audit
  inspected 0.1.5a-hotfix. CW's optional interaction logger still targets the
  `ViewpointInteract.harvest`, `harvestVehicle`, and `run` functions present in
  the installed 0.1.6 Lua. The logger remains diagnostic only; runtime behavior
  needs a disposable-save retest.
- Car Fix (3810724915) now says it is obsolete because Viewpoint 0.1.6 fixes
  vehicle appearance. The local default preset and two October 11 save
  `mods.txt` files still list `ViewpointCar` even after unsubscription. Do not
  edit those saves without a backup and migration test.

## Direct CW patch overlap

| Updated item | CW patch checked | Static result |
| --- | --- | --- |
| Bandits NPC (3268487204) | Container loot and player-hit guards | Installed 42.21 source still exposes the target Bandits functions. No evidence yet to remove CW guards. |
| CleanUI (3437629766) | Inventory tooltip nil-context guard | Installed 42.19 source still calls `getPlayerContextMenu(self.player):isAnyVisible()` without a nil check. Keep guard. |
| EXACT MINUTE CLOCK (3778884296) | Fast Forward anchor and AM/PM positioning | Current source still hides the vanilla clock and moves AM/PM to the date row. Keep the existing compatibility behavior pending a runtime check. |

Other updated Viewpoint add-ons include QOL, Light Fix, Door Fix, Recoil & ADS,
True Ballistics, Immersive Effects, tree models, Advanced Throwables, True
Weathers, General Mod Map Fix, Tile Fix, Surface Fix, Fishing, Foraging, and
KI5 Vehicle Parts Fix. Their Workshop updates do not directly replace a CW
runtime patch. Light, Door, and Tile authors have not marked their fixes
obsolete. Tile Fix has a save-sensitive roof-removal procedure; do not infer
that it is safe to remove from the Car Fix announcement.

The remaining recently updated subscribed items were Has Been Read, Project
Cook, Neat Building, NeatUI XP Drop, Hide Anywhere, PZ Pulse Expanded,
Immersive Snow and its Viewpoint bridge, HydeCo Knox Underground, Senators
Martial Arts Core, SMB steps, and Yeah it's water bitch. No direct CW patch
ownership was found for those updates. Check fresh logs and a reproducible
symptom before adding compatibility code.
