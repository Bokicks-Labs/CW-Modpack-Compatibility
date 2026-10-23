-- Generated from Zomboid/Sandbox Presets/ChaosWorldViewpoint.cfg.
-- Refresh with: python Scripts/export-sandbox-preset.py
SandboxVars = {
    VERSION = 6,
    -- Changing this also sets the "Population Multiplier" in Advanced Zombie Options. Default = Normal
    -- 1 = Insane
    -- 2 = Very High
    -- 3 = High
    -- 4 = Normal
    -- 5 = Low
    -- 6 = None
    Zombies = 4,

    -- How zombies are distributed across the map. Default = Urban Focused
    -- 1 = Urban Focused
    -- 2 = Uniform
    Distribution = 1,

    -- Controls whether some randomization is applied to zombie distribution.
    ZombieVoronoiNoise = true,

    -- How frequently new zombies are added to the world. Default = None
    -- 1 = High
    -- 2 = Normal
    -- 3 = Low
    -- 4 = None
    ZombieRespawn = 4,

    -- Zombie allowed to migrate to empty cells.
    ZombieMigrate = true,

    -- Default = 1 Hour, 30 Minutes
    -- 1 = 15 Minutes
    -- 2 = 30 Minutes
    -- 3 = 1 Hour
    -- 4 = 1 Hour, 30 Minutes
    -- 5 = 2 Hours
    -- 6 = 3 Hours
    -- 7 = 4 Hours
    -- 8 = 5 Hours
    -- 9 = 6 Hours
    -- 10 = 7 Hours
    -- 11 = 8 Hours
    -- 12 = 9 Hours
    -- 13 = 10 Hours
    -- 14 = 11 Hours
    -- 15 = 12 Hours
    -- 16 = 13 Hours
    -- 17 = 14 Hours
    -- 18 = 15 Hours
    -- 19 = 16 Hours
    -- 20 = 17 Hours
    -- 21 = 18 Hours
    -- 22 = 19 Hours
    -- 23 = 20 Hours
    -- 24 = 21 Hours
    -- 25 = 22 Hours
    -- 26 = 23 Hours
    -- 27 = Real-time
    DayLength = 5,

    StartYear = 1,

    -- Month in which the game starts. Default = July
    -- 1 = January
    -- 2 = February
    -- 3 = March
    -- 4 = April
    -- 5 = May
    -- 6 = June
    -- 7 = July
    -- 8 = August
    -- 9 = September
    -- 10 = October
    -- 11 = November
    -- 12 = December
    StartMonth = 7,

    -- Day of the month in which the games starts.
    StartDay = 9,

    -- Hour of the day in which the game starts. Default = 9 AM
    -- 1 = 7 AM
    -- 2 = 9 AM
    -- 3 = 12 PM
    -- 4 = 2 PM
    -- 5 = 5 PM
    -- 6 = 9 PM
    -- 7 = 12 AM
    -- 8 = 2 AM
    -- 9 = 5 AM
    StartTime = 1,

    -- Whether the time of day changes naturally, or it's always day/night. Default = Normal
    -- 1 = Normal
    -- 2 = Endless Day
    -- 3 = Endless Night
    DayNightCycle = 1,

    -- Whether weather changes or remains at a single state. Default = Normal
    -- 1 = Normal
    -- 2 = No Weather
    -- 3 = Endless Rain
    -- 4 = Endless Storm
    -- 5 = Endless Snow
    -- 6 = Endless Blizzard
    ClimateCycle = 1,

    -- Whether fog occurs naturally, never occurs, or is always present. Default = Normal
    -- 1 = Normal
    -- 2 = No Fog
    -- 3 = Endless Fog
    FogCycle = 1,

    -- How long after the default start date (July 9, 1993) that plumbing fixtures (eg. sinks) stop being infinite sources of water. Default = 0 - 30 Days
    -- 1 = Instant
    -- 2 = 0 - 30 Days
    -- 3 = 0 - 2 Months
    -- 4 = 0 - 6 Months
    -- 5 = 0 - 1 Year
    -- 6 = 0 - 5 Years
    -- 7 = 2 - 6 Months
    -- 8 = 6 - 12 Months
    -- 9 = Disabled
    WaterShut = 3,

    -- How long after the default start date (July 9, 1993) that the world's electricity turns off for good. Default = 14 - 30 Days
    -- 1 = Instant
    -- 2 = 14 - 30 Days
    -- 3 = 14 Days - 2 Months
    -- 4 = 14 Days - 6 Months
    -- 5 = 14 Days - 1 Year
    -- 6 = 14 Days - 5 Years
    -- 7 = 2 - 6 Months
    -- 8 = 6 - 12 Months
    -- 9 = Disabled
    ElecShut = 3,

    -- How long alarm batteries can last for after the power shuts off. Default = 0 - 30 Days
    -- 1 = Instant
    -- 2 = 0 - 30 Days
    -- 3 = 0 - 2 Months
    -- 4 = 0 - 6 Months
    -- 5 = 0 - 1 Year
    -- 6 = 0 - 5 Years
    AlarmDecay = 2,

    -- How long after the default start date (July 9, 1993) that plumbing fixtures (eg. sinks) stop being infinite sources of water. Min: -1 Max: 2147483647 Default: 14
    WaterShutModifier = 14,

    -- How long after the default start date (July 9, 1993) that the world's electricity turns off for good. Min: -1 Max: 2147483647 Default: 14
    ElecShutModifier = 14,

    -- How long alarm batteries can last for after the power shuts off. Min: -1 Max: 2147483647 Default: 14
    AlarmDecayModifier = 14,

    -- Any food that can rot or spoil. Min: 0.00 Max: 4.00 Default: 0.80
    FoodLootNew = 0.8,

    -- All other items that can be read, including books, fliers, and newspapers. Min: 0.00 Max: 4.00 Default: 0.60
    LiteratureLootNew = 0.6,

    -- Books that provide skill XP multipliers. Min: 0.00 Max: 4.00 Default: 0.60
    SkillBookLoot = 0.6,

    -- Items that teach recipes. Min: 0.00 Max: 4.00 Default: 0.60
    RecipeResourceLoot = 0.6,

    -- Medicine, bandages and first aid tools. Min: 0.00 Max: 4.00 Default: 0.60
    MedicalLootNew = 0.6,

    -- Fishing Rods, Tents, camping gear etc. Min: 0.00 Max: 4.00 Default: 0.60
    SurvivalGearsLootNew = 0.6,

    -- Canned and dried food, beverages. Min: 0.00 Max: 4.00 Default: 0.60
    CannedFoodLootNew = 0.6,

    -- Weapons that are not tools in other categories. Min: 0.00 Max: 4.00 Default: 0.60
    WeaponLootNew = 0.6,

    -- Also includes weapon attachments. Min: 0.00 Max: 4.00 Default: 1.20
    RangedWeaponLootNew = 1.2,

    -- Loose ammo, boxes and magazines. Min: 0.00 Max: 4.00 Default: 0.60
    AmmoLootNew = 0.6,

    -- Vehicle parts and the tools needed to install them. Min: 0.00 Max: 4.00 Default: 0.60
    MechanicsLootNew = 0.6,

    -- Everything else. Also affects foraging for all items in Town/Road zones. Min: 0.00 Max: 4.00 Default: 0.80
    OtherLootNew = 0.8,

    -- All wearable items that are not containers. Min: 0.00 Max: 4.00 Default: 0.60
    ClothingLootNew = 0.6,

    -- Backpacks and other wearable/equippable containers, eg. cases. Min: 0.00 Max: 4.00 Default: 0.60
    ContainerLootNew = 0.6,

    -- Keys for buildings/cars, key rings, and locks. Min: 0.00 Max: 4.00 Default: 0.40
    KeyLootNew = 0.4,

    -- VHS tapes and CDs. Min: 0.00 Max: 4.00 Default: 0.60
    MediaLootNew = 0.6,

    -- Spiffo items, plushies, and other collectible keepsake items eg. Photos. Min: 0.00 Max: 4.00 Default: 0.60
    MementoLootNew = 0.4,

    -- Items that are used in cooking, including those (eg. knives) which can be weapons. Does not include food. Includes both usable and unusable items. Min: 0.00 Max: 4.00 Default: 0.60
    CookwareLootNew = 0.6,

    -- Items and weapons that are used as ingredients for crafting or building. This is a general category that does not include items belonging to other categories such as Cookware or Medical. Does not include Tools. Min: 0.00 Max: 4.00 Default: 0.60
    MaterialLootNew = 0.6,

    -- Items and weapons which are used in both animal and plant agriculture, such as Seeds, Trowels, or Shovels. Min: 0.00 Max: 4.00 Default: 0.60
    FarmingLootNew = 0.6,

    -- Items and weapons which are Tools but don't fit in other categories such as Mechanics or Farming. Min: 0.00 Max: 4.00 Default: 0.60
    ToolLootNew = 0.6,

    -- <BHC> [!] It is recommended that you DO NOT change this. [!] <RGB:1,1,1>   Can be used to adjust the number of rolls made on loot tables when spawning loot. Will not reduce the number of rolls below 1. Can negatively affect performance if set to high values. It is highly recommended that this not be changed. Min: 0.10 Max: 100.00 Default: 1.00
    RollsMultiplier = 1.0,

    -- A comma-separated list of item types that won't spawn as ordinary loot.
    LootItemRemovalList = "",

    -- If enabled, items on the Loot Item Removal List, or that have their rarity set to 'None', will not spawn in randomised world stories.
    RemoveStoryLoot = false,

    -- If enabled, items on the Loot Item Removal List, or that have their rarity set to 'None', will not spawn worn by, or attached to, zombies.
    RemoveZombieLoot = false,

    -- If greater than 0, the spawn of loot is increased relative to the number of nearby zombies,  with the effect multiplied by this number. Min: 0 Max: 20 Default: 0
    ZombiePopLootEffect = 0,

    -- Min: 0.00 Max: 0.20 Default: 0.05
    InsaneLootFactor = 0.05,

    -- Min: 0.05 Max: 0.60 Default: 0.20
    ExtremeLootFactor = 0.2,

    -- Min: 0.20 Max: 1.00 Default: 0.60
    RareLootFactor = 0.6,

    -- Min: 0.60 Max: 2.00 Default: 1.00
    NormalLootFactor = 1.0,

    -- Min: 1.00 Max: 3.00 Default: 2.00
    CommonLootFactor = 2.0,

    -- Min: 2.00 Max: 4.00 Default: 3.00
    AbundantLootFactor = 3.0,

    -- The global temperature. Default = Normal
    -- 1 = Very Cold
    -- 2 = Cold
    -- 3 = Normal
    -- 4 = Hot
    -- 5 = Very Hot
    Temperature = 3,

    -- How often it rains. Default = Normal
    -- 1 = Very Dry
    -- 2 = Dry
    -- 3 = Normal
    -- 4 = Rainy
    -- 5 = Very Rainy
    Rain = 3,

    -- Number of days until the erosion system (which adds vines, long grass, new trees etc. to the world) will reach 100% growth. Default = Slow (200 Days)
    -- 1 = Very Fast (20 Days)
    -- 2 = Fast (50 Days)
    -- 3 = Normal (100 Days)
    -- 4 = Slow (200 Days)
    -- 5 = Very Slow (500 Days)
    ErosionSpeed = 4,

    -- For a custom Erosion Speed. Zero means use the Erosion Speed option. Maximum is 36,500 days (approximately 100 years). Min: -1 Max: 36500 Default: 0
    ErosionDays = 0,

    -- The speed of plant growth. Default = Normal
    -- 1 = Very Fast
    -- 2 = Fast
    -- 3 = Normal
    -- 4 = Slow
    -- 5 = Very Slow
    Farming = 3,

    -- How long it takes for food to break down in a composter. Default = 2 Weeks
    -- 1 = 1 Week
    -- 2 = 2 Weeks
    -- 3 = 3 Weeks
    -- 4 = 4 Weeks
    -- 5 = 6 Weeks
    -- 6 = 8 Weeks
    -- 7 = 10 Weeks
    -- 8 = 12 Weeks
    CompostTime = 2,

    -- How fast the player's hunger, thirst, and fatigue will decrease. Default = Normal
    -- 1 = Very Fast
    -- 2 = Fast
    -- 3 = Normal
    -- 4 = Slow
    -- 5 = Very Slow
    StatsDecrease = 3,

    -- The abundance of items found in Foraging mode. Default = Normal
    -- 1 = Very Poor
    -- 2 = Poor
    -- 3 = Normal
    -- 4 = Abundant
    -- 5 = Very Abundant
    NatureAbundance = 3,

    -- How likely the player is to activate a house alarm when breaking into a new house. Default = Sometimes
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    Alarm = 4,

    -- How frequently the doors of homes and buildings will be locked when discovered. Default = Very Often
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    LockedHouses = 5,

    -- Spawn with Chips, a Water Bottle, a Small Backpack, a Baseball Bat, and a Hammer.
    StarterKit = false,

    -- Nutritional value of food affects the player's condition. Turning this off will stop the player gaining or losing weight.
    Nutrition = true,

    -- How fast that food will spoil, inside or outside of a fridge. Default = Normal
    -- 1 = Very Fast
    -- 2 = Fast
    -- 3 = Normal
    -- 4 = Slow
    -- 5 = Very Slow
    FoodRotSpeed = 3,

    -- How effective a fridge will be at keeping food fresh for longer. Default = Normal
    -- 1 = Very Low
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    -- 6 = No decay
    FridgeFactor = 3,

    -- When greater than 0, loot will not respawn in zones that have been visited within this number of in-game hours. Min: 0 Max: 2147483647 Default: 0
    SeenHoursPreventLootRespawn = 0,

    -- When greater than 0, after X hours, all containers in towns and trailer parks in the world will respawn loot. To spawn loot a container must have been looted at least once. Loot respawn is not impacted by visibility or subsequent looting. Min: 0 Max: 2147483647 Default: 0
    HoursForLootRespawn = 0,

    -- Containers with a number of items greater, or equal to, this setting will not respawn. Min: 0 Max: 2147483647 Default: 5
    MaxItemsForLootRespawn = 5,

    -- Items will not respawn in buildings that players have barricaded or built in.
    ConstructionPreventsLootRespawn = true,

    -- A comma-separated list of item types that will be removed after HoursForWorldItemRemoval hours.
    WorldItemRemovalList = "Base.Hat, Base.Glasses, Base.Maggots, Base.Slug, Base.Slug2, Base.Snail, Base.Worm, Base.Dung_Mouse, Base.Dung_Rat",

    -- Number of hours since an item was dropped on the ground before it is removed.  Items are removed the next time that part of the map is loaded.   Zero means items are not removed. Min: 0.00 Max: 2147483647.00 Default: 24.00
    HoursForWorldItemRemoval = 24.0,

    -- If true, any items *not* in WorldItemRemovalList will be removed.
    ItemRemovalListBlacklistToggle = false,

    -- How long after the end of the world to begin. This will affect starting world erosion and food spoilage. Does not affect the starting date. Default = 0
    -- 1 = 0
    -- 2 = 1
    -- 3 = 2
    -- 4 = 3
    -- 5 = 4
    -- 6 = 5
    -- 7 = 6
    -- 8 = 7
    -- 9 = 8
    -- 10 = 9
    -- 11 = 10
    -- 12 = 11
    -- 13 = 12
    TimeSinceApo = 1,

    -- How much water plants will lose per day, and their ability to avoid disease. Default = Normal
    -- 1 = Very High
    -- 2 = High
    -- 3 = Normal
    -- 4 = Low
    -- 5 = Very Low
    PlantResilience = 3,

    -- The yield of plants when harvested. Default = Normal
    -- 1 = Very Poor
    -- 2 = Poor
    -- 3 = Normal
    -- 4 = Abundant
    -- 5 = Very Abundant
    PlantAbundance = 3,

    -- Recovery from being tired after performing actions. Default = Normal
    -- 1 = Very Fast
    -- 2 = Fast
    -- 3 = Normal
    -- 4 = Slow
    -- 5 = Very Slow
    EndRegen = 3,

    -- How regularly a helicopter passes over the Event Zone. Default = Once
    -- 1 = Never
    -- 2 = Once
    -- 3 = Sometimes
    -- 4 = Often
    Helicopter = 2,

    -- How often zombie-attracting metagame events like distant gunshots will occur. Default = Sometimes
    -- 1 = Never
    -- 2 = Sometimes
    -- 3 = Often
    MetaEvent = 2,

    -- How often events during the player's sleep, like nightmares, occur. Default = Never
    -- 1 = Never
    -- 2 = Sometimes
    -- 3 = Often
    SleepingEvent = 2,

    -- How much fuel is consumed by generators per in-game hour. Min: 0.00 Max: 100.00 Default: 0.10
    GeneratorFuelConsumption = 0.1,

    -- The chance of electrical generators spawning on the map. Default = Rare
    -- 1 = None (not recommended)
    -- 2 = Insanely Rare
    -- 3 = Extremely Rare
    -- 4 = Rare
    -- 5 = Normal
    -- 6 = Common
    -- 7 = Abundant
    GeneratorSpawning = 4,

    -- How often a looted map will have notes on it, written by a deceased survivor. Default = Sometimes
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    AnnotatedMapChance = 4,

    -- Adds free points during character creation. Min: -100 Max: 100 Default: 0
    CharacterFreePoints = 0,

    -- Gives player-built constructions extra hit points so they are  more resistant to zombie damage. Default = Normal
    -- 1 = Very Low
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    ConstructionBonusPoints = 3,

    -- The level of ambient lighting at night. Default = Normal
    -- 1 = Pitch Black
    -- 2 = Dark
    -- 3 = Normal
    -- 4 = Bright
    NightDarkness = 3,

    -- The time from dusk to dawn. Default = Normal
    -- 1 = Always Night
    -- 2 = Long
    -- 3 = Normal
    -- 4 = Short
    -- 5 = Always Day
    NightLength = 3,

    -- If survivors can get broken limbs from impacts, zombie damage, falls etc.
    BoneFracture = true,

    -- The impact that injuries have on your body, and their healing time. Default = Normal
    -- 1 = Low
    -- 2 = Normal
    -- 3 = High
    InjurySeverity = 2,

    -- How long, in hours, before dead zombie bodies disappear from the world.  If 0, maggots will not spawn on corpses. Min: -1.00 Max: 2147483647.00 Default: 216.00
    HoursForCorpseRemoval = 216.0,

    -- The impact that nearby decaying bodies has on the player's health and emotions. Default = Normal
    -- 1 = None
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Insane
    DecayingCorpseHealthImpact = 3,

    -- Whether nearby "living" zombies have the same impact on the player's health and emotions.
    ZombieHealthImpact = false,

    -- How much blood is sprayed on floors and walls by injuries. Default = Normal
    -- 1 = None
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Ultra Gore
    BloodLevel = 3,

    -- How quickly clothing degrades, becomes dirty, and bloodied. Default = Normal
    -- 1 = Disabled
    -- 2 = Slow
    -- 3 = Normal
    -- 4 = Fast
    ClothingDegradation = 3,

    -- If fires spread when started.
    FireSpread = true,

    -- Number of in-game days before rotten food is removed from the map.  -1 means rotten food is never removed. Min: -1 Max: 2147483647 Default: -1
    DaysForRottenFoodRemoval = -1,

    -- If enabled, generators will work on exterior tiles.  This will allow, for example, the powering of gas pumps.
    AllowExteriorGenerator = true,

    -- Maximum intensity of fog. Default = Normal
    -- 1 = Normal
    -- 2 = Moderate
    -- 3 = Low
    -- 4 = None
    MaxFogIntensity = 1,

    -- Maximum intensity of rain. Default = Normal
    -- 1 = Normal
    -- 2 = Moderate
    -- 3 = Low
    MaxRainFxIntensity = 1,

    -- If snow will accumulate on the ground.  If disabled, snow will still show on vegetation and rooftops.
    EnableSnowOnGround = true,

    -- If melee attacking slows you down.
    AttackBlockMovements = true,

    -- The chance of finding randomized buildings on the map (eg. burnt out houses,  ones containing loot stashes or dead bodies). Default = Rare
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    -- 7 = Always Tries
    SurvivorHouseChance = 3,

    -- The chance of road stories (eg. police roadblocks) spawning. Default = Rare
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    -- 7 = Always Tries
    VehicleStoryChance = 3,

    -- The chance of stories specific to map zones (eg. a campsite in a forest) spawning. Default = Rare
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    -- 7 = Always Tries
    ZoneStoryChance = 3,

    -- Allows you to select from every piece of clothing in the game when customizing your character
    AllClothesUnlocked = true,

    -- If tainted water will show a warning marking it as such.
    EnableTaintedWaterText = true,

    -- If vehicles will spawn.
    EnableVehicles = true,

    -- How frequently vehicles can be discovered on the map. Default = Low
    -- 1 = None
    -- 2 = Very Low
    -- 3 = Low
    -- 4 = Normal
    -- 5 = High
    CarSpawnRate = 3,

    -- General engine loudness to zombies. Min: 0.00 Max: 100.00 Default: 1.00
    ZombieAttractionMultiplier = 1.0,

    -- Whether found vehicles are locked, need keys to start etc.
    VehicleEasyUse = false,

    -- How full the gas tank of discovered vehicles will be. Default = Low
    -- 1 = Very Low
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    -- 6 = Full
    InitialGas = 2,

    -- If enabled, gas pumps will never run out of fuel
    FuelStationGasInfinite = false,

    -- The minimum amount of gasoline that can spawn in gas pumps. Check the "Advanced" box below to use a custom amount. Min: 0.00 Max: 1.00 Default: 0.00
    FuelStationGasMin = 0.0,

    -- The maximum amount of gasoline that can spawn in gas pumps. Check the "Advanced" box below to use a custom amount. Min: 0.00 Max: 1.00 Default: 0.80
    FuelStationGasMax = 1.0,

    -- The chance, as a percentage, that individual gas pumps will initially have no fuel. Min: 0 Max: 100 Default: 20
    FuelStationGasEmptyChance = 15,

    -- How likely cars will be locked Default = Sometimes
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    LockedCar = 4,

    -- How gas-hungry vehicles are. Min: 0.00 Max: 100.00 Default: 1.00
    CarGasConsumption = 1.0,

    -- General condition discovered vehicles will be in. Default = Normal
    -- 1 = Very Low
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    CarGeneralCondition = 3,

    -- The amount of damage dealt to vehicles that crash. Default = Normal
    -- 1 = Very Low
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    CarDamageOnImpact = 3,

    -- Damage received by the player from being crashed into. Default = None
    -- 1 = None
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    -- 5 = Very High
    DamageToPlayerFromHitByACar = 1,

    -- If traffic jams consisting of wrecked cars  will appear on main roads.
    TrafficJam = true,

    -- How frequently discovered vehicles have active alarms. Default = Rare
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    CarAlarm = 3,

    -- If the player can get injured from being in a car accident.
    PlayerDamageFromCrash = true,

    -- How many in-game hours before a wailing siren shuts off. Min: 0.00 Max: 168.00 Default: 0.00
    SirenShutoffHours = 0.0,

    -- The chance of finding a vehicle with gas in its tank. Default = Normal
    -- 1 = Low
    -- 2 = Normal
    -- 3 = High
    ChanceHasGas = 2,

    -- Whether a player can discover a car that has been cared for  after the Knox infection struck. Default = Low
    -- 1 = None
    -- 2 = Low
    -- 3 = Normal
    -- 4 = High
    RecentlySurvivorVehicles = 2,

    -- If certain melee weapons will be able to strike multiple zombies in one hit.
    MultiHitZombies = true,

    -- Chance of being bitten when a zombie attacks from behind. Default = High
    -- 1 = Low
    -- 2 = Medium
    -- 3 = High
    RearVulnerability = 3,

    -- If zombies will head towards the sound of vehicle sirens.
    SirenEffectsZombies = true,

    -- Speed at which animals stats (hunger, thirst etc.) reduce. Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalStatsModifier = 4,

    -- Speed at which animals stats (hunger, thirst etc.) reduce while in meta. Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalMetaStatsModifier = 4,

    -- How long animals will be pregnant for before giving birth. Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalPregnancyTime = 4,

    -- Speed at which animals age. Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalAgeModifier = 4,

    -- Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalMilkIncModifier = 4,

    -- Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalWoolIncModifier = 4,

    -- The chance of finding animals in farm. Default = Often
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    -- 7 = Always
    AnimalRanchChance = 5,

    -- The number of hours grass will regrow after being  eaten by an animal or cut by the player. Min: 1 Max: 9999 Default: 240
    AnimalGrassRegrowTime = 240,

    -- If a meta (ie. not actually visible in-game) fox may attack  your chickens if the hutch's door is left open at night.
    AnimalMetaPredator = true,

    -- If on, animals will only mate during their breeding season (if any).  Otherwise they can reproduce/lay eggs all year round.
    AnimalMatingSeason = true,

    -- How long before baby animals will hatch from eggs. Default = Normal
    -- 1 = Ultra Fast
    -- 2 = Very Fast
    -- 3 = Fast
    -- 4 = Normal
    -- 5 = Slow
    -- 6 = Very Slow
    AnimalEggHatch = 4,

    -- If true, animal calls will attract nearby zombies.
    AnimalSoundAttractZombies = true,

    -- The chance of animals leaving tracks. Default = Sometimes
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    AnimalTrackChance = 4,

    -- The chance of creating a path for animals to be hunted. Default = Sometimes
    -- 1 = Never
    -- 2 = Extremely Rare
    -- 3 = Rare
    -- 4 = Sometimes
    -- 5 = Often
    -- 6 = Very Often
    AnimalPathChance = 4,

    -- The frequency and intensity of eg. rats in infested buildings. Min: 0 Max: 50 Default: 25
    MaximumRatIndex = 25,

    -- How long it takes for the Maximum Vermin Index to be reached. Min: 0 Max: 365 Default: 90
    DaysUntilMaximumRatIndex = 90,

    -- If a piece of media hasn't been fully seen or read, this setting determines whether it's displayed fully, displayed as "???", or hidden completely. Default = Completely hidden
    -- 1 = Fully revealed
    -- 2 = Shown as ???
    -- 3 = Completely hidden
    MetaKnowledge = 3,

    -- If true, you will be able to see any recipes that can be done with a station, even if you haven't learnt them yet.
    SeeNotLearntRecipe = true,

    -- If a building has more than this amount of rooms it will not be looted. Min: 0 Max: 200 Default: 50
    MaximumLootedBuildingRooms = 50,

    -- If poison can be added to food. Default = True
    -- 1 = True
    -- 2 = False
    -- 3 = Only bleach poisoning is disabled
    EnablePoisoning = 1,

    -- If/when maggots can spawn in corpses. Default = In and Around Bodies
    -- 1 = In and Around Bodies
    -- 2 = In Bodies Only
    -- 3 = Never
    MaggotSpawn = 1,

    -- The higher the value, the longer lightbulbs last before breaking.  If 0, lightbulbs will never break.  Does not affect vehicle headlights. Min: 0.00 Max: 1000.00 Default: 2.00
    LightBulbLifespan = 2.0,

    -- The abundance of fish in rivers and lakes. Default = Poor
    -- 1 = Very Poor
    -- 2 = Poor
    -- 3 = Normal
    -- 4 = Abundant
    -- 5 = Very Abundant
    FishAbundance = 2,

    -- When a skill is at this level or above, television/VHS/other media  will not provide XP for it. Min: 0 Max: 10 Default: 3
    LevelForMediaXPCutoff = 6,

    -- When a skill is at this level or above, scrapping furniture does not provide XP for the relevant skill. Does not apply to Electrical. Min: 0 Max: 10 Default: 0
    LevelForDismantleXPCutoff = 3,

    -- Number of days before old blood splats are removed. Removal happens when map chunks are loaded. 0 means they will never disappear. Min: 0 Max: 365 Default: 0
    BloodSplatLifespanDays = 0,

    -- Number of days before one can benefit from reading previously read literature items. Min: 1 Max: 365 Default: 45
    LiteratureCooldown = 45,

    -- If there are diminishing returns on bonus trait points provided from selecting multiple negative traits. Default = None
    -- 1 = None
    -- 2 = 1 point penalty for every 3 negative traits selected
    -- 3 = 1 point penalty for every 2 negative traits selected
    -- 4 = 1 point penalty for every negative trait selected after the first
    NegativeTraitsPenalty = 1,

    -- The number of in-game minutes it takes to read one page of a skill book. Min: 0.00 Max: 60.00 Default: 2.00
    MinutesPerPage = 2.0,

    -- When enabled, crops and herbs grown inside buildings will die. Does not affect houseplants.
    KillInsideCrops = true,

    -- When enabled, the growth of plants is affected by seasons.
    PlantGrowingSeasons = true,

    -- <BHC> [!] It is recommended that you DO NOT change this. Changing this can result in performance issues. [!] <RGB:1,1,1>   When enabled, dirt can be placed, and farming performed on other than the ground level.
    PlaceDirtAboveground = false,

    -- The speed of plant growth. Min: 0.10 Max: 100.00 Default: 1.00
    FarmingSpeedNew = 1.0,

    -- The abundance of harvested crops. Min: 0.10 Max: 10.00 Default: 1.00
    FarmingAmountNew = 1.0,

    -- The chance that any building will already be looted when found. Check the "Advanced" box below to use a custom number. Min: 0 Max: 200 Default: 25
    MaximumLooted = 25,

    -- How long it takes for Maximum Looted Building Chance to be reached. Min: 0 Max: 3650 Default: 90
    DaysUntilMaximumLooted = 90,

    -- The chance that any rural building will already be looted when found. Check the "Advanced" box below to use a custom number. Min: 0.00 Max: 2.00 Default: 0.50
    RuralLooted = 0.5,

    -- The maximum loot that won't spawn when Days Until Maximum Diminished Loot is reached. Check the "Advanced" box below to use an exact percentage. Min: 0 Max: 100 Default: 20
    MaximumDiminishedLoot = 20,

    -- How long it takes for Maximum Diminished Loot Percentage to be reached. Min: 0 Max: 3650 Default: 3650
    DaysUntilMaximumDiminishedLoot = 3650,

    -- Functions as a multiplier when applying muscle strain from swinging weapons or carrying heavy loads. Min: 0.00 Max: 10.00 Default: 0.70
    MuscleStrainFactor = 0.6,

    -- Functions as a multiplier when applying discomfort from worn items. Min: 0.00 Max: 10.00 Default: 0.80
    DiscomfortFactor = 0.7,

    -- If greater than zero damage can be taken from serious wound infections. Min: 0.00 Max: 10.00 Default: 1.00
    WoundInfectionFactor = 1.0,

    -- If true clothing with randomized tints will not be so dark to be virtually black.
    NoBlackClothes = true,

    -- Disables the failure chances when climbing sheet ropes or over walls.
    EasyClimbing = false,

    -- The maximum hours of fuel that can be placed in a campfire, wood stove etc. Min: 1 Max: 168 Default: 8
    MaximumFireFuelHours = 8,

    -- Replaces Chance-To-Hit mechanics with Chance-To-Damage calculations.  This mode prioritizes player aiming. Default = Zombies only
    -- 1 = Disabled
    -- 2 = Zombies only
    -- 3 = All types of target
    FirearmUseDamageChance = 3,

    -- A multiplier for the distance at which zombies can hear gunshots. Min: 0.20 Max: 2.00 Default: 1.00
    FirearmNoiseMultiplier = 1.0,

    -- Multiplier for firearm jamming chance. 0 disables jamming. Min: 0.00 Max: 10.00 Default: 1.00
    FirearmJamMultiplier = 1.0,

    -- Multiplier for Moodle effects on hit chance. 0 disables Moodle penalty. Min: 0.00 Max: 10.00 Default: 1.00
    FirearmMoodleMultiplier = 1.0,

    -- Multiplier for the effects of weather (wind, rain and fog) on hit chance. 0 disables weather effect. Min: 0.00 Max: 10.00 Default: 1.00
    FirearmWeatherMultiplier = 1.0,

    -- Enable to have headgear like welding masks affect hit chance
    FirearmHeadGearEffect = true,

    -- Chance to turn a dirt floor into a clay floor. Applies to lakes. Min: 0.00 Max: 1.00 Default: 0.05
    ClayLakeChance = 0.05,

    -- Chance to turn a dirt floor into a clay floor. Applies to rivers. Min: 0.00 Max: 1.00 Default: 0.05
    ClayRiverChance = 0.05,

    -- Min: 1 Max: 100 Default: 20
    GeneratorTileRange = 30,

    -- How many levels both above and below a generator it can provide with electricity. Min: 1 Max: 15 Default: 3
    GeneratorVerticalPowerRange = 5,

    -- Parts with a success chance below this value will be skipped during training. <LINE> At '-1' this setting is not enforced, any value over '-1' is enforced server-wide. <LINE>  <LINE> 0% -> All parts will be worked on. Parts will break at lower skill levels. <LINE> 30% -> Default setting for a good balance. <LINE> 100% -> Only parts that are guaranteed to succeed will be worked on. Completely safe at all skill levels. Min: -1 Max: 100 Default: -1
    BAM_Server_MinSuccessChance = -1,

    -- Toggle whether the Engine Rebuild action is available in-game. (If Project Summer Car or another engine repair mod is enabled, this setting does nothing)
    VRO_EnableEngineRebuild = false,

    -- Use the original repair system that allows repairs to be done standing in place, doesn't use a welding mask, any sounds or animations.
    VRO_UseVanillaFixingRecipes = false,

    -- When enabled, repairing a part no longer increases its repair counter, so repairs never get progressively harder or less effective. (If the Old Repair System is enabled, this setting does nothing)
    VRO_DisableDiminishingRepairs = false,

    -- When enabled, parts at 0 condition can be repaired, whether loose in your inventory or installed on a vehicle. Windows and tire parts are excluded and still can't be repaired once fully broken. (If the Old Repair System is enabled, this setting does nothing)
    VRO_RepairFullyBrokenParts = false,

    -- When enabled, parts that normally require another part to be uninstalled first — like brakes or suspension under a tire, or a window with armor on it — can be repaired without removing that part first. (If the Old Repair System is enabled, this setting does nothing)
    VRO_DisableUninstallRequirement = false,

    -- Allow repair materials and tools stored in adjacent containers you can reach to be used without moving them into your inventory first.
    VRO_UseNearbyContainers = true,

    -- Allow repair materials and tools lying on the ground within reach to be used.
    VRO_SearchNearbyGroundItems = true,

    VSO_EnableFullVehicleSalvaging = true,

    -- How long it takes to salvage doors. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Doors = 600,

    -- How long it takes to salvage military / large doors. Higher is slower. Default 700. Min: 1 Max: 5000 Default: 700
    VSO_SalvageTime_DoorsMilitary = 700,

    -- How long it takes to salvage trunk doors. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_TrunkDoors = 500,

    -- How long it takes to salvage hoods / metal covers. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Hoods = 600,

    -- How long it takes to salvage military hoods / armor. Higher is slower. Default 800. Min: 1 Max: 5000 Default: 800
    VSO_SalvageTime_HoodsMilitary = 800,

    -- How long it takes to salvage wooden parts. Higher is slower. Default 700. Min: 1 Max: 5000 Default: 700
    VSO_SalvageTime_Wooden = 700,

    -- How long it takes to salvage gas tanks. Higher is slower. Default 700. Min: 1 Max: 5000 Default: 700
    VSO_SalvageTime_GasTanks = 700,

    -- How long it takes to salvage small gas tanks. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_GasTanksSmall = 500,

    -- How long it takes to salvage mufflers. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_Mufflers = 500,

    -- How long it takes to salvage suspension. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_Suspension = 500,

    -- How long it takes to salvage brakes. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Brakes = 600,

    -- How long it takes to salvage seats. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Seats = 600,

    -- How long it takes to salvage tires. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Tires = 600,

    -- How long it takes to salvage bars (bullbars / roofracks). Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Bars = 600,

    -- How long it takes to salvage saddlebags / misc fabrics. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_SaddlebagsFabric = 600,

    -- How long it takes to salvage hard saddlebags. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_SaddlebagsHard = 600,

    -- How long it takes to salvage soft-tops. Higher is slower. Default 300. Min: 1 Max: 5000 Default: 300
    VSO_SalvageTime_SoftTops = 300,

    -- How long it takes to salvage small misc panels. Higher is slower. Default 600. Min: 1 Max: 5000 Default: 600
    VSO_SalvageTime_Panels = 600,

    -- How long it takes to salvage large container tanks. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_ContainerTanks = 500,

    -- How long it takes to salvage electronics. Higher is slower. Default 500. Min: 1 Max: 5000 Default: 500
    VSO_SalvageTime_Electronics = 500,

    -- Controls how often DrugTime items appear in the world. Default = Rare
    -- 1 = Very Rare
    -- 2 = Rare
    -- 3 = Normal
    -- 4 = Frequent
    -- 5 = Very Frequent
    DrugTime89_LootRarity = 2,

    -- Controls how often zombies drop DrugTime items on death. Default = Rare
    -- 1 = Very Rare
    -- 2 = Rare
    -- 3 = Normal
    -- 4 = Frequent
    -- 5 = Very Frequent
    DrugTime89_ZombieLootRarity = 2,

    -- Enables DrugTime debug logs in the console. Keep disabled unless testing.
    DrugTime89_DebugLogs = false,

    -- Controls how long DrugTime drug effects remain active after consumption: Fast x0.5, Normal x1, Long x5, Very long x10. Default = Normal (x1)
    -- 1 = Fast (x0.5)
    -- 2 = Normal (x1)
    -- 3 = Long (x5)
    -- 4 = Very long (x10)
    DrugTime89_EffectDuration = 2,

    -- Controls smoking action time for DrugTime joints and for cannabis or hash smoked with a pipe. Default = Normal (x1)
    -- 1 = Normal (x1)
    -- 2 = Long (x5)
    -- 3 = Very long (x10)
    DrugTime89_SoftActionDuration = 1,

    -- Controls the action time when smoking crack or crystal meth with a pipe. Default = Normal (x1)
    -- 1 = Normal (x1)
    -- 2 = Long (x5)
    -- 3 = Very long (x10)
    DrugTime89_HardActionDuration = 1,

    -- Enables DrugTime smoke effects when the character smokes cigarettes, cigars, cigarillos and other compatible smokable products, including those added by other mods. Disabled: smoke effects remain limited to DrugTime products. Enabled: smoke effects also apply to other compatible smokable products.
    DrugTime89_SmokeFXVanilla = false,
    Basement = {

        -- How frequently basements spawn at random locations. Default = Sometimes
        -- 1 = Never
        -- 2 = Extremely Rare
        -- 3 = Rare
        -- 4 = Sometimes
        -- 5 = Often
        -- 6 = Very Often
        -- 7 = Always
        SpawnFrequency = 4,
    },
    Map = {

        -- If enabled, a mini-map window will be available.
        AllowMiniMap = false,

        -- If enabled, the world map can be accessed.
        AllowWorldMap = true,

        -- If enabled, the world map will be completely filled in on starting the game.
        MapAllKnown = false,

        -- If enabled, maps can't be read unless there's a source of light available.
        MapNeedsLight = true,
    },
    ZombieLore = {

        -- How fast zombies move. Default = Random
        -- 1 = Sprinters
        -- 2 = Fast Shamblers
        -- 3 = Shamblers
        -- 4 = Random
        Speed = 4,

        -- If Random Speed is enabled, this controls what percentage of zombies are Sprinters. Check the "Advanced" box below to use a custom percentage. Min: 0 Max: 100 Default: 0
        SprinterPercentage = 2,

        -- The damage zombies inflict per attack. Default = Normal
        -- 1 = Superhuman
        -- 2 = Normal
        -- 3 = Weak
        -- 4 = Random
        Strength = 2,

        -- The difficulty of killing a zombie. Default = Random
        -- 1 = Tough
        -- 2 = Normal
        -- 3 = Fragile
        -- 4 = Random
        Toughness = 4,

        -- How the Knox Virus spreads. Default = Blood and Saliva
        -- 1 = Blood and Saliva
        -- 2 = Saliva Only
        -- 3 = Everyone's Infected
        -- 4 = None
        Transmission = 1,

        -- How quickly the infection takes effect. Default = 2-3 Days
        -- 1 = Instant
        -- 2 = 0-30 Seconds
        -- 3 = 0-1 Minutes
        -- 4 = 0-12 Hours
        -- 5 = 2-3 Days
        -- 6 = 1-2 Weeks
        -- 7 = Never
        Mortality = 4,

        -- How quickly infected corpses rise as zombies. Default = 0-1 Minutes
        -- 1 = Instant
        -- 2 = 0-30 Seconds
        -- 3 = 0-1 Minutes
        -- 4 = 0-12 Hours
        -- 5 = 2-3 Days
        -- 6 = 1-2 Weeks
        Reanimate = 3,

        -- Zombie intelligence. Default = Basic Navigation
        -- 1 = Navigate and Use Doors
        -- 2 = Navigate
        -- 3 = Basic Navigation
        -- 4 = Random
        Cognition = 4,

        -- Min: 0 Max: 100 Default: 0
        DoorOpeningPercentage = 2,

        -- How often zombies can crawl under parked vehicles. Default = Often
        -- 1 = Crawlers Only
        -- 2 = Extremely Rare
        -- 3 = Rare
        -- 4 = Sometimes
        -- 5 = Often
        -- 6 = Very Often
        -- 7 = Always
        CrawlUnderVehicle = 5,

        -- How long zombies remember a player after seeing or hearing them. Default = Normal
        -- 1 = Long
        -- 2 = Normal
        -- 3 = Short
        -- 4 = None
        -- 5 = Random
        -- 6 = Random between Normal and None
        Memory = 6,

        -- Zombie vision radius. Default = Random between Normal and Poor
        -- 1 = Eagle
        -- 2 = Normal
        -- 3 = Poor
        -- 4 = Random
        -- 5 = Random between Normal and Poor
        Sight = 5,

        -- Zombie hearing radius. Default = Random between Normal and Poor
        -- 1 = Pinpoint
        -- 2 = Normal
        -- 3 = Poor
        -- 4 = Random
        -- 5 = Random between Normal and Poor
        Hearing = 5,

        -- Activates the new advanced stealth mechanics, which allows you to hide from zombies behind cars, takes traits and weather into account, and much more.
        SpottedLogic = true,

        -- If zombies that have not seen/heard player can attack doors and constructions while roaming.
        ThumpNoChasing = false,

        -- If zombies can destroy player constructions and defenses.
        ThumpOnConstruction = true,

        -- Whether zombies are more "active" during the day or night.  "Active" zombies will use the speed set in the "Speed" setting.  "Inactive" zombies will be slower, and tend not to give chase. Default = Both
        -- 1 = Both
        -- 2 = Night
        -- 3 = Day
        ActiveOnly = 1,

        -- If zombies trigger house alarms when breaking through windows or doors.
        TriggerHouseAlarm = true,

        -- If multiple attacking zombies can drag you down and kill you.  Dependent on zombie strength.
        ZombiesDragDown = true,

        -- If crawler zombies beside a player contribute to the chance of being dragged down and killed by a group of zombies.
        ZombiesCrawlersDragDown = false,

        -- If zombies have a chance to lunge at you after climbing over a fence or through a window if you're too close.
        ZombiesFenceLunge = true,

        -- Serves as a multiplier when determining the effectiveness of armor worn by zombies. Min: 0.00 Max: 100.00 Default: 2.00
        ZombiesArmorFactor = 2.0,

        -- The maximum defense percentage that any worn protective garments can provide to a zombie. Min: 0 Max: 100 Default: 85
        ZombiesMaxDefense = 85,

        -- Percentage chance of having a random attached weapon. Min: 0 Max: 100 Default: 6
        ChanceOfAttachedWeapon = 6,

        -- How much damage zombies take when falling from height. Min: 0.00 Max: 100.00 Default: 1.00
        ZombiesFallDamage = 1.0,

        -- Whether some dead-looking zombies will reanimate and attack the player. Default = World Zombies
        -- 1 = World Zombies
        -- 2 = World and Combat Zombies
        -- 3 = Never
        DisableFakeDead = 1,

        -- Zombies will not spawn where players spawn. Default = Inside the building and around it
        -- 1 = Inside the building and around it
        -- 2 = Inside the building
        -- 3 = Inside the room
        -- 4 = Zombies can spawn anywhere
        PlayerSpawnZombieRemoval = 1,

        -- How many zombies it takes to damage a tall fence. Min: -1 Max: 100 Default: 25
        FenceThumpersRequired = 25,

        -- How quickly zombies damage tall fences. Min: 0.01 Max: 100.00 Default: 1.00
        FenceDamageMultiplier = 1.0,
    },
    ZombieConfig = {

        -- Set by the "Zombie Count" population option, or by a custom number here. Insane = 2.5, Very High = 1.6, High = 1.2, Normal = 0.65, Low = 0.15, None = 0.0. Min: 0.00 Max: 4.00 Default: 0.65
        PopulationMultiplier = 0.65,

        -- A multiplier for the desired zombie population at the start of the game. Insane = 3.0, Very High = 2.0, High = 1.5, Normal = 1.0, Low = 0.5, None = 0.0. Min: 0.00 Max: 4.00 Default: 1.00
        PopulationStartMultiplier = 1.0,

        -- A multiplier for the desired zombie population on the peak day. Insane = 3.0, Very High = 2.0, High = 1.5, Normal = 1.0, Low = 0.5, None = 0.0. Min: 0.00 Max: 4.00 Default: 1.50
        PopulationPeakMultiplier = 3.0,

        -- The day when the population reaches its peak. Min: 1 Max: 365 Default: 28
        PopulationPeakDay = 90,

        -- The number of hours that must pass before zombies may respawn in a cell. If 0, spawning is disabled. Min: 0.00 Max: 8760.00 Default: 0.00
        RespawnHours = 0.0,

        -- The number of hours that a chunk must be unseen before zombies may respawn in it. Min: 0.00 Max: 8760.00 Default: 0.00
        RespawnUnseenHours = 0.0,

        -- The fraction of a cell's desired population that may respawn every RespawnHours. Min: 0.00 Max: 1.00 Default: 0.00
        RespawnMultiplier = 0.0,

        -- The number of hours that must pass before zombies migrate  to empty parts of the same cell. If 0, migration is disabled. Min: 0.00 Max: 8760.00 Default: 12.00
        RedistributeHours = 12.0,

        -- The distance a zombie will try to walk towards the last sound it heard. Min: 10 Max: 1000 Default: 100
        FollowSoundDistance = 100,

        -- The size of groups real zombies form when idle. 0 means zombies don't form groups. Groups don't form inside buildings or forest zones. Min: 0 Max: 1000 Default: 20
        RallyGroupSize = 20,

        -- The amount, as a percentage, that zombie groups can vary in size from the default (both larger and smaller).   For example, at 50% variance with a default group size of 20, groups will vary in size from 10-30. Min: 0 Max: 100 Default: 50
        RallyGroupSizeVariance = 50,

        -- The distance real zombies travel to form groups when idle. Min: 5 Max: 50 Default: 20
        RallyTravelDistance = 20,

        -- The distance between zombie groups. Min: 5 Max: 25 Default: 15
        RallyGroupSeparation = 15,

        -- How close members of a zombie group stay to the group's "leader". Min: 1 Max: 10 Default: 3
        RallyGroupRadius = 3,

        -- Controls the maximum number of zombies tracked before cleanup occurs. 0 means zombies will not be cleaned up. The default value (300) is strongly recommended. Increasing this value or setting to 0 may cause severe performance problems. For troubleshooting and bug-report purposes, please reproduce any issue with the default setting before submitting a report. Min: 0 Max: 5000 Default: 300
        ZombiesCountBeforeDelete = 300,
    },
    MultiplierConfig = {

        -- The rate at which all skills level up. Min: 0.00 Max: 1000.00 Default: 1.00
        Global = 1.5,

        -- When enabled, all skills will use the Global Multiplier.
        GlobalToggle = true,

        -- Rate at which Fitness skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Fitness = 1.0,

        -- Rate at which Strength skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Strength = 1.0,

        -- Rate at which Sprinting skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Sprinting = 1.0,

        -- Rate at which Lightfooted skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Lightfoot = 1.0,

        -- Rate at which Nimble skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Nimble = 1.0,

        -- Rate at which Sneaking skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Sneak = 1.0,

        -- Rate at which Axe skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Axe = 1.0,

        -- Rate at which Long Blunt skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Blunt = 1.0,

        -- Rate at which Short Blunt skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        SmallBlunt = 1.0,

        -- Rate at which Long Blade skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        LongBlade = 1.0,

        -- Rate at which Short Blade skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        SmallBlade = 1.0,

        -- Rate at which Spear skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Spear = 1.0,

        -- Rate at which Maintenance skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Maintenance = 1.0,

        -- Rate at which Carpentry skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Woodwork = 1.0,

        -- Rate at which Cooking skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Cooking = 1.0,

        -- Rate at which Agriculture skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Farming = 1.0,

        -- Rate at which First Aid skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Doctor = 1.0,

        -- Rate at which Electrical skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Electricity = 1.0,

        -- Rate at which Welding skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        MetalWelding = 1.0,

        -- Rate at which Mechanics skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Mechanics = 1.0,

        -- Rate at which Tailoring skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Tailoring = 1.0,

        -- Rate at which Aiming skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Aiming = 1.0,

        -- Rate at which Reloading skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Reloading = 1.0,

        -- Rate at which Fishing skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Fishing = 1.0,

        -- Rate at which Trapping skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Trapping = 1.0,

        -- Rate at which Foraging skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        PlantScavenging = 1.0,

        -- Rate at which Knapping skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        FlintKnapping = 1.0,

        -- Rate at which Masonry skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Masonry = 1.0,

        -- Rate at which Pottery skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Pottery = 1.0,

        -- Rate at which Carving skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Carving = 1.0,

        -- Rate at which Animal Care skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Husbandry = 1.0,

        -- Rate at which Tracking skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Tracking = 1.0,

        -- Rate at which Blacksmithing skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Blacksmith = 1.0,

        -- Rate at which Butchering skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Butchering = 1.0,

        -- Rate at which Glassmaking skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Glassmaking = 1.0,

        -- Rate at which the Lockpicking skill levels up. Default 1. Same scale as the other skill multipliers (0 to 1000). Min: 0.00 Max: 1000.00 Default: 1.00
        Lockpicking = 1.5,

        -- Rate at which Art skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Art = 1.0,

        -- Rate at which Cleaning skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Cleaning = 1.0,

        -- Rate at which Dancing skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Dancing = 1.0,

        -- Rate at which Meditation skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Meditation = 1.0,

        -- Rate at which Music skill levels up. Min: 0.00 Max: 1000.00 Default: 1.00
        Music = 1.0,

        -- Multiplies the XP gained in the Archery skill from landing bow hits. Min: 0.00 Max: 1000.00 Default: 1.00
        Archery = 1.0,

        -- Multiplies the XP gained in the Fletching skill from cutting fletching, carving shafts, binding them and fitting a head. Min: 0.00 Max: 1000.00 Default: 1.00
        Fletching = 1.0,

        -- Used only when the game's global XP multiplier is switched off, like the game's own per-skill multipliers. Min: 0.00 Max: 1000.00 Default: 1.00
        Mining = 1.0,

        -- XP multiplier for the Martial Arts skill. Used when the global XP multiplier is switched off. Min: 0.00 Max: 1000.00 Default: 1.00
        SMA_MartialArts = 1.0,
    },
    KI5GF = {

        -- Raises the MAN KAT1's suspension travel and rest length so it climbs back out of the ground instead of staying sunk, and stiffens it so the extra travel does not turn into a bounce. Turn off to leave the truck exactly as KI5 ships it.
        FixKat1Suspension = false,
    },
    LayeredPlacement = {

        -- Allow players to stack posters and wall decor on the same wall and place ceiling lights over furniture. Floor furniture remains unchanged.
        LayeredPlace = true,

        -- Allow players to place and pick up hanging lights and other high decor on railings, posts, catwalk edges, and other locations without a solid wall or floor.
        FloatingPlace = true,

        -- Allow players upstairs to aim Place and Pickup at their current floor when the cursor falls through a grated floor to the level below.
        MeshFloorAim = true,

        -- Allow Place and Pickup to finish when a player is already near a catwalk or railing tile but normal pathing cannot reach it.
        CatwalkReach = true,
    },
    MedicineMoodles = {

        -- Min: 0 Max: 11 Default: 6
        Antibiotics_Doctor = 3,

        -- Min: 0 Max: 11 Default: 4
        Antidepressants_Doctor = 2,

        -- Min: 0 Max: 11 Default: 2
        BetaBlockers_Doctor = 1,

        -- Min: 0 Max: 11 Default: 1
        Painkillers_Doctor = 0,

        -- Min: 0 Max: 11 Default: 3
        SleepingTablets_Doctor = 1,

        -- Min: 0 Max: 11 Default: 5
        LemonGrass_Doctor = 2,
    },
    AMGeneralTankerFunctionality = {

        -- Multiplier for tanker pump transfer speed. 1 is the default speed. Min: 1 Max: 20 Default: 5
        PumpSpeedMultiplier = 5,

        -- Capacity in litres for the M49A2C fuel cargo tank. Applies to newly loaded vehicles. Min: 500 Max: 6000 Default: 850
        M49A2CCargoTankCapacity = 850,

        -- Capacity in litres for the M50A3 water cargo tank. Applies to newly loaded vehicles. Min: 500 Max: 6000 Default: 850
        M50A3CargoTankCapacity = 850,

        -- Capacity in litres for the M967 fuel cargo tank. Applies to newly loaded vehicles. Min: 1000 Max: 10000 Default: 2000
        M967CargoTankCapacity = 2000,
    },
    RVVFX = {

        -- Temporary marks use the normal RVV lifetime. Persistent marks are saved with the world and remain until weather or RVV cleanup removes them. Safety limits still apply. Default = Temporary
        -- 1 = Temporary
        -- 2 = Persistent
        TireMarkPersistence = 1,
    },
    VFluidLib = {

        -- Distance in which vehicle-to-vehicle fluid transfer works. Min: 2 Max: 40 Default: 6
        TransferRange = 6,

        -- Enables mounted Gas and Water cans to be directly accessible via the vehicle radial menu.
        MountedHandContainers = true,

        -- Allow drinking harmful fluids from a tank.
        DrinkHarmful = false,

        -- Feature not implemented yet.
        PumpsEnabled = false,

        -- Allows refueling and fluid transfer from a hitched trailer to the towing vehicle and where viable in reverse.
        HitchedRefuel = false,

        -- Player can create mixtures that are not compliant with vanilla mixing rules and make a tank compromised and unusable unless drained and cleaned.
        ServiceOverride = false,

        -- Cleaning requirements for tanks. Default = Everything (default)
        -- 1 = Off - draining is enough
        -- 2 = Mixtures only
        -- 3 = Everything (default)
        TankCleaning = 3,

        -- Disable the mixing part of this mod entirely - vehicle storage tanks are single fluid only again.
        VanillaRules = false,

        -- How often a found tank simply holds its own cargo - water in a water tank, fuel in a fuel tank. The five spawn weights are RELATIVE, not percentages: they are normalised against each other, so any values work. Set all five to 0 for tanks that always spawn empty. Min: 0 Max: 100 Default: 35
        SpawnOrigin = 35,

        -- How often a found tank holds one of the curated loads - a milk tanker, a whisky trailer, watered-down milk, a cocktail mix, someone's cleaning stash. Relative weight; see the original-cargo option. Min: 0 Max: 100 Default: 10
        SpawnFlavor = 10,

        -- How often a found tank rolls one or two random fluids, weighted by how common each fluid is. Relative weight; see the original-cargo option. Min: 0 Max: 100 Default: 30
        SpawnMixSmall = 30,

        -- How often a found tank rolls three to five random fluids. Mixes that no service could carry spawn COMPROMISED - sealed until drained and cleaned. Relative weight; see the original-cargo option. Min: 0 Max: 100 Default: 23
        SpawnMixMedium = 23,

        -- How often a found tank rolls a six-to-eight fluid soup. Keep this low or the extraordinary becomes furniture. Relative weight; see the original-cargo option. Min: 0 Max: 100 Default: 2
        SpawnMixLarge = 2,
    },
    DAMN = {

        AllowOinkerSpawns = true,

        AllowPro440Spawns = true,

        AllowDemonChildSpawns = false,

        AllowSuckyMcSuckfaceSpawns = true,

        AllowGreatScottSpawns = false,

        AllowCloudSpawns = true,

        AllowShitSpawns = true,

        AllowEV6spawns = true,

        AllowTBCspawns = true,

        AllowUBCspawns = true,

        AllowWreckyMcChevySpawns = true,

        AllowMrBusSpawns = true,

        AllowChonkerSpawns = true,

        AllowCashcowSpawns = true,

        AllowMcBoxySpawns = true,

        AllowContainerSpawns = true,

        AllowPowerChadSpawns = true,

        AllowManlyMANSpawns = true,

        AlLAV300Spawns = true,
    },
    CompanionDogs = {

        -- How much trust a pet must reach (by feeding) before it becomes your companion. Min: 1 Max: 1000 Default: 100
        TameThreshold = 100,

        -- Maximum number of animals a player can keep bonded at once. 0 = no limit. Min: 0 Max: 30 Default: 0
        MaxCompanions = 0,

        -- Allow pets to attack nearby zombies.
        CombatEnabled = true,

        -- Default damage is 1. 0 means the pet can no longer kill zombies. Min: 0.00 Max: 5.00 Default: 1.00
        DogDamageMultiplier = 1.0,

        -- Turns hunger, thirst, loyalty and stress on or off.
        UpkeepEnabled = true,

        -- Daily hunger and thirst rate. Raise it and the pet eats and drinks more often. Min: 0.00 Max: 5.00 Default: 1.00
        NeedsRateMultiplier = 1.0,

        -- Base loss. A hungry or thirsty pet loses it faster. Min: 0.00 Max: 100.00 Default: 12.00
        LoyaltyDecayPerDay = 6.0,

        -- Enables the animal's need for protein in its diet.
        ProteinNeedEnabled = true,

        -- How many hours a pet can go without protein before it turns Weak. Min: 6 Max: 168 Default: 72
        ProteinHours = 72,

        -- The pets' ability to detect zombies.
        SentinelEnabled = true,

        -- Less boredom when petting or sleeping next to the animal.
        BondingEnabled = true,

        -- Moodle whose buff reduces panic, stress, sadness and boredom and makes you tire more slowly.
        RestedBuffEnabled = true,

        -- How many hours the Well Rested moodle lasts. Min: 0.50 Max: 24.00 Default: 2.00
        RestedBuffHours = 0.5,

        -- Enables the moodle with each breed's unique buffs.
        BreedMoodlesEnabled = true,

        -- Global multiplier for the pet's skills. Min: 0.10 Max: 10.00 Default: 0.50
        SkillXPRate = 0.6,

        -- Lets the pet take on caring for animals in pens. Affects server performance (low impact).
        FarmCareEnabled = true,

        -- Enables the pet's tricks. Can be OP on a server.
        TricksEnabled = true,

        -- Barking, meowing and the like can attract zombies.
        DogNoiseAttractsZombies = true,

        -- Text with the pet's name. Turn off for more immersion.
        ShowNameTags = true,

        -- Animal spawn rate. Default is 1, 0 disables spawning. Min: 0.00 Max: 5.00 Default: 1.00
        DogSpawnMultiplier = 1.0,

        -- When on, wild animals cannot die from vehicles, fire, attacks and the like.
        WildDogsInvincible = false,

        -- When the owner logs out of the server, the animal leaves with them.
        DespawnOnOwnerOffline = true,

        -- Multiplies the saddlebag's cargo capacity. 0 makes it purely cosmetic. Min: 0.00 Max: 5.00 Default: 1.00
        CargoCapacityMultiplier = 1.0,

        -- Lets pets breed. Affects server performance (low impact).
        BreedingEnabled = true,

        -- How many in-game days a pregnant pet carries before giving birth. Min: 1 Max: 60 Default: 4
        GestationDays = 4,

        -- How many in-game days a puppy takes to grow into an adult. Min: 1 Max: 365 Default: 90
        MaturityDays = 90,

        -- Percent chance per in-game day that a nearby adult male and female with the same owner breed on their own (rolled hourly). Same conditions as manual breeding: fed, loyal, healthy, off cooldown, a free dog slot, and breeding not blocked on either. Only while they are loaded near you. 0 = off. Min: 0.00 Max: 100.00 Default: 5.00
        BreedChancePerDay = 5.0,

        -- When on, running into a pet can knock you down.
        TripOverDogs = true,

        -- The pet can pick up wounds and illnesses. Default: on.
        VetCareEnabled = true,

        -- Everyone starts out knowing every vet care recipe, no need for the mod's magazine.
        VetRecipesUnlocked = true,

        -- The pet can die of illness, hunger and thirst. Default: off.
        Death = false,

        -- Chance that a bite the pet lands on a zombie hurts its paw. Default 0.4 percent. Each Combat level of the pet lowers it by 5 percent of this value, so at level 10 it is halved. Min: 0.00 Max: 100.00 Default: 0.40
        VetWoundChance = 1.0,

        -- Percent chance that each fence the pet hops leaves it with a sprained paw. Default 0.5, 0 means never. Min: 0.00 Max: 100.00 Default: 0.50
        VetSprainChance = 5.0,

        -- Percent chance the pet catches worms for every 6 hours with an upset stomach. Default 10 percent. Min: 0.00 Max: 100.00 Default: 10.00
        VetWormsChance = 10.0,

        -- Chance that bad food or water leaves the pet vomiting. Default 25 percent. Min: 0.00 Max: 100.00 Default: 25.00
        VetSpoiledChance = 25.0,

        -- Chance of catching the flu: rolled while the pet is starving, and for each hour beside a sick dog. Default 15 percent. Min: 0.00 Max: 100.00 Default: 15.00
        VetFluChance = 15.0,

        -- Rolled for every 6 straight hours outdoors. Going indoors resets the count. Default 1.5 percent. Min: 0.00 Max: 100.00 Default: 1.50
        VetHeartwormChance = 1.5,

        -- Chance that the pet is born allergic to one meat for life, rolled once per pet. Default 5 percent. Min: 0.00 Max: 100.00 Default: 5.00
        VetAllergyChance = 10.0,

        -- Chance that each bite in a fight brings fleas or ticks. Default 0.2 percent. Min: 0.00 Max: 100.00 Default: 0.20
        VetInfestChance = 0.2,
    },
    ReadWalking = {

        -- The darkness of the reading fog.
        -- 0.0 means no darkness.
        -- 1.0 means full darkness. Min: 0.00 Max: 1.00 Default: 1.00
        FogDarkness = 1.0,

        -- The mod: Read While Walking
        -- 1.0 means x1 vanilla defaults.
        -- 2.0 means speed x2, etc. Min: 0.20 Max: 100.00 Default: 1.00
        ReadSpeed = 1.0,
    },
    RVAddon = {

        -- Comma-separated list of vehicle script names (e.g., Base.Van,Base.StepVan,Base.VanSpiffo).
        CustomNormalVehicles = "",

        -- Comma-separated list of bus vehicle script names.
        CustomBusVehicles = "",

        -- Comma-separated list of small vehicle script names.
        CustomSmallVehicles = "",

        -- Comma-separated list of 3x2 caravan/trailer script names.
        Custom3x2Caravan = "",

        -- Comma-separated list of 3x6 caravan/trailer script names.
        Custom3x6Caravan = "",

        -- Comma-separated list of 3x7 empty trailer script names.
        Custom3x7Empty = "",

        -- Comma-separated list of 4x12 colossal vehicle script names.
        Custom4x12colossal = "",
    },
    ProjectRVFix = {

        -- When on, RV interior temperature follows the vehicle's own Heater part (if installed, switched on, and powered) instead of raw outdoor weather - so an unheated cabin in a heatwave or blizzard is NOT protected. When off, this mod applies no temperature correction at all inside RV interiors (full outdoor weather, same as vanilla PROJECT RV Interior). Wetness (rain) is always blocked either way - it isn't part of climate control, the cabin just physically has a roof.
        EnableCabinClimateControl = true,
    },
    SPNCharCustom = {

        -- Admins or players holding an Appearance Changer ignore this Default = Disabled
        -- 1 = Face and Details
        -- 2 = Face only
        -- 3 = Details only
        -- 4 = Disabled
        AllowCustomisationChange = 4,

        -- Customisation categories that are hidden to normal players. Comma separated, eg: joke,halloween,special
        AdminLockedCustomisation = "",

        -- Set to 0 to disable growth Min: 0 Max: 20 Default: 10
        BodyHairGrowth = 10,

        -- Set to 0 to disable growth Min: 0 Max: 20 Default: 6
        StubbleHeadGrowth = 6,

        -- Set to 0 to disable growth Min: 0 Max: 20 Default: 3
        StubbleBeardGrowth = 3,

        -- Body hair and stubble grows in-game Default = Enabled for everyone
        -- 1 = Enabled for everyone
        -- 2 = Disabled for everyone
        -- 3 = Player Choice
        BodyHairGrowthEnabled = 1,

        -- Display visible muscles on character depending on strength level Default = Enabled for everyone
        -- 1 = Enabled for everyone
        -- 2 = Disabled for everyone
        -- 3 = Player Choice
        MuscleVisuals = 1,

        -- Players with missing eye customisation will have a vision penalty - Set to 1.0 to disable Min: 0.10 Max: 1.00 Default: 0.50
        MissingEyeVisionModifier = 0.5,

        -- In vanilla washing yourself will also wash off makeup
        WashMakeup = true,
    },
    UsefulBarrels = {

        -- Enables additional information for debugging purposes.
        DebugMode = false,

        -- Maximum barrel capacity.
        -- Applied only for new barrels, previously used is unaffected. Min: 1 Max: 9999 Default: 400
        BarrelCapacity = 400,

        -- A Pipe Wrench is required for barrel uncapping.
        RequirePipeWrench = true,

        -- A Rubber Hose is required to take Gas from barrel.
        RequireHoseForTake = true,

        -- A Funnel is required to add Gas to barrel.
        RequireFunnelForFill = false,

        -- Speeds up canister filling when a funnel is nearby.
        -- For example, 1.25 means a 25 percent bonus, or 1.25 times faster.
        -- Set to 1 to disable the speed bonus.
        -- Does not work if 'Require Funnel' is disabled. Min: 1.00 Max: 2.00 Default: 1.25
        FunnelSpeedUpFillModifier = 1.25,

        -- Acid, Alcohol, Blood, Gasoline, Dye...
        AllowIndustrial = true,

        -- Gasoline
        AllowFuel = true,

        -- Acid, Bleach, Cleaning Liquid...
        AllowHazardous = true,

        -- Seltzer Water, Water, Tainted Water
        AllowWater = true,

        -- Alcohol, Beer, Wine...
        AllowAlcoholic = true,

        -- Blood, Beer, Coffee, Milk, Honey, Soda...
        AllowBeverage = true,

        -- Alcohol
        AllowMedical = true,

        -- Dye, Hair Dye, Wine
        AllowColors = true,

        -- Dye
        AllowDyes = true,

        -- Hair Dye
        AllowHairDyes = true,

        -- No any fluids as for B42.4
        AllowPaint = true,

        -- Potent Poison
        AllowPoisons = true,

        EnableGeneratorRefuel = true,

        GeneratorRefuelRequiresHose = true,

        EnableCarRefuel = true,

        CarRefuelRequiresHose = true,

        EnableFillBarrelFromVehicles = true,

        FillBarrelFromVehiclesRequiresHose = true,

        InitialFluid = true,

        -- Whitespace separated list of fluids that can spawn in barrels.
        InitialFluidPool = "Acid Water TaintedWater Petrol Petrol Bleach PotentPoison",

        -- Max amount of initial fluid.
        -- Won't be greater than the barrel capacity. Min: 0 Max: 9999 Default: 54
        InitialFluidMaxAmount = 54,

        -- Spawn chance of initial fluid. Min: 0.00 Max: 100.00 Default: 25.00
        InitialFluidSpawnChance = 25.0,

        RequireWeldingMask = true,

        RequireBlowTorch = true,
    },
    Plumbing = {

        -- The percentage of the water pump filter that is consumed every 1 game minute. Min: 0.00 Max: 0.10 Default: 0.01
        PumpFilterUsage = 0.007,

        -- The percentage of the efficiency that a water pump loses every 1 game minute. Min: 0.00 Max: 0.01 Default: 0.00
        PumpEfficiencyLoss = 0.0012,

        -- Units of water delivered every game minute by a pump at 100 percent efficiency. Min: 6 Max: 96 Default: 12
        PumpMaxWater = 12,
    },
    TakeABathAndShower = {

        -- This checkbox option does nothing itself.
        GeneralSection = false,

        -- Whether has a water temperature concept to shower and bath.
        --  If False, you will no longer be able to get the warming to body effects of hot water or the stress relief effects.
        WaterTemperatureConcept = true,

        -- This is the amount of water remaining in the bathtub faucet after a water outage. <LINE> By making this value higher than the amount of taking bath water consumed, you will be able to take a bath in the first house you visit after the water outage. Min: 0 Max: 1000 Default: 100
        RemainTubFaucetWater = 100,

        -- This is the amount of water remaining in the shower faucet after a water outage. <LINE> By making this value higher than the amount of taking shower water consumed, you will be able to take a shower in the first house you visit after the water outage. Min: 0 Max: 1000 Default: 20
        RemainShowerFaucetWater = 20,

        -- Randomizes the amount of water remaining after the water shutoff. <LINE>Higher values can reduce the configured remaining water by a larger amount. Default = None
        -- 1 = None
        -- 2 = Up to 25% reduction
        -- 3 = Up to 50% reduction
        -- 4 = Up to 75% reduction
        -- 5 = Up to 100% reduction
        RemainingWaterRandomizationIntensity = 1,

        -- The chance of body shampoo spawning. Default = Rare
        -- 1 = None
        -- 2 = Extremely Rare
        -- 3 = Rare
        -- 4 = Normal
        -- 5 = Common
        -- 6 = Abundant
        BathItemSpawnChance = 3,

        -- The chance of bath salt spawning. Default = Extremely Rare
        -- 1 = None
        -- 2 = Extremely Rare
        -- 3 = Rare
        -- 4 = Normal
        -- 5 = Common
        -- 6 = Abundant
        BathSaltSpawnChance = 2,

        -- This checkbox option does nothing itself.
        TubFluidContainerSection = false,

        -- The amount of water that can be stored in a bathtub.
        --  <PUSHRGB:1,0.5,0.5> Note: This is separate from the amount of water remaining in the faucet when shut out of the water supply. <POPRGB> Min: 100 Max: 1000 Default: 200
        TubWaterCapacity = 200,

        -- If you placed bathtub to outdoors, you can collect rainwater. But you cannot use that water for plumbing.
        TubRainCollect = true,

        -- When you bathing, the water becomes tainted by the dirt washed off your body.
        TubWaterGetDirty = true,

        -- If you have electricity, you can reheat the bath water.
        EnableReheat = true,

        -- Whether to consider all fluid types when check for fluid containers plumbed into baths and showers. If disabled, only fluid containers containing water will be considered.
        AvailableAllFluid = false,

        -- This checkbox option does nothing itself.
        BathAndShowerSection = true,

        -- The amount of water consumed when washing blood, dirt, and grime from your body during a bath. This is a relative value based on the total amount removed. If you want to disable water consumption, set it to 0. Min: 0.00 Max: 1.00 Default: 0.80
        WashInBathConsumeWater = 0.8,

        -- The amount of water needed to take a shower. Min: 0 Max: 200 Default: 80
        ShowerConsumeWater = 80,

        -- Maximum in-game minutes that bath additive benefits can be received. The limit resets 12 in-game hours after the last benefit. Set to 0 for no limit. Min: 0 Max: 240 Default: 30
        BathingBenefitDailyMinutes = 30,

        -- Disable the increase discomfort, boredom, and unhappiness that comes from bathing with wearing clothes or in bad condition bathwater (wrong temperature or dirty).
        DisableNegativeEffectsOfBathing = false,

        -- Disable the increased stress caused by someone (includ zombies) seen at you while bathing.
        DisableFeelingStressByGaze = false,

        -- This checkbox option does nothing itself.
        BodyGrimeSection = true,

        -- Enable Body Grime functions. If this to False, all settings below this will be disabled.
        EnableBodyGrime = true,

        -- Allow the vanilla Wash Yourself action to remove Body Grime.
        WashSelfRemovesGrime = true,

        -- Allow Body Grime to be washed at water sources such as sinks, lakes, and ponds.
        EnableGrimeWash = true,

        -- Require sufficient soap to use the Grime Wash action.
        GrimeWashRequiresSoap = false,

        -- Displays a moodle that increases in severity for every 25 Body Grime accumulated. <LINE> <PUSHRGB:1,0.5,0.5> It will not work if Moodle Framework Mod is not installed!<POPRGB>
        EnableBodyGrimeMoodle = true,

        -- The base amount of Grime that accumulates for your body every hour without you doing anything. Min: 0.00 Max: 100.00 Default: 0.80
        BodyGrimeIncreasedBase = 0.8,

        -- If there is more blood on your body than this value, it will accumulate on the body as Grime. Min: 0 Max: 100 Default: 30
        BloodToGrimeThreshold = 30,

        -- If there is more dirt on your body than this value, it will accumulate on the body as Grime. Min: 0 Max: 100 Default: 30
        DirtToGrimeThreshold = 30,

        -- A multiplier on how amount blood and dirt over the threshold will accumulate as grime. <LINE> This is calculated by total blood or dirt stains on full body, not by part, and the maximum value is 1, not 100. <LINE> If you set this value to 3, you will accumulate 1.5 additional grime every hour if you have 50 blood on your body. Min: 0.00 Max: 100.00 Default: 1.00
        BloodAndDirtMultiplier = 1.0,

        -- If you have too much Grime, you will feel discomfort.
        GrimeDiscomfort = true,

        -- Discomfort modifier when grime is 60 or more but below 75. <LINE> 0 disables discomfort for this stage. Min: 0.00 Max: 1.00 Default: 0.15
        GrimeDiscomfort1 = 0.15,

        -- Discomfort modifier when grime is 75 or more but below 90. <LINE> 0 disables discomfort for this stage. Min: 0.00 Max: 1.00 Default: 0.30
        GrimeDiscomfort2 = 0.3,

        -- Discomfort modifier when grime is 90 or more. <LINE> 0 disables discomfort for this stage. Min: 0.00 Max: 1.00 Default: 0.55
        GrimeDiscomfort3 = 0.55,

        -- If you have too much Grime, you will feel a slight noxious smell.
        GrimeNoxiousSmell = true,
    },
    TchernoLib = {

        -- When a zombie loses a target it's forbidden to attack (e.g. an infected player), it's marked useless to stop it re-detecting that target - but useless zombies also stop wandering. Off: zombies keep wandering normally, but may walk towards a forbidden target without attacking it.
        UselessZombies = false,
    },
    Infirmities = {

        -- The minimum likelihood of a hallucination triggering, expressed as a percentage. Min: 0.00 Max: 5.00 Default: 5.00
        TAWBaseHallucinationChanceMin = 5.0,

        -- The maximum likelihood of a hallucination triggering, expressed as a percentage. Min: 0.00 Max: 20.00 Default: 20.00
        TAWBaseHallucinationChanceMax = 20.0,

        -- Enable this to have nights be a multiplier too and affect the player
        TAWNightsAfftectPlayer = true,

        -- You can change this to your liking, or leave it default Min: 0.00 Max: 5.00 Default: 1.00
        TAWSoundMultiplier = 1.0,

        -- Should the player react and say lines or not?
        TAWShouldPlayerReact = true,

        -- This affects the base chance of getting tremors Min: 0.00 Max: 1.00 Default: 0.00
        ParkinsonsBaseTremorsChance = 0.001,

        -- This affects how long of base cooldown you want between Tremors Min: 0.00 Max: 10.00 Default: 2.00
        ParkinsonsBaseTremorsCooldown = 2.0,

        -- This controls how much the time between tremors can randomly vary around the base cooldown. Example: Base cooldown = 5 hours, factor = 0.5 → actual cooldown will be randomly between 2.5 and 7.5 hours. Min: 0.00 Max: 1.00 Default: 0.30
        ParkinsonsBaseTremorsCooldownVariationFactor = 0.3,

        -- This affects the base factor of your character's anxiety Min: 0.00 Max: 1.00 Default: 0.50
        AnxietyBaseAnxietyFactor = 0.5,

        -- This affects the stress factor used to multiply with your character's anxiety factor Min: 0.00 Max: 1.00 Default: 0.50
        AnxietyBaseStressFactor = 0.5,

        -- This affects the fatigue factor used to multiply with your character's anxiety factor Min: 0.00 Max: 1.00 Default: 0.30
        AnxietyBaseFatigueFactor = 0.3,

        -- This affects the panic factor used to multiply with your character's anxiety factor Min: 0.00 Max: 1.00 Default: 0.30
        AnxietyBasePanicFactor = 0.3,

        -- This adds another factor during the night time to multiply with your character's anxiety factor
        AnxietyNightsAfftectPlayer = true,

        -- This is the factor that multiplies by how much anxiety will affect you during the night Min: 0.00 Max: 10.00 Default: 1.50
        AnxietyNightFactor = 1.5,

        -- This sets the minimum panic threshold to trigger a panic attack/episode Min: 0.00 Max: 100.00 Default: 70.00
        AnxietyPanicEpisodeThreshold = 70.0,

        -- This affects the minimum duration of a panic episode in minutes Min: 0.00 Max: 100.00 Default: 10.00
        AnxietyPanicEpisodeMinDuration = 10.0,

        -- This affects the maximum duration of a panic episode in minutes Min: 0.00 Max: 100.00 Default: 30.00
        AnxietyPanicEpisodeMaxDuration = 30.0,

        -- This affects the duration of the cooldown between panic episodes in minutes Min: 0.00 Max: 100.00 Default: 20.00
        AnxietyPanicEpisodeCooldown = 20.0,

        -- This affects how likely is to trigger a panic episode Min: 0.00 Max: 1.00 Default: 0.20
        AnxietyPanicEpisodeTriggerModifier = 0.2,

        -- This affects how likely is to not drop items during a panic episode Min: 0.00 Max: 1.00 Default: 0.20
        AnxietyPanicEpisodeDropNoneChance = 0.2,

        -- This affects how likely is to drop the main item during a panic episode Min: 0.00 Max: 1.00 Default: 0.50
        AnxietyPanicEpisodeDropMainChance = 0.5,

        -- This affects how likely is to drop the secondary item during a panic episode Min: 0.00 Max: 1.00 Default: 0.20
        AnxietyPanicEpisodeDropSecondaryChance = 0.2,

        -- Should the panic attacks affect the movement speed of the player?
        PanicAffectsMovement = true,

        -- This affects how slow the player becomes during a panic attack, I recommend leaving default Min: 0.00 Max: 1.00 Default: 0.48
        AnxietyPanicSlowMovement = 0.48,

        -- This affects the chronical base pain your character experiences Min: 0.00 Max: 100.00 Default: 10.00
        ScoliosisBasePain = 10.0,

        -- This affects to how much max weight is reduced Min: 0.00 Max: 1.00 Default: 0.85
        ScoliosisCarryModifier = 0.85,

        -- This affects how much pain you will get after you are overloaded Min: 0.00 Max: 100.00 Default: 15.00
        ScoliosisCarryPain = 15.0,

        -- This affects the chance you will get a Scoliosi's flare up Min: 0.00 Max: 1.00 Default: 0.10
        ScoliosisFlareChance = 0.1,

        -- This affects how much pain you will get during a flare up Min: 0.00 Max: 100.00 Default: 40.00
        ScoliosisMaxFlare = 40.0,

        -- This affects how much your fatigue is affected by the Narcolepsy Min: 0.00 Max: 1.00 Default: 0.20
        NarcolepsyBaseModifier = 0.2,

        -- This affects the minimum fatigue threshold for an narcoleptic attack Min: 0.00 Max: 1.00 Default: 0.85
        NarcolepsyAttackThreshold = 0.85,

        -- This affects by how much the chance of the previous option raises related to your fatigue Min: 0.00 Max: 1.00 Default: 0.60
        NarcolepsyAttackFactor = 0.6,

        -- This affects the minimum amount of time your character might fall asleep Min: 0 Max: 60 Default: 15
        NarcolepsySleepMinutesMin = 15,

        -- This affects the maximum amount of time your character might fall asleep Min: 0.00 Max: 24.00 Default: 15.00
        NarcolepsySleepHoursMax = 15.0,

        -- This enables or disables the addiction system
        StartAddictiveSystem = true,

        -- This affects the addictive personality modifier added to the addiction chance Min: 1.00 Max: 2.00 Default: 1.30
        AddictivePersonalityModifier = 1.3,

        -- This affects the modifier added to the decay modifier with the trait Min: 0.00 Max: 1.00 Default: 0.70
        AddictivePersonalityDecayModifier = 0.7,
    },
    ImmersiveBlackouts = {

        -- Enabling this option will reset the mod's saved data.
        -- Only enable this if you have changed the day when the shutdowns will occur.
        -- It will automatically disable afterwards.
        ModReset = false,

        -- Enables automatic emergency radio broadcasts from the Knox Emergency Regional Infrastructure Service.
        -- The radio will provide information about upcoming outages, current infrastructure status, and other emergency events.
        Radio = true,

        -- Sets the frequency of the emergency radio broadcasts in MHz.
        RadioFrequency = 89.2,

        -- Sets the day range for a random permanent shutoff.
        -- Format: minimum day - maximum day
        -- 0-30 = random day
        -- 30-30 = fixed day.
        -- Overrides the vanilla 'Water Shutoff' day setting.
        -- If the value becomes blank, the entered format was invalid and was rejected.
        WaterShutoffDayRange = "",

        -- Number of days before the scheduled permanent shutoff to start random outages.
        -- Vanilla shutoff: 30, Random Outage Offset: 5 = random outages start on day 25.
        -- Vanilla shutoff: Disabled, Random Outage Offset: 2147483647 = random outages start on day 0. Min: 1 Max: 2147483647 Default: 7
        WaterOffset = 7,

        -- Determines how often the chance of a shutoff or restoration is checked.
        -- The value is specified in in-game minutes. Min: 1 Max: 1440 Default: 10
        WaterCheckInterval = 10,

        -- Cooldown time (in in-game hours) before another state change can occur.
        -- Format: after restoration|after shutoff
        -- 2-2 = 2 hour cooldown after both restoration and shutoff
        -- 1-3|12-24 = random cooldown of 1-3 hours after a restoration and 12-24 hours after a shutoff
        -- 0-0|2-2 = no cooldown after a restoration and a fixed 2 hour cooldown after a shutoff.
        WaterCooldown = "0-0",

        -- Chance (in percent) that the supply will be shut off.
        -- Checked according to the configured check interval. Min: 0.00 Max: 100.00 Default: 1.00
        WaterPercentOFF = 0.5,

        -- Chance (in percent) that the supply will be restored.
        -- Checked according to the configured check interval. Min: 0.00 Max: 100.00 Default: 5.00
        WaterPercentON = 10.0,

        -- Weather conditions affect the chance of outages.
        -- Bad weather increases the chance of outages and decreases the chance of restoration.
        -- Determines the maximum percentage of weather influence on the chance. Min: 0.00 Max: 100.00 Default: 0.00
        WeatherInfluenceWater = 0.0,

        -- Dynamically adjusts the chance of shutoffs and restorations based on how close the scheduled shutoff day is.
        -- Uses the maximum chance set in the Shutoff Chance and Restore Chance settings.
        -- The restore chance always remains at a minimum of 5%.
        -- It is recommended to use a cooldown when this option is enabled.
        DynamicWaterChance = false,

        -- Sets the day range for a random permanent shutoff.
        -- Format: minimum day - maximum day
        -- 0-30 = random day
        -- 30-30 = fixed day.
        -- Overrides the vanilla 'Electricity Shutoff' day setting.
        -- If the value becomes blank, the entered format was invalid and was rejected.
        ElectricityShutoffDayRange = "",

        -- Number of days before the scheduled permanent shutoff to start random outages.
        -- Vanilla shutoff: 30, Random Outage Offset: 5 = random outages start on day 25.
        -- Vanilla shutoff: Disabled, Random Outage Offset: 2147483647 = random outages start on day 0. Min: 1 Max: 2147483647 Default: 7
        ElectricityOffset = 7,

        -- Determines how often the chance of a shutoff or restoration is checked.
        -- The value is specified in in-game minutes. Min: 1 Max: 1440 Default: 10
        ElectricityCheckInterval = 10,

        -- Cooldown time (in in-game hours) before another state change can occur.
        -- Format: after restoration|after shutoff
        -- 2-2 = 2 hour cooldown after both restoration and shutoff
        -- 1-3|12-24 = random cooldown of 1-3 hours after a restoration and 12-24 hours after a shutoff
        -- 0-0|2-2 = no cooldown after a restoration and a fixed 2 hour cooldown after a shutoff.
        ElectricityCooldown = "0-0",

        -- Chance (in percent) that the supply will be shut off.
        -- Checked according to the configured check interval. Min: 0.00 Max: 100.00 Default: 1.00
        ElectricityPercentOFF = 0.5,

        -- Chance (in percent) that the supply will be restored.
        -- Checked according to the configured check interval. Min: 0.00 Max: 100.00 Default: 5.00
        ElectricityPercentON = 10.0,

        -- Weather conditions affect the chance of outages.
        -- Bad weather increases the chance of outages and decreases the chance of restoration.
        -- Determines the maximum percentage of weather influence on the chance. Min: 0.00 Max: 100.00 Default: 0.00
        WeatherInfluenceElectricity = 5.0,

        -- Dynamically adjusts the chance of shutoffs and restorations based on how close the scheduled shutoff day is.
        -- Uses the maximum chance set in the Shutoff Chance and Restore Chance settings.
        -- The restore chance always remains at a minimum of 5%.
        -- It is recommended to use a cooldown when this option is enabled.
        DynamicElectricityChance = false,
    },
    UnseasonalWeather = {

        -- If false, this mod's unseasonal weather events are disabled.
        Enabled = true,

        -- Approximate chance per day for an unseasonal weather event to occur. Min: 0 Max: 100 Default: 25
        DailyEventChance = 25,

        -- Shortest possible duration of a single unseasonal weather event. Min: 1 Max: 48 Default: 3
        MinDuration = 3,

        -- Longest possible duration of a single unseasonal weather event. Min: 1 Max: 72 Default: 8
        MaxDuration = 8,

        -- Scales the strength of unseasonal weather events. 1.0 = default. Min: 0.20 Max: 3.00 Default: 1.00
        IntensityMultiplier = 1.0,

        -- If enabled, each winter day rolls against Daily event chance to decide whether hardcore winter temperatures apply that day. Default: off.
        HardcoreWinterTemps = false,

        -- If enabled, each summer day rolls against Daily event chance to decide whether hardcore summer temperatures apply that day. Default: off.
        HardcoreSummerTemps = false,

        -- If true, unseasonal weather events keep their temperature, wind, fog and cloud changes but do not generate rain or snow.
        DryEvents = false,

        -- Rain now increases wetness progressively. Prolonged high wetness amplifies cold damage indirectly; rain does not cause direct illness.
        EnhancedRainExposure = true,

        -- If enabled, a lit campfire, fireplace, antique oven or barbecue warms players anywhere in the same enclosed room as strongly as standing beside it. Heat does not spread to other rooms. Default: off.
        RoomWideIndoorHeat = true,

        -- Skips global event scans while all active players travel in vehicles and stops this mod's heat, rain-exposure and forced wind-sprite updates for the driver. Active weather is kept; it is never cleared.
        PauseWhileDriving = true,

        -- If true, lightning strikes emit a strong world sound that attracts zombies like a global meta event. Default: off.
        LightningAttractsZombiesGlobal = false,

        -- If true, Unseasonal Weather uses its custom minute-precision clock UI. If false, it is disabled and the normal clock is used.
        ClockUIEnabled = true,
    },
    UW_RadioForecasting = {

        -- If false, all SPEC radio forecasts are disabled.
        Enabled = true,

        -- If true, schedules broadcasts between 20:00 and 23:00; otherwise between 08:00 and 11:00.
        UseNightWindow = false,

        -- If true, active walkies show subtle WX scanner readings (default: on).
        WalkieHints = true,

        -- If true, print broadcast text to console for verification.
        DebugLogging = false,
    },
    CaffeineMakesSense = {

        -- When enabled, caffeine degrades sleep through slower overnight fatigue recovery and planner-aware longer sleep. Turn this off to keep CMS awake masking while leaving sleep penalty-free.
        EnableSleepPenaltyModel = true,
    },
    DGMC_Bolt_Cutters = {

        -- whether the lock on garage doors can be cut open
        Allow_Garage_Doors = true,

        -- whether the lock on fence gates can be cut open
        Allow_Fence_Gates = true,

        -- whether bolt cutters can be used to destroy fence sections
        Allow_Fences = true,

        -- the percentage chance to drop a resource when destroying a fence section, 0 to disable Min: 0 Max: 100 Default: 0
        Fence_Wire_Chance = 20,

        -- whether the lock on security shutters over doors and windows can be cut open, the shutters will be destroyed
        Allow_Shutters = true,

        -- a character must have at least this level of strength to perform easy actions, like cutting thin wire fences Min: 0 Max: 10 Default: 3
        Easy_Strength_Req = 3,

        -- a character must have at least this level of strength to perform moderate actions, like cutting locks Min: 0 Max: 10 Default: 5
        Medium_Strength_Req = 5,

        -- a character must have at least this level of strength to perform challenging actions, like cutting thick fences Min: 0 Max: 10 Default: 7
        Hard_Strength_Req = 7,

        -- how many seconds it will take, before strength is factored in Min: 0 Max: 60 Default: 22
        Base_Duration = 22,

        -- how much muscle strain will be applied, before strength is factored in Min: 0.00 Max: 40.00 Default: 4.00
        Base_Muscle_Strain = 4.0,

        Debug_Logging = false,
    },
    ZHB = {

        -- Min: 1.00 Max: 50.00 Default: 30.00
        NoSkullBagCapacity = 30.0,

        -- Min: 0.00 Max: 99.00 Default: 85.00
        NoSkullBagWeightReduction = 85.0,

        -- Min: 1.00 Max: 50.00 Default: 34.00
        SkullBagCapacity = 34.0,

        -- Min: 0.00 Max: 99.00 Default: 87.00
        SkullBagWeightReduction = 87.0,

        -- Min: 0.10 Max: 10.00 Default: 2.00
        BagWeight = 2.0,

        -- Min: 0.50 Max: 1.00 Default: 0.95
        BagRunSpeedModifier = 0.95,
    },
    NestedHealthInfo = {

        -- Viewing status requires the skill level (greater than or equal to this value). Min: 0 Max: 10 Default: 3
        DoctorLevelForInfo = 3,
    },
    TrueWeight = {

        -- If enabled, applies the mod creator's custom weight values. <LINE>Player custom sandbox settings above will ALWAYS override the preset if modified.
        UseModPreset = true,

        -- Multiplies the weight of ALL items in the game. <LINE>This calculation is applied AFTER any custom lists, sandbox categories, or mod presets. Min: 0.00 Max: 256.00 Default: 1.00
        GeneralMultiplier = 1.0,

        -- Format: ItemID:Weight;ItemID:Weight <LINE>(e.g., Nails:0.001;DuctTape:0.1)
        CustomWeights = "\"\"",

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Accessory = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Ammo = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Animal = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        AnimalPart = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        AnimalPartWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Animals = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Appearance = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Armor = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Assembly = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Badger = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Bag = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Bandage = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Barricades = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Bear = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Beaver = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Blacksmithing = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Blade = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        BrokenWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Bug = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Bunny = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        CDs = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Camping = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Carpentry = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Cartography = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Carving = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Clothing = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Communications = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Container = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Cooking = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        CookingWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Cookware = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Corpse = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Debug = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Dog = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Duck = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Ears = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Electrical = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Electronics = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Entertainment = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Explosives = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Eye = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Farming = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        FireSource = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Firearm = 0.8,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        FirstAid = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        FirstAidWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Fishing = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        FishingWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Food = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Fox = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Frog = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Furniture = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Gardening = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        GardeningWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Generic = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Glassmaking = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Goblin = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Hedgehog = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Hidden = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Home_VHS = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Household = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        HouseholdWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Instrument = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        InstrumentWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Item = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Junk = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        JunkWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Knapping = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        LightSource = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Literature = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        MaleBody = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Masonry = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Material = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        MaterialWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Medical = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Memento = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Meta = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Metalworking = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Miscellaneous = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Mole = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Music = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Object = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Outdoors = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Packing = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Paint = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Player = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Pottery = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        ProtectiveGear = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Raccoon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        RecipeResource = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Repair = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Retail_VHS = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Security = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        SkillBook = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Slash = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Spear = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Spider = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Sports = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        SportsWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Squirrel = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Stab = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Swinging = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Tail = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Tailoring = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Teddy_Bear = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Tool = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        ToolWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Tools = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Trapping = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        UI = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Vehicle = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        VehicleMaintenance = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        VehicleMaintenanceWeapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Wall_Coverings = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Water = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        WaterContainer = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Weapon = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        WeaponCrafted = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        WeaponImprovised = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        WeaponPart = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Weaponry = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Welding = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        World = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Wound = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        ZedDmg = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        Zombie = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        bodywork = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        brakes = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        door = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        engine = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        gastank = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        lights = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        nodisplay = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        seat = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        suspension = 1.0,

        -- Min: 0.00 Max: 256.00 Default: 1.00
        tire = 1.0,
    },
    PZ_Map = {

        -- Off: PZ Map stops sending other players' positions to its browser page. Saves about 55 bytes per visible player per second.
        SendPlayerPositions = true,

        -- On: the PZ Map browser page never shows the player's own position, or the direction cone.
        DisablePlayerMarker = false,

        -- On: the PZ Map browser page shows the position dot but not which way the player faces.
        DisableCompassDirection = false,

        -- On: the direction cone shows only while the player carries a compass. Off: always shown.
        RequireCompass = false,

        -- On: locks PZ Map's Fog tickbox on, so unexplored areas stay hidden on the browser page.
        MandatoryFog = false,

        -- On: locks PZ Map's Darkness tickbox on, so the page dims the map when it's too dark to read.
        MandatoryDarkness = false,
    },
    TrippingZombies = {

        -- Master switch for the whole mod. Turn this off to stop zombies tripping entirely without removing the mod from the save.
        enableMod = true,

        -- % chance a sprinter trips when it bumps into another zombie while on the move.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 50
        collisionTripChanceSprinters = 50,

        -- % chance a fast shambler trips when it bumps into another zombie while on the move.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 10
        collisionTripChanceFastShamblers = 10,

        -- % chance a shambler trips when it bumps into another zombie while on the move.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 4
        collisionTripChanceShamblers = 4,

        -- % chance, rolled on a cooldown, that a moving sprinter trips on its own with nothing in the way.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 7
        randomTripChanceSprinters = 7,

        -- % chance, rolled on a cooldown, that a moving fast shambler trips on its own with nothing in the way.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 4
        randomTripChanceFastShamblers = 4,

        -- % chance, rolled on a cooldown, that a moving shambler trips on its own with nothing in the way.
        -- 0 = never, 100 = always. Min: 0 Max: 100 Default: 2
        randomTripChanceShamblers = 2,

        -- % chance a chasing zombie trips when it bumps into another zombie that is already on the ground. Lets one trip cascade into a dogpile through a packed horde.
        -- 0 = off. Applies to all speeds - a body is a body. Min: 0 Max: 100 Default: 30
        pileUpTripChance = 30,

        -- % chance, rolled on the trip cooldown, that a moving zombie trips while standing on a square that has a dead body on it. Turns killzones and corpse piles into real obstacles.
        -- 0 = off. Min: 0 Max: 100 Default: 23
        corpseTripChance = 23,

        -- How a trip plays out.
        -- Stumble: a light stagger that briefly interrupts the zombie, no fall.
        -- Trip (default): sprinters tumble forward at speed; slower zombies fall flat.
        -- Knockdown: every tripped zombie is knocked to the ground, the longest recovery. Default = Trip (default)
        -- 1 = Stumble (light)
        -- 2 = Trip (default)
        -- 3 = Knockdown (heavy)
        tripEffect = 2,

        -- Shortest gap, in update ticks, before a zombie that already rolled for a trip can roll again. Higher values make tripping rarer. ~60 ticks is roughly a second. Min: 1 Max: 600 Default: 100
        tripCooldownMin = 100,

        -- Longest gap, in update ticks, before a zombie can roll for a trip again. Each cooldown is randomised between the minimum and maximum so trips don't fall into a rhythm. Clamped up to the minimum if set lower. Min: 1 Max: 600 Default: 150
        tripCooldownMax = 150,

        -- % chance that a tripping zombie breaks something on the way down and gets back up as a crawler.
        -- 0 = off (default). A spicy, lethal-but-fair option for sprinter runs. Min: 0 Max: 100 Default: 0
        crawlerChance = 5,

        -- Radius of the noise a trip makes as the body hits the ground, drawing other zombies the same way a thump does.
        -- 0 = silent (default). Min: 0 Max: 30 Default: 0
        tripNoise = 5,

        -- Off (default): any moving zombie can trip, including wandering and migrating hordes.
        -- On: zombies only trip while actively chasing a target they can see - the original behaviour.
        requireChasing = false,

        -- On (default): zombies can trip even in the close-range, arms-out lunge, so a charging attacker can still pitch forward.
        -- Off: they only trip once back in a normal chase.
        tripWhileFighting = true,

        -- % chance a fall becomes a full physics ragdoll instead of an animated fall - trips, stair falls and hit knockdowns alike. The zombie goes down the way it was pushed, flops, settles, then gets back up.
        -- 100 = always (default), 0 = off.
        -- Needs the game's "Use Physics Hit Reactions" display setting on.
        -- Single-player only, unless you also run the Ragdolls in Multiplayer mod - then it works in MP too, minus the forward sprawl.
        -- Costs performance in a big horde. Min: 0 Max: 100 Default: 100
        ragdollTripChance = 100,

        -- % chance a moving zombie loses its footing partway along a flight of stairs - rolled once per flight.
        -- 0 = off. Absorbed from Zombies Trippin'. Min: 0 Max: 100 Default: 8
        stairTripChance = 8,

        -- % chance a shove or a melee hit puts the zombie on the floor, falling away from you - backward if hit from the front, forward from behind, sideways from the side (sideways needs a ragdoll).
        -- 0 = off. Absorbed from Zombies Trippin'. Min: 0 Max: 100 Default: 20
        hitFallChance = 20,

        -- % chance a firearm hit puts the zombie on the floor, falling away from the shooter.
        -- 0 = off. Absorbed from Zombies Trippin'. Min: 0 Max: 100 Default: 30
        firearmFallChance = 30,

        -- How long the hit's own stagger plays before the zombie goes down. ~60 ticks is roughly a second. Lower = it drops almost at once, higher = it reels first. Min: 1 Max: 100 Default: 30
        hitFallDelay = 30,

        -- Stops human NPCs from other mods tripping and falling like zombies. Many NPC mods build their NPCs out of zombies, so without this they trip too.
        -- Type the tag the NPC mod puts on its NPCs. Separate several tags with commas.
        -- Plain word = an animation variable, e.g. Bandit
        -- md:Word = a ModData field, e.g. md:ProjectALifeOwned
        -- Already built in: Bandit, SurvivorNPC, NotAloneBody, md:ProjectALifeOwned.
        -- Check the NPC mod's page or ask its author for the tag. Example: MyNpcTag, md:MyNpcFlag
        extraNpcTags = "",
    },
    ZCollision = {

        -- How many zombies are processed per tick for hitbox collision. Lower numbers ensure smooth performance for everyone. Min: 3 Max: 15 Default: 6
        MaxHitboxes = 6,

        -- Maximum distance in tiles around the player where zombie hitboxes will collide. Min: 3 Max: 15 Default: 6
        MaxDistanceFromPlayer = 6,

        -- Hitbox collision radius for standard walking/chasing zombies. Min: 0.01 Max: 0.99 Default: 0.46
        BaseRadius = 0.46,

        -- Force applied to separate standard zombies from each other. Min: 0.01 Max: 0.99 Default: 0.05
        BasePushForce = 0.05,

        -- Hitbox collision radius applied when a zombie is hit, shoved, or staggered. Min: 0.01 Max: 0.99 Default: 0.65
        StunRadius = 0.65,

        -- Force applied to push moving zombies away from a stunned zombie. Min: 0.01 Max: 0.99 Default: 0.19
        StunPushForce = 0.19,

        -- Hitbox collision radius applied when a zombie is tripping, falling, or dying mid-air. Min: 0.01 Max: 0.99 Default: 0.75
        FallingRadius = 0.75,

        -- Force applied to push moving zombies away from a falling/dying zombie. Min: 0.01 Max: 0.99 Default: 0.24
        FallingPushForce = 0.24,

        -- Highlights zombies which have collision enabled. This is for debugging purposes only and should be disabled for normal gameplay.
        DebugMode = false,
    },
    HereGoesTheSun = {

        EnableGodRays = true,

        EnableStormMood = true,

        -- Default = Recommended
        -- 1 = Soft
        -- 2 = Recommended
        -- 3 = Night of the Living Dead
        StormMoodPreset = 2,
    },
    LGExtendedPlumbing = {

        -- A rain collector plumbed into a building feeds every plumbed fixture in it, not just the one right below. Turn this off for normal plumbing.
        Enabled = true,

        -- How far a fixture looks for barrels when it is not in a real building, like a base you built yourself. Inside a real building the whole building is used and this does nothing. 12 covers a good sized base. Min: 1 Max: 64 Default: 12
        Reach = 12,

        -- Things that can be plumbed in to be FILLED by the supply instead of feeding it. Water dispensers by default. You still have to right-click one and plumb it with a pipe wrench. Use the object's script name, separated by semicolons. Clear the box to turn this off.
        FedFixtures = "WaterDispenser",

        -- Fixes two base game bugs on servers: a washing machine you cannot plumb, and one that keeps running on your screen after it runs dry. Singleplayer does not need it.
        WasherPatch = true,

        -- Fixes a base game bug that empties your barrels without filling anything. It only hits drinks like cola, juice and vodka. Water, beer and whiskey were never affected.
        FluidPatch = true,

        -- Writes every plumbing change to the log file. Only useful for tracking down a problem.
        Debug = false,
    },
    LGExtendedElectricity = {

        -- A generator powers the whole building it reaches, not just the tiles around it. Every floor, the roof and the basement. Turn this off and restart before removing the mod.
        Enabled = true,

        -- On: plug a generator in and it powers the building straight away. Off: you right-click it and pick Wire up the building first. Either way you can change your mind on any generator.
        ExtendByDefault = false,

        -- On: the extra rooms cost fuel, so a big building burns more. Off: they are free. To change the fuel rate itself, use the game's own Generator Fuel Consumption.
        ChargeFuel = true,

        -- On: two generators on one building split the fuel bill instead of both paying it in full. Off: each one pays in full.
        ShareLoad = true,

        TakeoverMark = "none",

        -- Put too much on a generator and its breaker trips, taking every generator on the same buildings with it. Start them all again, then right-click one and reset. To stop it tripping, add a generator or turn something off. Needs Generator Fuel Consumption above zero.
        Breaker = true,

        -- How much a generator can run at once. A better generator gets more: at 225 they range from 5400 to 8100 watts. Lower this for a harder game, raise it for an easier one. Min: 10 Max: 10000 Default: 225
        BreakerWattsPerPoint = 250,

        -- Lets you pipe petrol to a generator with a pipe wrench. A barrel next to it feeds it directly. With LG Extended Plumbing, a generator can also draw from the whole base's petrol barrels. Off: nothing can be connected.
        FuelLine = true,

        -- Lets you pipe a fuel station pump into a generator parked next to it, so it runs off the tanks below. Off: barrels only.
        FuelFromPumps = true,

        -- How far power reaches past the walls, so a porch light or an outdoor freezer works. Set 0 for indoors only. Some tiles reach a little further than this, so treat it as a minimum. Min: 0 Max: 8 Default: 1
        ExteriorReach = 6,

        -- On: generators and wire relays use the two ranges below, and the game's Generator tile range is set to 1. Off: the game's range is used. Needs a restart.
        TakeOverGeneratorRange = true,

        -- How many tiles a running generator powers around itself, and how far away a building can be to wire it up. Used when the mod sets generator range. Min: 1 Max: 100 Default: 20
        GeneratorRange = 20,

        -- How many tiles a wire relay powers around itself, and how many electrical wires it costs. Used when the mod sets generator range. Min: 1 Max: 100 Default: 2
        WireRelayRange = 2,

        -- On: generators and wire relays use the two level settings below, and the game's Generator vertical range is set to 1. Only works while Mod sets generator range is on. Off: the game's vertical range is used. Needs a restart.
        TakeOverGeneratorVerticalRange = true,

        -- How many levels above and below a running generator it powers. Wired buildings always get every level. Used when the mod sets generator vertical range. Min: 1 Max: 15 Default: 1
        GeneratorVerticalRange = 1,

        -- How many levels above and below a wire relay it powers. Used when the mod sets generator vertical range. Min: 1 Max: 15 Default: 1
        WireRelayVerticalRange = 1,

        -- What one street light costs your generator once you wire it up. The game charges nothing for street lights, so this figure is the mod's. Set 0 to make them free. Min: 0 Max: 1000 Default: 100
        StreetLightWatts = 100,

        -- Writes every power change to the log file. Only useful for tracking down a problem.
        Debug = false,
    },
    LGRealisticPowerUsage = {

        -- Off: nothing ever uses more power than it did before, only less. On: a few things that really use a lot now cost a lot. A clothes dryer goes to 3000 watts and an oven to 1500.
        Increases = true,
    },
    ProximityInventory = {

        -- Enable this if you want the Proximity Inventory to work only on zombies
        ZombieOnly = false,
    },
    CF8KSweeper = {

        AllowTiles = true,

        -- You can list exact sprite names or the start of tilepacks. Separate them with ;
        SpriteWhitelist = "brokenglass_1_;trash_01_;d_trash_;street_decoration_01_26;street_decoration_01_27;damaged_objects_01_26;damaged_objects_01_27;damaged_objects_01_18;damaged_objects_01_19;damaged_objects_01_20;damaged_objects_01_21",

        AllowBlood = true,

        AllowGrime = true,

        AllowAshes = true,

        AllowItems = true,

        AllowCorpses = true,

        -- WARNING: items and corpses will be gone forever. This has enormous griefing potential so it is disabled by default.
        AllowUserAutoDelete = true,
    },
    VMZ = {

        -- Determines whether military road stories will spawn in the game.
        RoadStories = true,

        -- Allows you to edit the chances of military road stories appearing. Min: 0.00 Max: 5.00 Default: 1.00
        RoadStoriesMultiplier = 1.0,

        -- Minimum amout of days (since start of apocalypse) after which road stories will begin to spawn. Min: 0 Max: 1000 Default: 5
        RoadStoriesMinDay = 5,

        -- Maximum amout of days (since start of apocalypse) after which road stories will stop spawning. Min: 0 Max: 1000 Default: 90
        RoadStoriesMaxDay = 90,

        -- Determines whether a vehicle can spawn in a regular parking stall (near shops, houses) as police and fire department cars occasionally do.
        SpecCar = false,

        -- Set spawn rate for vehicles in military zone. Min: 0 Max: 100 Default: 16
        SpawnRate = 16,

        -- Set condition of vehicle parts (should be 'damaged') that spawn in military zone. Recommend use it in pair with 'Chance of having a damaged part'. So if you want ~100% vehicle set 'Vehicles condition' = 100 and 'Chance of having a damaged part' = 100. Min: 0 Max: 100 Default: 50
        VehiCond = 50,

        -- Set chance of having a 'damaged' part for vehicles in military zone (the part's condition applies specifically to 'damaged' parts, so if the chance is 100 and the durability is 100, the overall condition indicator of the car will also be ~100%). Min: 0 Max: 100 Default: 0
        PartDamage = 0,

        -- Set chance to spawn a key in vehicle and near it (zombies, floor, buildings). Min: 0 Max: 100 Default: 70
        KeySpawn = 70,
    },
    VVR = {

        -- Disables trailers spawn in traffic jams and basic car crashes. Still can be founded in car crash attached to vehicle and parkings.
        NoTrailers = false,

        -- Replaces burnt cars with KI5's ones in bad condition.
        NoBurnt = true,

        -- Set condition for vehicles that replaced burnt cars. Min: 0 Max: 100 Default: 10
        VehiCond = 10,

        -- Cars that shouldn't spawn in world. Divider - ;
        VehiclesBlacklist = "Base.ModernCar_Martin;",
    },
    SandboxOptions = {

        EnableRightClick = false,

        ShowAdvanced = false,

        -- Automatically opens the Sandbox Options menu when the game is paused.
        EnableOpenOnPause = false,
    },
    ComputerMod = {

        -- Min: 0 Max: 100 Default: 14
        DiscSpawnChance = 14,

        -- Min: 0 Max: 300 Default: 100
        GameDiscWeightPercent = 100,

        -- Min: 0 Max: 300 Default: 100
        SystemDiscWeightPercent = 100,

        -- Min: 0 Max: 300 Default: 100
        BlankDiscWeightPercent = 100,

        -- Min: 0 Max: 300 Default: 100
        HackDiscWeightPercent = 100,

        -- Min: 0 Max: 100 Default: 60
        PreinstalledGameChance = 60,

        -- Min: 0 Max: 100 Default: 34
        PasswordChance = 34,

        -- Min: 0 Max: 100 Default: 12
        FramePasswordNoteChance = 12,

        -- Min: 0 Max: 100 Default: 18
        NearbyPasswordNoteChance = 18,

        -- Min: 0 Max: 10 Default: 1
        HackRequiredElectricalLevel = 1,

        -- Min: 0 Max: 100 Default: 28
        EmptyFolderChance = 28,

        -- Min: 0 Max: 100 Default: 12
        FolderMagazineChance = 12,

        -- Min: 0 Max: 100 Default: 18
        FolderNewspaperChance = 18,

        -- Min: 0 Max: 100 Default: 9
        FolderVideoChance = 9,

        -- Min: 0 Max: 100 Default: 10
        PaintFileChance = 10,

        -- Min: 0 Max: 100 Default: 6
        ComponentSpawnChance = 6,

        -- Min: 0 Max: 100 Default: 18
        FoundComputerBadPartChance = 18,

        -- Min: 0 Max: 100 Default: 1
        FoundComputerBrokenPartChance = 1,

        -- Min: 0 Max: 300 Default: 100
        ComponentWearRate = 100,

        EnableGameInstallVirus = true,

        -- Min: 0 Max: 100 Default: 8
        GameInstallVirusChance = 8,

        EnableBoardApp = true,

        EnableChatApp = true,

        EnableCommerceApp = true,

        NetworkOutageOnPowerLoss = true,

        NetworkTerminalNeedsPower = true,

        -- Min: 1 Max: 168 Default: 24
        MarketShopRefreshHours = 24,

        -- Min: 1 Max: 168 Default: 24
        MarketJobRefreshHours = 24,

        -- Min: 0 Max: 100 Default: 42
        MailAccountChance = 42,

        -- Min: 0 Max: 100 Default: 55
        MailLoggedInChance = 55,

        -- Min: 0 Max: 100 Default: 28
        SecretSiteHintChance = 28,
    },
    NeatLockpicking = {

        -- When off, vehicles use the vanilla hotwire action instead of the wire minigame.
        EnableHotwire = true,

        -- When on, locked windows can be opened with a lockpick, same as with a crowbar.
        EnableWindowLockpick = true,

        -- Min: 3 Max: 10 Default: 6
        PinCount = 6,

        -- Min: 0 Max: 100 Default: 50
        BreakChanceAtZeroSkill = 40,

        -- Min: 0 Max: 100 Default: 5
        BreakChanceMinimum = 1,

        NoiseOnFail = true,

        ResetPinsOnBreak = true,

        -- Min: 0.10 Max: 5.00 Default: 1.00
        BrokenLockpickDuration = 1.0,

        -- Min: 1 Max: 10 Default: 4
        RandomPinCountMin = 2,

        -- Min: 1 Max: 10 Default: 7
        RandomPinCountMax = 7,

        -- Min: 3 Max: 10 Default: 8
        ReinforcedDoorPinCount = 8,

        -- Degrees per second for the crowbar minigame on normal doors and windows. Default 180. Min: 90 Max: 900 Default: 180
        NormalDoorArrowSpeed = 180,

        -- Degrees per second for the crowbar minigame on security doors. Default 360. Min: 180 Max: 1800 Default: 360
        ReinforcedDoorArrowSpeed = 360,

        -- When on, a hit on a security door reverses the arrow direction.
        ReinforcedReverseArrowOnHit = true,

        -- Progress added per yellow-zone hit on security doors. Default 10 percent. Min: 1 Max: 100 Default: 10
        ReinforcedYellowHitValue = 10,

        -- Progress added per green-zone hit on security doors. Default 20 percent. Min: 1 Max: 100 Default: 20
        ReinforcedGreenHitValue = 20,

        -- When on, crowbar minigame progress slowly drops if you wait.
        CrowbarProgressDecayEnabled = true,

        -- Seconds between each decay tick. Default 2. Min: 0.50 Max: 10.00 Default: 2.00
        CrowbarProgressDecayInterval = 2.0,

        -- Progress removed each decay tick. Default 1 percent. Min: 1 Max: 10 Default: 1
        CrowbarProgressDecayAmount = 1,

        -- Multiplier on endurance lost per crowbar swing. Default 0.5 (half of the old drain). 1.0 is the previous rate. Min: 0.10 Max: 3.00 Default: 0.50
        CrowbarExhaustionMultiplier = 0.5,

        -- When on, pins bind after about 50 percent lift. The first pin in the sequence is stiffest. Off by default.
        PinResistanceEnabled = false,
    },
    Tuna_Rewatch = {

        -- How long before a watched retail VHS tape is ready to watch again. Only retail tapes are affected - home VHS tapes and music CDs are unchanged.  READING THE TICK: a finished tape keeps its "watched" tick for the whole cooldown, and the tick disappears once the tape is ready to watch again. No tick means there is something to be had from it; a tick means you have already taken it.  A tape you had already finished before installing this mod starts its cooldown when the mod first detects it, not from whenever you originally watched it - so expect one full wait before anything changes on an existing save.  Tapes are checked once an in-game hour, so one can be up to an hour late becoming ready.  Single-player only. Default = 2 weeks
        -- 1 = 12 hours (Very Short)
        -- 2 = 2 weeks
        -- 3 = 1 month
        -- 4 = 3 months
        -- 5 = 6 months
        CooldownDays = 3,

        -- Disabled by default. Enable this to earn skill XP from instructional tapes again on a rewatch. Left off, a rewatched tape gives back its comfort but not its lessons, so how-to tapes recover less than films do.  Recipes are NEVER re-learned, whether this is on or off.
        RestoreSkillXp = true,
    },
    Tuna_MovieNight = {

        -- How strongly a tape moves your mood. At the default, a well-matched film is worth about what a hot meal is worth, and the strongest comfort tape stays below what a cigar gives you.  This scales everything, including the tapes that make things worse - turning it up makes horror hit harder too.  Requires Rewatchable VHS, which decides when a tape's mood becomes available again. Default = Normal
        -- 1 = Half (Subtle)
        -- 2 = Three Quarters
        -- 3 = Normal
        -- 4 = One and a Half
        -- 5 = Double (Strong)
        EffectMultiplier = 3,

        -- On by default. Home VHS tapes are somebody's birthdays, weddings and messages, and a few of them are hard to watch. Turn this off to leave home tapes alone and keep the effect on retail films only.  DECIDE THIS BEFORE YOU WATCH THEM. A home tape played with this off is still spent - the game marks it watched either way - so turning it back on later does nothing for a tape you have already seen until Rewatchable VHS makes it fresh again.
        HomeVideoMood = true,

        -- On by default. Adds what kind of tape it is, and what it will do to your mood, to the tape's hover tooltip, so you can pick a comedy on purpose instead of finding out after you have watched it. Turn this off if you would rather discover each tape by watching it.
        ShowGenre = true,
    },
    RET_LTS = {

        -- Enable Prone position, disable this option if you want to use another mod that implements this position (compatibility not guaranteed), Default: enabled.
        AllowProne = true,

        -- Aim Bonus while in Prone position. Min: 0 Max: 10 Default: 4
        ProneAimBonus = 6,

        -- Aim Bonus while in Crouching position. Min: 0 Max: 10 Default: 2
        CrouchAimBonus = 4,

        -- Base Speed when Getting Up/Down in Prone position, a higher value increases the speed. Min: 50 Max: 300 Default: 100
        VelocityPercent = 100,

        -- Pressing <Run/Sprint + Getting Up/Down> will increase speed in exchange for increased effort. Min: 100 Max: 300 Default: 200
        VelocityPercentAcceleration = 200,

        -- Pressing <Run/Sprint + Getting Up/Down> to get up faster will consume this energy in exchange for increasing speed, a higher value will increase energy used. Min: 0.00 Max: 1.00 Default: 0.28
        EnduraceUseWhenAccelerating = 0.28,
    },
    CyesPushDoors = {

        -- Scales damage dealt to zombies.
        -- 0 disables damage but keeps other effects. Default: 1.0. Min: 0.00 Max: 2.00 Default: 1.00
        ZombieDamageMultiplier = 1.0,

        -- Scales targets per regular impact for all supported doors.
        -- Forced opening always affects its entire eligible crowd; sliding glass doors remain capped at 3. Min: 0.25 Max: 2.00 Default: 1.00
        ZombiesAffectedMultiplier = 1.0,

        -- Scales how many eligible zombies a character can push through before an entrance blocks.
        -- It also changes the pressure used to calculate regular and forced door wear. Garages are excluded. Default: 1.0. Min: 0.50 Max: 2.00 Default: 1.00
        DoorBlockCapacityMultiplier = 1.0,

        -- Chance for a selected eligible zombie to fall during regular, closing, or forced impacts; otherwise it staggers.
        -- Arm strain can reduce it. Sliding glass doors never knock zombies down. Default: 35%. Min: 0 Max: 100 Default: 35
        ZombieKnockdownChance = 35,

        -- Scales every durability loss caused by Push Doors!.
        -- 0 disables regular, forced, and garage wear, including random garage failure. Default: 1.0. Min: 0.00 Max: 3.00 Default: 1.00
        DoorWearMultiplier = 1.0,

        -- Extra wear multiplier for successful forced openings.
        -- Stacks with Door Wear; 0 disables only forced-opening wear. Default: 1.0. Min: 0.00 Max: 3.00 Default: 1.00
        ForcedOpeningDoorWearMultiplier = 1.0,

        -- Extra wear multiplier for garage doors.
        -- Stacks with Door Wear. Default: 1.0. Min: 0.25 Max: 3.00 Default: 1.00
        GarageDoorWearMultiplier = 1.0,

        -- Scales garage failure from Strength and existing damage while Door Wear is above 0.
        -- 0 disables random failure, not normal wear. Default: 1.0. Min: 0.00 Max: 3.00 Default: 1.00
        GarageFailureChanceMultiplier = 1.0,

        -- Scales vanilla Endurance consumed by successful CPD impacts.
        -- 0 disables CPD drain; current Endurance still affects CPD. Default: 1.0. Min: 0.00 Max: 3.00 Default: 1.00
        EnduranceCostMultiplier = 1.0,

        -- Scales the normal chance of fracturing one healthy part of the selected arm: hand, forearm, or upper arm.
        -- At critical endurance, with both arms already at the strain limit, or when the selected arm reaches the limit after the action, fracture risk is always 100%. Default: 1.0. Min: 0.00 Max: 2.00 Default: 1.00
        ForcedOpeningFractureRiskMultiplier = 1.0,

        -- Scales strain added to both arms by regular successful impacts and to the selected arm during forced opening.
        -- It also applies before garage-specific strain. Min: 0.00 Max: 3.00 Default: 1.00
        ArmStrainGainMultiplier = 1.0,

        -- Scales the 20.00 limit and every penalty threshold.
        -- Both arms at the limit block CPD effects. Default: 1.0. Min: 0.25 Max: 5.00 Default: 1.00
        ArmStrainUsageLimitMultiplier = 1.0,

        -- Extra strain multiplier for garage impacts.
        -- Stacks with Arm Strain Gain. Default: 1.0. Min: 0.25 Max: 3.00 Default: 1.00
        GarageArmStrainMultiplier = 1.0,

        -- Scales how arm strain reduces damage and knockdown chance.
        -- Default: 1.0. Min: 0.00 Max: 2.00 Default: 1.00
        ArmStrainPenaltyMultiplier = 1.0,

        -- Scales the anti-spam recovery between CPD impacts: 1.60s at 0-4.99 arm strain, 2.00s light, and 2.50s medium/high.
        -- Low Endurance can add extra recovery time. Default: 1.0. Min: 0.25 Max: 3.00 Default: 1.00
        ArmStrainRecoveryMultiplier = 1.0,

        -- Allows impacts to damage other valid PvP players. On normal doors, fence gates, and double entrances, a stronger target blocks the regular interaction but can be hit through forced opening. Sliding and garage doors do not use the player Strength block.
        DamagePlayers = true,

        -- Allows eligible door impacts to knock down other valid PvP players. Regular impacts use Player Knockdown Chance; forced opening has a 100% knockdown chance across its two-square impact band.
        KnockDownPlayers = true,

        -- Maximum chance for regular impacts after comparing Strength and Fitness.
        -- Winning one stat halves it; winning neither sets it to 0. Forced opening uses 100% while Knock Down Players is enabled. Default: 25%. Min: 0 Max: 100 Default: 25
        PlayerKnockdownChance = 25,

        -- Allows door impacts to damage and stun crawling zombies.
        AffectCrawlers = true,

        -- Allows doors, fences, and double doors to apply mod effects from either side.
        -- Disabled by default. Garages and sliding doors are unaffected.
        AllowImpactsFromBothSides = true,

        -- In MP, locks each player's personal feedback controls and enforces Global Impact Feedback.
        -- The forced-opening shortcut remains available.
        HideIndividualOptions = false,

        -- When personal feedback controls are locked, controls messages, custom animations, and sound effects for everyone.
        GlobalImpactFeedback = true,
    },
    RVII = {

        -- Master switch. When off, RV interiors behave like vanilla PROJECT RV Interior: no windows, no siege.
        Enabled = true,

        -- How hard the interior hunts you. The longer you stay inside, the more zombies gather outside the windows. <LINE> <LINE> Tolerant: about 6 h safe, then the odd wave (~2 h apart) spawning far off. <LINE> Standard: about 2 h safe, then roughly one wave every 45 min. <LINE> Relentless: about 10 min safe, then roughly one wave every 5 min, spawning close. <LINE> <LINE> Leaving the interior only trims the time-inside counter by 25% - it does not reset it. <LINE> <LINE> Mirror: no time pressure. The besiegers at your windows are a live reflection of the real zombie horde around the parked vehicle. Kill them and the horde thins; fire a gun inside and you draw more; sit quiet and it wanders off. A finite fight, not a timer. Default = Mirror - reflects the real horde
        -- 1 = Tolerant - rare, distant sieges
        -- 2 = Standard - balanced pressure
        -- 3 = Relentless - constant, close sieges
        -- 4 = Mirror - reflects the real horde
        SiegeProfile = 4,

        -- Upper limit of windows cut into each RV interior. Fewer windows means fewer ways in - and fewer directions a siege can come from. Min: 1 Max: 12 Default: 3
        MaxWindows = 5,

        -- On: stepping past the edge of the interior teleports you back to the vehicle - a safety net for window climbs the game doesn't report. <LINE> <LINE> Off: only climbing through a window exits. Turn this off for large multi-room custom interiors where the far floor tiles sit outside the detected room bounds and wrongly kick you out.
        WalkOutExit = true,

        -- On: while you stand in the RV interior the sledgehammer "Destroy" action is blocked - walls, windows, furniture and barricades. The way out is a window climb or the walk-off exit, not smashing a hole into the void. <LINE> <LINE> Off: vanilla sledgehammer behaviour. <LINE> <LINE> Admins/moderators can still destroy (set in RVII_Constants.lua).
        BlockSledgehammer = true,

        -- On: a gunshot or a shout made INSIDE the interior also sounds at the RV's real parked position. The world horde converges on the vehicle - you meet them on the way out - and the siege on your windows escalates right away. <LINE> <LINE> Off: the interior is acoustically sealed; noise made inside stays inside.
        InteriorNoiseBridge = true,
    },
    DHCS = {

        -- Sets the shared base entry/exit time. Entry supports 0.25 to 30.0 seconds; exit retains its existing 1.0-second minimum. Admin toggles can disable body weight, carried bulk, hiding-place type, and trait modifiers for entry only. Disable all four entry-time modifiers to make entry use the configured base time for everyone. All defaults unchanged: 7.0 seconds; modifiers enabled. Multiplayer: Admin only. Min: 0.25 Max: 30.00 Default: 7.00
        BaseInteractionSeconds = 7.0,

        -- When enabled, actual body weight affects physical fit and body-weight limits. When disabled, use standard 80 kg body volume and ignore minimum/maximum body-weight limits; storage capacity, occupancy, and other safety checks still apply. Default: Enabled. Multiplayer: Admin only.
        FactorBodyWeightForFit = true,

        -- When enabled, carried inventory bulk affects physical fit and maximum carried-bulk restrictions. When disabled, carried gear cannot block entry by weight; stored items still occupy physical space. Default: Enabled. Multiplayer: Admin only.
        FactorInventoryWeightForFit = true,

        -- When enabled, survivor body weight may increase or decrease entry time. When disabled, body weight has no effect on entry time. Default: Enabled. Multiplayer: Admin only.
        FactorBodyWeightForEntryTime = true,

        -- When enabled, carried inventory bulk adds entry time. When disabled, carried inventory has no effect on entry time. Default: Enabled. Multiplayer: Admin only.
        FactorInventoryWeightForEntryTime = true,

        -- When enabled, certain hiding places (such as freezers) multiply entry time. When disabled, all hiding-place types use the same base entry time. Default: Enabled. Multiplayer: Admin only.
        FactorHidingPlaceForEntryTime = true,

        -- When enabled, Stealthy, Inconspicuous, or Graceful can shorten entry time. When disabled, those traits do not change entry time. Default: Enabled. Multiplayer: Admin only.
        FactorTraitsForEntryTime = true,

        -- Sets the base distance in tiles that entry noise can travel before Sneaking, Lightfooted, traits, carried bulk, panic, and stress modify it. Default: 8 tiles. Set to 10 tiles for the previous Hide Anywhere base balance. Valid range: 1 to 20 tiles. In multiplayer, only an Admin can change this server setting. Min: 1 Max: 20 Default: 8
        EntryNoiseRadiusTiles = 8,

        -- Allows survivors to sleep in supported hiding places that have room for a seated or lying posture. Upright lockers and wardrobes remain too cramped to sleep in. Danger, zombie pounding, cold, or discovery can wake the survivor. Default: Enabled. In multiplayer, only an Admin can change this server setting.
        AllowSleeping = true,

        -- Allows an eligible standing zombie to open a compromised hiding place and pull the survivor out after reaching it. This only works when Zombie Cognition is explicitly set to Navigate + Use Doors. It does not activate with Basic Navigation or Random cognition, and crawlers, prone zombies, and dead zombies cannot perform the pullout. Disabling this does not stop zombies from using ordinary doors; it only prevents them from pulling survivors from Hide Anywhere locations. Default: Enabled. In multiplayer, only an Admin can change this server setting.
        ZombiesCanPullPlayersFromHiding = true,

        -- Sets the server-wide default for opening the hidden status panel when a survivor enters a hiding place. Players can close the panel with X and can use their personal Hide Anywhere mod option to suppress it on entry. Default: Enabled. In multiplayer, only an Admin can change this server setting.
        ShowStatusPanelOnEntry = true,

        -- Allows hidden survivors to gain Sneaking XP when nearby zombies meet Hide Anywhere's stealth XP eligibility checks. Default: Enabled. In multiplayer, only an Admin can change this server setting.
        GrantSneakingXPWhileHidden = true,

        -- Allows hidden survivors to gain Lightfooted XP when nearby zombies meet Hide Anywhere's stealth XP eligibility checks. Default: Disabled. In multiplayer, only an Admin can change this server setting.
        GrantLightfootedXPWhileHidden = false,
    },
    PZTheMutants = {

        -- Percentage of zombies classified as Pukers. Min: 0.00 Max: 100.00 Default: 0.40
        PukerSpawnPercentage = 0.4,

        -- Percentage of zombies classified as Husks. Min: 0.00 Max: 100.00 Default: 0.40
        HuskSpawnPercentage = 0.4,

        -- Percentage of zombies classified as Skitter. Min: 0.00 Max: 100.00 Default: 0.40
        SkitterSpawnPercentage = 0.4,

        -- Percentage of zombies classified as Wreckers. Min: 0.00 Max: 100.00 Default: 0.40
        WreckerSpawnPercentage = 0.4,

        -- Percentage of zombies classified as Leapers. Min: 0.00 Max: 100.00 Default: 0.40
        LeaperSpawnPercentage = 0.4,

        -- Percentage of zombies classified as Weepers. Min: 0.00 Max: 100.00 Default: 0.40
        WeeperSpawnPercentage = 0.4,
    },
    CompanionCat = {

        -- Scales how often stray cats appear in houses, shops and pet stores. 1.0 is the normal rate, 2.0 doubles them, 0 turns cat spawns off. This is separate from the dog spawn setting: turning stray dogs down or off no longer takes the cats with them. Min: 0.00 Max: 5.00 Default: 1.00
        CatSpawnMultiplier = 1.0,
    },
    TAS = {

        -- Multiplies the XP that spectrums earn passively over time (resting staying healthy well fed and hydrated). 1.0 normal. 2.0 double. 0.5 half. 0.0 off. Min: 0.00 Max: 5.00 Default: 1.00
        XPGainPassiveMultiplier = 1.0,

        -- Multiplies the XP that spectrums lose passively over time (hunger thirst bad habits). 1.0 normal. 2.0 double. 0.5 half. 0.0 off. Min: 0.00 Max: 5.00 Default: 1.00
        XPLossPassiveMultiplier = 1.0,

        -- Multiplies the XP earned by playing (eating well reading healing killing zombies driving). 1.0 normal. 2.0 double. 0.5 half. 0.0 off. Min: 0.00 Max: 5.00 Default: 1.00
        XPGainActiveMultiplier = 1.0,

        -- Multiplies the XP lost through harmful actions while playing (rotten food smoking taking damage). 1.0 normal. 2.0 double. 0.5 half. 0.0 off. Min: 0.00 Max: 5.00 Default: 1.00
        XPLossActiveMultiplier = 1.0,

        -- Characters born deaf keep the trait forever. Turn it off to let them raise the Hearing spectrum and lose the trait.
        PermanentDeafness = true,

        -- Characters born shortsighted keep the trait forever. Turn it off to let them raise the Vision spectrum and lose the trait.
        PermanentShortsightedness = false,

        -- Multiplies the Hearing XP lost every shot fired. 1.0 normal. 2.0 double. 0.5 half. 0.0 disables hearing loss from gunfire. Min: 0.00 Max: 5.00 Default: 1.00
        ShootingHearingLossMultiplier = 0.75,

        -- This is the INITIAL level required in a trait skill for negative traits to be removed automatically. If the starting level is lower than this number, the player must level up to remove the spectrum's already-surpassed negative traits. Min: 0 Max: 10 Default: 10
        AutoRemoveNegativesAtLevel = 10,

        -- When ON, the 'Level down' line of the spectrum tooltip only shows the loss of positive traits that the character actually has. Turn it off to always show which positive traits a level would take away.
        TooltipLossesIfOwned = true,
    },
    Explosives = {

        -- Off by default. When enabled, the mod's custom throw arc and ground-target marker also apply to vanilla Pipe Bombs, Aerosol Bombs, Smoke Bombs, Flame Traps, Noise Traps, Firecrackers, and Molotov Cocktails (including their sensor, remote, and timer variants where they exist), instead of only this mod's own grenades.
        VanillaBallisticsEnabled = true,

        -- Multiplies the spawn chance of all grenades and mines in loot containers. 0.5 = half as frequent, 1.0 = default, 2.0 = twice as frequent. Min: 0.01 Max: 5.00 Default: 1.00
        LootMultiplier = 1.0,

        -- When enabled, zombies take additional damage while on fire, regardless of the fire source. Disable to use vanilla fire behavior.
        FireDamageEnabled = true,

        -- Multiplies additional fire damage to burning zombies. 0.5 is about 30 percent faster than vanilla, 1.0 is about twice as fast, and 5.0 is about five times faster. Min: 0.50 Max: 5.00 Default: 1.00
        FireDamageMultiplier = 1.0,

        -- Off by default. When enabled, this mod's own grenades (Mk2, M26, M67, M84 Flashbang, M14 TH3) land and sit armed for a few seconds before exploding, instead of detonating immediately on impact. Does not affect mines/Claymores (which already land as placed traps) or vanilla throwables.
        DelayedFuseEnabled = false,

        -- How many seconds a landed grenade sits armed before exploding, when Delayed Fuse on Landing is enabled. Min: 0.50 Max: 10.00 Default: 4.00
        DelayedFuseSeconds = 4.0,

        -- Off by default. When enabled, Shift + Numpad "+" (rebindable in Mod Options) spawns a single flashbang directly into your inventory for quick trajectory testing.
        DebugSpawnKeyEnabled = false,
    },
    HB = {

        -- Casings will stay in the floor after landing. Turn this off to make casings only visible while active.
        PermanentCasings = true,

        -- Enable custom icons for casings and bullets.
        CustomIcons = true,

        -- Enable sounds for casings hitting the floor.
        CasingSounds = true,

        -- Bandits will drop casings when shooting their guns.
        BanditsCasings = false,
    },
    MarzGuns = {

        -- Enable Vanilla Weapon Replacement with GoM counterpart.
        VanillaWeaponReplacement = true,

        -- Enable Vanilla Ammo Replacement with GoM counterpart.
        VanillaAmmoReplacement = true,

        -- Enable Vanilla Attachments Replacement with GoM counterpart.
        VanillaAttachmentReplacement = true,

        -- Scales how often Guns of Marz weapons, attachments and magazines are injected into world loot, vehicles and bags. 1.0 = default, higher = more common, 0 = disable GoM loot injection. Min: 0.00 Max: 100.00 Default: 1.00
        LootMultiplier = 1.0,

        -- Allow extended / drum magazines (50+ round AR, Russian drums, big pistol/SMG sticks) to appear in loot. Disable for a more grounded game.
        SpawnHighCapMags = true,

        -- Allow fragmentation grenades, smoke and incendiary devices to spawn in military and police loot. Off by default.
        SpawnExplosives = true,
    },
    FWOFitness = {

        -- Include the initial perk bonus: 75 percent, 100 percent, or 125 percent.
        InitialPerkBonus = true,

        -- Grants a bonus or penalty to XP for the exercise you just did, based on how regularly you've been training it. Strength depends on the Offset and Rate options below.
        currentExerciseRegularityBonus = true,

        -- The regularity percentage (0-100) at which the Current Exercise Regularity Bonus is neutral. Training this exercise more regularly than this gives bonus XP; less regularly gives a penalty. Min: 0 Max: 100 Default: 25
        currentExerciseOffset = 25,

        -- How strongly regularity above or below the Offset affects XP for this exercise. Higher values mean bigger bonuses for consistent training and bigger penalties for inconsistent training. Min: 0.01 Max: 100.00 Default: 5.00
        currentExerciseRate = 5.0,

        -- Bonus XP based on how regularly you train across ALL exercises combined, not just the one you're currently doing. Min: 0.00 Max: 100.00 Default: 6.00
        AverageExerciseRegularityBonus = 6.0,

        -- Extra XP multiplier per perk level. At level 5 with a value of 0.30, the bonus is 150 percent. Min: 0.00 Max: 100.00 Default: 0.30
        LevelBonus = 0.3,

        -- Applies an XP penalty if you train the same muscle group again too soon (while still sore from the last session, roughly within 8 in-game hours). Tracked separately for Fitness and Strength.
        SpaceOutExercise = true,

        -- XP multiplier while the Space Out Exercise penalty is active. For example, 0.90 means 10 percent less XP. Min: 0.00 Max: 100.00 Default: 0.90
        SpaceOutExerciseNegative = 0.9,

        -- Applies an XP penalty while you still have ongoing muscle soreness from a previous workout. No penalty once the soreness has worn off.
        RestedBonus = true,

        -- XP multiplier while the Rested Bonus penalty is active. For example, 0.90 means 10 percent less XP. Min: 0.00 Max: 10.00 Default: 0.90
        RestedBonusNegative = 0.9,

        -- Multiplies all XP gained from this mod's bonuses on top of vanilla XP. 1.0 = normal; use small steps (e.g. 1.1, 0.9) to fine-tune the pace. Min: 0.01 Max: 10.00 Default: 1.00
        XPMultiplier = 1.0,

        -- Controls how much this mod's bonuses affect XP gained OUTSIDE of active exercise, e.g. from fighting or sprinting. Set to 0 to disable passive XP changes entirely. Min: 0.00 Max: 10.00 Default: 1.00
        PassiveMultiplier = 1.0,

        -- Multiplier for how much exercise reduces Boredom. Set to 0 to disable this mod's boredom reduction. Min: 0.00 Max: 10.00 Default: 1.00
        BoredomMultiplier = 1.0,

        -- Multiplier for how much exercise reduces Unhappiness. Set to 0 to disable this mod's unhappiness reduction. Min: 0.00 Max: 10.00 Default: 1.00
        UnhappynessMultiplier = 1.0,

        -- When bags are automatically removed for exercise, drop them on the floor instead of keeping them in your inventory. Has no effect if Keep Bags Equipped is on.
        DropBags = true,

        -- Keep worn backpacks and bags equipped during exercise instead of automatically removing them first.
        KeepBagsOn = false,
    },
    FWOWorkingTreadmill = {

        -- Multiplier for the Fitness XP earned from treadmill exercise. 1.0 = normal. Requires a game/server restart to take effect for characters who have already exercised this session. Min: 0.00 Max: 100.00 Default: 1.00
        FitnessXPMultiply = 1.25,

        -- Multiplier for the Strength XP earned from weighted treadmill training and benchpress reps. 1.0 = normal. Min: 0.00 Max: 100.00 Default: 1.00
        StrengthXPMultiply = 1.5,

        -- Multiplier for the Sprinting XP earned from treadmill cardio sessions. 1.0 = normal. Min: 0.00 Max: 100.00 Default: 1.00
        SprintingXPMultiply = 1.25,

        -- Multiplier for the body heat you generate while exercising (0 = no heat gain, 1 = normal, 2 = double heat gain). Min: 0.00 Max: 5.00 Default: 1.00
        HeatMultiplier = 1.0,

        -- Multiplier for the thirst you build up while exercising (0 = no thirst gain, 1 = normal, 2 = double thirst gain). Min: 0.00 Max: 5.00 Default: 1.00
        ThirstMultiplier = 1.0,

        -- When a bag is automatically removed before using the treadmill, drop it on the floor instead of keeping it in your inventory. Has no effect if Keep Bags Equipped is on.
        TreadmillDropBags = true,

        -- When a bag is automatically removed before using the benchpress, drop it on the floor instead of keeping it in your inventory. Has no effect if Keep Bags Equipped is on.
        BenchpressDropBags = true,

        -- Keep worn backpacks and bags equipped during treadmill and benchpress exercise instead of automatically removing them first.
        BenchTreadKeepBagsOn = false,
    },
    BYDT = {

        -- The dental hygiene new characters begin with. Default = Random (pristine to fair)
        -- 1 = Random (any)
        -- 2 = Random (pristine to fair)
        -- 3 = Random (healthy to bad)
        -- 4 = Random (poor to rotting)
        -- 5 = Pristine
        -- 6 = Healthy
        -- 7 = Fair
        -- 8 = Poor
        -- 9 = Bad
        -- 10 = Rotting
        StartingHygiene = 5,

        -- When off, the short-term 'brush your teeth' moodle is hidden and its unhappiness effect is skipped. Brushing still updates your long-term hygiene silently. The other two dental mechanics are unaffected.
        MouthStateEnabled = true,

        -- How much the toothbrush counts in the effectiveness average; the toothpaste takes whatever is left to reach 100. So at 70 the brush weighs 70 and the paste 30. Min: 0 Max: 100 Default: 70
        BrushToPasteWeightRatio = 70,

        -- Flat effectiveness added when you rinse with water, applied after the weighted average and before the clamp. Default 0.10. Min: 0.00 Max: 0.50 Default: 0.10
        WaterBonusAmount = 0.1,

        -- If on, tainted water counts for the rinse bonus, including puddles, lakes and rivers. If off, only clean sources (sinks, wells, taps) count.
        AllowTaintedWater = true,

        -- Millilitres of water drained per brushing when rinsing. Min: 0 Max: 1000 Default: 50
        WaterPerBrushML = 50,

        -- If on, the Collect Fur action is only available on pigs. Fur remains obtainable from other animals by other means; this only limits the collect action.
        RestrictFurCollectToPigs = false,

        -- Stress added to an animal each time you collect fur from it. Min: 0.00 Max: 100.00 Default: 10.00
        FurStressPerCollect = 10.0,

        -- If on, you can also Check Teeth by right-clicking a window and using its reflection, not just mirrors. Off by default.
        WindowReflectionCheckTeeth = false,

        -- How many teeth your character has already lost when a new game begins. Clamped to the maximum teeth that can be lost. Affects phantom pain and the toothless state. Min: 0 Max: 500 Default: 0
        StartingTeethPulled = 0,

        -- Multiplier on the unhappiness a dirty mouth adds over time. 1.0 = mod default, 0 disables it. Min: 0.00 Max: 5.00 Default: 1.00
        MouthStateUnhappiness = 1.0,

        -- Multiplier on the unhappiness poor long-term dental hygiene adds over time. 1.0 = mod default, 0 disables it. Min: 0.00 Max: 5.00 Default: 1.00
        DentalHygieneUnhappiness = 1.0,

        -- Multiplier on the tooth pain poor long-term dental hygiene adds. 1.0 = mod default, 0 disables it. Min: 0.00 Max: 5.00 Default: 1.00
        DentalHygienePain = 1.0,

        -- How many teeth can be extracted before no new cavities form (no teeth left to decay). Set to 0 to disable the cavity mechanic entirely. Other dental problems, if added later, are not affected by this. Min: 0 Max: 500 Default: 32
        MaxTeethPulledOut = 32,

        -- Long-term dental hygiene (0.0-1.0) below which a cavity can start to develop. At or above it, low hygiene never causes a cavity. Default 0.50. Min: 0.00 Max: 1.00 Default: 0.50
        DentalRiskThreshold = 0.35,

        -- In-game hours an untreated cavity spends at each stage before worsening. A cavity climbs from early to dead over about four times this. Min: 1 Max: 720 Default: 96
        DentalStageProgressHours = 96,

        -- Enable Phantom Dental Pain: recurring, uncurable aches from teeth you've lost. Each episode builds up, peaks, then fades on its own; the more teeth you've lost, the worse it can get.
        PhantomEnabled = true,

        -- How fast an episode climbs one pain stage at a time up to its target. Faster means the pain ramps up sooner. Default = Very Fast
        -- 1 = Very Fast
        -- 2 = Fast
        -- 3 = Slow
        -- 4 = Very Slow
        -- 5 = Extremely Slow
        -- 6 = Slowest
        PhantomProgressionSpeed = 1,

        -- How long an episode stays at its worst (its target stage) before it starts fading. Default = Long
        -- 1 = Very Short
        -- 2 = Short
        -- 3 = Long
        -- 4 = Very Long
        -- 5 = Extremely Long
        -- 6 = Longest
        PhantomPeakDuration = 3,

        -- How fast an episode steps back down through the pain stages and finally disappears. Default = Fast
        -- 1 = Very Fast
        -- 2 = Fast
        -- 3 = Slow
        -- 4 = Very Slow
        -- 5 = Extremely Slow
        -- 6 = Slowest
        PhantomRegressionSpeed = 2,

        -- Long-term dental hygiene (0.0-1.0) below which a mouth infection can start. Independent of cavities and of how many teeth you have. Default 0.30. Min: 0.00 Max: 1.00 Default: 0.30
        InfectionThreshold = 0.2,

        -- In-game hours in one mouth-infection cycle. At the end of each cycle the infection worsens, holds, or regresses based on how much healing you built up. Also the dead-tooth interval. Min: 1 Max: 720 Default: 96
        InfectionCycleHours = 96,

        -- First Aid level at which the infection stages show their clinical names (Gingivitis, Periodontitis, Dental Abscess, Odontogenic Sepsis) instead of Mild/Moderate/Severe/Lethal. Presentation only. Min: 0 Max: 10 Default: 4
        InfectionTermFirstAidLevel = 4,

        -- A safety net, not the main way the infection kills. The Lethal stage already kills you on its own by draining your health: the head first, then the chest, then the whole body. If that takes too long for your taste, this kills you outright after this many full cycles at the Lethal stage, whatever your health. 0 kills the instant you reach Lethal. -1 turns the forced death off, so only the natural drain can kill you. Min: -1 Max: 100 Default: -1
        InfectionCyclesBeforeDeath = -1,

        -- At the Lethal stage the infection first drains your head's health, which on its own leaves you at about a third of your health. After this many full cycles at the Lethal stage it spreads to the chest (and then to the whole body if needed) and keeps draining until you die. 0 spreads it as soon as you reach Lethal. Antibiotics slow the drain, and beating the stage back restores the health it took. Min: 0 Max: 100 Default: 1
        InfectionSpreadCycles = 1,

        -- Scales the pain the mouth infection inflicts at each stage. 0 = painless, 2.0 = twice as painful. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionPainIntensity = 1.0,

        -- Scales how much healing an effective mouthwash rinse contributes toward beating the infection. Higher cures faster. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionHealMouthwash = 1.0,

        -- Scales how much healing an effective dose of antibiotics contributes toward beating the infection. Higher cures faster. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionHealAntibiotics = 1.0,

        -- Scales how much healing a good brushing day contributes toward beating the infection (mainly relevant at the Mild stage). Note this is not a single brushing but whether you brushed enough over the day (a 'good day'). Higher cures faster. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionHealGoodDay = 1.0,

        -- When off, no new cavities develop and existing cavity pain is suppressed. Tooth extraction and missing-teeth effects still work.
        CavityEnabled = true,

        -- When off, no mouth infection develops and any ongoing infection effect (pain, mood, health drain) is suppressed.
        InfectionEnabled = true,

        -- Chance (0.0-1.0) that a cavity starts on each risk check while your hygiene is below the threshold. Default 0.15. Min: 0.00 Max: 1.00 Default: 0.15
        DentalRiskChance = 0.15,

        -- In-game hours between two cavity risk checks. Lower means cavities appear sooner once hygiene is poor. Min: 1 Max: 168 Default: 6
        DentalRiskCheckHours = 6,

        -- Chance (0.0-1.0) that a mouth infection starts on each risk check while hygiene is below the threshold. Default 0.10. Min: 0.00 Max: 1.00 Default: 0.10
        InfectionRiskChance = 0.1,

        -- In-game hours between two mouth-infection risk checks. Min: 1 Max: 168 Default: 6
        InfectionRiskCheckHours = 6,

        -- Chance (0.0-1.0) that a phantom dental pain episode starts on each check, while you have lost teeth and none is already active. Min: 0.00 Max: 1.00 Default: 0.10
        PhantomRiskChance = 0.1,

        -- In-game hours between two phantom dental pain risk checks. Min: 1 Max: 168 Default: 6
        PhantomRiskCheckHours = 6,

        -- In-game hours a mouthwash rinse must be spaced from the last one to grant its infection-healing bonus again. Rinsing sooner still works and is still consumed - it just gives no infection benefit. Never blocks the action. Min: 0 Max: 168 Default: 4
        InfectionMouthwashCooldownHours = 4,

        -- In-game hours a dose of antibiotics must be spaced from the last one to grant its infection-healing bonus again. Taking them sooner still works normally - it just gives no infection benefit. Never blocks the action. Min: 0 Max: 168 Default: 4
        InfectionAntibioticsCooldownHours = 4,

        -- Scales the chance that a CRITICAL FAILURE of a cavity operation seeds a mouth infection (base: certain at the worst possible result, down to none at the fail/crit-fail boundary). 0 = a botched operation never causes an infection; 2.0 = twice as likely. Min: 0.00 Max: 5.00 Default: 1.00
        CritFailInfectionRisk = 1.0,

        -- Scales how fast the Lethal stage drains your health (head, then chest, then the whole body). Higher kills sooner. 0 stops the drain, so the infection can then only kill through the forced death setting. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionLethalLossMult = 1.0,

        -- Scales how much the mouth infection depresses your mood at each stage. 0 = no mood effect, 2.0 = twice as much. Min: 0.00 Max: 5.00 Default: 1.00
        InfectionUnhappyIntensity = 1.0,

        -- The number of teeth whose loss makes you 'toothless'. Set to 32 because a human mouth has 32 teeth. It's not recommended to change it or it would be unrealistic, unless you want to play as a non-human or someone with a genetic condition that gives them fewer or more teeth. Min: 1 Max: 500 Default: 32
        TotalTeeth = 32,

        -- When on, dental operations can fail (and critically fail). When off, an operation can never fail: any result that would have been a failure is promoted to a plain success, so the tooth is always saved / pulled. Critical successes are unaffected, and a non-failing operation never seeds a mouth infection.
        OperationsCanFail = true,

        -- What dental operations need to disinfect with. None: nothing is needed and the off hand stays empty. Dressing: a disinfected rag (handed back dirty), alcohol-soaked cotton balls or alcohol wipes only. Liquid: only a liquid antiseptic, either a container whose main liquid is disinfectant, alcohol, a spirit or mouthwash (a small dose is poured) or a mouthwash item; no dressings. Mouthwash only: only mouthwash, store-bought, homemade or makeshift. Any: any of the above. Default = Any
        -- 1 = None
        -- 2 = Dressing (rag, cotton balls, wipes)
        -- 3 = Liquid (alcohol, disinfectant, mouthwash)
        -- 4 = Mouthwash only
        -- 5 = Any
        OpDisinfection = 5,

        -- When on, Scrape Tooth and Fill Tooth need a mirror: a nearby wall or furniture mirror (you walk up to it and face it), a car mirror while seated in a vehicle, or a mirror in your inventory. Extract Tooth never needs one. When off, you can scrape and fill anywhere.
        OpRequireMirror = true,

        -- When you start Scrape Tooth or Fill Tooth from a tool, how far (in tiles, same floor and same room) the mod looks for a wall or furniture mirror to walk up to. 0 turns the search off, so only a car mirror or a mirror in your inventory counts. Min: 0 Max: 10 Default: 3
        OpMirrorSearchRadius = 3,

        -- How much of an operation's success is driven by your First Aid skill versus luck. 70 (default) = 70 percent skill, 30 percent random. 100 = pure skill; 0 = pure chance. Min: 0 Max: 100 Default: 70
        OpSkillWeightPercent = 70,

        -- A global nudge on every operation's result before its outcome tier is decided. Above 1.0 makes success (and critical success) more likely; below 1.0 makes failure more likely. 1.0 = unchanged. Min: 0.00 Max: 3.00 Default: 1.00
        OpSuccessMult = 1.0,

        -- Scales the pain you feel after an operation (all outcomes). 0 = painless, 2.0 = twice as painful. Min: 0.00 Max: 5.00 Default: 1.00
        OpPainIntensity = 1.0,

        -- Scales the stress inflicted by a failed or critically-failed operation. 0 = no stress, 2.0 = twice as much. Min: 0.00 Max: 5.00 Default: 1.00
        OpFailStressIntensity = 1.0,

        -- First Aid level required to attempt a Scrape. Min: 0 Max: 10 Default: 1
        OpScrapeFirstAidMin = 1,

        -- First Aid level at which a Scrape's success is effectively guaranteed. Below it, success chance scales up from the minimum. Min: 0 Max: 10 Default: 3
        OpScrapeFirstAidRec = 3,

        -- First Aid level required to attempt a Fill. Min: 0 Max: 10 Default: 2
        OpFillFirstAidMin = 2,

        -- First Aid level at which a Fill's success is effectively guaranteed. Min: 0 Max: 10 Default: 5
        OpFillFirstAidRec = 5,

        -- First Aid level required to attempt an Extraction. Min: 0 Max: 10 Default: 0
        OpExtractFirstAidMin = 0,

        -- First Aid level at which an Extraction's success is effectively guaranteed. Min: 0 Max: 10 Default: 2
        OpExtractFirstAidRec = 2,

        -- Durability (condition) of a normal toothbrush. Min: 1 Max: 1000 Default: 30
        ToothbrushCondition = 30,

        -- Durability (condition) of a homemade toothbrush. Min: 1 Max: 1000 Default: 30
        HomemadeToothbrushCondition = 20,

        -- Durability (condition) of a makeshift toothbrush. Min: 1 Max: 1000 Default: 10
        MakeshiftToothbrushCondition = 10,

        -- Lowest condition for a toothbrush (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 30
        ToothbrushHouseCondMin = 30,

        -- Highest condition for a toothbrush (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 90
        ToothbrushHouseCondMax = 90,

        -- Lowest condition for a toothbrush (all variants) found in trash. Min: 1 Max: 100 Default: 1
        ToothbrushTrashCondMin = 1,

        -- Highest condition for a toothbrush (all variants) found in trash. Min: 1 Max: 100 Default: 10
        ToothbrushTrashCondMax = 10,

        -- Number of uses in a full normal toothpaste. Min: 1 Max: 1000 Default: 100
        ToothpasteUses = 100,

        -- Number of uses in a full homemade toothpaste. Min: 1 Max: 1000 Default: 200
        HomemadeToothpasteUses = 200,

        -- Number of uses in a full makeshift toothpaste. Min: 1 Max: 1000 Default: 50
        MakeshiftToothpasteUses = 50,

        -- Lowest usage for a toothpaste (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 30
        ToothpasteHouseUsageMin = 30,

        -- Highest usage for a toothpaste (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 90
        ToothpasteHouseUsageMax = 90,

        -- Lowest usage for a toothpaste (all variants) found in trash. Min: 1 Max: 100 Default: 1
        ToothpasteTrashUsageMin = 1,

        -- Highest usage for a toothpaste (all variants) found in trash. Min: 1 Max: 100 Default: 10
        ToothpasteTrashUsageMax = 10,

        -- Number of uses in a full dental floss. Min: 1 Max: 1000 Default: 15
        FlossUses = 15,

        -- Number of uses in a full homemade dental floss. Min: 1 Max: 1000 Default: 10
        HomemadeFlossUses = 10,

        -- Number of uses in a full makeshift dental floss. Min: 1 Max: 1000 Default: 5
        MakeshiftFlossUses = 5,

        -- Lowest usage for a dental floss (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 30
        DentalFlossHouseUsageMin = 30,

        -- Highest usage for a dental floss (all variants) found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 90
        DentalFlossHouseUsageMax = 90,

        -- Lowest usage for a dental floss (all variants) found in trash. Min: 1 Max: 100 Default: 1
        DentalFlossTrashUsageMin = 1,

        -- Highest usage for a dental floss (all variants) found in trash. Min: 1 Max: 100 Default: 10
        DentalFlossTrashUsageMax = 10,

        -- Number of times a toothpick can be used before it's used up. Min: 1 Max: 1000 Default: 1
        ToothpickUses = 1,

        -- Lowest condition for a toothpick found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 100
        ToothpickHouseCondMin = 100,

        -- Highest condition for a toothpick found in a house (kitchen or bathroom). Min: 1 Max: 100 Default: 100
        ToothpickHouseCondMax = 100,

        -- Lowest condition for a toothpick found in trash. Only matters when toothpick uses is above 1. Min: 1 Max: 100 Default: 1
        ToothpickTrashCondMin = 1,

        -- Highest condition for a toothpick found in trash. Only matters when toothpick uses is above 1. Min: 1 Max: 100 Default: 10
        ToothpickTrashCondMax = 10,

        -- Brushing quality of a bare finger (no toothbrush), 0.0-1.0. Feeds the brush side of the effectiveness formula. Default 0.50. Min: 0.00 Max: 2.00 Default: 0.50
        FingerEfficiency = 0.5,

        -- Brushing quality of a normal toothbrush, 0.0-1.0. Feeds the brush side of the effectiveness formula. Default 1.00. Min: 0.00 Max: 2.00 Default: 1.00
        ToothbrushEfficiency = 1.0,

        -- Brushing quality of a homemade toothbrush, 0.0-1.0. Feeds the brush side of the effectiveness formula. Default 1.00. Min: 0.00 Max: 2.00 Default: 1.00
        HomemadeToothbrushEfficiency = 1.0,

        -- Brushing quality of a makeshift toothbrush, 0.0-1.0. Feeds the brush side of the effectiveness formula. Default 0.70. Min: 0.00 Max: 2.00 Default: 0.70
        MakeshiftToothbrushEfficiency = 0.7,

        -- Brushing quality of a normal toothpaste, 0.0-1.0. Feeds the paste side of the effectiveness formula. Default 1.00. Min: 0.00 Max: 2.00 Default: 1.00
        ToothpasteEfficiency = 1.0,

        -- Brushing quality of a homemade toothpaste, 0.0-1.0. Feeds the paste side of the effectiveness formula. Default 1.00. Min: 0.00 Max: 2.00 Default: 1.00
        HomemadeToothpasteEfficiency = 1.0,

        -- Brushing quality of a makeshift toothpaste, 0.0-1.0. Feeds the paste side of the effectiveness formula. Default 0.70. Min: 0.00 Max: 2.00 Default: 0.70
        MakeshiftToothpasteEfficiency = 0.7,

        -- Long-term dental hygiene gained per mouthwash rinse (0.0-1.0). Separate from flossing; the two stack. Default 0.05. Min: 0.00 Max: 1.00 Default: 0.06
        MouthwashGain = 0.06,

        -- Long-term dental hygiene gained per homemade-mouthwash rinse (0.0-1.0). As effective as store mouthwash by default. Default 0.05. Min: 0.00 Max: 1.00 Default: 0.06
        HomemadeMouthwashGain = 0.06,

        -- Long-term dental hygiene gained per makeshift-mouthwash rinse (0.0-1.0). A bit less effective than proper mouthwash. Default 0.03. Min: 0.00 Max: 1.00 Default: 0.02
        MakeshiftMouthwashGain = 0.02,

        -- Daily cap on mouthwash hygiene gain. Set below the per-rinse gain so a single rinse reaches the cap (one effective mouthwash per day); extra rinsing that day gives nothing. Separate from the floss limit. Default 0.04. Min: 0.00 Max: 1.00 Default: 0.04
        MouthwashGainLimitPerDay = 0.04,

        -- Number of rinses in a full bottle of mouthwash. Min: 1 Max: 1000 Default: 25
        MouthwashUses = 25,

        -- Number of rinses in a full homemade mouthwash. Min: 1 Max: 1000 Default: 20
        HomemadeMouthwashUses = 20,

        -- Number of rinses in a full makeshift mouthwash. Min: 1 Max: 1000 Default: 5
        MakeshiftMouthwashUses = 5,

        -- How many fill operations a dental drill lasts before it breaks. Min: 1 Max: 1000 Default: 40
        DentalDrillDurability = 40,

        -- How many fill operations a tooth filler lasts before it breaks. Min: 1 Max: 1000 Default: 40
        ToothFillerDurability = 40,

        -- Number of fills in a full tube of tooth cement. Min: 1 Max: 1000 Default: 20
        ToothCementUses = 20,

        -- Long-term dental hygiene gained per use (0.0-1.0). Min: 0.00 Max: 1.00 Default: 0.08
        FlossGain = 0.08,

        -- Long-term dental hygiene gained per use (0.0-1.0). Min: 0.00 Max: 1.00 Default: 0.06
        HomemadeFlossGain = 0.06,

        -- Long-term dental hygiene gained per use (0.0-1.0). Min: 0.00 Max: 1.00 Default: 0.04
        MakeshiftFlossGain = 0.04,

        -- Long-term dental hygiene gained per toothpick (0.0-1.0). Min: 0.00 Max: 1.00 Default: 0.02
        ToothpickGain = 0.02,

        -- Days without brushing before the mouth reaches the first bad level (Bad Breath). Min: 1 Max: 100 Default: 2
        DaysToFirstBadLevel = 4,

        -- Extra days without brushing to reach each next bad level. Min: 1 Max: 100 Default: 1
        DaysPerLevel = 3,

        -- Brushes needed in a day to count as a 'good' day for long-term hygiene. Set to 0 to disable long-term hygiene degradation. Min: 0 Max: 10 Default: 2
        MinBrushesForGoodDay = 2,

        -- Maximum gameplay streak that improves long-term hygiene (the display streak is uncapped). Min: 1 Max: 30 Default: 3
        StreakCap = 3,

        -- How many brushes per day can grant the hygiene bonus. You can still brush more than this, but the extra brushes just give no bonus. Min: 1 Max: 12 Default: 3
        DailyBrushBonusLimit = 3,

        -- In-game hours that must pass after a rewarded brush before another brush can grant the bonus again. Set to 0 to disable the cooldown. Min: 0 Max: 24 Default: 4
        BrushBonusCooldownHours = 4,

        -- Lowest an effectiveness value can be. Must be below the maximum clamp, or all formula values revert to defaults (a warning is logged). Default 0.50. Min: 0.00 Max: 1.00 Default: 0.50
        EffMinClamp = 0.5,

        -- Highest an effectiveness value can be. Must be above the minimum clamp, or all formula values revert to defaults (a warning is logged). Default 1.20. Min: 1.00 Max: 2.00 Default: 1.20
        EffMaxClamp = 1.2,

        -- Once the day's accumulated floss hygiene gain exceeds this, extra flossing that day gives nothing (and isn't consumed). The item crossing the limit still applies its full gain. Min: 0.00 Max: 1.00 Default: 0.04
        FlossGainLimitPerDay = 0.04,

        -- How long brushing your teeth (or cleaning your mouth) takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 320
        BrushActionTime = 320,

        -- How long flossing takes (all dental floss variants), in action time units. Lower is faster. Min: 10 Max: 2000 Default: 200
        FlossActionTime = 200,

        -- How long picking your teeth with a toothpick takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 120
        ToothpickActionTime = 120,

        -- How long rinsing with mouthwash takes (all variants), in action time units. Lower is faster. Min: 10 Max: 2000 Default: 200
        MouthwashActionTime = 200,

        -- How long checking your teeth (or mouth) takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 160
        CheckTeethActionTime = 160,

        -- How long the Scrape Tooth operation takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 400
        OpScrapeActionTime = 400,

        -- How long the Fill Tooth operation takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 450
        OpFillActionTime = 450,

        -- How long the Extract Tooth operation takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 310
        OpExtractActionTime = 310,

        -- How long collecting fur from an animal takes, in action time units. Lower is faster. Min: 10 Max: 2000 Default: 120
        CollectFurActionTime = 120,

        -- Multiplies the vanilla mirror's existing loot-table chances everywhere it spawns. 1.0 = vanilla default, 0 = mirror no longer spawns as world loot. Does not affect the bonus OnFillContainer spawns. Min: 0.00 Max: 5.00 Default: 1.00
        MirrorProcMultiplier = 1.0,

        -- Multiplies the vanilla toothbrush's existing loot-table chances everywhere it spawns. 1.0 = vanilla default, 0 = toothbrush no longer spawns as world loot. Does not affect the bonus OnFillContainer spawns. Min: 0.00 Max: 5.00 Default: 1.50
        ToothbrushProcMultiplier = 2.0,

        -- Multiplies the vanilla toothpaste's existing loot-table chances everywhere it spawns. 1.0 = vanilla default, 0 = toothpaste no longer spawns as world loot. Does not affect the bonus OnFillContainer spawns. Min: 0.00 Max: 5.00 Default: 2.00
        ToothpasteProcMultiplier = 2.0,

        -- Multiplies the vanilla dental floss's existing loot-table chances everywhere it spawns. 1.0 = vanilla default, 0 = dental floss no longer spawns as world loot. Does not affect the bonus OnFillContainer spawns. Min: 0.00 Max: 5.00 Default: 1.00
        DentalFlossProcMultiplier = 1.0,

        -- Loot-table chance for the homemade toothbrush in bathrooms. A roll value, not a percentage: higher is more common. Min: 0.00 Max: 100.00 Default: 0.00
        HomemadeToothbrushProcChance = 0.0,

        -- Loot-table chance for the homemade toothpaste in bathrooms. A roll value, not a percentage: higher is more common. Default 0.6 (very rare). Min: 0.00 Max: 100.00 Default: 0.60
        HomemadeToothpasteProcChance = 0.6,

        -- Loot-table chance for the homemade dental floss in bathrooms. A roll value, not a percentage: higher is more common. Min: 0.00 Max: 100.00 Default: 0.00
        HomemadeDentalFlossProcChance = 0.0,

        -- Loot-table chance for the makeshift toothbrush in bathrooms. A roll value, not a percentage: higher is more common. Min: 0.00 Max: 100.00 Default: 0.00
        MakeshiftToothbrushProcChance = 0.0,

        -- Loot-table chance for the makeshift toothpaste in bathrooms. A roll value, not a percentage: higher is more common. Min: 0.00 Max: 100.00 Default: 0.00
        MakeshiftToothpasteProcChance = 0.0,

        -- Loot-table chance for the makeshift dental floss in bathrooms. A roll value, not a percentage: higher is more common. Min: 0.00 Max: 100.00 Default: 0.00
        MakeshiftDentalFlossProcChance = 0.0,

        -- Loot-table chance for the toothpick in kitchens and bars. A roll value, not a percentage: higher is more common. Default 10 (common). 0 removes it from those loot tables. Min: 0.00 Max: 100.00 Default: 10.00
        ToothpickProcChance = 10.0,

        -- Loot-table chance for coconut oil in kitchens. A roll value, not a percentage: higher is more common. Default 2 (about baking-soda rarity). 0 removes it from kitchens. Min: 0.00 Max: 100.00 Default: 2.00
        CoconutOilKitchenProcChance = 2.0,

        -- Loot-table chance for coconut oil in grocery baking/dry goods. A roll value, not a percentage: higher is more common. Default 1.6 (slightly rarer than kitchens). 0 removes it from grocery stores. Min: 0.00 Max: 100.00 Default: 1.60
        CoconutOilShopProcChance = 1.6,

        -- Loot-table chance for coconut oil in bathrooms (rarer than kitchens/grocery). A roll value, not a percentage: higher is more common. Default 0.7 (very rare, about as common as homemade toothpaste). 0 removes it from bathrooms. Min: 0.00 Max: 100.00 Default: 0.70
        CoconutOilBathroomProcChance = 0.7,

        -- Loot-table chance for mouthwash in bathrooms, alongside toothbrushes and floss. A roll value, not a percentage: higher is more common. Default 4. 0 removes it. Min: 0.00 Max: 100.00 Default: 4.00
        MouthwashBathroomProcChance = 4.0,

        -- Loot-table chance for mouthwash in the household/toiletries aisle of general grocery stores (with toothbrushes, toothpaste and floss). A roll value, not a percentage. Default 3. 0 removes it from shops. Min: 0.00 Max: 100.00 Default: 3.00
        MouthwashShopProcChance = 3.0,

        -- Loot-table chance for the dental drill in hospital/dentist tool storage. A roll value, not a percentage. Rare (one of three fill tools). Default 1. 0 removes it. Min: 0.00 Max: 100.00 Default: 1.00
        DentalDrillProcChance = 1.0,

        -- Loot-table chance for the tooth filler in hospital/dentist tool storage. A roll value, not a percentage. Rare (one of three fill tools). Default 1. 0 removes it. Min: 0.00 Max: 100.00 Default: 1.00
        ToothFillerProcChance = 1.0,

        -- Loot-table chance for tooth cement in hospital/dentist tool storage. A roll value, not a percentage. Rare (one of three fill tools). Default 1. 0 removes it. Min: 0.00 Max: 100.00 Default: 1.50
        ToothCementProcChance = 1.5,

        -- How common toothbrush is in trash bins, as a loot weight (not a percentage). Set low for rarity: the default ~0.5 makes roughly one bin in ten hold one. 0 removes it from bins. Min: 0.00 Max: 100.00 Default: 0.50
        ToothbrushTrashProcChance = 0.5,

        -- How common toothpaste is in trash bins, as a loot weight (not a percentage). Set low for rarity: the default ~0.5 makes roughly one bin in ten hold one. 0 removes it from bins. Min: 0.00 Max: 100.00 Default: 0.50
        ToothpasteTrashProcChance = 0.5,

        -- How common dental floss is in trash bins, as a loot weight (not a percentage). Set low for rarity: the default ~0.5 makes roughly one bin in ten hold one. 0 removes it from bins. Min: 0.00 Max: 100.00 Default: 0.40
        DentalFlossTrashProcChance = 0.4,

        -- How common toothpick is in trash bins, as a loot weight (not a percentage). Set low for rarity: the default ~0.5 makes roughly one bin in ten hold one. 0 removes it from bins. Min: 0.00 Max: 100.00 Default: 0.60
        ToothpickTrashProcChance = 0.6,
    },
    NaturesCall = {

        -- Multiplier applied to bladder filling over time. Min: 0.10 Max: 5.00 Default: 1.00
        BladderRateMult = 1.0,

        -- Multiplier applied to bowel filling over time. Min: 0.10 Max: 5.00 Default: 1.00
        BowelRateMult = 1.0,

        -- Multiplier applied to chance-based accidents from fill pressure, overflow, and incontinence. Min: 0.10 Max: 5.00 Default: 1.00
        AccidentChanceMult = 1.0,

        -- Multiplier applied to how much is released and how harsh the consequences are for non-forced accidents. Min: 0.10 Max: 5.00 Default: 1.00
        AccidentSeverityMult = 1.0,

        -- Multiplier applied to wipe supply consumption when cleaning after relief and accidents. Min: 0.10 Max: 5.00 Default: 1.00
        WipeNeedMult = 1.0,

        -- Multiplier applied to relief and wiping action duration. Min: 0.10 Max: 5.00 Default: 1.00
        WipeDurationMult = 1.0,

        -- When checked, gut health stays at a constant neutral and your diet no longer causes cramps, diarrhea, constipation, heartburn or any other good/bad gut effects. Eating and drinking still track and fill your bladder and bowels, and you can still get sick from rotten or tainted food and normal vanilla food effects. Can be changed mid-game (single-player and multiplayer).
        DisableGutSystem = false,

        -- Multiplier applied to how quickly gut health improves or worsens from diet. Min: 0.10 Max: 5.00 Default: 1.00
        GutTrendMult = 1.0,

        -- Multiplier applied to the duration of stomach effects (cramps, heartburn, diarrhea, constipation, laxative, sugar/water/caffeine highs, binge fatigue) when they are triggered or extended. Lower values let effects wear off faster. Min: 0.10 Max: 5.00 Default: 1.00
        EffectDurationMult = 1.0,

        -- Multiplier applied to discomfort and unhappiness from wearing soiled clothing. Set to 0 to disable these penalties. Min: 0.00 Max: 5.00 Default: 1.00
        SmellPenaltyMult = 1.0,

        -- Multiplier applied to zombie attraction radius from player soilage, dropped soiled items, exposed waste, and foul toilets. Set to 0 to disable smell-based attraction. Min: 0.00 Max: 5.00 Default: 1.00
        ZombieSmellRangeMult = 1.0,

        -- Multiplier applied to unhappiness from using unflushed toilets and to nearby foul-toilet smell severity. Set to 0 to disable these penalties. Min: 0.00 Max: 5.00 Default: 1.00
        ToiletPenaltyMult = 1.0,

        -- Multiplier applied to trait modifiers such as fill rates, control, soilage penalties, and accident scaling. Min: 0.00 Max: 5.00 Default: 1.00
        TraitIntensityMult = 1.0,

        -- Minimum accumulated scale (servings) before a food category's per-hour effects (bowel rate, control, mood, sleepiness) start applying. Higher values mean you must eat more of a category in a short window before its effects engage. Default 1.0 means roughly 2-3 servings. Min: 0.50 Max: 3.00 Default: 1.00
        CategoryActivationThreshold = 1.0,

        -- How fast a food category's effect fades per game hour once you stop eating it. Higher means effects wear off quicker. Default 0.50: a heavy meal's effect lasts about 1-3 hours and a single snack fades in well under an hour. Min: 0.05 Max: 1.00 Default: 0.50
        CategoryScaleDecayPerHour = 0.5,

        -- Multiplier applied to the per-hour magnitude of active food category effects and binge penalties. Higher values make the effects hit harder while active. Default 1.5. Min: 0.50 Max: 3.00 Default: 1.50
        CategoryIntensityScale = 1.5,
    },
    GasPumpIndicator = {

        -- Adds the pump's remaining fuel to its right-click menu.
        -- Vanilla shows this number in debug mode only.
        ShowFuelAmount = false,
    },
    Text = {

        -- Enable/disable all mechanics related to Music (moodles, traits, interactions, ...).
        DividerMusicNew = true,

        -- Enable/disable all mechanics related to Dancing (moodles, traits, interactions, ...).
        DividerDancingNew = true,

        -- Enable/disable all mechanics related to Meditation and Yoga (moodles, traits, interactions, ...).
        DividerMeditationNew = true,

        -- Enable/disable all mechanics related to Hygiene and Cleaning (moodles, traits, interactions, ...).
        DividerHygiene = true,

        -- Enable/disable all mechanics related to Art (moodles, traits, interactions, ...).
        DividerArt = true,

        -- This is only a line separator, checking it has no effect.
        LSDividerOther = false,

        -- This is only a line separator, checking it has no effect.
        DividerDebug = false,
    },
    LSAmbt = {

        -- Toggle ambitions on or off. Warning: Disabling this will reset all current player progress on ambitions.
        Toggle = true,

        -- The number of in game hours that must pass before a player can toggle on or off a recently activated/deactivated ambition again. Min: 1 Max: 1000 Default: 36
        Cooldown = 36,

        -- The maximum number of incomplete ambitions players can activate and pursue. Passive ambitions are excluded. Min: 1 Max: 100 Default: 1
        MaxInProgress = 1,

        -- The maximum number of ambitions players can activate overall, including both completed and in-progress ambitions. Min: 1 Max: 100 Default: 3
        MaxTotal = 3,

        -- Whether or not resets after editing ambitions' goals apply for players currently working towards them. Forced resets still apply for everyone.
        ResetException = false,

        -- Hidden ambitions won't display clues on how to unlock them.
        HideTips = false,
    },
    Music = {

        -- Controls how strong music related activities are for the musician. Higher values increase their effectiveness on mood and xp gains. Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        StrengthMultiplier = 2,

        -- Controls how strong the effects of listening to music are. Higher values increase it's effectiveness on mood. Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        ListeningStrengthMultiplier = 2,

        -- Chance of learning a new song when practicing with an instrument. Music level 2 is required to start learning songs. Default = Normal
        -- 1 = Very Difficult
        -- 2 = Difficult
        -- 3 = Normal
        -- 4 = Easy
        -- 5 = Very Easy
        LearningChance = 3,

        -- Whether or not playing music is physically taxing. Default = Enabled
        -- 1 = Enabled
        -- 2 = Practicing only
        -- 3 = Disabled
        Metabolics = 1,
    },
    Dancing = {

        -- Controls how powerful dancing is. Higher values increase it's effectiveness. Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        StrengthMultiplier = 2,
    },
    Meditation = {

        -- Controls how powerful meditation is. Higher values increase it's effectiveness. Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        StrengthMultiplier = 2,

        -- Controls the duration of all mindfulness states. Default = Normal
        -- 1 = Short
        -- 2 = Normal
        -- 3 = Long
        MindfulnessDuration = 2,

        -- How much healing occurs during the Perfect Mindfulness state.
        -- The amount varies depending on your character overall health and game-time settings. Min: 0.00 Max: 10.00 Default: 2.00
        HealFactor = 2.0,

        -- Controls the effectiveness of the mindfulness states bonuses (stress, pain, panic, etc...). Default = Normal
        -- 1 = Weak
        -- 2 = Normal
        -- 3 = Strong
        EffectMultiplier = 2,

        -- Enable/Disable keeping bags and backpacks on during Meditation at lower skill levels.
        KeepBags = false,
    },
    LSMeditation = {

        -- Tick this box to disable levitation at higher levels.
        RemoveLevitation = false,
    },
    Yoga = {

        -- Controls how powerful yoga is. Higher values increases the effectiveness of it's benefits. Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        StrengthMultiplier = 2,

        -- How exhausted a character has to be before he's unable to practice Yoga. Default = At medium exhaustion (default)
        -- 1 = None (disable the threshold)
        -- 2 = At low exhaustion
        -- 3 = At medium exhaustion (default)
        -- 4 = At high exhaustion
        Exhaustion = 3,

        -- How embarrassed a character has to be before he's unable to practice Yoga. Default = At low embarrassment (default)
        -- 1 = None (disable the threshold)
        -- 2 = At low embarrassment (default)
        -- 3 = At medium embarrassment
        -- 4 = At high embarrassment
        Embarrassment = 2,

        -- Enable/Disable mats and incenses improving Yoga.
        AidObjects = true,

        -- Enable/Disable Yoga mat requirement for practicing the activity.
        RequiresMat = false,

        -- Enable/Disable keeping bags and backpacks on during Yoga.
        KeepBags = false,

        -- How often a character loses balance and falls during difficult Yoga poses (affected by skill). Default = Often (default)
        -- 1 = Never
        -- 2 = Rarely
        -- 3 = Sometimes
        -- 4 = Often (default)
        -- 5 = Very Often
        -- 6 = Two Left Feet (almost always)
        FailChance = 4,

        -- Yoga. Values below 1.0 decrease XP gain. Min: 0.10 Max: 5.00 Default: 1.00
        YogaXPMultiplier = 1.0,

        -- Fitness. Values below 1.0 decrease XP gain. Min: 0.10 Max: 5.00 Default: 1.00
        FitnessXPMultiplier = 1.0,

        -- Nimble. Values below 1.0 decrease XP gain. Min: 0.10 Max: 5.00 Default: 1.00
        NimbleXPMultiplier = 1.0,
    },
    LSHygiene = {

        -- Values below 1.0 decrease the rate, set it to 0 stop the need from increasing. Min: 0.00 Max: 3.00 Default: 1.00
        HygieneNeedMultiplier = 1.0,

        -- Values below 1.0 decrease the rate, set it to 0 stop the need from increasing. Min: 0.00 Max: 3.00 Default: 1.00
        BladderNeedMultiplier = 0.0,

        -- How many survived days it takes for a new survivor to care about hygiene. Default = 4-12 days
        -- 1 = 1-3 days
        -- 2 = 4-12 days
        -- 3 = 2-4 weeks
        -- 4 = 1-3 months
        HygieneNeedExpectationTime = 2,

        -- Whether or not showering and bathing cleans body and facial makeup.
        CleansMakeup = true,

        -- Characters won't mind having others around while bathing or using the toilet.
        NotEmbarrassed = false,

        -- Toilets and other fixtures can be cleaned even while clogged.
        CleanClogged = false,

        -- How weak or strong the sickness from low hygiene can be. Default = Mild
        -- 1 = Low
        -- 2 = Mild
        -- 3 = High
        -- 4 = Deadly
        ColdSeverity = 2,

        -- Values below 1.0 lower the chance, set it to 0 to disable the mechanic. Min: 0.00 Max: 3.00 Default: 0.00
        ColdChanceMultiplier = 0.0,

        -- XY distance in tiles occupied by each outhouse. Min: 1 Max: 100 Default: 10
        OuthouseRange = 10,

        -- How many survived days it takes for a new survivor to care about their surroundings. Default = 4-12 days
        -- 1 = 1-3 days
        -- 2 = 4-12 days
        -- 3 = 2-4 weeks
        -- 4 = 1-3 months
        CleaningExpectationTime = 2,

        -- Chance for an unskilled character to generate waste during a skill-based activity (e.g. food scraps from cooking with low cooking skill). Default = Normal
        -- 1 = Very Low
        -- 2 = Low
        -- 3 = Normal
        -- 4 = High
        CleaningLitterChance = 3,
    },
    LSArt = {

        -- Modifies the default beauty value of all tiles, except player artworks. Min: 0.10 Max: 3.00 Default: 1.00
        GeneralBeautyMultiplier = 1.0,

        -- Whether or not beauty need can drop to negative levels when outdoors.
        BeautyOutdoors = false,

        -- Whether or not negative beauty scores can appear above outdoor tiles (will always appear if ugly outdoors is enabled).
        BeautyShowNegative = false,

        -- The rate at which beauty needs decreases when around ugly or neutral environments. Default = Normal
        -- 1 = Very Slow
        -- 2 = Slow
        -- 3 = Normal
        -- 4 = Fast
        -- 5 = Very Fast
        BeautyNeedDecayRate = 3,

        -- How strong the effects on mood from satisfying or neglecting a character's beauty need are. Default = Normal
        -- 1 = Very Weak
        -- 2 = Weak
        -- 3 = Normal
        -- 4 = Strong
        -- 5 = Very Strong
        BeautyNeedStrength = 3,

        -- Values below 1.0 lower the effect of artworks on beauty score. Min: 0.10 Max: 4.00 Default: 1.00
        ArtworkBeautyMultiplier = 1.0,
    },
    LS = {

        -- Whether or not traits can be lost or gained dynamically.
        DynamicTraits = true,

        -- Whether or not positive traits can be lost when DLT is enabled.
        --  - Never: will never lose positive traits
        --  - Always: can lose any lifestyle trait
        --  - Dynamic only: can only lose traits gained dynamically, will never lose positive traits picked during character creation Default = Never
        -- 1 = Never
        -- 2 = Always
        -- 3 = Dynamic only
        DynamicTraitsReverse = 1,

        -- This is only a line separator, checking it has no effect.
        DividerServer = false,

        -- How often in game time player moddata is updated. Do not change this if you don't know what this is. Default = Set by day length (default)
        -- 1 = Set by day length (default)
        -- 2 = Once per minute
        -- 3 = Per 2 minutes
        -- 4 = Per 5 minutes
        -- 5 = Per 10 minutes
        -- 6 = Per 15 minutes
        -- 7 = Per 30 minutes
        -- 8 = Once per hour
        -- 9 = Per 2 hours
        -- 10 = Per 6 hours
        -- 11 = Per 12 hours
        -- 12 = Once per day
        ModdataUpdate = 1,

        -- How often in game time changes to mood are applied. Only affects passive mood gain/loss (not timed actions) Default = Set by day length (default)
        -- 1 = Set by day length (default)
        -- 2 = Once per minute
        -- 3 = Per 2 minutes
        -- 4 = Per 5 minutes
        -- 5 = Per 10 minutes
        -- 6 = Per 15 minutes
        -- 7 = Per 30 minutes
        -- 8 = Once per hour
        -- 9 = Per 2 hours
        MoodUpdate = 1,
    },
    LSComfort = {

        -- Values below 1.0 decrease the rate, set it to 0 to stop the need from increasing. Min: 0.00 Max: 3.00 Default: 1.00
        ComfortNeedMultiplier = 1.0,

        -- Check to disable comfy chairs and beds giving positive comfort.
        ComfortPositive = false,

        -- Check to stop Lifestyle's Comfort need from impacting vanilla's Discomfortable moodle.
        ComfortNoImpact = false,
    },
    Debug = {

        -- Enabling this will cause other modded moodles to appear above lifestyle moodles.
        MoodlePriority = false,

        -- Enables manual expressions in the admin context menu
        Expressions = false,

        -- Enabling this will make animation names appear above some of the new animations
        DanceAnim = false,

        -- Prints texts. For debugging only.
        LSVerbose = false,
    },
    CWModpackCompatibility = {

        -- Enabled by default when both mods are active. Disables Lifestyle's bladder progression and relief actions so Nature's Call exclusively handles urination and bowel needs. Lifestyle's cleaning, grooming, bathing integration, and other hobbies remain available.
        NaturesCallOwnsBathroomNeeds = true,

        -- Enabled by default. If Nature's Call ownership is inactive and an older preset left Lifestyle's bladder multiplier at zero, restores Lifestyle's default multiplier of 1. Disable this before intentionally turning off Lifestyle's bathroom need while Nature's Call is absent.
        RestoreLifestyleBathroomNeedsWhenUnowned = true,

        -- Enabled by default when both mods are active. Removes Lifestyle's brushing actions so Brush Your Damn Teeth exclusively controls brushing, item wear, dental hygiene, and dental consequences. Other Lifestyle mirror, cabinet, grooming, and hygiene actions remain available.
        BrushYourDamnTeethOwnsDentalHygiene = true,

        -- Enabled by default. Keeps Lifestyle's personal hygiene need neutral and hides its clean/dirty hygiene moodles. Lifestyle cleaning actions and skills remain enabled. PZ Pulse Expanded omits the Lifestyle hygiene bar when its compatible adapter is installed. Restart after changing this option.
        DisableLifestyleHygieneNeed = true,

        -- Players visibly react when damaged by a Bandit NPC firearm, melee weapon, or bare-hand attack. Disable this if hit reactions interfere with another combat or animation mod. This does not change damage or wounds.
        BanditPlayerHitReactions = false,

        -- Minimum time between visible reactions. Increase this to reduce repeated interruption from rapid attacks, or use 0 for no cooldown. The default is 750 milliseconds. Min: 0 Max: 3000 Default: 750
        BanditPlayerHitReactionCooldownMs = 1000,

        -- Chance that confirmed damage from a Bandit NPC firearm produces a visible player reaction. This does not change firearm accuracy or damage. Min: 0 Max: 100 Default: 100
        BanditPlayerFirearmReactionChance = 100,

        -- Chance that confirmed damage from a Bandit NPC melee weapon or bare-hand attack produces a visible player reaction. This does not change melee damage. Min: 0 Max: 100 Default: 100
        BanditPlayerMeleeReactionChance = 100,
    },
    GurneyTransport = {

        -- How tiring it is to push a loaded gurney. At 100, a full gurney tires you about as fast as jogging, and an empty one costs nothing extra. 0 makes pushing free, 200 makes it twice as tiring. At 875, pushing a full gurney is as tiring as dragging one body by hand. Min: 0 Max: 1000 Default: 100
        PushEffort = 100,

        -- When on, a gurney carries anything, not just bodies, so it doubles as a loot cart. The heavier the load, the more tiring it is to push. When off, only bodies can go on a gurney, and anything already on one stays there.
        LootOnGurney = true,
    },
    Genset = {

        -- How common the trailer generator is in the contractor, carpenter, junkyard, farm, LectroMax and Fossoil zones it spawns in. This is a share of those zones, so making it commoner makes everything else parked there rarer. Uncommon is the default and is roughly one vehicle in thirty-five. Choosing "Never" keeps it out of the world entirely. Default = Uncommon
        -- 1 = Never
        -- 2 = Rare
        -- 3 = Uncommon
        -- 4 = Common
        -- 5 = Everywhere
        SpawnFrequency = 3,

        -- How fast a running generator drains the trailer's own tank, as a percentage of what a vanilla generator would burn. 100 is identical to vanilla. This stacks with the game's own Generator Fuel Consumption setting. 0 means it runs forever without drinking. Min: 0 Max: 500 Default: 100
        FuelUse = 100,

        -- How fast a running generator loses condition, as a percentage of vanilla's rate. 100 is identical to vanilla - a 1 in 30 chance each running hour of losing 1 or 2 condition. Repairs are never scaled, only wear. 0 means it never wears out. Min: 0 Max: 500 Default: 100
        Wear = 100,

        -- What condition the generator is in on a trailer you have just found. Rolled once per trailer and then kept for good. Pristine is the default. Default = Pristine (100%)
        -- 1 = Pristine (100%)
        -- 2 = Used (60-100%)
        -- 3 = Worn (30-90%)
        -- 4 = Anything (1-100%)
        FoundCondition = 1,
    },
    MaskaradsSummerCar = {

        -- Shifts newly initialized vehicles toward better or worse coherent engine loadouts. Only affects vehicles initialized after the setting is applied. Default = Normal
        -- 1 = Very poor
        -- 2 = Poor
        -- 3 = Normal
        -- 4 = Good
        -- 5 = Very good
        LoadoutQuality = 3,

        -- Controls how many components may be absent from newly initialized vehicles. Optional and service parts are more likely to be missing than critical internals. Default = Common
        -- 1 = None
        -- 2 = Rare
        -- 3 = Normal
        -- 4 = Common
        -- 5 = Severe
        MissingParts = 4,

        -- Chance that each newly generated component belongs to a different Standard, Heavy-Duty, or Sport class. The transmission pair always stays internally consistent. Min: 0 Max: 100 Default: 10
        CrossClassChance = 10,

        -- Chance that a newly initialized vehicle receives a manual transmission and clutch instead of an automatic transmission and torque converter. Min: 0 Max: 100 Default: 50
        ManualTransmissionChance = 50,

        -- Legendary chance for newly created MSC components. Lower values make legendary parts more common; 350 means one chance in 350. Min: 1 Max: 5000 Default: 350
        LegendaryOneIn = 350,

        -- Multiplies condition loss from normal running wear and fluid-related engine damage. Zero disables those MSC wear sources. Min: 0.00 Max: 5.00 Default: 1.00
        ComponentWearMultiplier = 1.0,

        -- Multiplies condition- and pressure-related oil, coolant, and transmission-fluid leaks. Zero disables MSC leaks. Min: 0.00 Max: 5.00 Default: 1.00
        FluidLossMultiplier = 1.0,

        -- Default follows each player's account temperature preference. Celsius and Fahrenheit force that unit for every MSC vehicle temperature. Default = Default (player preference)
        -- 1 = Default (player preference)
        -- 2 = Celsius
        -- 3 = Fahrenheit
        TemperatureDisplay = 1,

        -- Allows a shove near either end of a vehicle's side to turn it. Front and rear pushing remains available when disabled.
        AllowSidePushing = true,

        -- Controls how often Standard parts appear as loot. 0 disables them, 1 is the default rate, and 2 doubles it. Min: 0.00 Max: 5.00 Default: 1.00
        StandardPartsSpawnRate = 1.0,

        -- Controls how often Heavy-Duty parts appear as loot. 0 disables them, 1 is the default rate, and 2 doubles it. Min: 0.00 Max: 5.00 Default: 1.00
        HeavyDutyPartsSpawnRate = 1.0,

        -- Controls how often Sport parts appear as loot. 0 disables them, 1 is the default rate, and 2 doubles it. Min: 0.00 Max: 5.00 Default: 1.00
        SportPartsSpawnRate = 1.0,

        -- Controls how often oil, coolant, and transmission-fluid bottles appear as loot. 0 disables them, 1 is the default rate, and 2 doubles it. Min: 0.00 Max: 5.00 Default: 1.00
        FluidSuppliesSpawnRate = 1.0,
    },
    TrailerCargo = {

        -- On: a trailer or pickup that tips over drops its cargo onto the ground. Off: the cargo stays in the trunk. Each player's own Spill on flip option still applies when this is on.
        ItemSpill = true,

        -- On: cars loaded on the W900 car trailer are thrown off when it rolls. Off: they stay loaded. Each player's own Spill on flip option still applies when this is on.
        CarSpill = true,

        -- Multiplies the damage a car takes when it lands after a spill. 1.0 is normal, 0.0 none, 2.0 double. Min: 0.00 Max: 4.00 Default: 1.00
        CarSpillDamage = 0.5,
    },
    FCW = {

        -- If enabled, the car wash requires electricity (grid power or nearby generator) to function.
        RequireElectricity = true,
    },
    SpawnSelector = {

        -- Stops a player from using Spawn Selector to spawn back near where their previous character died, making it harder to immediately reclaim lost gear with a fresh character.
        DeathZoneEnabled = false,

        -- How far, in tiles, the no-spawn zone extends around a player's death location. Min: 5 Max: 1000 Default: 100
        DeathZoneRadius = 100,

        -- How many real-world hours the block lasts after death. Set to 0 to block the area permanently. Min: 0.00 Max: 999.00 Default: 24.00
        DeathZoneDurationHours = 24.0,

        -- Gun stores, shooting ranges, army surplus stores and other military buildings. Untick to stop Spawn Selector from placing players inside these.
        AllowWeaponsMilitary = true,

        -- Hospitals, doctors' offices, dentists, pharmacies, nursing homes and laboratories.
        AllowMedical = true,

        -- Police stations, prisons and fire stations.
        AllowLawEnforcement = true,

        -- General stores, malls, clothing stores, electronics stores, gas stations, and other retail shops.
        AllowRetailShops = true,

        -- Restaurants, cafes, bars, bakeries and other food and drink venues.
        AllowFoodDrink = true,

        -- Factories, warehouses and storage units.
        AllowIndustrial = true,

        -- Houses, motels, hotels and trailer parks.
        AllowResidentialLodging = true,

        -- Churches, schools, libraries, offices and post offices.
        AllowCivicPublic = true,

        -- Gyms, theatres, bowling alleys, swimming pools and other entertainment venues.
        AllowRecreation = true,

        -- If the building a player spawns in has a lock, automatically give them a matching key for it so they aren't locked in or out of their own starting building.
        GiveBuildingKey = true,

        -- Displays marked points of interest on the spawn-selection map. Untick to hide the POI button and all POI markers from players.
        ShowPOIs = true,
    },
    ISIL = {

        -- Enables configurable suppression strength and optional suppressor durability. Disabled by default to preserve the original mod balance.
        ExtendedMode = false,

        -- Suppressors lose durability whenever the weapon is fired and are destroyed when exhausted. Only applies while Extended Realism Mode is enabled.
        EnableDurability = true,

        -- Adjusts suppressor wear by ammunition caliber. Small calibers consume less durability, while rifle and shotgun ammunition consume more. Unknown ammunition uses the standard 9mm wear rate.
        CaliberBasedWear = true,

        -- Percentage reduction applied to firearm sound radius and volume in Extended Realism Mode. Min: 0 Max: 100 Default: 60
        ProfessionalNoiseReduction = 60,

        -- Percentage reduction applied to firearm sound radius and volume in Extended Realism Mode. Min: 0 Max: 100 Default: 40
        MetalPipeNoiseReduction = 40,

        -- Percentage reduction applied to firearm sound radius and volume in Extended Realism Mode. Min: 0 Max: 100 Default: 30
        HandTorchNoiseReduction = 30,

        -- Percentage reduction applied to firearm sound radius and volume in Extended Realism Mode. Min: 0 Max: 100 Default: 20
        WaterBottleNoiseReduction = 20,

        -- Number of 9mm-equivalent shots before a professional suppressor is destroyed. Min: 1 Max: 10000 Default: 500
        ProfessionalDurability = 500,

        -- Number of 9mm-equivalent shots before a metal pipe suppressor is destroyed. Min: 1 Max: 10000 Default: 100
        MetalPipeDurability = 100,

        -- Number of 9mm-equivalent shots before a hand torch suppressor is destroyed. Min: 1 Max: 10000 Default: 20
        HandTorchDurability = 20,

        -- Number of 9mm-equivalent shots before a water bottle suppressor is destroyed. Min: 1 Max: 10000 Default: 5
        WaterBottleDurability = 5,
    },
    RVM = {

        -- When enabled, only admins and moderators can associate RV interior rooms with vehicles. Regular players cannot enter an RV that has no room assigned — ask an admin to associate a room first.
        RequireAdminToAssociate = false,

        -- Automatically dissociates rooms that have had no interaction for this many days. The last entry date is used; if never entered, the link date is used instead. Set to 0 to disable (default). Min: 0 Max: 365 Default: 0
        IdleCleanupDays = 0,
    },
    ImmersiveSnow = {

        -- Who leaves footprints in ground snow: everyone (players and the zombies near a player), players only, or nobody (no footprints and no snow carried off on the soles). Each player can also show fewer for themselves in Options > Mods. Default = Everyone (players and zombies)
        -- 1 = Everyone (players and zombies)
        -- 2 = Players only
        -- 3 = Nobody (off)
        FootprintsFrom = 1,

        -- Vehicles leave tire tracks in ground snow. Off: no tire tracks and no snow carried off on the tires. Each player can also turn them off for themselves in Options > Mods.
        TireTracks = true,

        -- For weak integrated graphics with little video memory. Turns off snow on zombies, on items in hand and on vehicle doors, hoods and wheels, and the icing on vehicles; fewer footprints and tire tracks (at most 600 / 1200), zombie footprints only within 15 tiles, fewer snow particles blown off cars, half the footprint textures. The same switch is in Options > Mods for each player.
        LowEndMode = false,

        -- In-game hours a player's footprint lasts when no snow is falling. Min: 0.50 Max: 168.00 Default: 6.00
        FootprintHours = 6.0,

        -- In-game hours a zombie's footprint lasts when no snow is falling. Lower it so hordes do not trample the snow for long. Min: 0.50 Max: 168.00 Default: 6.00
        ZombieFootprintHours = 6.0,

        -- How much faster footprints disappear during heavy snowfall. Min: 0.00 Max: 50.00 Default: 8.00
        SnowfallCoverRate = 8.0,

        -- Above this limit the oldest footprints fade out. Players and zombies share it (each keeps at least half); lower it if the game slows down in snow. Min: 10 Max: 10000 Default: 2000
        MaxFootprints = 2000,

        -- Only zombies within this many tiles of the player leave footprints. Min: 5 Max: 60 Default: 25
        ZombieRadius = 25,

        -- B42 animals (deer, rabbits, chickens, cows, pigs, sheep...) and the horses, dogs and cats of the Horse Mod and Companion Dogs leave hoof and paw prints in ground snow, also out of sight, so game can be tracked. Each player can also turn them off for themselves in Options > Mods.
        AnimalTracks = true,

        -- In-game hours an animal's print lasts when no snow is falling. Min: 0.50 Max: 168.00 Default: 12.00
        AnimalTrackHours = 12.0,

        -- Above this limit the oldest animal prints fade out (a limit of their own, apart from the footprints). Lower it if the game slows down by a farm in snow. Min: 10 Max: 10000 Default: 1000
        MaxAnimalTracks = 1000,

        -- Only animals within this many tiles of the player leave prints (the nearest 48 at most). Min: 5 Max: 60 Default: 25
        AnimalTrackRadius = 25,

        -- A player or zombie without shoes leaves the print of a bare foot (heel, ball and toes) instead of a boot sole, in the snow and with the snow carried onto clear ground.
        BarefootPrints = true,

        -- A player or zombie who steps on a corpse leaves red prints for the next steps, each fainter, in the snow and on clear ground (asphalt, floors). Blood on the floor alone does not count. Off with the game's blood decals set to none.
        BloodyFootprints = true,

        -- How many steps after the blood still leave red prints. Min: 1 Max: 40 Default: 8
        BloodyFootprintSteps = 8,

        -- Drops of blood behind a bleeding player or a wounded zombie, covered by snowfall like the footprints. In multiplayer only for players on this computer and zombies: the game does not tell other clients that a player bleeds. Off with the game's blood decals set to none.
        BloodOnSnow = true,

        -- In-game hours a tire track lasts when no snow is falling. Min: 0.50 Max: 168.00 Default: 12.00
        TireTrackHours = 12.0,

        -- A segment is 0.4 tile of one wheel's track. Hard limit: above it the oldest segments vanish within seconds; lower it if the game slows down in snow. Min: 20 Max: 20000 Default: 4000
        MaxTireTracks = 4000,

        -- Above this many segments the oldest fade out over about 20 seconds, so a spot driven over again and again keeps only its latest laps. Has no effect at or above the max segments. Min: 20 Max: 20000 Default: 1500
        TireTrackSoftLimit = 1500,

        -- A wheel that runs over a corpse leaves a red track that pales out: a red rut in snow, red tread marks on clear ground. Only the wheels that went over it; blood on the ground alone does not count. Follows the vanilla blood settings (none with Blood Level none or blood decals off). Each player can also turn it off for themselves in Options > Mods.
        BloodyTireTracks = true,

        -- Tiles a wheel keeps leaving a red track after the blood, paler and paler. Min: 0.40 Max: 40.00 Default: 2.00
        BloodyTireTrackTiles = 2.0,

        -- Snow builds up on vehicles parked outdoors, melts in warmth and from a running engine, and blows off when driving. Works with modded vehicles.
        VehicleSnow = true,

        -- In-game hours of heavy snowfall until a parked vehicle is fully covered. Min: 0.25 Max: 24.00 Default: 2.00
        VehicleSnowHours = 2.0,

        -- Glazed ice around the snow on the body, the wheels and the glass edges. Off: plain snow only. Frost on the glass is a separate option.
        VehicleSnowIce = true,

        -- Snow settles on the clothes and on what you hold while you are outdoors in snowfall, and melts in warmth: indoors, by a fire, in the rain above freezing. Melting snow wets the clothes. Off: no snow on characters at all, so none melts into the clothes (falling snow and walking through snow still wet them).
        CharSnow = true,

        -- In-game hours of heavy snowfall outdoors a full layer of snow on the clothes would take (players stop at the most snow below). Light snowfall builds up slower. Min: 0.10 Max: 24.00 Default: 3.00
        CharSnowHours = 3.0,

        -- How much snow snowfall leaves on a player's clothes, moving about shakes off as much as falls; the lighter the snowfall, the less. 1: a full layer only in the heaviest snowfall. 1.5: a full layer in heavy snowfall, three quarters in light. Never more than a full layer. Zombies always get a full layer. Min: 0.10 Max: 2.00 Default: 1.50
        CharSnowMax = 1.5,

        -- Game hours a full layer of snow on a character takes to melt at 20 C (indoors, by a fire, in a heated car). At 10 C it takes twice as long; below 0 C it does not melt. Min: 0.10 Max: 24.00 Default: 1.25
        CharSnowMeltHours = 1.25,

        -- Under a roof or in a vehicle just above 0 C a full layer of snow on a character melts in this many game hours, however cold the room; warmer rooms melt it faster still (the option above). Min: 0.10 Max: 24.00 Default: 0.50
        CharSnowIndoorMeltHours = 0.5,

        -- Game hours body heat takes to melt a full layer of snow in the cold while it does not snow. Zombies have no body heat. Min: 1.00 Max: 500.00 Default: 50.00
        CharSnowBodyMeltHours = 50.0,

        -- Game hours of heavy rain above 0 C that wash a full layer of snow off a character or zombie (on top of melting in the warmth). Min: 0.10 Max: 48.00 Default: 3.00
        CharSnowRainMeltHours = 3.0,

        -- Snow on what characters hold and carry on the body: weapons, tools, backpacks on the back. Off: snow on the clothes only. Turn it off if a weapon mod shows the wrong weapon models in the snow.
        CharItemSnow = true,

        -- Darker snow on vehicles, characters and items, and darker snow particles, to match darker ground snow. On by itself with Snow Lands - Darker Snow. Takes effect after loading the save again.
        DarkSnow = false,

        -- Zombies get snow on their clothes too. They have no body heat: the snow melts in warmth above freezing or in the rain, and goes within an hour once the ground outdoors is bare.
        ZombieSnow = true,

        -- Game hours of heavy snowfall until a zombie outdoors is fully covered. Melting works as for players, without body heat; outdoors on bare ground the snow goes within an hour. Min: 0.10 Max: 24.00 Default: 0.50
        ZombieSnowHours = 0.5,

        -- A zombie or player that dies with snow on keeps it on the corpse, and it melts there as on zombies: in warmth above freezing, in the rain, and within an hour once the ground outdoors is bare. No new snow settles on corpses. Off: the snow comes off when a character dies. In multiplayer only on the corpses of deaths this client saw.
        CorpseKeepSnow = false,

        -- While it is 0 C or colder outdoors, no flies buzz over corpses and their stench makes nobody sick: the mod holds the game's "Decaying Corpse Health Impact" at None and sets it back above +1 C. If you set that option yourself while it is held, the mod leaves it as you set it and turns this option off. Before taking the mod out of a save, run ISnow.cleanSave() in the console (see the mod page), or that option may stay at None.
        ColdCorpses = true,

        -- Snow falling on a player and the snow melting on the clothes make them wet, like rain does in vanilla; walking through snow wets the shoes. Water-resistant clothes and boots protect. Wet clothes keep less warm.
        SnowWetness = true,

        -- Multiplier of how fast snow wets the clothes. 1 = wet snow at 0 C soaks an outer layer in about 3 game hours; the colder, the drier the snow. Min: 0.00 Max: 5.00 Default: 1.00
        SnowWetnessRate = 1.0,

        -- Stepping or driving from snow onto a clear square leaves a few fading snowy prints.
        CarriedSnow = true,

        -- How many steps on clear ground after the snow still leave snowy prints. Min: 1 Max: 10 Default: 3
        CarriedSnowSteps = 3,

        -- How far a wheel leaves snowy tread marks on clear ground after the snow. Min: 0.40 Max: 20.00 Default: 3.20
        CarriedSnowTireTiles = 3.2,

        -- Game hours snowy prints and tire marks on clear ground last at 0 C and below. Min: 0.10 Max: 48.00 Default: 2.00
        CarriedSnowHours = 2.0,

        -- Game hours snowy prints and tire marks take to melt at 20 C (a heated house); at 10 C twice as long. Uses the temperature of their square. Min: 0.02 Max: 24.00 Default: 0.25
        CarriedSnowMeltHours = 0.25,

        -- Living players breathe out vapour in the cold: faster and thicker after running, none through a gas mask or respirator, half through cloth over the face. Uses the air temperature at the character (indoors, heaters and the vehicle heater count). Zombies do not breathe.
        Breath = true,

        -- Air temperature at and below which the vapour shows, faint at first. Min: -20.00 Max: 15.00 Default: 7.00
        BreathMaxTemp = 7.0,

        -- Air temperature at and below which the vapour is at full strength. Min: -40.00 Max: 0.00 Default: -20.00
        BreathFullTemp = -20.0,

        -- How thick the vapour is, 0.1 (barely visible) to 1. Min: 0.10 Max: 1.00 Default: 0.85
        BreathOpacity = 0.85,

        -- While the engine is warm, the snow on the hood melts faster than on the roof: the hotter the engine, the faster (vanilla engine temperature: it warms up over the first hour or so of running and stays warm for a while after it stops). Only on vehicles whose hood is a separate model (KI5, Vanilla Vehicles Animated...); on the vanilla cars the hood is part of the body. In multiplayer the server decides; each player can hide it for themselves in Options > Mods.
        VehicleHoodMelt = true,

        -- Game hours a hot engine takes to melt a full layer of snow off the hood. A cold engine melts nothing; half warm, twice as long. In multiplayer always as on the server. Min: 0.10 Max: 24.00 Default: 1.00
        VehicleHoodMeltHours = 1.0,

        -- Running and sprinting through snow throws a little powder back off the feet; a player or zombie that goes down in the snow (knocked down, tripped, killed) raises a puff. Only with footprints on.
        SnowKick = true,

        -- Powder puffs a running step into snow throws (a fraction is the chance of one): 0 none, 0.4 about every other step, 3 a lot. Min: 0.00 Max: 3.00 Default: 0.40
        SnowKickRun = 0.4,

        -- Powder puffs a sprinting step into snow throws, with a chance of a clump. Min: 0.00 Max: 5.00 Default: 1.30
        SnowKickSprint = 1.3,

        -- A player or zombie that goes down in the snow (knocked down, tripped, killed) raises a puff along the body.
        SnowKickFalls = true,

        -- How much snow a fall raises: 1 is 7 puffs and 3 clumps, 2 twice as many. Min: 0.10 Max: 3.00 Default: 1.00
        SnowKickFallAmount = 1.0,

        -- Vehicle wheels in snow throw powder and now and then a clump behind them: more the faster the vehicle goes, more again when it slides sideways. Works with tire tracks off too.
        SnowKickWheels = true,

        -- How much snow the wheels throw: 1 is about 40 puffs a second off a car at 40 km/h and over, 2 twice as many. Min: 0.10 Max: 3.00 Default: 0.80
        SnowKickWheelAmount = 0.8,

        -- Frost creeps in from the edges of the screen with the Hypothermia moodle: further in at each level, in full at level 4. Goes away as the character warms up. In multiplayer each player can hide it for themselves in Options > Mods.
        FrostScreen = true,

        -- How thick the frost at the edges of the screen is at its fullest, 0.1 (barely visible) to 1. In multiplayer always as on the server. Min: 0.10 Max: 1.00 Default: 0.80
        FrostScreenOpacity = 0.8,

        -- Level of the Hypothermia moodle (1-4) at which the first frost shows at the edges of the screen. It reaches further in at each level above, in full at level 4. In multiplayer always as on the server. Min: 1 Max: 4 Default: 1
        FrostScreenFromLevel = 1,

        -- Real seconds the frost takes to creep in to the next stage when the Hypothermia moodle rises. In multiplayer always as on the server. Min: 1.00 Max: 120.00 Default: 12.00
        FrostScreenComeSeconds = 12.0,

        -- Real seconds the frost takes to thaw back when the Hypothermia moodle drops or goes. In multiplayer always as on the server. Min: 1.00 Max: 300.00 Default: 30.00
        FrostScreenGoSeconds = 30.0,

        -- The frost at the edges of the screen trembles while the character shivers with cold, harder at each Hypothermia level. Turn off if screen motion bothers you.
        FrostScreenShiver = true,

        -- Level of the Hypothermia moodle (1-4) at which the frost starts to tremble. Min: 1 Max: 4 Default: 2
        FrostScreenShiverLevel = 2,

        -- A vehicle parked outdoors in the frost gets frost on its windows, on the glass itself. Scrape it off (right-click the vehicle; faster with a scraper, spatula or trowel) or run the engine with the heater on. In multiplayer each player can hide it for themselves in Options > Mods.
        VehicleFrost = true,

        -- Game hours a vehicle parked outdoors at -8 C or colder takes to frost over fully. Slower in a milder frost, none above 0 C. In multiplayer always as on the server. Min: 0.25 Max: 24.00 Default: 3.00
        VehicleFrostHours = 3.0,

        -- Game minutes the heater (with the engine running) takes to clear fully frosted windows. The engine alone takes four times as long. In multiplayer always as on the server. Min: 1.00 Max: 120.00 Default: 10.00
        VehicleFrostHeaterMinutes = 10.0,

        -- Game hours full frost takes to thaw on its own at +5 C; at +10 C half as long. Below 0 C it does not thaw on its own. In multiplayer always as on the server. Min: 0.25 Max: 24.00 Default: 2.50
        VehicleFrostMeltHours = 2.5,

        -- In a strong wind in the frost, low snow dust sweeps along the ground snow with the wind, in gusts. In multiplayer each player can hide it for themselves in Options > Mods.
        DriftingSnow = true,

        -- Wind speed from which snow drifts along the ground; it grows to full 30 km/h above it. Min: 5.00 Max: 100.00 Default: 25.00
        DriftingSnowWind = 25.0,

        -- How much snow dust drifts: 1 is about 30 wisps a second on the screen at full wind, 2 twice as many. Min: 0.10 Max: 3.00 Default: 1.00
        DriftingSnowAmount = 1.0,

        -- A campfire, a fire on the ground or a burning building melts the snow around it into a dark wet patch, with a little steam, while it burns. The patch freezes over and is snowed over after the fire goes out. In multiplayer each player can hide it for themselves in Options > Mods.
        FireThaw = true,

        -- Game hours a fully thawed patch takes to go after the fire is out, if no snow falls (falling snow covers it faster). Min: 0.25 Max: 24.00 Default: 2.00
        FireThawHours = 2.0,

        -- Snow walked over again and again (players and zombies) becomes a trodden path that lasts much longer than footprints: you can see where a horde keeps walking. Counted from the footprints, so only with footprints on. In multiplayer each player can hide them for themselves in Options > Mods.
        TrampledPaths = true,

        -- Footprints on one square that make a path there (older ones count less, half after 3 game hours); the path gets darker with more. About 2 footprints a square each time someone walks through. Min: 3 Max: 100 Default: 12
        TrampledPathSteps = 12,

        -- Game hours a path lasts after the last walker, if no snow falls (falling snow covers it faster). Min: 1.00 Max: 336.00 Default: 48.00
        TrampledPathHours = 48.0,

        -- Only with the Immersive Snow - Viewpoint add-on: depth of the snow on the ground in Viewpoint's 3D view at the highest snow level, less while it is building up or melting. The snow also drifts deeper against buildings, steps run together into a trench and shovelled squares stand as cuttings; from 10 cm it slows you down (3D snow slows you down). Min: 5 Max: 100 Default: 35
        SnowDepth = 35,

        -- Only with the Immersive Snow - Viewpoint add-on (its 3D snow on the ground): from 10 cm of snow (Snow depth) wading through it tires you, from 30 cm you cannot sprint, and a vehicle you drive goes slower (at 45 cm about half its top speed). Not on squares cleared with a shovel; on trampled paths it is easier. In MP the server decides.
        SnowSlowdown = true,

        -- Game hours of rain that wash a full cover of snow off the ground, in stages: the snow thins out, the prints and the depth go with it; heavy rain is twice as fast. 0: all at once at the next hour, as in vanilla. In MP the server decides. Min: 0.00 Max: 48.00 Default: 3.00
        RainWashHours = 3.0,

        -- Only in the 3D view of Viewpoint with the Immersive Snow - Viewpoint add-on: the snow on vehicles stands out as a layer where it settles on top (the roof, the bonnet: up to about 12 cm at the last stage at 100%); clothes, the vehicles' sides, ice and frost on the glass stay flat. 0: flat, as before. Min: 0 Max: 200 Default: 100
        SnowThickness3D = 100,

        -- Only in the 3D view of Viewpoint with the Immersive Snow - Viewpoint add-on: the snow on the ground has a depth (prints, ruts and furrows pressed into it). Off: the ground snow is flat, as Viewpoint lays it.
        Snow3DGround = true,

        -- Only in the 3D view of Viewpoint with the Immersive Snow - Viewpoint add-on: the snow on vehicles lies on top as a layer with a thickness (roof, bonnet, boot). Off: the snow on vehicles is flat, as in the isometric view.
        Snow3DVehicles = true,
    },
    ALife = {

        Preset_ExplicitValues = false,

        -- How dangerous NPCs are. Easy: half damage, 80 health, raids from day 60. Only default-valued options change; density is separate. Reload for full effect.
        -- Default Easy (1). Default = Easy
        -- 1 = Easy
        -- 2 = Medium
        -- 3 = Hard
        -- 4 = Hardcore
        Preset_Difficulty = 2,

        -- The War Challenge: Biggest limits. Lots of NPCs alive at once. Needs a decent PC. Changes limits only, not chances or timing. High stays the normal choice.
        -- Default High (4). Default = High
        -- 1 = Very few
        -- 2 = Few
        -- 3 = Medium
        -- 4 = High
        -- 5 = Maximum (unsupported, may lag)
        -- 6 = The War Challenge
        Preset_World = 3,

        -- Lets your profession affect how NPCs treat you, including Creator rules. Off: profession has no attitude effect; faction and folder relations still apply.
        -- Default off.
        ProfessionAffectsAttitude = true,

        -- Adds extra activity for the first 3 game days and a National Guard checkpoint north of West Point. After 72 hours, road police, army and the checkpoint disappear.
        -- Default on.
        Realistic_Outbreak = true,

        -- Off prevents hostile factions, automatic raids and new outposts. Friendly, neutral and cautious survivors can still appear.
        -- Default on.
        World_HostileEnabled = true,

        -- Scales the chance of natural faction encounters. At 50, these checks have half their normal chance of bringing a group.
        -- Default 200. Min: 25 Max: 400 Default: 200
        Population_RatePercent = 150,

        -- Scales the number of NPCs in naturally appearing groups. At 100, groups keep their original sizes. Faction size limits still apply.
        -- Default 125. Min: 50 Max: 200 Default: 125
        Population_PartyPercent = 100,

        -- Sets how close saved NPCs must be to a player before they appear as physical characters. Larger distances keep more nearby NPCs active.
        -- Default 90. Min: 40 Max: 250 Default: 90
        World_SimRadius = 90,

        -- Stops new travelling crews at this living-NPC count, including peaceful survivors. It is not the county population; existing crews stay.
        -- Default 32. Min: 4 Max: 160 Default: 32
        Population_HostileCeiling = 32,

        -- Time to raise, aim and start firing, and to look for a new combat target. Default 75% shortens these delays by one quarter. 100% restores the previous timing. Lower is faster. Weapon fire rate, reload time and warnings keep their own timings. Min: 25 Max: 200 Default: 75
        Combat_ReactionDelayPercent = 75,

        -- Higher choices make NPC gunfire more accurate against players. Medium keeps their own aiming skill; zombie accuracy is separate.
        -- Default Medium (3). Default = Medium
        -- 1 = Very Easy
        -- 2 = Easy
        -- 3 = Medium
        -- 4 = Hard
        -- 5 = Very Hard
        -- 6 = Hardcore
        Combat_AimDifficulty = 3,

        -- Sets the chance of a group on each natural encounter check. Both the game-hour faction checks and game-minute encounter checks use it.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Encounters_RollPercent = 10,

        -- Sets the time between natural faction encounter checks. A check can fail; this is not a guaranteed time between meetings.
        -- Default 3. Min: 1 Max: 24 Default: 3
        Encounters_GapHours = 8,

        -- Extra no-spawn distance around claimed multiplayer safehouses. At 8, new NPCs cannot spawn within eight extra tiles of the claim.
        -- Default 8. Min: 0 Max: 50 Default: 8
        World_SafehouseClearance = 8,

        -- Allows hostile NPC factions to fight each other.
        -- Default on.
        World_FactionWarfare = true,

        -- Allows wounded hostile NPCs to retreat from a fight.
        -- Default on.
        Behavior_Retreat = true,

        -- NPCs infected by zombie bites or attacks can rise in their own clothes. The game's Transmission, Mortality and Reanimate settings still apply.
        -- Default on.
        Behavior_NPCsReanimate = true,

        -- Infected NPC corpses wait before rising, giving you time to right-click and put them down. Off: they rise immediately. The wait advances only while the body is loaded.
        -- Default on.
        Turning_Enabled = true,

        -- Sets the shortest wait before an infected NPC corpse rises. For example, 30 means at least half a minute while the body is loaded.
        -- Default 20. Min: 0 Max: 600 Default: 20
        Turning_DelaySecondsMin = 20,

        -- Sets the longest wait before an infected NPC corpse rises. For example, 120 allows up to two minutes while the body is loaded.
        -- Default 90. Min: 0 Max: 600 Default: 90
        Turning_DelaySecondsMax = 90,

        -- Allows hostile looters to take nearby supplies.
        -- Default on.
        Behavior_Scavenge = true,

        -- Hostile NPCs may walk toward gunfire, shouts and other signs of activity they notice.
        -- Default on.
        Behavior_Investigate = true,

        -- Members that fall behind close back up on their group instead of drifting.
        Behavior_Regroup = true,

        -- Groups travel together in formation rather than as separate walkers.
        Behavior_MarchTogether = true,

        -- Outside combat, the last group member closes doors the group opened. Player-opened doors and occupied doorways stay untouched; no locks are changed.
        -- Default on.
        Behavior_CloseDoors = true,

        -- Allows eligible NPC guns and melee weapons to remain on their bodies for looting. The weapon drop chance still applies.
        -- Default on.
        Drops_WeaponsEnabled = true,

        -- Per NPC profile uses each NPC's own chance times the NPC loot percent. Another choice sets one chance for all weapons and ignores that percent; needs NPC weapon drops.
        -- Default Per NPC profile (1). Default = Per NPC profile
        -- 1 = Per NPC profile
        -- 2 = Off (0%)
        -- 3 = Very low (0-10%)
        -- 4 = Low (10-20%)
        -- 5 = Moderate (20-30%)
        -- 6 = High (30-50%)
        -- 7 = Very high (50-70%)
        -- 8 = Almost always (70-99%)
        -- 9 = Always (100%)
        Drops_WeaponChance = 1,

        -- Sets dropped weapon condition, not NPC combat strength. Per NPC profile keeps its rating and early-game wear curve; Broken needs repairs before use.
        -- Default Per NPC profile (1). Default = Per NPC profile
        -- 1 = Per NPC profile
        -- 2 = Broken (0/10)
        -- 3 = Scrap, a shot or two (1/10)
        -- 4 = Very poor, a few shots (2/10)
        -- 5 = Poor (3/10)
        -- 6 = Worn (4/10)
        -- 7 = Used, half gone (5/10)
        -- 8 = Serviceable (6/10)
        -- 9 = Good (7/10)
        -- 10 = Very good (8/10)
        -- 11 = Near new (9/10)
        -- 12 = Issue fresh (10/10)
        Drops_WeaponCondition = 1,

        -- Only military and special-response crews can drop rare armor, dirty and at 10-40 percent condition. 0 stops these drops. Sledgehammers and crafting components never drop.
        -- Default 5. Min: 0 Max: 100 Default: 5
        Loot_RareDropPercent = 5,

        -- On: Creator profiles keep their chosen rare gear. Off: custom sledgehammers, crafting heads and heavy armor are replaced with common gear at spawn.
        -- Default off.
        Loot_AllowRareFromProfiles = false,

        -- Restores the earlier factions, attitudes and spawn weights instead of the merged roster. Takes effect when the game or server starts.
        -- Default off.
        Factions_LegacyRoster = false,

        -- Changes factions, gear and aim as the world ages. Emergency services disappear by day 120; survivor and raider groups take over. Off uses fixed faction schedules.
        -- Default on.
        Funnel_Enabled = true,

        -- Moves faction progression ahead or back. At +30, a new world uses day-30 factions and gear; -10 delays progression by 10 days.
        -- Default 0. Min: -3650 Max: 3650 Default: 0
        Funnel_DayOffset = 0,

        -- Limits lone survivors and survivor pairs to this many NPCs, even if group-size settings would make their party larger.
        -- Default 2. Min: 1 Max: 2 Default: 2
        Funnel_LoneSurvivorMax = 2,

        -- How much NPC aim improves as the stages pass, in % of the built-in ramp (up to +3 aim rating in the last stage). 0% turns the ramp off, 100% is the default. Min: 0 Max: 200 Default: 100
        Funnel_SkillRampPercent = 100,

        -- Scales the ammo an NPC starts with; 100 keeps its profile amount. Each gun retains at least one full load. Infinite-ammo profiles are unchanged.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Ammo_SpawnPercent = 100,

        -- Caps starting and collected spare ammo in gun loads of at least 6 rounds. Smaller kits stay smaller; 2 permits two spare loads. 0 removes the cap; infinite-ammo profiles are unchanged.
        -- Default 2. Min: 0 Max: 20 Default: 2
        Ammo_ReserveLoads = 6,

        -- Chooses which NPC profiles may use infinite ammo. Creator profiles only limits it to profiles you made or edited; stock NPCs can run dry.
        -- Default Creator profiles only (1). Default = Creator profiles only
        -- 1 = Creator profiles only
        -- 2 = Every profile that asks
        -- 3 = Never
        Ammo_Bottomless = 2,

        -- On: dropped magazines use only ammo the NPC had left, up to its profile limit. Off: each issued magazine gets a drop roll and can be full even after its rounds were fired.
        -- Default on.
        Ammo_HonestDrops = true,

        -- Allows NPC firearms other than revolvers to jam: the gun clicks instead of firing, then the NPC racks it clear.
        -- Default on.
        Combat_EnableJamming = true,

        -- Base chance per trigger pull for a non-revolver NPC firearm to jam. Zero disables jams even if the feature is enabled. Min: 0.00 Max: 25.00 Default: 1.00
        Combat_JamChance = 1.0,

        -- How hard NPCs work a door, a window or a barricade when they break in. 100 is the tested default: a window takes three swings, a plank four, a plain door about half a minute, and only one man swings while the rest cover him. Lower it and they take longer; raise it and they come through faster. Min: 25.00 Max: 200.00 Default: 100.00
        Breach_Strength = 100.0,

        -- A two-handed swing by an NPC carries into a second zombie standing in the arc, at three quarters of the blow. Zombies only, never people. Off by default.
        Combat_MultiHit = true,

        -- A round an NPC puts into a zombie goes on into the zombie standing right behind it (up to three squares). Zombies only, never people; better against a horde. Off by default.
        Combat_BulletPenetration = true,

        -- Marks 10, 20 or 35 percent of suitable buildings once per world, up to the building limit. Residents appear when approached and are saved. Realistic outbreak does not turn it off.
        -- Default Uncommon (3). Default = Uncommon
        -- 1 = Off
        -- 2 = Rare
        -- 3 = Uncommon
        -- 4 = Common
        Population_PopulateOnStart = 3,

        -- Limits buildings selected for starting residents across the whole map. Selection happens once per world; stations, firehouses and clinics take priority.
        -- Default 75. Min: 1 Max: 200 Default: 75
        Population_PopulateMax = 75,

        -- Adds small local groups, such as a family or rescue crew, when a new character starts in town. Reloading or rejoining does not add more.
        -- Default on.
        TownWelcome_Enabled = true,

        -- How many welcome groups each new character gets, and how many can be alive in one town at once, even when several players start there.
        -- Default 8. Min: 1 Max: 8 Default: 8
        TownWelcome_GroupsPerTown = 4,

        -- On allows a character's town welcome group only during their first game day. Off extends the window to their first game week.
        -- Default on.
        TownWelcome_FirstDayOnly = true,

        -- Sets the finite survivor pool when the world starts. Natural groups and reinforcements draw from it; deaths reduce it. Slow arrivals replace losses. Admin spawns do not count.
        -- Default 360. Min: 20 Max: 5000 Default: 360
        Census_Size = 200,

        -- Sets how many newcomers can replace dead survivors each game week early in the outbreak. If nobody has died, nobody arrives.
        -- Default 7.0. Min: 0.00 Max: 100.00 Default: 7.00
        Census_ArrivalsEarly = 7.0,

        -- Sets the replacement arrival rate after the early period. Arrivals gradually fall from the early rate to this one; they only replace losses.
        -- Default 1.0. Min: 0.00 Max: 100.00 Default: 1.00
        Census_ArrivalsLate = 1.0,

        -- Sets how long the weekly arrival rate takes to fall from the early value to the later value.
        -- Default 28. Min: 1 Max: 365 Default: 28
        Census_ArrivalsFadeDays = 28,

        -- Keeps a camp, outpost or inhabited building empty after all its residents die. Once this period ends, rare newcomers may settle there if resettlement is enabled.
        -- Default 30. Min: 1 Max: 365 Default: 30
        Census_ClearedDays = 30,

        -- Allows newcomers to settle cleared sites after their vacancy period, at most one site per four arrivals. Off keeps cleared sites empty for the rest of the game.
        -- Default on.
        Census_Resettle = true,

        -- NPCs walk to where a target was last seen and sweep the area before giving up.
        Search_Enabled = true,

        -- Shouting draws every NPC within earshot toward you.
        Search_ShoutResponse = true,

        -- An NPC that spots something tells its group where, once. Not a live feed.
        Search_GroupCallout = true,

        -- When not fighting, NPCs search areas with signs that survivors are nearby, such as barricades or a running generator.
        -- Default on.
        Clues_Enabled = true,

        -- Running or hotwired vehicles attract NPC searches in the surrounding area.
        -- Default on.
        Clues_Vehicles = true,

        -- Planks on doors and windows make NPCs treat a building as occupied and worth investigating.
        -- Default on.
        Clues_Barricades = true,

        -- Player-built walls, gates and fences make NPCs treat a place as occupied and worth investigating.
        -- Default on.
        Clues_PlayerBuilt = true,

        -- A running generator gives NPCs a strong sign that someone lives nearby, attracting investigation.
        -- Default on.
        Clues_Power = true,

        -- Scales how readily NPCs investigate survivor traces. Higher values let weaker evidence draw a search; lower values require stronger evidence.
        -- Default 1.0. Min: 0.25 Max: 5.00 Default: 1.00
        Clues_WeightMultiplier = 1.0,

        -- Enables recorded speech where available. Off keeps conversations as text; pain and death sounds are separate.
        -- Default off.
        Voice_Enabled = true,

        -- Nearby NPCs answer typed questions, requests, threats and yes-or-no replies. They also speak when you hit them or help them fight.
        -- Default on.
        Talk_Enabled = true,

        -- The Toggle chat key opens a small chat line for talking to NPCs in single player. Start a message with ! to shout.
        -- Default on.
        Talk_SinglePlayerChat = true,

        -- Friendly and neutral NPCs notice you nearby, stop and look when you speak. Passing friends greet you; outlaw groups call out strangers.
        -- Default on.
        Talk_Presence = true,

        -- Fresh survivors avoid unprovoked fights, but hostile relations, grudges and self-defence still allow attacks. Veterans and predators ignore this caution.
        -- Default on.
        Talk_RiskAssessment = true,

        -- Non-enemy groups within eight tiles may stop and talk, then part or walk together briefly. Off disables meetings; fights, fleeing and player orders always interrupt.
        -- Default Normal (3). Default = Normal
        -- 1 = Off
        -- 2 = Rare
        -- 3 = Normal
        -- 4 = Often
        Talk_GroupMeetings = 3,

        -- Calm groups pause to talk, and passing NPCs greet each other or you. Danger interrupts them. Off disables both group chatter and these greetings.
        -- Default on.
        Chatter_Enabled = true,

        -- How often calm groups start talking. At 200, conversations happen twice as often; at 50, half as often.
        -- Default 100. Min: 10 Max: 400 Default: 100
        Chatter_Frequency = 100,

        -- Chance that an NPC greets you or another NPC while passing. Friendly people greet more, wary people less, enemies never. At 0, passing greetings stop.
        -- Default 70. Min: 0 Max: 100 Default: 70
        Chatter_PassingGreetPercent = 70,

        -- Maximum group conversations happening at once. Lower values keep speech easier to follow in crowded places.
        -- Default 3. Min: 1 Max: 8 Default: 3
        Chatter_MaxConcurrent = 3,

        -- Outlaws may rob a lone player instead of shooting: hands up, weapon down, three or four valuables taken, then they leave. Refusal can lead to shooting.
        -- Default on.
        Robbery_Enabled = true,

        -- Scales how often outlaws choose robbery rather than a fight. 0 means never; 200 means twice the normal rate, not a guaranteed robbery.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Robbery_Chance = 100,

        -- Lets you order NPCs to raise their hands, drop weapons, leave or follow. Obedience depends on fear, faction, weapons and group size.
        -- Default on.
        Orders_Enabled = true,

        -- Scales the chance an NPC obeys a spoken order. At 0, nobody obeys; at 200, obedience is twice as likely. Civilians are easier to command than armed factions.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Orders_Chance = 100,

        -- Chance the target and their group attack after refusing hands-up, drop-weapon or hold-up orders. At 100, they always attack; at 0, they only refuse.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Orders_FailFight = 75,

        -- A surrendering NPC lowers their hands and reacts when a zombie comes within this distance.
        -- Default 4. Min: 1 Max: 8 Default: 4
        Orders_ZombieTiles = 4,

        -- Longest time an NPC keeps their hands up before lowering them and carrying on.
        -- Default 90. Min: 10 Max: 600 Default: 90
        Orders_SurrenderSeconds = 90,

        -- How much weapons, loaded ammo, armour, numbers, distance and clear sight affect obedience. At 0, these advantages do not matter; at 300, they dominate the decision.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Orders_Advantage = 100,

        -- When one member surrenders, each groupmate chooses whether to obey, fight or flee after a warning. Off: the whole group always follows the surrendering member.
        -- Default on.
        Orders_GroupSurrender = true,

        -- Robbed NPCs flee, then remember you as dangerous and keep their distance for this long. At 0, this caution is not remembered.
        -- Default 15. Min: 0 Max: 240 Default: 15
        Orders_CarefulMinutes = 15,

        -- Opening a calm NPC's talk menu makes them stop, face you and greet you before choices appear. Fighting or frightened NPCs are not interrupted.
        -- Default on.
        Talk_GreetOnOpen = true,

        -- NPCs remember repeated questions, lose patience and react to your tone. Off: no question memory or opinion changes from words; deeds still count.
        -- Default on.
        Talk_AntiSpam = true,

        -- Prioritises useful replies, marks asked questions and hides unsuitable choices, such as personal questions for strangers. Requires conversation memory and patience.
        -- Default on.
        Talk_MenuFocus = true,

        -- Within this time, a repeated question gets an already-answered reply and no opinion gain. Personal-life answers stay remembered for a full game day.
        -- Default 30. Min: 1 Max: 600 Default: 30
        Talk_RepeatCooldownMinutes = 30,

        -- Base number of questions an NPC will answer. NPCs who like you allow more; those who dislike you allow fewer. After warning that patience is spent, they end the talk.
        -- Default 10. Min: 2 Max: 30 Default: 10
        Talk_QuestionsPerTalk = 10,

        -- After ending an overlong or irritating conversation, the NPC refuses to answer and closes the talk window until this time passes.
        -- Default 60. Min: 5 Max: 1440 Default: 60
        Talk_RefuseMinutes = 60,

        -- Talks needed before family and past-life questions open up, unless the NPC already likes you. Asking too early lowers their opinion.
        -- Default 2. Min: 1 Max: 10 Default: 2
        Talk_PersonalAfterTalks = 2,

        -- Scales how much polite, nosy, rude or kind words change an NPC's opinion. At 0, words do not change opinion; repetition, patience and refusals still work.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Talk_OpinionFromTalk = 100,

        -- Limits opinion gained from words in one talk; losses stop at one and a half times this amount. Twenty quiet game minutes begin a new conversation.
        -- Default 6. Min: 1 Max: 40 Default: 6
        Talk_OpinionCapPerConversation = 6,

        -- Limits opinion gained from words with each NPC per game day. Losses stop at one and a half times this amount.
        -- Default 12. Min: 1 Max: 100 Default: 12
        Talk_OpinionCapPerDay = 12,

        -- Conversation cannot raise an NPC's opinion above this score. Beyond it, gifts, healing or fighting beside them must earn further trust.
        -- Default 40. Min: 0 Max: 100 Default: 40
        Talk_OpinionWordCeiling = 40,

        -- After fights, NPCs near players loot bodies when no danger is within 15 tiles, taking supplies and useful gear. Player bodies and former player companions' bodies are left alone.
        -- Default on.
        BodyLoot_Enabled = true,

        -- Caps how many bodies one group searches each real minute. For example, 2 prevents it searching more than two corpses in a minute.
        -- Default 3. Min: 1 Max: 20 Default: 3
        BodyLoot_PerMinute = 3,

        -- Adds a survivor-run station with scanner traffic, military chatter, calls, stories, jokes and rumors about events in your world.
        -- Default on.
        Radio_KnoxCounty = true,

        -- Tracks kills, help and mistreatment, with change notices and character-window scores. Off stops both tracking and display.
        -- Default on.
        Reputation_Tracking = true,

        -- Each NPC remembers a separate opinion of each player, shaped by temperament, reputation and deeds toward their group. Shown in conversations. Off disables individual opinions.
        -- Default on.
        Reputation_NpcOpinion = true,

        -- Scales how deeds change an NPC's opinion. At normal strength, a gift gives about 8 points, a hit loses 20 and killing a groupmate loses 45; others may hear about it.
        -- Default 100. Min: 25 Max: 300 Default: 100
        Reputation_NpcOpinionScale = 100,

        -- Scales opinion's effect on prices, replies, invitations, company, deals, greetings, betrayal and orders. At 0, opinion is displayed but has no gameplay effect.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Reputation_NpcOpinionEffects = 100,

        -- How far each NPC's opinion moves back toward its starting value each day. At 0, the NPC never forgets.
        -- Default 3. Min: 0 Max: 20 Default: 3
        Reputation_NpcOpinionDecay = 3,

        -- Radio stories may name players after lasting reputation changes, fighting sprees or surviving raids. Requires personal reputation; never reveals the player's location.
        -- Default on.
        Reputation_RadioNames = true,

        -- Allows radio stories about a player's bad reputation. Off: only neutral or positive mentions are broadcast.
        -- Default on.
        Reputation_RadioBadNews = true,

        -- Food gifts and fair trades improve standing with the visitor's faction. Off: these choices do not change faction standing; existing grudges remain.
        -- Default Off (1). Default = Off
        -- 1 = Off
        -- 2 = On
        Reputation_Mode = 2,

        -- How quickly earned faction standing returns toward zero. At 200, it fades twice as fast; at 0, earned standing stays unchanged.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Reputation_DecayPercent = 100,

        -- Shows the number beside your reputation level in the character window, notes and radio panel, such as Cutthroat (-62). Off shows only the level name.
        -- Default on.
        Reputation_ShowScore = true,

        -- New characters reset personal reputation, faction standing and NPC memories, not faction or Creator relations. Off keeps the old values. Reconnecting never resets the same character.
        -- Default on.
        Reputation_ResetOnNewCharacter = true,

        -- The T-menu reputation answer also lists other players' reputation levels on the server. Off shows only your own.
        -- Default off.
        Reputation_ShowOthers = false,

        -- Killing an NPC already in a fight counts as a hostile kill and is not held against you. Off judges each kill by the NPC's attitude toward you.
        -- Default on.
        Reputation_NpcFightIsHostile = true,

        -- Points of personal reputation that drift toward neutral each day. At 0, your earned reputation stays unchanged.
        -- Default 5. Min: 0 Max: 50 Default: 5
        Reputation_DriftPerDay = 5,

        -- Scales personal reputation changes from kills and from deeds (visitors, hosting, gifts, treating, trading). At 0 none count; at 200 they count twice as much.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Reputation_KillScale = 100,

        -- Limits reputation gained from kills each day at full rate; extra hostile kills count at the reduced share below. Deeds get their own limit of 150 percent of this.
        -- Default 60. Min: 0 Max: 1000 Default: 60
        Reputation_GainCapPerDay = 60,

        -- Share of normal gain earned for hostile or criminal kills after the daily limit, with at least 1 point per kill. At 0, no further gain is possible that day.
        -- Default 25. Min: 0 Max: 100 Default: 25
        Reputation_OverCapPercent = 25,

        -- Extra points beyond a level boundary needed before your reputation label changes. Higher values reduce frequent label changes.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Reputation_Hysteresis = 15,

        -- Personal reputation gained for killing an NPC who was hostile toward you.
        -- Default 10. Min: 0 Max: 200 Default: 10
        Reputation_KillHostile = 10,

        -- Personal reputation gained for killing an NPC from a criminal faction.
        -- Default 15. Min: 0 Max: 200 Default: 15
        Reputation_KillCrime = 15,

        -- Personal reputation lost for killing a neutral or cautious NPC who meant you no harm.
        -- Default 40. Min: 0 Max: 500 Default: 40
        Reputation_KillNeutral = 40,

        -- Personal reputation lost for killing an NPC who regarded you as a friend.
        -- Default 80. Min: 0 Max: 500 Default: 80
        Reputation_KillFriendly = 80,

        -- Personal reputation lost for killing an NPC who had surrendered.
        -- Default 100. Min: 0 Max: 500 Default: 100
        Reputation_KillSurrendered = 100,

        -- Choose an unused frequency; 100000 means 100 MHz. Other channels are never replaced. Restart the server after changes, then open a radio to add the matching preset.
        -- Default 99600. Min: 88000 Max: 108000 Default: 99600
        Radio_KnoxFrequency = 99600,

        -- The admin console, spawn panel, encounter list, outpost builder and raid setup in the right-click menu. Players also need Diagnostics ticked in Options. Turn this off for a clean right-click menu; the Creator (Insert key) and world status (Home key) stay on their keys and the pause menu. Admins on a server are unaffected.
        -- Default on.
        Debug_ShowAdminTools = true,

        -- After an admin has run CLEANUP A-LIFE to the end, the mod stays inert in that world so it can be removed safely. Turn this on only if you want the mod to spawn people and outposts again in a cleaned world.
        -- Default off.
        Cleanup_RespawnAfter = false,

        -- Adds a right-click peephole view on closed doors. Each player can also turn it off in their own mod options.
        -- Default on.
        Peek_Enabled = true,

        -- Every few seconds, an NPC within two tiles of the door may hear you peeking and speak. They cannot see you through the peephole. At 0, peeking is never heard.
        -- Default 5. Min: 0 Max: 100 Default: 5
        Peek_NoticeChancePercent = 5,

        -- Hides faction, rank, mood and standing in the talk window. Shows only a name you have learned and held items. Off restores the full heading.
        -- Default on.
        Talk_MysteryMode = true,

        -- Moving vehicles hurt NPCs they hit, with damage based on speed. Off: collisions do no NPC damage. Intact car windows still protect you from NPC attacks either way.
        -- Default on.
        Combat_VehicleDamage = true,

        -- On: NPCs do not start fights in non-PvP zones, but still retaliate against an attacker. Off: NPCs may attack there. Safehouses protect you either way.
        -- Default off.
        Combat_NonPvpZoneShield = false,

        -- Scales how often NPC gunfire hits a ZOMBIE. 100 is unchanged; raise it if crews look helpless against a horde. Does not affect their aim against you. Min: 10 Max: 200 Default: 100
        Combat_AimZombiePercent = 100,

        -- Global multiplier on how often NPC gunfire hits players, applied on top of the NPC aim setting and each character's own accuracy. 100 is unchanged. NPCs also aim worse in the first seconds of a fight, at long range and against a moving target. Min: 10 Max: 200 Default: 70
        Combat_AimPlayerPercent = 70,

        -- Scales NPC melee and gun damage to players. At 50, each hit deals half the original damage; 100 is the original amount.
        -- Default 72. Min: 0 Max: 100 Default: 72
        Combat_DamagePercent = 72,

        -- Optional extra overall-health loss added on top of a hit, on top of the damage option above. 0 means no extra damage, so the 60% option is exactly 60% of the original hit. Default 0. Min: 0 Max: 200 Default: 0
        Combat_ExtraWoundPercent = 0,

        -- Scales each survivor's original health. At 80, they have four-fifths of their usual health; profession differences still apply.
        -- Default 98. Min: 25 Max: 300 Default: 98
        NpcHealth_Percent = 98,

        -- How hard bullets, melee hits, shoves and zombie bites land on NPCs, on top of the NPC maximum health setting. At 100 guns, shoves and bites cost what they used to, 130 is 30% more. Melee hits are priced so that the defaults keep the old number of swings. This is the damage NPCs receive, not what they deal to players (see NPC damage output). Default 130. Min: 25 Max: 400 Default: 130
        NpcHealth_DamageTakenPercent = 130,

        -- How fast a resting NPC recovers health. 100 is the original 1.5% of maximum health per game hour, 50 is half of that. Only an NPC that has been out of the fight for two minutes and has no open wound recovers. 0 turns recovery off. Default 50. Min: 0 Max: 400 Default: 50
        NpcHealth_RegenPercent = 50,

        -- Switches the NPC health rebalance off: original maximum health, original hits needed to put an NPC down, original bleeding and regeneration. Default off.
        NpcHealth_Legacy = false,

        -- NPCs carrying a weapon walk into buildings slowly with the weapon raised, pause at doorways and corners and look over the room before moving on.
        Combat_RoomSweep = true,

        -- Shows a visible streak along NPC gunshots. Turning this off does not change muzzle flashes, gunfire sounds or casings.
        -- Default on.
        Combat_VisibleTracers = true,

        -- Shows weapon-sized flashes and nearby ground light when NPCs fire. Suppressed weapons do not flash. Gunfire sounds and casings are unchanged.
        -- Default on.
        Combat_MuzzleFlash = true,

        -- Sets how far other players can see an NPC shot's flash and streak and hear its gunshot and casing in multiplayer.
        -- Default 90. Min: 20 Max: 150 Default: 90
        Combat_ShotFxRange = 90,

        -- Armed NPCs get out of the line of fire to reload, break contact when hurt, and fight from behind walls and corners.
        Modules_Cover = true,

        -- A shooter that is losing breaks contact, runs about a block back, holes up out of sight -- inside a building when there is one -- then comes back in from another side. Ranged only; melee always closes.
        Modules_Withdraw = true,

        -- Civilians, families and workers flee zombies, flinch at loud events and spread fear early in the outbreak. Soldiers, police and criminals stay steadier. Requires Civilian fear of zombies.
        -- Default on.
        Panic_FirstDays = true,

        -- 100% is the standard curve: full fright on days 0 and 1, then easing off. Lower values make survivors calmer, higher values keep them frightened longer. 0 turns the panic off. Min: 0 Max: 200 Default: 100
        Panic_Strength = 100,

        -- Stretches or shortens the early-outbreak panic curve. Fright is strongest at the start and nearly gone by this many days after the outbreak.
        -- Default 12. Min: 2 Max: 60 Default: 12
        Panic_LengthDays = 12,

        -- A frightened survivor makes the people around them more frightened for 30 to 60 seconds: their own group first, strangers within about 12 tiles less. Soldiers and police nearby calm them down. Off keeps every survivor's fright separate.
        Panic_Contagion = true,

        -- Civilians, families and workers avoid distant zombies and flee crowds for at least 30 seconds, fighting if cornered. Soldiers, police, criminals and hardened members stay steadier.
        -- Default on.
        Modules_Fear = true,

        -- Civilians start out at full fear and steady over this many days, down to the lingering fear below. 0 starts them at the lingering fear. Min: 0 Max: 30 Default: 7
        Fear_Days = 7,

        -- How many zombies it takes before civilians break and run. Default = Normal
        -- 1 = Hard to scare
        -- 2 = Normal
        -- 3 = Easily scared
        Fear_Level = 2,

        -- How much of their fear civilians keep once they have steadied. At 50 it takes a crowd about 1.6 times the size to make them run. 0 means they stop running from zombies altogether after the days above. Min: 0 Max: 100 Default: 50
        Fear_Lingering = 50,

        -- Poorly armed NPCs back away from a player or hostile aiming or raising a firearm. The Creator determines which factions and members have this fear.
        -- Default on.
        GunFear_Enabled = true,

        -- Chance that an NPC panics when a gun is aimed at it. Rolled once per NPC and player, so the same NPC always reacts the same way to the same player. A gun that is raised but not pointed at it counts half. Default 60. Min: 0 Max: 100 Default: 60
        GunFear_Percent = 60,

        -- How far, in tiles, a frightened NPC runs from the gun on each leg. It heads for cover that breaks line of sight and keeps going until the gun has been out of sight for a few seconds. Default 35. Min: 8 Max: 80 Default: 35
        GunFear_RunDistance = 35,

        -- How fast a frightened NPC runs away. A flight may use all of its stamina and slows down only when it is empty. Default = Sprint
        -- 1 = Run
        -- 2 = Sprint
        GunFear_RunSpeed = 2,

        -- How long an NPC freezes and stares at the gun before it starts to run. 0 runs at once. Default 400. Min: 0 Max: 3000 Default: 400
        GunFear_ReactDelayMs = 400,

        -- After a fight, a wounded NPC stops, bandages, and loses the limp and the bleeding.
        Modules_Healing = true,

        -- In melee, NPCs step back while swinging when zombies press or outnumber them, and step in when a lone zombie is within reach or backing off. Decided each swing from the zombies' positions and facing.
        Combat_MeleeFootwork = true,

        -- How many zombies facing an NPC within the step-back radius it takes before the NPC steps back between swings. 0 turns stepping back off. Min: 0 Max: 8 Default: 2
        Combat_MeleeKiteCrowd = 2,

        -- How far around an NPC zombies are counted for melee footwork. Min: 1 Max: 5 Default: 2
        Combat_MeleeKiteTiles = 2,

        -- How far an NPC steps back between swings. It never steps out of weapon reach. 16 is 1.6 tiles. Min: 3 Max: 30 Default: 16
        Combat_MeleeStepBackTenths = 16,

        -- How far an NPC steps toward a lone zombie that is in reach or backing off. 11 is 1.1 tiles. Min: 3 Max: 25 Default: 11
        Combat_MeleeStepInTenths = 11,

        -- A zombie an NPC has just struck with a melee weapon cannot start or finish a bite and stops chasing for this long, so a fighter who keeps swinging is not bitten by the zombie in front of him. 0 turns the stun off. Min: 0 Max: 3000 Default: 1100
        Combat_ZombieStunMs = 1100,

        -- Master switch. On: the Sawmill Hands crew can spawn and the five melee modules work. Off: the faction is hidden from spawning, the Creator and the debug spawner, and every melee module is inert.
        Melee_FactionEnabled = true,

        -- Sidestep between swings, back off when zombies press in, step back in afterwards. Tuned for pairs and groups.
        Melee_Footwork = true,

        -- In a melee group one member engages and the others circle round to the far side of the target.
        Melee_Flank = true,

        -- A fighter holding an axe cuts through doors and windows faster and does it when checking a noise. The normal courtesy rules still apply.
        Melee_Breach = true,

        -- Walks up on a player, shouts the warning from range, then closes in. The normal warn-before-strike rules still decide when the first blow may land.
        Melee_Intimidate = true,

        -- Breaks contact early when a few zombies close in, using the existing withdraw behaviour with a lower crowd threshold.
        Melee_Caution = true,

        -- How many zombies near a crew member make it retreat. Normal fighters need five. Min: 2 Max: 8 Default: 3
        Melee_CautionCrowd = 3,

        -- How quickly zombies notice and engage NPCs compared with the old pace. 500 is five times faster, 100 is the old pace. Higher values cost a little more processing near NPCs. Min: 100 Max: 1000 Default: 500
        Zombies_ReactSpeed = 500,

        -- Zombies use the game's bite and scratch attack animations when attacking NPCs.
        -- Default on.
        Zombies_AttackAnims = true,

        -- How many of the attacks on a standing NPC are scratches instead of bites. Min: 0 Max: 100 Default: 35
        Zombies_ScratchPercent = 35,

        -- Enough zombies grabbing one NPC at once drag it down and kill it, with the game's being-eaten voice.
        -- Default on.
        Zombies_DragDown = true,

        -- Sets how many zombies must grab an NPC at the same time to drag it down. For example, 4 requires four simultaneous attackers.
        -- Default 4. Min: 2 Max: 8 Default: 4
        Zombies_DragDownCount = 4,

        -- How long the NPC is held down before it dies. 30 is 3 seconds. Min: 5 Max: 60 Default: 30
        Zombies_DragDownTenths = 30,

        -- The base armour system for NPCs, with the same rules a player gets. It is not a Creator module. Every hit on an NPC (zombie bites and scratches, melee, bullets; from NPCs and from players) rolls against the matching protection of what is worn on the struck body part: bite, scratch or bullet defense. 100 always blocks, 0 never does, layers add up to 100. A blocked hit does no damage and cannot wound or infect, and the clothing tears. Body parts with no protection take the normal damage. Off ignores worn clothing. Default on.
        Combat_NpcArmorVsZombies = true,

        -- NPCs that would bleed out can lie injured, be rescued, bandaged or questioned. Off keeps ordinary injury behavior; in multiplayer, only the client controlling the NPC runs its movement.
        -- Default on.
        Injury_Enabled = true,

        -- A teammate or friendly ally from the same bloc who can see a downed NPC walks over and bandages it. The rescued NPC stands up limping.
        -- Default on.
        Injury_Rescue = true,

        -- Rescuers drag downed NPCs away before bandaging when zombies or hostiles are within 12 tiles. Off: rescue cannot start with danger that close.
        -- Default on.
        Injury_RescueDrag = true,

        -- Allows rescues while players are near or watching. Off: rescuers wait until all players are beyond the nearby-player distance set under expert combat.
        -- Default on.
        Injury_RescueInView = true,

        -- Teammates and friendly members of the same faction this close to the injured NPC may come to help. Helpers outside his squad also need a clear line of sight. Hostile NPCs never rescue him. Min: 5 Max: 40 Default: 15
        Injury_RescueRange = 15,

        -- Downed NPCs crawl away from zombies and hostiles toward their group, and occasionally shuffle instead of lying still.
        -- Default on.
        Injury_Crawl = true,

        -- When an NPC would start bleeding out, this is the chance it goes injured instead. 0 means only the debug menu makes injured NPCs. Min: 0 Max: 100 Default: 50
        Injury_AutoPercent = 50,

        -- Health an NPC has when it goes down injured. Min: 2 Max: 40 Default: 12
        Injury_DownHpPercent = 12,

        -- Each question put to an injured NPC can kill it. The player sees that it bled out. Min: 0 Max: 100 Default: 25
        Injury_InterrogationDeathPercent = 25,

        -- Taken once per injured NPC when you question a friendly, neutral or careful one. Hostile NPCs cost nothing. Min: 0 Max: 20 Default: 3
        Injury_RepPenalty = 3,

        -- Small reward for giving a bandage or medical item. Min: 0 Max: 20 Default: 4
        Injury_RepGain = 4,

        -- Sets the time from getting up with low health to full health and a normal walk. For example, 12 means half a game day of recovery.
        -- Default 8. Min: 1 Max: 72 Default: 8
        Injury_RecoverHours = 8,

        -- Sets how long a downed NPC waits without help before getting up on its own, still limping. For example, 6 means a quarter of a game day.
        -- Default 4. Min: 1 Max: 48 Default: 4
        Injury_DownHours = 4,

        -- Only used when Rescues happen in front of players is off: then a teammate rescues an injured NPC only when no player is within this range or in sight. Min: 10 Max: 60 Default: 25
        Injury_PlayerRangeTiles = 25,

        -- Lets downed NPCs run on a server with connected players. The client that controls the NPC keeps its own bleed-out timers and wound list; the server only hands it a downed state. Off keeps the ordinary bleed-out in multiplayer. Single player is not affected.
        -- Default on.
        Injury_MultiplayerEnabled = true,

        -- After you bandage an injured NPC it turns neutral and walks this far from you. Min: 30 Max: 120 Default: 45
        Injury_LeaveTiles = 45,

        -- Sets the volume of zombie bites, being-eaten voices and NPC pain cries. Sounds fade with distance and are heard only within 25 tiles. At 0, they are muted.
        -- Default 40. Min: 0 Max: 100 Default: 40
        Audio_BiteLoudness = 40,

        -- Hits cause bruises, fractures, cuts, bullet wounds or bites. Leg wounds slow NPCs, arm wounds spoil aim, and open wounds bleed until bandaged; below 10 percent health, bleed-out is rapid.
        -- Default on.
        Combat_Wounds = true,

        -- How fast an NPC's open wounds bleed: scratches and cuts clot on their own, deep wounds and bullet wounds bleed until bandaged. 0 turns the bleeding off. Min: 0 Max: 300 Default: 100
        Combat_InjuryBleed = 100,

        -- Chance that an NPC's hit with a heavy blunt weapon (bat, sledgehammer) breaks the player's arm or leg it lands on. Blunt weapons never cut: a laceration becomes a scratch. Min: 0 Max: 50 Default: 4
        Combat_BluntFracture = 4,

        -- Allows sprint windows for melee closing, cover moves, and retreats. Off keeps those moves at a run or walk.
        Modules_Sprint = true,

        -- A shooter that loses sight of its target dumps the magazine into the last known position, full auto, spraying left and right. Pistols magdump too.
        Modules_Gunner = true,

        -- Allows groups such as patrols, scavengers and hostile crews to appear near players in suitable map areas.
        -- Default on.
        Encounters_Enabled = true,

        -- Sets the time between random encounter checks, including while sleeping or fast-forwarding. The encounter chance still decides whether a group appears.
        -- Default 45. Min: 10 Max: 720 Default: 45
        Encounters_IntervalMinutes = 60,

        -- Scales Roadside Pickers, small looting crews that may warn or rob you. They are common in the first two weeks and gone by week four. At 0, they do not appear.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Encounters_EarlyLooters = 100,

        -- Free groups choose goals such as supplies or shelter, discuss them and follow through until done, blocked, hurt or threatened. Off: groups return to travelling and idling.
        -- Default on.
        Plans_Enabled = true,

        -- Sets how far a group looks for a building to visit for its plan. Nearby buildings are preferred; 80 limits the search to 80 tiles.
        -- Default 100. Min: 40 Max: 200 Default: 100
        Plans_Radius = 100,

        -- Sets how long a group keeps a plan before giving up and choosing again. Shelter plans last until morning.
        -- Default 6. Min: 1 Max: 48 Default: 6
        Plans_LifespanHours = 6,

        -- Groups discuss plans before leaving and speak when they arrive or give up. Off: they still follow plans, but silently.
        -- Default on.
        Plans_Talk = true,

        -- Crews can move on after an encounter, such as fixing a car then scavenging from it. Distant groups plan around supplies. Off: crews keep their earlier behavior.
        -- Default on.
        Activities_Enabled = true,

        -- Sets the share of finished encounters whose crews take up another activity. The rest keep their post and later leave as before; higher values put more crews on roads.
        -- Default 70. Min: 0 Max: 100 Default: 70
        Activities_SwitchChance = 70,

        -- Allows armed NPC crews to hunt. Offline only allows hunting away from players and leaves nearby wildlife to you.
        -- Default Offline and nearby wildlife (3). Default = Offline and nearby wildlife
        -- 1 = Off
        -- 2 = Offline only
        -- 3 = Offline and nearby wildlife
        Activities_Hunting = 3,

        -- A crew stuck at a broken or crashed car this long may leave it and go scavenging, but only when no player is nearby.
        -- Default 10. Min: 1 Max: 72 Default: 10
        Activities_SwitchHours = 10,

        -- A crew cannot abandon its car while any player is closer than this distance. For example, 80 keeps it at the car while you are within 80 tiles.
        -- Default 60. Min: 20 Max: 150 Default: 60
        Activities_SwitchClearTiles = 60,

        -- Crews of two or more may settle in an empty building away from players, store their loot and return after trips.
        -- Default on.
        Activities_Bases = true,

        -- Caps settled NPC bases across the world. If the limit is exceeded, the oldest base is abandoned. At 0, crews cannot found new bases.
        -- Default 6. Min: 0 Max: 24 Default: 6
        Activities_MaxBases = 6,

        -- Scales encounters with fishers, hunters, foragers, woodcutters, camp builders, scavengers and water carriers. 100 keeps the usual rate; 0 disables these encounters.
        -- Default 100. Min: 0 Max: 500 Default: 100
        Activities_PartyWeight = 100,

        -- Chance that each eligible crew founds a base, checked once per game day.
        -- Default 25. Min: 0 Max: 100 Default: 25
        Activities_BaseChance = 25,

        -- Time a crew with a base spends away before planning a return home.
        -- Default 8. Min: 2 Max: 48 Default: 8
        Activities_BaseReturnHours = 8,

        -- Minimum distance from any player when an NPC crew founds a base.
        -- Default 45. Min: 20 Max: 120 Default: 45
        Activities_BaseClearTiles = 45,

        -- Scales food gained from NPC hunts. 100 keeps the usual amount; 0 gives no food and 200 gives twice the usual amount.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Activities_HuntYieldPercent = 100,

        -- Allows NPC crews to fish near water without reducing the fish available to players.
        -- Default on.
        Activities_Fishing = true,

        -- Sessions last 60-140 percent of this time. Fishers stop if noticed by a player, hostile or zombie, or after gunfire or a hit.
        -- Default 65. Min: 10 Max: 240 Default: 65
        Activities_FishingMinutes = 65,

        -- Scales fish caught by NPC crews. 100 keeps the usual catch; 0 gives no fish and 200 gives twice the usual catch.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Activities_FishYieldPercent = 100,

        -- Foraging crews bring seasonal berries, herbs, nuts and mushrooms to their camp stash. This does not reduce what players can forage.
        -- Default on.
        Activities_Foraging = true,

        -- Scales food foraged per crew per game day. 100 gives six items, 200 gives twelve and 0 gives none.
        -- Default 100. Min: 0 Max: 300 Default: 100
        Activities_ForageYieldPercent = 100,

        -- Scales how quickly groups become hungry and thirsty. Higher values cause more supply runs and more chances to encounter you.
        -- Default 100. Min: 25 Max: 400 Default: 100
        Activities_NeedsDrainPercent = 100,

        -- Caps encounter crews kept travelling while you are away; they share the distant-group limit. Extra crews may continue while you are near, then leave the world as before.
        -- Default 6. Min: 0 Max: 24 Default: 6
        Activities_AdoptCap = 6,

        -- On: repaired cars have working engines, batteries, bonnets and some fuel, and remain with their trunk loot. Off: the car stays a wreck but remains the crew's stash.
        -- Default on.
        Activities_FixedCarDrivable = true,

        -- Sets how full a repaired car's fuel tank is. For example, 25 gives it a quarter tank.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Activities_FixedCarFuelPercent = 15,

        -- Removes inactive NPCs after nobody has approached them for this long. Persistent crews, such as anchored NPCs and garrisons, never expire. At 0, cleanup is disabled.
        -- Default 8. Min: 0 Max: 168 Default: 8
        Population_DormantTtlHours = 8,

        -- The conduct layer: squad leaders that deploy and rally their group, snipers that keep distance, medics that dress their wounded, ambushers that wait in the dark, stealth killers. Off disables every conduct at once.
        Modules_Behaviors = true,

        -- Armed NPCs keep the gun on their target, or on where it was last seen, while they walk, back off or sidestep.
        Modules_Strafe = true,

        -- Flashlights: NPCs see 12 tiles in darkness, or 20 when their light reaches you. Night vision: they can see at night, but you must supply goggles yourself.
        -- Default Flashlights (1). Default = Flashlights
        -- 1 = Flashlights
        -- 2 = Night vision
        Night_Sight = 1,

        -- How many groups keep travelling and working at night. No risks makes everyone shelter; Risk takers keeps most groups active.
        -- Default Moderate chance (3). Default = Moderate chance
        -- 1 = No risks
        -- 2 = Low chance
        -- 3 = Moderate chance
        -- 4 = High chance
        -- 5 = Risk takers
        Night_Activity = 3,

        -- Saved travelling groups return up to this rate-scaled limit after restart; at 0 or in Local only, the saved-crew cap applies. Lowering stops new groups; extras keep moving until reload.
        -- Default 45. Min: 0 Max: 500 Default: 45
        Offline_SquadCap = 18,

        -- Limits outpost garrisons and persistent crews kept after restart. Distant travelling groups and starting building residents have separate limits. Lowering it affects the next save.
        -- Default 60. Min: 0 Max: 500 Default: 60
        Population_PersistentSquadCap = 20,

        -- Visitors, travellers and traders you met stay in the world when you quit. Raiders and other hostile groups do not. Counts toward the saved crew limit.
        -- Default on.
        Population_KeepEncounterNpcs = true,

        -- Caps simultaneous patrol, scavenging and hunting teams from each outpost. At 0, none are sent. Teams last for the session; the outpost stays saved.
        -- Default 3. Min: 0 Max: 4 Default: 3
        Outposts_TaskSquadCap = 4,

        -- Sets how often distant travelling groups move and make decisions. Longer intervals mean fewer updates.
        -- Default 20. Min: 10 Max: 60 Default: 20
        Offline_TickSeconds = 15,

        -- How far an offline squad walks in one in-game hour. Default 150, a walking pace at the default day length; towns are 1700-3400 tiles apart. Min: 20 Max: 400 Default: 150
        Offline_TravelTilesPerHour = 150,

        -- Groups that lose members to you and escape can return for revenge two to three game days later, bringing backup.
        -- Default on.
        Offline_RevengeEnabled = true,

        -- Sets the daylight game hours between distant travelling groups (up to 1500 tiles away) heading for you and arriving out of sight. Hostile ones wait until day 3. At 0, off.
        -- Default 6. Min: 0.00 Max: 48.00 Default: 6.00
        Offline_ApproachGapHours = 6.0,

        -- Game hours between hunts sent by each hostile outpost. From day 7, after dark, one crew per player. Uses faction sightings refreshed every 24 game hours. At 0, off.
        -- Default 72. Min: 0 Max: 168 Default: 72
        Assassins_GapHours = 72,

        -- Lets fortified stations, occupied houses and forest camps appear over time, with garrisons that remain at their site.
        -- Default on.
        Outposts_Enabled = true,

        -- Limits how many outposts may exist at once across the map. At 0, outposts are disabled.
        -- Default 9. Min: 0 Max: 24 Default: 9
        Outposts_MaxSites = 14,

        -- Limits how many fortified-building outposts each town may hold. Outdoor camps have a separate limit.
        -- Default 2. Min: 1 Max: 4 Default: 2
        Outposts_PerCity = 2,

        -- Time between chances to found an outpost. Sleep and fast-forward count. If the game clock stops, checks use this many real minutes instead.
        -- Default 20. Min: 5 Max: 120 Default: 20
        Outposts_IntervalMinutes = 30,

        -- Chance that an outpost check founds a new site, if a suitable location is available.
        -- Default 35. Min: 0 Max: 100 Default: 35
        Outposts_Chance = 20,

        -- Normal outposts start within this distance, at least 40 tiles from players. Fixed checkpoints may start up to 200 tiles away; all need loaded ground.
        -- Default 120. Min: 60 Max: 200 Default: 120
        Outposts_BuildRadius = 120,

        -- Share of destroyed or burned walls, doors, windows and fences that causes an outpost to be removed. At 0, this damage-based removal is disabled.
        -- Default 40. Min: 0 Max: 100 Default: 40
        Outposts_StructureLossPercent = 40,

        -- Pauses multiplayer wall and structure work until players stop crossing map sections. At least 5 seconds protects loading clients; new joins keep a separate 30-second pause.
        -- Default 5. Min: 5 Max: 30 Default: 5
        Outposts_StreamHoldSeconds = 5,

        -- A built outpost receives its garrison when a player comes within this distance.
        -- Default 90. Min: 40 Max: 150 Default: 90
        Outposts_SpawnRadius = 90,

        -- Sets the relative frequency of natural 1-3-person parties compared with larger groups. Higher means more small parties; faction-specific rules take priority.
        -- Default 2. Min: 0.00 Max: 20.00 Default: 2.00
        Party_LoneWeight = 3.0,

        -- Sets the relative frequency of natural groups of 4 or more compared with small parties. Equal weights give both sizes equal selection weight.
        -- Default 2. Min: 0.00 Max: 20.00 Default: 2.00
        Party_GroupWeight = 1.0,

        -- Sets the minimum time between new distant travelling groups. Existing groups stay; the world group limit and local quiet periods still apply.
        -- Default 3. Min: 0.25 Max: 48.00 Default: 3.00
        Offline_FoundGapHours = 1.5,

        -- Enables automatic raids: a radio warning, scouts arriving unseen, then a buildup before the attack. The earliest raid day still applies. Admins can force raids.
        -- Default on.
        Raid_Enabled = true,

        -- Automatic raids cannot begin before the world reaches this age. For example, 60 prevents them during the first 60 game days.
        -- Default 21. Min: 0 Max: 365 Default: 21
        Raid_MinDay = 20,

        -- Sets the minimum time between automatic full-scale raids. For example, 14 requires at least two game weeks between raids.
        -- Default 14. Min: 0.25 Max: 60.00 Default: 14.00
        Raid_CooldownDays = 10.0,

        -- Chance for scouts to begin a raid buildup on each check. Set 0 to stop automatic raids; cooldown and earliest-day limits still apply.
        -- Default 0.025. Min: 0.00 Max: 100.00 Default: 0.03
        Raid_Chance = 0.01,

        -- How often the raid director checks automatic eligibility. Min: 1 Max: 120 Default: 10
        Raid_CheckMinutes = 10,

        -- Sets the number of attacking waves in a raid. The total attacker limit still applies, so extra waves do not bypass that limit.
        -- Default 4. Min: 1 Max: 10 Default: 4
        Raid_Waves = 3,

        -- Sets the requested attackers in each wave. The total raid limit and other spawn limits can reduce the actual number.
        -- Default 8. Min: 1 Max: 12 Default: 8
        Raid_GroupSize = 6,

        -- Caps attackers across all automatic raid waves, spread evenly among the waves. Earlier scouts do not count. Admin-forced raids ignore this limit.
        -- Default 12. Min: 1 Max: 48 Default: 12
        Raid_MaxAttackers = 8,

        -- Sets the warning-to-scout delay; the raid follows its buildup. 0 sends scouts immediately. Scouts and raiders walk in from 40-50 tiles away, unseen and away from player bases.
        -- Default 3. Min: 0.00 Max: 24.00 Default: 3.00
        Raid_WarningHours = 3.0,

        -- Paces reinforcement waves after the initial warning. Min: 1 Max: 120 Default: 5
        Raid_WaveDelayMinutes = 5,

        -- Allows all A-Life helicopters: raid and backup arrivals, night searchlights and flyovers. Off: none of these helicopters fly.
        -- Default on.
        Raid_Helicopter = true,

        -- Controls opening sirens, jets and raid aircraft sounds. Helicopter raid arrivals also need the helicopter option switched on.
        -- Default on.
        Raid_SirenAircraftSounds = true,

        -- Wait this long after scouts successfully arrive before a raid can start. Min: 0.00 Max: 72.00 Default: 6.00
        Raid_ScoutBuildupHours = 6.0,

        -- An expired scout report cannot authorize a raid; new scouts must be sent. Min: 1.00 Max: 168.00 Default: 48.00
        Raid_ScoutLifetimeHours = 48.0,

        -- Sets how many enemy scouts arrive before an automatic full-scale raid. They are separate from the raid's total attacker limit.
        -- Default 4. Min: 1 Max: 8 Default: 4
        Raid_ScoutSize = 3,

        -- Groups in contact may request backup, with limited calls, a cooldown and a chance of no answer.
        -- Default on.
        Support_Enabled = true,

        -- Sets the chance that an allowed backup call succeeds. For example, 50 gives each permitted call a one-in-two chance of an answer.
        -- Default 35. Min: 0 Max: 100 Default: 35
        Support_Chance = 20,

        -- Sets the minimum wait between successful backup calls by the same group. For example, 6 means it must wait a quarter of a game day.
        -- Default 1.5. Min: 0.00 Max: 24.00 Default: 1.50
        Support_CooldownHours = 3.0,

        -- Sets backup size only when the calling NPC or its faction has no size of its own. It does not replace sizes chosen in their profiles.
        -- Default 4. Min: 1 Max: 8 Default: 4
        Support_GroupSize = 3,

        -- Limits how many reinforcement requests one group may make, preventing repeated backup calls without end.
        -- Default 2. Min: 0 Max: 10 Default: 2
        Support_MaxCalls = 1,

        -- Sets the chance of a searchlight call from an NPC authorized to request helicopter support. Ground-only callers cannot request it.
        -- Default 20. Min: 0 Max: 100 Default: 20
        Support_SpotlightChance = 12,

        -- Sets how long a requested searchlight flight lasts before the helicopter leaves.
        -- Default 180. Min: 5 Max: 180 Default: 180
        Support_SpotlightSeconds = 180,

        -- Sets how long the support helicopter's flyover effects last. This does not set how long ground reinforcements stay.
        -- Default 35. Min: 5 Max: 180 Default: 35
        Support_HelicopterSeconds = 35,

        -- Allows moving searchlights at night or in low light. They can reveal people outdoors; cover and buildings hide them. Off disables only the searchlight.
        -- Default on.
        Helicopter_Spotlight = true,

        -- Sets the radius of the lit area. A larger beam covers more ground and makes it easier to be caught in the light.
        -- Default 11. Min: 4 Max: 20 Default: 11
        Helicopter_SpotlightSize = 11,

        -- Sets how strongly the helicopter searchlight illuminates the ground.
        -- Default 100. Min: 20 Max: 100 Default: 100
        Helicopter_SpotlightBrightness = 100,

        -- Sets the minimum time between searchlight flights anywhere in the world. Shorter intervals allow more flights; the call chance still applies.
        -- Default 20. Min: 2 Max: 240 Default: 20
        Helicopter_SpotlightGapMinutes = 20,

        -- Residents slowly carry zombie corpses out of loaded buildings to reduce corpse sickness. Never removes player or NPC corpses, or corpses in claimed player safehouses.
        -- Default on.
        Residents_ClearCorpses = true,

        -- Sets how far scavengers look for a nearby building. Higher values widen the search but increase the work needed to find one.
        -- Default 27. Min: 10 Max: 60 Default: 27
        Scavenge_BuildingRadius = 27,

        -- Scavengers return to their camp or base depot after collecting this many items. For example, 4 sends them home with four collected items.
        -- Default 8. Min: 1 Max: 24 Default: 8
        Scavenge_CarryLimit = 8,

        -- Scavengers bring supplies home after searching this many buildings. For example, 3 allows three building searches before returning.
        -- Default 2. Min: 1 Max: 8 Default: 2
        Scavenge_ReturnAfterBuildings = 2,

        -- Adds winter layers, removes heavy layers in summer and adds rainwear in wet weather. Uniforms and profiles with their own seasonal outfits are preserved.
        -- Default on.
        Loadouts_SeasonalDress = true,

        -- Each new person gets their own hair, hair colour, beard and clothing colours, so crews stop looking cloned. Off keeps the authored look. People already in a save keep theirs.
        -- Default on.
        Appearance_Variation = true,

        -- Share of new people who keep their authored face, so named characters stay recognisable. 0 varies everyone, 100 varies nobody. Needs Varied NPC looks on.
        -- Default 35. Min: 0 Max: 100 Default: 35
        Appearance_KeepAuthoredPercent = 35,

        -- People whose profile lists several weapons for one slot pick one of them per person. Off always uses the first listed weapon. Profiles with a single weapon are unaffected. Default on.
        Appearance_LoadoutVariation = true,

        -- Weather and clothing affect NPC warmth. Prolonged chill can cause coughing, worse aim, slower walking and faster fatigue. Indoors or near a fire, NPCs warm up.
        -- Default on.
        Cold_Enabled = true,

        -- How hard the cold hits NPCs and how big the penalties of a cold are. 0 = NPCs never get chilled. 100 = default and gentle. 300 = harsh winters. Default 100. Min: 0 Max: 300 Default: 100
        Cold_Severity = 100,

        -- Per game hour spent badly chilled, the base chance that an NPC comes down with a cold (it grows with how chilled and wet the NPC is). 0 = chills never turn into a cold. Default 6. Min: 0.00 Max: 100.00 Default: 6.00
        Cold_ChancePercent = 6.0,

        -- A sneeze or cough from a sick NPC is a small sound (a few tiles) that nearby zombies can hear. Turn off to keep them silent.
        Cold_SneezeNoise = true,

        -- Chilled NPCs without orders or danger seek a fire or heated building and wear warmer clothes from their packs. Groups follow their leader to a fire.
        -- Default on.
        Cold_SeekWarmth = true,

        -- In cold weather, NPCs sitting beside a lit campfire periodically hold their hands toward it. In warm weather or without a fire, they just sit.
        -- Default on.
        Idle_CampWarmHands = true,

        -- Shore fishers cast, wait and pull their rods every 20-60 seconds. Off: they continue fishing without the rod animation.
        -- Default on.
        Idle_FishingAnim = true,

        -- Camp sitters beside a free outdoor bench sit on it instead of the ground. Off: they always sit on the ground.
        -- Default on.
        Idle_BenchSeat = true,

        -- New arrivals from built-in factions mix uniforms with civilian clothes from this day; makeshift armour appears later. At 0, uniforms stay intact. Creator profiles are unchanged.
        -- Default 10. Min: 0 Max: 365 Default: 10
        Loadouts_UniformDecayDay = 10,

        -- Sets how quickly built-in civilian groups gain guns over time. At 200, guns spread twice as fast; at 50, half as fast. Police, army and elite units are unaffected.
        -- Default 100. Min: 25 Max: 400 Default: 100
        Loadouts_ArmingPace = 100,

        -- Scales gun ownership among built-in non-military NPCs. At 0, affected NPCs use melee tools only. Police, army, elite units and Creator profiles are unchanged.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Loadouts_ArmingShare = 100,

        -- Full keeps groups travelling beyond players' view. Local only stops new distant groups; existing ones retire on reload. Outposts can still develop in either mode.
        -- Default Full A-Life (offline squads roam the map) (1). Default = Full A-Life (offline squads roam the map)
        -- 1 = Full A-Life (offline squads roam the map)
        -- 2 = Local only (groups near players; outposts stay)
        World_Mode = 1,

        -- Scales the chance of a random group near players without changing check intervals. Low halves the chance; Abundant triples it.
        -- Default Normal (2). Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        -- 5 = Abundant
        Rate_Encounters = 2,

        -- Scales natural group arrivals and the distant travelling group limit together. Low halves both; Abundant triples them, within their limits.
        -- Default Normal (2). Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        -- 5 = Abundant
        Rate_Groups = 2,

        -- Scales how often friendly, neutral and wary factions are picked compared with hostile ones. Low halves their selection weight; Abundant triples it.
        -- Default Normal (2). Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        -- 5 = Abundant
        Rate_Survivors = 2,

        -- Changes distant gunfire, helicopters and other background events. Low halves event limits and doubles the wait between them.
        -- Default Normal (2). Default = Normal
        -- 1 = Low
        -- 2 = Normal
        -- 3 = High
        -- 4 = Very High
        -- 5 = Abundant
        Rate_MetaEvents = 2,

        -- Limits outdoor sites such as forest camps, field bases and aid stations, separate from fortified town buildings. At 0, outdoor sites are disabled.
        -- Default 4. Min: 0 Max: 12 Default: 4
        Outposts_OutsideCity = 3,

        -- Allows cautious survivor communities to hold outposts alongside hostile crews. They warn strangers away but never send hunting parties. Off leaves only hostile holders.
        -- Default on.
        Outposts_SurvivorHolds = true,

        -- Patrols and scouts pause off the road every few hours and after fights to sit, smoke, drink or talk, then resume their route.
        -- Default on.
        PatrolRest_Enabled = true,

        -- Sets the minimum length of a patrol rest. For example, 30 means each rest lasts at least half a game hour.
        -- Default 20. Min: 5 Max: 180 Default: 20
        PatrolRest_MinMinutes = 20,

        -- Sets the maximum length of a patrol rest. For example, 60 limits each rest to one game hour.
        -- Default 45. Min: 10 Max: 240 Default: 45
        PatrolRest_MaxMinutes = 45,

        -- Sets the usual time between a group's planned rests, with some variation. Rest after a fight is separate from this schedule.
        -- Default 3.0. Min: 0.50 Max: 48.00 Default: 3.00
        PatrolRest_EveryHours = 3.0,

        -- Controls notes, gifts, visitors and attacks at claimed safehouses or buildings you live in. Off disables these base events.
        -- Default Normal (3). Default = Normal
        -- 1 = Off
        -- 2 = Rare
        -- 3 = Normal
        -- 4 = Often
        Safehouse_Events = 3,

        -- Some visitors may lie about why they came. They give a warning sign before you open the door.
        -- Default on.
        Safehouse_Betrayal = true,

        -- Allows groups who hate you to attack your base after warnings. Off prevents these base-event attacks.
        -- Default on.
        Safehouse_Attacks = true,

        -- Only when invited: visitors enter after you let them in at the door. Never: all visitors remain outside.
        -- Default Only when invited (1). Default = Only when invited
        -- 1 = Only when invited
        -- 2 = Never
        Safehouse_Entry = 1,

        -- Time after a place becomes your base before its first base event can happen.
        -- Default 3. Min: 0 Max: 14 Default: 3
        Safehouse_QuietDays = 3,

        -- Allows base events on dedicated servers while at least one resident is online. Off disables them there. Single player and co-op do not need this switch.
        -- Default on.
        Safehouse_Dedicated = true,

        -- Radio messages, door marks, knocks, distant gunfire and dog barks can happen in the world. Off leaves text notices only.
        -- Default on.
        Events_ScriptedEffects = true,

        -- Tunes and switches on a nearby radio for base-event messages, then turns it off. No radio: text only. Requires physical and audible base-event effects.
        -- Default on.
        Events_RadioActivate = true,

        -- Survivors may ask about your travels or how you cope: up to two questions per talk, then a ten-real-minute cooldown. Not during combat, injury or surrender.
        -- Default on.
        Talk_NpcQuestions = true,

        -- Shows requests for an NPC to follow you or walk alongside you. These conversation choices are still being reworked.
        -- Default off.
        Talk_FollowOptions = false,

        -- Visitor and ambient NPC lines show over their heads only within this many tiles, and only if you can see them or stand by the door. 0 shows them at any distance.
        -- Default 14. Min: 0 Max: 60 Default: 14
        Text_VisitorRangeTiles = 14,

        -- NPC speech appears as a bubble with the speaker's name and a pointer. A speaker off screen gets an edge arrow and the distance. Off: the game's plain floating text.
        -- Default on.
        Text_Bubbles = true,

        -- Shows a clickable Talk or Answer button while a visitor waits at your door or someone has just asked you something. Right-click still works.
        -- Default on.
        Talk_StartButton = true,

        -- How solid the talk window and the speech bubble boxes are. Text stays fully opaque. Lower is more see-through, 100 is the classic look.
        -- Default 100. Min: 40 Max: 100 Default: 100
        Talk_UIOpacity = 100,

        -- Copies NPC speech into the chat box in multiplayer, or a small log panel in single player. Only on your own screen, rate limited, names follow the stranger rule.
        -- Default Off (1). Default = Off
        -- 1 = Off
        -- 2 = Spoken to you
        -- 3 = Everything you hear
        Text_NpcChatLog = 1,

        -- Travellers may visit your door with goods to trade. Their trading conversation is still being reworked.
        -- Default off.
        Safehouse_TraderVisits = false,

        -- Places washable wall marks by the door: up to four, fading after ten game days. Off gives text only. Requires physical and audible base-event effects.
        -- Default on.
        Events_WallMarks = true,

        -- A hostile NPC never lands its first blow or shot on a player who has not attacked it unless the player had a fair chance to notice: a shouted warning, a door or window heard opening, or the NPC in plain view for the first-contact grace. Fighting back is never delayed.
        Fair_TellBeforeStrike = true,

        -- How long a hostile NPC must have been in your view before it may attack without shouting first. Min: 0.00 Max: 10.00 Default: 2.50
        Fair_FirstContactGrace = 2.5,

        -- Time between a hostile NPC's warning shout and its first blow or shot. Min: 0.50 Max: 6.00 Default: 1.50
        Fair_WarningLead = 1.5,

        -- Time between the sound of a hostile NPC opening a door or climbing through a window and its first attack on a player nearby. Min: 0.00 Max: 6.00 Default: 1.50
        Fair_EntryLead = 1.5,

        -- How long an NPC needs to open a closed window before it climbs through. The window can be heard opening. Min: 0.30 Max: 4.00 Default: 1.20
        Fair_WindowOpenTime = 1.2,

        -- How long NPCs remember who started a fight with a player. Fighting back inside this time is self-defence, and the NPC that started it does not speak like a victim. Min: 10 Max: 240 Default: 60
        Fair_FightMemory = 60,

        -- Enables warnings for crews set to warn; others attack on sight unless a chance below allows a warning. Off: hostile crews attack on sight. Careful factions keep their own rules.
        -- Default on.
        Warning_Enabled = true,

        -- Sets the share of normally kill-on-sight crews that warn anyway. Each group rolls once and keeps its result. 0 means none; 100 means all. Raids use their separate chance.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Warning_ChancePercent = 15,

        -- Sets the share of raids, assassins, highway ambushers and admin-spawned attackers that warn first. 0 makes all of these crews attack on sight.
        -- Default 10. Min: 0 Max: 100 Default: 10
        Warning_RaidChancePercent = 10,

        -- Limits unanswered warnings, standoffs and hold-ups. A crew waits four fifths of this per warning or demand before the next step. Replies restart the clock, up to four times this limit.
        -- Default 8. Min: 2 Max: 60 Default: 8
        Warning_HoldSeconds = 8,

        -- Crews that warn may question you, demand a toll or call you outside before fighting. Silence, leaving, a raised gun or betrayal can start a fight. Off: only their attack warning remains.
        -- Default on.
        Encounter_Standoffs = true,

        -- How long a hostile crew holds its fire after it discovers a player: time to answer, drop the weapon, raise the hands or act first. Aiming at the crew or attacking it ends the beat at once. Min: 1.00 Max: 10.00 Default: 3.00
        Encounter_SurpriseSeconds = 3.0,

        -- How long a confronting crew waits for an answer before it asks again ('Will you answer me?'). After the third silence the crew acts: leave, warn or attack, by faction. Min: 4 Max: 30 Default: 10
        Encounter_AnswerSeconds = 10,

        -- Scales how often crews call hidden players outside instead of searching; police do this more than raiders. Player bases are always called out first. 0 disables ordinary callouts.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Encounter_CalloutPercent = 100,

        -- How long a crew outside a building waits for the player to answer or come out, with repeated calls and a warning shot, before it searches the building or leaves. The time left is shown to the player. Min: 15 Max: 180 Default: 45
        Encounter_CalloutSeconds = 45,

        -- Scales outlaw flanking during talks. A flanker circles while the leader stalls; calling it out or raising a gun makes them back off. 0 disables this betrayal.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Encounter_BetrayalPercent = 100,

        -- How long a crew searches a building where it believes a player is hiding: one man at the door, the rest room by room. Then it gives up and moves on. Min: 20 Max: 600 Default: 90
        Encounter_SearchSeconds = 90,

        -- How long an NPC keeps chasing a player it can no longer see or hear. After that it only knows where he was last seen and searches from there. Min: 2.00 Max: 30.00 Default: 6.00
        Encounter_LostSightSeconds = 6.0,

        -- A hunting, raiding or revenge crew gets ONE tip about where its target is when it sets out, off by up to this many tiles. It never follows the player's live position; it searches and gives up. Min: 0 Max: 60 Default: 12
        Encounter_FixBlurTiles = 12,

        -- Stand-offs and hold-ups lean on gestures and distance instead of text over heads: one spoken line per phase (notice, demand, turn, parting), the rest goes to the talk panel, hand signals and nods carry the in-between. Every line is picked so it does not repeat. Off: every line is shouted over the head as before.
        -- Default on.
        Encounter_ScriptedCues = true,

        -- In a hold-up one crew member, never the speaker if someone else is free, walks up to arm's length and pats you down with an animation and one of three pat-down sounds. The search lasts exactly as long as the sound. If you step away or fight, it stops and the crew reacts. Off: the old instant search.
        -- Default on.
        Robbery_FriskScripted = true,

        -- Limits revenge groups sent after a player for one grudge. Each is drawn from the original crew's survivors plus at most two reinforcements.
        -- Default 2. Min: 1 Max: 10 Default: 2
        Revenge_MaxWaves = 2,

        -- Your shoves briefly stagger NPCs, and melee hits interrupt their next swing. A staggered NPC cannot finish its attack.
        -- Default on.
        Outplay_Stagger = true,

        -- Unvisited scavenged buildings may have fewer valuables and signs of looting. Never changes buildings players entered, player bases, safehouses or outposts.
        -- Default on.
        PickedOver_Enabled = true,

        -- Scales the chance that a building is already scavenged. 100 keeps the usual chance, 300 triples it and 0 disables it.
        -- Default 100. Min: 0 Max: 300 Default: 100
        PickedOver_Strength = 100,

        -- Sets the base chance before building type and rate scaling. Nearby scavenging adds up to 60 percentage points before those adjustments.
        -- Default 5. Min: 0 Max: 100 Default: 5
        PickedOver_Baseline = 5,

        -- Already scavenged buildings may show open doors, broken windows and blood. These signs are placed only while every player is at least 40 tiles away.
        -- Default on.
        PickedOver_Visuals = true,

        -- Already scavenged buildings may contain one or two dead zombies.
        -- Default on.
        PickedOver_ZombieCorpses = true,

        -- A building may rarely contain a dead member of the group that scavenged the area, wearing that group's clothes and carrying its gear.
        -- Default on.
        PickedOver_FactionCorpses = true,

        -- NPCs killed in battles away from players leave dressed bodies at the battle site. Bodies are placed while players are 40-110 tiles away and forgotten after 14 game days.
        -- Default on.
        WarDead_Enabled = true,

        -- Outposts start with one or two ground-floor planks, adding more every four game days while players stay over 40 tiles away. Upstairs gets sheets; metal bars stay unchanged.
        -- Default on.
        Boarding_Staged = true,

        -- Crews weigh guns, ammo, distance and nearby zombies before attacking a player, and avoid poor odds. Crews sent to attack and NPCs you have hurt still fight.
        -- Default on.
        Discretion_Enabled = true,

        -- Uses each faction's view of your profession when choosing nearby encounters. Off: every profession uses that faction's general attitude.
        -- Default on.
        Reputation_ProfessionEncounters = true,

        -- During the first week, NPCs from a similar background may recognise your former profession, such as police recognising police. Requires personal reputation.
        -- Default on.
        Reputation_ProfessionRecognition = true,

        -- Time an invited visitor waits for the door to open before giving up.
        -- Default 10. Min: 2 Max: 60 Default: 10
        Safehouse_InviteMinutes = 10,

        -- Visitors face the door and wait for roughly two thirds to four thirds of this duration. Opening the door, talking or attacking ends it immediately. At 0, no initial wait.
        -- Default 30. Min: 0 Max: 120 Default: 30
        Safehouse_VisitorHoldSeconds = 30,

        -- Hear visitors knock at doors or windows from about 50 tiles away. Break-ins sound when the first inside door opens. Off: text notices only.
        -- Default on.
        Safehouse_KnockSounds = true,

        -- Chance that an overnight guest refuses to leave in the morning until you talk them out.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Safehouse_SquatPercent = 15,

        -- Chance that a wounded visitor is secretly bitten. Bitten visitors refuse to be searched.
        -- Default 15. Min: 0 Max: 100 Default: 15
        Safehouse_BittenPercent = 15,

        -- Minimum time between a hostile group's threat letter, door mark, sabotage and eventual attack.
        -- Default 48. Min: 12 Max: 240 Default: 48
        Safehouse_LadderGapHours = 48,

        -- In SP/co-op, recognised bases block NPC spawning, shelter, loot and uninvited non-hostiles. Off: any slept-in or built-at place blocks spawns, as on dedicated servers.
        -- Default on.
        Safehouse_BaseFlag = true,

        -- Points needed to recognise a base, with at least two kinds of evidence. A night adds 20, a day there 10, a running generator 20 and a claim 30.
        -- Default 100. Min: 20 Max: 400 Default: 100
        Safehouse_BaseScore = 100,

        -- Chance of an event at an eligible house. Rare halves this chance; Often increases it by half.
        -- Default 12. Min: 1 Max: 100 Default: 12
        Safehouse_ChancePercent = 12,

        -- Time between event checks at the same house.
        -- Default 2. Min: 1.00 Max: 24.00 Default: 2.00
        Safehouse_CheckHours = 2.0,

        -- Minimum gap between events at one house. Rare doubles the gap; Often halves it, but never below one game day.
        -- Default 2. Min: 0.50 Max: 14.00 Default: 2.00
        Safehouse_GapDays = 2.0,

        -- Minimum gap between two visits to the same house.
        -- Default 1. Min: 1 Max: 30 Default: 1
        Safehouse_VisitGapDays = 1,

        -- Minimum gap between attacks on the same house.
        -- Default 1. Min: 1 Max: 60 Default: 1
        Safehouse_AttackGapDays = 1,

        -- World age before the first attack on a house is allowed.
        -- Default 14. Min: 0 Max: 365 Default: 14
        Safehouse_AttackMinDay = 14,

        -- Above this many zombies within 40 tiles of the front door, only armed groups visit.
        -- Default 10. Min: 0 Max: 200 Default: 10
        Safehouse_DensityMid = 10,

        -- Above this many zombies within 40 tiles of the front door, nobody visits and notes arrive half as often.
        -- Default 30. Min: 0 Max: 400 Default: 30
        Safehouse_DensityHigh = 30,

        -- Above this many zombies within 40 tiles of the front door, nothing is left at the house.
        -- Default 60. Min: 0 Max: 800 Default: 60
        Safehouse_DensityExtreme = 60,

        -- Notes and gifts can be left when every resident is at least this far from the delivery point and is not looking toward it.
        -- Default 40. Min: 10 Max: 60 Default: 40
        Safehouse_AwayTiles = 40,

        -- Notes and gifts can also be left when every resident is at least this far away, is not looking toward the delivery point and cannot see it.
        -- Default 20. Min: 5 Max: 60 Default: 20
        Safehouse_HiddenTiles = 20,

        -- How long a note waits for a safe delivery opportunity before it expires without being delivered.
        -- Default 3. Min: 1 Max: 14 Default: 3
        Safehouse_DropDeadlineDays = 3,

        -- Notes go into a mailbox within this distance of the front door. Without one, they are left on the porch.
        -- Default 10. Min: 2 Max: 20 Default: 10
        Safehouse_MailboxTiles = 10,

        -- A crew fights when its score reaches this value. Lower means bolder crews, higher means more cautious ones. Default 50. Min: 0 Max: 100 Default: 50
        Discretion_FightPercent = 50,

        -- A gun with fewer rounds than this (loaded plus reserve) counts as a melee weapon when a crew weighs a fight. Default 6. Min: 0 Max: 30 Default: 6
        Discretion_LowAmmoRounds = 6,

        -- A crew that keeps holding back because of the odds alone commits to the fight after this many seconds if you stay near. Crews short on ammunition or surrounded by zombies never commit this way. Default 45. Min: 10 Max: 600 Default: 45
        Discretion_PatienceSeconds = 45,

        -- Careful factions can calm down after provocation once their waiting time passes. Naturally hostile factions and grudges from real attacks do not fade this way.
        -- Default on.
        CalmDown_Enabled = true,

        -- Game hours until a provoked careful faction forgives. Default 2. Min: 0 Max: 24 Default: 2
        CalmDown_Hours = 2,

        -- With multiple players, outpost theft blames those inside the outpost rather than everyone. A manhunt keeps its named target instead of switching to the nearest player.
        -- Default on.
        Blame_Fair = true,

        -- NPCs break into a building only when raiding or looting, use an unlocked door first, try a window before smashing a door, and tell before entering a player's base. On by default.
        Breach_Policy = true,

        -- NPCs leave distant zombies alone unless they approach, threaten a friend or are near the NPC's post, helping the group stay on task.
        -- Default on.
        ZombieFocus_Enabled = true,

        -- Zombies inside this distance are always fought. Default 8. Min: 2 Max: 30 Default: 8
        ZombieFocus_Radius = 8,

        -- Travelling NPCs avoid zombie groups by skipping buildings, detouring, waiting or backing off. They still fight zombies that are close or coming at them.
        -- Default on.
        Caution_Enabled = true,

        -- How far ahead on their route NPCs watch for zombies. Default 12. Min: 4 Max: 30 Default: 12
        Caution_AvoidTiles = 12,

        -- Groups walk in a loose formation instead of one clump, never share a square when calm, and when they stop for a rest they move into a nearby house or shelter and idle there with different jobs: one sits in a corner, one keeps watch, two talk face to face, one comments, one stays quiet, others eat or smoke. Danger breaks it up at once. Off restores the old behaviour. On by default.
        GroupLife_Enabled = true,

        -- How wide a travelling group spreads out. 100 is the normal formation, 50 keeps them closer, 150 spreads them wider, 0 turns the formation off. Default 100. Min: 0 Max: 150 Default: 100
        GroupLife_Spread = 100,

        -- Typical length of a group rest, in game minutes. Each rest lasts between half and double of this value. Default 20, so 10 to 40. Min: 5 Max: 90 Default: 20
        GroupLife_ShelterIdleMinutes = 20,

        -- While a group rests, every member gets a role (lookout, sitter, talker, commenter, quiet, eater, smoker) with its own spot and pose. Off: they only spread out and stand. On by default.
        GroupLife_Roles = true,

        -- NPCs sometimes sneak (slow, crouched) while moving around town or scavenging. They stop sneaking when they see a player or a hostile NPC. Sneaking NPCs are harder for zombies to notice; the effect follows the zombie sight and hearing settings of the world. On by default.
        Stealth_Enabled = true,

        -- Share of the time a calm NPC or group moves sneaking. Higher near zombies. 0 never, 100 always. Default 30. Min: 0 Max: 100 Default: 30
        Stealth_Frequency = 30,

        -- How far zombies notice a sneaking NPC, as a share of the normal distance. Poor zombie sight or hearing makes sneaking stronger, eagle sight and pinpoint hearing weaker. Default 50. Min: 10 Max: 100 Default: 50
        Stealth_NoticePercent = 50,

        -- Groups scavenging away from players keep this share of each house's loot value. They stash it at a base or carry it if homeless. 0 disables this loot gain.
        -- Default 25. Min: 0 Max: 100 Default: 25
        Offline_LootPercent = 25,

        -- Lets you ask a friendly NPC group to take you in. The group keeps its own plans, offers jobs and warnings, and can leave you behind if you stay away.
        -- Default on.
        Party_Enabled = true,

        -- A group at this size refuses new members. NPCs and players both count toward the limit.
        -- Default 6. Min: 2 Max: 12 Default: 6
        Party_MaxSize = 6,

        -- Sets the leader's minimum opinion of you before you can join. Soldiers and raiders require more; gentler groups, such as families, require less.
        -- Default 20. Min: -50 Max: 80 Default: 20
        Party_MinOpinion = 20,

        -- Sets the minimum time between jobs offered by your group leader at calm stops. At 0, automatic offers stop; you can still ask for a job.
        -- Default 45. Min: 0 Max: 240 Default: 45
        Party_TaskFrequency = 45,

        -- Sets how long you can stay far from your NPC group before it leaves you behind and your membership ends.
        -- Default 10. Min: 2 Max: 60 Default: 10
        Party_AwayMinutes = 10,

        -- Allows settled groups near you to tell stories about their old lives. You can also ask for a story.
        -- Default on.
        Party_Stories = true,

        -- How often an NPC that could shoot a zombie does so. Gunfire draws more zombies, so lowering this makes NPCs walk around zombies, use melee on a lone one, and keep their guns for NPCs and players. They still shoot when cornered, hurt, defending a hurt player, on a horde that blocks the way, or on duty as military or police. 0 means never unless cornered. 100 is the old behaviour. While the world is under 14 days old the default 50 acts as 70, so early NPCs shoot more. Default 50. Min: 0 Max: 100 Default: 50
        Combat_GunsVsZombiesPercent = 15,

        -- An NPC holds fire when more than this many zombies are within 25 tiles, unless it is cornered, hurt or defending a hurt player. 0 turns the check off. Default 8. Min: 0 Max: 40 Default: 8
        Combat_GunNoiseZombies = 8,

        -- A group of at least this many zombies within 12 tiles that blocks an NPC's route may be shot at, if it is not too loud (see the noise limit). Default 5. Min: 2 Max: 30 Default: 5
        Combat_GunHordeSize = 5,

        -- Scales how far zombies and others hear NPC gunfire. At 50, a shot carries half as far. Players and NPCs hear the same reduced range. Lower it on busy servers where NPC shooting pulls hordes across the map. Default 100. Min: 10 Max: 100 Default: 100
        Combat_NpcShotNoisePercent = 100,

        -- Sets how many travelling groups each town receives when the world starts. The distant travelling group limit may allow extra groups in larger worlds.
        -- Default 3. Min: 1 Max: 4 Default: 3
        Population_SeedPerTown = 3,

        -- Prevents starting travelling groups from being placed this close to a player. Groups may still arrive later. At 0, this starting clearance is disabled.
        -- Default 150. Min: 0 Max: 400 Default: 150
        Population_SeedClearTiles = 150,

        -- Blocks new travelling groups when this many already live within 240 tiles. From day 4, the limit drops by one but never below one.
        -- Default 4. Min: 1 Max: 8 Default: 4
        Population_NeighbourGroups = 4,

        -- Beyond this distance (60-400 tiles), groups stop travelling, planning and using supplies. Members and loot stay; groups wake on approach without catching up missed time.
        -- Default 150. Min: 60 Max: 400 Default: 150
        Population_HibernateTiles = 150,

        -- Blocks new travelling groups in an area of about 120 tiles after NPC deaths. Heavy losses extend the delay. At 0, this delay is disabled.
        -- Default 3. Min: 0 Max: 60 Default: 3
        Population_RespawnCooldownDays = 3,

        -- After the death cooldown, limits a recovering area to one new group per interval. At 0, this additional recovery limit is disabled.
        -- Default 2. Min: 0 Max: 30 Default: 2
        Population_RegrowthDays = 2,

        -- Keeps spawning, waking and removal away from nearby or watching players. Also reduces rural encounters and prevents checkpoints near players or on dead-end roads.
        -- Default on.
        Spawn_FairnessEnabled = true,

        -- Minimum distance from players for random groups to appear, then walk in. Sight and loaded-map limits also apply; too large a distance can prevent spawns.
        -- Default 45. Min: 20 Max: 150 Default: 45
        Spawn_PlayerKeepOutTiles = 70,

        -- Lets welcome and starting-town groups appear nearby during a new character's first minutes. Other groups still obey the normal player clearance.
        -- Default 10. Min: 0 Max: 240 Default: 10
        Spawn_StartGraceMinutes = 10,

        -- Restores NPCs after map reloads, removes leftover zombie copies out of sight and clears zombies around returning groups. Blocked groups return farther away. Off removes this protection.
        -- Default on.
        Lifecycle_ReloadGuard = true,

        -- NPCs can become inactive or be removed only when they are at least this far from every player and out of sight.
        -- Default 60. Min: 0 Max: 200 Default: 60
        Spawn_DespawnMinTiles = 60,

        -- Sets open-countryside encounters relative to towns. At 50, the rate is half the town rate. Only suitable visitors, such as travellers and hunters, appear.
        -- Default 50. Min: 0 Max: 100 Default: 50
        Spawn_RuralDensityPercent = 50,

        -- Sets forest and wilderness encounters relative to towns. At 30, the rate is 30 percent of the town rate.
        -- Default 30. Min: 0 Max: 100 Default: 30
        Spawn_WildernessDensityPercent = 30,

        -- Sets farm and ranch encounters relative to towns. At 60, the rate is 60 percent of the town rate.
        -- Default 60. Min: 0 Max: 100 Default: 60
        Spawn_FarmDensityPercent = 60,

        -- Blockades and checkpoints are never built within this distance of a player, a player base or a place a player drove through in the last five minutes, and never on dead-end roads. Default 150. Min: 0 Max: 400 Default: 150
        Spawn_CheckpointMinTiles = 150,

        -- Adds floor splatter, bleeding drips and death pools, respecting the game's blood settings. Off: only the game's ordinary splatter and body stains remain.
        -- Default on.
        Blood_Enabled = true,

        -- Scales floor splatter, body stains, drips and pools from non-melee deaths. At 100, only the earlier body-stain behavior remains.
        -- Default 200. Min: 100 Max: 500 Default: 200
        Blood_Percent = 200,

        -- Size of the blood pool when an NPC is killed with a blade, bat or other melee weapon, and the blood on the attacker. Only used while the NPC blood amount is above 100%. Default 300%. Min: 100 Max: 800 Default: 300
        Blood_MeleeKillPercent = 300,

        -- Allows NPCs to react to world sounds and notice nearby players who run or shoot.
        -- Default on.
        Hearing_Enabled = true,

        -- Scales how far NPCs hear sounds. At 50, hearing distance is halved. Indoor player sounds and NPC gunshots use half the resulting range.
        -- Default 100. Min: 25 Max: 200 Default: 100
        Hearing_RadiusPercent = 100,

        -- Sets how much hearing distance remains when a wall blocks the sound's path. At 50, a blocked sound can be heard from half as far away.
        -- Default 50. Min: 0 Max: 100 Default: 50
        Hearing_WallPercent = 50,

        -- Reduces hearing distance for each floor between the NPC and sound. At 50, one floor leaves half the range; two floors leave one quarter.
        -- Default 50. Min: 0 Max: 100 Default: 50
        Hearing_FloorPercent = 50,

        -- Lets NPCs notice a running or recently shooting player behind them on the same floor. At 0, this rear detection is disabled.
        -- Default 8. Min: 0 Max: 12 Default: 8
        Hearing_PeripheralTiles = 8,

        -- Sets how long extra awareness from sounds and warnings lasts before the NPC returns to its normal awareness.
        -- Default 20. Min: 1 Max: 60 Default: 20
        Hearing_AlertSeconds = 20,

        -- Sets the minimum awareness after an NPC hears a sound. Confirmed contacts and final warnings still give full awareness.
        -- Default 70. Min: 0 Max: 100 Default: 70
        Hearing_AlertPercent = 70,

        -- Walking NPCs take short detours around nearby zombie crowds and fresh combat or loud noises. They wait or abandon an unsafe destination when no safe detour is found. Running and combat movement keep their existing rules.
        Caution_DangerRouting = true,

        -- Checks proposed movement legs for burning tiles, lit campfires and water. NPCs reject legs with known hazards. Applies to all movement paces.
        Caution_HazardCheck = true,

        -- Limits extra sight checks for danger detours across all NPCs. Groups wait when the limit is reached. At 0, these extra checks stop; normal perception is unaffected.
        -- Default 32. Min: 0 Max: 120 Default: 32
        Caution_DangerRaysPerSecond = 32,

        -- Shooters can advance to nearby cover and briefly step out to fire. Eligible squad gunners provide bounded covering fire. Turning this off cancels active maneuvers.
        Combat_FireManeuver = true,

        -- Maximum length of a forward cover leg. Default 4; range 2-6. Weapon distance and movement safety still apply. Min: 2 Max: 6 Default: 4
        Combat_ForwardCoverTiles = 4,

        -- Time at the firing point before returning to cover. Default 1200; range 600-2000. At most two shots; weapon cycles finish normally. Min: 600 Max: 2000 Default: 1200
        Combat_PeekWindowMs = 1200,

        -- Maximum covering fire time for one squad maneuver. Default 4000; range 2000-6000. Requires an eligible gunner and a clear friendly-safe line. Min: 2000 Max: 6000 Default: 4000
        Combat_PinWindowMs = 4000,

        -- Prefer nearby retreat destinations that hide the NPC from the threat. Existing retreat triggers, stamina and fallback destinations remain in use.
        Combat_RetreatLOS = true,

        -- Expose living Jeem residents as residents through the A-Life compatibility API when the Jeem extension is active. Needs an available actor registry. Does not replace the Companion Dogs patch. Applied at world startup; restart after changing this.
        Compat_JeemResidents = true,

        -- Enable the A-Life compatibility adapter when Point Blank is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_PointBlank = true,

        -- Enable the A-Life compatibility adapter when Wandering Zombies is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_WanderingZombies = true,

        -- Enable the A-Life compatibility adapter when Cye's Push Doors is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_CyesPushDoors = true,

        -- Enable the A-Life compatibility adapter when More Traits Definitive is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_MoreTraits = true,

        -- Enable the A-Life compatibility adapter when Project Exile is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_ProjectExile = true,

        -- Enable the A-Life compatibility adapter when Pixel Strike Indicator is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_PixelStrike = true,

        -- Enable the A-Life compatibility adapter when GaelGunStore-Firearms is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_GaelGunStore = true,

        -- Enable the A-Life compatibility adapter when Project RV Interior is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_RVInterior = true,

        -- Enable the A-Life compatibility adapter when Advanced Trajectory is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_AdvancedTrajectory = true,

        -- Enable the A-Life compatibility adapter when Auto All is active. Applied once at world startup; restart after changing this. Turning it off disables only this adapter, not the other mod.
        Compat_AutoAll = true,

        -- Let Cry of Fear monsters bite A-Life people when their own attack animation never starts, at the same pace as ordinary zombies. Applied once at world startup; restart after changing this. Does nothing without the monsters mod.
        Compat_CryOfFear = true,

        -- Mark A-Life people as already searched when they appear, so the vanilla zombie pocket loot is not rolled on their bodies. Off keeps the vanilla loot. Use it with mods that add loot to zombies.
        -- Default off.
        Compat_NoPocketLoot = false,

        -- Maximum work units per round. Higher values finish sooner but may increase server stalls. Multiplayer streaming pauses still apply.
        -- Default 100. Min: 1 Max: 2000 Default: 100
        Outposts_BuildBudget = 250,

        -- Limits new walled compounds. At 0, none are proposed. Existing sites, small camps, checkpoints and admin-built sites stay.
        -- Default 1. Min: 0 Max: 40 Default: 1
        Outposts_MaxCompounds = 1,

        -- Minimum distance between new walled compounds. Recently expired sites count until cleared. Small camps and fixed checkpoints are unchanged.
        -- Default 500. Min: 0 Max: 5000 Default: 500
        Outposts_CompoundSpacing = 500,

        -- Keeps campfires, lamps and generators in outposts, compounds, checkpoints and camps burning and switched on, refuelled while a player is near. Off leaves them as built.
        -- Default on.
        Outposts_LightsOn = true,

        -- Chance for each carried item to stay on an NPC's body. 100 drops all items; lower values drop fewer. Fixed NPC weapon drop chances take priority. Use wear below for poorer gear.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcDropPercent = 100,

        -- Wear added to gear and ammo on death. 0 adds no wear; 100 is full. Fixed NPC weapon conditions take priority. Guns can still drop broken: set Dropped weapon condition for working guns.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcWearPercent = 50,

        -- Multiplies the NPC loot percent for guns and melee weapons. Ignored while NPC weapon drop chance is a fixed choice. For example, 50 halves weapon drops.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcWeaponPercent = 100,

        -- Multiplies the NPC loot percent for worn armor and clothing, including rare armor. For example, 50 halves armor drops.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcArmorPercent = 100,

        -- Multiplies the NPC loot percent for dropped magazines and loose ammo. For example, 50 halves ammo drops.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcAmmoPercent = 100,

        -- Multiplies the NPC loot percent for food, medicine, tools and pocket items; identity cards always stay. For example, 50 halves supply drops.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Loot_NpcSuppliesPercent = 100,

        -- Door visits bring named individuals and small groups with their own history, needs and conversation. Off: visits work exactly as before.
        -- Default on.
        Visitors_Persons = true,

        -- How often a guest inside your home starts talking by themselves, for example asking about the TV. Rare waits longer, Often waits less. Off: guests only answer when you talk.
        -- Default Normal (3). Default = Normal
        -- 1 = Off
        -- 2 = Rare
        -- 3 = Normal
        -- 4 = Often
        Visitors_ProactiveEvents = 3,

        -- Real seconds that must pass after a guest speaks up before the same player is prompted again. Higher is calmer.
        -- Default 240. Min: 60 Max: 1800 Default: 240
        Visitors_EventMinGapSeconds = 240,

        -- A guest never stays inside longer than this. Most guests leave sooner. Raise it to let people ask to stay for a few nights; more time inside means more risk and more help.
        -- Default 1. Min: 1 Max: 48 Default: 1
        Visitors_StayHours = 1,

        -- Pairs and trios of related people can knock together instead of one stranger at a time. Off: one visitor per visit.
        -- Default on.
        Visitors_Parties = true,

        -- Once you have really helped someone, this chance decides whether a later visit is that person coming back. 0 means never.
        -- Default 15. Min: 0 Max: 50 Default: 15
        Visitors_ReturningChance = 15,

        -- Guests inside your home walk around, sit on furniture, read and look out of windows instead of standing where they were let in. Off: they stand still.
        -- Default on.
        Visitors_Life = true,

        -- Adult guests can ask for clean clothes and change in a closed room, down to the default body and never beyond. Off: no clothes changes.
        -- Default on.
        Visitors_ChangeClothes = true,

        -- Strict: a guest only changes in a room with the door shut, and not while you stand near the door. Normal: the door may be open.
        -- Default Strict (1). Default = Strict
        -- 1 = Strict
        -- 2 = Normal
        Visitors_Privacy = 1,

        -- Adult guests can show gentle, optional, non-explicit warmth after real trust and always accept a no. Off: no flirting at all.
        -- Default On (2). Default = On
        -- 1 = Off
        -- 2 = On
        Visitors_Flirt = 2,

        -- Guests can carry and read books and newspapers and discuss them with you. Off: no book conversations.
        -- Default on.
        Visitors_Books = true,

        -- Words spoken by guests also appear in the chat window, not only as speech bubbles. Needs the chat mirror of the talk interface.
        -- Default on.
        Visitors_ChatMirror = true,

        -- Adds extra visitor lines to the QA dump and the flight recorder to help find problems. Leave off for normal play.
        -- Default off.
        Visitors_Debug = false,

        -- Established outposts can send three existing squads together. Their people leave the site; this does not create extra survivors.
        -- Default on.
        Outposts_TrioEnabled = true,

        -- Game days between coordinated departures from each outpost. Set 0 to stop these departures.
        -- Default 5. Min: 0.00 Max: 120.00 Default: 5.00
        Outposts_TrioGapDays = 5.0,

        -- Maximum outposts with a coordinated group away at once. Set 0 to stop departures. The War Challenge raises this limit to 3.
        -- Default 2. Min: 0 Max: 8 Default: 2
        Outposts_TrioMaxActive = 2,

        -- An outpost must exist this many game days before sending three squads. At 0, a new site can qualify if it has enough people.
        -- Default 7. Min: 0.00 Max: 120.00 Default: 7.00
        Outposts_TrioMinAgeDays = 7.0,

        -- Automatic keeps these groups off on Light difficulty and on otherwise. Choose Off or On to override that rule in any world preset.
        -- Default Automatic: off on Light, on otherwise (1). Default = Automatic: off on Light, on otherwise
        -- 1 = Automatic: off on Light, on otherwise
        -- 2 = Off
        -- 3 = On
        Outposts_MegaEnabled = 1,

        -- Game days between large-group departures from each outpost. They use existing people and weaken the site while away. Set 0 to stop departures.
        -- Default 12. Min: 0.00 Max: 120.00 Default: 12.00
        Outposts_MegaGapDays = 12.0,

        -- People combined from an outpost and its existing squads. A site without enough people cannot send the group. Rendering remains spread across frames.
        -- Default 16. Min: 12 Max: 40 Default: 16
        Outposts_MegaSize = 16,

        -- Maximum large marching groups away at once, with one per faction. Set 0 to stop departures. The War Challenge raises the world limit to 2.
        -- Default 1. Min: 0 Max: 8 Default: 1
        Outposts_MegaMaxActive = 1,

        -- An outpost must exist this many game days before sending a large group. At 0, a new site can qualify if it has enough people.
        -- Default 10. Min: 0.00 Max: 120.00 Default: 10.00
        Outposts_MegaMinAgeDays = 10.0,

        -- Adds rare, tougher hostile factions after their earliest day. Their weapons and clothing use existing game items. Off keeps these new factions out.
        -- Default on.
        Late_FactionsEnabled = true,

        -- Earliest world day for the new raider and hazmat factions. Special forces have a separate earliest day. At 0, no minimum day applies.
        -- Default 14. Min: 0 Max: 3650 Default: 14
        Late_FactionStartDay = 14,

        -- Scales later weapon, ammunition and armour progression for new groups after day 13. The early worn-weapon curve stays unchanged. Set 0 to disable this progression.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Late_WeaponScalePercent = 100,

        -- Earliest world day for rare four-to-six-person special forces groups. At 0, no minimum day applies; late hostile factions must still be enabled.
        -- Default 21. Min: 0 Max: 3650 Default: 21
        Late_SpecialForcesStartDay = 21,

        -- Chance to react to a distant hit, close bullet crack or witnessed killing. People need a real cue, not knowledge of a hidden shooter. Set 0 to disable.
        -- Default 100. Min: 0 Max: 100 Default: 100
        Combat_SniperAwareness = 100,

        -- Shots from at least this many tiles can trigger distant-fire reactions. Scoped rifles can qualify closer; normal sight and ownership checks still apply.
        -- Default 40. Min: 10 Max: 200 Default: 40
        Combat_SniperAwarenessTiles = 40,

        -- Volume of human footsteps for nearby A-Life survivors on this computer. Set 0 to turn them off. Does not change noise heard by zombies.
        -- Default 100. Min: 0 Max: 200 Default: 100
        Audio_NpcFootsteps = 100,

        -- Military checkpoint crews are hostile by default and warn once before firing. Off restores their careful stance. Earned relations and combat safety still apply.
        -- Default on.
        Outposts_BridgeHostile = true,
    },
    ALifeDriving = {

        -- NPC driving, passenger crews and automatic multiplayer control handover. Driving debug controls require admin access.
        Enabled = true,

        -- By car spawns create functioning vehicles with seated NPC crews. They drive to a reachable nearby road and dismount. Requires loaded terrain.
        VehicleArrivals = true,
    },
    RadArchery = {

        -- Percent chance a Carved Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 25
        CarvedArrowRecovery = 25,

        -- Percent chance a Fine Carved Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 40
        FineCarvedArrowRecovery = 40,

        -- Percent chance a Stone-Tipped Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 50
        StoneTippedArrowRecovery = 50,

        -- Percent chance a Bone-Tipped Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 50
        BoneTippedArrowRecovery = 50,

        -- Percent chance a Tipped Carved Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 55
        TippedCarvedArrowRecovery = 55,

        -- Percent chance a Carbon Hunting Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 90
        HuntingArrowRecovery = 90,

        -- Percent chance a Bodkin Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 75
        BodkinArrowRecovery = 75,

        -- Percent chance a Broadhead Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 65
        BroadheadArrowRecovery = 65,

        -- Percent chance a Bodkin (MFD) Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 90
        BodkinArrowMFDRecovery = 90,

        -- Percent chance a Broadhead (MFD) Arrow survives hitting a zombie and lodges in the body, to be recovered by looting the corpse. Min: 0 Max: 100 Default: 85
        BroadheadArrowMFDRecovery = 85,

        -- Scales how much arm muscle strain drawing and holding a bow causes: a one-off cost when the draw starts, plus a drain for every second the aim is held. Heavier bows tire the arms faster, a compound bow's let-off makes it far easier to hold, and a higher Archery level tires them slower. Set to 0 to remove bow strain entirely. Applied on top of the game's own Muscle Strain Factor setting. Min: 0 Max: 1000 Default: 100
        BowStrainFactor = 100,

        -- Scales the spawn chance of every RadArchery item together -- bows, arrows, the Leather Quiver and Archery skill books -- on top of each category's own slider below. Set to 0 to remove all RadArchery loot. Min: 0 Max: 1000 Default: 100
        LootGeneral = 100,

        -- Scales how often compound bows spawn in containers, vehicles and zombie outfits, on top of the Overall RadArchery Loot slider above. The craft-only carved bows are unaffected -- they never spawn as loot. Min: 0 Max: 1000 Default: 100
        LootBows = 100,

        -- Scales how often loose Carbon Hunting Arrows and their packs and crates spawn, on top of the Overall RadArchery Loot slider above. Min: 0 Max: 1000 Default: 100
        LootArrows = 100,

        -- Scales how often the Leather Quiver spawns, on top of the Overall RadArchery Loot slider above. The quiver is also craftable regardless of this setting. Min: 0 Max: 1000 Default: 100
        LootQuiver = 100,

        -- Scales how often the Archery and Fletching skill books spawn, on top of the Overall RadArchery Loot slider above. Min: 0 Max: 1000 Default: 100
        LootBooks = 100,

        -- Percent chance an arrow shot into an Archery Target survives and stays stuck in it, to be pulled back out. The same for every arrow type. Min: 0 Max: 100 Default: 90
        TargetArrowRecovery = 90,

        -- Archery level at which shooting an Archery Target stops awarding Archery XP. Zombie hits are unaffected. Set to 0 for no cap. Min: 0 Max: 10 Default: 5
        TargetXpCapLevel = 5,
    },
    AviationCore = {

        -- Min: 0 Max: 50 Default: 5
        MaxWorldHelicopters = 50,
    },
    HydeCoBeavers = {

        -- Beavers build lodges on wild creeks, rivers, lakes and ponds across the county, never in town. A lodge starts small with two beavers and grows to medium and large with the wood that comes in, some floated down the water and some its beavers gnaw down and carry home, and the bigger it is the more beavers it has room for and lets out. Kits are born in spring into any room left. A lodge with a full store is content: its beavers rest, let you come closer and have bigger litters. A large lodge full of beavers sends a young pair off each spring to start a new lodge on other water. Beavers come out from dusk to dawn, fewer in winter, one at a time by day. A beaver that sees you swims off and dives. Beavers come back from the water with seaweed, stones, waterlogged wood or whatever the river carried down, anything from rope to someone's wallet, and the river snags things in a lodge's sticks that come out with its wood. Take the wood a lodge does not need from it, or break it up with an axe and its beavers flee and never come back. Pull at a lodge and its beavers come out and bite. A dead beaver gives meat, bones and a pelt.
        Beavers = true,

        -- How many beavers can be out around each player at the same time (6 by default); a bigger lodge lets out more. Lower it to see fewer, raise it for more. 0 stops new beavers coming out. Min: 0 Max: 12 Default: 6
        BeaversNearPlayer = 12,

        -- Hit a beaver and it turns on you for a while. Take wood from a lodge or chop at it and its beavers come out after you. They bite at your feet and shins; boots and trousers can stop a bite, and a bite never infects. Off, a hit beaver runs for the water and a lodge lets you take its wood.
        BeaversDefendLodge = true,

        -- Cattails grow on the shallows round every lodge. Cut a clump for cattails: peel the shoots to eat, pull the fluff for tinder and pillow stuffing. A cut clump grows back in a few weeks. Beavers graze them. Off, none grow.
        BeaverCattails = true,

        -- Off by default. On, about one lodge in six is rotten: nothing living comes out of it, a few zombie beavers climb out onto its bank at night and bite anyone who comes close, a dead beaver left lying can get back up as one, and pulling at a rotten lodge or chopping at it brings the whole nest out after you. By day they go back in.
        ZombieBeavers = false,

        -- Off by default: a zombie beaver's bite hurts and never carries the Knox infection. On, a scratch or laceration from one can infect you at the game's own odds.
        ZombieBiteInfects = false,

        -- Removing this mod from a game where a beaver was out at the last save loses the other animals saved around it, your own included. In single player, save once with this version (sleep, or quit) and it should be safe to remove. On a server, turn this on first: no beavers or zombie beavers come out and any that are out go home; let the server save, then remove the mod.
        PrepareToRemove = false,
    },
    HydeCoFrogs = {

        -- Green and brown frogs live by lily pads on ponds, creeks and rivers. Near water there is always at least one frog on the bank. More frogs come out from spring to autumn, in the evening, at night and in the rain. A frog that sees you leaps into the water and sinks. Sneaking lets you get closer. Frogs can be picked up, and a dead frog gives a whole frog.
        Frogs = true,

        -- How many frogs can be out around each player at the same time (4 by default). Lower it to see fewer, raise it for more. 0 stops new frogs coming out. Min: 0 Max: 12 Default: 4
        FrogsNearPlayer = 12,

        -- Removing this mod from a game where a frog was out at the last save loses the other animals saved around it, your own included. In single player, save once with this version (sleep, or quit), after letting go of any you carry and it should be safe to remove. On a server, turn this on first: no frogs come out and any that are out go home; let the server save, then remove the mod.
        PrepareToRemove = false,
    },
    HydeCoRobins = {

        -- American robins live in nest trees and hop and peck on the grass nearby. In daylight there are always two robins near nest trees, more from March to October and fewer in the rain. Nest trees drop robin feathers, and sometimes a bird's nest or robin eggs. A robin that sees you flies into a nest tree. Sneaking lets you get closer. A stick trap catches robins alive, and a dead robin gives small-bird meat and feathers.
        Robins = true,

        -- How many robins can be out around each player at the same time (6 by default). Lower it to see fewer, raise it for more. 0 stops new robins coming out. Min: 0 Max: 12 Default: 6
        RobinsNearPlayer = 12,

        -- Removing this mod from a game where a robin was out at the last save loses the other animals saved around it, your own included. In single player, save once with this version (sleep, or quit), after letting go of any you carry and it should be safe to remove. On a server, turn this on first: no robins come out and any that are out go home; let the server save, then remove the mod.
        PrepareToRemove = false,
    },
    HydeCoUnderGround = {

        -- The sewer under every town: its manholes, side rooms and crawl tunnels, the sewer view on the map and the sewer works map. Off: every manhole is plain street. Decided when the world is made: a world already started keeps the underground it was made with.
        Sewers = true,

        -- The eight caves under the old dry wells, the well ropes and the cave survey map. Off: the wells are ordinary wishing wells. Decided when the world is made: a world already started keeps the underground it was made with.
        Caves = true,

        -- The 22 mines under their shaft entrances and the mine survey map. Digging your own tunnels works either way. Decided when the world is made: a world already started keeps the underground it was made with.
        Mines = true,

        -- An opened manhole lets the sun down into the room below it. The shaft brightens and fades with the time of day and dims under heavy weather. Turn this off to keep the sun out of the sewer; its own lamps are not affected.
        DaylightShafts = true,

        -- How far the light spreads from directly under an open manhole at midday. 6 = current, enough to light the landing and a little of the walkway. Lower it for a narrow beam, raise it to light most of a chamber. Min: 1 Max: 12 Default: 6
        DaylightRadius = 6,

        -- How green and murky the sewer air reads. It tints the view and drains some of its colour while you are in the sewer, and lifts the moment you climb out. 0 leaves the sewer its own colour. Min: 0.00 Max: 1.00 Default: 0.50
        GreenMurk = 0.5,

        -- How bright the sewer reads. 1 is its lamps at full strength; lower darkens the whole view evenly while you are in the sewer, torches included. Min: 0.00 Max: 1.00 Default: 0.60
        UnderAmbient = 0.6,

        -- Hours a body in the sewer takes to grow one stage further, from clean through to fully fruiting. 0 freezes every zombie where it is. Min: 0.00 Max: 720.00 Default: 36.00
        SporeGrowthHours = 36.0,

        -- How badly the spores affect you underground. It builds near fruiting bodies, a mask cuts most of it, and it clears once you are back in clean air. 0 turns it off. Min: 0.00 Max: 4.00 Default: 1.00
        SporeSickness = 1.0,

        -- How many of the sewer's dead have mushrooms growing out of them. 0 turns the bloom off entirely. Min: 0.00 Max: 1.00 Default: 0.35
        FungalChance = 0.35,

        -- How many zombies are sealed into the sewer's side rooms. 0 leaves them empty; 1 is one to three per room. Min: 0.00 Max: 4.00 Default: 1.00
        RoomZombies = 1.0,

        -- The most live rats anywhere at once, across every sewer you have opened. 20 = current, 40 = maximum. They come out of holes in the walls, only below ground and never in view, and go back when you walk away; 0 turns them off. Min: 0 Max: 40 Default: 28
        RatCount = 28,

        -- Whether dynamite or TNT set below ground opens the rock around it. Off, the charges still bang, hurt and burn like any other bomb, and leave the rock standing.
        BlastingEnabled = true,

        -- How many squares of rock one dynamite stick opens. 8 = the eight squares around it. Bigger charges scale from this, but less than in proportion: at 8 a TNT crate opens about 34 and a TNT barrel about 64. Min: 2 Max: 16 Default: 8
        SquaresPerStick = 8,

        -- The most rock any single charge can open, however big it is. 64 = a small room. Raise it if you want a TNT barrel to open a chamber. Min: 8 Max: 128 Default: 64
        BlastCap = 64,

        -- The share of blasted squares that leave their stone, ore or coal on the floor. 1 = every square, as if it had been dug by hand; 0 = the blast leaves nothing to pick up. Min: 0.00 Max: 1.00 Default: 0.50
        BlastSpoil = 0.5,

        -- The chance, per coal square a blast opens, that the coal catches fire. 0 means blasting a seam never lights it. Min: 0 Max: 100 Default: 25
        CoalDustChance = 25,

        -- How fast cracks, vines and weeds take hold in the sewer, on top of the game's own Erosion Speed setting. 1 keeps pace with the world above; 0 leaves the tunnels exactly as they were built. Min: 0.00 Max: 10.00 Default: 1.00
        DecaySpeed = 1.0,

        -- Deep dug tunnels with no shaft near, and the far ends of a cave, have stale air that slowly wears you down; a blast or a burning coal seam fouls the air for hours and makes you sick unless you wear a mask or breathing gear. A canary warns you first. Turn this off and the air below ground is always fresh.
        AirQuality = true,

        -- Caves keep one temperature all year round, and the sewer runs a few degrees warmer. Single player only: on a server the weather above sets the temperature below ground. Min: 0.00 Max: 25.00 Default: 12.00
        UndergroundTemperature = 12.0,

        -- How long a bucket of guano soak steeps before it turns to nitre liquor, ready to boil down for saltpeter. Game hours. Min: 1.00 Max: 720.00 Default: 48.00
        SaltpeterSoakHours = 48.0,

        -- How long a sown mushroom tray takes to fruit while it is kept below ground. Game hours. Bringing a tray up into daylight kills the spawn and the clock starts over. Min: 1.00 Max: 720.00 Default: 72.00
        MushroomGrowHours = 72.0,

        -- Off: the mod's fifteen mushrooms are found only below ground. On: they also turn up when foraging above ground, wherever and whenever the game's own wild mushrooms do. Takes effect when the world loads.
        SurfaceMushrooms = false,

        -- How fast an oxygen tank and a mask filter are used up, against the game's own rate. 1.0 leaves them exactly as the base game spends them; 0 makes them last for ever; 4 empties them four times as fast. Below ground a running tank also uses Oxygen tank drain below ground. Min: 0.00 Max: 4.00 Default: 1.00
        BreathingDrain = 1.0,

        -- How fast a switched-on oxygen tank empties while you are below ground, on top of the breathing gear drain rate. The base game empties a full tank in about five and a half minutes at normal speed, in fresh air or foul; 0.25 makes one last about 22 minutes down here, and 1.0 is the base game's rate. Tanks on the surface are left alone. Min: 0.00 Max: 4.00 Default: 0.25
        TankDrainBelowGround = 0.25,

        -- How likely a square caught in a blast is set alight, at the centre of it, falling off toward the edge. 0 stops a charge starting fires; anything above about 50 will burn out a furnished cellar. Min: 0.00 Max: 100.00 Default: 35.00
        BlastFire = 35.0,

        -- Off: the sewer map fills in as you walk the tunnels. On: every tunnel under every town is on the map from the start.
        SewerMapRevealAll = false,

        -- Off: caves and mines go on the map as you find them, or when you read a survey map. On: every cave and mine, every level, is on the map from the start.
        CaveMineMapRevealAll = false,

        -- On: a manhole cover is pried up with a crowbar. Off: it can be lifted by hand.
        ManholeCrowbar = true,

        -- Off: the Miner is not offered at character creation. A character who already has it keeps it.
        MinerProfession = true,

        -- Off: the two traits are not offered at character creation. A character who already has one keeps it.
        UndergroundTraits = true,

        -- A character saved with a trait from a removed mod will not load. Turn this on, load every character once and save: this mod's traits and the Miner profession come off each character as it loads. Then the mod can be removed from a single-player game. A multiplayer world that has ever run this mod must keep it: the game will not let players join a server it was removed from.
        PrepareToRemove = false,

        -- Servers only. Turn this on to add the mod to a server world that was started without it: back up the server, turn this on, delete map_basements.bin from the server's save folder, and restart. House basements stay as they were, and the sewers and caves appear wherever nobody has been yet. Players who joined before must delete their own copy of map_basements.bin for this server once; the game tells them where. Leave it off on a server that started with the mod. Single player works this out by itself.
        AddedToExistingWorld = false,

        -- Only matters when SMB Steps is on. The game's own ladders are then climbed SMB Steps' way, and this mod's manhole, catwalk and well ladders and wall ropes stay this mod's. Off: this mod climbs the game's ladders too, and both mods offer to climb them.
        SMBStepsLadders = true,

        -- The Strength level a character needs to throw a grappling hook up a wall. Climbing a rope already hung needs none; Strength and Fitness set how fast anyone climbs. Min: 0 Max: 10 Default: 5
        RopeClimbStrength = 5,

        -- Off: throw a grappling hook and climb, no falls. On: you also need a carabiner, and the game's own rope fall check runs, so a tired, heavily loaded or hurt climber can fall.
        RealisticClimbing = false,

        -- What drinking straight from the sewer channel does. Tainted: the game's own tainted water, a little poison, boil it clean. Deadly at once: light poison, food sickness and sickness the moment you drink. Deadly over hours: the same three, building over four hours. Water carried out in a bottle is tainted either way and boils clean. Default = Tainted (boil it)
        -- 1 = Tainted (boil it)
        -- 2 = Deadly, at once
        -- 3 = Deadly, over hours
        SewerWater = 1,

        -- Who can sink a shaft or dig stairs down from the surface. Admins only matters on servers; single player digs as normal. Digging stairs up out of a cave, a sewer or a mine is always allowed, so nobody is ever shut in below ground. Default = Anyone
        -- 1 = Anyone
        -- 2 = Admins only
        -- 3 = Nobody
        StreetMines = 1,
    },
    HydeCoSquirrels = {

        -- Squirrels live in some of the grown trees. In daylight they come down to forage, run back up when spooked, and go home at dusk. Felling a den tree turns out whoever is inside.
        SquirrelDens = true,

        -- About one grown tree in this many is a den. Oaks are dens twice as often, small ornamental trees half as often. Lower means more squirrels. Min: 2 Max: 40 Default: 8
        DenTreeOdds = 16,

        -- How many den squirrels can be out foraging around each player at the same time (4 by default). Lower it to see fewer, raise it for more. 0 keeps them all in their dens. Min: 0 Max: 12 Default: 4
        SquirrelsNearPlayer = 12,

        -- The chance a squirrel inside a felled den tree lands stunned for a few seconds, long enough to grab it. The rest bolt for another den. Min: 0 Max: 100 Default: 33
        StunChance = 33,

        -- Some den trees are rotten. At night a few zombie squirrels come out of them and chase anyone who comes close, scratching at the feet and shins; boots and trousers help. A dead squirrel left lying can get back up. Chop a rotten den down and the whole nest comes out after you.
        ZombieSquirrels = false,

        -- When on, a zombie squirrel's scratch can carry the zombie infection, like any scratch from a zombie. Off by default: in the game's own lore, animals do not carry it.
        ZombieScratchInfects = false,

        -- Removing this mod from a game where a squirrel was out at the last save loses the other animals saved around it, your own included. In single player, save once with this version (sleep, or quit), after letting go of any you carry and it should be safe to remove. On a server, turn this on first: no squirrels or zombie squirrels come out and any that are out go home; let the server save, then remove the mod.
        PrepareToRemove = false,
    },
    HydeCoBees = {

        -- How fast a working hive fills its comb and grows. 1.0 = current pacing, 2.0 = twice as fast, 0.5 = half speed. Weather, temperature, flowers and feeding still apply on top. Min: 0.25 Max: 5.00 Default: 1.00
        HiveProductionSpeedMultiplier = 1.0,

        -- How many days a queen lays before she needs replacing. 7 = current. Longer games may want 14-30. Applies to queens inserted or raised after the change. Min: 1.00 Max: 60.00 Default: 7.00
        QueenLifespanDays = 7.0,

        -- Scales how many filled combs each production cycle adds. 1.0 = current (2-4), 2.0 = double. The hive still holds no more than its cells. Min: 0.25 Max: 4.00 Default: 1.00
        HoneycombYieldMultiplier = 1.0,

        -- Scales how many bees and larvae each production cycle adds. 1.0 = current, 2.0 = double. Kept separate from honeycomb so honey and colony can be tuned apart. Min: 0.25 Max: 4.00 Default: 1.00
        ColonyGrowthMultiplier = 1.0,

        -- How long a full, queenless hive takes to make royal jelly. 72 = current (three days). Min: 12.00 Max: 240.00 Default: 72.00
        RoyalJellyHours = 72.0,

        -- How long placed queen larvae take to become a new queen. 48 = current (two days). Min: 12.00 Max: 168.00 Default: 48.00
        QueenLarvaeRaiseHours = 48.0,

        -- Chance a harvest that collects honeycomb also yields propolis. 0.30 = current (30%), 0 = never, 1.0 = always. Min: 0.00 Max: 1.00 Default: 0.30
        PropolisChance = 0.3,

        -- At or below this temperature the bees hibernate and the hive stops. 7 = current. Lower it for hardier bees, raise it for a shorter season. Min: -10.00 Max: 15.00 Default: 7.00
        HibernationTemperatureC = 7.0,

        -- A jar of sugar water or honey left on the ground away from any hive turns into a Wild Yeast Starter after this many hours. 48 = current (two days). 0 = never. Jars within reach of a hive are drunk by the bees instead and never sour. Min: 0.00 Max: 720.00 Default: 48.00
        JarSourHours = 48.0,

        -- When off, angry bees are still shown but never sting - no health damage, poison or swelling. For relaxed servers.
        BeeStingsEnabled = true,

        -- Scales how often Queen Bees appear while foraging, in every zone. 1.0 = default scarcity (roughly one queen per 2-5 in-game hours of daytime foraging in forest zones, in season Apr-Oct, none Dec-Mar). 2.0 = about twice as common. 0 = queens never appear from foraging. Min: 0.00 Max: 10.00 Default: 1.00
        QueenForageWeightMultiplier = 1.0,

        -- Scales how fast mead barrels ferment through Young, Normal, Aged (and Spoiled). 1.0 = current pacing, 2.0 = twice as fast, 0.5 = half speed. Applies to batches already fermenting. Min: 0.25 Max: 20.00 Default: 1.00
        MeadFermentationSpeedMultiplier = 1.0,

        -- When disabled, a batch left too long holds at Aged quality forever instead of turning Spoiled.
        MeadSpoilageEnabled = true,

        -- Scales how long bees stay angry after you disturb or crack open hives and nests. 1.0 = current, 0 = they calm down almost immediately, 2.0 = twice as long. Min: 0.00 Max: 10.00 Default: 1.00
        AngryBeesDurationMultiplier = 1.0,

        -- Scales how long a bee smoker keeps a hive calm. 1.0 = current, 2.0 = smoke lasts twice as long. Min: 0.25 Max: 10.00 Default: 1.00
        SmokeDurationMultiplier = 1.0,

        -- How many working hours one litre of stored sugar water buys. 24 = a full day of work per litre. The bees only drink while they are actually working, so a hive halted by rain or frost loses nothing from its supply. A hive holding any sugar water forages as if there were an ordinary spread of flowers around it - enough to keep working through winter or a poor biome, but no better than a decent summer. Min: 1.00 Max: 72.00 Default: 24.00
        HiveFeedHoursPerLitre = 24.0,

        -- Extra production while a hive is fed, on top of the forage the sugar water stands in for. 1.15 = 15% faster, 1.0 = no bonus at all (the forage rescue still applies). Rain, snow and freezing still stop the hive no matter how well fed it is. Min: 1.00 Max: 3.00 Default: 1.15
        HiveFeedBoostMultiplier = 1.15,
    },
    ProjectCook = {

        -- Allows Project Cook to use frozen food in Base Cooking and Cooking By Recipes even when the base-game recipe requires thawed ingredients. Disabled by default. Only affects Project Cook.
        AllowFrozenCooking = false,
    },
    ViewpointThrowables = {

        -- Physical throws aimed with Viewpoint's camera. Off: vanilla throwing (still aimed through Viewpoint's crosshair instead of at your feet).
        Enabled = true,

        -- Scales every throw speed. Min: 0.25 Max: 3.00 Default: 1.00
        StrengthMultiplier = 1.0,

        -- Speed of a quick tap. Min: 0.50 Max: 20.00 Default: 5.00
        MinThrowSpeed = 5.0,

        -- Speed of a fully charged overhand throw of a 1 kg object. 16 m/s reaches about 25 m on flat ground. Min: 2.00 Max: 40.00 Default: 16.00
        MaxThrowSpeed = 16.0,

        -- How long the throw input must be held for a full-strength throw. Min: 0.10 Max: 6.00 Default: 1.10
        ChargeTime = 1.1,

        EnableUnderhand = true,

        EnableRolling = true,

        -- Share of the thrower's own velocity added to the throw. Min: 0.00 Max: 1.50 Default: 0.60
        MomentumInfluence = 0.6,

        -- Damage scales with mass x impact speed and is deliberately conservative.
        ImpactDamage = true,

        -- Min: 0.00 Max: 5.00 Default: 1.00
        ImpactDamageMultiplier = 1.0,

        -- Also needs PVP enabled on the server; safety mode is respected.
        PlayerImpactDamage = true,

        -- Impacts make a world sound zombies investigate (vanilla sound system).
        ZombieDistraction = true,

        -- Min: 0.00 Max: 4.00 Default: 1.00
        DistractionMultiplier = 1.0,

        -- Bottles, cans, rocks, tools and other small objects can be thrown.
        ObjectThrowing = true,

        -- Min: 0.10 Max: 10.00 Default: 3.00
        MaxObjectWeight = 3.0,

        -- Bounciness of explosives, smoke and noise makers. Min: 0.00 Max: 2.00 Default: 1.00
        GrenadeBounceMultiplier = 1.0,

        -- Bounciness of ordinary objects. Min: 0.00 Max: 2.00 Default: 1.00
        ObjectBounceMultiplier = 1.0,

        -- A fast object smashes a closed, intact, unbarricaded window.
        WindowBreaking = true,

        -- The server checks item ownership, release point, speed, rate and fuse of every throw.
        ServerValidation = true,

        -- The most a player may choose in their own settings. Default = Full
        -- 1 = Off
        -- 2 = Simple
        -- 3 = Full
        MaxPreview = 3,

        -- Only items registered as cookable; vanilla throwables are not.
        AllowCooking = true,

        -- Min: 1 Max: 50 Default: 6
        MaxActivePerPlayer = 6,

        -- Min: 0.00 Max: 3.00 Default: 0.35
        ThrowCooldown = 0.35,

        -- Min: 0.20 Max: 3.00 Default: 1.00
        GravityMultiplier = 1.0,

        -- Verbose [ViewpointThrow] log lines (classification, collisions, corrections).
        DebugLogging = false,

        -- Lets every player use the debug drawing option, not just admins.
        AllowDebugDraw = false,

        -- A flashbang whites out the screen of every player who sees it go off: more when closer and looking at it, less around a corner.
        FlashbangBlinds = true,

        -- Beyond this distance a flashbang does not blind. Min: 4.00 Max: 40.00 Default: 16.00
        FlashbangRange = 16.0,

        -- How fast molotov and incendiary fire burns zombies to death (1 = a few seconds in the flames). 0 leaves it to the game's own fire, which rarely kills. Min: 0.00 Max: 5.00 Default: 1.00
        FireDamageMultiplier = 1.0,

        -- How fast 40 mm grenades leave a launcher (M79, M203). 32 gives a visible lob that reaches about 100 m at the highest arc. A real M79 is about 76, which is very fast and very far for Project Zomboid. Min: 10.00 Max: 90.00 Default: 32.00
        LauncherSpeed = 32.0,
    },
    VTB = {

        -- Firearms fire simulated projectiles (travel time, drop, walls) instead of vanilla's instant hits while Viewpoint first/third person aiming is active.
        Enabled = true,

        -- Also use projectiles when Viewpoint is off, aimed along vanilla's aim direction. Off = vanilla firearm combat in the isometric view.
        UseInIsoView = false,

        -- Multiplies every muzzle velocity. Real velocities (1.0) make drop almost invisible at Project Zomboid distances; 0.4 gives noticeable travel time and drop at long range. Min: 0.05 Max: 3.00 Default: 0.40
        VelocityScale = 0.4,

        -- Multiplies 9.81 m/s2 gravity acting on rounds in flight. Min: 0.00 Max: 10.00 Default: 1.00
        GravityScale = 1.0,

        -- Multiplies air drag. Higher values make rounds lose speed (and damage) faster. Min: 0.00 Max: 10.00 Default: 1.00
        DragScale = 1.0,

        -- How much remaining energy matters: 0 = full vanilla damage at any range, 1 = damage scales with kinetic energy left. Min: 0.00 Max: 1.00 Default: 0.50
        DamageFalloff = 0.5,

        -- Rounds are removed after this many seconds of flight. Min: 0.20 Max: 20.00 Default: 3.00
        ProjectileLifetime = 3.0,

        -- Rounds fly up to the weapon's MaxRange times this. In multiplayer this needs the True Ballistics jar on the server, otherwise hits stay inside vanilla range. Min: 1.00 Max: 20.00 Default: 3.00
        MaxDistanceMultiplier = 3.0,

        -- Absolute limit for any round, in metres (tiles). Min: 10.00 Max: 1000.00 Default: 200.00
        MaxDistanceCap = 200.0,

        -- Distance at which rounds cross the reticle again. 0 = the bore points straight at the reticle, so rounds always land a little low. Scope mods can override this per sight. Min: 0.00 Max: 1000.00 Default: 0.00
        ZeroDistance = 0.0,

        -- Multiplies the dispersion that comes from weapon accuracy, Aiming skill, movement, moodles and weapon condition. Min: 0.00 Max: 10.00 Default: 1.00
        SpreadScale = 1.0,

        -- Rifle rounds with enough energy can pass through a body and hit what is behind it.
        Penetration = true,

        -- The body part the round physically hit is used for vanilla's head/torso/limb damage, and a shot player is wounded on exactly that part (hands and feet included). Off = vanilla's random body part.
        HitLocations = true,

        -- Solid furniture and counters stop rounds (tall solid objects up to 1.9 m, counters/tables up to 0.9 m).
        FurnitureCollision = true,

        -- Multiplayer: the server rejects firearm hits that had no line of fire or impossible damage. Needs the True Ballistics jar on the server.
        ServerValidation = true,
    },
    CasualtiesUndead = {

        -- Treat wounds by playing a short minigame instead of watching a progress bar. How well it is played decides how well the treatment works. Off: every treatment is the normal progress bar. The options below turn single minigames off.
        Minigames = true,

        -- Play the minigame when wrapping a bandage round a wound. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameBandage = true,

        -- Play the minigame when folding a ripped sheet, denim or leather strip into a pad and tying it over a wound. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameRag = true,

        -- Play the minigame when sticking an adhesive bandage over a cut. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameAdhesive = true,

        -- Play the minigame when cleaning a wound with disinfectant or alcohol (alcohol wipes never have one). Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameDisinfect = true,

        -- Play the minigame when stitching a deep wound. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameSuture = true,

        -- Play the minigame when pulling out glass shards. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameGlass = true,

        -- Play the minigame when extracting a lodged bullet. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameBullet = true,

        -- Play the minigame when setting and splinting a fracture. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameSplint = true,

        -- Play the minigame when swallowing pills or giving an injection. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameMedicine = true,

        -- Play the minigame when sawing off a limb. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameAmputation = true,

        -- Play the minigame when searing a stump shut with a hot blade. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameCauterize = true,

        -- Play the minigame when shocking a stopped heart. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameDefib = true,

        -- Play the minigame when carrying out a procedure from the problem list (strapping ribs, draining a chest, clearing an airway, running saline, opening a compartment and the rest). Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameProcedures = true,

        -- Play the minigame when taking a dressing, stitches or a splint off. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameRemovals = true,

        -- Play the minigame when putting on a comfrey, wild garlic or plantain poultice. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigamePoultice = true,

        -- Play the minigame when cooling, cleaning and covering a burn. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameBurnCare = true,

        -- Play the minigame when putting a tourniquet on or taking it off. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameTourniquet = true,

        -- Play the minigame when fitting a prosthetic limb or taking it off. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameProsthetic = true,

        -- Play the minigame when opening a corpse to learn from it. Off: it is the normal progress bar, with an average result for the character's First Aid level.
        MinigameDissection = true,

        -- Scales every minigame's tolerances and time limits. 0.5 is much easier, 2.0 much harder. Min: 0.25 Max: 3.00 Default: 1.00
        MinigameDifficulty = 0.8,

        -- How much each First Aid level loosens a minigame's tolerances. 0 means First Aid does not change the minigames at all. Min: 0.00 Max: 3.00 Default: 1.00
        SkillScaling = 1.0,

        -- How far a badly played minigame can pull a treatment down, as a fraction of the character's real First Aid level. 0.25 means the worst result counts as a quarter of their skill; 1.0 means a bad result works as well as a perfect one. Min: 0.00 Max: 1.00 Default: 0.25
        QualityFloor = 0.25,

        -- Drops the game to 1x speed while a minigame is open, and restores the old speed after.
        ForceNormalSpeed = true,

        -- The first time a character plays each minigame, a card explains how. H brings it back during any minigame.
        HowToCards = true,

        -- Pills spilled on the floor, disinfectant poured and dressing unrolled onto a wound are lost when a minigame fails or is abandoned.
        FailedTreatmentWastes = true,

        -- Every minigame adds pain to the treated body part as it goes, so the pain moodle climbs while the patient is being worked on, and every slip hurts more. The pain the base game adds at the end is not added twice. Off: only the base game's pain, at the end.
        ProcedurePain = true,

        -- Scales the pain a treatment causes as it is done. First Aid already takes up to half of it away. Min: 0.00 Max: 3.00 Default: 1.00
        ProcedurePainScale = 1.0,

        -- When the patient is in a lot of pain, a minigame pulses red and they wince, and a patient being disinfected can flinch away.
        ProcedurePainEffects = true,

        -- A treatment can go wrong and still get done: a dressing too loose to stay clean, dirt stitched into a wound, a bone set crooked, a fragment left in, a torn wound, a tourniquet on too tight. Each treatment has its own. Off: a bad result only costs quality and pain.
        BotchInjuries = true,

        -- The chance a treatment by somebody with no First Aid has a complication. Every First Aid level takes about a tenth of it away (level 10 is a twelfth of it); a well-played minigame halves it and a sloppy one makes it up to twice as likely. With no minigame it is the First Aid chance alone. 0: only failed minigames have complications. Min: 0.00 Max: 1.00 Default: 0.25
        BotchChance = 0.25,

        -- Failing a minigame no longer throws the treatment away: it is done anyway, badly, and always with a complication. A defibrillator shock that never landed still does nothing. Off: failing a minigame cancels the treatment, as before.
        FailedMinigameStillTreats = true,

        -- Scales the extra pain a botched minigame causes. 0 means no extra pain. Min: 0.00 Max: 5.00 Default: 1.00
        BotchPainMultiplier = 1.0,

        -- Right-click a corpse with a scalpel or a knife to open it and learn from it: First Aid experience, and the medical terms for what is inside. Each body can be opened once.
        Dissection = true,

        -- Scales the First Aid experience a dissection gives (25 to 70 by how well it went). Min: 0.00 Max: 5.00 Default: 1.00
        DissectionXP = 1.0,

        -- When a dissection goes wrong the blade opens the dissector's own hand. On a zombie's body, without gloves, this is the chance that cut carries the Knox infection. 0: never. Min: 0.00 Max: 1.00 Default: 0.10
        DissectionInfectionChance = 0.1,

        -- A character only knows the names of some conditions. The rest show as what they look like ("Can't get air in") and the to-do list keeps how to fix them to itself until the term is learned: from First Aid levels, First Aid books, medical journals or dissection. Doctors and nurses know all of them. Off: everybody knows everything.
        MedicalTerms = true,

        -- The share of medical terms a new character already knows, chosen at random. Each First Aid level they start with adds 7 percent. Min: 0.00 Max: 1.00 Default: 0.30
        StartingTermsKnown = 0.3,

        -- How many new medical terms a character learns every time their First Aid goes up. Min: 0 Max: 10 Default: 2
        TermsPerLevel = 2,

        -- How often medical journals turn up in bookshops, libraries, medical offices and hospitals. 0 removes them. Min: 0.00 Max: 10.00 Default: 1.00
        JournalLootChance = 1.0,

        -- Antibiotics use the syringe minigame. Off: they are swallowed, with the pill minigame.
        AntibioticsAsInjection = true,

        -- A clean treatment by a practised medic works as if their First Aid were higher: the dressing lasts longer, it hurts less and infection is less likely. Mistakes cost them less, and wounds they dressed heal faster.
        FirstAidRewards = true,

        -- Scales the extra healing a dressed wound gets when the medic has First Aid above 3. 0 turns it off. Min: 0.00 Max: 5.00 Default: 1.00
        FirstAidHealRate = 1.0,

        -- Each bandage has a Remaining amount (shown in its tooltip). The dressing minigame uses only as much as is wrapped, and the rest stays in the inventory. Off: a bandage is always used up whole.
        DressingRolls = true,

        -- How many turns round a limb a dressing needs to stay clean for its full time. At 1.0 a First Aid 0 character needs 5 turns and a First Aid 10 character needs 2. Lower is more forgiving. Min: 0.25 Max: 3.00 Default: 1.00
        DressingTurnsScale = 1.0,

        -- Too little dressing gets dirty sooner, and more than enough lasts longer. Off: every dressing lasts as long as it would in the base game.
        DressingCleanTime = true,

        -- Tourniquets can be found or crafted, and put on a bleeding arm or leg from the Health menu. They stop the bleeding without healing the wound, and hurt the limb if left on.
        Tourniquets = true,

        -- Game minutes before a tourniquet starts adding pain and stiffness to the limb. Min: 5 Max: 480 Default: 30
        TourniquetPainMinutes = 30,

        -- Game minutes before a tourniquet starts damaging the limb and can cause a pressure injury. Min: 10 Max: 1440 Default: 120
        TourniquetDamageMinutes = 120,

        -- Taking a tourniquet off gives it back. Off: it is used up when it goes on.
        TourniquetReusable = false,

        -- Scales how often morphine, heroin and fentanyl syringes spawn. 0 removes them. Min: 0.00 Max: 10.00 Default: 1.00
        DrugLootChance = 1.0,

        -- Scales the chance that an overdose kills. 0 means every overdose is survivable. Min: 0.00 Max: 3.00 Default: 1.00
        DrugOverdoseLethality = 1.0,

        -- A panel beside the health screen showing heart rate and rhythm, blood pressure, oxygen, blood left, clotting, every organ and the problem list.
        VitalsReport = true,

        -- The Miserable, high and condition moodles. Off hides them for everyone; players can also hide them for themselves in Options > Mods. The conditions still happen.
        ShowMoodles = true,

        -- The screen blurs when a character is badly dehydrated or has lost a lot of blood. Players can also turn it off for themselves in Options > Mods.
        VisionEffects = true,

        -- How fast bleeding empties the body. A deep wound already counts for seven scratches and a dressing stops most of it, so a bandaged cut barely registers. 0 stops blood loss. Min: 0.00 Max: 5.00 Default: 1.00
        BloodLossRate = 1.0,

        -- How fast lost blood comes back once nothing is bleeding. It already comes back faster on a full stomach. Min: 0.10 Max: 5.00 Default: 1.00
        BloodRecoveryRate = 1.0,

        -- How fast a damaged heart, lungs, liver, kidneys and gut heal by themselves. The brain never heals. 0 means organ damage is permanent. Min: 0.00 Max: 5.00 Default: 1.00
        OrganRecoveryRate = 1.0,

        -- A body in trouble acts like it: blackouts with no blood pressure, palpitations, seizures without oxygen, coughing fits, cramps, nosebleeds, shivering. Never while being treated.
        HealthEvents = true,

        -- Scales how often health events happen when the body is in the state that causes them. Min: 0.10 Max: 5.00 Default: 1.00
        HealthEventRate = 1.0,

        -- Serious conditions develop from injuries and neglect: collapsed lungs, sepsis, clots, kidney failure and more. Each is on the problem list with a To-do entry explaining the fix. Off: none of them happen. The options below turn single groups off.
        ClinicalConditions = true,

        -- Scales the chance of every condition developing. 0.5 halves it; 2 doubles it. Min: 0.00 Max: 5.00 Default: 1.00
        ConditionOnsetRate = 1.0,

        -- Left alone, some conditions turn into worse ones: a wound infection into sepsis, a clot into an embolism. There is always a warning first. Off: they stay as they are until treated.
        ConditionsWorsen = true,

        -- Multiplies how long a condition takes to become the next one. 2 gives twice as long. Min: 0.25 Max: 5.00 Default: 1.00
        ConditionWorsenTime = 1.0,

        -- Rib fractures, collapsed lung, vomit in the lungs, pneumonia and fluid on the lungs.
        ConditionsChest = true,

        -- Haemorrhagic shock and blood-loss anaemia.
        ConditionsBlood = true,

        -- Wound infection, sepsis, septic shock, necrosis and tetanus.
        ConditionsInfection = true,

        -- Compartment syndrome in a broken limb and tourniquet pressure injury.
        ConditionsLimb = true,

        -- Deep vein thrombosis after losing a leg, and the pulmonary embolism it can become.
        ConditionsClots = true,

        -- Low blood sugar, dehydration and kidney injury.
        ConditionsBodyNeeds = true,

        -- Hypothermia and hyperthermia.
        ConditionsTemperature = true,

        -- Concussion and bleeding inside the skull.
        ConditionsHead = true,

        -- Game hours a wound must go unwashed and undressed before it can become infected; the odds then climb over the next eight hours. A clean dressing, or searing it, winds the clock back twice as fast. Min: 0.50 Max: 48.00 Default: 4.00
        InfectionHours = 4.0,

        -- Game hours an infection must go untreated before it can reach the blood. A wound with a clean dressing on it can never become sepsis (unless the character is Immunocompromised). Min: 1.00 Max: 96.00 Default: 12.00
        SepsisHours = 12.0,

        -- Traits such as Thin-skinned, Slow Healer, Resilient and Prone to Illness, and Evolving Traits World's, change bleeding, clotting, healing and infection. Off: traits make no difference to this mod.
        TraitsAffectMedicine = true,

        -- Limbs can be cut off with a saw from the Health menu. Off: no amputation option.
        Amputation = true,

        -- Cutting off every bitten limb cures the zombie infection. Bites on the chest, neck or head can never be cut away.
        AmputationCuresInfection = true,

        -- Hours after being infected during which amputation still cures it. 0 means no limit. Min: 0.00 Max: 168.00 Default: 0.00
        AmputationCureWindowHours = 0.0,

        -- Offer amputation on any limb, not only bitten ones.
        AmputateWithoutBite = false,

        -- How hot a blade must be, heated in a fire, to seal a stump. Min: 100 Max: 900 Default: 300
        CauterizeTemperature = 300,

        -- Hours a stump that was never cauterized must stay bandaged before it closes on its own. 0 means it never does. Min: 0.00 Max: 720.00 Default: 72.00
        StumpSelfSealHours = 72.0,

        -- Without a hand some things cannot be held or done, without legs a character cannot climb or drive, and so on. Off: a missing limb only changes speed and walking.
        LimbLossLimits = true,

        -- Fraction of normal action speed with one arm gone and no prosthetic. Min: 0.10 Max: 1.00 Default: 0.60
        OneArmSpeed = 0.6,

        -- Fraction of normal action speed with both arms gone and no prosthetics. Min: 0.05 Max: 1.00 Default: 0.35
        NoArmsSpeed = 0.35,

        -- Fraction of normal walking speed with a leg gone and no crutch or prosthetic. Min: 0.10 Max: 1.00 Default: 0.50
        OneLegSpeed = 0.5,

        -- Fraction of normal walking speed on one leg with a crutch in hand. Min: 0.10 Max: 1.00 Default: 0.80
        CrutchSpeed = 0.8,

        -- Fraction of normal speed a prosthetic gives at Prosthetics skill 0. Min: 0.10 Max: 1.00 Default: 0.70
        ProstheticStartSpeed = 0.7,

        -- Fraction of normal speed a prosthetic gives at Prosthetics skill 10. Min: 0.10 Max: 1.00 Default: 0.95
        ProstheticMaxSpeed = 0.95,

        -- Scales how fast the Prosthetics skill levels up. Min: 0.00 Max: 10.00 Default: 1.00
        ProstheticXPMultiplier = 1.0,

        -- Scales how often prosthetics and crutches spawn in medical buildings. 0 removes them. Min: 0.00 Max: 10.00 Default: 1.00
        ProstheticLootChance = 1.0,

        -- Game hours of wear a crude wooden prosthetic lasts before it splinters apart. A badly made one starts partly worn. Min: 1.00 Max: 1000.00 Default: 48.00
        CrudeProstheticLife = 48.0,

        -- A character with no usable arm can lift light things in their teeth, and gnaw scrap wood off wooden objects to make a crude prosthetic. Off: with no arms they can do none of it.
        MouthWork = true,

        -- Scales how fast a wheelchair goes. At 1.0 it is a little over half walking speed with both hands on the rims; one hand pushes at 60 percent of that, and none at a quarter. Min: 0.25 Max: 2.00 Default: 1.00
        WheelchairSpeed = 1.0,

        -- Scales how often wheelchairs turn up in hospital rooms and medical storage. 0 removes them. Min: 0.00 Max: 10.00 Default: 1.00
        WheelchairLootChance = 1.0,

        -- When Tomb's Player Body is running, stumps and prosthetics are the ones cut from its bodies, so they fit its thinner limbs. Off: always the ones cut from the game's own bodies.
        BodyModCompat = true,

        -- Fraction of normal melee damage dealt from the floor. Min: 0.10 Max: 1.00 Default: 0.60
        CrawlMeleeDamage = 0.6,

        -- How hard a swing from the floor pushes zombies back or knocks them down, as a fraction of normal. Min: 0.00 Max: 1.00 Default: 0.40
        CrawlMeleeForce = 0.4,

        -- Fraction of normal melee damage dealt sitting in a wheelchair: all arms, no legs behind it. Min: 0.10 Max: 1.00 Default: 0.80
        WheelchairMeleeDamage = 0.8,

        -- How hard a swing from a wheelchair pushes zombies back or knocks them down, as a fraction of normal. Min: 0.00 Max: 1.00 Default: 0.60
        WheelchairMeleeForce = 0.6,

        -- A cut-off limb ends up in the hands of whoever cut it. It rots, and can be cooked and eaten, which costs more than it feeds.
        SeveredLimbs = true,

        -- Right-click someone who cannot walk (no legs, knocked down or asleep) to pick them up. It costs endurance, and the carrier cannot run or fight.
        CarryPlayers = true,

        -- When deep unhappiness lasts for days, standing still too long makes the character turn on themselves: self-harm after two days of it, and when Miserable after three, a suicide attempt. Antidepressants hold it off. Off: none of it happens.
        MiserableEnabled = true,

        -- Unhappiness (0-100) above which the depression clock runs and episodes can build up. Min: 30 Max: 100 Default: 70
        SelfHarmThreshold = 70,

        -- In-game days unhappiness must stay above the threshold before the first self-harm episode. Antidepressants stop the count and wind it back. Min: 0.00 Max: 30.00 Default: 2.00
        SelfHarmAfterDays = 2.0,

        -- In-game days of depression before a Miserable character's episode can be an attempt on their life. Until then it is self-harm, the warning. Min: 0.00 Max: 30.00 Default: 3.00
        SuicideAfterDays = 3.0,

        -- Unhappiness (0-100) at which a character becomes Miserable and episodes can become suicide attempts. The moodle lifts again 10 below this. Min: 50 Max: 100 Default: 90
        MiserableThreshold = 90,

        -- A Miserable character carrying a gun can use it on themselves. Off: they turn to a blade instead.
        FirearmSelfHarm = true,

        -- At rock bottom a Miserable character can claw out an eye. Off: they turn to a blade instead.
        EyeEpisodes = true,

        -- With no blade to hand, an episode can be a burn from a lighter or a blow from a blunt weapon. Off: with no blade, an episode is vomiting instead.
        SelfHarmWithoutBlade = true,

        -- Real seconds between an episode starting and it taking over the screen. You keep playing while the edges close in and the heartbeat gets louder. 0 means it lands at once. Min: 0 Max: 120 Default: 14
        SelfHarmGraceSeconds = 14,

        -- Instead of self-harm or suicide, an episode is vomiting, or when Miserable a heart attack and heavy vomiting. Each player can also turn this on for themselves in Options > Mods.
        MiserableCensored = false,

        -- Another living player nearby, on the same floor, stops an episode from starting or finishing.
        BuddyPreventsSelfHarm = true,

        -- How close another player must be to prevent an episode. Min: 1 Max: 30 Default: 8
        BuddyRadius = 8,

        -- Above the unhappiness below, a character will not bandage, stitch, disinfect or splint themselves, unless it is urgent (a bite, a bleed, a deep wound). Pills still work, and someone else can still treat them.
        LowMoodBlocksHealing = true,

        -- Unhappiness (0-100) above which a character will not treat their own minor wounds. Min: 30 Max: 100 Default: 75
        LowMoodHealingThreshold = 75,

        -- A bite that is not cut away weighs heavier every hour, until the character is as low as the infection is far along. Amputating it lifts the dread.
        BiteDespair = true,

        -- Game hours a bite takes to reach full despair. Min: 1.00 Max: 168.00 Default: 20.00
        BiteDespairHours = 20.0,

        -- Seeing a friend's body, a friend eaten alive by the dead, or anybody's attempt on their own life can leave a character with post-traumatic stress: flashbacks, nightmares and a low mood that never quite lifts, for good. Antidepressants and beta blockers soften it; nothing cures it. It only comes from seeing it happen, so it needs other players.
        PTSD = true,

        -- The chance each thing seen starts it (half as much again for a friend eaten alive). Less for the Desensitized and the Brave, more for the Cowardly, and certain once three have piled up. It sets in 12 to 48 hours later. Min: 0.00 Max: 1.00 Default: 0.35
        PTSDChance = 0.35,

        -- How many flashbacks a day, on average, for a character with post-traumatic stress. Four times as likely with the dead close by; fewer with antidepressants or beta blockers. Min: 0.00 Max: 24.00 Default: 3.00
        PTSDFlashbacks = 3.0,

        -- Game hours two players must spend near each other before one counts as the other's friend. Faction members always count. Min: 0.00 Max: 48.00 Default: 2.00
        PTSDFriendHours = 2.0,

        -- When a character is dying, the screen goes dark and the heart slows until it stops, leaving a short window for a defibrillator or a last stand. Off: death is instant, as in the base game.
        DeathScene = true,

        -- Overall health at which a dying character is caught and their last moments begin. Higher catches it more reliably (on a server the killing blow can come in one piece) but ends the fight sooner. Min: 1 Max: 40 Default: 10
        LastMomentsAt = 10,

        -- How long the countdown runs once the heart stops: the window in which a defibrillator or a last stand can still save them. Min: 5 Max: 120 Default: 30
        ArrestSeconds = 5,

        -- Zombies lose interest in a character in cardiac arrest and wander off for as long as it lasts. Off: they keep attacking.
        DownedIgnoredByZombies = true,

        -- Single player: the chance a dying character is not done yet. The bleeding stops (the wounds stay), health comes back and nearby zombies are thrown to the floor. The Unfinished Business trait guarantees one. Min: 0.00 Max: 100.00 Default: 5.00
        LastStandChance = 5.0,

        -- Overall health a last stand brings a character back to. Min: 1.00 Max: 100.00 Default: 37.00
        LastStandHealth = 37.0,
    },
    Artel = {

        -- A multiplier applied to the spawn chance of every mod item at once: "Scarce" leaves things as they were, "Noticeable" makes them three times as common, "Generous" tenfold, and "Abundance" puts something of ours in roughly every second or third fitting container. The group switches work separately from frequency: a disabled group never shows up at any level. The value is read when the world loads, so in a game already in progress it only affects blocks you have not visited yet. Default = Scarce (default)
        -- 1 = Scarce (default)
        -- 2 = Noticeable
        -- 3 = Generous
        -- 4 = Abundance
        LootRate = 1,

        -- Test switch: every waiting process of the mod (brewing, aging, potions, apiary, retort, bioreactor, souring, charging) runs a hundred times faster. Overrides both speed dropdowns below.
        DebugSpeed = false,

        -- Speeds up fermentation stages, sealed aging, mystic kegs and bottles, wild yeast and vinegar mash. Default = Standard
        -- 1 = Standard
        -- 2 = Faster (x2)
        -- 3 = Fast (x5)
        BrewSpeed = 1,

        -- Speeds up the charcoal retort and the bioreactor. Default = Standard
        -- 1 = Standard
        -- 2 = Faster (x2)
        -- 3 = Fast (x5)
        MachineSpeed = 1,

        -- Fuel and water consumption of the steam generator - one setting covers both tanks. 5 (default) means a full tank lasts about four and a half days under a full load; 1 stretches that five times longer, 10 burns through it twice as fast. Min: 1 Max: 10 Default: 5
        SteamFuelConsumption = 5,

        -- A debugging switch, not a gameplay setting. Off (default) — workstation furniture spawns as usual, rarely, and this entry changes nothing in the game. On — all four workstations are placed in every suitable building with a kitchen: the factory can sealer and the bar extruder onto a kitchen counter, the electric dryer and the freeze dryer onto the floor against a wall. They also sit in every matching container: one walk is enough to see that spawning works.
        BenchDebugSpawn = false,

        -- Groceries and supplies in world loot: flour, yeast, coffee, powdered and cartoned milk, honey, salt and pepper, jerky, instant juices, seed boxes (wheat, rye, barley, seasonal packs).
        FoodPackEnabled = true,

        -- Pharmacy goods in world loot: boxes of painkillers and sleeping pills, vicodin, cold remedy, stimulants, activated charcoal, orthopedic cast, a bag of empty capsules.
        MedPackEnabled = true,

        -- Outdoor gear in world loot: fishing, hunting, engineer and mess kits, a camp heater, a folding chair, an air mattress, empty lanterns, barbecue charcoal, water purification tablets, humanitarian airdrops.
        CampPackEnabled = true,

        -- Home brewing in full: steel kegs, wooden kegs, fermenting demijohns, finished beer, wine and spirits, airlocks, corks and sealing, brewer's books, wild yeast in foraging.
        BrewPackEnabled = true,

        -- Devices in world loot: laptops, printers and components, floppy disks, a portable TV, a portable generator, a heater, portable hobs, a satellite dish.
        ElecPackEnabled = true,

        -- Household goods in world loot: soap, toothpaste, packs of socks, thread and spools, a chemical hand warmer, a box of tin cans.
        HousePackEnabled = true,

        -- Machines and everything for canning: the factory and hand can sealers, the small smelting furnace, a sewing machine, a pasteuriser, a crate of milk bottles, the beekeeper's kit, a bucket of preservative, a pack of salt.
        MachinesPackEnabled = true,

        -- Army food in world loot: retort meals, the army ration and its crate, anti-hypoxia capsules, factory canned goods, bars and energy drinks.
        MREPackEnabled = true,

        -- A separate switch inside the "Machines and canning" group. It kills both layers at once: the item in cupboards and the ready-made bench in the world. If the group itself is off, the sealer will not appear either way.
        FactorySealerSpawn = true,

        -- The secret branch: three extremely rare recipe parchments, a copper alembic and three potions - lifting the zombie virus, healing the body completely, clearing fatigue. Off: the parchments and the alembic do not appear in the world.
        MysticBreweryEnabled = true,

        -- From 1 to 5, default 2. Every potion needs its own empty vial: no container, no potion. Min: 1 Max: 5 Default: 2
        MysticPotionYield = 2,

        -- On (default): pouring into the conditioning demijohn consumes the parchment for good, and the potion cannot be brewed again without a new scroll. Off: the parchment comes back to your hands after the pour and lasts forever.
        MysticScrollBurn = true,

        -- Craft them or find them. Potions turn up where the parchments do, and in survivor stashes. Rare: 5 times rarer than parchments. Normal: as often as parchments. Often: 5 times more often than parchments. Read when the world loads: in a game already in progress it only affects places you have not visited yet. Default = None (default)
        -- 1 = None (default)
        -- 2 = Rare
        -- 3 = Normal
        -- 4 = Often
        MysticPotionLoot = 1,

        -- Three new medicinal herbs - valerian, St. John's wort and willow bark - appear in foraging. Off: the herbs are never found, but garden plots and anything already gathered stay as they are.
        SportpitPackEnabled = true,

        -- The forbidden branch of sports nutrition: a bar made from aged mouldy paste raises the skill levels of its group but always leaves a side effect. This also covers the rare zombie in a mutant suit and the infected bar. Off: the recipes and items remain, but there are no levels and no side effects, and the mutant does not appear in the world.
        SuperBarsEnabled = true,

        -- 0 (default) - no cooldown, eat as many as you find. Above zero: a second bar eaten within that many in-game hours gives neither levels nor side effects. Min: 0 Max: 168 Default: 0
        SuperBarCooldownHours = 0,

        -- 0 - no side effects at all, only the levels remain. From 1 to 7 - that many in-game days each caught effect hangs on you (default 3). Effects of different kinds stack on top of each other. Min: 0 Max: 7 Default: 3
        SuperBarDefectDays = 3,

        -- The whole apiary: hives placed in the yard, a queen bee found deep in the forest, a colony that settles in and fills the combs, hives that fall ill and are treated with a sprayer, and insulation for winter. Off: the handbook, the smoker and the queen do not spawn in the world, and hives do not tick.
        BeekeepingEnabled = true,

        -- Off (default): comb filling speed depends on the month - the peak is May to July, autumn is weak, and in winter no honey comes at all. On: seasons are ignored and combs fill at a steady rate all year.
        BeeYearRound = false,

        -- On (default): once a day a colony can fall ill; in winter and the dead season twice as often, a flower bed nearby halves the chance, and insulation left on the hive over summer raises it sharply. A sick hive stores no honey and dies without treatment - the sprayer saves it. Off: disease never comes, and a colony that is already sick simply waits for the sprayer.
        BeeDiseaseEnabled = true,

        -- On (default): when stung without smoke and without a suit there is a rare chance the sting tears the skin - an ordinary scratch, it never carries the zombie infection. Off: stings only bring pain, stiffness and panic.
        BeeStingWound = true,

        -- On (default): the drying rack, the electric dryer and the freeze dryer work - drying fish, curing meat, dried fruit and compote. Off: the station windows do not open and the branch stands still. The items themselves and the cooking recipes stay in place.
        DryingEnabled = true,

        -- On (default): two chemistry journals and the hand pill press appear in the world - bookshelves, post offices, schools, pharmacies and medical spots; acid demolition and the bioreactor work. Off: the journals and the press do not spawn, and acid and the bioreactor offer no actions. The chemistry bench and the bioreactor are still built and do not depend on this switch.
        ChemPackEnabled = true,

        -- A four-tile station that burns wood and charcoal, drinks water and powers your base without petrol. Built in four stages, it wears down and needs welding. Off: the station menu does not appear and the manual does not spawn; stations already built stay in the world.
        SteamPackEnabled = true,

        -- The cooler bag and the root cellar slow down spoilage of the food inside them. Off: the bag stays an ordinary bag, the cellar an ordinary container, and the cellar building menu does not appear; cellars already built and their contents stay as they are.
        ColdStorageEnabled = true,

        -- One setting for the whole quantum branch. On (default): the wall quantum storage is built and holds up to four cells of 1000 each, nothing inside them spoils at all while the tile has power; quantum vials and the strange device appear in lab, military and electronics loot; reading the device unlocks the storage recipe and grants a one-off +1 Electrical. Off: the vials and the device do not appear in the world, the storage recipe disappears from crafting even with "show all" ticked, the device teaches nothing, and the freezing does not work. Nothing already built breaks: storages and their contents stay where they are, the contents simply start to spoil again.
        QuantumTech = true,

        -- The trading radio post in full: the dying note turns up as ultra-rare loot on radio masts, in military spots and survivalist stashes; whoever reads it can build the post under open sky and trade goods for vanilla money - buying at full price, selling for 30 percent. Without power the recipes in the post window are unavailable. Off: the note does not appear in the world, the building recipe disappears from the crafting menu even with "show all" ticked, and the window of an already built post will not open. The posts themselves are not removed from the world.
        TradePostEnabled = true,

        -- How many in game days until a new trader arrives with his own goods and a full purse. The credit term does not depend on this: 44 days. Default = 11 days (default)
        -- 1 = 3 days
        -- 2 = 5 days
        -- 3 = 11 days (default)
        -- 4 = 17 days
        TradeCycleDays = 3,

        -- How many notes the trader is willing to pay out per visit at reputation level 1. Every level adds 20 percent: at level 10 it is 5 times more. Default = 200 (default)
        -- 1 = 200 (default)
        -- 2 = 500
        -- 3 = 1000
        -- 4 = 2000
        TradeWalletBase = 1,
    },
    TWGameplay = {

        -- Zombies hear less in heavy rain, blizzards and strong wind: footsteps, doors, fighting and gunshots carry a shorter distance. On top of the game's own small rain and fog effect.
        RainMasksNoise = true,

        -- 0 = no extra effect, 0.5 = a downpour cuts how far zombies hear by about a quarter, 1 = by about half (never below the minimum below). Min: 0.00 Max: 1.00 Default: 0.50
        NoiseMasking = 0.5,

        -- For a few seconds after a nearby thunder clap reaches you, zombies hear much less. Time your shot with the thunder.
        ThunderMasksNoise = true,

        -- Zombies always keep at least this fraction of their hearing distance, whatever the weather. Min: 0.20 Max: 1.00 Default: 0.55
        MinHearing = 0.55,

        -- Fog, downpours, heavy snow and white-outs shorten how far zombies can spot you, beyond the game's own limit.
        WeatherLimitsSight = true,

        -- 0 = no extra effect, 0.5 = thick fog roughly halves the spotting distance, 1 = stronger still (never below the minimum below). Min: 0.00 Max: 1.00 Default: 0.50
        SightReduction = 0.5,

        -- Zombies always keep at least this fraction of their spotting distance, whatever the weather. Min: 0.20 Max: 1.00 Default: 0.40
        MinSight = 0.4,

        -- The game's weather falls in places, not everywhere at once: storms several kilometres across drift over the map, fog lies in banks, showers pass by. Rain barrels fill, crops get watered, you get wet, fires go out and zombies react only where it is actually raining. Off: the game's map-wide weather. Forced weather (admin climate controls) is always map-wide.
        RegionalWeather = true,

        -- How big the storm areas, fog banks and showers are. 1 = several kilometres across (a few storms over the whole map); 2 = twice as large; 0.5 = half. Min: 0.40 Max: 2.50 Default: 1.00
        StormSize = 1.0,

        -- Lightning takes the tallest thing near where it comes down. Out in the open, with no tree or building near, that is you: a direct hit burns badly and knocks you down or kills you, a strike within 3 tiles burns and knocks you down, within 8 tiles the shock through the ground staggers you. Trees, buildings, roofs and vehicles protect you. Nobody is aimed at.
        LightningHitsPlayers = true,

        -- Chance that a direct lightning hit kills. 0 = always survivable (heavy burns), 0.3 = about one in three, 1 = always deadly. Min: 0.00 Max: 1.00 Default: 0.30
        LightningDeathChance = 0.3,

        -- How many extra ground strikes come down at random over a thunderstorm (the game's own are spread over kilometres). 1 = about one every 45 seconds within a few hundred metres of each player; 0 = only the game's own strikes. Min: 0.00 Max: 4.00 Default: 1.00
        LightningFrequency = 1.0,
    },
    SMB_steps = {

        -- On: ladders and poles spend endurance like the game's rope climbing and work the arms (sore later, using the game's muscle strain setting); sliding down rails or a pole without gloves burns the hands, and landings with weight strain the legs. Worn out, the climber trembles on the ladder and climbs out at the top on a knee. More with weight or Run, less when strong and fit. Off: climbing costs nothing.
        Effort = true,

        -- Survivable: a tired, loaded or rushed climber can slip and fall, and the fall alone never kills. As in the game: falls take the game's damage from the real height and can kill. Off: every slip is caught. The game's Easy Climbing also turns slips off. Default = Survivable
        -- 1 = Survivable
        -- 2 = As in the game
        -- 3 = Off
        Falls = 1,
    },
    MartialArts = {

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        BoxingAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        BoxingAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        BoxingStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        MuayThaiAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        MuayThaiAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        MuayThaiStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        KarateAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        KarateAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        KarateStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        MMAAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        MMAAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        MMAStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        BrawlingAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        BrawlingAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        BrawlingStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        TaekwondoAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        TaekwondoAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        TaekwondoStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        WrestlingAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        WrestlingAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        WrestlingStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        JiuJitsuAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        JiuJitsuAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        JiuJitsuStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        PakMeiAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        PakMeiAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        PakMeiStaminaDrain = 100,

        -- 100 = current balance, 50 = half, 200 = double. Changes attack playback speed, including paired throws. Does not change movement or dodge speed. Min: 10 Max: 500 Default: 100
        CombativesAttackSpeed = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales martial arts attack damage. Does not add damage to positional Jiu-Jitsu throws. Min: 0 Max: 1000 Default: 100
        CombativesAttackDamage = 100,

        -- 100 = current balance, 50 = half, 200 = double. Scales attack stamina cost, including paired throws. Zero removes the cost; minimum stamina requirements still apply. Does not change dodge costs. Min: 0 Max: 1000 Default: 100
        CombativesStaminaDrain = 100,

        -- Off preserves the current behaviour: martial arts proxy attacks deal no door damage. On gives them 1 base door damage per hit. Does not change real weapons, pushing, windows or tree damage.
        DamageDoors = false,
    },
    EffortlessTowing42 = {

        -- Multiplier for the towing force applied by standard vehicles. Set to 0 to disable the assist for this class. Min: 0.00 Max: 10.00 Default: 4.00
        StandardFactor = 4.0,

        -- Multiplier for the towing force applied by heavy duty vehicles. Set to 0 to disable the assist for this class. Min: 0.00 Max: 10.00 Default: 5.00
        HeavyDutyFactor = 5.0,

        -- Multiplier for the towing force applied by sport vehicles. Set to 0 to disable the assist for this class. Min: 0.00 Max: 10.00 Default: 3.00
        SportFactor = 3.0,
    },
    ALifeJimmy = {

        -- No NPC spawns in player bases (right-click > [A-Life Jimmy] Bases), and non-hostile NPCs won't break, pick or scavenge anything inside.
        Base_Protect = true,

        -- NPCs open doors they can open, but only smash windows, break doors, pull down barricades or pick locks when they're looting or raiding, and only when there's no door they could open instead. When forcing their way in they go for a window before a door (much quicker), and looters may use windows when a building's doors are all locked. Everyone else goes another way or somewhere else.
        Breach_Policy = true,

        -- NPCs don't choose spots inside your grounds to wander to, and anyone who lingers there without belonging (6 seconds) walks back out. Not your residents, people following a player's orders, captives, raiders or anyone fighting a player, or someone you're standing next to (talking or trading).
        Base_KeepOut = true,

        -- NPCs fighting a player, and raiders, may still break doors and barricades in base areas, and walk past door and window markers anywhere. Off: bases and markers hold them too.
        Base_HostileCanBreach = true,

        -- Your residents shut a door or window of their base behind them once they've gone through and nobody is in the way, and one they opened in passing (one you opened or left open stays as it is). An outside door that was locked locks again. Off: doors and windows they open stay open.
        Base_ShutDoors = true,

        -- Right-click a door or window > [A-Life Jimmy] to mark it No trespassing (NPCs who don't belong keep out; your residents, people on your orders and captives may pass) or Private (everyone keeps out, your residents too). Raiders and anyone fighting a player pass both while Attackers can breach bases is on. NPCs can always get out, and shut a marked door they opened behind them (never one you opened or left open).
        Doors_Marks = true,

        -- How many bases each player (or vanilla faction) may mark. Admins aren't limited. Min: 0 Max: 20 Default: 2
        Base_MaxBases = 2,

        -- Rectangles (main, quarters, yard) one base may have. Admins aren't limited. Min: 1 Max: 30 Default: 6
        Base_MaxAreas = 6,

        -- Tiles a resident crew stands guard on. Admins aren't limited. Min: 0 Max: 40 Default: 8
        Base_MaxPosts = 8,

        -- Right-click near an allied crew to invite them to one of your bases. They stand guard at your guard posts, live in the quarters and defend the base. A-Life never builds there.
        Residents_Enabled = true,

        -- People living at your base become members of an A-Life faction for your group (civilian, never spawns on its own), keeping their looks; restyle them in A-Life's Faction & NPC Creator. They go back to their old faction if they leave. Single player: A-Life keeps this faction in a file shared by all your SP worlds.
        Residents_JoinFaction = true,

        -- In A-Life's conversation, people living at your base talk to you as their own people, not as strangers: they greet you by name, call the base home, don't ask to join or offer you a walk, and A-Life's stranger, robbery and recruiting choices are hidden for them. On A-Life 1.4 their window gets a Home tab (how they're holding up, what they're on, base news, how long they've been here, what they think of you), and their small talk at the base is about the base. Off: A-Life's own lines, as before.
        Residents_Talk = true,

        -- When one of your residents gets a new kind of task (a guard post, a body to move, a weapon to fetch, a job) they say a short line, like "Heading to the Gate." At most one line each every 45 seconds, only with a player nearby. Default = Text and voice
        -- 1 = Off
        -- 2 = Text only
        -- 3 = Text and voice
        Residents_Announce = 3,

        -- Guards take turns on the posts, by the schedule or by tiredness: each base picks with Shifts by on its Schedule tab (the setting below is the default). By tiredness, on posts you haven't pinned anyone to, a rested resident relieves a tired guard (needs tiredness to be on). A tired guard sits down at the post (and gets up to fight). Off: posts are filled in order and nobody takes turns - no schedule and no Trip shifts (the setting below does nothing).
        Residents_Shifts = true,

        -- The default for a base that has not chosen: each base picks its own on the Schedule tab (Shifts by), and that choice wins over this option. The schedule (the default for a new world): three 8-hour shifts (day 06-14, evening 14-22, night 22-06) and a schedule per resident - a guard post, work, training, a trip, free time, sleep - dealt by the base itself (Auto-schedule, on by default) or set by hand. 20 minutes before a shift starts the relief walks up beside the post, and only then does the guard go off duty. Tiredness (automatic): a rested resident relieves a tired guard, as before; pins and jobs work as they do today. Switching between the two keeps what you set up: pins and picks become schedules, and a schedule is parked while shifts go by tiredness and comes back when they go by the schedule again. A world from before the schedule goes on it too when you load it: pins become Guard cells, workers the Worker role, and Auto-schedule deals in the rest; a base that prefers tiredness presses Shifts by on its Schedule tab. There is no 12-hour watch any more: a guard who stands two shifts in a row covers 16 hours. Default = The schedule
        -- 1 = Tiredness (automatic)
        -- 2 = The schedule
        Residents_ShiftMode = 2,

        -- Residents off a post live their day with animations of their own, with either kind of guards' shifts. They sleep in their room in their sleep window (in their own bed with Residents sleep in beds on): with Shifts by: The schedule, their Sleep shift (15-45 minutes in, to its end, or to the call before a Guard, Work or Train shift); otherwise (tiredness) about 22:30 to 06:30. Worn out, they take a two-hour nap. They eat and drink in their room at meal times - about one, six and twelve hours after their sleep shift ends, so around 07:00, 12:00 and 18:00 for someone who sleeps at night (and for everyone with tiredness shifts) - or when hungry or thirsty, unless the base is out of food. Otherwise they relax on the floor in their room, read, exercise or have a smoke (outside by day), which keeps them from wandering in and out of the house. Danger wakes them at once, and when a real threat gathers at the base (one of the crew fighting people, hostile people close by, zombies in numbers) everyone off duty gets up until it has passed, with a note for you. Workers and trainees keep their work. Off: as before.
        Residents_DayPlan = false,

        -- Each resident gets a bed of their own in their quarters (a double bed sleeps two; everyone has a bed to themselves before anyone shares), kept until the beds or their quarters change. In their sleep window they walk to it, get in and lie down to sleep, and get up out of it at the end, at an alarm, when danger comes or when you talk to them. With no bed free, or none they can get to, they sit down and doze. Their task says Asleep only while they really are, else Going to bed, Dozing, Getting up or Resting. With the day plan off this still runs for the schedule's Sleep shifts. Off: they sit beside a bed as before.
        Residents_Beds = true,

        -- When a real threat comes to a base, everyone living there gets up and the crew off the guard posts go to it. It goes off when one of the crew is fighting people, shot or killed at the base, a raider is within 40 tiles, two other hostile people are within 25, hostile people drive up, a loud noise near the grounds comes with hostile people about (A-Life 1.4), or zombies gather in numbers by a building or a sleeper. Sleepers stand up, training and work pause (the task says Alarm), and those off a post head for the fight, with a longer reach while it lasts; the guards hold their posts, and with more than three going one stays in each quarters. It lasts 15 minutes after the last sign of the threat, with a note in the base's News. A loud noise alone sends whoever is awake to look, without waking anyone. Off: they react only to what each of them sees.
        Residents_BaseAlarm = true,

        -- Your people inside their own base behave like people at home. Nobody sneaks about (A-Life's Stealth specialty and its quiet walking). Nobody leaves the base to look for a zombie that went out of sight past the fence, or walks out to a noise past it (someone who shot at them is still hunted). Nobody goes to check a noise made by their own crew or by you, or treats the base's own barricades, generators and cars as clues to search. Guards stay on their posts unless a crewmate close by calls for help. The early-outbreak panic doesn't grip them. A real threat changes all of it: someone they see and fight, the base alarm, a mission, an escort. Off: A-Life decides as it does everywhere else.
        Residents_HomeCalm = true,

        -- With a working two-way radio (a walkie-talkie in your inventory, or a ham radio you stand next to: on, with power), right-click it > Call your people: a status check of your bases (who's at home, on a post, asleep, out, hurt or bitten, and the alarm), Come to me (1, 2 or 4 of the people off the guard posts, or one by name, follow you as an escort for a day), Hold the base (everyone at home up and alert for an hour), Sound the alarm, Stand down and Head home. The base must be within the reach of both your radio and the base's own radio. People you call travel unseen and come into view about 40 tiles from you, after about one game hour per 400 tiles. Off: no radio menu.
        Radio_Enabled = true,

        -- How far each base's own radio reaches, in tiles. A call goes through when the base is within both this and your radio's own range (750 tiles for a toy walkie-talkie, 2000 for an ordinary one, up to 20000 for military and high-end radios). A radioman living at the base doubles it. Min: 100 Max: 20000 Default: 4000
        Radio_BaseRange = 4000,

        -- Off duty, residents spread out over the quarters' rooms instead of crowding the middle, keep away from bodies, and at night rest beside the beds.
        Residents_RestSpots = true,

        -- When a resident dies the others mourn for three game days: one of them says something, they fight worse if the base is raided, and they turn on whoever did it (a player who isn't one of the base's people, or an NPC crew you can then send people to hunt).
        Residents_Grief = true,

        -- A-Life 1.4 only. A resident whose opinion of the base's people stays at A-Life's worst (Hates you) for 6 game hours leaves, as if sent away: no grudge, back to their old faction. Only hours with one of the base's people online count. They wait until they're home, off shift and awake. An admin's Clear opinions or a kind act before then puts it right.
        Residents_LeaveWhenHated = true,

        -- An off-duty resident carries zombie corpses out of the base to its body dump, one at a time. Set a dump from the Bases menu; with none, bodies are left where they are.
        Residents_ClearBodies = true,

        -- Residents can be given a mission or a clean-up duty that repeats at the same hour (faction window > People > Every day...). It runs by the game clock, whether or not the player who set it is online. At a base whose shifts go by the schedule it also runs the Trip shifts (Scavenge, Patrol, Patrol an area) and the Scavenger role. Off: nothing runs; saved routines and Trip shifts are kept, a Trip shift counts as Free and a Scavenger stands watch like an All-rounder.
        Residents_Routines = true,

        -- A routine never sends out so many that fewer than this many residents stay at the base, and Auto-schedule keeps a Scavenger home for the same; a Trip shift you put in someone's schedule yourself goes regardless. Pinned guards and workers are never picked automatically, and at a base on the schedule a routine takes only people on a Free shift. Min: 0 Max: 12 Default: 2
        Residents_RoutineKeepHome = 2,

        -- A crew only moves in if the base's quarters have a bed for each of them: single beds and sleeping bags hold 1, double beds 2, bunk beds twice that. Residents per base still caps it.
        Residents_NeedBeds = true,

        -- Residents eat 1 supply a day each and scrounge half that themselves; mark a container as a Food store (My people > Bases > Stores...) and they eat from it when their supplies run low. Out of food for 7 days, they leave. Off: they never go hungry, and only take enough from the Food store for training and trades (medicine in a Medical store still heals).
        Residents_NeedFood = false,

        -- Off: the crew never touches containers in the quarters, so your things are safe there; they only take what they need from containers you mark as stores (My people > Bases > Stores..., or right-click a container > Bases > Store). On (the old way): every 10 minutes while nobody is near, food, drink, smokes and medicine in the quarters' containers become supplies, and ammo and weapons go to their armory. Containers marked as stores are always left out of it.
        Residents_QuartersIntake = false,

        -- A-Life gives about half of all groups a flashlight beam at night (19:00 to 07:00), and a base's residents share one group. Not indoors (the default): residents put the light away while they sleep, sit, or are inside one of the base's buildings (a main building or quarters), and take it out again outside: on a post in the yard, on patrol, escorting you, on a trip. Traders visiting a base do the same inside its buildings. Always: A-Life's way, the light on wherever they are. Never: residents and visiting traders never carry one. Their night sight stays the same either way. Default = Not indoors at the base
        -- 1 = Not indoors at the base
        -- 2 = Always (A-Life's way)
        -- 3 = Never
        Residents_Flashlights = 1,

        -- How many NPCs may live at one base (default 12, up to 30), whatever the beds say; beds in the quarters are the other limit. A crew only moves in if all of them fit. Min: 0 Max: 30 Default: 12
        Base_MaxResidents = 12,

        -- Longest side of one base area, for players. Admins may mark up to 400. Min: 10 Max: 400 Default: 80
        Base_MaxSide = 80,

        -- Hostile groups may attack a base with residents while no player is within 110 tiles (from day 7, at most every 3 days a base). Guard posts help; a crew out of food fights worse. Nobody takes the base over.
        Bases_Raids = true,

        -- Per hostile group within 80 tiles, checked every game hour while you're away. Min: 0 Max: 100 Default: 5
        Bases_RaidChance = 5,

        -- Under the name of someone living at your base: what they're meant to be doing (on guard, working, carrying a body, patrolling...), how far they are from where they should be, and whether they're stuck. Their spot is highlighted. Only for your own bases.
        NpcTags_Tasks = true,

        -- Under an NPC's name: keeping their distance from you, attacking you, protecting you, fighting zombies, checking out a noise, searching, scavenging, running away... So someone marked hostile who isn't attacking shows why.
        NpcTags_Intent = true,

        -- Outpost theft only angers the garrison at the players who were inside; avengers only hunt someone who actually killed that outpost's people; manhunters never switch to a bystander.
        Blame_Fair = true,

        -- Deeds move points with each faction; your standing moves one step at a time from the faction's default (hostile, careful, neutral, friendly, allied). Attacking or killing costs points instead of turning a faction hostile forever (the people you fought still turn on you). Helping them and gifts raise it.
        Standing_Enabled = true,

        -- Scales every standing gain (gifts, help). Factions also differ: families trust readily, raiders and hostile factions slowly. Min: 0 Max: 500 Default: 100
        Standing_GainRate = 100,

        -- Scales every standing loss (attacks, killings). Law and military take violence hardest, raiders and gangs least. Min: 0 Max: 500 Default: 100
        Standing_LossRate = 100,

        -- Puts a Reset standing button on everyone's Standing tab in the faction window: it wipes their standing points with every faction and crew. Admins can always reset. NPCs' own grudges stay.
        Standing_PlayersMayReset = false,

        -- With A-Life's per-person opinion on, a faction's standing with you is built from what its people think of you, what the faction remembers (your old points, and what people who are gone thought of you) and rumours. Hits, kills and help in a fight count through the people (they fade as A-Life's opinions do); gifts, trades and the rest add to what the faction remembers. Off: your standing points alone decide, as before.
        Standing_OneReputation = true,

        -- Food and medicine become supplies (growth; medicine heals defenders), guns, ammo and melee weapons go to the outpost's armory (defenders use them in sieges). Players who were inside recently gain standing with that faction (capped per day). Taken in once you're 40+ tiles away.
        Donations_Enabled = true,

        -- When you start talking, NPCs may bring up real things you did to their faction or crew (gifts, help, attacks, killings) with where and when it happened. Only deeds their faction has heard about.
        Memories_Enabled = true,

        -- Say 'take this' (or 'here you go', 'this is for you') to someone who isn't hostile while holding an item: they take it and your standing with their faction rises. Outpost members pass supplies and weapons on to their outpost.
        HandGifts_Enabled = true,

        -- Right-click one of your residents or someone following you > Equip (or 'Gear up for this.' in conversation): hand them weapons, clothes (residents) and gear from your inventory for a trip, and take any of it back whenever you like. No prices, no standing. Ammo that fits their gun goes into their spare rounds and isn't given back.
        Equip_Enabled = true,

        -- When someone you equipped stops following or waiting for you (for a quarter of an hour), what you lent them goes back into your inventory if you're within 30 tiles, or else a resident's goes into their base's stores and anyone else's waits until you're near. Off: they keep it until you take it back.
        Equip_AutoReturn = true,

        -- Now and then a few traders from a peaceable faction that you get on with walk to one of your bases, wait a few tiles outside the grounds and trade through the Trade window (right-click them, or say: want to trade). They sell food, medicine, tools, general goods or guns and ammo, and pay for what they want. Needs Trade (hand gifts) on.
        Traders_Enabled = true,

        -- Percent, each game hour from 7:00 to 17:00, that a base with one of its people online nearby gets traders. 3 is about one or two visits a week for a base someone plays at most days. 0: no visits (the debug menu still sends them). Min: 0 Max: 100 Default: 3
        Traders_Chance = 3,

        -- Game hours after traders leave a base before the next visit there can happen. Min: 6 Max: 336 Default: 48
        Traders_CooldownHours = 48,

        -- The world day from which traders visit. Min: 0 Max: 60 Default: 3
        Traders_MinDay = 3,

        -- Game hours traders wait once they've reached your base (a little longer if you're in the middle of trading). They leave sooner if they sell out or the base is raided. Min: 1 Max: 24 Default: 6
        Traders_StayHours = 6,

        -- A trader plus guards. More people means more who can fight off zombies while they wait, and more NPCs on the map. Min: 1 Max: 4 Default: 2
        Traders_PartySize = 2,

        -- Now and then a gunsmith comes, selling guns, ammo and gun parts. Off: never.
        Traders_Guns = true,

        -- Attack, hold up or kill a trader and the rest run; no traders visit that base for this many days. Traders killed by zombies bring no penalty. Min: 0 Max: 60 Default: 14
        Traders_BanDays = 14,

        -- A visiting trader can be asked to live at your base (Would you stay with us?). They need friendly standing with their faction, to like you (or a trade first), a free bed and some supplies. They keep a stall, restock from their faction, buy what you put in a Trade goods store and trade through the Trade window. Off: nobody can be asked, and a trader who stayed is an ordinary resident.
        Traders_CanStay = true,

        -- On A-Life 1.4 with its NPC opinions on: how much the trader must think of you (16 is Likes you, 41 Trusts you). Without opinions they want one trade with you first. Min: -100 Max: 100 Default: 16
        Traders_StayOpinion = 16,

        -- Taken from the base's supplies when a trader agrees to stay. 0: free. Min: 0 Max: 100 Default: 10
        Traders_StayCost = 10,

        -- Every this many game hours a trader living at your base gets fresh goods from their faction (about half of what a visit brings, up to twice a visit's most of each). Min: 6 Max: 168 Default: 24
        Traders_RestockHours = 24,

        -- With Sell what we can spare, a resident trader sells only what the base's Food and Medical stores hold beyond this many items of each. Min: 0 Max: 200 Default: 20
        Traders_SurplusKeep = 20,

        -- With friendly standing, say 'follow me', 'wait here' or 'go away' to someone (or answer yes to 'Maybe we can work together?'): their crew follows you for 3 game hours or holds its spot for 6. At most 4 followers.
        Friendlies_Enabled = true,

        -- Your own people and anyone following or waiting for you never complain or get scared when your gun points their way. Allies don't either while a fight is on around them. Anyone hostile to you or fighting you still reacts as usual.
        AimCalm_Enabled = true,

        -- NPCs normally only fight other NPCs their faction is at war with. With this on, anyone hostile to you is hostile to your residents too (anywhere, and while you are away: a grudge against the base owner, a raid, a faction hostile to all players). Allied NPCs step in within 25 tiles of you, friendly ones only when it is right on you (6 tiles). It fights back.
        Defenders_Enabled = true,

        -- A crew you've helped (or wronged) enough treats you by its own standing, not just its faction's: a crew that owes you stays friendly even if its faction turns hostile, and the other way round. A grudge or a raid still wins.
        CrewStanding_Enabled = true,

        -- How many times one of your own people or an ally lets it go when you hit them (within 10 minutes): no anger, no grudge, no lost standing, they don't fight back. The next hit turns that one person against you, never their faction or crew. Killing still counts as killing. 0: off (A-Life's own rule only). Min: 0 Max: 10 Default: 2
        FriendlyFire_Forgiven = 2,

        -- Once a faction hears what you did, the story reaches other factions over the next day or so - weaker, and sometimes exaggerated, played down, lost or pinned on someone else. The victim's friends think less of you, their enemies a little better; raiders barely care about violence, the law cares most. Rumors fade over a few days and on their own never make a faction hostile (careful at worst). Harm to people who were hostile to you angers nobody. Off by default.
        Rumours_Enabled = true,

        -- Emotes count as saying the matching thing to the nearest person you face: wave = hello, follow me / come here = follow, stop / freeze = wait, move out = go away, thank you, thumbs up, insult, yes / no answer their questions.
        Emotes_Enabled = true,

        -- Aim a gun at an NPC and tap the shout key (Q). They may surrender: hands up, and you can make them drop their weapon or empty their pockets, or let them go. If they refuse, they hold a grudge.
        Intimidation_Enabled = true,

        -- A-Life has hold-ups of its own (orders in the talk window). A-Life's: Q while aiming gives its orders (hands up, then hand over weapons, then empty pockets), with ours on top: the disarmed stay disarmed, standing, grudges, Mercy. Ours: our own hold-ups (Q) beside A-Life's, one owner per NPC. Talk window only: Q is the game's own shout. Default = A-Life's, Q gives its orders
        -- 1 = A-Life's, Q gives its orders
        -- 2 = Ours
        -- 3 = Talk window only
        Intimidation_Mode14 = 1,

        -- A-Life weighs a hold-up its own way. On: someone hurt, frightened or in pain gives in more easily, and crew-mates you killed lately make them more or less likely to (by who they are), up to 30 points either way. Only with Hold people up at gunpoint on.
        Intimidation_Odds14 = true,

        -- Told to drop their weapon or empty their pockets, someone who surrendered may refuse: run for it, or (still armed) fight. More likely when they're angry with you, hostile, or have the numbers; less when they're wounded or peaceable.
        Intimidation_Defiance = true,

        -- How long someone who surrendered stays put with nobody aiming at them before they may make a break for it (checked every 3 seconds after that). Walk more than 30 tiles away and they slip off anyway. Only with 'Captives may refuse orders' on. Min: 3 Max: 300 Default: 15
        Intimidation_CoverSeconds = 15,

        -- Someone you let go after a hold-up remembers how you treated them. Treated well, they may put in a good word or their crew may offer to join you; robbed or hurt, they may warn everyone or their squad may come after you. Killing someone who surrendered costs extra standing and brings revenge.
        Mercy_Enabled = true,

        -- A-Life only saves squads and a few outposts. Promoted keeps crews you've interacted with; All keeps every living NPC. Default = Promoted crews
        -- 1 = A-Life default
        -- 2 = Promoted crews
        -- 3 = All living NPCs
        Persist_Mode = 2,

        -- Min: 0 Max: 500 Default: 150
        Persist_Cap = 150,

        -- Once an outpost has been manned it no longer expires of old age; it falls only when its garrison is wiped out. One that is never built or manned still expires as in A-Life. Scripted events are unaffected.
        Outposts_Permanent = true,

        -- When a player talks to (or fights) an encounter crew, it becomes a real squad: it lives on off-screen, travels and scavenges, and is saved with the world. Uses a roaming-squad slot.
        Promote_Enabled = true,

        -- A crew you fight carries on as a real squad - whether you hit them first or they opened fire on you. Survivors remember it through faction reputation.
        Promote_OnFight = true,

        -- A crew that robs you and walks away carries on as a real squad you may meet again.
        Promote_OnRobbery = true,

        -- A-Life fills its roaming-squad cap quickly in a new world. Crews you interact with can still be promoted past it, up to this many at once. Min: 0 Max: 50 Default: 10
        Promote_MaxExtra = 10,

        -- Off-screen squads head to an outpost of their own faction and join its garrison; they appear there the next time you're nearby. Calls for help are answered by the outpost's own faction. Fewer groups roam as a result.
        Homes_Enabled = true,

        -- Per squad, per game hour, when an outpost of its faction has room nearby. Doubled when the garrison is under half strength. Min: 0 Max: 100 Default: 4
        Homes_JoinChance = 4,

        -- Squads only consider outposts within this distance. Calls for help reach any distance. Min: 100 Max: 5000 Default: 900
        Homes_JoinRadius = 900,

        -- A small squad (3 or fewer) with no outpost of its own nearby may move in with a friendly peaceable faction, like a lone nurse joining a family. They keep their own faction.
        Homes_Mixed = true,

        -- This share of squads never settle down or join an outpost. Min: 0 Max: 100 Default: 30
        Homes_NomadShare = 30,

        -- For squads of 1-3 whose faction has no outpost nearby. The home (a holdout, forest camp or held house, whatever the faction uses) is placed when a player is 60-150 tiles from their town, never within 40 tiles of a player, never in a base area or a building a player has been in. Min: 0 Max: 100 Default: 2
        Homes_FoundChance = 2,

        -- Real garrison members leave to scavenge or patrol and come back (or don't). Replaces A-Life's outpost squads, which appear from nowhere and never return. Members only leave while no player is within 120 tiles, and the garrison never drops below its minimum.
        Expeditions_Enabled = true,

        -- Outposts spend supplies from expeditions (and a little foraging) to add a supply crate and campfire, then a fence with a gate at the main door, then take over a neighbouring building. Only placed while no player is within 40 tiles. The main entrance is never blocked.
        Growth_Enabled = false,

        -- When an outpost's garrison is wiped out, its barricades, fences, crates (and their loot) stay standing instead of vanishing. New groups prefer to settle in ruins of a type their faction uses.
        Ruins_Keep = true,

        -- When A-Life's groups fight each other away from players, the fallen are left where it happened, dressed as who they were. Bodies appear the next time a player comes within about 110 tiles (never within 40, never in a base area).
        WarDead_Enabled = true,

        -- Away from players, a group may attack an outpost of a faction it's hostile to (A-Life's own faction stances; peaceable factions never do). Fences and buildings help defenders. Outposts that lose everyone fall and leave ruins, and the attackers may move in.
        Sieges_Enabled = true,

        -- Per eligible group and outpost within 80 tiles. Each outpost can be attacked at most every 2 days. Min: 0 Max: 100 Default: 15
        Sieges_Chance = 15,

        -- Across the whole map. 0 turns sieges off. Min: 0 Max: 50 Default: 3
        Sieges_PerDay = 3,

        -- An outpost whose faction counts a player as Friendly defends this much better in off-screen sieges. Min: 0 Max: 200 Default: 15
        Sieges_FriendlyBonus = 15,

        -- The same, for a faction that counts a player as Allied. Min: 0 Max: 200 Default: 30
        Sieges_AlliedBonus = 30,

        -- Each gun given to an outpost goes to one of its guards, with some of its ammo; they carry it the next time they spawn and drop it if killed.
        ArmedGuards_Enabled = true,

        -- Give NPCs longer before a path counts as stuck, and before they give up. Turn off for a baseline session.
        Tuning_Enabled = true,

        -- How long without progress before a move counts as stalled. A-Life default 800. Min: 500 Max: 10000 Default: 800
        Tuning_StallMs = 800,

        -- Time allowed for the pathfinder to start moving. A-Life default 1600. Min: 1000 Max: 20000 Default: 1600
        Tuning_StartupGraceMs = 1600,

        -- A-Life default 3. Min: 1 Max: 20 Default: 3
        Tuning_MaxStalls = 3,

        -- Checks (every 0.5s) before a player's game lets go of an NPC it no longer owns. Higher means fewer resets when players move near each other. A-Life default 3. Min: 1 Max: 40 Default: 8
        Tuning_OwnershipLossReads = 8,

        -- When deciding whether a roaming squad may appear, ignore encounter crews and camps.
        Crowding_SquadsOnly = true,

        -- In multiplayer, when a different player's game takes over an NPC, it resumes chasing or searching where the last owner left off instead of forgetting.
        Handoff_Enabled = true,

        -- Fixes for bugs inside A-Life itself. NPCs are put away before the area around them unloads, so they don't come back as zombies (single player and servers). In multiplayer, NPCs left frozen are rebuilt. NPCs inside a building can unlock its key-locked doors, as a player there could, and knock broken glass out of a window before climbing through. On servers, zombies no longer drop masks and hats they aren't wearing (clothing left on reused zombie bodies). Also removes an error that filled the log. Off brings these bugs back.
        AlifeFixes_Enabled = true,

        -- A zombie the game creates inside a base's main building or quarters, or on an upper floor anywhere in a base, as the area loads or the zombie population fills it, is removed in the moment it is made, before anyone sees it. Zombies that walk in, and people or NPCs who turn inside, are never touched: only the game's own new zombies are. Zombies spawned there by an admin or another mod are removed too. Needs Fix A-Life bugs on. Off by default.
        AlifeFixes_NoZombiesInBase = false,

        -- Instead of chasing every zombie in sight, NPCs fight zombies that are close, coming for them, their allies or a player they're friendly with, or at their outpost or post. They stay calmer and will stop to talk.
        ZombieFocus_Enabled = true,

        -- Zombies closer than this are always fought. A-Life's own range is 16-21+ tiles. Min: 2 Max: 30 Default: 8
        ZombieFocus_Radius = 8,

        -- Unless attacked or holding a grudge, NPCs won't start fights when outgunned, low on ammo against an armed target, or surrounded by zombies (gunfire would draw them). Against zombies they switch to melee when the dead are thick around or ammo is low.
        Discretion_Enabled = true,

        -- A-Life infects and turns bitten NPCs by its own Mortality and Transmission settings. This adds a Bitten tag and the infection moodles, sets how often one zombie bites, and, where A-Life's own wounds are off, has an infected NPC die when their time comes.
        ZombieBites_Enabled = true,

        -- How long each zombie waits before biting the same NPC again. A-Life's own is 4.5; it lets up to 8 zombies bite one NPC at once. Min: 0.50 Max: 10.00 Default: 3.50
        ZombieBites_BiteGap = 3.5,

        -- Hits leave wounds on body parts: scratches, lacerations, deep wounds, bites, bullet wounds, bruises and fractures, depending on what hit them. Wounds bleed until bandaged or clotted, heal over days, and show on the hover tag.
        Injuries_Enabled = true,

        -- A broken or badly hurt leg makes them limp, and hurt arms make them aim worse, until healed or treated.
        Injuries_Effects = true,

        -- How fast open wounds drain health. 0: wounds never bleed. At 100 an untreated bullet wound kills in about six minutes. Min: 0 Max: 300 Default: 100
        Injuries_BleedRate = 100,

        -- At 100 a scratch heals in about two days, a bullet wound in about ten, a fracture (with a splint) in about forty. Min: 10 Max: 1000 Default: 100
        Injuries_HealSpeed = 100,

        -- Right-click a hurt NPC who isn't hostile to you (or has surrendered to you) to bandage, stitch or splint their wounds with your own supplies. Gives First Aid experience, and a little standing with their faction and crew.
        Injuries_Treatment = true,

        -- A bleeding NPC who isn't fighting bandages the wound with their own kit, even on guard or under orders; a resident fighting zombies stops to do it once none is close. With nothing left they call out when someone can come or hear them, and the nearest crewmate or fellow resident with a bandage (a medic first) comes over and does it. One dressing per wound.
        Injuries_SelfCare = true,

        -- Tops up each NPC's first aid when they appear. A-Life gives most 1-2 (medics 4). 0 leaves A-Life's own. Min: 0 Max: 10 Default: 3
        Injuries_Bandages = 3,

        -- Open wounds that aren't disinfected can get infected (not the zombie infection): they heal at a quarter of the speed and hurt more until disinfected. Alcohol bandages disinfect as they go on.
        Injuries_WoundInfection = true,

        -- A-Life spares NPCs from fall damage. With this on, a fall of a floor bruises or breaks a leg, two floors most likely break one, and three or more mean bad breaks and real harm.
        Injuries_Falls = true,

        -- NPCs on fire build up burns: painful, slow to heal and prone to infection. Treat them by disinfecting and bandaging.
        Injuries_Burns = true,

        -- With nothing bleeding, an NPC's health slowly comes back (about a day to full), held back by wounds that haven't healed yet. A-Life has no recovery of its own.
        Injuries_Regen = true,

        -- A resident with the Medic specialty walks over to wounded residents of their base, downed ones first, then the worst bleeding, and treats them with supplies from the base's Medical store (bandage, disinfect, stitch, splint, take a bullet out). Players of the base can call them too: right-click Call the medic, or Medic! in a conversation. During the base alarm they only treat people under a roof.
        Injuries_MedicRounds = true,

        -- NPCs near you and your residents have needs, shown in Medical Check and on the hover tag when pressing. Residents eat and drink at a base with food and sleep at night (in their Sleep shift where shifts go by the schedule); NPCs away from you look after themselves. Food and drink you hand them help; so does a drink for their nerves. Wounds, losing crewmates and being held up stress them.
        Needs_Enabled = true,

        -- Tired NPCs can't sprint; very hungry, thirsty, exhausted or panicked ones aim worse; starving or dehydrated residents slowly lose health (anyone else gets by on their own supplies), and wounds heal at half speed. Stressed or panicked NPCs give up more easily when held up.
        Needs_Effects = true,

        -- At 100 an NPC with no food gets hungry in about a day; a resident at a base with no food starves in under two. Thirst is a little faster. Min: 10 Max: 500 Default: 100
        Needs_Rate = 100,

        -- Now and then an NPC near you says something about their most pressing moodle: hunger, thirst, tiredness, stress, pain, drink, sickness, grief or the infection taking hold. Never in a fight.
        Needs_Lines = true,

        -- An NPC near you says something when they change course: backing off from a fight that isn't worth it (and why: the odds, the noise, their ammo), deciding it's on after all when you come too close, or stepping in to protect you or their base. At most once every 45 seconds each.
        Intent_Lines = true,

        -- Off: NPCs never get hungry (no moodle, no effects).
        Needs_Hunger = true,

        -- Off: NPCs never get thirsty (no moodle, no effects).
        Needs_Thirst = true,

        -- Off: NPCs never get tired (no moodle, no sprinting limits).
        Needs_Fatigue = true,

        -- Coffee, tea, Vitamins, coffee beans or a cola handed to an NPC makes them less tired, and residents on watch take one from a base Food or Medical store when tired. Each dose works less while the last is still in them, part of the tiredness comes back as it wears off, and too much makes them jittery. Needs tiredness on.
        Needs_Caffeine = true,

        -- Off: no stress from wounds, losses or hold-ups (no moodle, no effect on aim or surrendering).
        Needs_Stress = true,

        -- Off: alcohol you hand over still calms them but never gets them drunk.
        Needs_Drunk = true,

        -- Off: living near bodies doesn't sicken NPCs (no smell or sickness moodles, no effects).
        Needs_CorpseSickness = true,

        -- Residents mourning a crewmate are Depressed, then Unhappy, then Sad over three days, and stay a little stressed. Off: no moodle or stress (they still mourn).
        Needs_Grief = true,

        -- Shows A-Life's own fear and panic as moodles. Display only: A-Life acts on them either way.
        Needs_Fear = true,

        -- Bitten NPCs go Unwell, Feverish, Delirious and Zombified as they near turning, getting weaker. Off: no moodle or weakness (they still turn).
        ZombieBites_Stages = true,

        -- Lets an admin run Debug > Self-test > Scenario test in single player: it builds a base, spawns a crew, zombies and a hostile group, and changes the world for good. Only tick this on a world made for testing.
        Scenario_Allow = false,

        -- Off hides the [A-Life Jimmy] entry of the right-click menu for everyone, admins and -debug games included, and its Debug (admin) tools go with it until it is back on. Each player can also hide it just for themselves in Options > Mods. Trade, Medical Check and the other entries outside it stay. With it hidden: the faction window opens from the people button in the sidebar (its Bases section has the tools for land, buildings, guard posts, stores and the body dump, and the Show bases on the ground tick box), NPC safety from its sidebar button or the faction window, and you invite someone to your nearest base by talking to them (Come live at our base). Only in this menu: the Status panel, door and window marks, letting someone who surrendered go (Q still makes them drop their weapon and empty their pockets), sending a whole base crew away at once (People > Actions sends one at a time) and inviting someone to a base other than your nearest.
        ContextMenu_Show = false,

        -- Shows Debug (admin) in the [A-Life Jimmy] right-click menu in single player: admin tools for testing (self-test, spawning, sieges, traders). Off, it shows only in a -debug game, on a test world (the scenario test option, or a save with the word test in its name), and to admins in multiplayer.
        Debug_Menu = false,

        -- Write A-Life counters (ownership handoffs, movement stalls, squads, saves) to the server log as [ALIFE-JIMMY] diag lines.
        Diagnostics_Enabled = true,

        -- Min: 1 Max: 60 Default: 5
        Diagnostics_IntervalMinutes = 5,

        -- With your safety on, hitting, shooting or shoving one of your own people (see Who safety protects) does nothing (no damage, no anger). Multiplayer uses the game's own safety button (server option SafetySystem); single player gets a safety button in the left sidebar.
        NpcSafety_Enabled = true,

        -- With your safety on, which NPCs your hits can't hurt. People hostile to you can always be hurt. Default = Your residents and allies
        -- 1 = Your residents
        -- 2 = Your residents and allies
        -- 3 = Anyone not hostile to you
        NpcSafety_Who = 2,

        -- Multiplayer. On: a faction's leader can set their people (residents and parties) to treat every player outside the faction as hostile (My people > Reputation). The server's PvP setting, safehouses and non-PvP zones still apply, and faction members are never targets. Off: the switch is greyed out.
        HostileFactions_Allow = false,

        -- To the game an NPC is a zombie, so any NPC near you means "Not safe to sleep here", fast-forward dropping to normal speed, search mode switching off, panic when one walks into view, and the jump-scare sound when one steps out right beside you. With this on, NPCs who aren't hostile to you no longer do any of that. Zombies in view, hostile NPCs within 20 tiles and anyone attacking or robbing you still stop you resting; a zombie or a hostile NPC coming into view still panics you, and one stepping out beside you still plays the sound. Followers also stand back while you sit, rest or sleep. Fast-forward is single player only; on a server the panic part runs on the server. Off: the game's own rules.
        RestNearNpcs_Enabled = true,

        -- A-Life 1.4 draws a random name for every NPC unless their NPC Creation preset's NPC name is Set name. On, a preset you made yourself that has no name setting (every preset made before 1.4, and Random name, which A-Life saves the same way) names its people with its Display name, as before 1.4, in our tags and windows and, for your residents, in A-Life's too. Off, or a preset set to Random male name or Random female name: A-Life's random names.
        Names_CreatorDisplayName = true,

        -- Hover the mouse over an NPC to see their name above their head, coloured by how they feel about you.
        NpcTags_Names = true,

        -- Adds a [TAG] (the faction's initials) before the name, so you can tell who belongs to which faction.
        NpcTags_Factions = true,

        -- A skull in front of the label of anyone hostile to you, even if they seem friendly.
        NpcTags_Hostile = true,
    },
    CDAJCompatPatch = {

        -- Which A-Life NPCs your dogs may attack, judged by how they feel towards the dog's owner. Each level also includes the more hostile ones. Jeem base residents are never attacked. Default = Hostile only
        -- 1 = Hostile only
        -- 2 = Hostile and Careful
        -- 3 = Hostile, Careful and Neutral
        -- 4 = Everyone (including Friendly)
        -- 5 = Never attack A-Life NPCs
        DogTarget = 1,
    },
    RainCleansBlood = {

        -- How many random tiles near each player to check and clean per in-game minute. Min: 10 Max: 2000 Default: 300
        TilesPerMinuteNearPlayer = 300,

        -- How heavy the rain or snow must be before blood starts washing away. Higher = needs heavier weather. Min: 0.05 Max: 0.95 Default: 0.25
        WeatherThreshold = 0.25,

        -- Also clean ash left behind by burned corpses.
        AlsoCleanAsh = true,

        -- Also clean animal droppings (dung) left on the ground.
        AlsoCleanDroppings = true,

        -- Also clean blood inside buildings.
        AlsoCleanInside = false,

        -- Also gradually clean blood from vehicles.
        AlsoCleanVehicles = true,

        -- How much blood to remove from vehicles per minute. Min: 0.10 Max: 1.00 Default: 0.10
        VehicleCleanSpeed = 0.1,

        -- Also gradually clean blood and dirt from players' worn clothing.
        AlsoCleanClothes = true,

        -- How much blood and dirt to remove from clothing per minute. Min: 1.00 Max: 10.00 Default: 1.00
        ClothesCleanSpeed = 1.0,

        -- Always clean regardless of weather.
        AlwaysClean = false,
    },
    TooManyEmotes = {

        -- While a player's emote plays music or another sound, zombies within the radius below hear it.
        MusicAttractsZombies = false,

        -- In tiles. Used when emote sounds attract zombies. Min: 1 Max: 100 Default: 20
        MusicNoiseRadius = 20,
    },
    ThisIsYourLife = {

        -- Grant hometown map knowledge, local bonuses, skill levels, and home-ground effects. Disabling this does not remove the postcard pages or chosen spawn town.
        EnableOriginTraits = true,

        -- Begin with a hand-authored story opening when one is available for the selected origin. Story Starts are currently single-player only.
        EnableScriptedStarts = false,

        -- Enable the Survivor Journal, milestones, health record, diary entries, and preserved journals left on death.
        EnableSurvivorJournal = true,

        -- Enable contextual character thoughts and reactions. When disabled, the module performs no recurring background checks.
        EnableThisIsYourVoice = false,

        -- Skip the profession, trait, and appearance screens after choosing your postcard. You'll start as Unemployed with a randomised appearance. The postcard/map screen is never skipped.
        QuickStart = false,

        -- Show a brief popup notice whenever a milestone is reached. Turning this off still records milestones in the Survivor Journal, it just stops the on-screen notice.
        EnableMilestonePopups = true,

        -- Use This Is Your Life's redesigned profession and trait selection screens. Turning this off shows the vanilla profession and trait screens instead, after choosing your postcard.
        EnableCustomProfession = true,

        -- Use This Is Your Life's redesigned appearance screen. Turning this off shows the vanilla appearance screen instead. The postcard/map screen is never skipped.
        EnableCustomAppearance = true,
    },
    BetterCorpseBurning = {

        -- Time in game minutes to burn one corpse. Default: 110 (vanilla value). Min: 10 Max: 600 Default: 110
        TimePerCorpse = 110,

        -- Remove the vanilla 'Burn Corpse' option that requires petrol.
        RemoveVanillaBurn = true,

        -- When a corpse burns, nearby corpses within this radius also catch fire. 0 = disabled. Min: 0 Max: 5 Default: 4
        FireSpreadRadius = 4,

        -- When enabled, burning corpses also requires a petrol can (gasoline) in addition to a fire source.
        NeedPetrol = true,

        -- How much petrol (in litres) is consumed per corpse burned. Default: 0.1L (a 10L can burns ~100 corpses). Min: 0.01 Max: 1.00 Default: 0.10
        PetrolPerBurn = 0.1,

        -- When enabled, burning corpses also requires alcohol (Whiskey, Vodka, Wine) in addition to a fire source.
        NeedAlcohol = true,

        -- How much alcohol (in litres) is consumed per corpse burned. Default: 0.2L. Min: 0.01 Max: 2.00 Default: 0.20
        AlcoholPerBurn = 0.2,

        -- When enabled, burning corpses also requires Cologne in addition to a fire source.
        NeedCologne = true,

        -- How much cologne (in litres) is consumed per corpse burned. Default: 0.05L. Min: 0.01 Max: 2.00 Default: 0.05
        ColognePerBurn = 0.05,

        -- When disabled, corpses inside buildings cannot be burned with this mod. Prevents accidental fires damaging wooden structures. Default: enabled.
        AllowIndoorBurn = true,

        -- How many times the fire source is used per corpse burned. Higher values drain lighters and matches faster. 0 = unlimited (the fire source never drains). Default: 1. Min: 0 Max: 20 Default: 1
        FireUsesPerCorpse = 1,

        -- When enabled, the fire automatically goes out shortly after all corpses in the chain have caught fire. Protects wooden structures from lingering flames. Default: disabled.
        AutoExtinguishWhenDone = false,

        -- When enabled, burned corpses leave no ash pile behind. Default: disabled.
        NoAshRemains = false,

        -- How fast fire spreads between corpses. Lower = faster. Default: 150 frames (~5s per tile). Recommended: 150 for singleplayer, 50-80 for co-op/multiplayer. Min: 30 Max: 500 Default: 150
        FireSpreadSpeed = 150,
    },
    KnoxWildlife = {

        -- Hungry coyotes eat zombie corpses after 12 uninterrupted seconds of feeding. The corpse and ALL clothing and loot inside it are permanently removed. Player corpses are excluded. On by default.
        CoyotesEatCorpses = true,

        -- Allow new black bear migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableBlackBear = true,

        -- Allow new brown bear migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableBrownBear = true,

        -- Allow new coyote migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableCoyote = true,

        -- Allow new elk migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableElk = true,

        -- Allow new bobcat migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableBobcat = true,

        -- Allow new wild boar migration groups. Existing animals remain. Restart the world/server after changing this option.
        EnableBoar = true,

        -- Adult bears, coyotes, bobcats and wild boars attack nearby zombies. Elk and all young animals keep fleeing. Off by default. Adult bears also attack visible players within 20 tiles, independently of this option.
        AggressiveToZombies = false,
    },
    VPBinoculars = {

        -- Default = Normal
        -- 1 = Rare
        -- 2 = Normal
        -- 3 = Common
        LootFrequency = 2,

        MilitaryEnabled = true,

        HoldToLook = false,
    },
    FastForward = {

        -- Will allow you to force other players to select same speed.
        AllowForce = true,

        -- Will allow to force only for admins.
        ForceAdminOnly = true,

        -- Default = Build 42
        -- 1 = Build 41
        -- 2 = Build 42
        IconStyle = 2,
    },
    TrueSleep = {

        -- How much faster a solo napper rests compared to world time. 7 means a full night of rest fits into roughly one in-game hour. Min: 1.00 Max: 60.00 Default: 14.00
        SleepSpeed = 14.0,

        -- Solo naps cannot reduce fatigue below this remainder. Full rest is reserved for a proper night when everyone sleeps. Min: 0 Max: 90 Default: 15
        NapFloorPercent = 15,

        -- The server keeps restoring sleepers at normal speed on its own. With this on, Solo nap speed means the total rest speed instead of stacking on top of vanilla.
        CompensateVanilla = true,

        -- Min: 0.00 Max: 10.00 Default: 1.00
        EnduranceMult = 1.0,

        -- Automatically wake a solo napper once they hit the nap limit.
        WakeWhenRested = true,

        -- Small 'Sleeping 2/4' indicator with go-to-bed notifications.
        ShowHud = true,

        -- Min: 0.10 Max: 2.00 Default: 0.60
        FloorMult = 0.6,

        -- Min: 0.10 Max: 2.00 Default: 0.90
        BadBedMult = 0.9,

        -- Min: 0.10 Max: 2.00 Default: 1.00
        AverageBedMult = 1.0,

        -- Min: 0.10 Max: 2.00 Default: 1.10
        GoodBedMult = 1.1,

        -- Min: 0.00 Max: 0.50 Default: 0.05
        PillowBonus = 0.05,
    },
    ActualDoorRattling = {

        -- Animate supported closed doors in Viewpoint. Visual only; does not change door damage or collision.
        Enabled = true,

        -- Movement multiplier: 0 = off, 1 = original strength, 2 = twice the movement. Lower values give a subtler effect. Min: 0.00 Max: 2.00 Default: 1.00
        Strength = 1.0,

        -- Also follow the game's existing door contact effects, such as zombies pushing against a door. Turn off to use captured zombie strikes only; multiplayer clients may receive native effects without local strike callbacks.
        NativeMotion = true,

        -- Flex supported three-section garage doors together, keeping the outer edges fixed. Incomplete or incompatible geometry is skipped. Does not change opening animations.
        GarageDoors = true,
    },
    TienCoolers = {

        -- How much of a working refrigerator's cooling an iced cooler manages. 1 makes it the equal of a fridge, 0.5 gets it half way there, and 0 means the ice does nothing at all. It is measured against whatever your Refrigeration Effectiveness setting gives a real fridge, so the two move together; at the default 0.5 and Normal refrigeration, food in a cooler rots at 0.6 of its usual speed. A cooler is never allowed to beat a fridge, which is why the scale stops at 1. Min: 0.00 Max: 1.00 Default: 0.50
        CoolStrength = 0.5,

        -- In-game hours one full bag of ice lasts inside a cooler at 20 C. Hot weather burns through it faster, cold weather slower. Min: 1.00 Max: 1000.00 Default: 48.00
        IceLifeHours = 48.0,

        -- Multiplier applied to ice lifetime when the ice is not in a cooler. 0.2 means it melts five times faster in a backpack. Min: 0.01 Max: 1.00 Default: 0.20
        IceLifeOutsideMult = 0.2,

        -- In-game hours a powered freezer needs to turn water into ice, and to refill a melted bag of ice. With Reworked Ice on, it is the time water set to freeze takes to turn to ice, however much of it there is. Min: 0.25 Max: 72.00 Default: 7.00
        FreezeHours = 7.0,

        -- Units of water consumed per bag of ice produced. Water pools across every container set to freeze in the same fridge, so several small ones can add up to a bag. For scale, a bottle holds 1 unit and a bucket 10. With Reworked Ice on, a full bag of ice also weighs as much as this much water, plus the bag. Min: 0.10 Max: 10.00 Default: 5.00
        WaterPerBag = 5.0,

        -- Beta feature, off by default. Makes ice behave like the water it is made of. Tainted water freezes into a Bag of Ice (Tainted), which cools food just as well but melts into tainted water, and a clean bag topped up with tainted water becomes tainted. Each new bag of ice needs an empty plastic bag or garbage bag in the freezer, given back when the ice is used up. A bottle, pot or other water container inside a cooler can be set to catch the water from the ice melting beside it. Water set to freeze turns to ice a little at a time, filling one bag before starting the next, and water short of a full bag makes a partly filled one. A melted bag fills up again only from water set to freeze beside it, and a bag weighs as much as the water in it. When off, the mod plays as it always has.
        ReworkedIce = true,

        -- Lets the vanilla Cold Pack chill a cooler too, at the strength set below.
        UseColdpacks = true,

        -- How much cooling one Cold Pack is worth, where 1 is a full bag of ice. 0 turns them off, the same as the switch above. Min: 0.00 Max: 1.00 Default: 0.40
        ColdpackPower = 0.4,

        -- Adds bags of ice to freezer loot. Turn off to make freezing your own water the only source.
        SpawnIceInLoot = true,

        -- Chills the items in an iced cooler so the inventory window tints their rows blue, the same cue a powered fridge gives. Turn off to leave item temperature alone.
        ShowColdTint = true,

        -- Adds (Iced) to the name of a cooler that currently holds ice.
        RenameCoolers = true,
    },
    VisibleDoorDamage = {

        -- Enables test tools in the right-click menu. In multiplayer, access remains restricted to administrators. Disabled by default.
        EnableTestMenu = false,
    },
}
