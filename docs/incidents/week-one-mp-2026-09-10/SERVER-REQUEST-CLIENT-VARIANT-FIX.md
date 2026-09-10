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

## Requested server work

1. Pull the newest `main` commit containing mod version 1.1.7.
2. Deploy the same `CWModpackCompatibility` payload to the dedicated server and
   ensure connecting clients receive/use that exact version.
3. Restart the dedicated server. Do not modify or delete the production save.
4. Preserve the complete startup and rejoin server log.
5. Confirm these markers appear on the dedicated server:
   - `[CWModpackCompatibility][WeekOne] Repaired server variant ...` if the
     stored key was absent/invalid.
   - `[CWModpackCompatibility][Bandits] Installed authoritative BanditRemove boundary.`
6. Record the stored `BanditWeekOne.Variant` value before and after startup if
   it can be read without changing the save. Report the corresponding variant
   name and numeric table key from the installed Week One build.
7. After one client remains connected for at least ten in-game minutes, report:
   - count of `BWOScheduler.lua:42` and `BWOPopControl.lua:102` errors;
   - all `[CWModpackCompatibility][WeekOne]` lines;
   - all authoritative Bandit removal lines;
   - any `Spawner/Clan` command errors or rejects.
8. Commit the evidence summary and relevant bounded log excerpts under this
   incident directory. Do not commit full logs containing player or network
   identifiers.

Project Remnants and its dependant mods remain outside this test.
