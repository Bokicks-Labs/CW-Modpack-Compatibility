-- Hotbar definitions can name slots absent from an NPC's attachment group.
-- Check the actual group before entering Java; upstream pcall still logs the
-- Java exception and globally blocks the slot after the invalid call.
local function install()
    local mods = getActivatedMods and getActivatedMods()
    if not mods or not mods:contains("DynamicTradingV2") then return end
    local helpers = DTNPCEquipmentVisuals and DTNPCEquipmentVisuals.Helpers
    if not helpers or not helpers.trySetAttachedItem or helpers.__cwAttachmentGuard then return end

    local original = helpers.trySetAttachedItem
    local reported = {}
    helpers.trySetAttachedItem = function(zombie, slot, item)
        if zombie and slot and tostring(slot) ~= "" and zombie.getAttachedItems then
            local attached = zombie:getAttachedItems()
            local group = attached and attached:getGroup()
            if group and not group:getLocation(tostring(slot)) then
                if not reported[tostring(slot)] then
                    reported[tostring(slot)] = true
                    print("[CWModpackCompatibility][DynamicTrading] Skipped unregistered NPC attachment slot: " .. tostring(slot))
                end
                return false
            end
        end
        return original(zombie, slot, item)
    end
    helpers.__cwAttachmentGuard = true
    print("[CWModpackCompatibility][DynamicTrading] Installed NPC attachment-group guard.")
end

local function repairOutfits()
    local mods = getActivatedMods and getActivatedMods()
    if not mods or not mods:contains("DynamicTradingCommon") then return end
    local looks = DynamicTrading and DynamicTrading.ArchetypeLooks
    local manager = getScriptManager and getScriptManager()
    if not looks or not manager then return end
    -- Respect another mod supplying the old ID, and require a valid replacement.
    if manager:FindItem("Base.Tshirt_White") or not manager:FindItem("Base.Tshirt_WhiteTINT") then return end
    local repaired = 0
    for _, archetype in pairs(looks) do
        for _, gender in ipairs({"Male", "Female"}) do
            for _, outfit in ipairs(archetype[gender] or {}) do
                if type(outfit) == "table" then
                    for index, itemType in ipairs(outfit) do
                        if itemType == "Base.Tshirt_White" then
                            outfit[index] = "Base.Tshirt_WhiteTINT"
                            repaired = repaired + 1
                        end
                    end
                end
            end
        end
    end
    if repaired > 0 then
        print("[CWModpackCompatibility][DynamicTrading] Repaired obsolete T-shirt IDs in " .. tostring(repaired) .. " wardrobe entries.")
    end
end

local function apply()
    install()
    repairOutfits()
end
Events.OnGameStart.Add(apply)
if Events.OnServerStarted then Events.OnServerStarted.Add(apply) end
