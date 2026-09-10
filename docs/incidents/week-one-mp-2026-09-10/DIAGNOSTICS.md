# CWBanditsPerfTest diagnostic package

`Contents/mods/CWBanditsPerfTest/42` is a separate, opt-in mod created for this incident. It does not change `CWModpackCompatibility` and does not implement a production fix.

## What it traces

- Client Bandit state transitions, raw and normalized persistent outfit IDs, brain lookup form, program, and coordinates.
- Week One local-removal calls from zombie-limit, street, inhabitant, and survivor population controllers.
- A later `OnZombieUpdate` for the same normalized ID after a local-removal function returned, including whether the Java object string is unchanged.
- Whether `BanditServer.Spawner.Clan` is present when the client invokes the inhabitant spawn path.
- Server spawn requests/returns and Bandit brain removal requests/returns.
- Once-per-minute authoritative **loaded-cell** Bandit counts and raw/normalized ID mismatch counts.

It uses these prefixes:

- `[CWTRACE][CLIENT][NPC]`
- `[CWTRACE][SERVER][NPC]`

## Safety and overhead

- The mod is disabled unless explicitly added as `CWBanditsPerfTest` after `BanditsWeekOne` in `Mods=`.
- It wraps only named Bandits/Week One functions to observe entry/return and preserves their return value.
- It does not suppress exceptions; a caught population-function exception is logged and rethrown.
- Client state logs are emitted only on state signature changes.
- Local-removal logs are rate-limited per source and NPC ID to one every two seconds.
- Server enumeration occurs once per in-game minute, not per tick.
- It deliberately records no usernames, IP addresses, Steam IDs, or chat data. Player identity is the transient online ID.

## Deployment requirement

The diagnostic mod must exist on the dedicated server and both remote clients. Source is committed for the development agent to package/publish through the existing Workshop workflow. It has not been enabled or deployed to the production-like `CWDayOneMP` profile during this evidence-preservation pass.

For the controlled M3 run, append `CWBanditsPerfTest` after `BanditsWeekOne` in the disposable test profile's `Mods=` line. Preserve all server and client console logs before disabling the mod.

## Trace interpretation

- `LOCAL_REMOVE_RETURN` proves a Week One client population function returned after obtaining that Bandit object for its local removal path.
- `SEEN_AFTER_LOCAL_REMOVE` means the same normalized ID was updated again at least 250 ms later. `sameObject=0` strongly supports recreation/resynchronization; `sameObject=1` means the same client object remained/re-entered update and still demonstrates that local deletion was not final.
- `REMOVE_RETURN ... authoritativeEntityRemoval=0` documents the current Bandits handler contract: brain deletion only. It is a static annotation, not a runtime test of engine internals.
- A `STATE` record with `rawBrain=1 normalizedBrain=0` and `raw != normalized` is the evidence needed to promote `CW-WO-MP-003`.
