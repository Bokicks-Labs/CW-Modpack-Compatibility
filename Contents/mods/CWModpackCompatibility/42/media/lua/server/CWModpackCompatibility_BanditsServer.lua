-- Multiplayer boundary fixes for Bandits + BanditsWeekOne.
-- Keep these patches opt-in and limited to the affected Bandits command.

CWModpackCompatibility = CWModpackCompatibility or {}

local function isBanditsActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("Bandits2")
end

local function removeAuthoritativeBandit(id)
    if id == nil or not getCell then return false end

    local cell = getCell()
    local zombies = cell and cell:getZombieList()
    if not zombies then return false end

    for i = 0, zombies:size() - 1 do
        local zombie = zombies:get(i)
        if zombie and zombie:getVariableBoolean("Bandit") then
            local rawId = zombie:getPersistentOutfitID()
            local zombieId = BanditUtils.GetZombieID(zombie)
            if rawId == id or zombieId == id then
                zombie:removeFromWorld()
                zombie:removeFromSquare()
                return true
            end
        end
    end

    return false
end

local function installBanditRemovalBoundary()
    if not isBanditsActive() or not BanditServer or not BanditServer.Commands then return end
    if BanditServer.Commands.__cwAuthoritativeBanditRemove then return end

    local originalRemove = BanditServer.Commands.BanditRemove
    if not originalRemove then return end

    BanditServer.Commands.BanditRemove = function(player, args)
        local id = args and args.id
        if id == nil then return end

        -- Remove the server-owned entity before Bandits transmits the brain
        -- deletion, so clients receive one coherent despawn state.
        local removed = removeAuthoritativeBandit(id)
        originalRemove(player, args)
        print("[CWModpackCompatibility][Bandits] BanditRemove id=" .. tostring(id)
            .. " authoritativeEntityRemoved=" .. tostring(removed))
    end

    BanditServer.Commands.__cwAuthoritativeBanditRemove = true
    print("[CWModpackCompatibility][Bandits] Installed authoritative BanditRemove boundary.")
end

installBanditRemovalBoundary()
if Events and Events.OnServerStarted then
    Events.OnServerStarted.Add(installBanditRemovalBoundary)
end
