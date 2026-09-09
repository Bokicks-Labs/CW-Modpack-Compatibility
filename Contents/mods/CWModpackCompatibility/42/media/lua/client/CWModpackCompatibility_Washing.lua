-- Small UI-only cleanup for the overlapping TABAS/Nature's Call wash menus.
-- Do not alter the underlying wash calculations or action callbacks.
local function removeZeroSoapLine(description)
    if type(description) ~= "string" then return description end
    description = description:gsub("[^<]*Soap[^<]*:%s*0%s*/%s*0%s*<LINE>%s*", "")
    description = description:gsub("[^<]*Needs soap[^<]*:%s*0%s*/%s*0%s*<LINE>%s*", "")
    return description
end

local function cleanWashTooltips(context)
    if not context or not context.options then return end
    for _, option in ipairs(context.options) do
        if option.toolTip and option.toolTip.description then
            option.toolTip.description = removeZeroSoapLine(option.toolTip.description)
        end
        if option.subOption then
            local submenu = context:getSubMenu(option.subOption)
            if submenu then cleanWashTooltips(submenu) end
        end
    end
end

if Events.OnFillWorldObjectContextMenu then
    Events.OnFillWorldObjectContextMenu.Add(function(player, context, worldObjects, test)
        if not test then cleanWashTooltips(context) end
    end)
end
