-- Moodles in Lua hides vanilla MoodlesUI only once per instance. Build 42 can
-- reposition that same instance later, briefly drawing a second moodle stack.
local mods = getActivatedMods and getActivatedMods()
if not mods then return end
local hasMoodlesInLua = mods:contains("moodlesinlua")
local hasCasualties = mods:contains("CasualtiesUndead")
local hasMoodleFramework = mods:contains("MoodleFramework")
if not hasMoodlesInLua and not hasCasualties then return end

local hiddenCount = 0
local vanillaMoodles = {}
local nextScan = 0
local SCAN_INTERVAL_MS = 250
local casualtiesPlacementInstalled = false

local function discoverVanillaMoodles()
    local uiList = UIManager and UIManager.getUI and UIManager.getUI()
    if not uiList then return end
    local found = {}
    for i = 0, uiList:size() - 1 do
        local ui = uiList:get(i)
        if ui and instanceof(ui, "MoodlesUI") and ui.getX and ui.getY and ui.setX and ui.setY then
            found[#found + 1] = ui
        end
    end
    vanillaMoodles = found
end

local function keepVanillaMoodlesHidden()
    if not hasMoodlesInLua then return end
    local handle = rawget(_G, "ISMoodlesInLuaHandle")
    if not handle or handle.active ~= true then return end

    local now = getTimestampMs()
    if #vanillaMoodles == 0 or now >= nextScan then
        discoverVanillaMoodles()
        nextScan = now + SCAN_INTERVAL_MS
    end

    for i = 1, #vanillaMoodles do
        local ui = vanillaMoodles[i]
        if ui:getX() ~= -4096 or ui:getY() ~= -4096 then
            ui:setX(-4096)
            ui:setY(-4096)
            hiddenCount = hiddenCount + 1
            if hiddenCount == 1 then
                print("[CWModpackCompatibility][MoodleUIFix] Kept repositioned vanilla moodles off screen.")
            end
        end
    end
end

local function installCasualtiesPlacementBridge()
    if casualtiesPlacementInstalled or not hasCasualties then return end
    local cu = rawget(_G, "CasualtiesUndead")
    local place = cu and cu.Moodles and cu.Moodles.place
    if type(place) ~= "function" or cu.Moodles.__cwMoodleUIFix then return end

    local bridgedPlace = function(ui, player, id)
        local handle = rawget(_G, "ISMoodlesInLuaHandle")
        local playerNum = player and player.getPlayerNum and player:getPlayerNum() or 0
        local milActive = hasMoodlesInLua and handle and handle.active == true
        local size, x, y, spacing

        if milActive then
            size = handle.getMoodleSize and handle:getMoodleSize() or 32
            local distance = (handle.options and handle.options.moodlesDistance) or 10
            spacing = size + distance
            x = getPlayerScreenLeft(playerNum) + getPlayerScreenWidth(playerNum)
                - 10 - size + ((handle.options and handle.options.moodleOffsetX) or 0)
            y = getPlayerScreenTop(playerNum) + 120
                + ((handle.options and handle.options.moodleOffsetY) or 0)
            y = y + cu.Moodles.slot(id, player) * spacing
        else
            local vanilla = MoodlesUI and MoodlesUI.getInstance and MoodlesUI.getInstance()
            if not vanilla then return place(ui, player, id) end
            size = math.floor(vanilla:getWidth())
            if size < 16 then size = 32 end
            spacing = size + 10
            x, y = vanilla:getAbsoluteX(), vanilla:getAbsoluteY()
            y = y + cu.Moodles.slot(id, player) * spacing
        end

        local frameworkCount = 0
        local frameworkSize = hasMoodleFramework and MF and MF.getSize and MF.getSize()
        if hasMoodleFramework and MF and type(MF.MoodlesStorage) == "table" then
            local stack = MF.MoodlesStorage[playerNum]
            if stack then
                for _, moodle in pairs(stack) do
                    if moodle and not moodle.disable and moodle.getLevel
                        and moodle:getLevel() ~= 0 then
                        frameworkCount = frameworkCount + 1
                    end
                end
            end
        end
        if frameworkCount > 0 then
            frameworkSize = frameworkSize or ((MF.defaultWidth or 32) * (MF.scale or 1))
            y = y + frameworkCount * (frameworkSize + 10)
        end

        ui:setX(x)
        ui:setY(y)
        ui:setWidth(size)
        ui:setHeight(size)
        return size
    end
    cu.Moodles.place = bridgedPlace
    cu.Moodles.__cwMoodleUIFix = true
    casualtiesPlacementInstalled = true
    print("[CWModpackCompatibility][MoodleUIFix] Added Casualties Undead placement bridge for Moodles in Lua.")
end

local function updateMoodleUICompatibility()
    installCasualtiesPlacementBridge()
    if hasMoodlesInLua then keepVanillaMoodlesHidden() end
end

Events.OnPreUIDraw.Add(updateMoodleUICompatibility)
