# Chaosworld Bandits / Week One NPC architecture

Status: static architecture audit, 2026-09-10. No multiplayer root cause is claimed here.

## Scope

This pass covers the NPC lifecycle shared by:

- Bandits (`Bandits2`, Workshop `3268487204`, Build 42.20 payload)
- Bandits Week One (`BanditsWeekOne`, Workshop `3403180543`, Build 42.20 payload)
- Chaosworld compatibility (`CWModpackCompatibility` 1.1.6)
- the local diagnostic override (`CWBanditsPerfTest`)

Project Remnants, `ProjectRemnantsWeekOneMenuPatch`, and
`PZ_NpcSpawningSystem` are intentionally deferred. They are not part of the
current production compatibility target and should be introduced in a later,
separately measured stage.

The installed sources were inspected directly. At the time of this audit,
`docs/incidents/week-one-mp-2026-09-10/` was not present on `origin/main`, so
the multiplayer disappearance/phasing symptom remains an observed symptom
without a repository-backed root cause.

## Executive map

```text
Week One client scheduler/population policy
    |
    | sendClientCommand("Spawner", "Clan", args)
    v
Bandits server spawner
    |
    | creates IsoZombie + assigns persistent-outfit ID
    | writes brain into one of 32 Global ModData clusters
    v
PZ zombie replication + Bandits Global ModData replication
    |
    v
Each client: OnZombieUpdate
    |-- brain exists in cluster -> Banditize local IsoZombie representation
    |-- brain absent            -> Zombify local representation
    |-- run Bandits/Week One AI and presentation work
    |
    v
Week One client population policy
    |-- recounts only the client's loaded Bandit cache
    |-- may request more server spawns
    `-- may remove a local zombie body, then request server brain removal
```

The system is not purely server-authoritative. The server owns spawning and
the persisted Bandits brain registry, while clients perform most NPC AI,
Bandit conversion, population measurement, and some physical removal. That
split is the primary multiplayer compatibility boundary to validate.

## Entity and identifier model

Bandits NPCs are `IsoZombie` instances made to look and behave as humans. They
are not `IsoPlayer` NPCs.

`BanditServerSpawner.lua` creates a zombie with
`BanditCompatibility.AddZombiesInOutfit`, then `banditize` builds its brain.
The brain ID begins as `zombie:getPersistentOutfitID()`. Client lookup uses
`BanditUtils.GetZombieID`, which normalizes the high outfit bit before using
the value as a cache and Global ModData key.

Important identity fields are:

- `brain.id`: normalized persistent-outfit identity and registry key.
- `brain.cid` / `brain.clan`: Bandits clan identity.
- `brain.bid`: custom Bandit profile identity.
- `brain.master`: owning player identity. In multiplayer, player identity is
  `IsoPlayer:getOnlineID()`; in single player it is the constant `1`.
- `zombie:getModData().brain`: client-side live brain reference.
- `zombie:getModData().brainId`: copied during Bandit conversion for corpse
  and diagnostic lookup.

There is no second Chaosworld-assigned NPC ID at present.

## Bandits lifecycle

### Construction and registration

The normal multiplayer spawn path is server-owned:

1. A client sends `Spawner.Clan`, `Spawner.Type`, or another supported command.
2. `BanditServerSpawner.lua` receives it through `Events.OnClientCommand`.
3. The server creates one or more `IsoZombie` bodies.
4. `banditize` builds the brain, applies initial visuals, stores the brain as
   `GetBanditClusterData(id)[id]`, and transmits that cluster.

Natural Bandits groups are also considered by the server's
`Events.EveryTenMinutes` scheduler. Week One mostly supplies its own denser
client-side population policy.

### Client registration and lookup

`BanditZombie.lua` maintains process-local caches keyed by the normalized
persistent-outfit ID:

- `Cache`: live `IsoZombie` references.
- `CacheLight`: all loaded zombie summaries.
- `CacheLightB`: loaded Bandit summaries.
- `CacheLightZ`: loaded ordinary-zombie summaries.

The caches update on `Events.OnZombieUpdate`, remove dead entries on
`Events.OnZombieDead`, and rebuild once per game minute from the client's
loaded cell.

`BanditUpdate.lua` also runs on `Events.OnZombieUpdate` and explicitly returns
on the server. For each client-visible zombie it compares the local body with
the relevant Global ModData cluster:

- Registry entry present and body not yet marked `Bandit`: attach the brain,
  apply visuals, and convert the body with `Banditize`.
- Registry entry absent and body marked `Bandit`: remove Bandit state with
  `Zombify`.

After conversion, the client applies visuals, selects programs/tasks, and
executes AI actions. `BanditUpdate` itself is not guarded by
`BanditUtils.IsController`. Individual world-mutating zombie actions use the
controller check selectively. `BanditUtils.IsController` chooses whichever
online player is closest to the zombie and compares that player's online ID
with local player zero.

This means controller ownership can change as players move, and task/visual
work can still run on more than the chosen controller. That is a static
property to instrument; it is not yet proof of the reported phasing.

### Synchronization

Bandits persists brains in 32 Global ModData tables named `BanditC0` through
`BanditC31`. Clients request the tables in `Events.OnInitGlobalModData` and
replace their local references in `Events.OnReceiveGlobalModData`.

Client-to-server updates use several `Events.OnClientCommand` handlers:

- `Commands.BanditUpdatePart` mutates selected fields in the authoritative
  brain and retransmits its cluster.
- `Commands.BanditRemove` deletes the authoritative brain and retransmits.
- `Sync.Health` and other action commands synchronize selected effects.
- `Spawner.*` creates server-side bodies and brains.

Server-to-client commands handled through `Events.OnServerCommand` cover
selected effects such as health, vehicles, markers, and random state. Brain
existence and most brain data arrive through Global ModData, not a dedicated
spawn command echo.

### Removal and persistence

On death, client `BanditUpdate.lua` clears the body's Bandit state and sends
`Commands.BanditRemove`; the server removes the brain from its cluster. Corpse
sync uses a separate `BanditCorpse` command.

Week One additionally removes live NPC bodies for population control. Its
despawn functions call `removeFromSquare()` and `removeFromWorld()` on the
client first, then send `Commands.BanditRemove` to the server.

Bandits' durable state is the Global ModData registry plus PZ's zombie/world
state. A `BanditPermanent.Check` restore design exists, but the installed
implementation returns immediately and is disabled. Therefore this version
does not actively recreate a missing permanent body from its saved brain via
that path.

## Week One lifecycle participation

Week One extends Bandits; it does not introduce a separate NPC class or ID
registry. Its clan map, programs, actions, and `BanditPlayer.CheckFriendlyFire`
assignment all operate on Bandits brains and zombie-backed bodies.

### Scheduler and world state

`BWOScheduler.lua` is client Lua. It uses `getSpecificPlayer(0)` and maintains
an in-memory `BWOScheduler.Events` queue:

- `Events.OnGameStart`: stores/restores settings and starts the chosen variant.
- `Events.EveryOneMinute`: computes world age and scenario flags.
- `Events.OnTick`: dispatches due queued events.

Its durable world metadata uses the separate `BanditWeekOne` Global ModData
table (`BWOGMD.lua`). The server's `BWOClientCommands.lua` handles world-event
commands and retransmits that table. The scheduled event queue itself is
process-local and is not serialized by the inspected Lua.

### Population control

`BWOPopControl.lua` is the central Week One NPC lifecycle participant:

- `Events.EveryOneMinute` calls `UpdateCivs`.
- `UpdateCivs` counts programs in the local client's `CacheLightB`, calculates
  desired street/inhabitant/survivor populations around local player zero, and
  spawns or despawns the difference.
- Street and survivor creation use server commands.
- The active inhabitant path calls `BanditServer.Spawner.Clan` directly from a
  client file instead of sending a command. This is a single-player-shaped
  boundary and must be checked against the multiplayer errors before changing
  it.
- Street, inhabitant, and survivor removal uses distance from local player zero
  with a 50-tile threshold. Removal physically deletes the local body before
  asking the server to delete the brain.
- Every eighth tick, `BWOPopControl.Zombie` enforces the current zombie cap
  against the client's loaded cache and can remove non-registered zombies.
- `Events.OnZombieUpdate` adds Week One-specific per-NPC state such as
  reanimation timing and fallout damage.

Because every multiplayer client runs this client module, clients can observe
different loaded caches, density, distances, and desired counts. The source
contains no leader/host/controller gate around `UpdateCivs` or its distance
despawners. Multiple clients can therefore issue overlapping spawn/removal
requests from different local views. This is the highest-priority static
compatibility boundary for the investigator to correlate with runtime data.

### Other relevant hooks

- `BWOPlayer.lua` uses `Events.OnPlayerUpdate`, hit/death events, and timed
  action events for player/scenario reactions. It assigns
  `BanditPlayer.CheckFriendlyFire = BWOPlayer.CheckFriendlyFire`.
- `BWOAmbience.lua` also uses `Events.OnPlayerUpdate`.
- Week One has multiple additional `OnTick` systems for effects, emitters,
  vehicles, radio, lights, and square events. They are scenario systems rather
  than NPC identity registries, but their client-local execution matters when
  reproducing multiplayer load.
- `BWOClientCommands.lua` handles `Events.OnClientCommand` on the server.
- `BWOEffects.lua` and `BWOEffects2.lua` handle `Events.OnServerCommand` on
  clients.
- Week One has no inspected `Events.OnCreatePlayer` or `OnServerStarted` NPC
  lifecycle hook.

## Current Chaosworld compatibility behavior

`CWModpackCompatibility` currently touches this stack in two files.

### `shared/CWModpackCompatibility_Bandits.lua`

When `Bandits2` is active, it replaces only
`BanditPrograms.Container.Loot`. The replacement fixes the upstream
out-of-scope `enemyCharacter` lookup, preserves the expected task shape, and
uses a local `predicateAll` because the upstream callback is file-local.

Installation is requested from both `Events.OnGameStart` and
`Events.OnServerStarted`, and the marker
`BanditPrograms.Container.__cwSafeLoot` prevents this patch from installing
twice in one Lua environment. The function is replaced rather than wrapped;
there is no saved original because this patch is a complete narrow repair of
that one routine.

The patch does not create, register, identify, synchronize, persist, or remove
NPCs.

### `client/CWModpackCompatibility_WeekOne.lua`

When `BanditsWeekOne` is active, it:

- wraps `BWOChatPanel.new` with an idempotent pre-player guard; and
- wraps `BWOScheduler.Add` with idempotent diagnostics for selected emergency
  events.

Both installers run immediately when the file loads and again on
`Events.OnGameStart`. Originals are saved in local variables before wrapping,
and table markers prevent repeat installation. These hooks do not alter NPC
population ownership or removal.

### Load-order dependencies

`CWModpackCompatibility` declares no `require` or `loadModAfter` relationship
to Bandits or Week One. Its installers therefore rely on the target globals
being available by callback time. The Bandits repair retries at game/server
start; the Week One hooks retry at game start only.

The compatibility mod also supplies Build 42 moved-module shims such as
`CharacterCreationMain.lua` and `MainScreen.lua`. Those support old import
paths but do not participate in the current Bandits NPC lifecycle.

## `CWBanditsPerfTest` diagnostic override

`CWBanditsPerfTest` supplies the same relative file as Bandits:
`client/BanditUpdate.lua`. It is therefore a full-file diagnostic override,
not a wrapper around a small function.

The local copy matches the currently installed upstream file except for a
load marker and a distance gate before expensive `CanSee` checks in
`ManageCombat` (12 inserted and 4 changed lines in the current comparison).
It retains Bandits' remove/add registration pattern for `OnZombieUpdate`,
`OnHitZombie`, `OnZombieDead`, and `OnDeadBodySpawn`, so only the copied
handlers should remain registered if load order behaves as intended.

Because it copies the entire 2,600-line upstream module, a Workshop update can
silently make it stale. It should remain diagnostic-only and must be compared
to installed Bandits before each test. Its current combat visibility change
does not directly alter Week One population spawn/despawn logic.

## Static risk register (not fixes)

| Boundary | Static evidence | Runtime proof needed |
| --- | --- | --- |
| Per-client population authority | `BWOPopControl.UpdateCivs` runs every minute in client Lua, counts a local cache, and has no host/controller gate. | Correlate each client's spawn/remove decisions with server commands and NPC disappearance times. |
| Client physical removal before server registry removal | Week One distance despawners call `removeFromSquare`/`removeFromWorld`, then send `BanditRemove`. | Determine whether other clients retain/recreate the same body or receive a cluster transition that causes visible conversion. |
| Different local distance origins | Week One despawn uses `getSpecificPlayer(0)` on every client. | Record player online ID, NPC ID, positions, distance, and removing client for each removal. |
| Direct server API call in a client module | `InhabitantsSpawn` calls `BanditServer.Spawner.Clan` directly. | Capture the exact multiplayer error and whether inhabitants fail, duplicate, or fall back through another path. |
| Broad client AI with selective controller guards | `BanditUpdate` generates/processes tasks on each client; only selected actions check nearest-player ownership. | Compare task/program changes for one persistent-outfit ID on two clients and identify which mutations reach the server. |
| Event/load duplication | Bandits handlers commonly remove then add; Week One population handlers only add. | Confirm each Lua file loads once per process and count callbacks per real minute/tick. |
| Diagnostic full-file override drift | `CWBanditsPerfTest` shadows all of `BanditUpdate.lua`. | Log its marker and hash-match it to the intended upstream version for every validation run. |

None of these boundaries should be patched solely from static suspicion.

## Requested investigator evidence

Keep high-frequency tracing in `CWBanditsPerfTest`. For one affected NPC ID,
capture a short synchronized window containing:

1. Client identity: local player online ID, coordinates, and whether
   `BanditUtils.IsController(npc)` is true.
2. NPC identity: persistent outfit ID, normalized Bandits ID, program, brain
   presence in the local cluster, physical `Bandit` variable, and coordinates.
3. Every Week One population decision: local counts/targets, spawn command, or
   despawn reason/distance, including the issuing client.
4. Server receipt of `Spawner.Clan` and `Commands.BanditRemove`, including
   sender and ID, plus before/after registry existence.
5. Client transitions through `Banditize` or `Zombify` for that ID.
6. Confirmation that `BWOPopControl.UpdateCivs` and its handlers are invoked
   once per expected event per client.

The most useful isolation matrix is:

- Bandits + Week One only.
- Add `CWModpackCompatibility`.
- Add `CWBanditsPerfTest` last.

Project Remnants and its dependants should remain disabled for this matrix.
Once the incident files contain a reproducible correlation, assign a
`CW-WO-MP-*` ID and implement one narrow production change against that
confirmed boundary.
