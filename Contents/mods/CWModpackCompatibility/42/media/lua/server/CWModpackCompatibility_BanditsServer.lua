-- Multiplayer boundary fixes for Bandits + BanditsWeekOne.
-- Keep these patches opt-in and limited to the affected Bandits command.

CWModpackCompatibility = CWModpackCompatibility or {}

local function isWeekOneStackActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods
        and activeMods:contains("Bandits2")
        and activeMods:contains("BanditsWeekOne")
end

local function idsEqual(left, right)
    return left == right or (left ~= nil and right ~= nil and tostring(left) == tostring(right))
end

local function getBrain(id)
    if id == nil or not GetBanditClusterData then return nil end
    local cluster = GetBanditClusterData(id)
    return cluster and cluster[id] or nil
end

local function findAuthoritativeBandit(id)
    if id == nil or not getCell then return nil end

    local cell = getCell()
    local zombies = cell and cell:getZombieList()
    if not zombies then return nil end

    for i = 0, zombies:size() - 1 do
        local zombie = zombies:get(i)
        if zombie then
            local rawId = zombie:getPersistentOutfitID()
            local zombieId = BanditUtils.GetZombieID(zombie)
            if idsEqual(rawId, id) or idsEqual(zombieId, id) then
                local brain = getBrain(id) or getBrain(rawId) or getBrain(zombieId)
                if brain then return zombie, rawId, zombieId end
            end
        end
    end

    return nil
end

local function clearAlternateBrain(id, requestedId)
    if id == nil or idsEqual(id, requestedId) or not GetBanditClusterData then return false end
    local cluster = GetBanditClusterData(id)
    if not cluster or not cluster[id] then return false end
    cluster[id] = nil
    if TransmitBanditCluster then TransmitBanditCluster(id) end
    return true
end

local function installBanditRemovalBoundary()
    if not isWeekOneStackActive() or not BanditServer or not BanditServer.Commands then return end
    if BanditServer.Commands.__cwAuthoritativeBanditRemove then return end

    local originalRemove = BanditServer.Commands.BanditRemove
    if not originalRemove then return end

    BanditServer.Commands.BanditRemove = function(player, args)
        local id = args and args.id
        if id == nil then return end

        -- Remove the server-owned entity before Bandits transmits the brain
        -- deletion, so clients receive one coherent despawn state.
        local zombie, rawId, normalizedId = findAuthoritativeBandit(id)
        local removed = zombie ~= nil
        if zombie then
            zombie:removeFromWorld()
            zombie:removeFromSquare()
        end
        originalRemove(player, args)
        local clearedRaw = clearAlternateBrain(rawId, id)
        local clearedNormalized = clearAlternateBrain(normalizedId, id)
        print("[CWModpackCompatibility][Bandits] BanditRemove id=" .. tostring(id)
            .. " authoritativeEntityRemoved=" .. tostring(removed)
            .. " raw=" .. tostring(rawId)
            .. " normalized=" .. tostring(normalizedId)
            .. " alternateBrainCleared=" .. tostring(clearedRaw or clearedNormalized))
    end

    BanditServer.Commands.__cwAuthoritativeBanditRemove = true
    print("[CWModpackCompatibility][Bandits] Installed authoritative BanditRemove boundary.")
end

installBanditRemovalBoundary()
if Events and Events.OnServerStarted then
    Events.OnServerStarted.Add(installBanditRemovalBoundary)
end
