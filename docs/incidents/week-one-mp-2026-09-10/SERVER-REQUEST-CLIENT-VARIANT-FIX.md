# Server follow-up request: Week One variant repair

## Client evidence

The 2026-09-10 15:01 client session loaded the current compatibility hooks and
then produced exactly two repeating runtime failures:

- 518 `BWOScheduler.lua:42` failures: `schedule of non-table: null`.
- 518 `BWOPopControl.lua:102` failures: `playerIsHostile of non-table: null`.

Both sites dereference `BWOVariants[GetBWOModData().Variant]`. Dedicated-server
players do not pass through Week One's local variant selection screen, and the
received Global ModData did not contain a key valid for the client's numeric
`BWOVariants` table.

## Scope of server-thread work

The user owns Steam Workshop publishing, server update delivery, configuration,
and restart. Do not install, copy, publish, enable, disable, restart, or modify
anything on the server. Do not edit the profile or production save. Wait until
the user says the updated server has been restarted and the rejoin test is
complete.

The server thread is requested only to collect read-only evidence and return it
through this repository.

## Evidence to collect

1. Identify the server log covering the user-managed restart and rejoin test.
   Preserve the original log unchanged and record its path, size, modification
   time, and SHA-256 hash.
2. Read the server's installed `CWModpackCompatibility/42/mod.info` and report
   its `modversion`. Hash that file and the two server compatibility Lua files.
   Do not replace them if they are missing or stale; report the mismatch.
3. Read the active profile configuration and confirm whether these IDs were
   enabled for the test: `Bandits2`, `BanditsWeekOne`, and
   `CWModpackCompatibility`. Do not change the list.
4. Extract the bounded startup-through-disconnect window and report counts for:
   - `BWOScheduler.lua:42` / `schedule of non-table`;
   - `BWOPopControl.lua:102` / `playerIsHostile of non-table`;
   - `Spawner/Clan` errors or rejects;
   - `BanditRemove` errors;
   - all other Lua runtime exceptions grouped by first Lua frame and message.
5. Include every line in that window containing:
   - `[CWModpackCompatibility][WeekOne]`;
   - `[CWModpackCompatibility][Bandits]`;
   - `[CWTRACE]`, if the opt-in diagnostic mod was already enabled by the user.
6. If the logs expose `BanditWeekOne.Variant`, record its value before and after
   compatibility initialization. Do not probe or alter the save to obtain it.
7. Correlate player connect/disconnect times without including usernames,
   Steam IDs, IP addresses, or other account identifiers.

## Return format

Create `SERVER-RESULT-VARIANT-FIX.md` beside this request. Include:

- evidence metadata and hashes;
- active relevant mod IDs and compatibility version;
- the grouped error counts;
- bounded, redacted compatibility/diagnostic excerpts;
- whether the evidence supports PASS, FAIL, or INCONCLUSIVE for the variant
  flood and NPC phasing separately;
- any additional evidence required from the client.

Commit and push only that summary and any small redacted excerpts needed to
support it. Do not commit full logs or any player/network identifiers.

Project Remnants and its dependant mods remain outside this test.
