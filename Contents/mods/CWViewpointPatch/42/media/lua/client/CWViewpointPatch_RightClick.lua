-- The native handler ignores a world right-click when Viewpoint's 3D picker
-- resolves different objects on button press and release. This listener runs
-- after it and retries only a short, stationary click over a released object.
local installed = false

local function inViewpoint()
    local mouse = Viewpoint and Viewpoint.Mouse
    if not (mouse and mouse.worldX) then return false end
    local ok, x = pcall(mouse.worldX)
    return ok and x ~= nil
end

local function cursorUnlocked()
    local bridge = ViewpointQOL
    if not (bridge and bridge.isAvailable and bridge.isCursorMode) then return true end
    local ok, unlocked = pcall(function()
        if not bridge.isAvailable() then return true end
        return bridge.isCursorMode()
    end)
    return ok and unlocked == true
end

local function onWorldRightUp(object, x, y)
    local handler = ISObjectClickHandler
    if not (handler and object and handler.rdownObject and handler.rdownObject ~= object) then return end
    if handler.isDoubleClick or not inViewpoint() or not cursorUnlocked() then return end
    local elapsed = getTimestampMs() - (handler.lastRClickTime or 0)
    local dx, dy = x - (handler.downx or x), y - (handler.downy or y)
    if elapsed < 0 or elapsed >= 500 or dx * dx + dy * dy > 144 then return end
    handler.rdownObject = nil
    handler.doRClick(object, x, y)
end

local function install()
    if installed or not (ISObjectClickHandler and Events.OnObjectRightMouseButtonUp) then return end
    Events.OnObjectRightMouseButtonUp.Add(onWorldRightUp)
    installed = true
end

Events.OnGameStart.Add(install)
