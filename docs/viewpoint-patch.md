# Viewpoint patch work

`CWViewpointPatch` is an optional client mod in the CW Workshop item. Version
0.2.1 requires Viewpoint and ZombieBuddy; the CW core requires neither. Enable
it after Viewpoint. The patch JAR extends the Viewpoint loot/interaction label
width. A Lua listener retries short world right-clicks when the press and release pick
different objects. Existing interaction-failure logging remains available.

The menu width setting is under Options > Mods > CW Viewpoint Patch. It ranges
from 360 to 900 pixels and defaults to 600. Restart after changing it because
Viewpoint caches fitted labels. The Java source is under
`dev-scripts/viewpoint-patch/src`; run `Scripts/build-viewpoint-patch.ps1` to
rebuild the client JAR from the installed ZombieBuddy API. Repeated builds
produce the same SHA-256 hash. ZombieBuddy must approve the new JAR before it
loads. The patch never edits the installed Viewpoint or ZombieBuddy JARs.

The right-click fallback handles world-object picker mismatches; UI panels
still own their right-click events. Verify both remaining behaviors in a
disposable save before using this build in a new playthrough.

The locally installed Viewpoint x A-LIFE 1.3.4 mod scans Project A-Life NPC
shells independently, projects them into Viewpoint's camera, highlights the
crosshair target, and supplies its own Talk, Trade, Equip, and Medical Check
menu. It hides Viewpoint's loot panel while targeting an NPC. CW's Lua NPC
menu bridge and Java NPC target bridge were removed because this mod owns that
interaction. Install Viewpoint x A-LIFE separately for those features.

Earlier builds included a right-click trace that raised on a Java field access
and a collision trace. Both have been removed from the 0.2.0 play build.
Collision work is deferred.

The first diagnostic build mistakenly logged successful result tables as
`error: table ...` on every interaction. Those messages are false positives.
The corrected logger checks the `pcall` status explicitly; refresh the copied
dev mod after closing PZ before treating its next log as failure evidence.

## Current evidence and first reproduction

The inspected installed Viewpoint is `0.1.6` (Build 42.21, October 11). Its Lua
`ViewpointInteract.harvest` exits early for an open right-click menu, a placement
cursor, an object without a square, or a missing player context menu. It calls
`ISWorldObjectContextMenu.createMenu`, recursively collects submenu options,
then filters actions by target ownership. An empty action list can therefore
arise at several stages. Vehicle interactions follow a separate radial-menu
path. The October 9, 2026 17:07 local debug log shows the Viewpoint QOL and Menu
Fix Java hooks loading, but no interaction exception. This does not establish
the cause of the reported disappearance or that it persists after restart.

For the next occurrence, record: object and coordinates, first/third person,
camera release state, whether ordinary right-click works, whether a placement
cursor is active, whether switching perspective or restarting restores actions,
and the log lines beginning `[CWViewpointPatch]`. Reproduce in a disposable save
before editing the live mod list. Check a vanilla door/window, a vehicle, and
a representative mod-added action. Compare with QOL and Menu Fix enabled and
disabled one at a time. Do not infer an action-selection failure from a Java
rendering symptom alone.

## Next Viewpoint targets

### Unlocked right-click menu

The Build 42 `ISObjectClickHandler` opens the normal world menu only when the
object received on right-button release is the same object saved on press and
the press lasted under 500 ms. Viewpoint replaces the game's context pick with
its own 3D mouse target; that target can be unavailable or change between the
two callbacks. This is a concrete candidate for an intermittent world-menu
failure, not yet a tested cause. Inventory and other UI panels handle their own
right-clicks, so any fallback must leave captured UI clicks alone. Compare the
press/release target and menu result in a disposable save before changing the
handler; preserve the native `ISContextManager` menu path and mod entries.

### Deferred player and zombie collision

The user reports walking as well as running through zombies in Viewpoint first
and third person, while isometric view retains the bump. Viewpoint patches
`IsoPlayer.updateMovementFromInput` and transforms movement vectors/root
motion. The game's local `IsoPlayer.isSkipResolveCollision()` still returns
false unless the inherited grapple check is true, so a blanket collision-skip
toggle is not established as the cause. Compare player/zombie positions,
deferred movement, bump state, and current animation state at contact in the
same disposable scene across all three views. Do not add manual pushes or
synthetic bump animations until the missing stage is identified; this affects
grab risk and multiplayer movement.

## Installed fix audit

The earlier mod inventory included Barricade, Car, Door, Fire, Light, Menu,
Surface, KI5 Vehicle Parts, Tile, Bunker, General Mod Map, 3D Tracer, Turbo,
and Project Viewpoint QOL. All are separate mods from Viewpoint. Their
installed metadata still declares Viewpoint as a dependency, and the Menu Fix
contains a Java patch for `LootPanel.fit` that normalizes multiline labels.
QOL patches `LootPanel.rounded` and several interaction target/menu classes;
both Java mods were transformed in the inspected log. This shared surface is a
conflict candidate, not proof of a conflict. The Menu Fix author now marks it
obsolete because Viewpoint 0.1.6 fixed the row-overlap issue. Its old patch
does not supply the new width setting.

| Installed fix | Current target | Audit result |
| --- | --- | --- |
| Barricade | Placement and textures | Keep pending scene comparison |
| Car | 3D vehicle color | Obsolete per its author after Viewpoint 0.1.6; remove from future mod lists |
| Door | Lighting and textures | Keep pending scene comparison |
| Fire | 3D sprites | Keep pending scene comparison |
| Light | Headlight position | Keep pending scene comparison |
| Menu | Multiline row text | Author marks obsolete after Viewpoint 0.1.6; exclude from new playthrough test |
| Surface | Wall and roof textures | Keep pending scene comparison |
| KI5 Vehicle Parts | Near-camera part visibility | Keep pending KI5 vehicle comparison |
| Tile | Roof completion | Save removal procedure required |
| Bunker | Bunker geometry | Keep pending bunker comparison |
| General Mod Map | Mid/far terrain | Keep pending overlapping-map comparison |
| 3D Tracer | A-Life NPC tracers | Keep pending A-Life comparison |
| Turbo | Rendering performance | Keep pending measured comparison |
| QOL | Interaction and UI controls | Shared Java menu/target surface; isolate first |

An installed fix being older than Viewpoint `0.1.6` is insufficient to
declare it outdated: it may still correct a feature the base mod does not own.
Each remaining row needs a same-scene enabled/disabled comparison against this
Viewpoint version before it can be marked replaced or redundant. The Car Fix
Workshop author explicitly marks that one obsolete; the local default preset
and recent saves still list `ViewpointCar`, so a save/mod-list migration should
be checked separately.

QOL already provides a `K` loot-menu toggle, so a new show/hide key should be
assessed against it before implementation. Tile Fix documents a removal
procedure for explored roofs: disable roof completion, revisit affected areas,
then remove the mod. Keep it enabled on existing saves until that procedure is
validated. Do not remove any other fix solely from metadata or load markers;
compare its behavior against current Viewpoint in a disposable save first.

## Development and rollback

Run `Scripts/deploy-pz-dev-mods.ps1` to include a copied `CWViewpointPatch_dev`
junction alongside the CW dev mods, or run
`Scripts/deploy-pz-viewpoint-patch.ps1` to manage that junction alone.
Use one deploy command to manage the active junction. The dev copy declares the release ID incompatible.
Rerun the same command to refresh its copy. Restart PZ after changing
the mod list. To roll back, disable `CWViewpointPatch` or its dev ID and restart.
The patch does not write save data. The Workshop staging script copies the
optional mod and JAR but does not upload it. First verify the JAR load, menu
width and right-click behavior in a disposable save. Test A-Life targeting with
Viewpoint x A-LIFE separately.
