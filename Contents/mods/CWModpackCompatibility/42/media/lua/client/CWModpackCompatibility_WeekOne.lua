CWModpackCompatibility = CWModpackCompatibility or {}

local Compat = CWModpackCompatibility

local emergencyEvents = {
    CallCops = true,
    CallSWAT = true,
    CallMedics = true,
    CallHazmats = true,
}

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
    if repaired > 0 then
        print("[CWModpackCompatibility][WeekOne] Restored " .. tostring(repaired)
            .. " missing sandbox baseline values.")
    end
end

local function ensureWeekOneVariant(key, receivedData)
    if not isWeekOneActive() then return end
    if key and key ~= "BanditWeekOne" then return end

    local gmd = receivedData or (GetBWOModData and GetBWOModData())
    if type(gmd) ~= "table" then return end

    ensureWeekOneSandbox(gmd)

    local previous = gmd.Variant
    local resolved = resolveWeekOneVariant(previous)
    if resolved == nil then return end

    if previous ~= resolved or not BWOVariants[previous] then
        gmd.Variant = resolved
        Compat.weekOneVariantNeedsServerSync = true
        if BWOScheduler then BWOScheduler.Schedule = nil end
        print("[CWModpackCompatibility][WeekOne] Repaired invalid variant "
            .. tostring(previous) .. " -> " .. tostring(resolved) .. ".")
    end

    if Compat.weekOneVariantNeedsServerSync and sendClientCommand and getSpecificPlayer then
        local player = getSpecificPlayer(0)
        if player then
            sendClientCommand(player, "Commands", "SetVariant", {variant = resolved})
            Compat.weekOneVariantNeedsServerSync = false
            print("[CWModpackCompatibility][WeekOne] Synchronized repaired variant with server.")
        end
    end
end

local function installChatStartupGuard()
    if not isWeekOneActive() or not BWOChatPanel or not BWOChatPanel.new then return end
    if BWOChatPanel.__cwStartupGuard then return end

    local originalNew = BWOChatPanel.new
    BWOChatPanel.new = function(self, x, y, width, height, character)
        if not character then
            if not Compat.weekOneEarlyChatLogged then
                print("[CWModpackCompatibility][WeekOne] Ignored chat hotkey before player initialization.")
                Compat.weekOneEarlyChatLogged = true
            end
            return {
                initialise = function() end,
                addToUIManager = function() end,
            }
        end
        return originalNew(self, x, y, width, height, character)
    end

    BWOChatPanel.__cwStartupGuard = true
    print("[CWModpackCompatibility][WeekOne] Installed pre-player chat guard.")
end

local function installEmergencyEventDiagnostics()
    if not isWeekOneActive() or not BWOScheduler or not BWOScheduler.Add then return end
    if BWOScheduler.__cwEmergencyEventDiagnostics then return end

    local originalAdd = BWOScheduler.Add
    BWOScheduler.Add = function(eventName, params, timeout)
        if emergencyEvents[eventName] then
            local x = params and params.x or "?"
            local y = params and params.y or "?"
            print("[CWModpackCompatibility][WeekOne] Scheduled " .. tostring(eventName)
                .. " in " .. tostring(timeout) .. " ms at " .. tostring(x) .. "," .. tostring(y) .. ".")
        end
        return originalAdd(eventName, params, timeout)
    end

    BWOScheduler.__cwEmergencyEventDiagnostics = true
    print("[CWModpackCompatibility][WeekOne] Installed emergency-event diagnostics.")
end

-- BanditsWeekOne's inhabitant path calls the server-only Clan API directly.
-- On a real MP client, forward that request through the normal command path.
local function installInhabitantSpawnBoundary()
    if not isWeekOneActive() then return end
    BanditServer = BanditServer or {}
    BanditServer.Spawner = BanditServer.Spawner or {}
    if BanditServer.Spawner.__cwWeekOneClientBoundary then return end

    BanditServer.Spawner.Clan = function(player, args)
        player = player or (getSpecificPlayer and getSpecificPlayer(0))
        if not player or not args or not args.cid or not sendClientCommand then return end
        sendClientCommand(player, "Spawner", "Clan", args)
    end

    BanditServer.Spawner.__cwWeekOneClientBoundary = true
    print("[CWModpackCompatibility][WeekOne] Routed inhabitant spawns through MP command boundary.")
end

installChatStartupGuard()
installEmergencyEventDiagnostics()
installInhabitantSpawnBoundary()
ensureWeekOneVariant()
Events.OnGameStart.Add(installChatStartupGuard)
Events.OnGameStart.Add(installEmergencyEventDiagnostics)
Events.OnGameStart.Add(installInhabitantSpawnBoundary)
Events.OnGameStart.Add(ensureWeekOneVariant)
Events.OnInitGlobalModData.Add(function() ensureWeekOneVariant() end)
Events.OnReceiveGlobalModData.Add(ensureWeekOneVariant)
