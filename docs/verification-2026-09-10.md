# Week One multiplayer boundary fixes

## Scope

This change follows the server-thread findings for `Bandits2` plus
`BanditsWeekOne`. Project Remnants, its menu patch, and the PZ NPC spawning
dependants remain out of scope.

## Changes

- The client compatibility hook now provides the missing `BanditServer.Spawner.Clan`
  boundary used by Week One inhabitants. It forwards validated `cid` requests
  through `sendClientCommand(player, "Spawner", "Clan", args)`.
- The server compatibility hook wraps `BanditServer.Commands.BanditRemove`.
  It removes the matching authoritative Bandit entity from the server cell
  before allowing Bandits to delete and transmit the brain record. Raw and
  normalized persistent-outfit IDs are both accepted.

Both hooks are idempotent and activate only when the affected Bandits/Week One
mods are enabled.

## Verification

- `git diff --check` passes.
- `dev-scripts/test-week-one-boundaries.py` exercises invalid/named/numeric
  variant repair, server synchronization, idempotence, and inhabitant command
  forwarding with Lua mocks.
- Run the M2 and M7 two-client protocol in
  `docs/incidents/week-one-mp-2026-09-10/TEST-MATRIX.md`, preserving server and
  client logs. Confirm one inhabitant request produces one server spawn and that
  a removed Bandit does not reappear on either client.

## Rejoin evidence and variant-state repair

The 15:01 client session produced 518 failures each at
`BWOScheduler.lua:42` and `BWOPopControl.lua:102`. Both dereferenced
`BWOVariants[gmd.Variant]` after the dedicated-server path supplied no valid
numeric variant key. The compatibility hooks now resolve numeric strings and
variant names, default missing state to the registered `Original` variant,
invalidate the cached schedule, and synchronize the repaired key with the
server. The server performs the same repair before transmitting Week One data.

## Server-result follow-up: sandbox baseline and removal lookup

The 15:46 client log confirms the earlier `schedule` and `playerIsHostile`
failures are gone. It exposes the next blocked initialization step instead: 49
`__sub not defined for operands in adjustSandboxVars` failures at
`BWOScheduler.lua:240`. Week One's dedicated-server Global ModData contained an
empty `Sandbox` baseline, so its interpolation attempted to subtract nil from a
number. Version 1.1.8 restores only missing values from the authoritative
`SandboxVars`, including the nested zombie-population value, on both server and
client.

The server report also recorded 263 Bandit removal requests with zero entity
matches. Bandits' server spawner registers a brain but does not set the
client-side `Bandit` animation variable. The compatibility lookup incorrectly
required that variable. Version 1.1.8 instead requires a matching Bandits brain,
accepts raw or normalized persistent-outfit IDs, removes the authoritative
entity, and clears any alternate raw/normalized brain key.

## Week One removal guard

The rejoin after version 1.1.8 still showed large numbers of flickering,
non-interactable zombie-like entities that Bandits NPCs detected and attacked.
`BanditsWeekOne` and its direct companions are therefore being removed from the
multiplayer profile pending a future redesign or upstream multiplayer support.
The attempted compatibility fixes remain available for later testing.

Version 1.1.9 narrows the authoritative `BanditRemove` wrapper to the exact
`Bandits2 + BanditsWeekOne` stack. With only `Bandits2` enabled, it preserves
the original Bandits command unchanged. Lua mock coverage also confirms that
the Week One client wrappers, state repair, server state repair, and removal
wrapper make no target-state changes when `BanditsWeekOne` is absent. The
general Bandits container-loot fix remains correctly gated on `Bandits2` alone.

## Bandits player hit reactions

The installed Bandits 42.20 damage model applies firearm, melee, and bare-hand
damage to players without consistently entering a player hit-reaction state.
The compatibility boundary now preserves the original damage call, then sends
a targeted server confirmation to the damaged player's client. Single-player
uses the same presentation behavior locally. No additional `Hit` call is made,
so the patch does not duplicate health loss, wounds, holes, or embedded bullets.

The server-controlled `CWModpackCompatibility` sandbox page provides a master
toggle, cooldown from 0 to 3000 milliseconds, and separate 0–100 percent
firearm and melee/bare-hand reaction chances. Defaults are enabled, 750 ms,
100 percent firearm, and 100 percent melee. Reactions skip dead, floored,
vehicle-seated, and non-local player representations. A cooldown prevents
rapid attacks from repeatedly restarting the reaction animation.
