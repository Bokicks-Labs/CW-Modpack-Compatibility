# Chaosworld B42 Modpack Compatibility

Targeted, conditional compatibility fixes maintained for the Chaosworld Project
Zomboid 42.20 modpack. Install the original mods for the features you use; this
item does not replace them. Each patch stays dormant when its supported mod is
absent.

## Important load order

Place **CW Modpack Compatibility after the mods it patches**, near the end of
the Mods list.

The Lifestyle compatibility skill view uses this order:

1. `LifestyleHobbies`
2. `LifestyleHobbiesFix` — optional; include it here only when installed
3. `CWModpackCompatibility`

`Bandits2`, `BanditsWeekOne`, `DynamicTradingCommon`, `DynamicTradingV2`, and
other supported mods must also appear before `CWModpackCompatibility`.

For multiplayer, clients and the server should use the same mod list, order, and CW version.
Fully restart the client and server after changing the order.

## Current compatibility features

- **Lifestyle: Hobbies:** optional hidden-skill view for Yoga, Inventing, Ping
  Pong, Pool, and Arcade; Beyond Ten progress bridging; and focused
  recovery/diagnostic controls. CW now relies on Lifestyle's current animation
  and yoga files and no longer redistributes them.
- **Bandits NPC:** safe companion container-loot targeting and configurable
  client hit reactions after confirmed firearm or melee damage.
- **Week One NPC:** guarded multiplayer variant, population-removal,
  inhabitant-spawn, and pre-player chat boundaries. These hooks activate only
  when `BanditsWeekOne` is installed.
- **Dynamic Trading:** NPC attachment guards, pre-network player-anchor guards,
  obsolete wardrobe ID repair, and contacts UI compatibility.
- **Timed actions and washing:** safe Gael Gun Store weapon-part completion,
  Nature's Call multiplayer clothing-wash recovery, Take A Bath And Shower menu
  compatibility, and generic alternate-form item recovery.
- **UI and data:** Fast Forward plus Exact Minute Clock positioning,
  Quartermaster runtime categories, moved Build 42 UI modules, DAMN/KI5
  semi-attachment compatibility, and malformed English/sandbox text repairs.

## Configuration

- Bandits hit reactions can be enabled and tuned in Sandbox Options.
- The Lifestyle compatibility skill view can be toggled in Mod Options.

CW 1.1.11 does not add a save migration, but backing up saves before mod-list
changes is always recommended.

## Credits and upstream ownership

All original mods and assets remain the work of their respective authors. This
compatibility mod is not an official release from those authors.

- Lifestyle: Hobbies by Angry. CW relies on the current upstream animation and
  yoga implementation and supplies only compatibility code and perk
  declarations.
- Bandits NPC and Week One NPC by Slayer.
- Dynamic Trading (w/ NPC) and Dynamic Trading Common Library by Psychopatz.
- GaelGunStore-Firearms by Pen-Pen Pirulin.
- Nature's Call by RedChili.
- Take A Bath And Shower [SP/MP] by si-cafe.
- Fast Forward (MP) by Maumau.
- EXACT MINUTE CLOCK [B42] by PorrisV99.
- Quartermaster - Auto-Sort & Store Loot by deckard.
- Beyond Ten - Level 15 Skills by Patryk, published on Workshop by Silver
  (Brek).

If an original mod author asks for support for their mod or redistributed
material to be removed, it will be removed.

WIP: created and maintained with Codex for a private friend-group modpack.
Current compatibility release: **1.1.11**.
