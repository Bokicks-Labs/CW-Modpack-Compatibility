# Server evidence request: Week One removal baseline

## Decision

`BanditsWeekOne` is temporarily removed from the Chaosworld multiplayer
profile. The repeated flickering entities remain physically present on the
server: players cannot interact with them, but Bandits NPCs can still detect
and shoot them. Compatibility version 1.1.8 did not correct that lifecycle.

Keep the attempted Week One fixes in `CWModpackCompatibility`; version 1.1.9
now leaves its Week One-only server removal wrapper uninstalled unless both
`Bandits2` and `BanditsWeekOne` are active.

## User-managed configuration change

The user owns profile edits, Workshop delivery, save backup, and restart. The
server thread must not perform these actions.

Remove these entries if present:

| Purpose | Mod ID | Workshop ID |
| --- | --- | ---: |
| Week One scenario | `BanditsWeekOne` | `3403180543` |
| Week One command wheel | `BanditsWeekOneCommandWheel` | `3791829599` |
| Week One AI NPC Overhaul | `AIWeekOne` | `3782586843` |

The last two are Week One companions and must not remain enabled without their
scenario dependency. Keep `Bandits2`, `BanditsCreator`, and
`CWModpackCompatibility` enabled. Do not add, remove, or reconfigure Project
Remnants or its dependants as part of this change.

Before changing the profile, the user should preserve a recoverable copy of
the server configuration and save. The user will deploy compatibility version
1.1.9 through Steam Workshop and restart the server.

## Read-only evidence to collect

Begin after the user confirms the profile change, Workshop update, restart,
and rejoin test are complete.

1. Confirm the installed `CWModpackCompatibility` reports `modversion=1.1.9`.
2. Record the active `Mods=` and `WorkshopItems=` counts and report only the
   presence or absence of the six IDs in the table above and keep-list. Do not
   publish the complete mod list unless needed to explain a failure.
3. Confirm `BanditsWeekOne`, `BanditsWeekOneCommandWheel`, and `AIWeekOne` are
   absent, while `Bandits2` and `CWModpackCompatibility` remain active.
4. Confirm startup contains no compatibility installation or repair lines
   tagged `[CWModpackCompatibility][WeekOne]` and no
   `Installed authoritative BanditRemove boundary` line. The general
   `[CWModpackCompatibility][Bandits] Installed safe container-loot target fix`
   line is expected because `Bandits2` remains active.
5. From server-ready through the test disconnect, count and group:
   - Lua errors and Java exceptions by signature and first relevant frame;
   - `AddZombiesInOutfit` activity;
   - `BanditRemove` requests;
   - zombie removal, replication, or hit warnings.
6. Record the user's observed result separately for:
   - flickering/phasing zombie-like entities;
   - ability to interact with those entities;
   - ordinary Bandits NPC visibility and interaction;
   - Bandits NPCs firing at invisible or non-interactable targets.
7. Report whether this is an existing save or a fresh save. Do not modify or
   delete residual `BanditWeekOne` Global ModData in the existing save.

## Return format

Create `SERVER-RESULT-WEEK-ONE-REMOVAL.md` beside this request. Include bounded
timestamps, compatibility version, presence/absence checks, grouped error
counts, and separate PASS/FAIL/INCONCLUSIVE conclusions for:

- Week One and its direct companions being disabled;
- Week One compatibility hooks remaining inactive;
- flickering entities no longer appearing;
- base Bandits NPC behavior remaining functional.

Commit and push only the summary and small redacted excerpts needed to support
it. Do not commit full logs, server credentials, usernames, Steam IDs, IP
addresses, or other identity-bearing data.
