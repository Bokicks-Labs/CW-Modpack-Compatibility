-- Lifestyle stores its Build 42 yoga animations in the common layer. PZ 42.20
-- rejects those source paths, so CW supplies the same assets from its active 42
-- layer. This wrapper adds low-volume diagnostics and makes the otherwise hidden
-- timed-action progress visible while validating the asset-path repair.

local function isActive(modID)
    local activeMods = getActivatedMods and getActivatedMods() or nil
    return activeMods and activeMods:contains(modID)
end

local function log(message)
    print("[CWModpackCompatibility][LifestyleYoga] " .. tostring(message))
end

local function applyLifestyleYogaDiagnostics()
    if not isActive("LifestyleHobbies") then return end
    if not LSYogaAction then
        log("Lifestyle is active, but LSYogaAction was unavailable; diagnostics not installed.")
        return
    end
    if LSYogaAction.__cwYogaDiagnostics then return end

    local originalNew = LSYogaAction.new
    local originalWaitToStart = LSYogaAction.waitToStart
    local originalStart = LSYogaAction.start
    local originalStop = LSYogaAction.stop
    local originalPerform = LSYogaAction.perform

    LSYogaAction.new = function(self, character, skillLevel, args)
        local action = originalNew(self, character, skillLevel, args)
        local group = args and args[1] or "unknown"
        log("Yoga action queued (skill=" .. tostring(skillLevel) .. ", group=" .. tostring(group) .. ").")
        return action
    end

    LSYogaAction.waitToStart = function(self)
        local waiting = originalWaitToStart(self)
        if self.action and self.action.setUseProgressBar then
            self.action:setUseProgressBar(true)
        end
        log("Yoga action preparing (mat=" .. tostring(self.matObj ~= nil) .. ").")
        return waiting
    end

    LSYogaAction.start = function(self)
        originalStart(self)
        log("Yoga action started (animation=" .. tostring(self.animVars and self.animVars.anim) .. ").")
    end

    LSYogaAction.stop = function(self)
        log("Yoga action stopped (progress=" .. tostring(self.jobProgress) .. ").")
        return originalStop(self)
    end

    LSYogaAction.perform = function(self)
        log("Yoga action completed (poses=" .. tostring(self.poseCount) .. ").")
        return originalPerform(self)
    end

    LSYogaAction.__cwYogaDiagnostics = true
    log("Installed Yoga diagnostics and visible progress bar.")
end

Events.OnGameStart.Add(applyLifestyleYogaDiagnostics)

