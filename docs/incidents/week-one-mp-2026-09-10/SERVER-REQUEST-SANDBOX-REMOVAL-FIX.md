# Server evidence request: Week One sandbox and Bandit removal fixes

## Scope

The user owns Steam Workshop publishing, update delivery, configuration, and
server restart. The server thread must not install, copy, publish, enable,
disable, restart, or modify server content, profiles, or saves. Begin only after
the user says compatibility version 1.1.8 has been deployed, the server has been
restarted, and the rejoin observation is complete.

Collect read-only evidence and return it through this repository.

## Evidence to collect

1. Identify and hash the server debug log covering the user-managed restart and
   test. Record path, size, modification time, and SHA-256 without altering it.
2. Report the installed compatibility `modversion` and SHA-256 hashes for:
   - `42/mod.info`;
   - `media/lua/server/CWModpackCompatibility_BanditsServer.lua`;
   - `media/lua/server/CWModpackCompatibility_WeekOneServer.lua`.
3. Confirm read-only that `Bandits2`, `BanditsWeekOne`, and
   `CWModpackCompatibility` were active. Do not change the profile.
4. In the startup-through-disconnect window, count:
   - `schedule of non-table` / `BWOScheduler.lua:42`;
   - `playerIsHostile of non-table` / `BWOPopControl.lua:102`;
   - `__sub not defined for operands in adjustSandboxVars` /
     `BWOScheduler.lua:240`;
   - `Spawner/Clan` and `BanditRemove` errors;
   - every other runtime exception grouped by message and first Lua frame.
5. Extract all `[CWModpackCompatibility][WeekOne]` and
   `[CWModpackCompatibility][Bandits]` lines in the window. For Bandit removal
   lines, report total requests, distinct IDs, and counts grouped by:
   - `authoritativeEntityRemoved=true|false`;
   - `alternateBrainCleared=true|false`;
   - repeated requests per ID.
6. Report counts and timing for `AddZombiesInOutfit`, `ZombieHitThumpable`, and
   any server zombie-removal or replication warnings during the observation.
7. Correlate the connection interval without retaining usernames, Steam IDs,
   IP addresses, coordinates, or other identifiers.

## Return format

Create `SERVER-RESULT-SANDBOX-REMOVAL-FIX.md` beside this request. Include
evidence metadata, versions and hashes, grouped counts, bounded redacted
excerpts, and separate PASS/FAIL/INCONCLUSIVE conclusions for:

- Week One scheduler/population error flood;
- authoritative Bandit removal;
- visible NPC or ordinary-zombie phasing.

Commit and push only the summary and small redacted excerpts needed to support
it. Do not commit full logs or identity-bearing data. Project Remnants and its
dependants remain outside this test.
