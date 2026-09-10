CWModpackCompatibility = CWModpackCompatibility or {}

local Compat = CWModpackCompatibility

local emergencyEvents = {
    CallCops = true,
    CallSWAT = true,
    CallMedics = true,
    CallHazmats = true,
}

local function isWeekOneActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("BanditsWeekOne")
end

local function installChatStartupGuard()
    if not isWeekOneActive() or not BWOChatPanel or not BWOChatPanel.new then return end
    if BWOChatPanel.__cwStartupGuard then return end

    local originalNew = BWOChatPanel.new
    BWOChatPanel.new = function(self, x, y, width, height, character)
        if not character then
            if not Compat.weekOneEarlyChatLogged then
                print("[CWModpackCompatibility][WeekOne] Ignored chat hotkey before player initialization.")
                Compat.weekOneEarlyChatLogged = true
            end
            return {
                initialise = function() end,
                addToUIManager = function() end,
            }
        end
        return originalNew(self, x, y, width, height, character)
    end

    BWOChatPanel.__cwStartupGuard = true
    print("[CWModpackCompatibility][WeekOne] Installed pre-player chat guard.")
end

local function installEmergencyEventDiagnostics()
    if not isWeekOneActive() or not BWOScheduler or not BWOScheduler.Add then return end
    if BWOScheduler.__cwEmergencyEventDiagnostics then return end

    local originalAdd = BWOScheduler.Add
    BWOScheduler.Add = function(eventName, params, timeout)
        if emergencyEvents[eventName] then
            local x = params and params.x or "?"
            local y = params and params.y or "?"
            print("[CWModpackCompatibility][WeekOne] Scheduled " .. tostring(eventName)
                .. " in " .. tostring(timeout) .. " ms at " .. tostring(x) .. "," .. tostring(y) .. ".")
        end
        return originalAdd(eventName, params, timeout)
    end

    BWOScheduler.__cwEmergencyEventDiagnostics = true
    print("[CWModpackCompatibility][WeekOne] Installed emergency-event diagnostics.")
end

installChatStartupGuard()
installEmergencyEventDiagnostics()
Events.OnGameStart.Add(installChatStartupGuard)
Events.OnGameStart.Add(installEmergencyEventDiagnostics)
