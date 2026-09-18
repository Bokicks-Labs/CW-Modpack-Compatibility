# Normal-play tracker repairs and remaining tests

Tracker: `C:\Users\Rim28\Zomboid\CodexAudit\BugTracker`.
Source branch: `main`. Existing mod.info/artwork edits were preserved.
No game process was running during edits or staging. The newest debug log ends
with `GameThread exited` at 2026-09-17 00:10:58 local time. These changes have
not been executed by Project Zomboid yet.

## Findings and changes

| Issue | Evidence | Change / remaining uncertainty |
|---|---|---|
| PZ-20260916-215517-22704192: motorcycle Mechanics | Player clarified the trigger is opening Mechanics. Vanilla `ISVehicleMenu.onMechanic` queues vehicle-area pathing when an EngineDoor exists, otherwise vehicle-adjacent pathing. Installed Autotsar Motorclub includes BMW/Harley motorcycles without an EngineDoor. The historical bike model and incident time remain unknown. | Added AMC-only path observations: model, entity ID, goal, player/bike coordinates, start, completion/cancellation, and a pending sample every five real seconds. No pathing repair is claimed. |
| PZ-20260916-221345-c72a3be1: missing loading music | Current options.ini had `musicVolume=0`; player confirmed silence and that muting was unintended. | Restored `musicVolume=6` (60%). Verified every other byte of options.ini remains unchanged. Loading audio still needs an audible check. |
| PZ-20260916-230514-71e91432: errors and frozen NPCs | Preserved report-time stacks name Dynamic Trading's `trySetAttachedItem` / `clearManagedEquipment`, with invalid BeltOldFlashlightLeft/Right slots. The newest log repeats the same signatures. Upstream catches the exception with pcall; therefore these errors alone do not prove the AI freeze cause. Simple Flashlight on Belt supplies the old-flashlight hotbar mappings. | Added an attachment-group lookup before Dynamic Trading enters `setAttachedItem`. Unregistered slots return false without the Java exception or a global blocked-slot entry. Valid slots retain upstream behavior. NPC movement still needs verification. |
| PZ-20260916-234714-c48c840c: persistent embarrassment | Installed Lifestyle's real minute callback clears an isolated 0.2 embarrassment value in 40 calls in the headless test. Missing Comfort data reproduces a callback failure. No matching Lifestyle minute stack was established for the reported occurrence. | Added minute observations: world age, before/after embarrassment, value after the previous callback, missing general moodles, and callback success/errors. No moodle values or decay rates are changed. The occurrence's cause remains unconfirmed. |

Archived client debug logs and report snapshots were searched (183 files,
including overlapping evidence copies). Older Vehicle Repair Overhaul warnings
reference a moved ISPathFindAction require path; those unrelated historical
startup warnings are not evidence for this motorcycle occurrence. No matching
dedicated-server log was available at the recorded local server path.

## Validation

`dev-scripts/test-tracker-fixes.py --workshop-root S:\SteamLibrary\steamapps\workshop\content\108600`
executes installed upstream source under Lua 5.1 with mocked Java/game objects.
It demonstrates the invalid upstream attachment call, verifies the guard prevents
it, and covers valid attach/clear, activation, idempotence and different groups
supporting the same slot. It also exercises the real Lifestyle minute callback,
normal decay, visible missing-data failures, and motorcycle wrapper delegation,
multiple return values, unrelated paths and logging rate limits.

All three existing Bandits/Week One regression scripts and `git diff --check`
passed. Java signatures and bytecode in the installed game jar confirm
`getAttachedItems():getGroup():getLocation(slot)` exists and returns null for
an unknown slot. These checks do not validate Kahlua's Java bridge, NPC movement,
character state or audible music in the running game.

## Deployment

Source and local Workshop uploader staging contain 438 matching files, with no
staging-only extras. Before copying, staging matched source except for the two
new Lua files. The local mod junction points to source. Recent gameplay logs
identify the local uploader staging copy; a new run must show the installation
markers below to establish which code actually loaded.

No Steam Workshop update was published, no Steam cache was edited, and no
remote server deployment/restart, save edits or mod-list changes were made.
If testing a server that enforces Lua checksums, its payload must match the
client before connecting. The source retains the existing 1.1.10 metadata;
installation markers, rather than the version number alone, identify this test.

Music backup:
`C:\Users\Rim28\Zomboid\CodexAudit\BugTracker\evidence\repair-20260917\options-before-music-repair.ini`.
To undo only the music change, restore the prior musicVolume value while the
game is closed. To undo the compatibility additions, remove the two new Lua
files from source and local staging while closed; the helper does not delete
stale destination files automatically.

## Minimal manual tests

1. Start the usual game/modpack from a fully closed client. Listen during world
   loading. Report whether music is audible. If it is still silent, also report
   whether menu and gameplay music work. Do not change unrelated audio settings.
2. With the affected motorcycle parked upright on open ground, select Mechanics.
   If walking diverges, let it run five seconds, then cancel with Escape or
   movement. Report the model, approximate real time and whether cancellation
   works. Try opening Mechanics on a normal car as a control. Do not let an
   indefinite walk continue unattended.
3. While embarrassment is present, allow ten in-game minutes to advance without
   another hobby/hygiene action that could add embarrassment. Report whether the
   embarrassed icon changes. The new trace will show whether the value decreases
   and whether minute processing executes. An isolated 0.2 value should expire
   in approximately 40 in-game minutes, and 1.0 in approximately 90, if callbacks
   succeed and nothing adds to it. Stress/unhappiness can remain after the
   embarrassment value clears; record the embarrassed icon separately.
4. Observe nearby NPCs for a few minutes, recording any freeze time and whether
   player movement still works. If possible, distinguish trader NPCs from
   Bandits/Remnants; unknown affiliation is acceptable. In multiplayer, record
   whether another player sees the same freeze, and retain that server's log.

Expected installation markers:

- `[CWModpackCompatibility][DynamicTrading] Installed NPC attachment-group guard.`
- `[CWModpackCompatibility][LifestyleTrace] Installed minute observations`
- `[CWModpackCompatibility][MotorcycleTrace] Installed AMC path observations.`

After these tests, the client logs can be inspected directly from this machine.
Tracker issues remain monitoring/investigating until matching gameplay evidence
establishes resolution.
