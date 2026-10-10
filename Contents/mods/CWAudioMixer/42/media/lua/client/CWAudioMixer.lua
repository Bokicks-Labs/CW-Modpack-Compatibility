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
require "OptionScreens/MainOptions"

CWAudioMixer = CWAudioMixer or {}
local Mixer = CWAudioMixer

local CONFIG_FILE = "CWAudioMixer.ini"
local GROUPS = { "MenuUI", "Death", "TV", "Radio", "Music", "Weather", "Vehicles", "Combat", "Other" }
local GROUP_LABELS = {
    MenuUI = "Menu and UI effects",
    Death = "Death music (Game/GameOver)",
    TV = "TV and shared radio program audio",
    Radio = "Radio sound effects",
    Music = "Music and performances (not title-video audio)",
    Weather = "Weather and world ambience (includes vanilla rain)",
    Vehicles = "Vehicles",
    Combat = "Combat and weapons",
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

    local oldGroups = {}
    local seenGroups = {}

    while true do
        local line = reader:readLine()
        if not line then break end
        local fields = luautils.split(line, "|")
        if fields[1] == "group" and fields[2] and tonumber(fields[3]) then
            local value = clamp(tonumber(fields[3]), 0, 2)
            if Mixer.settings.groups[fields[2]] then
                Mixer.settings.groups[fields[2]] = value
                seenGroups[fields[2]] = true
            else
                oldGroups[fields[2]] = value
            end
        elseif fields[1] == "base" and fields[2] and tonumber(fields[3]) then
            Mixer.settings.baseline[unescape(fields[2])] = clamp(tonumber(fields[3]), 0, 2)
        elseif fields[1] == "assign" and fields[2] and fields[3] then
            local oldGroup = unescape(fields[3])
            local migrated = ({ Menu = "MenuUI", World = "Weather", MenuBackground = "Music" })[oldGroup] or oldGroup
            if GROUP_LABELS[migrated] or migrated == "Devices" then
                Mixer.settings.assignments[unescape(fields[2])] = migrated
            end
        end
    end
    reader:close()
    if oldGroups.Devices then
        if not seenGroups.TV then Mixer.settings.groups.TV = oldGroups.Devices end
        if not seenGroups.Radio then Mixer.settings.groups.Radio = oldGroups.Devices end
    end
    if oldGroups.Menu and not seenGroups.MenuUI then Mixer.settings.groups.MenuUI = oldGroups.Menu end
    if oldGroups.World and not seenGroups.Weather then Mixer.settings.groups.Weather = oldGroups.World end
    if oldGroups.MenuBackground and not seenGroups.Music then Mixer.settings.groups.Music = oldGroups.MenuBackground end
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

    if name == "playerdied" then return "Death" end
    if name == "radiotalk" then return "TV" end -- PZ shares this program loop between TVs and radios.
    if name:find("television", 1, true) or name:find("tvstatic", 1, true) then return "TV" end
    if name:find("radio", 1, true) or name:find("broadcast", 1, true) then return "Radio" end
    if category == "ui" or master == "ui"
        or name:find("menu", 1, true) or name:find("button", 1, true)
        or name:find("toggle", 1, true) or name:find("hover", 1, true)
        or name:find("select", 1, true) or name:find("activate", 1, true)
        or name:find("tab", 1, true) then
        return "MenuUI"
    end
    if category == "music" or master == "music"
        or name:find("music", 1, true) or name:find("song", 1, true)
        or name:find("jukebox", 1, true) or name:find("instrument", 1, true)
        or name:find("dj", 1, true) or name:find("disco", 1, true) then
        return "Music"
    end
    if master == "ambient" or category == "world" or name == "worldambiance"
        or name:find("rain", 1, true) or name:find("weather", 1, true)
        or name:find("thunder", 1, true) then
        return "Weather"
    end
    if category == "vehicle" or name:find("vehicle", 1, true) or name:find("engine", 1, true) then return "Vehicles" end
    if category == "weapon" or category == "combat" or name:find("gun", 1, true)
        or name:find("weapon", 1, true) or name:find("impact", 1, true) then return "Combat" end
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
                if Mixer.settings.assignments[name] == "Devices" then
                    local detected = classify(sound)
                    Mixer.settings.assignments[name] = (detected == "TV" or detected == "Radio") and detected or "Other"
                end
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
    if not GROUP_LABELS[group] then return end
    local value = clamp(sliderValue / 5, 0, 2)
    if Mixer.settings.groups[group] == value then return end
    Mixer.settings.groups[group] = value
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
    if Mixer.audioControls then
        for group, control in pairs(Mixer.audioControls) do
            control:setVolume(5)
        end
    end
end

local MixerPanel = ISPanel:derive("CWAudioMixerPanel")

function MixerPanel:prerender()
    if self.optionsOwner and not self.optionsOwner:isVisible() then
        self:onClose()
        return
    end
    ISPanel.prerender(self)
end

function MixerPanel:addLabel(x, y, text)
    local label = ISLabel:new(x, y, 18 * self.layoutScale, text, 1, 1, 1, 1, UIFont.Small, true)
    label:initialise()
    self:addChild(label)
    return label
end

function MixerPanel:createChildren()
    local function px(value) return math.floor(value * self.layoutScale + 0.5) end
    self:addLabel(px(14), px(12), "CW Audio Mixer")
    self:addLabel(px(14), px(34), "Group sliders adjust discovered sounds. 0% to 200%.")

    self.groupControls = {}
    local y = px(60)
    for _, group in ipairs(GROUPS) do
        self:addLabel(px(14), y + px(2), GROUP_LABELS[group])
        local control = ISVolumeControl:new(px(430), y, px(200), px(20), self, function(panel, _, value)
            if not panel.refreshing then Mixer.setGroupVolume(group, value) end
        end)
        control:initialise()
        control.tooltip = "0% to 200%; 100% is the normal level."
        self:addChild(control)
        self.groupControls[group] = control
        y = y + px(28)
    end

    self:addLabel(px(14), y + px(8), "Discovered sound")
    self.filterBox = ISComboBox:new(px(150), y + px(4), px(140), px(22), self, MixerPanel.onFilterChanged)
    self.filterBox:initialise()
    self.filterBox:addOptionWithData("All groups", "All")
    for _, group in ipairs(GROUPS) do
        self.filterBox:addOptionWithData(GROUP_LABELS[group], group)
    end
    self:addChild(self.filterBox)

    self.soundBox = ISComboBox:new(px(14), y + px(32), px(616), px(22), self, MixerPanel.onSoundChanged)
    self.soundBox:initialise()
    self.soundBox:setEditable(true)
    self:addChild(self.soundBox)

    self.selectedLabel = self:addLabel(px(14), y + px(62), "Select a sound to inspect its group and volume.")
    self.soundVolume = ISVolumeControl:new(px(430), y + px(86), px(200), px(20), self, MixerPanel.onSoundVolumeChanged)
    self.soundVolume:initialise()
    self.soundVolume.tooltip = "Individual volume: 0% to 200%."
    self:addChild(self.soundVolume)
    self:addLabel(px(14), y + px(88), "Individual volume")

    self.assignmentBox = ISComboBox:new(px(150), y + px(114), px(480), px(22), self, MixerPanel.onAssignmentChanged)
    self.assignmentBox:initialise()
    for _, group in ipairs(GROUPS) do
        self.assignmentBox:addOptionWithData(GROUP_LABELS[group], group)
    end
    self:addChild(self.assignmentBox)
    self:addLabel(px(14), y + px(118), "Assign group")

    self.previewButton = ISButton:new(px(14), y + px(150), px(100), px(24), "Preview", self, MixerPanel.onPreview)
    self.previewButton:initialise()
    self:addChild(self.previewButton)
    self.stopButton = ISButton:new(px(122), y + px(150), px(100), px(24), "Stop preview", self, MixerPanel.onStopPreview)
    self.stopButton:initialise()
    self:addChild(self.stopButton)
    self.restoreButton = ISButton:new(px(230), y + px(150), px(130), px(24), "Restore originals", self, MixerPanel.onRestore)
    self.restoreButton:initialise()
    self.restoreButton.tooltip = "Restores the sound volumes from before this mixer first adjusted them."
    self:addChild(self.restoreButton)
    self.closeButton = ISButton:new(px(558), y + px(150), px(72), px(24), "Close", self, MixerPanel.onClose)
    self.closeButton:initialise()
    self:addChild(self.closeButton)

    self:addLabel(px(14), y + px(184), "Rain shares world ambience. TV volume also depends on its device setting.")
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

function MixerPanel:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then self:onClose() end
end

function MixerPanel:new(x, y, width, height, scale)
    local panel = ISPanel.new(self, x, y, width, height)
    panel.layoutScale = scale
    panel.moveWithMouse = true
    panel.backgroundColor = { r = 0.05, g = 0.05, b = 0.05, a = 0.94 }
    panel.borderColor = { r = 0.5, g = 0.5, b = 0.5, a = 1.0 }
    return panel
end

function Mixer.panelGeometry(screenWidth, screenHeight)
    local scale = math.min(1.4, math.max(1, screenHeight / 1080),
        (screenWidth - 32) / 645, (screenHeight - 32) / 550)
    local width, height = math.floor(645 * scale), math.floor(550 * scale)
    local x = math.floor((screenWidth - width) / 2)
    local y = math.floor((screenHeight - height) / 2)
    return x, y, width, height, scale
end

function Mixer.open(owner)
    ensureAdvancedSoundVolumes()
    Mixer.discover()
    if Mixer.panel then
        Mixer.panel:setVisible(true)
        Mixer.panel:bringToTop()
        Mixer.panel:refresh()
        return
    end
    local x, y, width, height, scale = Mixer.panelGeometry(getCore():getScreenWidth(), getCore():getScreenHeight())
    Mixer.panel = MixerPanel:new(x, y, width, height, scale)
    Mixer.panel.optionsOwner = owner
    Mixer.panel:initialise()
    Mixer.panel:instantiate()
    Mixer.panel:addToUIManager()
end

local function closeAdvancedFor(options)
    if Mixer.panel and Mixer.panel.optionsOwner == options then Mixer.panel:onClose() end
end

local originalOptionsClose = MainOptions.close
function MainOptions:close()
    closeAdvancedFor(self)
    return originalOptionsClose(self)
end

local originalOnGameSounds = MainOptions.onGameSounds
function MainOptions:onGameSounds()
    closeAdvancedFor(self)
    return originalOnGameSounds(self)
end

-- Build 42 constructs its Audio tab inside MainOptions:addSoundPanel(). Add
-- controls there so they use the same Apply/Back lifecycle as vanilla sliders.
local originalAddSoundPanel = MainOptions.addSoundPanel
function MainOptions:addSoundPanel()
    originalAddSoundPanel(self)
    local y = MainOptions.style.initialY
    local splitpoint = self:getWidth() / 2
    local controlWidth = 45 * (getCore():getOptionFontSizeReal() + 1) + 60
    self:addHorizontalLine(y, "CW Audio Mixer")
    Mixer.audioControls = {}
    for _, group in ipairs(GROUPS) do
        local groupId = group
        local control = self:addVolumeControl(splitpoint, y, controlWidth, 20, GROUP_LABELS[groupId], 5)
        local option = GameOption:new("CWAudioMixer." .. groupId, control)
        function option:storeCurrentValue()
            self.originalValue = Mixer.settings.groups[groupId] or 1
        end
        function option:restoreOriginalValue()
            Mixer.setGroupVolume(groupId, (self.originalValue or 1) * 5)
        end
        function option:toUI()
            self.syncing = true
            self.control:setVolume(math.floor((Mixer.settings.groups[groupId] or 1) * 5 + 0.5))
            self.syncing = false
        end
        function option:onChange(_, value)
            if not self.syncing then Mixer.setGroupVolume(groupId, value) end
        end
        function option:apply()
            Mixer.setGroupVolume(groupId, self.control:getVolume())
        end
        self.gameOptions:add(option)
        Mixer.audioControls[groupId] = control
    end
    local button = ISButton:new(splitpoint + 20, y + self.addY + 8, 160, 24,
        "Advanced sound mixer", self, Mixer.open)
    button:initialise()
    button:instantiate()
    self.mainPanel:addChild(button)
    self.mainPanel:insertNewLineOfButtons(button)
    self.mainPanel:setScrollHeight(y + self.addY + 44)
end

loadSettings()

local function initialise()
    ensureAdvancedSoundVolumes()
    loadSettings()
    Mixer.applyAll()
    log("Loaded optional client audio mixer.")
end

Events.OnGameStart.Add(initialise)
Events.OnMainMenuEnter.Add(function() Mixer.applyAll() end)
