local function isActive(modID)
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains(modID)
end

local function installCleanUIEquipmentTooltipFix()
    if not isActive("CleanUI") or not isActive("EquipmentUI_B42") then return end

    require("ISUI/ISInventoryPane")
    if not ISInventoryPane or not ISInventoryPane.updateTooltip then return end
    if ISInventoryPane.__cwCleanUIEquipmentTooltipFix then return end

    -- Equipment UI installs its updateTooltip wrapper during OnGameStart. This
    -- compatibility handler runs later and therefore guards the complete live
    -- chain while preserving Equipment UI's normal delegation.
    local moddedUpdateTooltip = ISInventoryPane.updateTooltip

    ISInventoryPane.updateTooltip = function(self, ...)
        -- CleanUI assumes getPlayerContextMenu() always returns a menu. During
        -- initial UI construction and teardown it can legitimately return nil;
        -- Equipment UI delegates into that copied function every few frames,
        -- turning the missing nil guard into an unbounded console flood.
        if self and self.player ~= nil and getPlayerContextMenu then
            local contextMenu = getPlayerContextMenu(self.player)
            if not contextMenu then
                return
            end
        end

        return moddedUpdateTooltip(self, ...)
    end

    ISInventoryPane.__cwCleanUIEquipmentTooltipFix = true
    print("[CWModpackCompatibility] Applied CleanUI/Equipment UI tooltip nil-context fix.")
end

Events.OnGameStart.Add(installCleanUIEquipmentTooltipFix)
