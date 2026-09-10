-- Temporary, observational diagnostics for the Week One MP investigation.
-- This mod must remain opt-in and must not implement compatibility behavior.

require "BanditUtils"

CWBanditsPerfTest = CWBanditsPerfTest or {}

local installed = false
local lastState = {}

local function valueOrUnknown(value)
    if value == nil then return "?" end
    return tostring(value)
end

local function boolFlag(value)
    if value then return "1" end
    return "0"
end

local function trace(event, fields)
    print("[CWTRACE][SERVER][NPC][" .. event .. "] " .. fields)
end

local function playerId(player)
    if not player then return "?" end
    return valueOrUnknown(player:getOnlineID())
end

local function getBrain(id)
    if id == nil then return nil end
    local cluster = GetBanditClusterData(id)
    if not cluster then return nil end
    return cluster[id]
end

local function identityFields(zombie)
    if not zombie then return "object=nil" end
    local raw = zombie:getPersistentOutfitID()
    local normalized = BanditUtils.GetZombieID(zombie)
    local rawBrain = getBrain(raw)
    local normalizedBrain = getBrain(normalized)
    local program = normalizedBrain and normalizedBrain.program or (rawBrain and rawBrain.program or "?")
    return "raw=" .. valueOrUnknown(raw)
        .. " normalized=" .. valueOrUnknown(normalized)
        .. " rawBrain=" .. boolFlag(rawBrain ~= nil)
        .. " normalizedBrain=" .. boolFlag(normalizedBrain ~= nil)
        .. " bandit=" .. boolFlag(zombie:getVariableBoolean("Bandit"))
        .. " program=" .. valueOrUnknown(program)
        .. " x=" .. valueOrUnknown(math.floor(zombie:getX()))
        .. " y=" .. valueOrUnknown(math.floor(zombie:getY()))
        .. " z=" .. valueOrUnknown(math.floor(zombie:getZ()))
end

local function scanAuthoritativeState()
    local cell = getCell()
    if not cell then return end
    local zombieList = cell:getZombieList()
    local banditCount = 0
    local mismatchCount = 0

    for i = 0, zombieList:size() - 1 do
        local zombie = zombieList:get(i)
        if zombie and zombie:getVariableBoolean("Bandit") then
            banditCount = banditCount + 1
            local raw = zombie:getPersistentOutfitID()
            local normalized = BanditUtils.GetZombieID(zombie)
            local rawBrain = getBrain(raw)
            local normalizedBrain = getBrain(normalized)
            if raw ~= normalized then mismatchCount = mismatchCount + 1 end

            local key = valueOrUnknown(normalized)
            local signature = valueOrUnknown(raw)
                .. ":" .. valueOrUnknown(normalized)
                .. ":" .. boolFlag(rawBrain ~= nil)
                .. ":" .. boolFlag(normalizedBrain ~= nil)
            if lastState[key] ~= signature then
                lastState[key] = signature
                trace("STATE", identityFields(zombie))
            end
        end
    end

    trace("SUMMARY", "authoritativeCellBandits=" .. banditCount .. " rawNormalizedMismatches=" .. mismatchCount)
end

local function install()
    if installed then return end
    if not BanditServer or not BanditServer.Spawner or not BanditServer.Commands then
        trace("INSTALL_DEFERRED", "banditServer=" .. boolFlag(BanditServer ~= nil))
        return
    end

    installed = true

    local originalClan = BanditServer.Spawner.Clan
    BanditServer.Spawner.Clan = function(player, args)
        trace("SPAWN_REQUEST",
            "player=" .. playerId(player)
            .. " program=" .. valueOrUnknown(args and args.program)
            .. " cid=" .. valueOrUnknown(args and args.cid)
            .. " size=" .. valueOrUnknown(args and args.size)
            .. " x=" .. valueOrUnknown(args and args.x)
            .. " y=" .. valueOrUnknown(args and args.y)
            .. " z=" .. valueOrUnknown(args and args.z))
        local result = originalClan(player, args)
        trace("SPAWN_RETURN", "player=" .. playerId(player) .. " program=" .. valueOrUnknown(args and args.program))
        return result
    end

    local originalBanditRemove = BanditServer.Commands.BanditRemove
    BanditServer.Commands.BanditRemove = function(player, args)
        local id = args and args.id
        trace("REMOVE_REQUEST",
            "player=" .. playerId(player)
            .. " id=" .. valueOrUnknown(id)
            .. " brainBefore=" .. boolFlag(getBrain(id) ~= nil))
        local result = originalBanditRemove(player, args)
        trace("REMOVE_RETURN",
            "player=" .. playerId(player)
            .. " id=" .. valueOrUnknown(id)
            .. " brainAfter=" .. boolFlag(getBrain(id) ~= nil)
            .. " authoritativeEntityRemoval=0")
        return result
    end

    trace("INSTALLED", "version=0.1.0")
end

Events.OnServerStarted.Add(install)
Events.EveryOneMinute.Add(scanAuthoritativeState)
