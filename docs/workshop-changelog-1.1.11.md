# Chaosworld B42 Modpack Compatibility 1.1.11

Released: September 19, 2026

## Important load-order reminder

Place `CWModpackCompatibility` after the mods it patches, near the end of the
Mods list.

The Lifestyle compatibility skill view uses this order:

1. `LifestyleHobbies`
2. `LifestyleHobbiesFix` — optional; include it here only when installed
3. `CWModpackCompatibility`

Keep `Bandits2`, `BanditsWeekOne`, `DynamicTradingCommon`, `DynamicTradingV2`,
and other supported mods before CW. Multiplayer clients and the server should use
the same mod list, order, and CW version. Fully restart after changing the order.

## Changes in 1.1.11

- Reviewed the September 19 Workshop updates against the compatibility pack.
- Removed 400 copied Lifestyle FBX files, seven stale animation-set XML files,
  and the retired CW yoga wrapper. Lifestyle 0.4.0.3 now owns the corrected
  animation paths and current yoga action implementation.
- Kept CW's Lifestyle hidden-skill view, the Yoga/Inventing/Ping Pong/Pool/Arcade
  mirror perks, and the Beyond Ten progress bridge.
- Updated the Lifestyle regression harness for the current Ambitions, clothing,
  networking, and yoga-action initialization paths.
- Rechecked the current Bandits update. The safe companion container-loot target
  repair remains necessary, and firearm/melee player-hit reactions remain
  compatible with the updated paths.
- Kept Week One compatibility hooks conditional on `BanditsWeekOne`; they remain
  dormant when Week One is not installed.
- Hardened Workshop staging so publishing removes retired destination-only files
  and fails verification if the staged payload contains extras.
- Synchronized the runtime constant and `mod.info` version to 1.1.11.

## Local modpack maintenance — not shipped in this Workshop item

- Removed the `CWBanditsPerfTest` developer tracer from the normal local preset.
- Corrected Lua-style comments in the installed Project A-Life
  `sandbox-options.txt` so Project Zomboid's parser can read the local copy.
  This is a local Workshop-cache repair and Steam may overwrite it; it is not a
  feature of CW 1.1.11.

## Verification

- All five static regression suites pass: Bandits loot, Bandits hit reactions,
  Week One boundaries, tracker fixes, and server-log fixes.
- CW and the locally repaired Project A-Life sandbox-options files pass the
  installed game's exact `CustomSandboxOptions` parser.
- Local Workshop staging is an exact 33-file source/hash match with no extra
  retired assets.
- Runtime gameplay, UI, and two-client multiplayer checks are still required.

CW 1.1.11 does not add a save migration. Back up saves before changing any mod
list and restart the client/server before testing.
