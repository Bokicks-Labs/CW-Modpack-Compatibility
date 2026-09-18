-- OnInitGlobalModData runs before dedicated-server UDP networking exists.
-- DT already handles an empty player list; avoid calling getOnlinePlayers
-- until OnServerStarted, without replacing the game's global function.
if not isServer() then return end
local mods = getActivatedMods and getActivatedMods()
if not mods or not mods:contains("DynamicTradingCommon") then return end

require("DT/Common/Faction/TradingSys/DynamicTrading_Factions")
local locationContext = require("DT/Common/GeolocatorSystem/GeolocatorSystemLocation/DT_GeolocatorSystemLocation_Context")
local lifecycleContext = require("DT/Common/Faction/TradingSys/Factions/Lifecycle/DT_Lifecycle_Context")

local ready = false
local installed = false
local function guard(context)
    if type(context) ~= "table" or type(context.collectSpatialAnchorPlayers) ~= "function"
            or context.__cwStartupAnchors then return end
    local original = context.collectSpatialAnchorPlayers
    context.collectSpatialAnchorPlayers = function(...)
        if not ready then return {} end
        return original(...)
    end
    context.__cwStartupAnchors = true
    installed = true
end
guard(locationContext)
guard(lifecycleContext)

if installed then
    Events.OnServerStarted.Add(function()
        ready = true
        print("[CWModpackCompatibility][DynamicTrading] Player-anchor queries enabled after server startup.")
    end)
    print("[CWModpackCompatibility][DynamicTrading] Installed pre-network player-anchor guards.")
end
