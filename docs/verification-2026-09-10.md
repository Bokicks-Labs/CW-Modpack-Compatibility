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
- Lua runtime execution was not available in this checkout (`lupa` is absent),
  so Java bridge behavior and event ordering remain runtime validation items.
- Run the M2 and M7 two-client protocol in
  `docs/incidents/week-one-mp-2026-09-10/TEST-MATRIX.md`, preserving server and
  client logs. Confirm one inhabitant request produces one server spawn and that
  a removed Bandit does not reappear on either client.
