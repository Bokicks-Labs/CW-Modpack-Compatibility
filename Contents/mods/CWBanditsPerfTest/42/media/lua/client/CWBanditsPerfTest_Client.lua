-- Temporary, observational diagnostics for the Week One MP investigation.
-- This mod must remain opt-in and must not implement compatibility behavior.

require "BanditUtils"

CWBanditsPerfTest = CWBanditsPerfTest or {}

local installed = false
local activeContext = nil
local contextCandidates = nil
local pendingRemoval = {}
local lastLog = {}
local lastState = {}

local function now()
    return getTimestampMs()
end

local function valueOrUnknown(value)
    if value == nil then return "?" end
    return tostring(value)
end

local function boolFlag(value)
    if value then return "1" end
    return "0"
end

local function playerId()
    local player = getSpecificPlayer(0)
    if not player then return "?" end
    return valueOrUnknown(player:getOnlineID())
end

local function trace(event, fields)
    print("[CWTRACE][CLIENT][NPC][" .. event .. "] player=" .. playerId() .. " " .. fields)
end

local function rateLimited(key, interval)
    local timestamp = now()
    local previous = lastLog[key]
    if previous and timestamp - previous < interval then return true end
    lastLog[key] = timestamp
    return false
end

local function getIdentity(zombie)
    if not zombie then return nil end
    local raw = zombie:getPersistentOutfitID()
    local normalized = BanditUtils.GetZombieID(zombie)
    return raw, normalized
end

local function getBrain(id)
    if id == nil then return nil end
    local cluster = GetBanditClusterData(id)
    if not cluster then return nil end
    return cluster[id]
end

local function identityFields(zombie)
    if not zombie then return "object=nil" end
    local raw, normalized = getIdentity(zombie)
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

local function rememberCandidate(id, zombie)
    if not zombie then return end

    local raw, normalized = getIdentity(zombie)
    if activeContext == "ZOMBIE_LIMIT" then
        local brain = getBrain(id)
        if not zombie:isAlive() or zombie:isReanimatedPlayer() or brain then return end
        if not zombie:getVariableBoolean("Bandit") then return end
    end

    contextCandidates[#contextCandidates + 1] = {
        id = id,
        raw = raw,
        normalized = normalized,
        object = tostring(zombie),
        fields = identityFields(zombie),
        context = activeContext
    }
end

local function finishCandidates()
    local timestamp = now()
    for _, candidate in ipairs(contextCandidates or {}) do
        local key = valueOrUnknown(candidate.normalized)
        pendingRemoval[key] = {
            timestamp = timestamp,
            object = candidate.object,
            context = candidate.context,
            fields = candidate.fields
        }
        local logKey = "remove:" .. candidate.context .. ":" .. key
        if not rateLimited(logKey, 2000) then
            trace("LOCAL_REMOVE_RETURN", "source=" .. candidate.context .. " " .. candidate.fields)
        end
    end
end

local function invokePopulationFunction(context, original, ...)
    activeContext = context
    contextCandidates = {}
    local ok, result = pcall(original, ...)
    activeContext = nil
    finishCandidates()
    contextCandidates = nil
    if not ok then
        trace("EXCEPTION", "source=" .. context .. " error=" .. valueOrUnknown(result))
        error(result)
    end
    return result
end

local function wrapPopulationFunction(name, context)
    local original = BWOPopControl and BWOPopControl[name]
    if not original then
        trace("INSTALL_MISS", "function=BWOPopControl." .. name)
        return
    end

    BWOPopControl[name] = function(...)
        return invokePopulationFunction(context, original, ...)
    end
end

local function onZombieUpdate(zombie)
    if not zombie then return end
    local raw, normalized = getIdentity(zombie)
    local normalizedBrain = getBrain(normalized)
    local rawBrain = getBrain(raw)
    local isBandit = zombie:getVariableBoolean("Bandit")
    local key = valueOrUnknown(normalized)
    local pending = pendingRemoval[key]

    if not isBandit and not normalizedBrain and not rawBrain and not pending then return end

    local program = normalizedBrain and normalizedBrain.program or (rawBrain and rawBrain.program or "?")
    local signature = valueOrUnknown(raw)
        .. ":" .. valueOrUnknown(normalized)
        .. ":" .. boolFlag(rawBrain ~= nil)
        .. ":" .. boolFlag(normalizedBrain ~= nil)
        .. ":" .. boolFlag(isBandit)
        .. ":" .. valueOrUnknown(program)

    if lastState[key] ~= signature then
        lastState[key] = signature
        trace("STATE", identityFields(zombie))
    end

    if pending and now() - pending.timestamp >= 250 then
        pendingRemoval[key] = nil
        trace("SEEN_AFTER_LOCAL_REMOVE",
            "source=" .. pending.context
            .. " sameObject=" .. boolFlag(pending.object == tostring(zombie))
            .. " elapsedMs=" .. valueOrUnknown(now() - pending.timestamp)
            .. " " .. identityFields(zombie))
    end
end

local function onEveryOneMinute()
    local pendingCount = 0
    local cutoff = now() - 60000
    for key, pending in pairs(pendingRemoval) do
        if pending.timestamp < cutoff then
            pendingRemoval[key] = nil
        else
            pendingCount = pendingCount + 1
        end
    end

    local stateCount = 0
    for _ in pairs(lastState) do stateCount = stateCount + 1 end
    trace("SUMMARY", "trackedStates=" .. stateCount .. " pendingLocalRemovals=" .. pendingCount)
end

local function install()
    if installed then return end
    if not BWOPopControl or not BanditZombie or not BanditZombie.GetInstanceById then
        trace("INSTALL_DEFERRED", "weekOne=" .. boolFlag(BWOPopControl ~= nil)
            .. " banditZombie=" .. boolFlag(BanditZombie ~= nil))
        return
    end

    installed = true

    local originalGetInstanceById = BanditZombie.GetInstanceById
    BanditZombie.GetInstanceById = function(id)
        local zombie = originalGetInstanceById(id)
        if activeContext and contextCandidates then rememberCandidate(id, zombie) end
        return zombie
    end

    wrapPopulationFunction("Zombie", "ZOMBIE_LIMIT")
    wrapPopulationFunction("StreetsDespawn", "STREETS_DESPAWN")
    wrapPopulationFunction("InhabitantsDespawn", "INHABITANTS_DESPAWN")
    wrapPopulationFunction("SurvivorsDespawn", "SURVIVORS_DESPAWN")

    local originalInhabitantsSpawn = BWOPopControl.InhabitantsSpawn
    if originalInhabitantsSpawn then
        BWOPopControl.InhabitantsSpawn = function(maximum)
            trace("INHABITANT_SPAWN_CALL",
                "max=" .. valueOrUnknown(maximum)
                .. " banditServer=" .. boolFlag(BanditServer ~= nil)
                .. " spawner=" .. boolFlag(BanditServer and BanditServer.Spawner ~= nil)
                .. " clan=" .. boolFlag(BanditServer and BanditServer.Spawner and BanditServer.Spawner.Clan ~= nil))
            return originalInhabitantsSpawn(maximum)
        end
    end

    trace("INSTALLED", "version=0.1.0")
end

Events.OnGameStart.Add(install)
Events.OnCreatePlayer.Add(install)
Events.OnZombieUpdate.Add(onZombieUpdate)
Events.EveryOneMinute.Add(onEveryOneMinute)
