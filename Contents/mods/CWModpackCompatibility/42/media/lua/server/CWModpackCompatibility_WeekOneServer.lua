-- Dedicated servers do not pass through Week One's variant-selection UI.
-- Repair missing or stale variant keys before clients consume scenario state.

local function isWeekOneActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("BanditsWeekOne")
end

local function resolveWeekOneVariant(value)
    if not BWOVariants then return nil end
    if value ~= nil and BWOVariants[value] then return value end

    local numeric = tonumber(value)
    if numeric and BWOVariants[numeric] then return numeric end

    local requested = value and string.lower(tostring(value)) or "original"
    local fallback = nil
    for id, variant in pairs(BWOVariants) do
        if type(variant) == "table" then
            fallback = fallback or id
            local name = variant.name and string.lower(tostring(variant.name)) or ""
            if name == requested or (requested == "original" and name == "original") then
                return id
            end
        end
    end
    return fallback
end

local weekOneSandboxKeys = {
    "KeyLootNew", "MaximumLooted", "FoodLootNew", "CannedFoodLootNew",
    "LiteratureLootNew", "SurvivalGearsLootNew", "MedicalLootNew",
    "WeaponLootNew", "RangedWeaponLootNew", "AmmoLootNew",
    "MechanicsLootNew", "OtherLootNew", "ClothingLootNew",
    "ContainerLootNew", "MementoLootNew", "MediaLootNew",
    "CookwareLootNew", "MaterialLootNew", "FarmingLootNew", "ToolLootNew",
    "MaximumRatIndex", "SurvivorHouseChance", "VehicleStoryChance",
    "MetaEvent", "LockedHouses", "ZoneStoryChance", "AnnotatedMapChance",
    "MaxFogIntensity", "TrafficJam", "CarSpawnRate", "Helicopter",
    "FireSpread", "ZombieConfig.PopulationMultiplier",
}

local function getSandboxValue(path)
    local value = SandboxVars
    for part in string.gmatch(path, "[^.]+") do
        if type(value) ~= "table" then return nil end
        value = value[part]
    end
    return value
end

local function ensureWeekOneSandbox(gmd)
    gmd.Sandbox = type(gmd.Sandbox) == "table" and gmd.Sandbox or {}
    local repaired = 0
    for _, key in ipairs(weekOneSandboxKeys) do
        if gmd.Sandbox[key] == nil then
            local value = getSandboxValue(key)
            if value ~= nil then
                gmd.Sandbox[key] = value
                repaired = repaired + 1
            end
        end
    end
    return repaired
end

local function ensureWeekOneVariant()
    if not isWeekOneActive() or not GetBWOModData then return end

    local gmd = GetBWOModData()
    if type(gmd) ~= "table" then return end

    local repairedSandbox = ensureWeekOneSandbox(gmd)

    local previous = gmd.Variant
    local resolved = resolveWeekOneVariant(previous)
    local repairedVariant = resolved ~= nil and (previous ~= resolved or not BWOVariants[previous])
    if repairedVariant then
        gmd.Variant = resolved
        print("[CWModpackCompatibility][WeekOne] Repaired server variant "
            .. tostring(previous) .. " -> " .. tostring(resolved) .. ".")
    end
    if repairedSandbox > 0 then
        print("[CWModpackCompatibility][WeekOne] Restored " .. tostring(repairedSandbox)
            .. " missing server sandbox baseline values.")
    end
    if (repairedVariant or repairedSandbox > 0) and TransmitBWOModData then
        TransmitBWOModData()
    end
end

ensureWeekOneVariant()
if Events and Events.OnInitGlobalModData then
    Events.OnInitGlobalModData.Add(ensureWeekOneVariant)
end
if Events and Events.OnServerStarted then
    Events.OnServerStarted.Add(ensureWeekOneVariant)
end
