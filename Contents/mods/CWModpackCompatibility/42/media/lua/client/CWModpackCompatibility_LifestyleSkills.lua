require("XpSystem/ISUI/ISCharacterInfo")
require("XpSystem/ISUI/ISSkillProgressBar")

CWModpackCompatibility = CWModpackCompatibility or {}

local Compat = CWModpackCompatibility
local OPTION_ID = "showLifestyleHiddenSkills"
local MOD_OPTIONS_ID = "CWModpackCompatibility"

local hiddenPerks = {
    { hidden = "Yoga",     perk = "CWHiddenYoga" },
    { hidden = "Inventing", perk = "CWHiddenInventing" },
    { hidden = "PingPong", perk = "CWHiddenPingPong" },
    { hidden = "Pool",     perk = "CWHiddenPool" },
    { hidden = "Arcade",   perk = "CWHiddenArcade" },
}

local function log(message)
    print("[CWModpackCompatibility][LifestyleSkills] " .. tostring(message))
end

local function isLifestyleActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("LifestyleHobbies")
end

local options = PZAPI.ModOptions:getOptions(MOD_OPTIONS_ID)
if not options then
    options = PZAPI.ModOptions:create(MOD_OPTIONS_ID, getText("UI_CWCompat_OptionsTitle"))
end

options:addTitle(getText("UI_CWCompat_LifestyleTitle"))
options:addDescription("UI_CWCompat_LifestyleDescription")
local showOption = options:addTickBox(
    OPTION_ID,
    getText("UI_CWCompat_ShowHiddenSkills"),
    true,
    getText("UI_CWCompat_ShowHiddenSkills_tooltip")
)
Compat.lifestyleHiddenSkillsOption = showOption

local function findHiddenEntry(perk)
    if not perk then return nil end
    local perkType = perk:getType()
    for _, entry in ipairs(hiddenPerks) do
        if Perks[entry.perk] and perkType == Perks[entry.perk] then
            return entry
        end
    end
    return nil
end

local function getHiddenSkill(character, skillName)
    if not character then return nil end
    local data = character:getModData()
    return data and data.LSHiddenSkills and data.LSHiddenSkills[skillName] or nil
end

local function syncVisibleLevels(character)
    if not character or not isLifestyleActive() then return end
    for _, entry in ipairs(hiddenPerks) do
        local perk = Perks[entry.perk]
        if perk then
            local skill = getHiddenSkill(character, entry.hidden)
            local level = skill and tonumber(skill[1]) or 0
            level = math.max(0, math.min(10, math.floor(level)))
            if character:getPerkLevel(perk) ~= level then
                character:setPerkLevelDebug(perk, level)
            end
        end
    end
end

local originalGetPerkXp = ISSkillProgressBar.getPerkXp
ISSkillProgressBar.getPerkXp = function(self)
    local entry = findHiddenEntry(self and self.perk)
    if entry then
        local skill = getHiddenSkill(self.char, entry.hidden)
        return skill and tonumber(skill[2]) or 0
    end
    return originalGetPerkXp(self)
end

local originalLoadPerk = ISCharacterInfo.loadPerk
ISCharacterInfo.loadPerk = function(self)
    local perks = originalLoadPerk(self)
    if showOption:getValue() then return perks end

    for _, perkList in pairs(perks) do
        for index = #perkList, 1, -1 do
            if findHiddenEntry(perkList[index]) then
                table.remove(perkList, index)
            end
        end
    end
    return perks
end

local function refreshSkillPanels()
    for playerNum = 0, getNumActivePlayers() - 1 do
        local infoPanel = getPlayerInfoPanel and getPlayerInfoPanel(playerNum) or nil
        local characterInfo = infoPanel and infoPanel.characterView or nil
        if characterInfo then
            characterInfo.txtLen = 0
            characterInfo.perks = ISCharacterInfo.loadPerk(characterInfo)
            characterInfo.reloadSkillBar = true
        end
    end
end

options.apply = function(self)
    for playerNum = 0, getNumActivePlayers() - 1 do
        syncVisibleLevels(getSpecificPlayer(playerNum))
    end
    refreshSkillPanels()
    log("Hidden Lifestyle skill display " .. (showOption:getValue() and "enabled." or "disabled."))
end

local function installHiddenSkillBridge()
    if not isLifestyleActive() or not HiddenSkills then return end
    if HiddenSkills.__cwVisiblePerkBridge then return end

    for _, methodName in ipairs({ "addXP", "removeXP", "addLevel", "setLevel", "resetSkill" }) do
        local original = HiddenSkills[methodName]
        if original then
            HiddenSkills[methodName] = function(character, ...)
                local result = original(character, ...)
                syncVisibleLevels(character)
                return result
            end
        end
    end

    HiddenSkills.__cwVisiblePerkBridge = true
    log("Installed hidden-skill display bridge.")
end

local function initialiseLifestyleSkillDisplay()
    installHiddenSkillBridge()
    for playerNum = 0, getNumActivePlayers() - 1 do
        syncVisibleLevels(getSpecificPlayer(playerNum))
    end
    refreshSkillPanels()
end

Events.OnGameStart.Add(initialiseLifestyleSkillDisplay)
Events.OnCreatePlayer.Add(function(_, player)
    installHiddenSkillBridge()
    syncVisibleLevels(player)
end)
