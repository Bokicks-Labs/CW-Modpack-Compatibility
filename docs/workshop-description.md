<!-- Steam Workshop BBCode. Keep the description fields in workshop.txt synchronized; use plain text for Steam changelog entries. -->

[h1]Chaosworld B42 Modpack Compatibility[/h1]

Targeted compatibility fixes for a heavily modded Project Zomboid Build 42 multiplayer world. [b]The core supports Build 42.20+; the optional Viewpoint patch requires 42.21+.[/b] Install each original mod you use; CW does not replace upstream mods. Runtime hooks are conditional on their target mods.

[h2]Load order and multiplayer[/h2]
Place [b]CWModpackCompatibility after the mods it patches[/b], near the end of the Mods list.

For Lifestyle:
[olist]
[*]LifestyleHobbies
[*]LifestyleHobbiesFix (only if installed)
[*]CWModpackCompatibility
[/olist]
Bandits2, BanditsWeekOne, DynamicTradingCommon, DynamicTradingV2, ETO_B and other patched mods should also load before the CW core. Enable optional submods separately. CWAudioMixer and CWModOptionsSearch should load after the core; CWViewpointPatch should load after Viewpoint; CWModdedUILayout should load after Casualties Undead.

For multiplayer, keep server/client versions and mod lists aligned and restart after changing order or ownership settings. Back up saves before removing mods.

[h2]Core compatibility fixes[/h2]
[list]
[*][b]Lifestyle: Hobbies:[/b] Hidden-skill view (Yoga, Inventing, Ping Pong, Pool and Arcade), Beyond Ten progress integration, animation-regression mirror, diagnostics and automatic feature ownership. Nature's Call can own bathroom needs, Brush Your Damn Teeth can own dental hygiene, and CW can disable Lifestyle's overlapping personal hygiene meter/moodles by default. Lifestyle cleaning actions, Cleaning skill, other grooming, hobbies and animations remain available.
[*][b]Nature's Call:[/b] Fresh-character clock-jump guard and multiplayer clothing-wash recovery without discarding real need progression.
[*][b]Brush Your Damn Teeth:[/b] Suppress Lifestyle's duplicate brushing actions while keeping its unrelated actions.
[*][b]Moodles in Lua:[/b] Keep the duplicate vanilla Moodle UI off screen even when Build 42 repositions it, while placing supported custom moodles in the visible stack.
[*][b]Moodle Framework:[/b] Keep active Lifestyle and framework moodles in separate rows, including when MoodlePriority is enabled; Casualties Undead moodles are placed below the active stack.
[*][b]CleanUI + Equipment UI:[/b] Guard temporary missing inventory context menus to prevent tooltip exceptions.
[*][b]Every Texture Optimized (ETO_B):[/b] Narrow vanilla-safe rain-texture override for a world-loading crash.
[*][b]Bandits and Week One:[/b] Safe companion-loot targeting, optional player-hit reactions, and guarded Week One multiplayer variant/removal/chat boundaries.
[*][b]Dynamic Trading:[/b] NPC attachment, networking and old wardrobe-ID guards plus contacts UI compatibility.
[*][b]Other fixes:[/b] Gael Gun Store timed-action safety; Take A Bath And Shower menus; item recovery; Fast Forward / Exact Minute Clock layout; Quartermaster categories; moved Build 42 UI modules; DAMN/KI5 attachments and text repairs.
[*][b]Casualties Undead (optional):[/b] Adds top-level Full health shortcuts to the Health panel's body-part menu only while the game's Cheat option is enabled; its custom moodles stack below vanilla, Moodles in Lua and visible Moodle Framework moodles. Normal treatments are unchanged.
[/list]

[h2]Optional submods[/h2]
[list]
[*][b]CW Audio Mixer (0.2.0):[/b] Client-only group and individual sound sliders. Find its group controls under Options > Audio > CW Audio Mixer; Advanced sound mixer handles individual sounds and assignments. Categories include UI, death music, TV, radio, music, ambience, vehicles and combat. Settings are local. The title-screen video audio cannot reliably be controlled by this Lua mixer; vanilla rain is part of a shared ambience event, not an isolated rain slider.
[*][b]CW Mod Options Search (0.1.2):[/b] Client-only search inside Options > Mods for registered mod settings, labels and tooltips. Select a result to jump to an available option; search never edits setting values.
[*][b]CW Viewpoint Patch (0.2.1, experimental):[/b] Client-only Build 42.21+ patch for wider Viewpoint interaction labels and a guarded right-click fallback. Requires [b]Viewpoint and ZombieBuddy[/b]. Enable separately after Viewpoint. Configure label width under Options > Mods > CW Viewpoint Patch and restart. The included Java JAR requires explicit approval via ZombieBuddy. For Project A-Life NPC targeting and menus, install Viewpoint x A-LIFE separately. Test world interactions in a disposable save.
[*][b]CW Modded UI Layout (0.1.0):[/b] Client-only Casualties Undead window spacing for readable text sizes. Adjusts the Health panel Vitals report, debug controls, and treatment-minigame Vitals and case sidebar. Requires [b]Casualties Undead[/b] and should be enabled separately after it. Treatments and debug commands are unchanged.
[/list]

[h2]Project Viewpoint and ZombieBuddy[/h2]
Subscribe to the [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3619862853]official ZombieBuddy Workshop item[/url] and follow its current installation instructions before using Viewpoint. [b]The old CW ZombieBuddy setup launcher and bundled compatibility JAR were removed.[/b] Installing CW never downloads, executes, or repairs ZombieBuddy. On Windows, do not overwrite an already-working native DLL merely for cleanup if its current setup differs from upstream. ZombieBuddy and Viewpoint are third-party projects, not Chaosworld releases.

[h2]Configuration and testing[/h2]
Bandits hit reactions and Lifestyle feature ownership are configured under Sandbox Options. Each Lifestyle ownership rule can be disabled independently; restart for changes. The optional Lifestyle skill view is under Mod Options. Existing saves may contain settings or obsolete Viewpoint add-ons: back up saves and validate any migration separately.

This is a compatibility collection for an actively changing Build 42 modpack. Not every optional feature, load order or multiplayer combination is verified with each update. Back up important saves before changing mod lists, and report reproducible errors with the current game/mod versions and relevant console logs.

[h2]Credits[/h2]
Original mods and assets belong to their creators. This is an unofficial compatibility project. Lifestyle: Hobbies by Angry; Every Texture Optimized by maceleet; Bandits/Week One by Slayer; Dynamic Trading by Psychopatz; GaelGunStore by Pen-Pen Pirulin; Nature's Call by RedChili; Brush Your Damn Teeth by Cam3; Take A Bath And Shower by si-cafe; Fast Forward by Maumau; Exact Minute Clock by PorrisV99; Quartermaster by deckard; Beyond Ten by Patryk (Workshop publication by Silver/Brek); ZombieBuddy by Andrey "Zed" Zaikin. Viewpoint, Project A-Life, Casualties Undead and all other supported third-party projects remain the property of their respective authors.

CW 1.3.0 adds optional Casualties Undead UI layout fixes.

CW maintains a mirrored set of Lifestyle animations for regression prevention. If any original author requests removal of their material or compatibility support, CW will honor that request.

[i]Maintained with Codex for the Chaosworld modpack. Current compatibility release: 1.3.0. Optional modules may have independent versions.[/i]
