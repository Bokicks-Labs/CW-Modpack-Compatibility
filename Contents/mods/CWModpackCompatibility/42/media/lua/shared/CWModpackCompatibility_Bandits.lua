-- Bandits' container-loot routine references an out-of-scope enemyCharacter.
-- That becomes a repeated getX() nil error when Week One asks a Bandit to
-- seek supplies. Rebuild only this routine and keep the original task shape.

local function isBanditsActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("Bandits2")
end

-- BanditPrograms.lua's predicate is local to that file, so this replacement
-- needs its own callback for the container's Java/Lua predicate overload.
local function predicateAll(item)
    return true
end

local function installBanditsContainerLootFix()
    if not isBanditsActive() or not BanditPrograms or not BanditPrograms.Container then return end
    if BanditPrograms.Container.__cwSafeLoot then return end

    BanditPrograms.Container.Loot = function(bandit, object, container)
        local tasks = {}
        if not bandit or not object or not container then return tasks end

        local square = object:getSquare()
        if not square then return tasks end

        local bx, by, bz
        local lootDist
        local lootAnim
        if square:isFree(false) then
            bx = object:getX()
            by = object:getY()
            bz = object:getZ()
            lootDist = 1.1
            lootAnim = "LootLow"
        else
            local asquare = AdjacentFreeTileFinder.Find(square, bandit)
            if not asquare then return tasks end
            bx = asquare:getX()
            by = asquare:getY()
            bz = asquare:getZ()
            lootDist = 2.1
            lootAnim = "Loot"
        end

        -- The upstream routine used the unrelated global enemyCharacter here.
        -- Looting is a movement-to-container task, so measure to its target tile.
        local dist = BanditUtils.DistTo(bandit:getX(), bandit:getY(), bx, by)
        if dist < lootDist then
            local items = ArrayList.new()
            container:getAllEvalRecurse(predicateAll, items)
            local task = {
                action = "LootItems",
                anim = lootAnim,
                time = items:size() * 50,
                x = object:getX(),
                y = object:getY(),
                z = object:getZ(),
            }
            table.insert(tasks, task)
        else
            table.insert(tasks, BanditUtils.GetMoveTask(endurance, bx, by, bz, "Run", dist, false))
        end

        return tasks
    end

    BanditPrograms.Container.__cwSafeLoot = true
    print("[CWModpackCompatibility][Bandits] Installed safe container-loot target fix.")
end

if Events.OnGameStart then
    Events.OnGameStart.Add(installBanditsContainerLootFix)
end

if Events.OnServerStarted then
    Events.OnServerStarted.Add(installBanditsContainerLootFix)
end
