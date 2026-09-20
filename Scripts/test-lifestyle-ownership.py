"""Contract tests for automatic Lifestyle feature ownership."""

import argparse
from pathlib import Path

from lupa.lua51 import LuaRuntime


parser = argparse.ArgumentParser()
parser.add_argument("--workshop-root", type=Path, required=True)
args = parser.parse_args()

root = Path(__file__).resolve().parents[1]
payload_root = root / "Contents/mods/CWModpackCompatibility/42"
source = payload_root / "media/lua/client/CWModpackCompatibility_LifestyleOwnership.lua"
sandbox = payload_root / "media/sandbox-options.txt"

base = r'''
logs={}; print=function(s) logs[#logs+1]=s end
callbacks={}
Events={
 OnGameStart={Add=function(fn) callbacks.start=fn end},
 OnCreatePlayer={Add=function(fn) callbacks.create=fn end}
}
enabled={}
getActivatedMods=function()
 return {contains=function(_,id) return enabled[id] == true end}
end
require=function() return {} end
getText=function(key)
 if key=='ContextMenu_H_BrushTeeth' then return 'Lifestyle Brush Teeth' end
 return key
end
SandboxVars={CWModpackCompatibility={},LSHygiene={BladderNeedMultiplier=2}}
syncCount=0
LSSync={updateClientData=function() syncCount=syncCount+1 end}
players={}
getNumActivePlayers=function() return #players end
getSpecificPlayer=function(index) return players[index+1] end
function makePlayer(need,value,level)
 local data={bathroomNeed=need,IsDoingToilet=true,
  LSMoodles={BladderNeed={Value=value,Level=level}}}
 return {getModData=function() return data end,data=data}
end
function makeContext()
 local context={options={}}
 context.add=function(self,name) self.options[#self.options+1]=name end
 context.removeOptionByName=function(self,name)
  local kept={}
  for _,value in ipairs(self.options) do
   if value ~= name then kept[#kept+1]=value end
  end
  self.options=kept
 end
 return context
end
mirrorCalls=0; cabinetCalls=0; toiletCalls=0; groundCalls=0
MirrorContextMenu={doMirrorBrushTeethOption=function(_,context)
 mirrorCalls=mirrorCalls+1; context:add('Lifestyle Brush Teeth')
end}
CabinetContextMenu={doBuildMenu=function(_,context)
 cabinetCalls=cabinetCalls+1
 context:add('Lifestyle Brush Teeth'); context:add('Lifestyle Grooming')
 return 'cabinet-result'
end}
ToiletContextMenu={doBuildMenu=function() toiletCalls=toiletCalls+1; return 'toilet-result' end}
ToiletGroundContextMenu={doBuildMenu=function() groundCalls=groundCalls+1; return 'ground-result' end}
'''


def runtime(extra: str) -> LuaRuntime:
    lua = LuaRuntime()
    lua.execute(base)
    lua.execute(extra)
    lua.execute(source.read_text(encoding="utf-8-sig"))
    return lua


lua = runtime(
    """
enabled.LifestyleHobbies=true
enabled.NC_NaturesCall=true
enabled.BrushYourDamnTeeth=true
players[1]=makePlayer(72,0.6,3)
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==0)
assert(players[1].data.bathroomNeed==0 and players[1].data.IsDoingToilet==false)
assert(players[1].data.LSMoodles.BladderNeed.Value==0)
assert(players[1].data.LSMoodles.BladderNeed.Level==0)
assert(syncCount==1)

local mirrorContext=makeContext()
MirrorContextMenu.doMirrorBrushTeethOption(nil,mirrorContext)
assert(mirrorCalls==0 and #mirrorContext.options==0)

local cabinetContext=makeContext()
assert(CabinetContextMenu.doBuildMenu(0,cabinetContext)=='cabinet-result')
assert(cabinetCalls==1 and #cabinetContext.options==1)
assert(cabinetContext.options[1]=='Lifestyle Grooming')

players[1].data.bathroomNeed=40
players[1].data.LSMoodles.BladderNeed.Value=0.4
assert(ToiletContextMenu.doBuildMenu(0)=='toilet-result')
assert(players[1].data.bathroomNeed==0 and players[1].data.LSMoodles.BladderNeed.Value==0)
players[1].data.bathroomNeed=60
assert(ToiletGroundContextMenu.doBuildMenu(0)=='ground-result')
assert(players[1].data.bathroomNeed==0)

local mirrorWrapper=MirrorContextMenu.doMirrorBrushTeethOption
local cabinetWrapper=CabinetContextMenu.doBuildMenu
local toiletWrapper=ToiletContextMenu.doBuildMenu
callbacks.start()
assert(MirrorContextMenu.doMirrorBrushTeethOption==mirrorWrapper)
assert(CabinetContextMenu.doBuildMenu==cabinetWrapper)
assert(ToiletContextMenu.doBuildMenu==toiletWrapper)
"""
)
print("PASS: default ownership disables Lifestyle bladder state/actions and duplicate dental actions")

lua = runtime(
    """
enabled.LifestyleHobbies=true
enabled.NC_NaturesCall=true
enabled.BrushYourDamnTeeth=true
SandboxVars.CWModpackCompatibility.NaturesCallOwnsBathroomNeeds=false
SandboxVars.CWModpackCompatibility.BrushYourDamnTeethOwnsDentalHygiene=true
players[1]=makePlayer(72,0.6,3)
originalMirror=MirrorContextMenu.doMirrorBrushTeethOption
originalCabinet=CabinetContextMenu.doBuildMenu
originalToilet=ToiletContextMenu.doBuildMenu
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==2)
assert(players[1].data.bathroomNeed==72 and players[1].data.LSMoodles.BladderNeed.Value==0.6)
assert(ToiletContextMenu.doBuildMenu==originalToilet)
local mirrorContext=makeContext()
MirrorContextMenu.doMirrorBrushTeethOption(nil,mirrorContext)
assert(#mirrorContext.options==0)
"""
)
print("PASS: Nature's Call ownership can be opted out without disabling BYDT ownership")

lua = runtime(
    """
enabled.LifestyleHobbies=true
enabled.NC_NaturesCall=true
enabled.BrushYourDamnTeeth=true
SandboxVars.CWModpackCompatibility.NaturesCallOwnsBathroomNeeds=true
SandboxVars.CWModpackCompatibility.BrushYourDamnTeethOwnsDentalHygiene=false
players[1]=makePlayer(72,0.6,3)
originalMirror=MirrorContextMenu.doMirrorBrushTeethOption
originalCabinet=CabinetContextMenu.doBuildMenu
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==0)
assert(players[1].data.bathroomNeed==0)
assert(MirrorContextMenu.doMirrorBrushTeethOption==originalMirror)
assert(CabinetContextMenu.doBuildMenu==originalCabinet)
local mirrorContext=makeContext()
MirrorContextMenu.doMirrorBrushTeethOption(nil,mirrorContext)
assert(#mirrorContext.options==1 and mirrorContext.options[1]=='Lifestyle Brush Teeth')
"""
)
print("PASS: BYDT ownership can be opted out without disabling Nature's Call ownership")

lua = runtime(
    """
enabled.LifestyleHobbies=true
players[1]=makePlayer(72,0.6,3)
originalMirror=MirrorContextMenu.doMirrorBrushTeethOption
originalCabinet=CabinetContextMenu.doBuildMenu
originalToilet=ToiletContextMenu.doBuildMenu
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==2)
assert(players[1].data.bathroomNeed==72)
assert(MirrorContextMenu.doMirrorBrushTeethOption==originalMirror)
assert(CabinetContextMenu.doBuildMenu==originalCabinet)
assert(ToiletContextMenu.doBuildMenu==originalToilet)
"""
)
print("PASS: Lifestyle remains untouched when the specialized owner mods are absent")

lua = runtime(
    """
enabled.LifestyleHobbies=true
SandboxVars.LSHygiene.BladderNeedMultiplier=0
players[1]=makePlayer(0,0,0)
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==1)
"""
)
print("PASS: removing Nature's Call restores Lifestyle bathroom needs from an older zero preset")

lua = runtime(
    """
enabled.LifestyleHobbies=true
SandboxVars.LSHygiene.BladderNeedMultiplier=0
SandboxVars.CWModpackCompatibility.RestoreLifestyleBathroomNeedsWhenUnowned=false
players[1]=makePlayer(0,0,0)
"""
)
lua.execute(
    """
callbacks.start()
assert(SandboxVars.LSHygiene.BladderNeedMultiplier==0)
"""
)
print("PASS: automatic Lifestyle bathroom restoration can be opted out")

# Confirm the installed upstream surfaces still match the narrow wrappers.
lifestyle = args.workshop_root / "3403870858/mods/Lifestyle/common/media/lua/client/Hygiene"
mirror_text = (lifestyle / "MirrorContextMenu.lua").read_text(encoding="utf-8-sig")
cabinet_text = (lifestyle / "CabinetContextMenu.lua").read_text(encoding="utf-8-sig")
toilet_text = (lifestyle / "ToiletContextMenu.lua").read_text(encoding="utf-8-sig")
ground_text = (lifestyle / "ToiletGroundContextMenu.lua").read_text(encoding="utf-8-sig")
assert "MirrorContextMenu.doMirrorBrushTeethOption" in mirror_text
assert '"BrushTeeth"' in cabinet_text
assert 'LSMoodles["BladderNeed"].Value < 0.2' in toilet_text
assert 'LSMoodles["BladderNeed"].Value >= 0.4' in ground_text

sandbox_text = sandbox.read_text(encoding="utf-8-sig")
for option in (
    "NaturesCallOwnsBathroomNeeds",
    "RestoreLifestyleBathroomNeedsWhenUnowned",
    "BrushYourDamnTeethOwnsDentalHygiene",
):
    assert f"option CWModpackCompatibility.{option}" in sandbox_text
    assert "default = true" in sandbox_text

print("PASS: installed Lifestyle surfaces and enabled-by-default sandbox contracts are current")
