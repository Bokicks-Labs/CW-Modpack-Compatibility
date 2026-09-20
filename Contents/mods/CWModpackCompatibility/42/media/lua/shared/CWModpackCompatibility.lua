CWModpackCompatibility = CWModpackCompatibility or {}

local Compat = CWModpackCompatibility
Compat.version = "1.1.11"

local function isActive(modID)
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains(modID)
end

local function log(message)
    print("[CWModpackCompatibility] " .. tostring(message))
end

-- TABAS ships the named multiplayer constructor as of its September 7 update.
-- Keep its current implementation instead of wrapping the upstream fix.

local function applyGaelWeaponPartFix()
    if not isActive("GaelGunStore_B42") then return end

    require("TimedActions/ISRemoveWeaponUpgrade")
    if not ISRemoveWeaponUpgrade or not ISRemoveWeaponUpgrade.complete then return end
    if ISRemoveWeaponUpgrade.__cwSafeMissingPartComplete then return end

    local moddedComplete = ISRemoveWeaponUpgrade.complete

    ISRemoveWeaponUpgrade.complete = function(self, ...)
        if not self or not self.weapon or not self.partType then
            log("Skipped invalid weapon-upgrade removal completion with missing action data.")
            return true
        end

        local ok, part = pcall(self.weapon.getWeaponPart, self.weapon, self.partType)
        if not ok or not part then
            -- The authoritative server may receive a duplicate/stale completion
            -- after the part has already disappeared. Vanilla passes nil to
            -- Inventory:AddItem, and Gael's wrapper cannot restore hand state
            -- because that exception escapes. Treat the stale completion as an
            -- idempotent success instead.
            log("Skipped stale weapon-upgrade removal; the requested part is no longer attached.")
            return true
        end

        return moddedComplete(self, ...)
    end

    ISRemoveWeaponUpgrade.__cwSafeMissingPartComplete = true
    log("Applied Gael Gun Store safe weapon-part completion fix.")
end

local function installNaturesCallSessionClockFix()
    if not isActive("NC_NaturesCall") then return end

    require("NaturesCall/NC_State")
    require("NaturesCall/NC_System")
    if not NaturesCall or not NaturesCall.State or not NaturesCall.System then return end

    local State = NaturesCall.State
    local System = NaturesCall.System
    local Utils = NaturesCall.Utils
    if not State.resetSessionUpdateTimestamps or not System.runCatchUp or not Utils then return end
    if System.__cwFreshSpawnClockGuard then return end

    local naturesCallRunCatchUp = System.runCatchUp

    System.runCatchUp = function(player)
        local nc = player and State.ensurePlayerData(player) or nil
        local nowHours = Utils.getWorldAgeHours()
        local previousHours = nc and tonumber(nc.lastUpdateHours) or nil
        local hoursSurvived = player and tonumber(player:getHoursSurvived()) or nil
        local activeSessionLimit = tonumber(State.ActiveSessionMaxDeltaHours) or 0.25

        -- Nature's Call can first create a fresh character's timestamps while
        -- worldAgeHours is still 0. Its first pre-OnGameStart player update then
        -- sees the real day-one clock (~24h) and treats the startup discontinuity
        -- as elapsed play time. Intercept that first catch-up before it can fill
        -- the needs or roll an accident. The fresh-character and pristine-meter
        -- checks keep saved characters and legitimate needs untouched.
        local isFreshCharacter = hoursSurvived ~= nil and hoursSurvived <= 0.1
        local hasPristineNeeds = nc
            and (tonumber(nc.bladderFill) or 0) <= 0
            and (tonumber(nc.bowelFill) or 0) <= 0
        local startupDelta = previousHours and (nowHours - previousHours) or 0

        if isFreshCharacter and hasPristineNeeds and startupDelta > activeSessionLimit then
            State.resetSessionUpdateTimestamps(player)
            log(string.format(
                "Skipped Nature's Call fresh-spawn clock jump (previous=%.3f, now=%.3f, survived=%.3f).",
                previousHours,
                nowHours,
                hoursSurvived
            ))
        end

        return naturesCallRunCatchUp(player)
    end

    System.__cwFreshSpawnClockGuard = true
    log("Installed Nature's Call fresh-spawn clock guard.")
end

local function applyNaturesCallWashFix()
    if not isActive("NC_NaturesCall") then return end

    require("TimedActions/ISWashClothing")
    require("NaturesCall/NC_BodyWash")
    if not ISWashClothing or not ISWashClothing.new then return end
    if ISWashClothing.__cwSafeNaturesCallWash then return end

    local naturesCallNew = ISWashClothing.new
    local naturesCallComplete = ISWashClothing.complete
    local naturesCallGetRequiredSoap = ISWashClothing.GetRequiredSoap
    local naturesCallGetRequiredWater = ISWashClothing.GetRequiredWater

    -- NetTimedAction serializes constructor parameters by name. Keep a
    -- primitive item ID alongside the normal InventoryItem reference so the
    -- server can recover the clothing if that reference fails to resolve.
    function ISWashClothing:new(character, sink, item, bloodAmount, dirtAmount, noSoap, itemId)
        if not item and character and itemId then
            item = character:getInventory():getItemById(itemId)
        end

        local action = naturesCallNew(
            self,
            character,
            sink,
            item,
            bloodAmount,
            dirtAmount,
            noSoap
        )
        if action then
            action.itemId = item and item:getID() or itemId
        end
        return action
    end

    ISWashClothing.GetRequiredSoap = function(item)
        if not item then return 0 end
        return naturesCallGetRequiredSoap(item)
    end

    ISWashClothing.GetRequiredWater = function(item)
        if not item then return 0 end
        return naturesCallGetRequiredWater(item)
    end

    ISWashClothing.complete = function(self, ...)
        if self and not self.item and self.character and self.itemId then
            self.item = self.character:getInventory():getItemById(self.itemId)
        end
        if not self or not self.item then
            -- The target was genuinely removed while the action was queued.
            -- Treat that stale completion as finished instead of throwing from
            -- vanilla GetRequiredWater/getBloodLevel with a nil item.
            log("Skipped stale Nature's Call clothing-wash completion; target item no longer exists.")
            return true
        end
        return naturesCallComplete(self, ...)
    end

    ISWashClothing.__cwSafeNaturesCallWash = true
    log("Applied Nature's Call multiplayer clothing-wash recovery fix.")
end

local function applyRuntimeFixes()
    applyGaelWeaponPartFix()
    installNaturesCallSessionClockFix()
    applyNaturesCallWashFix()
end

-- Install during shared-Lua loading. OnGameStart is too late: Nature's Call can
-- run its first player update during the loading-state transition at frame 0.
installNaturesCallSessionClockFix()

if Events.OnGameStart then
    Events.OnGameStart.Add(applyRuntimeFixes)
end

if Events.OnServerStarted then
    Events.OnServerStarted.Add(applyRuntimeFixes)
end
