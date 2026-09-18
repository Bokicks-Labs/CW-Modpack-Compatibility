"""Headless Lua contract checks. Requires Python package lupa; no game is started."""
from pathlib import Path

from lupa import LuaRuntime


ROOT = Path(__file__).resolve().parents[1]
CLIENT = ROOT / "Contents/mods/CWModpackCompatibility/42/media/lua/client/CWModpackCompatibility_BanditsPlayerHitReaction.lua"
SERVER = ROOT / "Contents/mods/CWModpackCompatibility/42/media/lua/server/CWModpackCompatibility_BanditsPlayerHitReactionServer.lua"
SANDBOX = ROOT / "Contents/mods/CWModpackCompatibility/42/media/sandbox-options.txt"


client = LuaRuntime()
client.execute(
    """
callbacks = {}
Events = {
    OnGameStart = {Add = function(fn) callbacks.start = fn end},
    OnServerCommand = {Add = function(fn) callbacks.command = fn end},
}
active = true
clientMode = false
clock = 1000
randomRoll = 0
getActivatedMods = function() return {contains = function(_, id) return active and id == "Bandits2" end} end
getTimestampMs = function() return clock end
ZombRand = function() return randomRoll end
isClient = function() return clientMode end
SandboxVars = {CWModpackCompatibility = {
    BanditPlayerHitReactions = true,
    BanditPlayerHitReactionCooldownMs = 750,
    BanditPlayerFirearmReactionChance = 100,
    BanditPlayerMeleeReactionChance = 100,
}}
calls = {bullet = 0, bare = 0, melee = 0}
PlayerDamageModel = {
    BulletHit = function() calls.bullet = calls.bullet + 1 return "bullet-result" end,
    BareHandHit = function() calls.bare = calls.bare + 1 return "bare-result" end,
    MeleeHit = function() calls.melee = calls.melee + 1 return "melee-result" end,
}
player = {
    localPlayer = true,
    reactions = {},
    isLocalPlayer = function(self) return self.localPlayer end,
    isDead = function() return false end,
    isOnFloor = function() return false end,
    getVehicle = function() return nil end,
    setHitReaction = function(self, reaction) table.insert(self.reactions, reaction) end,
}
getSpecificPlayer = function() return player end
getNumActivePlayers = function() return 1 end
"""
)
client.execute(CLIENT.read_text(encoding="utf-8-sig"))
client.execute(
    """
assert(PlayerDamageModel.BulletHit({}, player) == "bullet-result" and calls.bullet == 1,
    "single-player wrapper must preserve the original result and call count")
assert(#player.reactions == 1 and player.reactions[1] == "ShotBelly",
    "firearm damage must produce a ranged reaction")

clock = 1200
PlayerDamageModel.MeleeHit({}, player, {})
assert(calls.melee == 1 and #player.reactions == 1, "cooldown must suppress only the reaction")

clock = 1800
PlayerDamageModel.BareHandHit({}, player)
assert(calls.bare == 1 and player.reactions[2] == "HitReaction",
    "bare-hand damage must share the melee reaction path")

SandboxVars.CWModpackCompatibility.BanditPlayerHitReactions = false
clock = 3000
PlayerDamageModel.MeleeHit({}, player, {})
assert(calls.melee == 2 and #player.reactions == 2, "master toggle must preserve damage and disable reaction")

SandboxVars.CWModpackCompatibility.BanditPlayerHitReactions = true
SandboxVars.CWModpackCompatibility.BanditPlayerFirearmReactionChance = 0
clock = 4000
PlayerDamageModel.BulletHit({}, player)
assert(calls.bullet == 2 and #player.reactions == 2, "zero firearm chance must disable firearm reactions")

SandboxVars.CWModpackCompatibility.BanditPlayerFirearmReactionChance = 50
randomRoll = 60
clock = 5000
PlayerDamageModel.BulletHit({}, player)
assert(#player.reactions == 2, "reaction chance must reject rolls at or above the configured percent")
randomRoll = 40
clock = 6000
PlayerDamageModel.BulletHit({}, player)
assert(player.reactions[3] == "ShotBelly", "reaction chance must accept rolls below the configured percent")

clientMode = true
clock = 7000
PlayerDamageModel.MeleeHit({}, player, {})
assert(calls.melee == 3 and #player.reactions == 3,
    "multiplayer damage wrapper must wait for the targeted server confirmation")
callbacks.command("CWModpackCompatibility", "BanditPlayerHitReaction", {playerNum = 0, ranged = false})
assert(player.reactions[4] == "HitReaction", "server confirmation must react on the local player")
callbacks.command("OtherModule", "BanditPlayerHitReaction", {playerNum = 0, ranged = true})
assert(#player.reactions == 4, "unrelated server commands must be ignored")
"""
)

inactive_client = LuaRuntime()
inactive_client.execute(
    """
callbacks = {}
Events = {
    OnGameStart = {Add = function(fn) callbacks.start = fn end},
    OnServerCommand = {Add = function(fn) callbacks.command = fn end},
}
getActivatedMods = function() return {contains = function() return false end} end
original = function() return "unchanged" end
PlayerDamageModel = {BulletHit = original, BareHandHit = original, MeleeHit = original}
"""
)
inactive_client.execute(CLIENT.read_text(encoding="utf-8-sig"))
inactive_client.execute(
    """
callbacks.start()
assert(PlayerDamageModel.BulletHit == original and PlayerDamageModel.BareHandHit == original
    and PlayerDamageModel.MeleeHit == original, "Bandits-absent client must remain untouched")
"""
)

server = LuaRuntime()
server.execute(
    """
callbacks = {}
Events = {OnServerStarted = {Add = function(fn) callbacks.started = fn end}}
active = true
getActivatedMods = function() return {contains = function(_, id) return active and id == "Bandits2" end} end
SandboxVars = {CWModpackCompatibility = {BanditPlayerHitReactions = true}}
damageCalls = 0
BanditServer = {Commands = {PlayerDamage = function()
    damageCalls = damageCalls + 1
    return "damage-result"
end}}
commands = {}
sendServerCommand = function(playerArg, module, command, args)
    table.insert(commands, {player = playerArg, module = module, command = command, args = args})
end
player = {getPlayerNum = function() return 2 end}
"""
)
server.execute(SERVER.read_text(encoding="utf-8-sig"))
server.execute(
    """
local result = BanditServer.Commands.PlayerDamage(player, {bullet = true, healthDrop = 5})
assert(result == "damage-result" and damageCalls == 1, "server wrapper must preserve damage behavior")
assert(#commands == 1 and commands[1].player == player
    and commands[1].module == "CWModpackCompatibility"
    and commands[1].command == "BanditPlayerHitReaction",
    "server must target the damaged player")
assert(commands[1].args.playerNum == 2 and commands[1].args.ranged == true,
    "server must preserve player slot and ranged classification")

SandboxVars.CWModpackCompatibility.BanditPlayerHitReactions = false
BanditServer.Commands.PlayerDamage(player, {healthDrop = 3})
assert(damageCalls == 2 and #commands == 1, "disabled toggle must preserve damage without sending reactions")
"""
)

inactive_server = LuaRuntime()
inactive_server.execute(
    """
callbacks = {}
Events = {OnServerStarted = {Add = function(fn) callbacks.started = fn end}}
getActivatedMods = function() return {contains = function() return false end} end
original = function() end
BanditServer = {Commands = {PlayerDamage = original}}
"""
)
inactive_server.execute(SERVER.read_text(encoding="utf-8-sig"))
inactive_server.execute(
    """
callbacks.started()
assert(BanditServer.Commands.PlayerDamage == original, "Bandits-absent server must remain untouched")
"""
)

sandbox_text = SANDBOX.read_text(encoding="utf-8-sig")
for option_name in (
    "BanditPlayerHitReactions",
    "BanditPlayerHitReactionCooldownMs",
    "BanditPlayerFirearmReactionChance",
    "BanditPlayerMeleeReactionChance",
):
    assert f"option CWModpackCompatibility.{option_name}" in sandbox_text

print("PASS: Bandits player hit reactions, balance settings, MP targeting, and absent-mod guards.")
