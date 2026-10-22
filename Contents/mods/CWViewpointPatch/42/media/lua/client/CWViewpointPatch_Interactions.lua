-- Keep this wrapper observational until the missing-menu failure is reproduced.
local installed = false
local lastFailure = {}

local function describe(result)
    if type(result) ~= "table" then return "invalid result: " .. type(result) end
    if result.why then return tostring(result.why) end
    if type(result.labels) == "table" and #result.labels == 0 then
        return "no actions; seen=" .. tostring(result.seen)
    end
    return nil
end

local function wrap(name)
    local original = ViewpointInteract and ViewpointInteract[name]
    if type(original) ~= "function" then return false end
    ViewpointInteract[name] = function(...)
        local ok, result = pcall(original, ...)
        local failure
        if ok then
            failure = describe(result)
        else
            failure = "error: " .. tostring(result)
        end
        if failure ~= lastFailure[name] then
            if failure then print("[CWViewpointPatch] " .. name .. ": " .. failure) end
            lastFailure[name] = failure
        end
        if not ok then error(result, 0) end
        return result
    end
    return true
end

local function install()
    if installed then return end
    if not ViewpointInteract then return end
    local world = wrap("harvest")
    local vehicle = wrap("harvestVehicle")
    installed = world and vehicle
    if installed then print("[CWViewpointPatch] interaction diagnostics active") end
end

Events.OnGameStart.Add(install)
