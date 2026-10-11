# Chaosworld major gameplay systems: player guide and bug checklist

Last reviewed: **2026-10-11**. Scope: the release-only IDs in [active-server-mods-2026-10-11.csv](active-server-mods-2026-10-11.csv), cross-checked against [active-mod-index.tsv](active-mod-index.tsv) and official Steam Workshop listings. This is a **feature handbook**, not a claim that every system has been runtime-tested on the current dedicated server.

**Deliberately excluded:** Project Viewpoint and its visual/compatibility submods, individual vehicles, cosmetics, passive libraries, simple item packs, and other self-explanatory content. The CSV still tracks all those mods for syncing. If a mod is not in the CSV, this guide does not declare it active.

**How to read:** "Use" is a documented action, "Watch" is a reproducible test to try, **not** an assertion of an observed Chaosworld bug. Keybinds are defaults reported by the creator; personal mappings or another mod may override them.

## Start here: systems most likely to surprise you

| System | Actual major mechanic | Quick entry point | Official source |
| --- | --- | --- | --- |
| Casualties Undead | Physiology, 21 conditions, treatment minigames, prosthetics, resuscitation | Health panel; right-click/Esc exits a procedure | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3805748433) |
| Project A-Life | Persistent faction squads, territory, raids, radios and creator | NPC/faction creator; 100+ sandbox settings | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3803984183) |
| Companion Dogs and Cats | Commands, loyalty, needs, skills, hunting, combat, breeding | Paw sidebar; **hold Q** radial; Paw window > Settings for hotkeys | [Features wiki](https://companiondogs.pet/docs/en/features.html) / [Breeds wiki](https://companiondogs.pet/docs/en/breeds.html) |
| Lifestyle: Hobbies | Music, disco, art, grooming, yoga, hygiene and homestead | World interactions; its sandbox and mod options | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3403870858) / [WIP wiki](https://lifestylemodwiki.miraheze.org/) |
| Nature's Call | Gut health, digestion, bladder/bowel, soiling, smell | Health panel's added tab; toilet/body/clothing interactions | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3709126801) |
| HydeCo. Knox Underground | Sewers, caves, excavation, ores, mining, underground survival | **K** mining mode; crowbar for manholes | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3811471690) |
| HydeCo. Bees! | Beekeeping, hive management, breeding queens, mead and wax | Grand Hive panel; smokers | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3430224478) |
| LG Extended Electricity + Power Usage | Whole-building circuits, relay networks, breakers, realistic power draw | Generator context menu > Wire up the building | [Detailed how-to](https://steamcommunity.com/workshop/filedetails/discussion/3779562002/500617547938355736/) |
| LG Extended Plumbing | Water supply by building, floors and pipe runs | Pipe wrench > Plumb into house supply | [Detailed how-to](https://steamcommunity.com/workshop/filedetails/discussion/3779561845/500617547938355504/) |
| BADLANDS Power | Battery bank and four other types of generators | Generator and crafting interactions | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3804093735) |
| Project RV Interior + Insecure | Real vehicle room, cabin climate, outdoor threat reflected inside | Vehicle radial, interior exit, sandbox siege mode | [RV base](https://steamcommunity.com/sharedfiles/filedetails/?id=3543229299) / [Insecure](https://steamcommunity.com/sharedfiles/filedetails/?id=3797698408) |
| Senator's Martial Arts | Four styles, shared XP + style mastery, combos, grappling | **K** Martial Arts window; empty hands | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3812456765) |
| RadArchery | Bows, quivers, arrow recovery, Archery + Fletching | In-game Archery Handbook | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3775407541) |
| Maskarad's Summer Car | Detailed vehicle engines, transmissions, fluids, lift maintenance | Vehicle mechanics/engine panels, car lift | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3790160840) |
| Artel Manufactory | Large production suite: food processing, brewing, crafting, chemistry, commerce | In-game crafting/machine recipes | [Workshop link from active CSV](https://steamcommunity.com/sharedfiles/filedetails/?id=3794133594) |

## Casualties Undead (CasualtiesUndead)

**What it really adds:** interactive mouse-driven procedures for bandages, stitches, glass extraction, splinting, injections, cauterization and amputation; blood, oxygen, blood pressure, heart rhythm and six organs; **21 independent medical problems** (including sepsis, collapsed lung and internal bleeding). Procedures are not generic wait bars: mistakes can worsen injury. **Right-click or Esc** cancels a procedure.

**Unusual progression:** arm/leg amputation, makeshift or hospital prosthetics, craftable prosthetics at Metalworking 6 / First Aid 2, Prosthetics skill to restore mobility. Cardiac arrest can be followed by resuscitation with a defibrillator. Gameplay effects vary with medical state, not just the vanilla wound icon. Roughly 40 sandbox controls; the author says multiplayer works imperfectly and is still buggy. **The Only Cure is explicitly incompatible**, but that mod is not on this active CSV. The optional "Censor Miserable episodes" setting is in Options > Mods.

**Watch:** compare client/server wound state, ongoing organ/blood values after rejoining, procedure results, splint application, prosthetic equip/movement, and defibrillator revive. A missing item script or splint crash reported in Workshop comments is a **community report**, not yet reproduced in Chaosworld. Report with both logs.

Source: [official Workshop mechanics and bug reports](https://steamcommunity.com/sharedfiles/filedetails/?id=3805748433).

## Project A-Life (ProjectALifeNPCs)

**What it really adds:** persistent factions and squads operating off-screen; faction relationships, radio calls, roadblocks, snipers, robberies, building clearance, medics, bleeding NPCs, raids and tiered outposts. The creator describes **148 preset factions** in version 1.3.17 (September 30): less than half hostile. You may be robbed instead of shot; NPCs that flee can remember prior fights. Disabling an outpost radio changes its dispatch behavior. Admins have a squad map overlay.

**Create your own:** creator edits appearance, outfits, weapons, attachments, behaviors, relationships and encounter inclusion. **COPY CODE / LOAD CODE** exports or imports a faction definition. Over 100 sandbox options; start with population, encounter and raid rate. The creator explicitly says **recruitable followers are not implemented yet**; treat announced updates as roadmap, not active features. It warns against running two full NPC frameworks on one save.

**Watch:** NPC visibility/ownership, NPC combat against zombies/players, line of sight through walls, faction persistence after cell unload/reload, excessive encounter density and raid balance. With Casualties Undead, separately test what happens to the medical state after an NPC hit. Be aware that Workshop commenters may report issues without proving they are universal.

Source: [official Workshop details and creator description](https://steamcommunity.com/sharedfiles/filedetails/?id=3803984183).

## Companion Dogs and Cats (CompanionDogs + installed breed add-ons)

**Use:** Paw icon on the sidebar, **hold Q** for the companion radial, or right-click the animal. **Paw window > Settings** assigns up to **14 unbound-by-default hotkeys**. The Commands tab manages Follow/Stay/Guard, Alert/Quiet/Silent, attack, hunting, protection, tricks and saddlebags. Commands also work from right-click and radial menus, but Guard is not exposed in the dog's simple right-click submenu.

Progression involves Obedience, Hunting, Combat, Scent and Herding, plus loyalty, feeding, disease/health where implemented, breeding and puppies. More than one owned animal is possible, but **only one active following dog at a time** is documented in the current base mod. The mod has separate **client/host initialization** requirements: enable in main-menu Mods and in the server settings; fully restart if models are crumpled/untextured. Animals left behind may be stashed during an owner's offline period based on sandbox settings.

**Watch:** dog command mode after disconnect, duplicated pets, models/textures for every installed breed, attack/alert noise, animal inventory persistence, and compatibility with PZ Pulse: Companion Dogs panel. **Do not remove a breed from a save with living animals of that breed.** The official wiki has far more specific instructions than a short summary.

Official references: [Complete features, commands, options and multiplayer wiki](https://companiondogs.pet/docs/en/features.html); [breeds, bonuses, behaviors](https://companiondogs.pet/docs/en/breeds.html).

## Lifestyle: Hobbies + Nature's Call + Brush Your Damn Teeth

**Lifestyle** encompasses music and instruments, bands, singing, dancing/disco, homestead activities, art/hobbies, yoga/meditation, mirrors and grooming, baths/showers and dental/hygiene features. The author explicitly links a **work-in-progress wiki**; features may differ by release.

**Nature's Call** simulates digestive health across meals, cramps, dietary consequences, bladder/bowel pressure, control/accidents, clothing and body grime, smell that can attract zombies, and a health-panel tab with intake/control/status. It allows toilet, bush/tree, container and open-ground interactions; bathroom hygiene items matter.

**Critical CW customization:** [Lifestyle feature ownership](lifestyle-feature-ownership.md) documents the authoritative overlap rules:
- Nature's Call normally owns bladder/bowel. Lifestyle's competing need/actions are suppressed.
- Brush Your Damn Teeth normally owns toothbrushing and dental consequences.
- CW's **Disable Lifestyle personal hygiene need** is **on by default**, keeping Lifestyle hygiene neutral while preserving actual cleaning actions. Nature's Call grime, Take a Bath and Shower and dental care are not disabled.
- Change under **Sandbox Options > Chaosworld Compatibility - Lifestyle Ownership**, then restart.

**Watch:** exactly one bladder/dental state, no double bathroom actions, showers and animations after reconnect, saved skill/hobby progress, no extra Lifestyle hygiene penalty when ownership says disabled. Verify client and server have the same CW mod and ownership options. Nature's Call Workshop discussions include reports of progress during offline time; treat as a test scenario rather than confirmed here.

References: [Lifestyle Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=3403870858), [Lifestyle WIP wiki](https://lifestylemodwiki.miraheze.org/), [Nature's Call Steam](https://steamcommunity.com/sharedfiles/filedetails/?id=3709126801), [CW ownership documentation](lifestyle-feature-ownership.md).

## HydeCo. Knox Underground (HydeCoUnderGround)

**Use:** Pry town sewer manholes open with a crowbar; follow the ladder down into catwalks and lower channels. Remote dry wells lead to caves and require rope/sheet rope. The mod also has old mines, geological layers down to **z=-30**, ore seams, a Mining skill, profession and mining-focused traits. **K** toggles mining mode; aim/swing a pickaxe to break stone, shovel for dirt, sledgehammer for some structures; **Shift+Ctrl** digs stairs. Grappling hooks can be used to traverse height with prerequisites.

**Watch:** client/server synchronization of newly excavated tiles, ladder transitions, player location after save/restart, mining skill XP, cave atmosphere/light handling, groundwater and permanent map changes. Do not presume all planned caves or future map expansions are already shipped.

Source: [Workshop controls and world layout](https://steamcommunity.com/sharedfiles/filedetails/?id=3811471690).

## HydeCo. Bees! (HydeCoBees)

**Use:** forage for hives/queens, acquire the Beekeeping Magazine, construct a Cultivated Beehive, and manage it cell-by-cell from **Grand Hive**. A queen starts production; use sugar water and nearby flowers to improve the colony. A **lit, fueled Bee Smoker** reduces sting risk, but smoking pauses hive work. The beehive panel responds to season/weather and displays colony needs.

**Other substantial systems:** mead batches using honey/water/yeast (35 bottles; fruit variants), young/classic/aged/spoiled timing, natural yeast culture, beeswax crafts, wound-care items, wax coating food, queen rearing, a Beekeeper profession and multiple sandbox options.

**Watch:** queen/larva and jar consumption across reload, weather/season adjustments, correct bee swarm and protection handling, mead batch timing, colony state on dedicated server. The Workshop itself reports future features (e.g. certain beekeeping clothing); do not count those as installed.

Source: [Workshop mechanics and crafting guide](https://steamcommunity.com/sharedfiles/filedetails/?id=3430224478).

## Power, water and base infrastructure

### LG Extended Electricity + LG Realistic Power Usage
The **same Workshop item (3779562002) contains two distinct Mod IDs**. The main mod wires an entire building, provides relay runs, circuit breakers, generator load sharing and fuel lines. Realistic Power Usage alters appliance draw. Right-click a connected but **switched-off** generator and choose **Wire up the building**, then start it. **Show powered area** visualizes actual/potential coverage. A relay run needs endpoints wired to generator and building; intermediate blue relays are normal. **BREAKER TRIPPED** means overload, not necessarily loss of connectivity. Modded machines including BADLANDS are documented as supported.

**Watch:** whole-base power across multiple floors, watt limits, charge/fuel under long absence, wiring after move, breaker resets, and distinction between the two installed Mod IDs.

Official in-depth documentation: [How To Use](https://steamcommunity.com/workshop/filedetails/discussion/3779562002/500617547938355736/); [FAQ and fixes](https://steamcommunity.com/workshop/filedetails/discussion/3779562002/500617547938355764/).

### LG Extended Plumbing (LGExtendedPlumbing)
Use a **pipe wrench** to **Plumb into house supply** on each source barrel first, then plumb fixtures. Water flows **downhill for free**; a powered barrel's square can push water to higher floors. Pipes link outbuildings and outdoor fixtures. The main guide covers placement, reserve barrels, pressure and inspection UI. It requires Nick's Inventory Selection Fix, which appears in the CSV.

**Watch:** supply reaching sinks on different floors, whether a barrel was actually plumbed, generator-assisted upward water, liquid contamination, area display and interactions with **Waterpipes** (also active, separate logic). An empty/unplumbed fixture is not automatically a mod bug.

Official docs: [How To Use](https://steamcommunity.com/workshop/filedetails/discussion/3779561845/500617547938355504/); [FAQ and failure states](https://steamcommunity.com/workshop/filedetails/discussion/3779561845/500617547938355568/).

### BADLANDS Power (BadlandsPower)
Five functional generator alternatives: silent indoor **Battery Bank**, propane generator, waste-oil generator, worn scrap generator and industrial generator. Battery Bank requires up to five car batteries and can recharge while turned off if powered by another source. Propane and oil machines use *their own* fuels; fuel lines do not imply support for every fluid. The author explicitly documents **LG Extended Electricity** compatibility.

**Watch:** accepted fuel, battery charges/discharges across sessions, indoor safety, LG circuits and load balance. Optional BADLANDS controllers/steam-machine add-ons are **not** assumed installed just because linked by the Workshop.

Source: [Workshop machine specifications](https://steamcommunity.com/sharedfiles/filedetails/?id=3804093735).

### Genset (Genset)
Towable generator trailer; hitch/park/unhitch, then use generator context or **V** radial. Its own trailer gas tank is the generator fuel tank. Hitching while running stops the generator. It obeys vanilla generator range and wears/repairs like one.

**Watch:** trailer fuel/condition persistence, moving or hitching a running generator, and wiring and power alongside LG systems.

Source: [Workshop setup details](https://steamcommunity.com/sharedfiles/filedetails/?id=3803022693).

## Project RV Interior, Cabin Climate Fix and RV Interior Insecure

The base mod provides separate walkable mobile rooms. The installed Cabin Climate Fix ties temperature control to actual powered RV heater/AC parts and prevents misleading exterior rain indoors. **Insecure's current Workshop says its default is Mirror mode**, where the interior threat reflects reachable zombies near the *parked exterior vehicle*, not a free safe dimension. Tolerant/Standard/Relentless are *alternative* timer modes, not necessarily the current default. Noise from inside can propagate to the parked position; walls/fences and where you park change the threat.

**Watch:** indoor/outdoor RV position, entering/exiting, actual versus mirror zombie numbers, cabin power, heating/cooling after engine stops, inventory/world chunks on save/reload and ownership of interior slots. For preserving a customized bus room see [RV Interior Manager script guide](rv-interior-manager.md).

References: [RV Interior](https://steamcommunity.com/sharedfiles/filedetails/?id=3543229299), [RV Insecure](https://steamcommunity.com/sharedfiles/filedetails/?id=3797698408), [Cabin Climate Fix](https://steamcommunity.com/sharedfiles/filedetails/?id=3781225795).

## Senator's Martial Arts (SenatorMartialArtsCore)

**Use:** learn styles from magazines or traits, practise via Fitness menu, fight **empty-handed**, earn shared Martial Arts levels 0-10 and per-style mastery 0-5. Styles: Boxing, Muay Thai, Karate and MMA; there are attacks, heavier finishers, dodges and an MMA takedown.

**Creator-documented defaults:** **K** open Martial Arts window; **Backslash** cycle learned styles; aim + **R** equipped heavy; **Z** dodge; **Shift+R** Karate flying side kick at mastery 4; **Space** cancel MMA takedown/ground pound. A held weapon or offhand item suspends the style.

**Watch:** **K conflicts with HydeCo Underground's mining-mode K**. Rebind one in Options before testing. Look for unarmed hit/XP not registering, heavy attack handling in MP and stamina/animation glitches.

Source: [Workshop complete controls and multiplayer notes](https://steamcommunity.com/sharedfiles/filedetails/?id=3812456765).

## RadArchery (RadArchery)

**Use:** bows/arrows/quiver, two progression skills (Archery and Fletching), target-practice building, craft/repair tiers and recovering arrows from targets/enemies. It ships an **in-game Archery Handbook** (right-click a RadArchery item or assign a handbook key under Options > RadArchery). Recent revisions expose a dedicated arrow-repair window.

**Watch:** arrow recovery and ammo state in multiplayer, bow drawing/nocking after reload presses, quiver inventory, and aiming with other combat/stance mods. The Workshop specifically discusses **R/RB overlap with reload mods**, so test against your active tactical reload and gun mods. The author says a future 2.0 will be a **separate** Workshop mod; do not switch IDs preemptively.

Source: [Workshop handbook and gameplay notes](https://steamcommunity.com/sharedfiles/filedetails/?id=3775407541).

## Maskarad's Summer Car (MaskaradsSummerCar)

This changes ordinary cars into maintainable assemblies: removable engines, internal parts, fluids and transmissions, with car-lift service and separate engine diagnostics. The Workshop notes **Better Car Physics** as optional, not a requirement. It lists **Specific Loot (KI5)** and **Functional Car Lift** as reported incompatibilities; treat the reports as compatibility targets, not proof every configuration fails.

**Watch:** vehicle mechanics panels and engine details in cars generated after enabling, parts/fluid persistence, other mechanical overhauls, and multiplayer part synchronization. **Specific Loot (KI5) is in the CSV**, making that pairing worth a controlled test.

Source: [Workshop description and caveats](https://steamcommunity.com/sharedfiles/filedetails/?id=3790160840).

## Artel Manufactory (ArtelManufactory)

The active mod index describes a very broad set of machinery and production features: brewing, canning and rations, beekeeping/dairy, drying, freeze-drying, farming, electric machines, chemical/steam equipment, reputation and trading. Some features may be tied to individual sandbox pack toggles. **Important verification limit:** its Steam page was not retrievable during this audit, so the index is the source of these feature claims. Do not treat roadmap-like descriptions as guaranteed existing recipes.

**Use:** inspect Artel entries in Sandbox Options and in-game recipe/workstation menus; identify which machine chains are active. **Watch:** duplicate beekeeping/food preservation paths alongside HydeCo Bees and Long Term Preservation; workstation power versus LG systems; trading persistence. No authoritative external wiki link was verified.

Reference: [Workshop item from actual active CSV](https://steamcommunity.com/sharedfiles/filedetails/?id=3794133594).

## First-pass test order (short, repeatable)

1. **Safe-house baseline:** confirm CW overlap settings, Nature's Call health tab, hygiene actions, Lifestyle music/hobby interactions, and client/server agreement.
2. **Medical:** cause a *controlled, nonfatal* injury; test bandaging and an additional simple procedure; verify state after relog before trying more complex interventions.
3. **NPCs:** observe one A-Life encounter, faction behavior and radio; note whether hits cause disproportionate medical problems. Compare in an empty area.
4. **Animals:** enable a companion breed, assign a hotkey in Paw Settings, test Stay/Follow and reconnect persistence.
5. **Base networks:** wire a building, enable a realistic-power appliance, plumb a barrel and measure behavior across floors; confirm breaker, barrel state and no unintended Waterpipes overlaps.
6. **Progression:** test K's double binding before either mining or Martial Arts; test arrow reload/nocking alongside Hot Brass.
7. **Advanced worlds:** test cave entry/exit and RV interior entry/exit in a disposable save or world backup before touching a long-lived base.

## Release-ID-only CSV policy

The CSV is the **Workshop-backed mod membership reference** for matching a client to the server. It must list the actual release mod ID from each Workshop payload and the numeric Workshop item URL; multiple mod IDs can legitimately share a single Workshop item. **Never insert** IDs ending in `_dev` or `_Dev` from local junctions. The newer CSV may differ from the older October 9 loaded-log index; never automatically copy older, dev-only or unchecked entries into this server list. Use your server's current `Mods=` and `WorkshopItems=` lines as final ground truth for membership and load order; a snapshot CSV alone cannot prove the running server's configuration.

**Known excluded mod:** "Yeah, It's Water, Bitch" is intentionally disabled because it is not working correctly, and has no row in the release-only CSV.

See [complete, older session player guide](active-mods-player-guide.md) for brief notes on remaining mods; ignore its Viewpoint sections for this focused handbook.
