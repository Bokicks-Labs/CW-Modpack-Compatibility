-- Preserve Viewpoint's native menu, then focus A-Life person actions on its aimed shell.
local installed = false
local lastFailure = {}

local function alifeUid(object)
    if (type(object) ~= "table" and type(object) ~= "userdata")
            or type(object.getModData) ~= "function" then return nil end
    local data = object:getModData()
    if not data or data.ProjectALifeOwned ~= true then return nil end
    local uid = data.ProjectALifeUID
    return type(uid) == "string" and uid ~= "" and uid or nil
end

local function otherNpc(action, aimed)
    for i = 1, action.n or 0 do
        local value = action.args and action.args[i]
        if value ~= aimed and alifeUid(value) then return true end
    end
    return false
end

local function addAction(actions, name, fn, player, npc)
    for _, action in ipairs(actions) do
        if action.name == name then return end
    end
    actions[#actions + 1] = {
        name = name, fn = fn, args = { player, npc }, n = 2, enabled = true,
    }
end

local function focusHarvest(original, player, object)
    local uid = alifeUid(object)
    if not uid then return original(player, object) end

    -- Jimmy's resident provider selects the first nearby crew. Restrict its
    -- synchronous scan while Viewpoint asks the game to build the native menu.
    local residents = ProjectALifeJimmy and ProjectALifeJimmy.ResidentsMenu
    local near = residents and residents.npcsNear
    if type(near) == "function" then
        residents.npcsNear = function(square)
            local selected = {}
            for _, npc in ipairs(near(square)) do
                if npc.uid == uid then selected[#selected + 1] = npc end
            end
            return selected
        end
    end
    local ok, result = pcall(original, player, object)
    if type(near) == "function" then residents.npcsNear = near end
    if not ok then error(result, 0) end
    if type(result) ~= "table" or result.why then return result end

    local actions = ViewpointInteract.actions or {}
    for i = #actions, 1, -1 do
        if otherNpc(actions[i], object) then table.remove(actions, i) end
    end

    local J = ProjectALifeJimmy
    local actors = ProjectALife and ProjectALife.ActorRegistry
    local record = actors and type(actors.read) == "function" and actors.read(uid) or nil
    if J and type(record) == "table" then
        local name = J.nameOf(record, J.t("IGUI_ALJ_Common_Someone"))
        local npc = { uid = uid, name = name, record = record, shell = object }
        local gifts = J.GiftWindow
        if gifts and type(gifts.open) == "function" and J.enabled("hand_gifts")
                and record.lifecycle == "active" then
            local relations = ProjectALife.Relations
            local stanceOk, stance = true, nil
            if relations and type(relations.playerStance) == "function" then
                stanceOk, stance = pcall(relations.playerStance, record, player)
            end
            if not (stanceOk and stance == "hostile") then
                local key = gifts.isTrader(record) and "ContextMenu_ALJ_Trade_OpenTrader" or "ContextMenu_ALJ_Trade_Open"
                gifts.named(npc, player)
                addAction(actions, J.t(key, npc.name), gifts.open, player, npc)
            end
        end

        local injuries = J.Injuries
        local medical = injuries and injuries.medical
        local treat = injuries and injuries.treat
        if medical and type(medical.open) == "function" and treat and type(treat.allowed) == "function"
                and (injuries.core() or medical.alife14()) and treat.allowed(record, player) then
            local patient = { uid = uid, name = J.shownName(record, player, name), record = record, shell = object }
            addAction(actions, J.t("ContextMenu_ALJ_Medical_Check", patient.name), medical.open, player, patient)
        end

        local bases, residentsState = J.BaseAreas, J.Residents
        if J.Menu and J.Menu.shown() and J.enabled("residents") and bases and residentsState
                and not residentsState.residentOf(record) then
            local who = bases.who(player)
            local shown = J.shownName(record, player, J.t("IGUI_ALJ_Residents_Them"))
            local invite = J.t("ContextMenu_ALJ_Residents_InviteCrew", shown)
            for _, base in ipairs(bases.basesFor(who.key, who.faction, false)) do
                local baseId = base.id
                addAction(actions, invite .. ": " .. base.name, function(p, target)
                    J.Menu.run(p, "recruit", { uid = target.uid, baseId = baseId })
                end, player, npc)
            end
        end
    end

    result.labels, result.enabled = {}, {}
    for i, action in ipairs(actions) do
        result.labels[i], result.enabled[i] = action.name, action.enabled
    end
    return result
end

local function describe(result)
    if type(result) ~= "table" then return "invalid result: " .. type(result) end
    if result.why then return tostring(result.why) end
    if type(result.labels) == "table" and #result.labels == 0 then
        return "no actions; seen=" .. tostring(result.seen)
    end
    return nil
end

local function wrap(name)
    local original = ViewpointInteract and ViewpointInteract[name]
    if type(original) ~= "function" then return false end
    ViewpointInteract[name] = function(...)
        local ok, result
        if name == "harvest" then
            ok, result = pcall(focusHarvest, original, ...)
        else
            ok, result = pcall(original, ...)
        end
        local failure
        if ok then
            failure = describe(result)
        else
            failure = "error: " .. tostring(result)
        end
        if failure ~= lastFailure[name] then
            if failure then print("[CWViewpointPatch] " .. name .. ": " .. failure) end
            lastFailure[name] = failure
        end
        if not ok then error(result, 0) end
        return result
    end
    return true
end

local function install()
    if installed then return end
    if not ViewpointInteract then return end
    local world = wrap("harvest")
    local vehicle = wrap("harvestVehicle")
    installed = world and vehicle
    if installed then print("[CWViewpointPatch] interaction diagnostics active") end
end

Events.OnGameStart.Add(install)
