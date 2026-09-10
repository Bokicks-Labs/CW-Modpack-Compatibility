-- Bandits applies its custom player damage on the server without notifying the
-- damaged client that a hit reaction should play. Echo only successful Bandits
-- PlayerDamage commands to that player; the client owns visual presentation.

CWModpackCompatibility = CWModpackCompatibility or {}

local function isBanditsActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("Bandits2")
end

local function hitReactionsEnabled()
    local options = SandboxVars and SandboxVars.CWModpackCompatibility
    return not options or options.BanditPlayerHitReactions ~= false
end

local function installBanditPlayerDamageBoundary()
    if not isBanditsActive() or not BanditServer or not BanditServer.Commands then return end
    if BanditServer.Commands.__cwPlayerHitReaction then return end

    local originalPlayerDamage = BanditServer.Commands.PlayerDamage
    if not originalPlayerDamage then return end

    BanditServer.Commands.PlayerDamage = function(player, args)
        local result = originalPlayerDamage(player, args)

        if hitReactionsEnabled() and player and args and sendServerCommand then
            sendServerCommand(player, "CWModpackCompatibility", "BanditPlayerHitReaction", {
                playerNum = player.getPlayerNum and player:getPlayerNum() or 0,
                ranged = args.bullet == true,
            })
        end

        return result
    end

    BanditServer.Commands.__cwPlayerHitReaction = true
    print("[CWModpackCompatibility][Bandits] Installed player hit-reaction boundary.")
end

installBanditPlayerDamageBoundary()
if Events and Events.OnServerStarted then
    Events.OnServerStarted.Add(installBanditPlayerDamageBoundary)
end
