# Bandits Week One multiplayer investigation — 2026-09-10

## Executive diagnosis

The retained server evidence does **not** contain the reported two-client Week One failure. The only retained two-player session (01:35–01:40) used `Bandits2;CWModpackCompatibility` and predates the first configuration snapshot containing `BanditsWeekOne` (01:47). The only retained post-Week-One connection was one client for 74 seconds (02:42:24–02:43:38). No client console was retained on this machine.

Static analysis nevertheless identifies two concrete multiplayer boundary defects in `BanditsWeekOne` 42.20. The strongest phasing mechanism is client-local deletion of server-replicated zombies/NPCs while the corresponding server command deletes only Bandits Global ModData. Every connected client independently runs this population controller. That can produce the proposed lifecycle:

`server object exists -> client deletes local object -> server still owns object -> object is replicated again -> client deletes it again`

This mechanism is source-confirmed. Matching the reported visible loop to exact NPC IDs and timestamps remains pending a two-client run with client-side lifecycle tracing. No production compatibility change has been made.

## Evidence limitations

- Dedicated server build: 42.20.4, revision `b0bbce05d5`.
- Server-side logs are complete enough to separate startup noise from post-start activity.
- No Project Zomboid client installation or client `console.txt` was found on this server machine.
- `CWBanditsPerfTest` is not installed, not enabled, and is not present in this repository.
- Project Remnants, a Week One/Project Remnants patch, and PZ NPC Spawning System were not found installed or enabled. They cannot explain this preserved run.
- A deterministic visual reproduction cannot be completed from a headless dedicated server with no remote test client connected.

## CW-WO-MP-001

### Status

CONFIRMED

### Symptom

On a multiplayer client, zombies or Bandit NPCs can disappear locally and later be replicated back by the server. Repeated execution presents as rapid phasing/flicker.

### Reproduction

Source-level reproduction is deterministic with `Bandits2` plus `BanditsWeekOne`:

1. Join a dedicated server during a Week One phase where `BWOPopControl.ZombieMax < 400` (including the early Week One population phases).
2. Allow the client cache to contain more zombies than `ZombieMax`, or allow a Week One NPC selected by one of the population despawners to cross 50 tiles from a player.
3. `BWOPopControl.Zombie` runs every eight client ticks; the NPC-specific population controller runs every in-game minute.
4. Observe that the client calls `removeFromWorld()` / `removeFromSquare()` locally.
5. For Bandit NPCs, the client sends `Commands/BanditRemove`; the server handler removes only the Global ModData brain and transmits that cluster. It does not remove the authoritative `IsoZombie`.

The visible repeated loop still requires an instrumented two-client confirmation.

### Evidence

- `BanditsWeekOne/42.20/media/lua/client/BWOPopControl.lua:44-84`: `BWOPopControl.Zombie` walks the client `BanditZombie.CacheLight`; after the client-local count exceeds `ZombieMax`, lines 69-70 remove the local zombie object. For a Bandit it sends `Commands/BanditRemove` at line 75.
- The same client file registers that function through `Events.OnTick` at lines 721-724 and 780-781, with an eight-tick cadence.
- `BWOPopControl.lua:160-189`, `380-408`, and `452-481`: street, inhabitant, and survivor despawners remove client objects locally when their distance from that client's player exceeds 50, then send `Commands/BanditRemove`.
- `Bandits/42.20/media/lua/server/BanditServerCommands.lua:47-56`: `BanditRemove` clears `gmd[id]` and transmits the cluster; it never removes the server `IsoZombie`.
- `BWOPopControl.lua:717-718,780`: `UpdateCivs` runs from the client file on every connected client. No server-authority or elected-client gate protects population decisions.
- The street spawner selects offsets of 35-59 on both axes (`BWOPopControl.lua:104-111`) while the despawner threshold is radial distance >50 (`:176-184`). Many new candidates can therefore be outside the removal radius immediately.
- A Workshop-wide assignment search found no active third-party replacement of these Week One population functions or `BanditServer.Spawner.Clan`.

### Root Cause

Week One makes population/despawn decisions independently on every client and deletes replicated objects only from the client's world. Its server removal command deletes the Bandits brain record, not the authoritative server entity. This violates the multiplayer ownership boundary and leaves the server free to replicate the object back.

This is a confirmed defect and a viable direct phasing mechanism. The retained evidence does not yet prove it was the only mechanism in the reported session.

### Owning Mod / Interaction

`BanditsWeekOne` client population control interacting with `Bandits2` server replication and Global ModData.

### Recommended Fix Boundary

The compatibility layer should make Week One population authority singular and server-side. A client must request a server despawn; it must not locally remove a server-owned `IsoZombie`. The server operation must remove both the Bandits brain and the authoritative entity in a safe order, then replicate the result. The development agent owns the implementation.

### Validation Requirements

- Two remote clients plus dedicated server.
- Correlate one raw/normalized persistent outfit ID across spawn, brain registration, both clients, despawn request, server entity removal, and final absence.
- Test player separation and convergence at 0-35, 45-55, 55-80, and >80 tiles.
- Confirm no delete/recreate loop for at least ten in-game minutes.
- Verify movement, combat, death, normal spawn/despawn, reconnect, server save/reload, CPU, and error rate.

## CW-WO-MP-002

### Status

CONFIRMED

### Symptom

Inhabitant population updates can throw repeated client-side nil-index/call errors in multiplayer and fail before NPC creation completes.

### Reproduction

1. Run a dedicated multiplayer server with `Bandits2` and `BanditsWeekOne`.
2. Join as a client in an area where `BWOPopControl.InhabitantsSpawn` produces a nonempty `roomPool`.
3. Wait for the client `EveryOneMinute` population update.
4. The client executes `BanditServer.Spawner.Clan(player, args)`.

Exact error text must be captured from the client console because no client log is present on this machine.

### Evidence

- `BanditsWeekOne/42.20/media/lua/client/BWOPopControl.lua:192-377` is a client Lua module.
- Its active path directly calls `BanditServer.Spawner.Clan` at line 347. The networked `sendClientCommand` alternative appears only inside commented-out code at line 370.
- `BanditServer.Spawner.Clan` is defined only in `Bandits/42.20/media/lua/server/BanditServerSpawner.lua:1104-1122`.
- Other Week One spawn paths correctly use `sendClientCommand(player, 'Spawner', 'Clan', args)`, including streets at line 154 and survivors at line 445.
- The dedicated server logs cannot contain this client exception. No retained client log exists.

### Root Cause

The active inhabitant spawn path directly calls a server-only Bandits API from a client-only Lua module. Single-player can mask this because client and server namespaces coexist; a true multiplayer client cannot rely on `BanditServer` being defined.

Correlation with the user's reported error flood is not yet proven until the original or a new client stack trace is captured.

### Owning Mod / Interaction

`BanditsWeekOne` calling the `Bandits2` server spawner across an invalid Lua execution boundary.

### Recommended Fix Boundary

Replace/intercept the inhabitant spawn path in the compatibility layer so it sends the same validated `Spawner/Clan` client command used by the other Week One spawn paths. Preserve rate limits and server-side validation. Do not suppress the exception.

### Validation Requirements

- Force a nonempty inhabitant room pool on a remote client.
- Capture the pre-fix stack at `BWOPopControl.lua:347`.
- Verify one client request produces one server spawn, one brain record, and one entity visible to both clients.
- Confirm the server rejects malformed or unauthorized spawn requests as appropriate.

## CW-WO-MP-003

### Status

SUSPECTED

### Symptom

A Bandit can oscillate between Bandit and ordinary-zombie state, lose visuals/AI, or become eligible for Week One's non-Bandit deletion path.

### Reproduction

Not yet established. Instrument raw and normalized persistent outfit IDs on spawn and lookup, prioritizing IDs whose bit 16 is set.

### Evidence

- `Bandits/42.20/media/lua/server/BanditServerSpawner.lua:295,301,423-425` keys the server brain record using raw `zombie:getPersistentOutfitID()`.
- `Bandits/42.20/media/lua/shared/BanditUtils.lua:614-629` normalizes that ID by clearing bit 16 when set.
- `Bandits/42.20/media/lua/client/BanditUpdate.lua:2080-2102` uses the normalized ID for cluster lookup, calls `Banditize` when a record exists, and `Zombify` when the object is marked Bandit but the lookup misses.
- `BWOPopControl.Zombie` also uses the normalized cache ID and deletes objects for which `gmd[id]` is absent.

### Root Cause

Not proven. The server and client appear to use different key forms for some persistent outfit IDs. A live trace must show a raw/normalized mismatch and subsequent state transition before this can be promoted.

### Owning Mod / Interaction

`Bandits2` server spawner, shared ID normalization, client update, and the `BanditsWeekOne` client despawner.

### Recommended Fix Boundary

First determine the canonical ID expected by Bandits Global ModData. If mismatch is observed, normalize at one compatibility boundary without rewriting stored saves blindly. Migration/dual-read may be needed for existing brain records.

### Validation Requirements

- Log raw ID, normalized ID, cluster index/key presence, Bandit flag, coordinates, and client/server role.
- Demonstrate whether bit-16 IDs miss lookup.
- Test existing save load as well as fresh spawn.
- Confirm no duplicate brain records and no `Banditize`/`Zombify` oscillation.

## Current conclusion

The smallest **source-supported** failing stack is `Bandits2 + BanditsWeekOne`; neither Project Remnants nor the full Chaosworld pack is required for the two confirmed boundary defects. The smallest **visually verified** reproduction remains open because this machine has no client and the retained post-Week-One session lacks a second client and client console. `TEST-MATRIX.md` defines the next controlled run needed to close that gap.
