-- Bounded runtime observations for tracker issues. These wrappers do not
-- change trait reconciliation, dialogue results, or NPC movement decisions.
local function active(id)
    local mods = getActivatedMods and getActivatedMods() or nil
    return mods and mods:contains(id)
end

local function safeCall(target, method, fallback)
    if target == nil or type(target[method]) ~= "function" then return fallback end
    local ok, value = pcall(target[method], target)
    if ok then return value end
    return fallback
end

local function traitNames(value)
    if type(value) == "table" then return table.concat(value, ",") end
    return value and tostring(value) or "none"
end

local function hasNamedTrait(player, name)
    if player == nil or name == nil or TAS == nil or TAS.Trait == nil then return false end
    local trait = TAS.Trait.get(name)
    return trait ~= nil and player:hasTrait(trait)
end

local function currentTraits(player, def)
    local found = {}
    for _, band in ipairs(def.bands or {}) do
        local names = type(band.trait) == "table" and band.trait or { band.trait }
        for _, name in ipairs(names) do
            if hasNamedTrait(player, name) then found[#found + 1] = tostring(name) end
        end
    end
    return #found > 0 and table.concat(found, ",") or "none"
end

local function perkName(perk)
    if perk == nil then return "nil" end
    local name = safeCall(perk, "getId", nil) or safeCall(perk, "getName", nil)
    return tostring(name or perk)
end

local function traceSpectrum(player, def, eventLevel, tag)
    if player == nil or def == nil then return end
    local level = def.perk and player:getPerkLevel(def.perk) or tonumber(eventLevel) or -1
    local band = TAS.Spectrum.getBandForLevel(def, level)
    local state = player:getModData().tasSpectra
    local saved = type(state) == "table" and state[def.id] or nil
    print("[CWModpackCompatibility][TASTrace] event=" .. tostring(tag)
        .. " player=" .. tostring(safeCall(player, "getUsername", "unknown"))
        .. " perk=" .. perkName(def.perk)
        .. " eventLevel=" .. tostring(eventLevel)
        .. " liveLevel=" .. tostring(level)
        .. " spectrum=" .. tostring(def.id)
        .. " dynamic=" .. tostring(def.dynamic == true)
        .. " expected=" .. traitNames(band and band.trait)
        .. " current=" .. currentTraits(player, def)
        .. " savedLevel=" .. tostring(type(saved) == "table" and saved.lastAppliedLevel or "none"))
end

local tasInstalled = false
local function installTASTrace()
    if tasInstalled or not active("traitsAsSkills") or TAS == nil or TAS.Spectrum == nil then return end
    tasInstalled = true
    Events.LevelPerk.Add(function(player, perk, level)
        for _, def in pairs(TAS.Spectrum.registry or {}) do
            if def.source == "skill" and def.perk == perk then
                traceSpectrum(player, def, level, "level_perk_after")
            end
        end
    end)
    local player = getPlayer and getPlayer() or nil
    if player ~= nil then
        for _, def in pairs(TAS.Spectrum.registry or {}) do
            if def.dynamic == true and def.source == "skill" then
                traceSpectrum(player, def, "n/a", "session_start")
            end
        end
    end
    print("[CWModpackCompatibility][TASTrace] Installed post-transition observations.")
end

local alifeInstalled = false
local unstickCounts = {}
local unstickTimes = {}
local function shellState(shell)
    local data = shell and shell.getModData and shell:getModData() or nil
    return {
        uid = type(data) == "table" and data.ProjectALifeUID or "unknown",
        phase = type(data) == "table" and data.ProjectALifeCombatPhase or "none",
        path = type(data) == "table" and data.ProjectALifePathActive or false,
        x = safeCall(shell, "getX", "unknown"),
        y = safeCall(shell, "getY", "unknown"),
        z = safeCall(shell, "getZ", "unknown"),
    }
end

local function installALifeTrace()
    if alifeInstalled or not active("ProjectALifeNPCs") or ProjectALife == nil then return end
    local installed = false
    local talk = ProjectALife.Talk
    if type(talk) == "table" and type(talk.choose) == "function" and not talk.__cwTrackerTrace then
        local originalChoose = talk.choose
        talk.choose = function(player, args)
            local ok, reason = originalChoose(player, args)
            print("[CWModpackCompatibility][ALifeTrace] talk_choose player="
                .. tostring(safeCall(player, "getUsername", "unknown"))
                .. " uid=" .. tostring(type(args) == "table" and args.uid or "nil")
                .. " choice=" .. tostring(type(args) == "table" and args.choice or "nil")
                .. " ok=" .. tostring(ok) .. " reason=" .. tostring(reason))
            return ok, reason
        end
        talk.__cwTrackerTrace = true
        installed = true
    end

    local combat = ProjectALife.Combat
    if type(combat) == "table" and type(combat.unstick) == "function" and not combat.__cwTrackerTrace then
        local originalUnstick = combat.unstick
        combat.unstick = function(shell, reason)
            local before = shellState(shell)
            local key = tostring(before.uid)
            local now = getTimestampMs and getTimestampMs() or 0
            unstickCounts[key] = (unstickCounts[key] or 0) + 1
            local elapsed = unstickTimes[key] and now - unstickTimes[key] or "first"
            unstickTimes[key] = now
            local result = originalUnstick(shell, reason)
            local after = shellState(shell)
            local count = unstickCounts[key]
            if count <= 12 or count % 10 == 0 then
                print("[CWModpackCompatibility][ALifeTrace] unstick uid=" .. key
                    .. " count=" .. tostring(count) .. " sincePreviousMs=" .. tostring(elapsed)
                    .. " reason=" .. tostring(reason)
                    .. " position=" .. tostring(before.x) .. "," .. tostring(before.y) .. "," .. tostring(before.z)
                    .. " beforePath=" .. tostring(before.path) .. " afterPath=" .. tostring(after.path)
                    .. " beforePhase=" .. tostring(before.phase) .. " afterPhase=" .. tostring(after.phase)
                    .. " result=" .. tostring(result))
            end
            return result
        end
        combat.__cwTrackerTrace = true
        installed = true
    end

    if installed then
        alifeInstalled = true
        print("[CWModpackCompatibility][ALifeTrace] Installed talk-result and unstick observations.")
    end
end

Events.OnGameStart.Add(function()
    installTASTrace()
    installALifeTrace()
end)

