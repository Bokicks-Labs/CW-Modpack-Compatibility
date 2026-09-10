"""Headless Lua contract checks. Requires Python package lupa; no game is started."""
from pathlib import Path
from lupa import LuaRuntime

root = Path(__file__).resolve().parents[1]
source = root / 'Contents/mods/CWModpackCompatibility/42/media/lua/shared/CWModpackCompatibility_Bandits.lua'
lua = LuaRuntime()
lua.execute('''
callbacks = {}
Events = {
    OnGameStart = {Add = function(fn) callbacks.start = fn end},
    OnServerStarted = {Add = function(fn) callbacks.server = fn end},
}
active = false
getActivatedMods = function() return {contains = function(_, id) return active and id == 'Bandits2' end} end
original = function() end
BanditPrograms = {Container = {Loot = original}}
BanditUtils = {
    DistTo = function(x, y, bx, by) return math.sqrt((x-bx)^2 + (y-by)^2) end,
    GetMoveTask = function(e, x, y, z, walk, dist, slow)
        return {action='Move', x=x, y=y, z=z, walkType=walk, dist=dist, closeSlow=slow}
    end,
}
ArrayList = {new = function() return {size = function() return 3 end} end}
AdjacentFreeTileFinder = {Find = function() return adjacent end}
function point(x, y, z)
    return {getX=function() return x end, getY=function() return y end, getZ=function() return z end}
end
square = {isFree=function() return free end}
object = point(10, 20, 0)
object.getSquare = function() return square end
container = {getAllEvalRecurse = function(_, predicate, items)
    assert(type(predicate) == 'function', 'container requires a callable predicate')
    assert(predicate({}) == true)
    assert(items:size() == 3)
end}
''')
lua.execute(source.read_text(encoding='utf-8-sig'))
lua.execute('''
callbacks.start()
assert(BanditPrograms.Container.Loot == original, 'disabled Bandits must remain untouched')
active = true
callbacks.start()
local loot = BanditPrograms.Container.Loot
assert(loot ~= original)
callbacks.server()
assert(loot == BanditPrograms.Container.Loot, 'installation must be idempotent')
assert(#loot(nil, object, container) == 0)
assert(#loot(point(10,20,0), nil, container) == 0)
assert(#loot(point(10,20,0), object, nil) == 0)
free = true
local tasks = loot(point(10,20,0), object, container)
assert(#tasks == 1 and tasks[1].action == 'LootItems')
assert(tasks[1].anim == 'LootLow' and tasks[1].time == 150)
assert(tasks[1].x == 10 and tasks[1].y == 20 and tasks[1].z == 0)
tasks = loot(point(0,20,0), object, container)
assert(#tasks == 1 and tasks[1].action == 'Move' and tasks[1].dist == 10)
assert(tasks[1].x == 10 and tasks[1].walkType == 'Run' and tasks[1].closeSlow == false)
free = false
assert(#loot(point(0,20,0), object, container) == 0, 'no adjacent tile must yield no tasks')
adjacent = point(9,20,0)
tasks = loot(point(9,20,0), object, container)
assert(tasks[1].action == 'LootItems' and tasks[1].anim == 'Loot')
tasks = loot(point(0,20,0), object, container)
assert(tasks[1].action == 'Move' and tasks[1].x == 9 and tasks[1].dist == 9)
square = nil
assert(#loot(point(0,20,0), object, container) == 0)
''')
print('PASS: loot callback, task fields, movement, guards, activation, and event idempotence (Lua mocks).')
