-- Moodles in Lua hides vanilla MoodlesUI only once per instance. Build 42 can
-- reposition that same instance later, briefly drawing a second moodle stack.
local mods = getActivatedMods and getActivatedMods()
if not mods or not mods:contains("moodlesinlua") then return end

local hiddenCount = 0
local vanillaMoodles = {}
local nextScan = 0
local SCAN_INTERVAL_MS = 250

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

Events.OnPreUIDraw.Add(keepVanillaMoodlesHidden)
