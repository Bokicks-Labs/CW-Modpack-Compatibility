-- Senator's equipped fighting style is a virtual bare-hands weapon, not an item to throw.
-- Advanced Throwables' public exclusion applies on both client and server.
local mods = getActivatedMods and getActivatedMods()
if mods and mods:contains("SenatorMartialArtsCore") and mods:contains("ViewpointAdvancedThrowables") then
    local SMA = require "SMA_Core"
    require "SMA_Styles"
    require "VAT/VAT_API"
    if SMA and SMA.styles and SMA.styleOrder and ViewpointThrowables and ViewpointThrowables.excludeItem then
        local excluded = {}
        for _, id in ipairs(SMA.styleOrder) do
            local style = SMA.styles[id]
            local fullType = style and style.weaponType
            if type(fullType) == "string" and not excluded[fullType] then
                ViewpointThrowables.excludeItem(fullType)
                excluded[fullType] = true
            end
        end
        local count = 0
        for _ in pairs(excluded) do count = count + 1 end
        print("[CWModpackCompatibility][MartialArtsThrowables] Excluded " .. tostring(count) .. " fighting-style proxy item types from throws.")
    end
end
