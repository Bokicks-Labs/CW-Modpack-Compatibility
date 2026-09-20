"""Checks fixes from the supplied server logs using installed Lua under Lua 5.1."""
import argparse
import hashlib
import re
from pathlib import Path
from lupa.lua51 import LuaRuntime

parser = argparse.ArgumentParser()
parser.add_argument('--workshop-root', type=Path, required=True)
parser.add_argument('--game-root', type=Path, required=True)
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]
payload = root / 'Contents/mods/CWModpackCompatibility/42/media/lua'
payload_root = root / 'Contents/mods/CWModpackCompatibility/42'
base = '''
logs={}; print=function(s) logs[#logs+1]=s end
callbacks={}
Events={OnGameStart={Add=function(fn) callbacks.start=fn end},
 OnServerStarted={Add=function(fn) callbacks.server=fn end}}
enabled={}; getActivatedMods=function() return {contains=function(_,id) return enabled[id] end} end
require=function() return {} end
ISBaseTimedAction={}
function ISBaseTimedAction:derive(name)
 local class={Type=name}; class.__index=class
 return setmetatable(class,{__index=self})
end
function ISBaseTimedAction.new(class,character)
 return setmetatable({character=character},class)
end
'''

lua = LuaRuntime()
lua.execute(base)
lua.execute('''
enabled.NC_NaturesCall=true
worldHours=24; resetCount=0; originalCalls=0; originalDelta=nil
NaturesCall={
 Utils={getWorldAgeHours=function() return worldHours end},
 State={ActiveSessionMaxDeltaHours=0.25},
 System={}
}
NaturesCall.State.ensurePlayerData=function(player) return player.nc end
NaturesCall.State.resetSessionUpdateTimestamps=function(player)
 resetCount=resetCount+1
 player.nc.lastUpdateHours=worldHours
 return player.nc
end
NaturesCall.System.runCatchUp=function(player)
 originalCalls=originalCalls+1
 originalDelta=worldHours-player.nc.lastUpdateHours
end
freshPlayer={nc={lastUpdateHours=0,bladderFill=0,bowelFill=0},
 getHoursSurvived=function() return 0 end}
existingNeeds={nc={lastUpdateHours=0,bladderFill=0,bowelFill=50},
 getHoursSurvived=function() return 0 end}
establishedPlayer={nc={lastUpdateHours=0,bladderFill=0,bowelFill=0},
 getHoursSurvived=function() return 2 end}
''')
lua.execute((payload / 'shared/CWModpackCompatibility.lua').read_text(encoding='utf-8-sig'))
lua.execute('''
assert(NaturesCall.System.__cwFreshSpawnClockGuard==true)
local wrapped=NaturesCall.System.runCatchUp
NaturesCall.System.runCatchUp(freshPlayer)
assert(resetCount==1 and originalCalls==1 and originalDelta==0)
assert(freshPlayer.nc.lastUpdateHours==24)
NaturesCall.System.runCatchUp(existingNeeds)
assert(resetCount==1 and originalCalls==2 and originalDelta==24)
NaturesCall.System.runCatchUp(establishedPlayer)
assert(resetCount==1 and originalCalls==3 and originalDelta==24)
callbacks.start()
assert(NaturesCall.System.runCatchUp==wrapped, 'event retry must not double-wrap')
assert(logs[1]=="[CWModpackCompatibility] Installed Nature's Call fresh-spawn clock guard.")
assert(string.find(logs[2], "Skipped Nature's Call fresh-spawn clock jump", 1, true))
''')
print("PASS: Nature's Call fresh-spawn clock jump is intercepted before catch-up; existing needs and saves are unchanged")

lua = LuaRuntime()
lua.execute(base)
lua.execute('''
enabled.CleanUI=true; enabled.EquipmentUI_B42=true
tooltipCalls=0; contextMenu=nil
ISInventoryPane={updateTooltip=function(self)
 tooltipCalls=tooltipCalls+1
 return 'upstream-result'
end}
getPlayerContextMenu=function() return contextMenu end
pane={player=0}
''')
lua.execute((payload / 'client/CWModpackCompatibility_CleanUIEquipmentTooltip.lua').read_text(encoding='utf-8-sig'))
lua.execute('''
callbacks.start()
local wrapped=ISInventoryPane.updateTooltip
assert(ISInventoryPane.__cwCleanUIEquipmentTooltipFix==true)
assert(ISInventoryPane.updateTooltip(pane)==nil and tooltipCalls==0)
contextMenu={isAnyVisible=function() return false end}
assert(ISInventoryPane.updateTooltip(pane)=='upstream-result' and tooltipCalls==1)
callbacks.start()
assert(ISInventoryPane.updateTooltip==wrapped, 'event retry must not double-wrap')
''')
print('PASS: CleanUI/Equipment UI tooltip skips transient nil context menus and preserves normal delegation')

yoga = args.workshop_root / '3403870858/mods/Lifestyle/common/media/lua/shared/TimedActions/LSYogaAction.lua'
upstream_anims = args.workshop_root / '3403870858/mods/Lifestyle/common/media/anims_X'
compat_anims = payload_root / 'media/anims_X'
assert not (payload / 'client/CWModpackCompatibility_LifestyleYoga.lua').exists()
assert not (payload_root / 'media/AnimSets/player/actions').exists()
compat_files = sorted(path.name for path in compat_anims.glob('*.fbx'))
upstream_files = sorted(path.name for path in upstream_anims.glob('*.fbx'))
assert len(compat_files) == 400, f'expected 400 mirrored Lifestyle animations, found {len(compat_files)}'
assert compat_files == upstream_files, 'CW Lifestyle animation mirror no longer matches upstream filenames'
for name in compat_files:
    compat_path = compat_anims / name
    upstream_path = upstream_anims / name
    assert compat_path.stat().st_size == upstream_path.stat().st_size, f'animation size drift: {name}'
    assert hashlib.sha256(compat_path.read_bytes()).digest() == hashlib.sha256(upstream_path.read_bytes()).digest(), (
        f'animation content drift: {name}'
    )
lua = LuaRuntime()
lua.execute(base)
lua.execute('''
enabled.LifestyleHobbies=true
Perks={Fitness=1}; SandboxVars={Yoga={}}
character={getModData=function() return {} end,
 isTimedActionInstant=function() return false end,getPerkLevel=function() return 5 end}
yogaArgs={'Beginner',0.2,1.25,8}
''')
source = yoga.read_text(encoding='utf-8-sig')
params = [p.strip() for p in re.search(r'function LSYogaAction:new\(([^)]+)\)', source)[1].split(',')]
assert params == ['character', 'skillLevel', 'Args'], 'upstream yoga constructor field contract changed'
lua.execute(source)
lua.execute('serverNew=LSYogaAction.new')
action = lua.eval('LSYogaAction:new(character,2,yogaArgs)')
# NetTimedAction serializes fields using the constructor parameter names.
serialized = {name: lua.eval('rawget')(action, name) for name in params}
result = lua.globals().serverNew(lua.globals().LSYogaAction, *[serialized.get(name) for name in params])
lua.globals().roundtrip = result
lua.execute('''
assert(roundtrip.skillLevel==2 and roundtrip.skillGroup=='Beginner')
assert(roundtrip.baseFailChance==0.2 and roundtrip.efficiency==1.25 and roundtrip.poseLimit==8)
assert(roundtrip.Args==yogaArgs and roundtrip.maxTime==-1)
assert(roundtrip:complete()==true)
''')
print('PASS: upstream yoga roundtrip is current; obsolete CW wrapper/XML overrides are absent; 400-file animation mirror matches Lifestyle')

lua = LuaRuntime()
lua.execute(base)
lua.execute('''
ISWearClothing={isStopOnWalk=function() return false end}
isClient=function() return false end
instanceof=function() return false end
ItemTag={REPLACE_PRIMARY=1}
removed=0; added=0; unworn=0; events=0
function makeVisual()
 local v={}
 for _,name in ipairs({'getTint','getBaseTexture','getTextureChoice','getDecal'}) do
  v[name]=function() return name end
 end
 for _,name in ipairs({'setTint','setBaseTexture','setTextureChoice','setDecal','copyDirt','copyBlood','copyHoles','copyPatches'}) do
  v[name]=function(self,value) self[name..'Value']=value end
 end
 return v
end
function makeItem(id)
 local visual=makeVisual()
 return {getID=function() return id end,getVisual=function() return visual end,
  getClothingItem=function() return {} end,getColor=function() return 'red' end,
  getCondition=function() return 42 end,isFavorite=function() return true end,
  getWetness=function() return 0.3 end,hasModData=function() return true end,
  getModData=function() return {source='preserve'} end,
  IsInventoryContainer=function() return false end,IsClothing=function() return true end,
  getFluidContainer=function() return nil end,hasTag=function() return false end,
  getBodyLocation=function() return 'Head' end,copyPatchesTo=function() end,
  setColor=function(self,v) self.color=v end,setWetness=function(self,v) self.wetness=v end,
  setCondition=function(self,v) self.condition=v end,setFavorite=function(self,v) self.favorite=v end,
  copyModData=function(self,v) self.copiedModData=v end,synchWithVisual=function() end}
end
old=makeItem(101); newItem=makeItem(102)
inventory={current=old,getItemById=function(self,id) return id==101 and self.current==old and old or nil end,
 contains=function(self,item) return self.current==item end,
 Remove=function(self,item) assert(self.current==item); self.current=nil; removed=removed+1 end,
 AddItem=function(self,item) self.current=item; added=added+1 end}
character={getInventory=function() return inventory end,isTimedActionInstant=function() return false end,
 isEquippedClothing=function() return true end,removeFromHands=function() end,
 removeWornItem=function() unworn=unworn+1 end,setWornItem=function(self,loc,item) self.worn=item end}
instanceItem=function(kind) assert(kind=='Base.TestAlternative'); return newItem end
sendRemoveItemFromContainer=function() end; sendAddItemToContainer=function() end
sendClothing=function() end; syncVisuals=function() end
triggerEvent=function() events=events+1 end
''')
clothing = args.game_root / 'media/lua/shared/TimedActions/ISClothingExtraAction.lua'
lua.execute(clothing.read_text(encoding='utf-8-sig'))
lua.execute('''
-- Invoke with the real class lookup, as a reconstructed server action would.
local missing=ISClothingExtraAction:new(character,nil,'Base.TestAlternative')
local ok=pcall(function() missing:complete() end)
assert(not ok and removed==0 and added==0, 'upstream nil item reproduces incomplete transformation')
unworn=0
''')
lua.execute((payload / 'shared/CWModpackCompatibility_ClothingExtra.lua').read_text())
lua.execute('''
callbacks.start(); local constructor=ISClothingExtraAction.new
callbacks.server(); assert(constructor==ISClothingExtraAction.new)
local client=ISClothingExtraAction:new(character,old,'Base.TestAlternative')
assert(client.itemId==101)
local server=ISClothingExtraAction:new(character,nil,client.extra,client.itemId)
assert(server.item==old and server.maxTime==1)
assert(server:complete()==true)
assert(removed==1 and added==1 and unworn==1 and events==1)
assert(inventory.current==newItem and character.worn==newItem)
assert(newItem.condition==42 and newItem.favorite and newItem.color=='red' and newItem.wetness==0.3)
assert(newItem.copiedModData.source=='preserve')
assert(server:complete()==true and removed==1 and added==1, 'duplicate completion must not create another item')
local missing=ISClothingExtraAction:new(character,nil,'Base.TestAlternative',999)
assert(missing:complete()==true and removed==1 and added==1 and unworn==1)
-- Independent case: the item resolves when queued, but its Lua reference is
-- lost before completion. Recovery must still perform the real transformation.
inventory.current=old; newItem=makeItem(103)
removed=0; added=0; unworn=0; events=0
local late=ISClothingExtraAction:new(character,old,'Base.TestAlternative')
late.item=nil
assert(late:complete()==true and late.item==old)
assert(removed==1 and added==1 and inventory.current==newItem)
''')
print('PASS: real clothing transformation, ID recovery, appearance/properties, duplicate and missing-target safety')

dt = args.workshop_root / '3635333613/mods/DynamicTradingCommon/42.16/media/lua/shared'
context_key = 'DT/Common/GeolocatorSystem/GeolocatorSystemLocation/DT_GeolocatorSystemLocation_Context'
lifecycle_key = 'DT/Common/Faction/TradingSys/Factions/Lifecycle/DT_Lifecycle_Context'
queue_key = 'DT/Common/Faction/TradingSys/Factions/Lifecycle/DT_Lifecycle_Queue'
startup_source = (payload / 'server/CWModpackCompatibility_DynamicTradingStartup.lua').read_text()
lua = LuaRuntime()
lua.execute(base)
lua.execute('''
server=true; isServer=function() return server end
onlineCalls=0; networkReady=false
onlinePlayer={getX=function() return 100 end,getY=function() return 200 end}
getOnlinePlayers=function()
 onlineCalls=onlineCalls+1
 if not networkReady then error('GameServer.udpEngine is null') end
 return {size=function() return 1 end,get=function() return onlinePlayer end}
end
getSpecificPlayer=function() return nil end
''')
location = lua.execute((dt / (context_key + '.lua')).read_text())
lua.execute('lifecycle={Lifecycle={},deferredTownQueue={}}')
factory = lua.execute((dt / (queue_key + '.lua')).read_text())
factory(lua.globals().lifecycle)
lua.globals().location = location
lua.execute('''
assert(not pcall(location.collectSpatialAnchorPlayers))
assert(not pcall(lifecycle.collectSpatialAnchorPlayers))
onlineCalls=0
modules={}
''')
lua.globals().modules[context_key] = location
lua.globals().modules[lifecycle_key] = lua.globals().lifecycle
lua.execute('require=function(key) return modules[key] end')
# Dedicated-server and affected-mod guards must leave the original contexts alone.
lua.execute(startup_source)
assert lua.eval('location.__cwStartupAnchors == nil') is True
lua.execute('enabled.DynamicTradingCommon=true; server=false')
lua.execute(startup_source)
lua.execute('assert(location.__cwStartupAnchors==nil); server=true')
lua.execute(startup_source)
lua.execute('''
firstLocation=location.collectSpatialAnchorPlayers
firstLifecycle=lifecycle.collectSpatialAnchorPlayers
firstStartupCallback=callbacks.server
assert(#location.collectSpatialAnchorPlayers()==0)
assert(#lifecycle.collectSpatialAnchorPlayers()==0 and onlineCalls==0)
''')
lua.execute(startup_source)
lua.execute('''
assert(firstLocation==location.collectSpatialAnchorPlayers and firstLifecycle==lifecycle.collectSpatialAnchorPlayers)
assert(firstStartupCallback==callbacks.server)
assert(#location.collectSpatialAnchorPlayers()==0)
networkReady=true; callbacks.server()
local a=location.collectSpatialAnchorPlayers(); local b=lifecycle.collectSpatialAnchorPlayers()
assert(#a==1 and a[1]==onlinePlayer and #b==1 and b[1]==onlinePlayer and onlineCalls==2)
assert(getOnlinePlayers():size()==1, 'game global was preserved')
''')
print('PASS: both real DT collectors skip pre-network queries and restore player lookup after server start; SP/mod-off unchanged')

# The supplied server log also names a missing T-shirt ID used in real DT looks.
lua = LuaRuntime()
lua.execute(base)
lua.execute('''
oldDefined=false; replacementDefined=true
getScriptManager=function() return {FindItem=function(_,id)
 if id=='Base.Tshirt_White' then return oldDefined and {} end
 if id=='Base.Tshirt_WhiteTINT' then return replacementDefined and {} end
end} end
''')
angler = args.workshop_root / '3635333613/mods/DynamicTradingCommon/common/media/lua/shared/DT/Common/ArchetypeDefinitions/Angler/Definitions/DT_Angler_Looks.lua'
lua.execute(angler.read_text(encoding='utf-8-sig'))
lua.execute((payload / 'shared/CWModpackCompatibility_DynamicTrading.lua').read_text())
lua.execute('''
local looks=DynamicTrading.ArchetypeLooks.Angler
local hair=looks.HairStyles
callbacks.start(); assert(looks.Male[1][3]=='Base.Tshirt_White')
enabled.DynamicTradingCommon=true; oldDefined=true
callbacks.start(); assert(looks.Male[1][3]=='Base.Tshirt_White', 'custom valid legacy ID must remain')
oldDefined=false; replacementDefined=false
callbacks.start(); assert(looks.Male[1][3]=='Base.Tshirt_White', 'replacement must exist')
replacementDefined=true; callbacks.server()
assert(looks.Male[1][3]=='Base.Tshirt_WhiteTINT' and looks.Female[1][3]=='Base.Tshirt_WhiteTINT')
assert(looks.Male[1][1]=='Base.Hat_BucketHatFishing' and looks.HairStyles==hair)
local logCount=#logs; callbacks.start(); assert(#logs==logCount, 'wardrobe repair is idempotent')
''')
print('PASS: installed wardrobe presets repaired only when legacy ID is absent and replacement exists')
