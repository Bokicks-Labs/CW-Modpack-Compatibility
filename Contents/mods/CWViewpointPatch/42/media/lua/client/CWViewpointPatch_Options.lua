local function install()
    if CWViewpointPatchOptions or not (PZAPI and PZAPI.ModOptions) then return end
    local page = PZAPI.ModOptions:create("CWViewpointPatch", "CW Viewpoint Patch")
    CWViewpointPatchOptions = page
    local width = page:addSlider("menuMaxWidth", "Maximum loot/interaction menu width", 360, 900, 20, 600,
        "Long Viewpoint menu labels can use more screen space. Restart the game after changing this setting.")
    local function apply()
        if CWViewpointSetMenuMaxWidth then
            CWViewpointSetMenuMaxWidth(math.floor(tonumber(width:getValue()) or 600))
        end
    end
    page.apply = apply
    Events.OnGameStart.Add(function()
        PZAPI.ModOptions:load()
        apply()
    end)
end

install()
Events.OnGameBoot.Add(install)
