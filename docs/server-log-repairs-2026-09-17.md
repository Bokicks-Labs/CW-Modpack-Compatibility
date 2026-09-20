# Repairs from the September 16 server logs

Evidence supplied by the player: `C:\Users\Rim28\OneDrive\Desktop\Logs.zip`.
Its September 16 entries were copied to
`C:\Users\Rim28\Zomboid\CodexAudit\BugTracker\evidence\server-logs-20260917`.
`archive-manifest.json` records the archive/member SHA-256 hashes, and
`error-inventory.json` records startup boundaries, error categories and stacks.
The original archive was preserved. Log text was treated as evidence.

## Session boundaries

| Server session | Evidence |
|---|---|
| September 16, 21:30 | Ends at 21:48 during Workshop downloads; no server-ready marker or play evidence. |
| September 16, 22:04 | Server-ready marker at logical line 37775; ends with shutdown at 23:08:37. Includes the 23:05 NPC report window. |
| September 16, 23:08 | Server-ready marker at logical line 37103; ends with shutdown September 17 at 21:45:27. Includes the yoga/clothing exceptions during last night's play. |

The ZIP also contains September 10 history. That history is separate from the
September 16 tracker occurrences and existing Week One investigation.

## Changes

### Yoga constructor field names

> Superseded September 19: Lifestyle 0.4.0.3 now supplies the correct `Args`
> constructor contract and repaired animation paths. CW 1.1.11 removes its yoga
> wrapper and copied animation payload; the original incident analysis below is
> retained as historical evidence.

At 23:34:29, the server fails in `LSYogaAction:new` at `Args[1]` while parsing a
network timed action. The existing CW client diagnostics wrapper names that
parameter `args`; Lifestyle stores it on the action as `Args`.

The installed game's `NetTimedAction.set` bytecode reads the constructor's
parameter names and uses them to read fields from the client action. Parsing
uses the server constructor's parameter names. Consequently, the old wrapper
serializes a missing `args` field and the server receives no `Args` table.
The corrected wrapper preserves the exact `Args` name and the original values.
The server's original Lifestyle constructor remains unchanged.

This repairs a concrete CW defect in starting multiplayer yoga. It does not
establish the cause of the separately reported persistent embarrassment.
Both clients must use the corrected wrapper; updating only the server cannot
restore argument data that an old client omitted.

### Clothing transformation item recovery

At 23:31:26, `ISClothingExtraAction:createItemNew` attempts `item:getVisual()`
with a nil source item. This causes the following `NetTimedAction.perform`
failure too; those are two reports of the same failed completion.

The shared compatibility hook stores a primitive `itemId`, resolves a missing
InventoryItem reference in the constructor and again at completion, then
delegates the real transformation to vanilla. If the target no longer exists
in inventory, completion succeeds without changing inventory or worn items.
Repeated completion cannot transform an already-removed source again.
This covers clothing/bag alternate forms, such as changing how an item is worn.

### Dynamic Trading startup collectors

Both playable server sessions fail in Dynamic Trading faction initialization:
22:07:03 through the geolocator context, and 23:09:31 through the lifecycle queue
context. Each calls `getOnlinePlayers()` before `GameServer.udpEngine` exists.

The server-only hook guards those two exported context methods before world
initialization. Before `OnServerStarted`, they return an empty player list,
which upstream already handles through its location-center and deferred-town
fallbacks. After server startup, they delegate to the original collectors.
The game global `getOnlinePlayers`, single-player initialization, faction
generation rules and saved faction data are not replaced by this patch.

### Dynamic Trading wardrobe item ID

At 23:13:23, the server cannot create `Base.Tshirt_White`. That ID is absent
from the installed vanilla clothing scripts; `Base.Tshirt_WhiteTINT` exists.
Installed Dynamic Trading archetype outfit presets contain the obsolete ID.

The compatibility hook replaces that exact ID in male/female wardrobe presets
only when the old script item is absent and the replacement is present. Another
mod supplying a valid old ID takes precedence. Hair, other garments and outfit
selection remain unchanged. Explicit saved NPC outfit overrides are not migrated,
so those can still require separate evidence if the missing-item warning recurs.

## What remains uncertain

- The 23:04:24 alarm-clock-clothing exception dereferences a player's missing
  square in Java. NPC navigation resumes at 23:04:24.490, about 112 milliseconds
  later. The same Dynamic Trading NPC changes reported position from approximately
  6097,5255 at 23:04:24 to 6097,5264 at 23:05:02. This shows continuing server
  activity for that NPC, but does not identify the player's frozen NPC or prove
  healthy client rendering/AI. No Java/base-game patch or alarm-state changes
  were made.
- The 22:04 session has 27 missing-IsoThumpable reports near player entry and two
  rejected null faction-tag packets. The 23:08 session has five invalid corpse
  indices and two missing world-item reports. Their initiating objects/actions
  are not established; no cache/save reset or broad packet suppression was made.
- Some NPCs repeatedly request blocked-path repaths. These are behavioral leads,
  not proof that a specific pathing change would repair the observed freeze.
- The three English tooltip formatting warnings in this archive already have
  corrected text in current CW source. No duplicate translation fix was added.
- There is no new motorcycle incident or Lifestyle minute-decay stack in these
  server logs. The earlier manual tests and observations remain necessary.

## Verification and delivery

`Scripts/test-server-log-fixes.py` runs the actual installed Lifestyle,
vanilla clothing, Dynamic Trading collector and wardrobe Lua under Lua 5.1 with
mocked Java/game objects. It checks Lifestyle's upstream yoga named-field
reconstruction without a CW wrapper; exercises vanilla clothing transformation and
preserved properties, missing/duplicate targets and late ID recovery; and checks
both startup collectors, restored player lookup, absent-mod/single-player guards,
idempotence and wardrobe script-item existence checks.

`Scripts/test-tracker-fixes.py` covers the earlier attachment guard and
embarrassment/motorcycle observations. The three existing Bandits/Week One
tests and `git diff --check` also pass.

Source and local Workshop uploader staging are verified against each other by
full file-set/SHA-256 comparison (440 files). Existing artwork/mod.info edits
were preserved. No commit, push, Steam publication or remote server deployment
was performed. Existing metadata remains 1.1.10; use the new installation markers
to verify the payload rather than relying on that version number alone.

## Required manual checks after client/server deployment

1. Restart the server with the updated compatibility payload. Confirm
   `Installed pre-network player-anchor guards` appears before server startup,
   then `Player-anchor queries enabled after server startup`. Confirm neither
   Dynamic Trading `udpEngine is null` stack recurs. Existing faction data should
   load and traders should still be available; do not delete faction data to test.
2. Use updated clients to start yoga and finish or cancel normally. Preserve
   the server log and verify no `LSYogaAction.lua:510` constructor failure. Keep
   the prior passive embarrassment test: yoga startup and moodle expiry are
   separate behaviors.
3. Transform an ordinary clothing/bag item through an available alternate-form
   context action. Verify it remains present exactly once, the new form is worn
   correctly, and condition, favorite status and contents (if a bag) survive.
   Check another client/rejoin for consistency. Do not deliberately discard a
   valuable item to provoke a stale completion.
4. During normal NPC encounters, check clothing and movement and retain any
   remaining missing-T-shirt or freeze logs with their times. These fixes still
   need gameplay verification; absence of an exception alone is not proof of
   healthy NPC behavior.

Clothing marker: `[CWModpackCompatibility][ClothingExtra] Installed multiplayer item recovery.`
Wardrobe marker: `[CWModpackCompatibility][DynamicTrading] Repaired obsolete T-shirt IDs`.
The wardrobe marker appears only when an actual replacement occurs.

The two previous staged Lua files changed by this follow-up are preserved under
`evidence\server-logs-20260917\pre-server-fixes`. To roll back this follow-up,
restore those files to source/local staging and remove the new ClothingExtra
and DynamicTradingStartup Lua files while the game is closed. Server rollback
remains part of the player's deployment workflow.
