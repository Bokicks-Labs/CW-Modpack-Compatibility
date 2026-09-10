# Server result: Week One variant repair

## Result

| Check | Result | Evidence |
| --- | --- | --- |
| Week One client variant failure flood | **INCONCLUSIVE (server side is healthy)** | The server repaired `BanditWeekOne.Variant` from `nil` to numeric key `7`, and the server log contains zero matches for both previously repeating client failures. Those failures are client-only, so a post-fix client `console.txt` is still required for a definitive pass. The tester reported that NPCs are now visible. |
| NPC phasing | **INCONCLUSIVE** | The tester reported visible NPCs, but clarified that ordinary-looking zombies flickered and that NPCs fired at those disappearing targets. During the connected interval, 263 `BanditRemove` requests for 31 IDs all reported `authoritativeEntityRemoved=false`; no `BanditRemove` exception occurred. This single-client, approximately two-minute observation does not establish stable NPC/zombie lifecycle behavior. |

No server files, Workshop content, profile configuration, or save data were modified while collecting this evidence.

## Evidence identity

The restart/rejoin session is covered by:

- Debug log: `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\Logs\2026-09-10_15-45_DebugLog-server.txt`
  - Size at collection: `4,179,167` bytes
  - Last modification: `2026-09-10 15:52:19.920 -04:00`
  - SHA-256: `9468EC13958AF4DBBA29DC61956DB7AAAB77F14F2B76FD5417A0C80E0F27D908`
  - The size and modification time were unchanged before and after the shared-read hash operation.
- Connection log used only to bound the player session: `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\Logs\2026-09-10_15-45_connections.txt`
- Active server configuration: `C:\GameServers\ProjectZomboid\profiles\CWDayOneMP\Server\CWDayOneMP.ini`
  - Size: `21,584` bytes
  - Last modification: `2026-09-10 15:45:48.731 -04:00`
  - SHA-256: `83E0FEB40322CE3858FF66216AD44617235E3E8973DE7A0A1B0886E6C1A3F80B`

The original logs were read in place and left unchanged. No usernames, Steam IDs, IP addresses, network identifiers, or player coordinates are reproduced here.

## Installed compatibility artifact

The installed Workshop path was `C:\GameServers\ProjectZomboid\steamapps\workshop\content\108600\3797782198\mods\CWModpackCompatibility\42`.

| File | Size | Modified | SHA-256 |
| --- | ---: | --- | --- |
| `mod.info` | 563 bytes | `2026-09-10 15:45:55.131 -04:00` | `E2A37318B412F2F0EA2BDD826AACA4B11943A568BB9D5DF01ED2D22EAAE24F1C` |
| `media/lua/server/CWModpackCompatibility_BanditsServer.lua` | 2,206 bytes | `2026-09-10 15:45:54.934 -04:00` | `C2540D90DBAAF91B55449A6E42907F184EFC651EA76BFE13B1FF816CB09F0E11` |
| `media/lua/server/CWModpackCompatibility_WeekOneServer.lua` | 1,885 bytes | `2026-09-10 15:45:55.231 -04:00` | `B2AEFC7C9F5CA5222A145595A315F6182A102049A40DD7DC06D117D9A532B421` |

`mod.info` reports `modversion=1.1.7`. All three hashes exactly match repository `main` at `d0b665b`.

## Active mods

The active `Mods=` line contains all three requested IDs:

| Mod ID | Active |
| --- | --- |
| `Bandits2` | Yes |
| `BanditsWeekOne` | Yes |
| `CWModpackCompatibility` | Yes |

`CWBanditsPerfTest` was not active, so no `[CWTRACE]` lines were expected or found. Project Remnants was not considered in this follow-up.

## Bounded timeline

Times are local server time (`UTC-04:00`). Identity-bearing connection fields were discarded.

- `15:45:46.777`: debug log begins; restart initialization is in progress.
- `15:46:26.057`: Week One server hook logs `Repaired server variant nil -> 7`.
- `15:46:31.662`: the server-start hook again logs `Repaired server variant nil -> 7` after replacement/reinitialization of the mod-data table.
- `15:46:36.796`: `*** SERVER STARTED ****`.
- `15:50:34.473`: test client reaches fully connected state.
- `15:50:35.898` through `15:52:16.764`: Bandits logs 111 `AddZombiesInOutfit` creations.
- `15:50:50.847` through `15:52:19.920`: the compatibility boundary logs 263 `BanditRemove` requests for 31 distinct IDs; every lookup reports `authoritativeEntityRemoved=false`.
- `15:52:31.865` through `15:52:31.882`: disconnect events bound the end of the test.

## Requested error counts

The counts cover startup through the test disconnect.

| Signature | Count |
| --- | ---: |
| `BWOScheduler.lua:42` | 0 |
| `schedule of non-table: null` | 0 |
| `BWOPopControl.lua:102` | 0 |
| `playerIsHostile of non-table: null` | 0 |
| `Spawner`/`Clan` errors or rejects | 0 |
| `BanditRemove` errors or exceptions | 0 |
| `[CWTRACE]` | 0 |

Other Lua runtime errors, grouped by first reported function and message:

| First function/site | Message | Count | Timing |
| --- | --- | ---: | --- |
| `Lua(Vanilla).handleMannequinZone` | `Mannequin zone missing properties in media/maps/Muldraugh, KY/objects.lua` | 1 | `15:46:33.953`, before server-ready and client connection |

One non-Lua network exception occurred at `15:51:29.360`: `ZombieHitThumpable` reached `IsoDoor.ToggleDoorActual`, where Java reported a null `player`. It is recorded because it occurred during the symptom observation, but the server log does not prove that it was caused by NPC targeting or the flickering entities.

## Compatibility diagnostics

The complete requested `[CWModpackCompatibility]` lines are preserved, without identity-bearing connection data, in `SERVER-RESULT-VARIANT-FIX-COMPAT-LINES.txt` beside this report. Summary:

- 2 Week One lines: both `nil -> 7` repairs.
- 265 Bandits lines: one boundary-install line, one safe-loot-install line, and 263 removal observations.
- 2 other compatibility installation lines.
- 0 `[CWTRACE]` lines.

The server log exposes the pre-repair Week One variant as `nil` and the repaired numeric key as `7`. It does not expose a later client-side variant value.

## Additional client evidence required

For a definitive variant-flood result, preserve the client `console.txt` from this exact `15:50:34`–`15:52:31` session and count the two former signatures there. For the flickering-zombie/NPC-fire symptom, a client log or short recording with timestamps is needed, ideally with the optional `CWBanditsPerfTest` tracing enabled in a separately authorized diagnostic run. A longer two-client M2/M7 protocol remains necessary before declaring the NPC lifecycle stable.
