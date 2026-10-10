-- Keep the vanilla debug healing commands easy to reach with Casualties Undead.
require "XpSystem/ISUI/ISHealthPanel"

local function isCasualtiesActive()
    local mods = getActivatedMods and getActivatedMods()
    return mods and mods:contains("CasualtiesUndead")
end

local function install()
    if not isCasualtiesActive() or ISHealthPanel.__cwCasualtiesHealMenu then return end

    local originalMenu = ISHealthPanel.doBodyPartContextMenu
    if not originalMenu then return end

    ISHealthPanel.doBodyPartContextMenu = function(self, bodyPart, x, y)
        originalMenu(self, bodyPart, x, y)
        if not ISHealthPanel.cheat or not bodyPart or self.blockingMessage then return end

        local doctor, patient = self:getDoctor(), self:getPatient()
        if not doctor or not patient then return end

        local playerNum = self.otherPlayer and self.otherPlayer:getPlayerNum() or self.character:getPlayerNum()
        local context = getPlayerContextMenu(playerNum)
        if not context then return end

        -- Use the same callback and arguments as the base game's Cheat menu.
        -- Its entries can be buried under Casualties Undead's long procedure menu.
        context:addOptionOnTop(getText("IGUI_HealthFullBody"), bodyPart,
            ISHealthPanel.onCheat, "healthFullBody", self.character, self.otherPlayer)
        context:addOptionOnTop(getText("IGUI_HealthFull"), bodyPart,
            ISHealthPanel.onCheat, "healthFull", self.character, self.otherPlayer)
        context:setVisible(true)
    end

    ISHealthPanel.__cwCasualtiesHealMenu = true
end

Events.OnGameStart.Add(install)
