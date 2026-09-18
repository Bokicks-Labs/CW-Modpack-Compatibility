-- Keep recovery controls out of cascading menus; retain Lifestyle's permissions.
local function hasRights()
    return LSUtil and LSUtil.hasAdminRights and LSUtil.hasAdminRights()
end

local function getEmbarrassment(character)
    local data = character:getModData()
    return data.LSMoodles and data.LSMoodles.Embarrassed
end

local function changeEmbarrassment(character, change, endpoint)
    if not hasRights() or not character or character:isDead() then return end
    local data = character:getModData()
    local moodle = getEmbarrassment(character)
    if not moodle then
        -- Initialize only this moodle; other Lifestyle stats must stay intact.
        local properties = require("Properties/MoodleProperties")
        for _, definition in pairs(properties) do
            if definition.name == "Embarrassed" then
                moodle = {}
                for key, value in pairs(definition) do moodle[key] = value end
                data.LSMoodles = data.LSMoodles or {}
                data.LSMoodles.Embarrassed = moodle
                break
            end
        end
    end
    if not moodle then return end

    local value = change == 0 and endpoint
        or ((tonumber(moodle.Value) or 0) + change)
    value = math.max(0, math.min(1, value))
    moodle.Value = value
    -- Match Lifestyle's moodle thresholds so gameplay also sees the new level
    -- immediately, including when clearing a stale nonzero level.
    moodle.Level = value >= 0.7 and 4 or value >= 0.5 and 3
        or value >= 0.3 and 2 or value >= 0.15 and 1 or 0
end

local installed = false
local windows = {}

local function install()
    local active = getActivatedMods and getActivatedMods()
    if not active or not active:contains("LifestyleHobbies") then return end
    if installed then return end
    require "ISUI/ISCollapsableWindow"
    require "ISUI/ISButton"

    local Controls = ISCollapsableWindow:derive("CWLifestyleEmbarrassmentControls")

    function Controls:close()
        ISCollapsableWindow.close(self)
        self:removeFromUIManager()
        if windows[self.playerIndex] == self then windows[self.playerIndex] = nil end
    end

    function Controls:createChildren()
        ISCollapsableWindow.createChildren(self)
        local spacing = 12
        self.valueY = self:titleBarHeight() + spacing
        local y = self.valueY + self.fontHeight + spacing
        local halfWidth = (self.width - spacing * 3) / 2
        local function button(text, x, row, width, change, endpoint)
            local widget = ISButton:new(x, y + row * (self.buttonHeight + spacing),
                width, self.buttonHeight, text, self, function(panel)
                    changeEmbarrassment(panel.character, change, endpoint)
                end)
            widget:initialise()
            self:addChild(widget)
        end
        button("Increase +0.2", spacing, 0, halfWidth, 0.2)
        button("Decrease -0.2", spacing * 2 + halfWidth, 0, halfWidth, -0.2)
        button("Set Maximum (1)", spacing, 1, halfWidth, 0, 1)
        button("Clear Embarrassment", spacing * 2 + halfWidth, 1, halfWidth, 0, 0)
        local close = ISButton:new(spacing, y + 2 * (self.buttonHeight + spacing),
            self.width - spacing * 2, self.buttonHeight, "Close", self, self.close)
        close:initialise()
        self:addChild(close)
    end

    function Controls:prerender()
        ISCollapsableWindow.prerender(self)
        local moodle = getEmbarrassment(self.character)
        local value = tonumber(moodle and moodle.Value) or 0
        self:drawText(string.format("Value: %.2f / 1    Level: %s", value,
            tostring(moodle and moodle.Level or 0)), 12, self.valueY, 1, 1, 1, 1, UIFont.Small)
    end

    local function open(character, playerIndex)
        if not hasRights() or not character or character:isDead() then return end
        if windows[playerIndex] then windows[playerIndex]:close() end
        local fontHeight = getTextManager():getFontHeight(UIFont.Small)
        local buttonHeight = math.max(30, fontHeight + 12)
        local labelWidth = getTextManager():MeasureStringX(UIFont.Small, "Clear Embarrassment")
        local width = math.max(340, labelWidth * 2 + 60)
        local height = math.max(16, fontHeight + 1) + fontHeight + buttonHeight * 3 + 72
        local x = getPlayerScreenLeft(playerIndex) + math.max(0, (getPlayerScreenWidth(playerIndex) - width) / 2)
        local y = getPlayerScreenTop(playerIndex) + math.max(0, (getPlayerScreenHeight(playerIndex) - height) / 2)
        local panel = Controls:new(x, y, width, height)
        panel.character = character
        panel.playerIndex = playerIndex
        panel.fontHeight = fontHeight
        panel.buttonHeight = buttonHeight
        panel.title = "Lifestyle: Embarrassment"
        panel:setResizable(false)
        windows[playerIndex] = panel
        panel:initialise()
        panel:addToUIManager()
    end

    Events.OnFillWorldObjectContextMenu.Add(function(player, context, worldobjects, test)
        if test or not hasRights() then return end
        local character = getSpecificPlayer(player)
        if not character or character:isDead() then return end
        local label = "Lifestyle: Embarrassment Controls"
        if not context:getOptionFromName(label) then
            context:addOptionOnTop(label, character, open, player)
        end
    end)
    installed = true
    print("[CWModpackCompatibility][LifestyleDebug] Installed embarrassment controls window.")
end

Events.OnGameStart.Add(install)
