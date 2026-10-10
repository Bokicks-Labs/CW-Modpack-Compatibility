-- Sample close contacts at a low rate; never move characters or change bump state.
local frame = 0
local inContact = false
local lastLog = 0

local function nearestZombie(player)
    local cell = getCell()
    local zombies = cell and cell:getZombieList()
    if not zombies then return nil, nil end
    local closest, distance2
    for i = 0, zombies:size() - 1 do
        local zombie = zombies:get(i)
        if zombie and math.abs(zombie:getZ() - player:getZ()) < 0.3 then
            local dx = zombie:getX() - player:getX()
            local dy = zombie:getY() - player:getY()
            local candidate = dx * dx + dy * dy
            if not distance2 or candidate < distance2 then
                closest, distance2 = zombie, candidate
            end
        end
    end
    return closest, distance2
end

local function onTick()
    frame = frame + 1
    if frame % 12 ~= 0 then return end
    local player = getSpecificPlayer(0)
    if not player or not player:isAlive() or player:getVehicle() then
        inContact = false
        return
    end
    local zombie, distance2 = nearestZombie(player)
    local close = zombie and distance2 < 0.36
    if not close then
        inContact = false
        return
    end
    local now = getTimestampMs()
    if inContact and now - lastLog < 1000 then return end
    inContact = true
    lastLog = now
    print("[CWViewpointPatch] close zombie distance=" .. string.format("%.2f", math.sqrt(distance2))
        .. " bump=" .. tostring(player:isBumped())
        .. " bumpedThisZombie=" .. tostring(player:getBumpedChr() == zombie)
        .. " skipCollision=" .. tostring(player:isSkipResolveCollision())
        .. " state=" .. tostring(player:getCurrentActionContextStateName())
        .. " player=" .. string.format("%.2f,%.2f", player:getX(), player:getY())
        .. " zombie=" .. string.format("%.2f,%.2f", zombie:getX(), zombie:getY()))
end

Events.OnTick.Add(onTick)
