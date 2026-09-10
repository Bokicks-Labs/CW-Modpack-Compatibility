# Week One multiplayer test matrix

## Evidence chronology

| Local time (ET) | Mods / event | Players | Result |
|---|---|---:|---|
| 00:37 and 01:22 config snapshots | 241 mods; relevant stack `Bandits2;CWModpackCompatibility` | — | Week One absent |
| 01:35:01–01:40:29 | Same pre-Week-One startup | 2 fully connected | Only retained two-player session; cannot reproduce a Week One defect |
| 01:47:34 config snapshot | 242 mods; `BanditsWeekOne` first appears | — | First preserved Week One configuration |
| 01:49, 02:00, 02:18 startups | Week One enabled | 0 | Startup only; no MP visual test |
| 02:01:12 config snapshot | `BanditsWeekOneCommandWheel` added | — | Command wheel now present |
| 02:42:24–02:43:38 | Full 247-mod config with Week One | 1 | One short remote-client session; no client log retained |

The configuration snapshots remain under `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\profile-state\config-backups`. The original server logs and save have not been modified.

## Controlled stack progression

Use a new disposable profile/save for every row. Do not reuse `CWDayOneMP` save data when determining first appearance. Each row needs a dedicated server and two remote clients unless marked startup-only.

| ID | Enabled stack | Availability on server | Status | Purpose / pass criterion |
|---|---|---|---|---|
| M0 | Vanilla dedicated server | Available | NOT RUN | Networking/control baseline |
| M1 | `Bandits2` | Available | NOT RUN | Bandits MP baseline; NPCs stable on both clients |
| M2 | `Bandits2;BanditsWeekOne` | Available | NOT RUN — highest priority | Smallest source-supported failing stack; capture phasing and line 347 error |
| M3 | M2 + `CWBanditsPerfTest` diagnostics | Not installed | BLOCKED ON DIAGNOSTIC DEPLOYMENT | Trace entity/brain lifecycle without changing behavior |
| M4 | M2 + Project Remnants | Not installed | UNAVAILABLE | Suggested interaction isolation |
| M5 | M4 + Week One/Project Remnants patch | Not installed | UNAVAILABLE | Patch regression/isolation |
| M6 | M5 + PZ NPC Spawning System | Not installed | UNAVAILABLE | Spawn-system interaction |
| M7 | M2 + `CWModpackCompatibility` | Available | NOT RUN | Determine whether current compatibility hooks affect baseline |
| M8 | M7 + `BanditsWeekOneCommandWheel` | Available | NOT RUN | Command-wheel interaction |
| M9 | Current full 247-mod Chaosworld configuration | Available | INCONCLUSIVE | Final confirmation only after M1/M2/M7 |

The suggested Project Remnants and PZ NPC Spawning rows cannot be responsible for the retained server run because those mods were not found installed or enabled. They should not delay M1/M2.

## Exact M2 reproduction protocol

1. Create a clean profile and clean save with only the minimum required Workshop items for `Bandits2` and `BanditsWeekOne`.
2. Start the dedicated server and preserve its config and complete log with SHA-256 hashes.
3. Connect client A. Start client logging before character load.
4. Connect client B at least 80 tiles away, then move through these bands relative to the same NPC: 0-35, 45-50, 50-60, and 60-80 tiles.
5. Remain connected for at least ten in-game minutes so both the eight-tick zombie controller and multiple `EveryOneMinute` population updates execute.
6. Repeat in an outdoor street area and a building-rich area so `StreetsSpawn` and `InhabitantsSpawn` both execute.
7. Record whether the same NPC is visible to A, B, and (where observable through server state) the server. The headless server has no render view; use authoritative entity enumeration.
8. Move one player beyond 50 tiles while the other remains near the NPC. This specifically tests conflicting client-local population authority.
9. Disconnect/reconnect client B, then save/restart the server and observe the same population.
10. Repeat M1, M2, and M7 with identical world seed, coordinates, sandbox settings, and timings.

## Required lifecycle trace fields

Use `CWBanditsPerfTest` for observational instrumentation. It is currently absent and must be deployed to the server and both clients before M3.

- Prefix: `[CWTRACE][SERVER][NPC]`, `[CWTRACE][CLIENT][NPC]`, or `[CWTRACE][NETWORK]`.
- Event: first seen, spawn request, server spawn, brain registration, cluster transmit/receive, Banditize, Zombify, local removal candidate, removal request, authoritative removal, reappearance.
- Identity: raw persistent outfit ID, `BanditUtils.GetZombieID` normalized ID, cluster/key, program/clan.
- State: coordinates, health/alive, Bandit flag, server/client, player online ID, selected controller/owner, GMD presence.
- Timing: wall-clock time and game tick/world age.
- Rate limit: emit on state transition; suppress unchanged per-tick state. Allow one aggregate summary per 60 seconds.

## Decision rules

- `CW-WO-MP-001` is visibly reproduced only if the same identity is locally removed and later reappears while the server entity persists, or if equivalent trace evidence proves a delete/resync cycle.
- A new identity after every disappearance is a respawn loop, not a replication loop; record it separately.
- A GMD removal followed by a new spawn request indicates population feedback; capture the requesting client.
- A raw/normalized ID mismatch followed by lookup failure promotes `CW-WO-MP-003` only when the same identity/state transition is correlated.
- Absence of console errors is not a pass. NPC visibility, persistence, movement, combat, spawn/despawn, reconnect, server stability, and CPU must all pass.
