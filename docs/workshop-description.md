[h1]Chaosworld B42 Modpack Compatibility[/h1]

Targeted, conditional compatibility fixes maintained for the Chaosworld Project Zomboid 42.20 modpack. Install the original mods for the features you use; this item does not replace them. Each runtime patch stays dormant when its supported mod is absent.

[h2]Important load order[/h2]

Place [b]CW Modpack Compatibility after the mods it patches[/b], near the end of the Mods list.

Required Lifestyle order:
[olist]
[*]LifestyleHobbies
[*]LifestyleHobbiesFix — optional; include it only when installed
[*]CWModpackCompatibility
[/olist]

Bandits2, BanditsWeekOne, DynamicTradingCommon, DynamicTradingV2, ETO_B, and other supported mods must also appear before CWModpackCompatibility.

For multiplayer, clients and the server should use the same mod list, order, and CW version. Fully restart the client and server after changing the order.

[hr][/hr]

[h2]Current compatibility features[/h2]

[list]
[*][b]Lifestyle: Hobbies:[/b] Optional hidden-skill view for Yoga, Inventing, Ping Pong, Pool, and Arcade; Beyond Ten progress bridging; focused recovery and diagnostic controls; automatic feature ownership; and a 400-file animation mirror restored to prevent missing-animation regressions. When the corresponding owner mods are active, Nature's Call handles bathroom needs and Brush Your Damn Teeth handles dental hygiene by default. Lifestyle continues to own its other hygiene, grooming, cleaning, hobby, yoga, and animation features.
[*][b]Nature's Call:[/b] Owns bladder and bowel needs when used with Lifestyle by default. Also prevents a fresh character's startup clock transition from being mistaken for hours of needs progression, retains multiplayer clothing-wash recovery, and leaves legitimate Nature's Call needs untouched.
[*][b]Brush Your Damn Teeth:[/b] Owns dental hygiene when used with Lifestyle by default. Lifestyle's duplicate brushing actions are suppressed without removing its other mirror, cabinet, grooming, or hygiene actions.
[*][b]CleanUI + Equipment UI:[/b] Guards transient missing inventory context menus during UI initialization and teardown, preventing the repeated tooltip exception and console flood.
[*][b]Every Texture Optimized — Well Balanced:[/b] Supplies a narrowly scoped vanilla-safe rain texture after ETO_B to prevent a null weather-particle texture from crashing an existing save during world loading.
[*][b]Bandits NPC:[/b] Safe companion container-loot targeting and configurable client hit reactions after confirmed firearm or melee damage.
[*][b]Week One NPC:[/b] Guarded multiplayer variant, population-removal, inhabitant-spawn, and pre-player chat boundaries. These hooks activate only when BanditsWeekOne is installed.
[*][b]Dynamic Trading:[/b] NPC attachment guards, pre-network player-anchor guards, obsolete wardrobe ID repair, and contacts UI compatibility.
[*][b]Timed actions and washing:[/b] Safe Gael Gun Store weapon-part completion, Take A Bath And Shower menu compatibility, and generic alternate-form item recovery.
[*][b]UI and data:[/b] Fast Forward plus Exact Minute Clock positioning, Quartermaster runtime categories, moved Build 42 UI modules, DAMN/KI5 semi-attachment compatibility, and malformed English and sandbox text repairs.
[/list]

[h2]Configuration[/h2]

[list]
[*]Bandits hit reactions can be enabled and tuned in Sandbox Options.
[*]Lifestyle ownership defaults require no setup and can be overridden independently under Chaosworld Compatibility - Lifestyle Ownership in Sandbox Options. Restart after changing them. Removing an owner mod automatically returns that feature to Lifestyle; CW also restores Lifestyle's default bladder multiplier if an older preset left it at zero, unless that fallback is disabled.
[*]The Lifestyle compatibility skill view can be toggled in Mod Options.
[/list]

CW 1.1.13 performs a narrow cleanup of obsolete Lifestyle bladder state when Nature's Call ownership is enabled. Back up important saves before changing mod lists.

[h2]Verification[/h2]

[list]
[*]All compatibility regression suites pass.
[*]The Lifestyle animation mirror matches the installed compatible upstream files by filename, size, and SHA-256.
[*]The affected local save was runtime-tested successfully with ETO_B enabled and the CW weather-texture override active.
[*]The Nature's Call and CleanUI/Equipment UI fixes behaved correctly during runtime testing.
[/list]

[h2]Credits and upstream ownership[/h2]

All original mods and assets remain the work of their respective authors. This compatibility mod is not an official release from those authors.

[list]
[*]Lifestyle: Hobbies by Angry. CW carries a compatibility animation mirror from the verified upstream version while leaving the current yoga implementation and mappings under Lifestyle's ownership.
[*]Every Texture Optimized by maceleet. CW overrides only the incompatible rain texture with its vanilla Project Zomboid counterpart.
[*]Bandits NPC and Week One NPC by Slayer.
[*]Dynamic Trading (w/ NPC) and Dynamic Trading Common Library by Psychopatz.
[*]GaelGunStore-Firearms by Pen-Pen Pirulin.
[*]Nature's Call by RedChili.
[*]Brush Your Damn Teeth by Cam3.
[*]Take A Bath And Shower (SP/MP) by si-cafe.
[*]Fast Forward (MP) by Maumau.
[*]EXACT MINUTE CLOCK (B42) by PorrisV99.
[*]Quartermaster - Auto-Sort & Store Loot by deckard.
[*]Beyond Ten - Level 15 Skills by Patryk, published on Workshop by Silver (Brek).
[/list]

If an original mod author asks for support for their mod or redistributed material to be removed, it will be removed.

[i]WIP: created and maintained with Codex for a private friend-group modpack. Current compatibility release: 1.1.13.[/i]
