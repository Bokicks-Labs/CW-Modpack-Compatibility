-- Dedicated servers do not pass through Week One's variant-selection UI.
-- Repair missing or stale variant keys before clients consume scenario state.

local function isWeekOneActive()
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains("BanditsWeekOne")
end

local function resolveWeekOneVariant(value)
    if not BWOVariants then return nil end
    if value ~= nil and BWOVariants[value] then return value end

    local numeric = tonumber(value)
    if numeric and BWOVariants[numeric] then return numeric end

    local requested = value and string.lower(tostring(value)) or "original"
    local fallback = nil
    for id, variant in pairs(BWOVariants) do
        if type(variant) == "table" then
            fallback = fallback or id
            local name = variant.name and string.lower(tostring(variant.name)) or ""
            if name == requested or (requested == "original" and name == "original") then
                return id
            end
        end
    end
    return fallback
end

local function ensureWeekOneVariant()
    if not isWeekOneActive() or not GetBWOModData then return end

    local gmd = GetBWOModData()
    if type(gmd) ~= "table" then return end

    local previous = gmd.Variant
    local resolved = resolveWeekOneVariant(previous)
    if resolved == nil or (previous == resolved and BWOVariants[previous]) then return end

    gmd.Variant = resolved
    if TransmitBWOModData then TransmitBWOModData() end
    print("[CWModpackCompatibility][WeekOne] Repaired server variant "
        .. tostring(previous) .. " -> " .. tostring(resolved) .. ".")
end

ensureWeekOneVariant()
if Events and Events.OnInitGlobalModData then
    Events.OnInitGlobalModData.Add(ensureWeekOneVariant)
end
if Events and Events.OnServerStarted then
    Events.OnServerStarted.Add(ensureWeekOneVariant)
end
