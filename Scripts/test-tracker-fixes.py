"""Regression checks using installed upstream Lua. Requires lupa; starts no game."""
import argparse
from pathlib import Path
from lupa.lua51 import LuaRuntime

parser = argparse.ArgumentParser()
parser.add_argument('--workshop-root', type=Path, required=True)
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]
payload = root / 'Contents/mods/CWModpackCompatibility/42/media/lua'
core = args.workshop_root / '3635333613/mods/DynamicTradingV2/42.16/media/lua/shared/DT/V2/NPC/Sys/EquipmentVisuals/DTNPC_EquipmentVisuals_Core.lua'
minute = args.workshop_root / '3403870858/mods/Lifestyle/common/media/lua/client/LSEffects/LSPerMinute.lua'

bootstrap = '''
logs = {}
print = function(message) logs[#logs+1] = message end
callbacks = {}
Events = {
 OnGameStart={Add=function(fn) callbacks.start=fn end},
 OnServerStarted={Add=function(fn) callbacks.server=fn end},
 EveryOneMinute={Add=function(fn) minuteCallback=fn end,
   Remove=function(fn) assert(fn == minuteCallback); minuteCallback=nil end},
}
enabled = {}
getActivatedMods = function() return {contains=function(_,id) return enabled[id] end} end
calls = 0
function npc(valid)
 local group = {getLocation=function(_,slot) return valid[slot] and {} or nil end}
 return {
  getAttachedItems=function() return {getGroup=function() return group end} end,
  setAttachedItem=function(_,slot,item)
   calls=calls+1
   if not valid[slot] then error('no such location '..slot) end
   lastSlot=slot; lastItem=item
  end,
 }
end
'''

# First demonstrate the upstream invalid call, then use a fresh runtime so its
# global blocked-slot cache cannot obscure whether CW prevents that call.
baseline = LuaRuntime()
baseline.execute(bootstrap)
baseline.execute(core.read_text(encoding='utf-8-sig'))
baseline.execute('''
assert(not DTNPCEquipmentVisuals.Helpers.trySetAttachedItem(npc({}), 'BeltOldFlashlightLeft', nil))
assert(calls == 1, 'upstream enters Java before detecting the missing slot')
''')

lua = LuaRuntime()
lua.execute(bootstrap)
lua.execute(core.read_text(encoding='utf-8-sig'))
lua.execute((payload / 'shared/CWModpackCompatibility_DynamicTrading.lua').read_text())
lua.execute('''
local original=DTNPCEquipmentVisuals.Helpers.trySetAttachedItem
callbacks.start()
assert(original == DTNPCEquipmentVisuals.Helpers.trySetAttachedItem)
enabled.DynamicTradingV2=true
callbacks.server()
local guarded=DTNPCEquipmentVisuals.Helpers.trySetAttachedItem
assert(original ~= guarded)
callbacks.start()
assert(guarded == DTNPCEquipmentVisuals.Helpers.trySetAttachedItem)
local z=npc({Back=true})
for i=1,3 do
 assert(not guarded(z,'BeltOldFlashlightLeft',nil))
 assert(not guarded(z,'BeltOldFlashlightRight',{}))
end
assert(calls == 0, 'unsupported slots must never enter setAttachedItem')
assert(not DTNPCEquipmentVisuals.BlockedAttachmentSlots.BeltOldFlashlightLeft)
local item={}
assert(guarded(z,'Back',item)); assert(lastItem == item)
assert(guarded(z,'Back',nil)); assert(lastItem == nil)
-- Registration differs by group; a rejected slot must remain usable elsewhere.
assert(guarded(npc({BeltOldFlashlightLeft=true}), 'BeltOldFlashlightLeft', item))
assert(not guarded(nil,'Back',item))
assert(not guarded(z,nil,item))
assert(not guarded(z,'',item))
local fallback=npc({Back=true}); fallback.getAttachedItems=nil
assert(guarded(fallback,'Back',item), 'unavailable group delegates to upstream')
assert(calls == 4)
''')
print('PASS: installed Dynamic Trading regression, delegation, group isolation, activation and idempotence')

# Execute the real Lifestyle minute function while sleeping to avoid unrelated
# hobby/UI work; leave the general mood calculation and decay untouched.
lua = LuaRuntime()
lua.execute(bootstrap)
lua.execute('''
require=function() return {} end
CharacterTrait={}; CharacterStat={}
SandboxVars={Text={}, LSComfort={ComfortNoImpact=true}}
LSUtil={getValidCharacter=function(p) return p end}
data={LSMoodles={}, Ambitions={}, LSClothes={}, ComfortNeed=0.5, IsOnBed=true}
player={getModData=function() return data end, hasModData=function() return true end,
 getBodyDamage=function() return {} end, isAsleep=function() return true end,
 hasTrait=function() return false end, isGodMod=function() return false end,
 isSittingOnFurniture=function() return false end, getVariableBoolean=function() return false end}
getPlayer=function() return player end
isClient=function() return false end
worldAge=1
getGameTime=function() return {getWorldAgeHours=function() return worldAge end} end
enabled.LifestyleHobbies=true
''')
lua.execute(minute.read_text(encoding='utf-8-sig'))
lua.execute((payload / 'client/CWModpackCompatibility_BugDiagnostics.lua').read_text())
lua.execute('''
local names={'Comfort','Uncomfortable','Embarrassed','PartyGood','PartyBad',
 'MusicGood','MusicBad','DJAudience','MintFresh','MintCurio','BathHot','BathCold','Eureka','Gloomy'}
for _,name in ipairs(names) do data.LSMoodles[name]={Value=0} end
data.LSMoodles.Embarrassed.Value=0.2
callbacks.start()
local observed=minuteCallback
callbacks.start(); assert(observed == minuteCallback)
for i=1,40 do worldAge=worldAge+1/60; minuteCallback() end
assert(data.LSMoodles.Embarrassed.Value == 0, 'real upstream decay still clears an isolated failure')
data.LSMoodles.Comfort=nil
local ok=pcall(minuteCallback)
assert(not ok, 'diagnostics must not swallow upstream callback failures')
local found=false
for _,line in ipairs(logs) do
 if line:find('missing=Comfort',1,true) and line:find('callbackOK=false',1,true) then found=true end
end
assert(found, 'missing moodle and callback failure must be observable')
''')
print('PASS: real Lifestyle minute decay unchanged, missing data traced, upstream failures preserved')

lua = LuaRuntime()
lua.execute(bootstrap)
lua.execute('''
enabled.amclub=true
worldAge=1; now=100
getTimestampMs=function() return now end
getGameTime=function() return {getWorldAgeHours=function() return worldAge end} end
counts={start=0,update=0,stop=0,perform=0}
ISPathFindAction={}
for _,name in ipairs({'start','update','stop','perform'}) do
 ISPathFindAction[name]=function(self, arg) counts[name]=counts[name]+1; return arg, 'second' end
end
char={getX=function() return 1 end,getY=function() return 2 end,getZ=function() return 0 end}
bike={getPartById=function(_,id) return id=='AMCConfig' and {} end,
 getScriptName=function() return 'Base.TestBike' end,getId=function() return 123 end,
 getX=function() return 5 end,getY=function() return 6 end}
''')
lua.execute((payload / 'client/CWModpackCompatibility_BugDiagnostics.lua').read_text())
lua.execute('''
callbacks.start(); local installed=ISPathFindAction.start
callbacks.start(); assert(installed==ISPathFindAction.start)
local action={goal={'VehicleAdjacent',bike},character=char}
local a,b=ISPathFindAction.start(action,'start-result'); assert(a=='start-result' and b=='second')
local initial=#logs
ISPathFindAction.update(action); assert(#logs==initial)
now=5100; ISPathFindAction.update(action); assert(#logs==initial+1)
ISPathFindAction.update(action); assert(#logs==initial+1)
assert(ISPathFindAction.stop(action,'stop-result')=='stop-result')
assert(action.__cwBikeVehicle==nil)
ISPathFindAction.start(action)
assert(ISPathFindAction.perform(action,'perform-result')=='perform-result')
assert(action.__cwBikeVehicle==nil)
local vanilla={goal={'LocationF',1,2,0},character=char}
initial=#logs; ISPathFindAction.start(vanilla); ISPathFindAction.update(vanilla)
assert(#logs==initial and vanilla.__cwBikeVehicle==nil)
assert(counts.start==3 and counts.update==4 and counts.stop==1 and counts.perform==1)
''')
print('PASS: motorcycle path delegation, return values, rate limits and unrelated path isolation')
