# Viewpoint patch work

`CWViewpointPatch` is an optional client mod in the CW Workshop item. It requires
`Viewpoint`; the CW core does not. Viewpoint itself requires ZombieBuddy. Version
0.1.1 records transitions into failed or empty interaction harvests and reports
the failure reason and number of context options seen in the PZ log. It does not
alter action selection, the menu, or Java classes. Enable it after Viewpoint.

It also logs right-clicks when the world picker changes between having a result
and having none on button press and release, or the player world menu is absent
two ticks later. The log
includes cursor mode when Viewpoint QOL exposes it; `unknown` means that bridge
was unavailable. UI panels may own their own context menus, so an absent player
world menu by itself is not proof that a UI click failed. The logger does not
change click handling. The first right-click diagnostic tried to read the Java
picker object's `tile` field through Lua and raised an error on every click.
The corrected logger records only whether the picker returned an object; it
cannot establish whether the exact picked target changed.

The collision logger samples the nearest zombie every 12 frames and logs at
most once per second while the player is within 0.6 world tiles. It records
bump state, collision-skip state, animation state, and both positions. It does
not move or push either character. Use a disposable save for a one-zombie
walking comparison in isometric, first-person, and third-person views.

The first diagnostic build mistakenly logged successful result tables as
`error: table ...` on every interaction. Those messages are false positives.
The corrected logger checks the `pcall` status explicitly; refresh the copied
dev mod after closing PZ before treating its next log as failure evidence.

## Current evidence and first reproduction

The inspected installed Viewpoint is `0.1.5a-hotfix` (Build 42.21). Its Lua
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

### Player and zombie collision

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

The current mod inventory includes Barricade, Car, Door, Fire, Light, Menu,
Surface, KI5 Vehicle Parts, Tile, Bunker, General Mod Map, 3D Tracer, Turbo,
and Project Viewpoint QOL. All are separate mods from Viewpoint. Their
installed metadata still declares Viewpoint as a dependency, and the Menu Fix
contains a Java patch for `LootPanel.fit` that normalizes multiline labels.
QOL patches `LootPanel.rounded` and several interaction target/menu classes;
both Java mods were transformed in the inspected log. This shared surface is a
conflict candidate, not proof of a conflict. No fix is currently proven
obsolete, already incorporated into the base mod, or safe to remove.

| Installed fix | Current target | Audit result |
| --- | --- | --- |
| Barricade | Placement and textures | Keep pending scene comparison |
| Car | 3D vehicle color | Keep pending scene comparison |
| Door | Lighting and textures | Keep pending scene comparison |
| Fire | 3D sprites | Keep pending scene comparison |
| Light | Headlight position | Keep pending scene comparison |
| Menu | Multiline row text | Shared `LootPanel` surface with QOL; isolate first |
| Surface | Wall and roof textures | Keep pending scene comparison |
| KI5 Vehicle Parts | Near-camera part visibility | Keep pending KI5 vehicle comparison |
| Tile | Roof completion | Save removal procedure required |
| Bunker | Bunker geometry | Keep pending bunker comparison |
| General Mod Map | Mid/far terrain | Keep pending overlapping-map comparison |
| 3D Tracer | A-Life NPC tracers | Keep pending A-Life comparison |
| Turbo | Rendering performance | Keep pending measured comparison |
| QOL | Interaction and UI controls | Shared Java menu/target surface; isolate first |

An installed fix being older than Viewpoint `0.1.5a-hotfix` is insufficient to
declare it outdated: it may still correct a feature the base mod does not own.
Each row needs a same-scene enabled/disabled comparison against this Viewpoint
version before it can be marked replaced or redundant.

QOL already provides a `K` loot-menu toggle, so a new show/hide key should be
assessed against it before implementation. Tile Fix documents a removal
procedure for explored roofs: disable roof completion, revisit affected areas,
then remove the mod. Keep it enabled on existing saves until that procedure is
validated. Do not remove any other fix solely from metadata or load markers;
compare its behavior against current Viewpoint in a disposable save first.

## Development and rollback

Run `Scripts/toggle-pz-junction.ps1` to include a copied `CWViewpointPatch_dev`
junction alongside the CW dev mods, or run
`Scripts/toggle-pz-viewpoint-patch-junction.ps1` to manage that junction alone.
Do not use both toggles for the same active junction. Disable the release ID
when testing the dev ID; rerun the same script to remove its junction. Restart PZ after changing
the mod list. To roll back, disable `CWViewpointPatch` or its dev ID and restart.
The diagnostic version does not write save data. The Workshop staging script
copies this optional mod but does not upload it; do not publish a behavioral
fix until the reproduction and comparison above are complete.
