-- Extend Lifestyle's existing admin/debug menu without changing its permissions.
local function hasRights()
    return LSUtil and LSUtil.hasAdminRights and LSUtil.hasAdminRights()
end

local function getEmbarrassment(character)
    local data = character:getModData()
    return data.LSMoodles and data.LSMoodles.Embarrassed
end

local function showCurrent(character)
    if not hasRights() or not character or character:isDead() then return end
    local moodle = getEmbarrassment(character)
    character:Say("Embarrassment: " .. tostring(moodle and moodle.Value or 0))
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

    local value = (change == 0 or isShiftKeyDown()) and endpoint
        or ((tonumber(moodle.Value) or 0) + change)
    value = math.max(0, math.min(1, value))
    moodle.Value = value
    -- Match Lifestyle's moodle thresholds so gameplay also sees the new level
    -- immediately, including when clearing a stale nonzero level.
    moodle.Level = value >= 0.7 and 4 or value >= 0.5 and 3
        or value >= 0.3 and 2 or value >= 0.15 and 1 or 0
    showCurrent(character)
end

local function install()
    local active = getActivatedMods and getActivatedMods()
    if not active or not active:contains("LifestyleHobbies") then return end
    if not LSDebugAdmin or not LSDebugAdmin.doBuildMenu then return end
    if LSDebugAdmin.__cwEmbarrassmentDebug then return end

    local original = LSDebugAdmin.doBuildMenu
    LSDebugAdmin.doBuildMenu = function(player, context, worldobjects, debugMenu)
        original(player, context, worldobjects, debugMenu)
        if not hasRights() or not debugMenu then return end
        local character = getSpecificPlayer(player)
        if not character or character:isDead() then return end
        local needsOption = debugMenu:getOptionFromName(getText("ContextMenu_LSDebug_Needs"))
        local needs = needsOption and needsOption.subOption and context:getSubMenu(needsOption.subOption)
        if not needs or needs:getOptionFromName("Embarrassment") then return end

        local option = needs:addOption("Embarrassment")
        local menu = needs:getNew(needs)
        context:addSubMenu(option, menu)
        menu:addOption("Increase (lshift - max)", character, changeEmbarrassment, 0.2, 1)
        menu:addOption("Decrease (lshift - min)", character, changeEmbarrassment, -0.2, 0)
        menu:addOption("Get Current", character, showCurrent)
        menu:addOption("Clear Embarrassment", character, changeEmbarrassment, 0, 0)
    end
    LSDebugAdmin.__cwEmbarrassmentDebug = true
    print("[CWModpackCompatibility][LifestyleDebug] Installed embarrassment debug control.")
end

Events.OnGameStart.Add(install)
