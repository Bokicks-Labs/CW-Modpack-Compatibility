# Workshop update compatibility review — September 19, 2026

## Lifestyle 0.4.0.3

Lifestyle now supplies the animation-path repair previously carried by CW.
The 400 copied FBX files were byte-identical to the installed upstream files,
while CW's seven copied animation-set XML files contained older animation-name
mappings. CW 1.1.11 removes both copied sets and the yoga diagnostic wrapper.
The staging publisher now removes destination-only files and rejects extra staged
files so retired assets cannot survive a source-to-staging publication.

The hidden-skill view remains owned by CW. Lifestyle still defines six native
perks; CW's combined `media/perks.txt` preserves those definitions and adds the
five visible hidden-skill mirrors. Project Zomboid reads each active mod's perks
file directly; the local preset keeps CW after `LifestyleHobbies` and
`LifestyleHobbiesFix` so CW's duplicate native definitions resolve last.

The translation loader likewise reads each active mod directory directly and
merges keys. CW's small `IG_UI.json`, `Sandbox.json`, and `UI.json` additions do
not replace Lifestyle's larger translation maps when CW loads later.

Lifestyle's minute callback now initializes missing Ambitions and wardrobe data.
The regression harness supplies valid tables so it can continue isolating moodle
decay and diagnostic failure propagation without invoking unrelated managers.

## Bandits update

Bandits disabled its general resupply branch, but the installed companion
program still calls `BanditPrograms.Container.Loot`, whose upstream target
distance uses an undefined `enemyCharacter`. The CW replacement remains active.
The player-damage command boundary also remains compatible with the updated
melee paths.

Week One compatibility hooks remain gated and dormant when `BanditsWeekOne` is
absent. The separate `CWBanditsPerfTest` lifecycle tracer is not a normal-profile
dependency and was removed from the active local preset.

## Other active updates

No direct CW-owned file or function overlap was found for Hide Anywhere, Stow In
Hands, Brush Your Damn Teeth, BoteBR, CovoBR, or FrotaBRRVAddon.

The installed Project A-Life sandbox-options file contained Lua `--` comments.
Project Zomboid's ScriptParser strips `/* ... */` comments only, producing
`unknown block type "the"`. The local Workshop cache was corrected to use a block
comment. Steam can overwrite that local repair on a future update.

`Scripts/VerifySandboxOptions.java` can run an individual file through the exact
`CustomSandboxOptions` implementation in the installed game jar when launched
with Project Zomboid's bundled Java runtime.

## Static verification

- All five regression scripts pass against the currently installed Workshop and
  game source: Bandits loot, Bandits player reactions, Week One boundaries,
  tracker fixes, and server-log fixes.
- The server-log suite verifies Lifestyle's current `Args` constructor roundtrip
  and that the retired CW wrapper and animation directories are absent.
- Both CW and the repaired Project A-Life `sandbox-options.txt` parse with the
  exact `CustomSandboxOptions` implementation from the installed game jar.
- Local Workshop staging is an exact 33-file source/hash match with no extras.
- `git diff --check` passes. Runtime gameplay and UI checks remain outstanding.

## Required runtime checks

1. Start from a fully closed client and verify there is no
   `CustomSandboxOptions` unknown-block error.
2. In the Skills panel, enable the CW Lifestyle compatibility view and verify the
   Yoga, Inventing, Ping Pong, Pool, and Arcade mirror rows appear.
3. Exercise yoga once and confirm it starts, shows the upstream behavior, awards
   experience, and produces no `LSYogaAction` or missing-animation exception.
4. Exercise a Bandits companion container-loot action and both firearm and melee
   player-hit reactions. Static tests cannot prove NPC or multiplayer behavior.
