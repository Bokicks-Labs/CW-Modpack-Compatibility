# Active Mods Player Guide

This guide is for the mods loaded in the Project Zomboid session captured on **October 9, 2026** (Build **42.21.0**). The inventory comes from the newest local `DebugLog.txt`, not from a guess based on installed Workshop subscriptions. The log contains **344 distinct mod IDs**. This guide focuses on mods with mechanics, controls, menus, setup, or interactions that are easy to miss; it deliberately skips the many single-vehicle additions and cosmetic-only packs.

## Read this first

- **Several IDs are local development builds.** The session loaded `CWModpackCompatibility_dev`, `CWModOptionsSearch_dev`, and `PZ_Pulse_Expanded_Dev` as well as some release IDs. Local dev IDs are not Workshop IDs; they exist because your local development junctions are enabled. The currently loaded CW release and dev IDs may result in both copies' code running. See the session inventory note at the end.
- **Server and client settings matter.** A few mods only work correctly when enabled in the right place, and some are single-player or require matching server/client versions. The guide flags these where the installed metadata establishes it.
- **Libraries are not gameplay systems.** Mods such as DAMN, NeatUI Framework, Tsar's Common Library, Moodle Framework, Gunworks, VFluidLib, and ZombieBuddy provide support that other mods use. Leave them enabled when their dependents need them.
- **Where the installed description is vague, I say so.** Key combinations and detailed recipes can vary by version. Check the in-game Keybindings, Mod Options, Sandbox Options, and recipe list rather than relying on an unverified hotkey.

## Major systems and how to use them

### Project Viewpoint: first-person play

**Viewpoint** renders a true first-person camera within PZ. The family of active add-ons fills out actions that would otherwise be awkward in a 3D camera: recoil and ADS alignment, true projectile travel, physical throwable arcs, visible blood effects, 3D fence models, windows, weather, vegetation, and fixes for vehicles, doors, fire, surfaces, lights, and menus. It changes how aiming and interacting feel, so spend time in a safe area learning the camera and reticle before using guns or throwables in a dangerous fight.

Key details from your installed add-ons:

- **Recoil & ADS** aligns sights to each weapon model and supports red dots and magnified scopes with eye boxes and reticles. It also adds recoil and sway. Sight alignment depends on the weapon, so the reticle/sight picture is meaningful rather than the vanilla isometric aim point.
- **True Ballistics** makes rounds travel from the muzzle, converge on the reticle, drop, stop at walls, and hit the body part intersected. It keeps vanilla damage, ammo, sounds, recoil, and jams; multiplayer hit validation is server-side.
- **Advanced Throwables** uses a hold-to-charge throw from the hand toward the crosshair. Projectiles bounce, roll, and collide with world geometry and entities. It covers grenades, molotovs, smoke/noise makers, supported modded throwables, and ordinary objects. The server owns throw results in MP.
- **Foraging** brings search pins, tracking markers/arrows, and pickup interactions into 3D. Search fog closes in around the search radius; this can make foraging feel more spatial and easier to read, but it also means the search boundary is shown visually.
- **True Weathers & Lighting** is a large presentation system: distant storms, seasonal profiles, horizon rain/snow, accumulation, blizzards, hail, lightning/shadows, wet surfaces, glass frost/rain, wipers, eye adaptation, weighted flashlight movement, and a weather/lighting shader pack. Check its options and shader packs if the scene is too dark, bright, or visually busy.
- **True Weathers - Gameplay** is separately active alongside the visual weather mod. It makes weather regional and gameplay-relevant: rain barrels, crops, wetness, fires, and zombie senses respond to weather; severe rain, thunder, blizzards, and fog affect noise or zombie sight. Its effects have sandbox toggles and it runs on server and clients. Keep it aligned across MP participants.
- **Viewpoint Fences** is a beta visual replacement for vanilla fence/gate/railing models. **F8** toggles between original and new fence models; that binding can be changed or unbound in Options.
- **Viewpoint - Shovel Graves**: hold a shovel/garden tool, press the dig key (default **Period**), inspect the preview, then left-click to dig a grave or furrow.
- **Construction 1P Viewpoint** adapts vanilla furniture placement to first-person aim and a geometric ghost preview, with rotate/place/pickup behavior.
- **Viewpoint Tile Fix** supplies roof backs/corners/gables missing from the isometric view. It covers vanilla Kentucky and Grapeseed, not Louisville, and avoids map cells changed by map mods. If removing it, first disable its roof-completion option and visit explored affected places before removing the mod from the save.
- **Viewpoint Bunker Fix** is a Build 42.21 visual geometry fix for vanilla bunker embankments/walls; enabling or disabling it requires a full game restart.
- **Viewpoint Turbo** is a client-side performance optimization that aims to preserve quality. Its description does not promise a fixed FPS gain; results depend on the scene and hardware.
- Remaining Viewpoint patches address specific rendering/interaction defects: barricade textures/placement, KI5 vehicle parts, door lighting/textures, fire sprites, headlight position, wall/roof surfaces, and custom menu text overlap. These are support fixes rather than separate gameplay systems.
- **AviationCore** plus **AviationCore - Higher Limits** support flight content and lift speed/altitude limits for Viewpoint; the higher-limits add-on says it is solely for Viewpoint.
- **ZombieBuddy** is a Java runtime patching framework required for Viewpoint's Java-side features. Subscribe through its official Workshop item and follow its one-time setup instructions. The October 9 active log confirms it loaded; the installed native DLL differs from the Workshop DLL because of the previously tested Windows hostname repair.

### Project A-Life NPC factions

**Project A-Life** adds factions, patrols, camps, outposts, and raids, plus a faction/NPC creator. Expect NPC groups to behave as organized populations rather than isolated encounters. Its Workshop summary is brief and doesn't document the creator workflow or controls; look for the mod's creator UI/options in-game and treat faction/raid behavior as dependent on its own configuration. **3D Tracer Fix** is an A-Life + Viewpoint presentation bridge for NPC muzzle flashes and tracers.

### Companion Dogs and breed add-ons

**Companion Dogs** lets you tame strays and raise a companion that follows, warns about zombies, and can fight, hunt, carry cargo, help with livestock, and breed. Obedience skill unlocks commands: *go to a spot* at level 1, *distract zombies* at level 3, *sniff out an item* at level 5, and *fetch while you sleep* at level 10. An untrained dog can disobey; Sandbox Options can disable that. Dog advantages have tradeoffs in loyalty, combat, training, heat, and behavior.

Your active breed add-ons have meaningful differences:

- **Chihuahua:** spots zombies 15% earlier, trains obedience quickly, is weak in combat, and can grant a forage-vision bonus while nearby, fed, and loyal.
- **Doberman:** weak while untrained but has the strongest fully trained lethality curve; less durable than a Rottweiler. Its nearby *Steady Aim* moodle improves firearm accuracy, recoil recovery, and reload speed.
- **Labrador:** specializes in hunting and retrieving. Its *Soft Mouth* moodle lets it bring kills back early; it trains hunting quickly and can improve your Butchering/Short Blade learning while nearby.
- **Pomeranian:** active breed with its own model, voice, puppy/breeding support, saddlebags, and unique moodle. The short description doesn't enumerate its exact balance effects.
- **Pug:** fast obedience learner with loyalty that doesn't fade on its own; a morale companion, not a fighter/hunter. It barks and cannot switch to quiet watch, so it may attract zombie attention.
- **Rottweiler:** combat-focused; its *Front Line* moodle reduces your melee endurance cost while it fights beside you.
- **Cats:** quiet lookouts, not fighters or livestock helpers. They detect zombies at long range, hunt rodents/rabbits during sleep, and may bring prey home. *Cat's Eyes* improves night foraging vision while conditions are met. Cats are more stubborn and lose loyalty faster if neglected; occasional rat chasing can interrupt them.

**Save caution:** each breed add-on warns not to remove it while a living animal of that breed exists in the save. For co-op hosting, Companion Dogs says enable the mod in the main-menu Mods list as well as the co-op setup, or animal models/textures may fail to appear. Dedicated servers require it on each player/client too.

### Lifestyle, hygiene, and bodily needs

**Lifestyle: Hobbies** is a broad activity and self-care system, not one small feature. It adds musical instruments/songs/singing/bands, dancing, jukeboxes and DJ/disco objects, hobbies, yoga/meditation, and many personal care interactions (mirrors, combs, baths, showers, toothbrushes, sponges, perfume, and more). Its sandbox settings tune the system. Its description warns that mods reducing timed-action duration can conflict.

**Lifestyle: Hobbies MP Fixes** patches Build 42 issues without replacing Lifestyle's own files: songs disappearing during a session, yoga/meditation staying hidden after disconnect, progress/moodles wiping on return, jukebox audio errors, and a log/firewood stack crash. It is especially relevant in multiplayer/reconnect testing.

Three bodily-care mods can overlap, and your CW compatibility mod arbitrates feature ownership:

- **Nature's Call** adds gut health plus bladder and bowel needs. Watch its bodily-needs/moodle signals and use appropriate bathroom options. With Lifestyle active, CW defaults bladder/bowel ownership to Nature's Call so duplicate needs/actions don't compete. CW's Sandbox Options expose independent overrides; changing ownership needs a restart. If the owner mod is removed, ownership should return to Lifestyle automatically.
- **Brush Your Damn Teeth** makes toothbrush and toothpaste useful through dental hygiene. It owns dental hygiene by default when paired with Lifestyle; CW suppresses Lifestyle's duplicate brushing actions but preserves its other hygiene/grooming features.
- **Take A Bath And Shower** adds bathing/showering interactions. Its companion depth-map fix supplies the correct bath/shower depth masks. CW includes a narrow menu/network compatibility fix; it doesn't replace the mod's bathing behavior.
- **LifestyleMP fix and CW should load after Lifestyle and before/after their respective patched mod as configured.** Your repo's current Workshop docs specify `LifestyleHobbies` → optional `LifestyleHobbiesFix` → `CWModpackCompatibility`, with CW after the other patched mods. Follow the server's prescribed order if using multiplayer.

### Health, first aid, illness, and exercise

- **Casualties Undead** turns treatment into hands-on mouse-driven procedures. Bandaging, stitches, injections, cauterizing, and amputation use short minigames; the body's state includes heart rhythm, blood pressure, oxygen, six organs, and 21 possible independent problems. It adds defibrillation and cardiac arrest. **Right-click or Esc exits** a procedure. It is a deeper medical simulation: carry/learn the right supplies and don't assume a single generic treatment fixes every condition.
- **Infirmities** adds conditions such as tremors and hallucinations with gameplay effects. It is paired with **Moodle Framework** and **Medicine Moodles** so active conditions/medication durations can be shown. Medicine Moodles' skill-requirement add-on limits when those medication moodles display.
- **Caffeine Makes Sense** changes caffeine from an instant fatigue removal to gradual fatigue masking, followed by rebound and worse sleep quality. A coffee can help you function now but does not erase the debt; avoid using it as a substitute for sleep before a long trip.
- **FWO Fitness Workout Overhaul** changes Fitness/Strength XP based on consistency, perk levels, and rest days. **FWO Working Bench Press & Treadmill** adds usable equipment, with heat/thirst and weight-sensitive training. Plan training as a routine and account for hydration/overheating rather than spamming sessions.
- **Senator's Martial Arts Core** adds Boxing, MMA, Muay Thai, and Karate learned from magazines. One Martial Arts skill covers styles while hidden per-style mastery unlocks combinations/heavy attacks. Fight with both hands free; gloves are optional. This is progression through learning and practice, not a character-creation menu toggle.
- **ScarSystem** adds persistent scars and an injury-history panel.
- **Replace Bandage** streamlines replacing dirty/old bandages; it exists to reduce repeated removal-and-reapply steps.
- **Brush Your Damn Teeth** and **Lifestyle** hygiene interactions are covered above; the CW ownership switch matters if dental bars/actions seem missing or duplicated.

### Firearms, ammo, stealth, and combat handling

- **Hot Brass - Ammo Crafting** turns recovered casings into a reloading/reuse loop. **Tactical Reload** adds a faster reload option. **Reload All Magazines** adds a right-click command to load all magazines of the selected type. Since these affect inventory/reload workflows, distinguish a tactical reload (speed/weapon handling) from bulk-loading loose magazines (inventory context menu).
- **Gun Repair Kit** adds basic and advanced craftable repair kits, plus dismantling firearms into parts. Basic repairs restore 10% condition, advanced 40%. Advanced repair is gated by a gunsmith manual. Gun-oil recovery/crafting and cleaning-kit recipes link the chain together; the server validates repairs and creates items in MP.
- **Guns of Marz** adds a substantial firearm set and uses **Gunworks** support. **Improvised Silencers** adds suppressor handling/sounds and optional Extended Realism durability settings; it also supports Guns of Marz and Vanilla Firearms Expansion. Check its sandbox/options before assuming suppressors are indestructible.
- **Lethal Stealth** adds crouching/prone tactical stances. It integrates with the archery mod's extra bow poses. Review Keybindings because this is stance control, not only a passive balance change.
- **Vehicle Armor Crafting** lets you craft/install welded window bars and steel plates on selected vehicle panels. Armor protects the covered part while the armor piece remains intact.
- **Cye's Push Doors** lets you shoulder/push doors to damage, stagger, or knock down targets. Strength, Fitness, door type, durability, and arm strain affect outcome. Sandbox settings tune it; repeated pushing has a physical cost.
- **Tripping Zombies** allows zombies to stumble against each other or randomly while moving. Tune frequency/behavior in Sandbox Options; in a sprinter run this can create openings but is not reliable crowd control.
- **Skully's Zombie Collision** changes zombie collision behavior. The installed description does not give enough detail to claim exact tuning or controls.

### Survival infrastructure, crafting, food, and farming

- **Waterpipes** builds pumps/pipes linking water sources such as barrels to toilets and sinks; it also supports sprinklers for crops. Think in terms of a connected network rather than separate point-use objects. The active description does not specify exact tool/pipe recipes.
- **Badlands Power** adds five power options: a silent fuel-free indoor battery bank, dual-fuel propane portable generator, waste-oil stationary engine, worn scrap portable, and 10 kW frame generator. Waste-oil engines can use cooking/fryer/motor oil. Machines can appear in generator crates or on the map. Optional BADLANDS Clutter fuels are described but not present in the captured active IDs, so don't expect those extra oils/cylinders unless enabled separately.
- **Long Term Preservation** adds preservation without a freezer: salting/drying, jars, pemmican, lard, and jam. It rewards planning and preserves harvest/meat through a different set of inputs and recipes.
- **Sunshi's Cooler System** extends food life on expeditions; use it as portable cold-chain support. The installed description is too short to state exact fuel/capacity rules.
- **Artel Manufactory [42.21]** is a large late-game production overhaul with 780+ items and electric machines: brewing, canning/rations, nutrition bars, beekeeping, farming/dairy, drying/freeze-drying, camping, chemistry (bioreactor/steam generator), reputation/credit trading, and high-capacity storage. Many packs have individual sandbox toggles. Its Workshop description is in Russian; this guide translates the listed systems, but recipes and current implemented scope should be checked in-game because the item is an active rebuild and its description includes roadmap features.
- **Computer Mod** makes otherwise decorative computers functional. The Workshop summary does not enumerate applications, so inspect powered computer interactions in-game rather than expecting one universal use.
- **Expanded Storage** expands selected containers and adds matching construction recipes; it's a capacity/building system, not a universal multiplier on every container.
- **Useful Barrels** gives barrels usable functions; the description is vague, so check right-click interactions/recipes on each barrel type.
- **Bookstore Storage Fix** repairs invalid loot distribution in certain rooms so room-specific containers draw appropriate loot rather than generic junk. It is a quiet data fix.
- **Quartermaster** is a beta, single-player auto-sorting/hauling workflow: assign/designate boxes by category, then your character transports matching loot to them. It is not an instant teleport sort; allow for the character to do the hauling. Avoid assuming it is multiplayer-safe.
- **Layered Placement** expands Build 42 furniture placement: lights can go over furniture, decor can go on railings/catwalks, and furniture can sit under some overhead lights. Outdoor/railing lights use batteries without building power. Server Sandbox Options control allowed features; clients can opt out in Mod Options. Enable on server and clients for MP.
- **Fence Sheets** lets you cover chainlink/wire/bar fences and empty doorframes. A curtain sheet blocks zombie line of sight and your view cone; right-click to open/close, remove to recover the sheet. One tarp can cover up to three contiguous fence tiles or a 1–3 tile doorway as a single piece.
- **Neat Building** is the legacy full variant with UI and buildable entities; its installed description says not to combine with Stairs East & South or modular Neat Building variants and warns against removing it from a save without the safe-uninstall process. Avoid changing this mod mid-save casually.
- **Neat Crafting** can switch between the Neat and vanilla crafting menus through Mod Options or right-click on the sidebar; default is Neat UI on. It warns against removing it from existing saves.
- **Neat Lockpicking** provides a redesigned UI and three entry approaches: lockpick, crowbar, and hotwire. The mod description doesn't specify exact skill/item thresholds, so inspect the UI and recipes.
- **Functional Car Wash** makes Fossoil car-wash locations usable. **Vehicle Salvage Overhaul** and **Vehicle Repair Overhaul** add repair/salvage systems; the B42 salvage version is the relevant active entry. Exact salvage yields/recipes are version-specific and should be read from the in-game recipe menus.

### Navigation, inventory, equipment, and second-screen tools

- **PZ Map** is a read-only second-screen map for vanilla PZ. Open its shipped browser page and let explored areas fill in as you travel. It doesn't cover the game screen. It is not a live map editor.
- **PZ Pulse** is a read-only second-screen dashboard for character info, skills/XP, health, protection, temperature, moodles/needs, weapon condition, clothing, quickload loadout, encumbrance, and wounds. **PZ Pulse Expanded (Dev)** extends Needs with active supported moodles and underlying/modded stats; absent or unreadable optional data is omitted. **Nutrition Panel** and **Companion Dogs** add dashboard panels. Keep the browser dashboard open on a second display; it doesn't alter the game state.
- **Spawn Selector** lets you choose any mapped location after character creation. The destination still needs to be present in the world/map setup.
- **Add More Map Symbols** enriches symbol placement/management on maps. Its local Workshop summary is too sparse to accurately document specific keybinds.
- **CleanUI** replaces the inventory/loot presentation with configurable container bars, persistent drag/drop container order, search/transfer shortcuts, sorting/columns, optional weight, and collapsible groups. Configure it client-side. It requires NeatUI Framework.
- **Equipment UI** provides a paper-doll equipment view in the Tarkov/STALKER style. Treat it as an alternate gear inspection/equip interface; check its options for layout behavior.
- **StowInHands (Hands)** adds hotkey actions to stow both held items into the active container, place held items in the world, and **Alt+Click** an inventory/container-tab/ground item to move it directly into your hands. Check Keybindings and avoid conflicts with other Alt-click mods.
- **Two Weapons on Back** adds support for carrying a second back-slot weapon when using a sling.
- **Bottles for Backpack Bottom** allows supported bottles to occupy the backpack-bottom slot, reducing the need to hold them. Its description says More Bottles is optional for the larger 3L bottle.
- **Item Condition Overlay** adds visual condition bars to items.
- **Better Generator Info** augments the generator info window with estimated days/hours until fuel runs out.
- **Exact Minute Clock** shows exact minutes rather than ten-minute jumps, adds a 12/24h toggle, weight readout, and an alarm settings gear on the clock; clicking the alarm silences it.
- **Context Menu Cleanup** hides right-click entries by name. **Context Menu Icons** is the shared core used for color/icon packs; customization is through its supported icon pack/settings, not a gameplay action.
- **Universal Translation Compatibility** restores readable names/recipes/traits/menus for mods still using older text conventions; it is automatic and has no setup described.
- **Daily Report Journal** stores daily statistics and XP gains in journal files. **Traits As Skills** gives evolving traits a tab with progress, levels, and stages; the description calls it an open platform and doesn't promise every trait is represented.
- **Read While Walking** (B42.20 fix) lets reading continue while walking. **Simply Put Mags Back** returns magazines to their source location, which helps avoid leaving a trail of books/mags in inventory.
- **Tuna collector shelves/racks** are functional collection storage rather than generic containers: the book shelf catalogs 204 vanilla skill/recipe books, the VHS shelf tracks 155 retail tapes, and the equipment/gun racks display and keep gear accessible. **Rewatchable VHS** only affects retail VHS and is single-player; configurable cooldown governs when watched tapes can be replayed. **Movie Night** makes tape choice affect mood: comedies comfort, horror has a cost, and home videos have their own response.
- **NeatUI XP Drop** is a standalone configurable XP bar; **NeatUI Hairstyler** provides a grid preview/filter for hair/beard choices. Both use the NeatUI framework.

### Maps, locations, boats, and vehicle utilities

- **New Hartburg** is a new village west of Rosewood on the main highway, described as a place to train firearms. A map addition affects world generation; don't add/remove map mods casually after a save has generated.
- **Project RV Interior** lets supported RVs enter a separate walkable interior. Use the vehicle's radial interaction (often V near/in the RV, depending on vehicle) and the interior's floor/right-click exit action as documented by individual vehicle add-ons. Some RV add-ons explicitly require the interior mod enabled when the world is created.
- **RV Interior Insecure (Beta)** changes the interior from a safe retreat into a siege scenario. Pressure increases with time sheltered, nights are worse, and going outside doesn't reset the siege. Choose Tolerant/Standard/Relentless profile; windows, forest, fog, curtains, and window escape contribute to the experience. It requires Project RV Interior and loads after it.
- **Project RV Fix** keeps rain from wetting players inside RV interiors and uses an actual powered heater/AC part to moderate interior temperature. No active heater/power means no temperature correction. It adds an interior context-menu toggle for the heater/AC because the driver-seat control is inaccessible inside. Sandbox option `EnableCabinClimateControl` can disable climate behavior while retaining the dry-interior fix.
- **RV Interior Manager** is an admin/management panel for tracking interior assignments and RV occupancy/location. Its description is Portuguese, but identifies an admin-oriented oversight tool rather than player survival content.
- **Fifth-Wheel RV Trailer** has a 300-capacity trunk and walk-in bedroom/bathroom/laundry/kitchen/living room. Its description says press **V** near the trailer to enter and right-click the interior floor to leave.
- **BoteBR rowboat** is a pilotable boat with walkable deck: place it on water, board, steer with **WASD**, anchor to treat the deck as walkable ground. It can be a mobile fishing platform and offers a stated increased big-fish chance away from shore.
- **Covo BR crab/lobster traps**: craft a pot, make bait from 10 fish (five uses), bait it, and set it from shore or boat. A buoy marks the location; return after five hours for 1–5 crab/lobster. The boat's walkable deck is a natural deployment platform.
- **Vehicle Seat UI (KI5)** adds a seat interface for KI5 vehicles; **Carry Visible Generators** changes how generators are carried; **Get In The Damn Car** changes vehicle entry convenience; **No More Wiggly Vehicle** helps align driving to the eight cardinal directions. **True Cargo** alters vehicle cargo representation/capacity behavior; its description should be consulted before loading unusually heavy vehicles.
- **Water Trailer B42.20 Fix** supplies multi-fluid water trailers and restores propane trailer support through Vehicle Fluid Logistics. Do not enable it with the original Water Trailer mod. **Water Semi-Trailer** requires the active 82 Oshkosh M911 and this fixed water trailer package.

## Feature packs that mostly explain themselves

The active list also contains many content packs whose main purpose is clear from their name. To keep the guide focused, they are not expanded into individual walkthroughs here: **99 loaded mod IDs** are obvious vehicle models, vehicle variants/skins, or extra vehicle textures. Those add the named vehicles to the world/spawn pool; some share Workshop pages and are separate in-game mod IDs. Also omitted from detailed entries are straightforward hairstyle/voice/face/clothing additions, individual weapons, and simple decorative item packs unless they have a distinct mechanic documented above.

Other active content worth knowing exists, but not requiring a special how-to from the installed descriptions: Guns of Marz, US Military Grenades, Vanilla Outfits Expanded, Spongie's character customization/details and retextures, More Damaged Objects, More Vehicles Replacer, and vehicle-specific emergency/service/camper variants. Use their item/spawn/recipe lists to discover content.

## Load order, configuration, and save care

- The CW compatibility mod must load **after** mods it patches. The repository's current Workshop description lists Lifestyle → optional Lifestyle MP Fix → CW; other supported mods (including Week One/Bandits, Dynamic Trading, ETO_B) also go before CW. Optional CW Audio Mixer and Mod Options Search go after CW.
- CW defaults Nature's Call to bladder/bowel ownership and Brush Your Damn Teeth to dental ownership when the respective owner mod is active. Ownership is independently configurable in Sandbox Options; restart after changing it. Its Lifestyle compatibility skill view is toggled in Mod Options.
- Keep map/world-generation mods (for example New Hartburg) stable for a save. Be especially careful removing Neat Building, Companion Dogs breed mods with living animals, Viewpoint roof tiles already visited, or RV interior mods referenced by world content.
- For multiplayer, align server and client mod versions/order for gameplay systems. Several visual Viewpoint mods are client presentation, but True Weathers Gameplay, Companion Dogs, Layered Placement, combat actions, and other systems have server/client expectations stated above.
- To find a specific action: check **Options → Key Bindings** for named mod actions; **Mod Options** for client-facing display/behavior; **Sandbox Options** for world/server balance. The active inventory has multiple control mods, so don't assume an undocumented key.

## Full active-session inventory

The 344 IDs below were parsed from the `loading <ID>.` entries in `C:\Users\Rim28\Zomboid\Logs\2026-10-09_15-59_DebugLog.txt`. This is the loaded mod ID inventory, including dependency libraries and local dev builds; it is not a list of 344 substantial gameplay mods. Main handbook sections above cover the ones that require extra explanation.

### Not expanded here: obvious single-vehicle additions

These IDs add the named car/truck/van or a close variant/texture pack. They are listed once here for completeness, without repetitive individual descriptions: `49powerWagon`, `62daimlerFerret`, `63beetle`, `63Type2Van`, `65banshee`, `66pontiacLeMans`, `67gt500`, `68firebird`, `69camaro`, `69charger`, `69fordMustang`, `69fordMustangExtra`, `69mini`, `69mini_ItalianJob`, `69mini_MrBean`, `69mini_PitbullSpecial`, `70barracuda`, `70chevelle`, `70dodge`, `70fordEscort`, `70roadRunner`, `73fordFalcon`, `73fordFalconPS`, `73nissanGTR`, `75grandPrix`, `76chevyKseries`, `76chevyKseriesExpanded`, `76chryslerNewYorker`, `77firebird`, `78amgeneralM35A2`, `78amgeneralM35A2extra`, `78amgeneralM49A2C`, `78amgeneralM50A3`, `78amgeneralM62`, `78lamboCountach`, `79camaro`, `80manKat1`, `81deloreanDMC12`, `81deloreanDMC12BTTF`, `82firebird`, `82firebirdKITT`, `82jeepJ10`, `82jeepJ10t`, `82oshkoshM911`, `82porsche911`, `83amgeneralM923`, `83amgeneralM923extra`, `83gmcGseriesVans`, `83gmcVanduraATeam`, `84buickElectra`, `84cadillacDeVille`, `84corvette`, `84gageV300`, `84jeepXJ`, `84merc`, `84oldsmobile98`, `85buickLeSabre`, `85chevyCaprice`, `85chevyStepVan`, `85chevyStepVanexpanded`, `85oldsmobileDelta88`, `85pontiacParisienne`, `86chevyCUCV`, `86fordE150`, `86fordE150dnd`, `86fordE150expanded`, `86fordE150mm`, `86fordE150pd`, `86oshkoshP19A`, `87buickRegal`, `87chevySuburban`, `87fordB700`, `87toyotaCorolla`, `87toyotaMR2`, `88chevyS10`, `88toyotaHilux`, `89defender`, `89dodgeCaravan`, `89fordBronco`, `89trooper`, `89volvo200`, `90bmwE30`, `90fordF350ambulance`, `90pierceArrow`, `91fordLTD`, `91fordRanger`, `91geoMetro`, `91lexusLS400`, `91nissan240sx`, `91range`, `92amgeneralM998`, `92amgeneralM998extra`, `92fordCVPI`, `92jeepYJ`, `92jeepYJJP18`, `92nissanGTR`, `93chevySuburban`, `93chevySuburbanExpanded`, `93fordElgin`, `93fordF350`, `93fordTaurus`, `93mustangSSP`, `93townCar`, `95impreza`, `96lancerEVO`, and `98stagea`. These are the straightforward named-vehicle entries; special vehicle behavior (boats, RV interiors, armor, fluid trailers, seats, cargo) is described in the sections above.

### Remaining straightforward content additions

The session also loads small item, clothing, hairstyle, voice, and weapon additions. Their purpose is discoverable in the in-game inventory/recipe/spawn pool; no unusual control or system is documented in the installed summaries. Some content packs (such as the AutoTsar motorclub) bundle multiple named vehicles rather than one model; they remain outside the how-to sections unless they add a distinct mechanic.

### Detailed entries covered above

The loaded ID count is 344. The guide prioritizes systems that need explanation; routine content-only additions and no-menu dependency libraries are intentionally not given standalone walkthroughs. Use the in-game Mods list or log as the complete checklist when you need to compare IDs.

## Inventory limitations

The local snapshot gives authoritative loaded IDs and local `mod.info` metadata, but not every Workshop page's full changelog or every sandbox/keybinding label. `CVI`, the local CW/PZ Pulse dev IDs, and an Authentic Z duffle integration lack matching indexed Workshop metadata, so their behavior is not guessed here. The log includes several startup blocks; the newest captured block around 16:06 on October 9, 2026 (in `2026-10-09_15-59_DebugLog.txt`) was used because it is the latest complete startup in that file and includes active PZ Pulse/PZ Map heartbeats. The file was updated through 16:12. Load order in the 15:59 launch shows CW release and dev core both loaded, so treat that as a local testing setup, not a recommended production configuration.
