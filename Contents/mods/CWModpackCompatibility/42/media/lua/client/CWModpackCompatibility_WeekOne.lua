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

-- BanditsWeekOne's inhabitant path calls the server-only Clan API directly.
-- On a real MP client, forward that request through the normal command path.
local function installInhabitantSpawnBoundary()
    if not isWeekOneActive() then return end
    BanditServer = BanditServer or {}
    BanditServer.Spawner = BanditServer.Spawner or {}
    if BanditServer.Spawner.__cwWeekOneClientBoundary then return end

    BanditServer.Spawner.Clan = function(player, args)
        player = player or (getSpecificPlayer and getSpecificPlayer(0))
        if not player or not args or not args.cid or not sendClientCommand then return end
        sendClientCommand(player, "Spawner", "Clan", args)
    end

    BanditServer.Spawner.__cwWeekOneClientBoundary = true
    print("[CWModpackCompatibility][WeekOne] Routed inhabitant spawns through MP command boundary.")
end

installChatStartupGuard()
installEmergencyEventDiagnostics()
installInhabitantSpawnBoundary()
Events.OnGameStart.Add(installChatStartupGuard)
Events.OnGameStart.Add(installEmergencyEventDiagnostics)
Events.OnGameStart.Add(installInhabitantSpawnBoundary)
