-- Observe the client half of Project A-Life conversations without altering UI
-- state or command delivery.
local function active(id)
    local mods = getActivatedMods and getActivatedMods() or nil
    return mods and mods:contains(id)
end

local installed = false
local function install()
    if installed or not active("ProjectALifeNPCs") or ProjectALife == nil
            or type(ProjectALife.TalkMenu) ~= "table" then return end
    local menu = ProjectALife.TalkMenu
    if type(menu.open) == "function" and not menu.__cwTrackerTrace then
        local originalOpen = menu.open
        menu.open = function(playerNum, uid, shell, name, faction)
            print("[CWModpackCompatibility][ALifeTrace] talk_open player=" .. tostring(playerNum)
                .. " uid=" .. tostring(uid) .. " name=" .. tostring(name)
                .. " faction=" .. tostring(faction))
            return originalOpen(playerNum, uid, shell, name, faction)
        end
        menu.__cwTrackerTrace = true
    end
    if Events.OnServerCommand ~= nil then
        Events.OnServerCommand.Add(function(module, command, args)
            if module == "ProjectALife" and command == "talkResult" and type(args) == "table" then
                print("[CWModpackCompatibility][ALifeTrace] talk_result uid=" .. tostring(args.uid)
                    .. " ok=" .. tostring(args.ok) .. " reason=" .. tostring(args.reason)
                    .. " stance=" .. tostring(args.stance) .. " hasText=" .. tostring(args.text ~= nil))
            end
        end)
    end
    installed = true
    print("[CWModpackCompatibility][ALifeTrace] Installed client conversation observations.")
end

Events.OnGameStart.Add(install)

