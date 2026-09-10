# Error inventory

Errors are grouped by unique signature and execution side. Counts below are from the retained server logs; repeated startup asset errors are not treated as thousands of independent NPC failures.

## Runtime correlation summary

| Session log | Server-ready line | Pre-ready errors | Post-ready errors | Post-ready exception markers | Week One / players |
|---|---:|---:|---:|---:|---|
| 01:14 | 35,505 | 1,391 | 0 | 0 | Week One absent / 0 |
| 01:22 | 34,325 | 1,395 | 0 | 0 | Week One absent / 2 later connected |
| 01:49 | 34,505 | 1,417 | 0 | 0 | Week One present / 0 |
| 02:00 | 34,618 | 1,417 | 0 | 0 | Week One present / 0 |
| 02:18 | 34,742 | 1,425 | 0 | 0 | Week One present / 0 |
| 02:36 | 34,905 | 1,427 | 2 | 0 | Week One present / 1 client for 74 seconds |

The two post-ready errors in the 02:36 session are `IsoThumpable not found on square` at 02:42:05 and 02:42:08, before the player became fully connected at 02:42:24. They are not Bandits stack traces and do not correlate with NPC phasing.

## S-STARTUP-ANIM-DIR

- Side: server startup.
- Signature: `AdvancedAnimator$1.visitFileFailed> Exception thrown`.
- Frequency: 916 instances in the 02:36 startup.
- Context: missing/inaccessible optional animation/action-group paths across the large modpack.
- Correlation: before `*** SERVER STARTED ****`; no demonstrated NPC lifecycle correlation.
- Disposition: startup noise for this incident, not ignored globally.

## S-STARTUP-SKELETON

- Side: server startup.
- Signature: `Could not find bone index for node name: ...`.
- Frequency: repeated groups, commonly 12 or 24 per bone name in the 02:36 startup.
- Context: imported animation skeleton mappings.
- Correlation: before server-ready; no Bandits/Week One stack.
- Disposition: not a current phasing lead.

## S-STARTUP-WORLDGEN

- Side: server startup.
- Signature: `IsoPropertyType.lookupOrDefaultStr> Exception thrown`.
- Frequency: 9 in the 02:36 startup.
- Correlation: before server-ready; no observed NPC event.
- Disposition: separately actionable map/property compatibility noise, but not evidence for this incident.

## S-RUNTIME-THUMPABLE

- Side: server runtime.
- Signature: `ERROR: IsoThumpable not found on square ...`.
- Frequency: 2 in the 02:36 session.
- Timing: 02:42:05 and 02:42:08; the sole player fully connected at 02:42:24.
- Correlation: none with a connected player or Bandits call path.
- Disposition: unrelated unless a later trace proves otherwise.

## C-WEEKONE-INHABITANT-SPAWN

- Side: client.
- Expected source: `BanditsWeekOne/42.20/media/lua/client/BWOPopControl.lua:347`, `BWOPopControl.InhabitantsSpawn` from `EveryOneMinute -> BWOPopControl.UpdateCivs`.
- Defect: direct `BanditServer.Spawner.Clan(player,args)` call from client-only Lua; definition exists only in Bandits server Lua.
- Expected failure family: nil global/table/function indexing or call involving `BanditServer`/`Spawner`/`Clan`.
- Frequency: potentially once per inhabitant candidate on each minute update, but **not measured**.
- Evidence status: source-confirmed defect; exact runtime stack and frequency unavailable because no client console was retained.
- Finding: `CW-WO-MP-002`.

## C-WEEKONE-LOCAL-REMOVAL

- Side: client.
- Source: `BWOPopControl.Zombie` every eight ticks and population despawners every in-game minute.
- Defect: local `removeFromWorld`/`removeFromSquare` on replicated objects; server `BanditRemove` clears only brain Global ModData.
- Error behavior: may create visual churn without throwing an exception. Do not use error-count reduction as the success condition.
- Frequency: data-dependent; not measured without client lifecycle instrumentation.
- Finding: `CW-WO-MP-001`.

## Missing evidence request

For the next run, retain each remote client's full `console.txt`/Lua log from before join through disconnect. Record client name only in a private mapping; incident artifacts should use client A/client B and omit public IP/Steam identifiers. Capture 30 lines around the first instance of every unique stack and count normalized repetitions.
