-- Automatic feature ownership for overlapping Lifestyle systems.
-- Keep Lifestyle's unrelated hygiene, grooming, cleaning, and hobby features.

CWModpackCompatibility = CWModpackCompatibility or {}

local Ownership = CWModpackCompatibility.LifestyleOwnership or {}
CWModpackCompatibility.LifestyleOwnership = Ownership

local function log(message)
    print("[CWModpackCompatibility][LifestyleOwnership] " .. tostring(message))
end

local function isActive(modID)
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains(modID)
end

local function optionEnabled(name)
    local options = SandboxVars and SandboxVars.CWModpackCompatibility or nil
    -- Treat an absent value as enabled so existing saves receive the new safe
    -- default even before their SandboxVars file is rewritten.
    return not options or options[name] ~= false
end

local function naturesCallOwnsBathroomNeeds()
    return isActive("LifestyleHobbies")
        and isActive("NC_NaturesCall")
        and optionEnabled("NaturesCallOwnsBathroomNeeds")
end

local function bydtOwnsDentalHygiene()
    return isActive("LifestyleHobbies")
        and isActive("BrushYourDamnTeeth")
        and optionEnabled("BrushYourDamnTeethOwnsDentalHygiene")
end

function Ownership.isLifestyleHygieneDisabled()
    local options = SandboxVars and SandboxVars.CWModpackCompatibility or nil
    return isActive("LifestyleHobbies")
        and (options == nil or options.DisableLifestyleHygieneNeed ~= false)
end

local function neutralizeLifestyleHygiene(player, data)
    data = data or (player and player.getModData and player:getModData())
    if not data then return end
    -- Lifestyle's cleaning actions share DividerHygiene with this need. Keep
    -- that feature group enabled and neutralize only the personal need.
    data.hygieneNeed = 50
    if data.LSMoodles then
        for _, name in ipairs({"HygieneGood", "HygieneBad"}) do
            local moodle = data.LSMoodles[name]
            if moodle then
                moodle.Value = 0
                moodle.Level = 0
            end
        end
    end
end

local function installHygieneOverride()
    if not Ownership.isLifestyleHygieneDisabled() then return false end
    require("Hygiene/HygieneNeed")
    if not Ownership.hygieneInstalled and type(AdjustHygieneNeed) == "function" then
        local original = AdjustHygieneNeed
        AdjustHygieneNeed = function(player, data)
            if Ownership.isLifestyleHygieneDisabled() then
                neutralizeLifestyleHygiene(player, data)
                return
            end
            return original(player, data)
        end
        Ownership.hygieneInstalled = true
    end
    local count = getNumActivePlayers and getNumActivePlayers() or 1
    for playerIndex = 0, count - 1 do
        neutralizeLifestyleHygiene(getSpecificPlayer and getSpecificPlayer(playerIndex))
    end
    return true
end

local function restoreLifestyleBathroomNeedsIfUnowned()
    if not isActive("LifestyleHobbies") or naturesCallOwnsBathroomNeeds()
        or not optionEnabled("RestoreLifestyleBathroomNeedsWhenUnowned") then
        return false
    end

    local hygieneOptions = SandboxVars and SandboxVars.LSHygiene or nil
    if not hygieneOptions or not hygieneOptions.BladderNeedMultiplier
        or hygieneOptions.BladderNeedMultiplier > 0 then
        return false
    end

    -- Older Chaosworld presets disabled this upstream option directly. Restore
    -- Lifestyle's default when CW is no longer assigning the feature to NC.
    hygieneOptions.BladderNeedMultiplier = 1
    if not Ownership.bathroomRestored then
        Ownership.bathroomRestored = true
        log("Restored Lifestyle bathroom needs because Nature's Call ownership is inactive.")
    end
    return true
end

local function clearLifestyleBladder(player)
    if not player or not player.getModData or not naturesCallOwnsBathroomNeeds() then
        return false
    end

    local data = player:getModData()
    if not data then return false end

    local changed = false
    if data.bathroomNeed ~= nil and data.bathroomNeed ~= 0 then
        data.bathroomNeed = 0
        changed = true
    end
    if data.IsDoingToilet then
        data.IsDoingToilet = false
        changed = true
    end

    local bladderMoodle = data.LSMoodles and data.LSMoodles.BladderNeed or nil
    if bladderMoodle then
        if bladderMoodle.Value ~= 0 then
            bladderMoodle.Value = 0
            changed = true
        end
        if bladderMoodle.Level ~= 0 then
            bladderMoodle.Level = 0
            changed = true
        end
    end

    if changed and LSSync and LSSync.updateClientData then
        LSSync.updateClientData(player, data)
    end

    return changed
end

local function clearLocalLifestyleBladders()
    if not naturesCallOwnsBathroomNeeds() then return end

    if SandboxVars and SandboxVars.LSHygiene then
        SandboxVars.LSHygiene.BladderNeedMultiplier = 0
    end

    local count = getNumActivePlayers and getNumActivePlayers() or 1
    for playerIndex = 0, count - 1 do
        local player = getSpecificPlayer and getSpecificPlayer(playerIndex) or nil
        clearLifestyleBladder(player)
    end
end

local function onCreatePlayer(_, player)
    if Ownership.isLifestyleHygieneDisabled() then
        neutralizeLifestyleHygiene(player)
    end
    if not naturesCallOwnsBathroomNeeds() then return end
    if SandboxVars and SandboxVars.LSHygiene then
        SandboxVars.LSHygiene.BladderNeedMultiplier = 0
    end
    clearLifestyleBladder(player)
end

local function installBathroomOwnership()
    if not naturesCallOwnsBathroomNeeds() then return false end

    if SandboxVars and SandboxVars.LSHygiene then
        SandboxVars.LSHygiene.BladderNeedMultiplier = 0
    end

    require("Hygiene/ToiletContextMenu")
    require("Hygiene/ToiletGroundContextMenu")

    if ToiletContextMenu and ToiletContextMenu.doBuildMenu
        and not ToiletContextMenu.__cwNaturesCallOwnership then
        local lifestyleBuildToiletMenu = ToiletContextMenu.doBuildMenu
        ToiletContextMenu.doBuildMenu = function(playerIndex, ...)
            local player = getSpecificPlayer and getSpecificPlayer(playerIndex) or nil
            clearLifestyleBladder(player)
            return lifestyleBuildToiletMenu(playerIndex, ...)
        end
        ToiletContextMenu.__cwNaturesCallOwnership = true
    end

    if ToiletGroundContextMenu and ToiletGroundContextMenu.doBuildMenu
        and not ToiletGroundContextMenu.__cwNaturesCallOwnership then
        local lifestyleBuildGroundMenu = ToiletGroundContextMenu.doBuildMenu
        ToiletGroundContextMenu.doBuildMenu = function(playerIndex, ...)
            local player = getSpecificPlayer and getSpecificPlayer(playerIndex) or nil
            clearLifestyleBladder(player)
            return lifestyleBuildGroundMenu(playerIndex, ...)
        end
        ToiletGroundContextMenu.__cwNaturesCallOwnership = true
    end

    if not Ownership.bathroomInstalled then
        Ownership.bathroomInstalled = true
        log("Nature's Call now owns bathroom needs; disabled Lifestyle bladder progression and relief actions.")
    end
    return true
end

local function removeLifestyleBrushOption(context)
    if context and context.removeOptionByName and getText then
        context:removeOptionByName(getText("ContextMenu_H_BrushTeeth"))
    end
end

local function installDentalOwnership()
    if not bydtOwnsDentalHygiene() then return false end

    require("Hygiene/MirrorContextMenu")
    require("Hygiene/CabinetContextMenu")

    if MirrorContextMenu and MirrorContextMenu.doMirrorBrushTeethOption
        and not MirrorContextMenu.__cwBydtOwnership then
        local lifestyleBuildBrushOption = MirrorContextMenu.doMirrorBrushTeethOption
        MirrorContextMenu.doMirrorBrushTeethOption = function(...)
            if bydtOwnsDentalHygiene() then
                -- Brush Your Damn Teeth owns the brushing action and its item use.
                return
            end
            return lifestyleBuildBrushOption(...)
        end
        MirrorContextMenu.__cwBydtOwnership = true
    end

    if CabinetContextMenu and CabinetContextMenu.doBuildMenu
        and not CabinetContextMenu.__cwBydtOwnership then
        local lifestyleBuildCabinetMenu = CabinetContextMenu.doBuildMenu
        CabinetContextMenu.doBuildMenu = function(playerIndex, context, ...)
            local result = lifestyleBuildCabinetMenu(playerIndex, context, ...)
            if bydtOwnsDentalHygiene() then
                removeLifestyleBrushOption(context)
            end
            return result
        end
        CabinetContextMenu.__cwBydtOwnership = true
    end

    if not Ownership.dentalInstalled then
        Ownership.dentalInstalled = true
        log("Brush Your Damn Teeth now owns dental hygiene; suppressed Lifestyle brushing actions.")
    end
    return true
end

local function applyOwnershipDefaults()
    restoreLifestyleBathroomNeedsIfUnowned()
    installHygieneOverride()
    installBathroomOwnership()
    installDentalOwnership()
    clearLocalLifestyleBladders()
end

if Events.OnCreatePlayer then
    Events.OnCreatePlayer.Add(onCreatePlayer)
end
if Events.OnGameStart then
    Events.OnGameStart.Add(applyOwnershipDefaults)
end
