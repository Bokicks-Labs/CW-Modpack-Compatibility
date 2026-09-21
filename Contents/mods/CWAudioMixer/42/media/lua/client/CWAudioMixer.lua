-- Optional client-only audio mixer for the Chaosworld modpack.
--
-- PZ exposes loaded GameSound definitions to Lua.  This submod only adjusts
-- their user-volume multipliers; it does not replace FMOD banks, modify world
-- state, or send any client/server commands.
require "ISUI/ISPanel"
require "ISUI/ISLabel"
require "ISUI/ISButton"
require "ISUI/ISComboBox"
require "ISUI/ISVolumeControl"

CWAudioMixer = CWAudioMixer or {}
local Mixer = CWAudioMixer

local CONFIG_FILE = "CWAudioMixer.ini"
local GROUPS = { "Music", "Devices", "Menu", "World", "Other" }
local GROUP_LABELS = {
    Music = "Music and performances",
    Devices = "Radio, TV, and media devices",
    Menu = "Menu and UI sounds",
    World = "World ambience (includes vanilla rain)",
    Other = "Other discovered sounds",
}

Mixer.settings = Mixer.settings or { groups = {}, baseline = {}, assignments = {} }
Mixer.discovered = Mixer.discovered or {}

local function log(message)
    print("[CWAudioMixer] " .. tostring(message))
end

local function clamp(value, minimum, maximum)
    return math.max(minimum, math.min(maximum, value))
end

local function escape(value)
    return tostring(value):gsub("%%", "%%25"):gsub("|", "%%7C"):gsub("[\r\n]", " ")
end

local function unescape(value)
    return tostring(value):gsub("%%7[Cc]", "|"):gsub("%%25", "%%")
end

local function defaults()
    local settings = { groups = {}, baseline = {}, assignments = {} }
    for _, group in ipairs(GROUPS) do
        settings.groups[group] = 1.0
    end
    return settings
end

local function saveSettings()
    local writer = getFileWriter(CONFIG_FILE, true, false)
    if not writer then
        log("Could not save " .. CONFIG_FILE)
        return
    end

    writer:write("version|1\r\n")
    for _, group in ipairs(GROUPS) do
        writer:write("group|" .. group .. "|" .. tostring(Mixer.settings.groups[group] or 1.0) .. "\r\n")
    end
    for name, value in pairs(Mixer.settings.baseline) do
        writer:write("base|" .. escape(name) .. "|" .. tostring(value) .. "\r\n")
    end
    for name, group in pairs(Mixer.settings.assignments) do
        writer:write("assign|" .. escape(name) .. "|" .. escape(group) .. "\r\n")
    end
    writer:close()
end

local function loadSettings()
    Mixer.settings = defaults()
    local reader = getFileReader(CONFIG_FILE, false)
    if not reader then return end

    while true do
        local line = reader:readLine()
        if not line then break end
        local fields = luautils.split(line, "|")
        if fields[1] == "group" and Mixer.settings.groups[fields[2]] and tonumber(fields[3]) then
            Mixer.settings.groups[fields[2]] = clamp(tonumber(fields[3]), 0, 2)
        elseif fields[1] == "base" and fields[2] and tonumber(fields[3]) then
            Mixer.settings.baseline[unescape(fields[2])] = clamp(tonumber(fields[3]), 0, 2)
        elseif fields[1] == "assign" and fields[2] and GROUP_LABELS[unescape(fields[3])] then
            Mixer.settings.assignments[unescape(fields[2])] = unescape(fields[3])
        end
    end
    reader:close()
end

local function ensureAdvancedSoundVolumes()
    -- GameSound:getUserVolume() deliberately returns 1.0 until this built-in
    -- switch is on.  The mixer needs that public per-sound layer; it also makes
    -- the game's own Advanced Sound Options button available for inspection.
    if SystemDisabler and SystemDisabler.setEnableAdvancedSoundOptions then
        SystemDisabler.setEnableAdvancedSoundOptions(true)
    end
end

local function classify(sound)
    local name = string.lower(sound:getName() or "")
    local category = string.lower(sound:getCategory() or "")
    local master = string.lower(sound:getMasterName() or "")

    if category == "ui" or master == "ui"
        or name:find("menu", 1, true) or name:find("button", 1, true)
        or name:find("toggle", 1, true) or name:find("hover", 1, true)
        or name:find("select", 1, true) or name:find("activate", 1, true)
        or name:find("tab", 1, true) then
        return "Menu"
    end
    if category == "music" or master == "music"
        or name:find("music", 1, true) or name:find("song", 1, true)
        or name:find("jukebox", 1, true) or name:find("instrument", 1, true)
        or name:find("dj", 1, true) or name:find("disco", 1, true) then
        return "Music"
    end
    if name:find("radio", 1, true) or name:find("television", 1, true)
        or name:find("broadcast", 1, true) or name:find("media", 1, true) then
        return "Devices"
    end
    if master == "ambient" or name == "worldambiance" or name:find("rain", 1, true)
        or name:find("weather", 1, true) then
        return "World"
    end
    return "Other"
end

local function groupFor(name, sound)
    return Mixer.settings.assignments[name] or classify(sound)
end

local function soundFor(name)
    if not GameSounds or not GameSounds.getSound then return nil end
    local ok, sound = pcall(GameSounds.getSound, name)
    return ok and sound or nil
end

local function applySound(name, sound)
    local baseline = Mixer.settings.baseline[name]
    if baseline == nil then
        baseline = clamp(tonumber(sound:getUserVolume()) or 1.0, 0, 2)
        Mixer.settings.baseline[name] = baseline
    end
    local group = groupFor(name, sound)
    local multiplier = Mixer.settings.groups[group] or 1.0
    sound:setUserVolume(clamp(baseline * multiplier, 0, 2))
end

function Mixer.discover()
    ensureAdvancedSoundVolumes()
    if not GameSounds or not GameSounds.getCategories then
        log("GameSounds API is unavailable; mixer remains inactive.")
        return false
    end

    local discovered = {}
    local categories = GameSounds.getCategories()
    for categoryIndex = 0, categories:size() - 1 do
        local sounds = GameSounds.getSoundsInCategory(categories:get(categoryIndex))
        for soundIndex = 0, sounds:size() - 1 do
            local sound = sounds:get(soundIndex)
            local name = sound:getName()
            if name and not discovered[name] then
                discovered[name] = sound
                if Mixer.settings.baseline[name] == nil then
                    Mixer.settings.baseline[name] = clamp(tonumber(sound:getUserVolume()) or 1.0, 0, 2)
                end
            end
        end
    end
    Mixer.discovered = discovered
    return true
end

function Mixer.applyAll()
    if not Mixer.discover() then return false end
    for name, sound in pairs(Mixer.discovered) do
        applySound(name, sound)
    end
    pcall(GameSounds.saveINI)
    saveSettings()
    return true
end

function Mixer.setGroupVolume(group, sliderValue)
    Mixer.settings.groups[group] = clamp(sliderValue / 5, 0, 2)
    Mixer.applyAll()
end

function Mixer.setSoundVolume(name, sliderValue)
    local sound = Mixer.discovered[name] or soundFor(name)
    if not sound then return end
    local group = groupFor(name, sound)
    local multiplier = Mixer.settings.groups[group] or 1.0
    if multiplier <= 0 then multiplier = 1.0 end
    Mixer.settings.baseline[name] = clamp((sliderValue / 5) / multiplier, 0, 2)
    applySound(name, sound)
    pcall(GameSounds.saveINI)
    saveSettings()
end

function Mixer.assignSound(name, group)
    local sound = Mixer.discovered[name] or soundFor(name)
    if not sound or not GROUP_LABELS[group] then return end
    Mixer.settings.assignments[name] = group
    applySound(name, sound)
    pcall(GameSounds.saveINI)
    saveSettings()
end

function Mixer.restoreOriginalVolumes()
    Mixer.settings.groups = defaults().groups
    Mixer.settings.assignments = {}
    for name, sound in pairs(Mixer.discovered) do
        sound:setUserVolume(Mixer.settings.baseline[name] or 1.0)
    end
    pcall(GameSounds.saveINI)
    saveSettings()
end

local MixerPanel = ISPanel:derive("CWAudioMixerPanel")

function MixerPanel:addLabel(x, y, text)
    local label = ISLabel:new(x, y, 18, text, 1, 1, 1, 1, UIFont.Small, true)
    label:initialise()
    self:addChild(label)
    return label
end

function MixerPanel:createChildren()
    self:addLabel(14, 12, "CW Audio Mixer")
    self:addLabel(14, 34, "Group sliders adjust safe, discovered sound definitions. 0% to 200%.")

    self.groupControls = {}
    local y = 60
    for _, group in ipairs(GROUPS) do
        self:addLabel(14, y + 2, GROUP_LABELS[group])
        local control = ISVolumeControl:new(260, y, 180, 20, self, function(panel, _, value)
            if not panel.refreshing then Mixer.setGroupVolume(group, value) end
        end)
        control:initialise()
        control.tooltip = "0% to 200%; 100% is the normal level."
        self:addChild(control)
        self.groupControls[group] = control
        y = y + 28
    end

    self:addLabel(14, y + 8, "Discovered sound")
    self.filterBox = ISComboBox:new(150, y + 4, 140, 22, self, MixerPanel.onFilterChanged)
    self.filterBox:initialise()
    self.filterBox:addOptionWithData("All groups", "All")
    for _, group in ipairs(GROUPS) do
        self.filterBox:addOptionWithData(GROUP_LABELS[group], group)
    end
    self:addChild(self.filterBox)

    self.soundBox = ISComboBox:new(14, y + 32, 426, 22, self, MixerPanel.onSoundChanged)
    self.soundBox:initialise()
    self.soundBox:setEditable(true)
    self:addChild(self.soundBox)

    self.selectedLabel = self:addLabel(14, y + 62, "Select a sound to inspect its current group and volume.")
    self.soundVolume = ISVolumeControl:new(260, y + 86, 180, 20, self, MixerPanel.onSoundVolumeChanged)
    self.soundVolume:initialise()
    self.soundVolume.tooltip = "Individual volume: 0% to 200%."
    self:addChild(self.soundVolume)
    self:addLabel(14, y + 88, "Individual volume")

    self.assignmentBox = ISComboBox:new(150, y + 114, 290, 22, self, MixerPanel.onAssignmentChanged)
    self.assignmentBox:initialise()
    for _, group in ipairs(GROUPS) do
        self.assignmentBox:addOptionWithData(GROUP_LABELS[group], group)
    end
    self:addChild(self.assignmentBox)
    self:addLabel(14, y + 118, "Assign group")

    self.previewButton = ISButton:new(14, y + 150, 100, 24, "Preview", self, MixerPanel.onPreview)
    self.previewButton:initialise()
    self:addChild(self.previewButton)
    self.stopButton = ISButton:new(122, y + 150, 100, 24, "Stop preview", self, MixerPanel.onStopPreview)
    self.stopButton:initialise()
    self:addChild(self.stopButton)
    self.restoreButton = ISButton:new(230, y + 150, 130, 24, "Restore originals", self, MixerPanel.onRestore)
    self.restoreButton:initialise()
    self.restoreButton.tooltip = "Restores the sound volumes from before this mixer first adjusted them."
    self:addChild(self.restoreButton)
    self.closeButton = ISButton:new(368, y + 150, 72, 24, "Close", self, MixerPanel.onClose)
    self.closeButton:initialise()
    self:addChild(self.closeButton)

    self:addLabel(14, y + 184, "Vanilla rain is part of the World Ambience FMOD event, so its control also affects other world ambience.")
    self:refresh()
end

function MixerPanel:selectedSoundName()
    return self.soundBox and self.soundBox:getOptionData(self.soundBox.selected) or nil
end

function MixerPanel:refreshSoundBox(keepName)
    self.soundBox:clear()
    local wantedGroup = self.filterBox:getOptionData(self.filterBox.selected) or "All"
    local names = {}
    for name, sound in pairs(Mixer.discovered) do
        if wantedGroup == "All" or groupFor(name, sound) == wantedGroup then
            table.insert(names, name)
        end
    end
    table.sort(names)
    for _, name in ipairs(names) do
        self.soundBox:addOptionWithData(name, name)
    end
    if keepName then self.soundBox:selectData(keepName) end
end

function MixerPanel:refreshSelectedSound()
    local name = self:selectedSoundName()
    local sound = name and Mixer.discovered[name] or nil
    if not sound then
        self.selectedLabel:setName("No discovered sound matches this filter.")
        return
    end
    local group = groupFor(name, sound)
    self.selectedLabel:setName(name .. "  |  " .. GROUP_LABELS[group] .. "  |  master: " .. tostring(sound:getMasterName()))
    self.assignmentBox:selectData(group)
    self.soundVolume:setVolume(math.floor((tonumber(sound:getUserVolume()) or 1) * 5 + 0.5))
end

function MixerPanel:refresh()
    self.refreshing = true
    Mixer.discover()
    for _, group in ipairs(GROUPS) do
        self.groupControls[group]:setVolume(math.floor((Mixer.settings.groups[group] or 1) * 5 + 0.5))
    end
    local selected = self:selectedSoundName()
    self:refreshSoundBox(selected)
    self:refreshSelectedSound()
    self.refreshing = false
end

function MixerPanel:onFilterChanged()
    self:refreshSoundBox(nil)
    self:refreshSelectedSound()
end

function MixerPanel:onSoundChanged()
    self:refreshSelectedSound()
end

function MixerPanel:onSoundVolumeChanged(_, value)
    if self.refreshing then return end
    local name = self:selectedSoundName()
    if name then Mixer.setSoundVolume(name, value) end
end

function MixerPanel:onAssignmentChanged()
    if self.refreshing then return end
    local name = self:selectedSoundName()
    local group = self.assignmentBox:getOptionData(self.assignmentBox.selected)
    if name and group then
        Mixer.assignSound(name, group)
        self:refresh()
    end
end

function MixerPanel:onPreview()
    local name = self:selectedSoundName()
    if name then pcall(GameSounds.previewSound, name) end
end

function MixerPanel:onStopPreview()
    pcall(GameSounds.stopPreview)
end

function MixerPanel:onRestore()
    Mixer.restoreOriginalVolumes()
    self:refresh()
end

function MixerPanel:onClose()
    pcall(GameSounds.stopPreview)
    self:setVisible(false)
    self:removeFromUIManager()
    Mixer.panel = nil
end

function MixerPanel:new(x, y, width, height)
    local panel = ISPanel.new(self, x, y, width, height)
    panel.moveWithMouse = true
    panel.backgroundColor = { r = 0.05, g = 0.05, b = 0.05, a = 0.94 }
    panel.borderColor = { r = 0.5, g = 0.5, b = 0.5, a = 1.0 }
    return panel
end

function Mixer.open()
    ensureAdvancedSoundVolumes()
    Mixer.discover()
    if Mixer.panel then
        Mixer.panel:setVisible(true)
        Mixer.panel:bringToTop()
        Mixer.panel:refresh()
        return
    end
    local width, height = 455, 390
    local x = math.floor((getCore():getScreenWidth() - width) / 2)
    local y = math.floor((getCore():getScreenHeight() - height) / 2)
    Mixer.panel = MixerPanel:new(x, y, width, height)
    Mixer.panel:initialise()
    Mixer.panel:instantiate()
    Mixer.panel:addToUIManager()
end

local function addContextOption(player, context, worldobjects, test)
    if test then return end
    context:addOption("CW Audio Mixer", nil, Mixer.open)
end

local function registerModOptions()
    local ok = pcall(require, "PZAPI/ModOptions")
    local api = ok and PZAPI and PZAPI.ModOptions or nil
    if not api or not api.create then return end
    local options = api.getOptions and api:getOptions("CWAudioMixer") or nil
    options = options or api:create("CWAudioMixer", "CW Audio Mixer")
    if not options or not options.addButton then return end
    options:addButton("OPEN_MIXER", "Open audio mixer", "Discover loaded sounds and adjust their volumes.", Mixer.open)
end

-- Mod Options builds its menu before OnGameStart. Register while this client
-- script loads so the entry is present when the player opens Options.
registerModOptions()

local function initialise()
    ensureAdvancedSoundVolumes()
    loadSettings()
    Mixer.applyAll()
    log("Loaded optional client audio mixer.")
end

Events.OnGameStart.Add(initialise)
Events.OnFillWorldObjectContextMenu.Add(addContextOption)
