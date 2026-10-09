-- Temporary, read-only trace for the intermittent duplicate moodle stack.
-- Moodles in Lua moves vanilla MoodlesUI off screen; check whether it returns.
local mods = getActivatedMods and getActivatedMods()
if not mods or not mods:contains("moodlesinlua") then return end

local samples = 0
local lastSignature = {}
local lastLogAt = {}
local MAX_SAMPLES = 120

local function coordinate(ui, method)
    if not ui[method] then return "?" end
    local ok, value = pcall(ui[method], ui)
    return ok and tonumber(value) or "?"
end

local function snapshot(phase)
    if samples >= MAX_SAMPLES then return end
    local list = UIManager and UIManager.getUI and UIManager.getUI()
    if not list then return end

    local vanilla = {}
    local replacement = {}
    local vanillaState = {}
    local replacementState = {}
    local handle = rawget(_G, "ISMoodlesInLuaHandle")
    local width = getCore():getScreenWidth()
    local height = getCore():getScreenHeight()

    for i = 0, list:size() - 1 do
        local ui = list:get(i)
        if ui then
            local isVanilla = instanceof(ui, "MoodlesUI")
            local isReplacement = ui == handle
            if isVanilla or isReplacement then
                local x = coordinate(ui, "getX")
                local y = coordinate(ui, "getY")
                local onScreen = type(x) == "number" and type(y) == "number"
                    and x >= 0 and x < width and y >= 0 and y < height
                local entry = tostring(ui) .. "@" .. tostring(x) .. "," .. tostring(y)
                    .. ":onScreen=" .. tostring(onScreen)
                if isVanilla then
                    vanilla[#vanilla + 1] = entry
                    vanillaState[#vanillaState + 1] = tostring(ui) .. ":" .. tostring(onScreen)
                end
                if isReplacement then
                    replacement[#replacement + 1] = entry
                    replacementState[#replacementState + 1] = tostring(ui) .. ":" .. tostring(onScreen)
                end
            end
        end
    end

    local signature = table.concat(vanillaState, ";") .. "|" .. table.concat(replacementState, ";")
    local detail = "vanilla=" .. #vanilla .. " [" .. table.concat(vanilla, "; ")
        .. "] replacement=" .. #replacement .. " [" .. table.concat(replacement, "; ") .. "]"
    local now = getTimestampMs()
    if signature ~= lastSignature[phase] or now - (lastLogAt[phase] or 0) >= 5000 then
        samples = samples + 1
        lastSignature[phase] = signature
        lastLogAt[phase] = now
        print("[CWModpackCompatibility][MoodleUITrace] " .. phase .. " " .. detail)
        if samples == MAX_SAMPLES then
            print("[CWModpackCompatibility][MoodleUITrace] Sample limit reached; trace stopped.")
        end
    end
end

Events.OnPreUIDraw.Add(function() snapshot("pre") end)
Events.OnPostUIDraw.Add(function() snapshot("post") end)
print("[CWModpackCompatibility][MoodleUITrace] Watching moodle UI positions; no rendering changes.")
