-- Observations for tracker issues without changing moodle values or pathing.
local function active(id)
    local mods = getActivatedMods and getActivatedMods()
    return mods and mods:contains(id)
end

local function age()
    local time = getGameTime and getGameTime()
    return time and time:getWorldAgeHours() or "unknown"
end

local generalMoodles = {"Comfort", "Uncomfortable", "Embarrassed", "PartyGood", "PartyBad", "MusicGood", "MusicBad", "DJAudience", "MintFresh", "MintCurio", "BathHot", "BathCold", "Eureka", "Gloomy"}
local function moodleSnapshot()
    local player = getPlayer()
    local data = player and player:getModData()
    local moodles = data and data.LSMoodles
    local missing = {}
    for _, name in ipairs(generalMoodles) do
        local entry = type(moodles) == "table" and moodles[name]
        if type(entry) ~= "table" or type(entry.Value) ~= "number" then
            missing[#missing + 1] = name
        end
    end
    local entry = type(moodles) == "table" and moodles.Embarrassed
    return type(entry) == "table" and entry.Value or "missing", table.concat(missing, ",")
end

local function installLifestyle()
    if not active("LifestyleHobbies") or type(LSEveryMinute) ~= "function" then return end
    CWModpackCompatibility = CWModpackCompatibility or {}
    if CWModpackCompatibility.__cwMoodleTrace then return end
    local original = LSEveryMinute
    local count, previous, failures = 0, nil, 0
    local function observed(...)
        local before, missing = moodleSnapshot()
        count = count + 1
        local ok, result = pcall(original, ...)
        local after = moodleSnapshot()
        local positive = type(before) == "number" and before > 0
        if not ok then failures = failures + 1 end
        if count == 1 or (positive and (count % 5 == 0 or after == 0))
                or (previous ~= nil and before ~= previous)
                or (not ok and (failures == 1 or failures % 10 == 0)) then
            print("[CWModpackCompatibility][LifestyleTrace] minute=" .. tostring(count)
                .. " age=" .. tostring(age()) .. " before=" .. tostring(before)
                .. " after=" .. tostring(after) .. " previousAfter=" .. tostring(previous)
                .. " missing=" .. missing .. " callbackOK=" .. tostring(ok))
            if not ok then print("[CWModpackCompatibility][LifestyleTrace] error=" .. tostring(result)) end
        end
        previous = after
        if not ok then error(result, 0) end
        return result
    end
    Events.EveryOneMinute.Remove(original)
    LSEveryMinute = observed
    Events.EveryOneMinute.Add(observed)
    CWModpackCompatibility.__cwMoodleTrace = true
    local value, missing = moodleSnapshot()
    print("[CWModpackCompatibility][LifestyleTrace] Installed minute observations; age="
        .. tostring(age()) .. " embarrassment=" .. tostring(value) .. " missing=" .. missing)
end

local function installMotorcycle()
    if not active("amclub") or not ISPathFindAction or ISPathFindAction.__cwBikeTrace then return end
    local originalStart = ISPathFindAction.start
    local originalStop = ISPathFindAction.stop
    local originalPerform = ISPathFindAction.perform
    local originalUpdate = ISPathFindAction.update
    local function trace(self, event)
        local vehicle = self.__cwBikeVehicle
        if not vehicle then return end
        local char = self.character
        print("[CWModpackCompatibility][MotorcycleTrace] " .. event
            .. " script=" .. tostring(vehicle:getScriptName())
            .. " vehicle=" .. tostring(vehicle:getId())
            .. " goal=" .. tostring(self.goal[1]) .. " areaOrSeat=" .. tostring(self.goal[3])
            .. " player=" .. tostring(char:getX()) .. "," .. tostring(char:getY()) .. "," .. tostring(char:getZ())
            .. " bike=" .. tostring(vehicle:getX()) .. "," .. tostring(vehicle:getY())
            .. " age=" .. tostring(age()))
    end
    ISPathFindAction.start = function(self, ...)
        local goal = self.goal
        if goal and (goal[1] == "VehicleAdjacent" or goal[1] == "VehicleArea" or goal[1] == "VehicleSeat") then
            local vehicle = goal[2]
            if vehicle and vehicle:getPartById("AMCConfig") then
                self.__cwBikeVehicle = vehicle
                self.__cwBikeNextTrace = getTimestampMs() + 5000
                trace(self, "start")
            end
        end
        return originalStart(self, ...)
    end
    ISPathFindAction.update = function(self, ...)
        if self.__cwBikeVehicle and getTimestampMs() >= self.__cwBikeNextTrace then
            self.__cwBikeNextTrace = getTimestampMs() + 5000
            trace(self, "pending")
        end
        return originalUpdate(self, ...)
    end
    ISPathFindAction.stop = function(self, ...)
        trace(self, "stop")
        self.__cwBikeVehicle = nil
        return originalStop(self, ...)
    end
    ISPathFindAction.perform = function(self, ...)
        trace(self, "complete")
        self.__cwBikeVehicle = nil
        return originalPerform(self, ...)
    end
    ISPathFindAction.__cwBikeTrace = true
    print("[CWModpackCompatibility][MotorcycleTrace] Installed AMC path observations.")
end

Events.OnGameStart.Add(function()
    installLifestyle()
    installMotorcycle()
end)
