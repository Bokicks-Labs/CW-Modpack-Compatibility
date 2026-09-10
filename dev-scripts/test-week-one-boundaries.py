"""Headless Lua contract checks. Requires Python package lupa; no game is started."""
from pathlib import Path

from lupa import LuaRuntime


ROOT = Path(__file__).resolve().parents[1]
CLIENT = ROOT / "Contents/mods/CWModpackCompatibility/42/media/lua/client/CWModpackCompatibility_WeekOne.lua"
SERVER = ROOT / "Contents/mods/CWModpackCompatibility/42/media/lua/server/CWModpackCompatibility_WeekOneServer.lua"


client = LuaRuntime()
client.execute(
    """
callbacks = {}
Events = {
    OnGameStart = {Add = function(fn) callbacks.start = fn end},
    OnInitGlobalModData = {Add = function(fn) callbacks.init = fn end},
    OnReceiveGlobalModData = {Add = function(fn) callbacks.receive = fn end},
}
getActivatedMods = function() return {contains = function(_, id) return id == "BanditsWeekOne" end} end
gmd = {Variant = "original"}
GetBWOModData = function() return gmd end
BWOVariants = {
    [1] = {name = "Original", schedule = {first = true}},
    [2] = {name = "Bandits", schedule = {second = true}},
}
BWOScheduler = {Add = function() end, Schedule = {stale = true}}
commands = {}
sendClientCommand = function(player, module, command, args)
    table.insert(commands, {player = player, module = module, command = command, args = args})
end
getSpecificPlayer = function() return player end
"""
)
client.execute(CLIENT.read_text(encoding="utf-8-sig"))
client.execute(
    """
assert(gmd.Variant == 1, "string variant must resolve to Original's numeric key")
assert(BWOScheduler.Schedule == nil, "variant repair must invalidate cached schedule")
gmd = {}
callbacks.init()
assert(gmd.Variant == 1, "Global ModData initialization must repair the replacement table")
player = {id = 7}
callbacks.start()
assert(#commands == 1 and commands[1].module == "Commands" and commands[1].command == "SetVariant")
assert(commands[1].args.variant == 1, "client must synchronize repaired variant")
BanditServer.Spawner.Clan(player, {cid = 4, x = 10, y = 20})
assert(#commands == 2 and commands[2].module == "Spawner" and commands[2].command == "Clan")
local received = {Variant = "2"}
callbacks.receive("BanditWeekOne", received)
assert(received.Variant == 2, "numeric-string variants must resolve")
callbacks.receive("OtherMod", {Variant = "bad"})
"""
)

server = LuaRuntime()
server.execute(
    """
callbacks = {}
Events = {
    OnInitGlobalModData = {Add = function(fn) callbacks.init = fn end},
    OnServerStarted = {Add = function(fn) callbacks.started = fn end},
}
getActivatedMods = function() return {contains = function(_, id) return id == "BanditsWeekOne" end} end
BWOVariants = {
    [1] = {name = "Original", schedule = {}},
    [2] = {name = "Bandits", schedule = {}},
}
gmd = {}
GetBWOModData = function() return gmd end
transmits = 0
TransmitBWOModData = function() transmits = transmits + 1 end
"""
)
server.execute(SERVER.read_text(encoding="utf-8-sig"))
server.execute(
    """
assert(gmd.Variant == 1, "dedicated server must default to Original")
assert(transmits == 1, "server must transmit repaired state")
callbacks.started()
assert(transmits == 1, "valid state must remain idempotent")
gmd.Variant = "Bandits"
callbacks.init()
assert(gmd.Variant == 2 and transmits == 2, "named server variant must resolve and transmit")
"""
)

print("PASS: Week One variant repair, server synchronization, and inhabitant command boundary.")
