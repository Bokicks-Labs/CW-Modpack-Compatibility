-- Restore player feedback after Bandits' custom damage model. In multiplayer,
-- the server targets the damaged player's client. In single player, wrap the
-- same damage-model entry points locally without applying any extra damage.

CWModpackCompatibility = CWModpackCompatibility or {}

local lastReactionAt = 0

local function isBanditsActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("Bandits2")
end

local function hitReactionsEnabled()
    local options = SandboxVars and SandboxVars.CWModpackCompatibility
    return not options or options.BanditPlayerHitReactions ~= false
end

local function getOptionNumber(key, fallback, minimum, maximum)
    local options = SandboxVars and SandboxVars.CWModpackCompatibility
    local value = tonumber(options and options[key]) or fallback
    return math.max(minimum, math.min(maximum, value))
end

local function getReactionChance(ranged)
    local key = ranged
        and "BanditPlayerFirearmReactionChance"
        or "BanditPlayerMeleeReactionChance"
    return getOptionNumber(key, 100, 0, 100)
end

local function canReact(player, ranged)
    if not hitReactionsEnabled() or not player or not player.setHitReaction then return false end
    if player.isLocalPlayer and not player:isLocalPlayer() then return false end
    if player.isDead and player:isDead() then return false end
    if player.isOnFloor and player:isOnFloor() then return false end
    if player.getVehicle and player:getVehicle() then return false end

    local chance = getReactionChance(ranged)
    if chance <= 0 or (chance < 100 and ZombRand and ZombRand(100) >= chance) then
        return false
    end

    local cooldownMs = getOptionNumber("BanditPlayerHitReactionCooldownMs", 750, 0, 3000)
    local now = getTimestampMs and getTimestampMs() or 0
    if cooldownMs > 0 and now > 0 and lastReactionAt > 0 and now - lastReactionAt < cooldownMs then
        return false
    end
    lastReactionAt = now
    return true
end

local function applyHitReaction(player, ranged)
    if not canReact(player, ranged) then return end

    player:setHitReaction(ranged and "ShotBelly" or "HitReaction")
end

local function getTargetPlayer(args)
    local playerNum = args and tonumber(args.playerNum) or 0
    local player = getSpecificPlayer and getSpecificPlayer(playerNum) or nil
    if player and (not player.isLocalPlayer or player:isLocalPlayer()) then return player end

    if getNumActivePlayers and getSpecificPlayer then
        for index = 0, getNumActivePlayers() - 1 do
            player = getSpecificPlayer(index)
            if player and (not player.isLocalPlayer or player:isLocalPlayer()) then return player end
        end
    end
    return nil
end

local function onServerCommand(module, command, args)
    if module ~= "CWModpackCompatibility" or command ~= "BanditPlayerHitReaction" then return end
    if not isBanditsActive() then return end
    applyHitReaction(getTargetPlayer(args), args and args.ranged == true)
end

local function wrapSinglePlayerDamage(functionName, ranged)
    local original = PlayerDamageModel and PlayerDamageModel[functionName]
    if not original then return end

    PlayerDamageModel[functionName] = function(shooter, player, ...)
        local result = original(shooter, player, ...)
        if not isClient or not isClient() then
            applyHitReaction(player, ranged)
        end
        return result
    end
end

local function installSinglePlayerHitReactions()
    if not isBanditsActive() or not PlayerDamageModel then return end
    if PlayerDamageModel.__cwPlayerHitReaction then return end

    wrapSinglePlayerDamage("BulletHit", true)
    wrapSinglePlayerDamage("BareHandHit", false)
    wrapSinglePlayerDamage("MeleeHit", false)
    PlayerDamageModel.__cwPlayerHitReaction = true
    print("[CWModpackCompatibility][Bandits] Installed player hit reactions.")
end

installSinglePlayerHitReactions()
if Events and Events.OnGameStart then
    Events.OnGameStart.Add(installSinglePlayerHitReactions)
end
if Events and Events.OnServerCommand then
    Events.OnServerCommand.Add(onServerCommand)
end
