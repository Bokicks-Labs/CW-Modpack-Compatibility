-- Compatibility shim for DAMN's semi-attachment registration API.
--
-- KI5MiniFixes overrides DAMN's helper file on Build 42, but its replacement
-- does not recreate DAMN.SemiAttachmentHelper.  Vehicle mods such as 82
-- Oshkosh M911 still call registerVehicleScript while their client file loads.
-- Keep this implementation self-contained so the override remains safe even
-- when the original DAMN helper is not available through require().

require "Vehicles/ISVehicleTrailerUtils";

DAMN = DAMN or {};
DAMN.SemiAttachmentHelper = DAMN.SemiAttachmentHelper or {};
local helper = DAMN.SemiAttachmentHelper;

helper.byScriptName = helper.byScriptName or {};

local function contains(array, value)
    if DAMN.itemIsInArray then
        return DAMN:itemIsInArray(array, value);
    end

    for _, item in ipairs(array or {}) do
        if item == value then return true end
    end
    return false;
end

local function isEmpty(array)
    if DAMN.arrayIsEmpty then
        return DAMN:arrayIsEmpty(array);
    end
    return not array or next(array) == nil;
end

function helper:registerVehicleScript(semiVehicleScriptName, allowedTrailersVehicleScriptNames)
    local allowed = self.byScriptName[semiVehicleScriptName]
    if not allowed then
        allowed = {}
        self.byScriptName[semiVehicleScriptName] = allowed
    end

    for _, trailerScriptName in ipairs(allowedTrailersVehicleScriptNames or {}) do
        if not contains(allowed, trailerScriptName) then
            table.insert(allowed, trailerScriptName)
        end
    end
end

function helper:vehicleIsRegistered(vehicle)
    if not vehicle or not vehicle.getScript then return false end
    local script = vehicle:getScript()
    return script and self.byScriptName[script:getFullName()] or false
end

function helper:trailerIsAllowed(semiVehicle, trailerVehicle)
    if not semiVehicle or not trailerVehicle then return false end
    local semiScript = semiVehicle:getScript():getFullName()
    local allowed = self.byScriptName[semiScript]
    if isEmpty(allowed) then return true end
    return contains(allowed, trailerVehicle:getScript():getFullName())
end

if ISVehicleTrailerUtils and ISVehicleTrailerUtils.getTowableVehicleNear
    and not helper.__cwTowableVehicleHook then
    local originalGetTowableVehicleNear = ISVehicleTrailerUtils.getTowableVehicleNear

    ISVehicleTrailerUtils.getTowableVehicleNear = function(square, ignoreVehicle, attachmentA, attachmentB)
        if helper:vehicleIsRegistered(ignoreVehicle) then
            local vehicles = square:getCell():getVehicles():toArray()
            for i = 1, #vehicles do
                local vehicle = vehicles[i]
                if vehicle and vehicle ~= ignoreVehicle
                    and helper:trailerIsAllowed(ignoreVehicle, vehicle)
                    and ignoreVehicle:canAttachTrailer(vehicle, attachmentA, attachmentB) then
                    return vehicle
                end
            end
            return nil
        end

        return originalGetTowableVehicleNear(square, ignoreVehicle, attachmentA, attachmentB)
    end

    helper.__cwTowableVehicleHook = true
end
