"""Headless contract checks for tracker diagnostics. Starts no game."""
from pathlib import Path

from lupa.lua51 import LuaRuntime


ROOT = Path(__file__).resolve().parents[1]
LUA_ROOT = ROOT / "Contents/mods/CWModpackCompatibility/42/media/lua"


def runtime(source: Path, bootstrap: str) -> LuaRuntime:
    lua = LuaRuntime()
    lua.execute(bootstrap)
    lua.execute(source.read_text(encoding="utf-8-sig"))
    return lua


server = runtime(
    LUA_ROOT / "server/CWModpackCompatibility_RuntimeDiagnostics.lua",
    r'''
logs={}
print=function(value) table.insert(logs,tostring(value)) end
enabled={traitsAsSkills=true,ProjectALifeNPCs=true}
getActivatedMods=function() return {contains=function(_,id) return enabled[id]==true end} end
function event()
  local value={handlers={}}
  value.Add=function(fn) table.insert(value.handlers,fn) end
  return value
end
Events={OnGameStart=event(),LevelPerk=event()}
getTimestampMs=function() return 5000 end
traitFit={id="FIT"}
perkFitness={getId=function() return "Fitness" end}
TAS={
  Trait={get=function(name) if name=="FIT" then return traitFit end end},
  Spectrum={registry={},getBandForLevel=function(def,level) return def.bands[1] end}
}
fitness={id="TAS.Fitness",source="skill",dynamic=true,perk=perkFitness,bands={{trait="FIT",min=0,max=10}}}
TAS.Spectrum.registry[fitness.id]=fitness
player={
  getUsername=function() return "tester" end,
  getPerkLevel=function(_,perk) return 6 end,
  getModData=function() return {tasSpectra={['TAS.Fitness']={lastAppliedLevel=6}}} end,
  hasTrait=function(_,trait) return trait==traitFit end
}
getPlayer=function() return player end
shellData={ProjectALifeUID="npc-1",ProjectALifeCombatPhase="approach",ProjectALifePathActive=true}
shell={getModData=function() return shellData end,getX=function() return 1 end,getY=function() return 2 end,getZ=function() return 0 end}
ProjectALife={
  Talk={choose=function(_,_) return true,"ok" end},
  Combat={unstick=function(_,_) shellData.ProjectALifePathActive=false; shellData.ProjectALifeCombatPhase=nil; return true end}
}
''',
)
server.execute(
    r'''
Events.OnGameStart.handlers[1]()
Events.LevelPerk.handlers[1](player,perkFitness,6)
local ok,reason=ProjectALife.Talk.choose(player,{uid="npc-1",choice="greet"})
assert(ok==true and reason=="ok")
assert(ProjectALife.Combat.unstick(shell,"blackbox_freeze")==true)
joined=table.concat(logs,"\n")
assert(string.find(joined,"[TASTrace] event=level_perk_after",1,true))
assert(string.find(joined,"expected=FIT current=FIT",1,true))
assert(string.find(joined,"[ALifeTrace] talk_choose",1,true))
assert(string.find(joined,"beforePath=true afterPath=false",1,true))
assert(string.find(joined,"beforePhase=approach afterPhase=none",1,true))
'''
)

client = runtime(
    LUA_ROOT / "client/CWModpackCompatibility_ALifeDiagnostics.lua",
    r'''
logs={}
print=function(value) table.insert(logs,tostring(value)) end
getActivatedMods=function() return {contains=function(_,id) return id=="ProjectALifeNPCs" end} end
function event()
  local value={handlers={}}
  value.Add=function(fn) table.insert(value.handlers,fn) end
  return value
end
Events={OnGameStart=event(),OnServerCommand=event()}
opened=false
ProjectALife={TalkMenu={open=function() opened=true; return "opened" end}}
''',
)
client.execute(
    r'''
Events.OnGameStart.handlers[1]()
assert(ProjectALife.TalkMenu.open(0,"npc-1",nil,"Alex","Nomads")=="opened")
assert(opened==true)
Events.OnServerCommand.handlers[1]("ProjectALife","talkResult",{uid="npc-1",ok=false,reason="busy"})
joined=table.concat(logs,"\n")
assert(string.find(joined,"[ALifeTrace] talk_open",1,true))
assert(string.find(joined,"[ALifeTrace] talk_result",1,true))
assert(string.find(joined,"reason=busy",1,true))
'''
)

print("PASS: runtime diagnostics preserve behavior and emit bounded tracker evidence")
