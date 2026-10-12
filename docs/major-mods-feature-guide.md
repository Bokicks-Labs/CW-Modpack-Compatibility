# Chaosworld major gameplay systems: player guide and bug checklist

Last reviewed: **2026-10-11**. Scope: the release-only IDs in [active-server-mods-2026-10-11.csv](active-server-mods-2026-10-11.csv), cross-checked against [active-mod-index.tsv](active-mod-index.tsv), installed Workshop payloads and official Steam Workshop listings. This is a **feature handbook**, not a claim that every system has been runtime-tested on the current dedicated server.

**Coverage:** major gameplay systems, now including Project Viewpoint and its substantial 3D interaction/combat add-ons. Individual vehicles, cosmetics, passive libraries, simple item packs and other self-explanatory content remain outside the detailed handbook. The CSV continues to track every active entry for synchronization. If a mod is not in the CSV, this guide does not declare it active.

**How to read:** "Use" is a documented action, "Watch" is a reproducible test to try, **not** an assertion of an observed Chaosworld bug. Keybinds are defaults reported by the creator; personal mappings or another mod may override them.

## Start here: systems most likely to surprise you

| System | Actual major mechanic | Quick entry point | Official source |
| --- | --- | --- | --- |
| Project Viewpoint | Full 3D perspective, optics, ballistics, weather and interactions | **O** perspective, **Shift+O** first/third, **Delete** graphics/settings | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3809306528) |
| Casualties Undead | Physiology, 21 conditions, treatment minigames, prosthetics, resuscitation | Health panel; right-click/Esc exits a procedure | [Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3805748433) |
| Project A-Life + Jeem Extension | Persistent faction squads, raids, player-claimed bases, residents and missions | A-Life creator; right-click > **Bases**; faction window | [A-Life](https://steamcommunity.com/sharedfiles/filedetails/?id=3803984183) / [Jeem Extension](https://steamcommunity.com/sharedfiles/filedetails/?id=3806944055) |
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

**Guide coverage note:** the major systems already have entries here, including the linked Casualties Undead guide. This handbook has focused code-derived player workflows for Artel Manufactory; remaining entries are prioritization candidates rather than confirmed missing guides. See the code/source coverage note in Artel's section.

## Project Viewpoint (Viewpoint) and installed gameplay add-ons

Viewpoint changes the camera, rendering, interactions, targeting and visual weather rather than just applying a graphics filter. The **core Steam listing** documents these defaults: **middle mouse** toggles cursor, **O** enables/disables first-person Viewpoint, **Shift+O** switches between first and third person, **Insert+O** enables Free Cam, **Shift+Insert+O** enables Physical Free Cam, and **Delete** opens shader/FOV/mouse/settings. Its bug reports use lines prefixed `[Viewpoint]` in `%USERPROFILE%\Zomboid\console.txt`. Settings include Vanilla, Default and Vivid shader profiles; test one profile at a time when troubleshooting.

**Combat changes:** the installed **Recoil & ADS** handles sights, scopes and weapon-specific aim alignment; **True Ballistics** starts a projectile at the muzzle rather than at the camera and models travel time, drop, body hit locations, solid cover, glass, drag and falloff. **Advanced Throwables** supplies hold-to-charge throws and object collisions. True Ballistics documents debug-console diagnostics `VTB_status()`, `VTB_debug("trajectories", true)`, and `VTB_tracers(1)` (debug mode required). **Full-range dedicated-server ballistics** require the appropriate ZombieBuddy server integration; a client-rendered bullet is not proof that server-side hit validation succeeded. The author specifically warns against combining competing firearm-hit replacements.

**Interactions and world systems:** installed mods include 3D foraging pins, fishing, shovel/grave placement (**Period** while holding a suitable tool), 3D fences (**F8** original/3D toggle), weather/lighting effects, weather-driven gameplay, 3D construction ghost previews, windows, surfaces, barricades, lighting, rendering fixes and Viewpoint QOL. **Viewpoint QOL uses K for the loot-menu toggle**, potentially conflicting with Senator's Martial Arts and HydeCo Underground's K actions. The QOL mod also touches menu and interaction-target hooks.

**Installed vs optional:** the server-sync CSV still includes `ViewpointCar` and `ViewpointMenu` even though the respective patches have been labeled obsolete by their authors. Keep them in the dated membership CSV until you deliberately change the live server preset and confirm save impact; do not assume they remain beneficial. **Viewpoint Turbo** appears in an older loaded-mod inventory but not in the October 11 release-only CSV. CW's own experimental `CWViewpointPatch` is documented separately and is **not** automatically an active mod just because its source exists in this repository.

**Watch:** (1) weapons striking cover from their muzzle versus firing through walls, and server/client hit agreement; (2) NPCs getting shot / losing collision or interaction targetability; (3) disappearance of world right-click menu vs inventory UI context menus; (4) opaque glass/roof surfaces, headlight offset, barricades and stairs; (5) view-dependent FPS and shader side effects; (6) ZombieBuddy Java/native integration after game updates; (7) overlapping keybinds, particularly **K**. Isolate in first-person, third-person and isometric modes in the same scene.

References: [Viewpoint core workshop and controls](https://steamcommunity.com/sharedfiles/filedetails/?id=3809306528), [True Ballistics mechanics and server setup](https://steamcommunity.com/sharedfiles/filedetails/?id=3812864848), [CW Viewpoint patch implementation/audit](viewpoint-patch.md), [earlier general player guide](active-mods-player-guide.md).

## Casualties Undead (CasualtiesUndead)

**What it really adds:** interactive mouse-driven procedures for bandages, stitches, glass extraction, splinting, injections, cauterization and amputation; blood, oxygen, blood pressure, heart rhythm and six organs; **21 independent medical problems** (including sepsis, collapsed lung and internal bleeding). Procedures are not generic wait bars: mistakes can worsen injury. **Right-click or Esc** cancels a procedure.

**Unusual progression:** arm/leg amputation, makeshift or hospital prosthetics, craftable prosthetics at Metalworking 6 / First Aid 2, Prosthetics skill to restore mobility. Cardiac arrest can be followed by resuscitation with a defibrillator. Gameplay effects vary with medical state, not just the vanilla wound icon. Roughly 40 sandbox controls; the author says multiplayer works imperfectly and is still buggy. **The Only Cure is explicitly incompatible**, but that mod is not on this active CSV. The optional "Censor Miserable episodes" setting is in Options > Mods.

**Watch:** compare client/server wound state, ongoing organ/blood values after rejoining, procedure results, splint application, prosthetic equip/movement, and defibrillator revive. A missing item script or splint crash reported in Workshop comments is a **community report**, not yet reproduced in Chaosworld. Report with both logs.

Source: [official Workshop mechanics and bug reports](https://steamcommunity.com/sharedfiles/filedetails/?id=3805748433).

### Showing Casualties Undead moodles in PZ Pulse Expanded screenshots

The original mod exposes **three distinct moodle types**, not 21 independent diagnosis icons: `High` (drug high), `Miserable`, and `Condition` (the highest-severity clinical problem, with the matching organ icon). Its full set of clinical conditions belongs to the medical report. The separate **Drug Euphoria** continuous value is a Needs Expanded bar, not a fourth moodle.

PZ Pulse Expanded's current `CustomMoodleAdapter.lua` already has read-only collectors for all three. It observes `CasualtiesUndead.Drugs.highLevel(player)`, `CasualtiesUndead.Mind.isMiserable(player)`, and `CasualtiesUndead.Conditions.worst(player)` / `organOf(id)`. Only active source states are exported, and the source's `showMoodles()` option can suppress all three.

For **screenshots** without damaging or drugging a character, a local disposable single-player preview can safely replace just the **adapter's exported UI payload** with example values: High 4/4, Miserable 1/1 and Condition/Concussion 3/3 with the Brain icon. It must **not** modify the Casualties Undead runtime, `player:getModData()`, true health, game moodles, or the live dedicated server; remove it after photography. The browser preview represents what Needs Expanded would display; the actual in-game Casualties HUD/medical report remains unchanged.

Reference: [PZ Pulse Expanded source adapter](https://github.com/Bokicks-Labs/PZ-Pulse-Expanded/blob/main/42/media/lua/client/PZPulseExpanded/CustomMoodleAdapter.lua); [optional mod integration inventory](https://github.com/Bokicks-Labs/PZ-Pulse-Expanded/blob/main/docs/integrations/installed-mod-moodles.md).

## Project A-Life (ProjectALifeNPCs)

**What it really adds:** persistent factions and squads operating off-screen; faction relationships, radio calls, roadblocks, snipers, robberies, building clearance, medics, bleeding NPCs, raids and tiered outposts. The creator describes **148 preset factions** in version 1.3.17 (September 30): less than half hostile. You may be robbed instead of shot; NPCs that flee can remember prior fights. Disabling an outpost radio changes its dispatch behavior. Admins have a squad map overlay.

**Create your own:** creator edits appearance, outfits, weapons, attachments, behaviors, relationships and encounter inclusion. **COPY CODE / LOAD CODE** exports or imports a faction definition. Over 100 sandbox options; start with population, encounter and raid rate. The core mod's NPC creator is not itself a follower system; recruitment into player-managed bases is supplied by the Jeem Extension subsection below. The core mod warns against running two full NPC frameworks on one save.

### Project A-Life - Jeem Extension: claim bases and bring in squads

The installed **Jeem Extension 0.6.0** is a separate companion, Workshop item **3806944055**, and its mod metadata requires `ProjectALifeNPCs` and loads after it. It now appears in the October 11 loaded-session CSV together with its A-Life/Companion Dogs compatibility patch. The CSV documents the latest local loaded session; it does not prove that these mods are enabled in the dedicated server's current `Mods=` configuration.

**Claim a base:** right-click in the world and open **Bases**. To claim a building, choose **Make this building a new base**, then choose whether it is the base's **Main** building or **Quarters** and give the base a name. To claim an outdoor yard, choose **New base: drag its grounds...** and draw the area. The **Base manager...** window provides the overview and management controls. Turn on the ground overlay to see the claimed boundaries. You can mark additional buildings or individual rooms as quarters, which is useful when a base spans multiple buildings or floors.

**Set up the base:** within your base, use the same right-click **Bases** menu to add guard posts, choose which containers serve as food, medical, tools, materials, clothing, weapons or ammunition stores, and set a body-dump location. Quarters and beds constrain how many residents the base can support. The extension exposes base count, area, guard-post and resident limits in Sandbox Options. In multiplayer, base edits are sent to the server and checked there; the base owner is the creating player or their in-game faction, and faction members can manage a faction-owned base.

**Recruit a squad:** approach an A-Life NPC crew and right-click near it. If you own a base and the crew is eligible, choose **Invite crew to live at** and select the base. Normal recruitment checks allied standing, available quarters/capacity and that the crew is not in combat; the debug-only force-invite action is not the normal player flow. Once housed, residents can be scheduled for shifts and routines, use marked stores and guard posts, and appear in the base/faction management views. Their daily plans and needs are part of the extension, not instant player-follow commands.

**Read before enabling:** this changes A-Life's faction/roster persistence and adds a separate resident layer; it is not just a safehouse marker. Check the extension's Sandbox Options for resident behavior, joining, food/bed requirements, base protection, keep-out and hostile breach settings. The code has dedicated server command handling for edits and resident operations, but a new companion mod still needs a disposable-save multiplayer check before adding it to an established campaign. The extension also adds faction reputation, missions and other world systems beyond base claiming.

Source: installed Jeem Extension 0.6.0 metadata, `Features/BaseAreas/Menu.lua`, `Features/Residents/Menu.lua`, and shared base/resident services; [Jeem Extension Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3806944055).

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

The installed payload is a large, late-game production suite, but it is not one linear tech tree. It mixes ordinary learned recipes and found loot with special machines that have their own windows or right-click actions. Sandbox Options > Artel groups features and loot by pack. The installed version identifies itself as **0.2.0** and targets Build 42.21+.

### Find recipes and learn the system

Start with books and magazines found in the world, then use the crafting search to find unlocked recipes. When holding an ingredient, right-click it and choose **Recipes with this item** to open the handcraft list filtered to recipes that consume it. The mod adds this entry as a fallback where the normal menu does not expose it. Machine recipes are separate: use the machine's own window and recipe list. If an expected recipe is absent, check that its Artel pack is enabled and that any required book has been read.

### Production paths

- **Food, medicine, rations and sport nutrition:** the installed recipe and item data includes preserved foods, medical supplies, field rations and protein/supplement bars. The factory sealer and bar extruder are powered CraftBench stations with their own recipe panels; look for the machine's recipe book and required station in the recipe requirements. Some product groups have separate sandbox toggles, including super bars and their cooldown/defect settings.
- **Brewing:** recipes cover fermentation and bottling/kegging. The process preserves liquid and container state: fill an empty container from a valid batch, seal bottles with the matching cork/cap or close a keg, then let the batch age. The Brew Speed setting changes supported fermentation and aging durations; it does not accelerate every Artel process.
- **Beekeeping:** build and place an apiary outdoors. It starts with one frame and can be expanded to three; add a queen, then inspect the hive for its state. Each frame fills separately, with production strongest in May–July, slower in spring/autumn and stopped in winter by default. Nearby flowering Artel planters speed production. Place and light a smoker at the entrance before harvesting to reduce sting risk; harvesting is one timed action per ready frame. The installed options can enable year-round production and independently control disease and sting wounds. This is a separate system from HydeCo Bees.
- **Drying and freeze-drying:** load a drying rack or electric dryer through its station window and select a listed recipe. The electric dryer needs power; its batch pauses while its square has no electricity and resumes when power returns. The sublimator is a separate station with its own recipes. The drying sandbox toggle gates these stations. Their recipe timers are not all affected by Artel's general speed settings.
- **Chemistry and power:** the chemical bench, bioreactor, retort and steam generator are buildable/usable stations, not simply recipes made in inventory. The steam generator is assembled in stages from its construction context menu: frame, boiler, engine, then piping. Once complete, its vanilla generator interaction starts/stops it; the Artel context menu handles fuel, water and boiler repair. It burns solid fuel, needs water, and stops when fuel/water is depleted or its condition is too low. Chemistry and steam have separate sandbox gates; the machine speed option applies only to the retort and bioreactor.
- **Cold storage:** the cooler bag accepts up to three batteries. With charge, it slows food aging to one quarter of the normal rate until its battery reserve is spent. A buildable cellar slows food aging to 60% continuously and does not require power. The Cold Storage sandbox toggle controls both systems.
- **Trade post:** find and read the trade-post note, then build the radio station using its recipe. It must have power (mains/generator or its supported battery setup) to conduct trades. Sell items or place purchase orders in the station window; orders join one shipment rather than completing instantly. When the shipment arrives, collect purchased goods from its manifest and claim sales proceeds. The trader's stock and selected rare goods refresh on an 11-day cycle. Buying is limited by stock, account balance and reputation level; the trade UI shows locked tiers and current demand/discounts. The Trade Post sandbox toggle disables its loot, construction recipe and interactions.

### Configuration and practical cautions

Artel's loot frequency is configurable separately from pack enable/disable switches. The installed file documents four loot-rate levels (×1, ×3, ×8 and ×15); process-speed settings are narrower and do not affect every timed craft. Change world-facing pack settings before relying on that content in a long-running save. Turning a pack off generally stops its station/actions and new loot; it does not necessarily remove already-built objects. The installed code explicitly preserves some built storage and trade/steam objects when their options are disabled, while their functionality is gated.

**Code/source coverage, not runtime validation:** these steps were derived from the installed Workshop files for Artel 0.2.0, especially its sandbox options, recipe/item definitions, player context menus and station logic. They provide a route into its systems, not an exhaustive ingredient-by-ingredient recipe catalog. Multiplayer behavior is claimed only where the installed code routes state changes through shared/server handlers; still validate a disposable setup before committing a valuable save. The upstream Workshop page is a primary reference, but no separate authored walkthrough/wiki was linked in the installed description.

Source: [Artel Manufactory Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3794133594); locally installed payload, `ArtelManufactory/42/media` (version 0.2.0).

## Immersive Blackouts (ImmersiveBlackouts)

This mod means a temporary utility outage is **not necessarily** the permanent vanilla shutdown. It simulates electricity and water going off and recovering, then eventually declining for good. Its creator lists default periodic outage/restoration chances of **1%/5% per 10-minute check**, adjustable by sandbox settings. Tune outage windows and permanent-shutoff behavior in Sandbox Options. Clients can adjust flickering effects separately in Mod Options.

**Use:** tune the world settings and listen to **KERS 89.2 MHz** radio broadcasts for infrastructure warnings and restoration reports. Debug/server admins can also toggle events from a debug context menu before permanent shutoff.

**Watch:** temporary failures versus permanent shutdown, radio announcements lining up with actual state, flickering on each client, and generator-powered buildings continuing to work during grid loss. Since LG Extended Electricity, BADLANDS and water mods are installed, test power and water as distinct systems, not a single switch.

Source: [Workshop features and configuration](https://steamcommunity.com/sharedfiles/filedetails/?id=3607686447).

## Beyond Ten (BeyondTen)

Skills continue from **level 10 to 15** with separate mastery progress, a 15-slot skill panel and additional combat, strength, endurance and crafting bonuses. The underlying native game tables still max at 10: mastery lives in the mod's extra saved state. This matters for compatibility with other skills and player panels.

**Watch:** XP and mastery after logout, other mods' skills appearing in the expanded panel, normal tooltip and status display in CleanUI, and whether skills that have their own level-10 gates continue awarding XP. The author notes not every external save/death-recovery mod preserves mastery. It is **not equivalent to changing native perk levels to 15**.

Source: [Workshop progression, values and compatibility notes](https://steamcommunity.com/sharedfiles/filedetails/?id=3765241705).

## PZ Pulse, PZ Pulse Expanded and companion panels

These are **read-only external dashboards**, not in-world treatment or stat-changing gameplay. The active CSV includes PZ Pulse (`PZ_Pulse`), your released PZ Pulse Expanded (`PZ_Pulse_Expanded`), Nutrition Panel (`PZ_Nutri_Panel`) and Companion Dogs panel (`PZ_Pulse_CompanionDogs`). Expanded's Needs panel supports extra moodles/stats; where CW disables Lifestyle hygiene by ownership, its hygiene bar can be intentionally omitted.

**Use:** open the PZ Pulse browser UI while playing and confirm the exported character/needs panels update. **Watch:** panels absent due to optional mod data, stale browser values, duplicated status providers, and the difference between one player's locally loaded development addon and the **released** server-sync ID. Never substitute `PZ_Pulse_Expanded_Dev` in the CSV.

References: [PZ Pulse Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3753700423), [PZ Pulse Expanded Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3804774101), [CW ownership](lifestyle-feature-ownership.md).

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

See [complete, older session player guide](active-mods-player-guide.md) for brief notes on remaining mods. Its session inventory may contain development IDs; the October 11 CSV remains the release-only sync reference.
