# Server evidence request: Bandits player hit reactions

## Scope

Compatibility version 1.1.10 adds server-targeted player hit reactions for
confirmed `Bandits2` damage. It does not change damage, accuracy, wounds, NPC
attack timing, or Bandits' existing shove behavior. The patch stays disabled
when `Bandits2` is absent.

The user owns Workshop deployment, sandbox configuration, save backup, server
restart, and test execution. The server thread must only collect read-only
evidence after the user confirms deployment and testing are complete.

## Settings to record

From the active server sandbox configuration, report:

- `CWModpackCompatibility.BanditPlayerHitReactions` (default `true`);
- `CWModpackCompatibility.BanditPlayerHitReactionCooldownMs` (default `750`);
- `CWModpackCompatibility.BanditPlayerFirearmReactionChance` (default `100`);
- `CWModpackCompatibility.BanditPlayerMeleeReactionChance` (default `100`).

Do not change these settings. If they are absent from an upgraded existing
profile, report their resolved runtime values rather than guessing.

## Evidence to collect

1. Confirm installed `CWModpackCompatibility` reports `modversion=1.1.10` and
   `Bandits2` is active.
2. Confirm startup contains one server line:
   `Installed player hit-reaction boundary.`
3. Preserve the server-ready through disconnect interval and group all Lua or
   Java failures by signature and first relevant frame.
4. Record the user's observed result separately for a confirmed damaging hit
   from:
   - a Bandit firearm;
   - a Bandit melee weapon;
   - Bandit bare hands, if naturally available;
   - an existing Bandit shove.
5. For each tested hit type, distinguish visible flinch/reaction, knockdown,
   health/wound change, and whether the player was standing, moving, floored,
   or in a vehicle.
6. Test a short rapid sequence and report whether the configured cooldown
   prevents continuous reaction locking while still providing readable hit
   feedback.
7. If practical, temporarily test the user-managed master toggle off after a
   restart and confirm damage remains while the added reactions stop. The
   server thread must not change the setting itself.

## Return format

Create `SERVER-RESULT-BANDIT-PLAYER-HIT-REACTION.md` beside this request with
bounded timestamps, settings, grouped errors, and separate PASS/FAIL/
INCONCLUSIVE conclusions for firearm reaction, melee reaction, cooldown
fairness, toggle-off behavior, and unchanged damage behavior. Do not commit
full logs, usernames, Steam IDs, IP addresses, or other identity-bearing data.
