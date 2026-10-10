-- Diagnostic only: observe which stage loses a right-click before changing menus.
local down
local pending
local tick = 0

local function picked()
    return UIManager.getPicked() ~= nil
end

local function cursorMode()
    local bridge = ViewpointQOL
    if bridge and bridge.isAvailable and bridge.isAvailable() and bridge.isCursorMode then
        return tostring(bridge.isCursorMode())
    end
    return "unknown"
end

local function menuVisible()
    local menu = getPlayerContextMenu(0)
    return menu and menu:getIsVisible() or false
end

local function onDown(x, y)
    down = { x = x, y = y, hasPick = picked(), started = getTimestampMs(), cursor = cursorMode() }
end

local function onUp(x, y)
    if not down then return end
    pending = {
        x = x, y = y, hasPick = picked(), down = down,
        heldMs = getTimestampMs() - down.started,
        due = tick + 2,
    }
    down = nil
end

local function onTick()
    tick = tick + 1
    if not pending or tick < pending.due then return end
    local click = pending
    pending = nil
    local changed = click.down.hasPick ~= click.hasPick
    local visible = menuVisible()
    if changed or not visible then
        print("[CWViewpointPatch] right-click cursor=" .. click.down.cursor
            .. " pickerPresenceChanged=" .. tostring(changed)
            .. " downHasPick=" .. tostring(click.down.hasPick)
            .. " upHasPick=" .. tostring(click.hasPick)
            .. " menuVisible=" .. tostring(visible)
            .. " heldMs=" .. tostring(click.heldMs)
            .. " x=" .. tostring(click.x) .. " y=" .. tostring(click.y))
    end
end

Events.OnRightMouseDown.Add(onDown)
Events.OnRightMouseUp.Add(onUp)
Events.OnTick.Add(onTick)
